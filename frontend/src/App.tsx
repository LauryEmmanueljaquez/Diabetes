import { useState } from 'react'
import './index.css'

interface Prediction {
  prediction: number;
}

function App() {
  const [formData, setFormData] = useState({
    age: 50,
    sex: 1, // 1: Masculino, 2: Femenino
    bmi: 25,
    bp: 80,
    s1: 180,
    s2: 100,
    s3: 50,
    s4: 4,
    s5: 4.5,
    s6: 90
  });

  const [result, setResult] = useState<number | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: parseFloat(e.target.value)
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('http://localhost:8000/predict', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        throw new Error('La respuesta de la red no fue correcta');
      }

      const data: Prediction = await response.json();
      setResult(data.prediction);
    } catch (err) {
      setError('No se conectó con el modelo de IA. Asegúrate de que el backend esté funcionando.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="animate-fade-in">
      <h1 className="header-title">Diamond Diabetes IA</h1>
      <p className="subtitle">
        Predicción avanzada de progresión basada en análisis de regresión de variables clínicas.
      </p>

      <div className="card">
        <form onSubmit={handleSubmit}>
          <div className="grid-cols-2">
            <div className="input-group">
              <label>Edad</label>
              <input
                type="number"
                name="age"
                value={formData.age}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>Sexo</label>
              <select name="sex" value={formData.sex} onChange={handleChange}>
                <option value={1}>Masculino</option>
                <option value={2}>Femenino</option>
              </select>
            </div>

            <div className="input-group">
              <label>IMC (Índice de Masa Corporal)</label>
              <input
                type="number"
                name="bmi"
                step="0.1"
                value={formData.bmi}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>PA (Presión Arterial)</label>
              <input
                type="number"
                name="bp"
                value={formData.bp}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>Colesterol Total (S1)</label>
              <input
                type="number"
                name="s1"
                value={formData.s1}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>LDL (S2)</label>
              <input
                type="number"
                name="s2"
                value={formData.s2}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>HDL (S3)</label>
              <input
                type="number"
                name="s3"
                value={formData.s3}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>Ratio Total/HDL (S4)</label>
              <input
                type="number"
                name="s4"
                step="0.01"
                value={formData.s4}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>Log Triglicéridos (S5)</label>
              <input
                type="number"
                name="s5"
                step="0.0001"
                value={formData.s5}
                onChange={handleChange}
                required
              />
            </div>

            <div className="input-group">
              <label>Azúcar en Sangre (S6)</label>
              <input
                type="number"
                name="s6"
                value={formData.s6}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          <button type="submit" className="btn-primary" disabled={loading}>
            {loading ? 'Analizando...' : 'Predecir Progresión'}
          </button>
        </form>

        {error && (
          <div style={{ color: 'var(--error)', marginTop: '1rem', textAlign: 'center' }}>
            {error}
          </div>
        )}

        {result !== null && (
          <div className="result-box animate-fade-in">
            <div>Progresión Predicha de la Enfermedad</div>
            <div className="metric-value">{result.toFixed(2)}</div>
            <div style={{ fontSize: '0.9rem', opacity: 0.8 }}>Un año después de la línea base</div>
          </div>
        )}
      </div>
    </div>
  )
}

export default App

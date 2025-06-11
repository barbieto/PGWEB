document.getElementById('attendanceForm').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const name = document.getElementById('name').value;
    const date = document.getElementById('date').value;

    if (name && date) {
        const table = document.getElementById('attendanceTable').getElementsByTagName('tbody')[0];
        
        const newRow = table.insertRow();
        newRow.innerHTML = `<td>${name}</td><td>${date}</td>`;
        
        // Limpiar el formulario
        document.getElementById('attendanceForm').reset();
    } else {
        alert("Por favor, complete todos los campos.");
    }
});

// Función para generar el PDF
document.getElementById('downloadPDF').addEventListener('click', function() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    doc.setFont("Arial", "normal");
    doc.text("Listado de Asistencias", 14, 20);

    const table = document.getElementById('attendanceTable');
    let y = 30; // Posición vertical inicial

    // Agregar encabezados de tabla
    doc.text("Nombre", 14, y);
    doc.text("Fecha", 120, y);
    y += 10; // Espacio entre encabezado y contenido

    // Agregar las filas de la tabla al PDF
    for (let i = 0; i < table.rows.length; i++) {
        let row = table.rows[i];
        let name = row.cells[0].textContent;
        let date = row.cells[1].textContent;
        doc.text(name, 14, y);
        doc.text(date, 120, y);
        y += 10;
    }

    // Descargar el PDF
    doc.save("asistencias.pdf");
});


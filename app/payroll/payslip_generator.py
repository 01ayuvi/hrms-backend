from reportlab.platypus import (
    SimpleDocTemplate,
    Paragraph,
    Spacer
)

from reportlab.lib.styles import getSampleStyleSheet


def generate_payslip(
    filename,
    payroll
):
    pdf = SimpleDocTemplate(filename)

    styles = getSampleStyleSheet()

    elements = []

    elements.append(
        Paragraph(
            "HRMS PAYSLIP",
            styles["Title"]
        )
    )

    elements.append(Spacer(1, 20))

    elements.append(
        Paragraph(
            f"Employee ID: {payroll.employee_id}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"Basic Salary: {payroll.basic_salary}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"HRA: {payroll.hra}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"Gross Salary: {payroll.gross_salary}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"PF Deduction: {payroll.pf_deduction}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"ESIC Deduction: {payroll.esic_deduction}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"Professional Tax: {payroll.professional_tax}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"TDS: {payroll.tds}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"LWP Deduction: {payroll.lwp_deduction}",
            styles["Normal"]
        )
    )

    elements.append(
        Paragraph(
            f"Net Salary: {payroll.net_salary}",
            styles["Normal"]
        )
    )

    pdf.build(elements)
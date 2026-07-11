from reportlab.platypus import (
    SimpleDocTemplate,
    Table,
    TableStyle,
    Paragraph,
    Spacer
)

from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.units import inch


def money(value):
    return f"Rs. {float(value):,.2f}"


def generate_payslip(
    filename,
    payroll,
    employee,
    payroll_run,
    department
):

    pdf = SimpleDocTemplate(
        filename,
        rightMargin=30,
        leftMargin=30,
        topMargin=30,
        bottomMargin=30
    )

    styles = getSampleStyleSheet()

    title_style = styles["Title"]
    title_style.alignment = TA_CENTER
    title_style.textColor = colors.HexColor("#1E3A8A")

    heading = styles["Heading2"]
    heading.alignment = TA_CENTER

    normal = styles["Normal"]

    elements = []

    # =====================================================
    # COMPANY HEADER
    # =====================================================

    elements.append(
        Paragraph(
            "<font size='22'><b>ENTERPRISE HRMS</b></font>",
            title_style
        )
    )

    elements.append(
        Paragraph(
            "<font size='13'><b>Company Name</b></font>",
            heading
        )
    )

    elements.append(Spacer(1, 8))

    elements.append(
        Paragraph(
            "<font size='18'><b>SALARY SLIP</b></font>",
            heading
        )
    )

    elements.append(Spacer(1, 18))


    # =====================================================
    # EMPLOYEE + PAYROLL INFORMATION
    # =====================================================

    info_data = [

        [
            Paragraph("<b>Employee Information</b>", styles["BodyText"]),
            Paragraph("<b>Payroll Information</b>", styles["BodyText"])
        ],

        [
            f"Employee Name : {employee.first_name} {employee.last_name}",
            f"Pay Period : {payroll_run.pay_period}"
        ],

        [
            f"Employee ID : {employee.employee_id}",
            f"Payroll Run : {payroll.payroll_run_id}"
        ],

        [
            f"Department : {department.department_name if department else 'N/A'}",
            f"Generated On : {payroll.created_at.strftime('%d-%m-%Y')}"
        ],
        [
            f"Designation : {employee.designation or 'N/A'}"
        ]

    ]

    info_table = Table(
        info_data,
        colWidths=[250, 250]
    )

    info_table.setStyle(

        TableStyle([

            ("BACKGROUND", (0,0), (-1,0), colors.lightgrey),

            ("GRID", (0,0), (-1,-1), 0.6, colors.black),

            ("FONTNAME", (0,0), (-1,0), "Helvetica-Bold"),

            ("BOTTOMPADDING", (0,0), (-1,0), 8),

            ("TOPPADDING", (0,1), (-1,-1), 7),

            ("BOTTOMPADDING", (0,1), (-1,-1), 7),

            ("VALIGN", (0,0), (-1,-1), "MIDDLE")

        ])

    )

    elements.append(info_table)

    elements.append(Spacer(1,20))

    # =====================================================
    # SALARY DETAILS
    # =====================================================

    elements.append(
        Paragraph(
            "<font size='14'><b>Salary Details</b></font>",
            heading
        )
    )

    elements.append(Spacer(1,10))

    salary_data = [

        [
            Paragraph("<b>Earnings</b>", styles["BodyText"]),
            Paragraph("<b>Amount</b>", styles["BodyText"]),
            Paragraph("<b>Deductions</b>", styles["BodyText"]),
            Paragraph("<b>Amount</b>", styles["BodyText"])
        ],

        [
            "Basic Salary",
            money(payroll.basic_salary),
            "Provident Fund",
            money(payroll.pf_deduction)
        ],

        [
            "House Rent Allowance",
            money(payroll.hra),
            "ESIC",
            money(payroll.esic_deduction)
        ],

        [
            "Allowances",
            money(payroll.allowances),
            "Professional Tax",
            money(payroll.professional_tax)
        ],

        [
            "",
            "",
            "TDS",
            money(payroll.tds)
        ],

        [
            "",
            "",
            "Leave Without Pay",
            money(payroll.lwp_deduction)
        ],

        [
            Paragraph("<b>Gross Salary</b>", styles["BodyText"]),
            Paragraph(f"<b>{money(payroll.gross_salary)}</b>", styles["BodyText"]),
            Paragraph("<b>Total Deductions</b>", styles["BodyText"]),
            Paragraph(f"<b>{money(payroll.deductions)}</b>", styles["BodyText"])
        ]

    ]

    salary_table = Table(
        salary_data,
        colWidths=[170, 90, 170, 90]
    )

    salary_table.setStyle(

        TableStyle([

            ("GRID",(0,0),(-1,-1),0.6,colors.black),

            ("BACKGROUND",(0,0),(-1,0),colors.lightgrey),

            ("FONTNAME",(0,0),(-1,0),"Helvetica-Bold"),

            ("BOTTOMPADDING",(0,0),(-1,0),8),

            ("TOPPADDING",(0,1),(-1,-1),7),

            ("BOTTOMPADDING",(0,1),(-1,-1),7),

            ("ALIGN",(1,1),(1,-1),"RIGHT"),

            ("ALIGN",(3,1),(3,-1),"RIGHT"),

            ("BACKGROUND",(0,-1),(-1,-1),colors.whitesmoke),

            ("FONTNAME",(0,-1),(-1,-1),"Helvetica-Bold")

        ])

    )

    elements.append(salary_table)

    elements.append(Spacer(1,20))

    # =====================================================
    # NET SALARY
    # =====================================================

    net_salary_table = Table(
        [
            [
            Paragraph("<b>NET SALARY</b>", styles["Heading2"]),
            Paragraph(f"<b>{money(payroll.net_salary)}</b>", styles["Heading2"])
        ]
        ],
        colWidths=[260, 260]
    )

    net_salary_table.setStyle(
        TableStyle([

            ("BACKGROUND", (0,0), (-1,-1), colors.HexColor("#E8F4FD")),

            ("TEXTCOLOR", (0,0), (-1,-1), colors.black),

            ("GRID", (0,0), (-1,-1), 1, colors.black),

            ("FONTNAME", (0,0), (-1,-1), "Helvetica-Bold"),

            ("FONTSIZE", (0,0), (0,0), 16),

            ("FONTSIZE", (1,0), (1,0), 18),

            ("TOPPADDING", (0,0), (-1,-1), 12),

            ("BOTTOMPADDING", (0,0), (-1,-1), 12),

            ("ALIGN", (1,0), (1,0), "RIGHT"),

            ("LEFTPADDING", (0,0), (-1,-1), 15),

            ("RIGHTPADDING", (0,0), (-1,-1), 15)

        ])
    )

    elements.append(net_salary_table)

    elements.append(Spacer(1, 30))


    # =====================================================
    # FOOTER
    # =====================================================

    elements.append(
        Paragraph(
            "<font size='9'><i>This is a computer-generated payslip. No signature is required.</i></font>",
            normal
        )
    )

    elements.append(Spacer(1, 35))


    # =====================================================
    # SIGNATURES
    # =====================================================

    signature_table = Table(
        [
            [
                "__________________________",
                "__________________________"
            ],
            [
                "Employee Signature",
                "Authorized Signatory"
            ]
        ],
        colWidths=[260,260]
    )

    signature_table.setStyle(
        TableStyle([

            ("ALIGN",(0,0),(-1,-1),"CENTER"),

            ("TOPPADDING",(0,0),(-1,-1),10),

            ("BOTTOMPADDING",(0,0),(-1,-1),5)

        ])
    )

    elements.append(signature_table)


    # =====================================================
    # BUILD PDF
    # =====================================================

    pdf.build(elements)

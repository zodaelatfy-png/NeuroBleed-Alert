from fastapi import APIRouter, Depends
from app.application.ai_service import ai_service, RiskAnalysisRequest, RiskAnalysisResponse
# from app.presentation.api.v1.auth import get_current_user # To be implemented for security

router = APIRouter()

@router.post("/analyze-risk", response_model=RiskAnalysisResponse)
async def analyze_patient_risk(request: RiskAnalysisRequest):
    """
    Endpoint for Doctors/System to evaluate patient risk of brain bleed.
    Protected by RBAC (Role-Based Access Control) in production.
    """
    result = await ai_service.analyze_neuro_risk(request)
    return result

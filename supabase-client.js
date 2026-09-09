// Connexion à Supabase — utilisé par toutes les pages du site
const SUPABASE_URL = "https://ulxiiotnabyzwokfnngs.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_QL608HTKR-hEtFPG-Tl5_Q_16e2FF-Y";

const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

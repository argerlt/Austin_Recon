function options_struct = load_options(preset)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
options_struct = load_default_options();
if ~exist('preset','var')
else
    preset = string(preset);
    if preset == "default"
    elseif preset == "debug"
        options_struct = steel_debug_opt(options_struct);
    elseif preset == "test"
        options_struct = steel_test_opt(options_struct);
    end
end
end

function options_struct = steel_debug_opt(options_struct)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
options_struct.OR_plot_mart = 1;
options_struct.OR_plot_vars = 1;
options_struct.OR_plot_ksi_spread = 1;
end

function options_struct = steel_test_opt(options_struct)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
options_struct.calc_grain_metrics = 0;
options_struct.variant_segmentation = 0;
options_struct.calc_variant_metrics = 0;
options_struct.plot_packets = 0;
options_struct.plot_blocks = 0;
options_struct.plot_variants = 0;
options_struct.output_text_file = 0;
end

function options_struct = load_default_options()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
options_struct = struct(...
... ### Material System (determines parent/child relationship)
    'material', 'Steel', ...
    'specimen_symmetry', 'triclinic', ...
... ### High Temperature Phase (Phase 1, Austenite in Steel) ###
... This is the phase ID assigned to Untransformed or "retained" areas 
    'High_Temp_phase_name', 'Austenite', ...
    'High_Temp_phase_color', str2rgb('LightGreen'), ...
    'High_Temp_phase_symm', 'm-3m', ...
    'High_Temp_lattice_parameters',[3.65, 3.65, 3.65], ...
... ### Low Temperature Phase (Phase 2, Martensite in Steel) ###
... This is the assigned to the transformed phase in the original EBSD. It 
... is the portion that will be reconstructed by this code, and is normally
... the bulk of the EBSD scan.
    'Low_Temp_phase_name', 'Martensite', ...
    'Low_Temp_phase_color', str2rgb('DarkRed'), ...
    'Low_Temp_phase_symm', 'm-3m', ...
    'Low_Temp_lattice_parameters',[2.87, 2.87, 2.87], ...
... ### Reconstructed phase (Phase 3, Identical CS to Phase 1) ###
... The calculated orientations of the original HT grain structure.
... Purely calculated, not in original EBSD.
    'Reconstructed_phase_name', 'Reconstructed Austenite', ...
    'Reconstructed_phase_color', str2rgb('DarkBlue'), ...
... ### Ideal Variant orientation (Phase 4, Identical CS to Phase 2) ###
... The calculated ideal orientations of the variants prior to deformation.
    'Variant_phase_name', 'Reconstructed Variants', ...
    'Variant_phase_color', str2rgb('Violet'), ...
... ### Orientation Relationship (OR) Information ###
... allows users to manually set the OR. leave bank to auto-calculate
    'OR_ksi', [0, 0, 0], ...
    'OR_noise', 0, ...
    'OR_sampling_size', 1000, ...
    'OR_fit_TolFun',3e-3,...
    'OR_fit_TolX',3e-3,...
... AutoOR plotting information
    'OR_plot_PAG_Mart_Guess', 0, ...
    'OR_plot_ODF_of_PAG_OR_guess', 0, ...
    'OR_plot_ksi_spread', 0, ...
... Reconstruction Graph Cut Parameters TODO: comment these better, rename, maybe reparameterize?
    'RGC_in_plane_m', 3, ...
    'RGC_in_plane_b', 12, ...
    'RGC_post_pre_m', 0.175, ...
    'RGC_post_pre_b', 0.35, ...
    'degree_of_connections_for_neighborhood', 1, ...
    'min_cut_size',5,...
    'max_recon_attempts',500,...
... Segmentation Parameters
    'Seg_IP_m', 25, ...
    'Seg_IP_b', 0, ...
    'Seg_OP_m', 1, ...
    'Seg_OP_b', 0, ...
    'Seg_Denoise',false,...
... Post Recon options
    'calc_grain_metrics', 1, ...
    'variant_segmentation', 1, ...
    'calc_variant_metrics', 1, ...
    'plot_packets', 1, ...
    'plot_blocks', 1, ...
    'plot_variants', 1, ...
    'output_text_file', 1);
end
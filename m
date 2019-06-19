Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB64BA1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfFSNie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 09:38:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfFSNie (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 09:38:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6513AEC7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 13:38:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44020DA88C; Wed, 19 Jun 2019 15:39:20 +0200 (CEST)
Date:   Wed, 19 Jun 2019 15:39:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.de>
Cc:     David Sterba <DSterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reorder struct btrfs_key for better alignment
Message-ID: <20190619133919.GF8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.de>,
        David Sterba <DSterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20190618141514.17322-1-dsterba@suse.com>
 <6ba5daa9-735b-1cdd-fdd7-9c1a60277d46@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba5daa9-735b-1cdd-fdd7-9c1a60277d46@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 09:37:39AM +0800, Qu Wenruo wrote:
> >  struct btrfs_key {
> >  	__u64 objectid;
> > -	__u8 type;
> >  	__u64 offset;
> > +	__u8 type;
> >  } __attribute__ ((__packed__));
> 
> And why not remove the packed attribute?

Because of this (stack usage changes):

do_relocation                                                      +8 (304 -> 312)
btrfs_orphan_cleanup                                              +16 (128 -> 144)
btrfs_init_new_device                                             -16 (288 -> 272)
get_subvol_name_from_objectid                                      +8 (136 -> 144)
log_conflicting_inodes                                             +8 (184 -> 192)
btrfs_read_chunk_tree                                             +16 (128 -> 144)
btrfs_recover_relocation                                           +8 (136 -> 144)
scrub_stripe                                                      +16 (536 -> 552)
btrfs_clone                                                       +16 (352 -> 368)
free_space_next_bitmap                                             +8 (80 -> 88)
btrfs_find_orphan_roots                                           +16 (112 -> 128)
find_free_dev_extent_start                                         +8 (160 -> 168)
btrfs_lookup_extent_info                                           +8 (160 -> 168)
btrfs_find_item                                                    +8 (80 -> 88)
btrfs_create_pending_block_groups                                  +8 (120 -> 128)
btrfs_read_block_groups                                           -24 (176 -> 152)
__remove_from_free_space_tree                                      +8 (120 -> 128)
check_committed_ref                                                +8 (104 -> 112)
replay_one_buffer                                                  +8 (152 -> 160)
fixup_inode_link_counts                                            +8 (96 -> 104)
btrfs_del_csums                                                    +8 (192 -> 200)
btrfs_search_path_in_tree_user                                    +16 (192 -> 208)
btrfs_lookup_dentry                                                +8 (168 -> 176)
__add_tree_block                                                   +8 (120 -> 128)
__btrfs_balance                                                    +8 (264 -> 272)
__lookup_free_space_inode                                         +16 (112 -> 128)
__readahead_hook                                                  +16 (168 -> 184)
btrfs_get_parent                                                   +8 (96 -> 104)
btrfs_run_dev_replace                                              +8 (88 -> 96)
add_qgroup_item                                                    +8 (80 -> 88)
merge_reloc_root                                                  +16 (240 -> 256)
link_to_fixup_dir                                                  +8 (80 -> 88)
btrfs_insert_orphan_item                                           +8 (64 -> 72)
btrfs_delete_delayed_items                                         +8 (184 -> 192)
btrfs_read_qgroup_config                                           +8 (136 -> 144)
is_extent_unchanged                                                +8 (152 -> 160)
btrfs_recover_log_trees                                           +24 (192 -> 216)
btrfs_create_free_space_tree                                       +8 (136 -> 144)
send_subvol                                                        +8 (136 -> 144)
btrfs_compare_trees                                               +24 (176 -> 200)
get_first_ref                                                      +8 (136 -> 144)
qgroup_trace_new_subtree_blocks                                    +8 (176 -> 184)
qgroup_trace_extent_swap                                          +16 (192 -> 208)
generic_bin_search                                                 +8 (160 -> 168)
replay_one_name                                                    +8 (152 -> 160)
btrfs_print_tree                                                   +8 (160 -> 168)
__create_free_space_inode                                          +8 (112 -> 120)
copy_items                                                        +24 (328 -> 352)
walk_down_reloc_tree                                               +8 (160 -> 168)
btrfs_find_next_key                                                +8 (184 -> 192)
btrfs_del_inode_ref                                                +8 (144 -> 152)
btrfs_check_node                                                  +16 (144 -> 160)
find_next_devid                                                    +8 (88 -> 96)
btrfs_new_inode                                                    +8 (184 -> 192)
__add_to_free_space_tree                                          +16 (136 -> 152)
__btrfs_run_delayed_refs                                           +8 (168 -> 176)
btrfs_qgroup_trace_subtree                                         +8 (224 -> 232)
btrfs_lookup_csums_range                                           +8 (184 -> 192)
__btrfs_update_delayed_inode                                       +8 (112 -> 120)
lookup_inline_extent_backref                                       +8 (184 -> 192)
find_data_references                                               +8 (152 -> 160)
replay_dir_deletes                                                +16 (168 -> 184)
check_leaf                                                         +8 (168 -> 176)
btrfs_ioctl_get_subvol_info                                       +16 (128 -> 144)
btrfs_insert_inode_ref                                             +8 (152 -> 160)
btrfs_finish_sprout                                                +8 (152 -> 160)
build_backref_tree                                                 +8 (272 -> 280)
insert_extent_data_ref                                             +8 (96 -> 104)
send_clone                                                        -24 (160 -> 136)
insert_tree_block_ref                                              +8 (56 -> 64)
read_node_slot                                                     +8 (88 -> 96)
btrfs_csum_file_blocks                                             +8 (168 -> 176)
replace_path                                                      +16 (352 -> 368)
changed_inode                                                     +16 (144 -> 160)
process_all_refs                                                  +16 (112 -> 128)
btrfs_find_root                                                   +16 (144 -> 160)
reada_walk_down                                                    +8 (176 -> 184)
btrfs_insert_xattr_item                                            +8 (136 -> 144)
maybe_send_hole                                                    +8 (152 -> 160)
btrfs_uuid_scan_kthread                                            +8 (520 -> 528)
modify_free_space_bitmap                                           +8 (192 -> 200)
lookup_extent_data_ref                                             +8 (144 -> 152)
btrfs_run_delayed_refs_for_head                                    +8 (208 -> 216)
btrfs_search_dir_index_item                                        +8 (112 -> 120)
btrfs_prev_leaf                                                   +16 (88 -> 104)
may_destroy_subvol                                                 +8 (88 -> 96)
convert_free_space_to_extents                                      +8 (176 -> 184)
btrfs_quota_enable                                                 +8 (128 -> 136)
remove_block_group_free_space                                      +8 (120 -> 128)
__btrfs_drop_extents                                              +24 (352 -> 376)
btrfs_finish_chunk_alloc                                          +16 (192 -> 208)
log_dir_items                                                     +16 (192 -> 208)
btrfs_log_changed_extents                                          +8 (240 -> 248)
update_cache_item                                                  +8 (112 -> 120)
extent_from_logical                                                +8 (104 -> 112)
btrfs_drop_snapshot                                                +8 (176 -> 184)
btrfs_realloc_node                                                 +8 (208 -> 216)
did_create_dir                                                     +8 (88 -> 96)
add_qgroup_relation_item                                           +8 (80 -> 88)
find_dir_range                                                     +8 (112 -> 120)
btrfs_verify_level_key                                             +8 (128 -> 136)
do_walk_down                                                       +8 (336 -> 344)
get_last_extent                                                    +8 (88 -> 96)
add_keyed_refs                                                     +8 (168 -> 176)
read_block_for_search                                              +8 (168 -> 176)
can_rmdir                                                          +8 (120 -> 128)
btrfs_insert_empty_inode                                           +8 (40 -> 48)
btrfs_add_root_ref                                                 +8 (144 -> 152)
__btrfs_free_extent                                                +8 (216 -> 224)
add_all_parents                                                    +8 (160 -> 168)
btrfs_search_path_in_tree                                          +8 (120 -> 128)
add_new_free_space_info                                            +8 (72 -> 80)
btrfs_set_inode_index                                              +8 (96 -> 104)
btrfs_search_forward                                               +8 (128 -> 136)
insert_balance_item                                                +8 (232 -> 240)
btrfs_find_one_extref                                              +8 (104 -> 112)
scrub_raid56_parity                                                +8 (400 -> 408)
btrfs_real_readdir                                                 +8 (192 -> 200)
btrfs_log_inode_parent                                             +8 (264 -> 272)
btrfs_listxattr                                                    +8 (168 -> 176)
convert_free_space_to_bitmaps                                      +8 (168 -> 176)
btrfs_verify_dev_extents                                           +8 (152 -> 160)
find_next_extent                                                   +8 (120 -> 128)
btrfs_set_item_key_safe                                            +8 (160 -> 168)
btrfs_mark_extent_written                                         +16 (296 -> 312)
replay_xattr_deletes                                               +8 (192 -> 200)
caching_kthread                                                    +8 (128 -> 136)
btrfs_remove_chunk                                                 +8 (184 -> 192)
scrub_print_warning_inode                                          +8 (208 -> 216)
caching_thread                                                     +8 (184 -> 192)
log_new_dir_dentries                                              +16 (216 -> 232)
drop_objectid_items                                               +16 (112 -> 128)
insert_dir_log_key                                                 +8 (56 -> 64)
iterate_dir_item                                                   +8 (176 -> 184)
btrfs_lookup_csum                                                  +8 (104 -> 112)
relocate_tree_blocks                                               +8 (168 -> 176)
btrfs_build_ref_tree                                               -8 (168 -> 160)
btrfs_find_highest_objectid                                        +8 (80 -> 88)
btrfs_insert_dir_item                                              +8 (136 -> 144)
walk_down_log_tree                                                 +8 (176 -> 184)
btrfs_insert_file_extent                                           +8 (112 -> 120)
setup_leaf_for_split                                               +8 (120 -> 128)
btrfs_shrink_device                                                +8 (176 -> 184)

LOST (0):

NEW (544):
	btrfs_relocate_sys_chunks
	find_first_block_group
	add_delayed_refs
	process_leaf

LOST/NEW DELTA:     +544
PRE/POST DELTA:    +1840


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1EF64ABFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 01:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiLMAJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 19:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLMAJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 19:09:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA410FCC;
        Mon, 12 Dec 2022 16:09:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1onuwD3jTh-00ualV; Tue, 13
 Dec 2022 01:09:33 +0100
Message-ID: <09d56e5a-0e11-ca60-785a-7f06aedf1932@gmx.com>
Date:   Tue, 13 Dec 2022 08:09:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1670873892.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.2
In-Reply-To: <cover.1670873892.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5eUhRqJtS9uKWDiXVezdb7w9sCWigqdS/74/EGeJIdQh3cP/vPa
 ftibihxKuCkRQOAoQMb0oYwiDnaxOk7loIHeZDujfTL4qC3nnedK664FsBKiZgKwlwBf/xX
 MlyO3Cmx0X5BiPf/bzrd3AQ0pxa3Z1SB1+U48EMwZydqTmR1aVCL17ji4Lyw6KHRWE74SmS
 pRx9K3gd1HwNDezZ28iyg==
UI-OutboundReport: notjunk:1;M01:P0:z4jV2QlQ9Hw=;4p1sQoXK139VX2UdOyyyO4DSABx
 dgrl+qCTg+NQuxpQt0uy5vwQ/pTwuutCnLYTY3iEBkJFVQgQUQTTtBgkWYeQKWA3hcGIWkEh5
 Jz5GaBfGDMWT4JRGDbVIfdpevIZBvAn4gQOdlq9oLBxDWyhhR9UEGDrcAudJZyQgiE6cgvk0E
 W2i0TWZMG3rB0GilQ+7K5w/0TcjAoVbBph1NWIO7reuqpCQ/9ylcNSB7FD2xVBYPMQZaHgUH0
 I+JZVrb6Vz3QUbSENLHtrorUVDu3MXRPVk1gOD0NDMBo9lJU9tjiYBSlt3Twgaa331+Q29//A
 WJT2RoF8zwc/9CTWEfIle+G9hmuBIzQu0fJuPBCdAhwBQn47RqA0pqjTUY0/jSJZ0YNejYLYP
 hn33e1dxXpixoMdS3PVrTU7IPSEaKifhrT6YFP8DuaX3G2ZR4nVXfRKNxbg79V/QdTZ1W5S+b
 S4elmcpvL8ZTb2zoSIk4lphkOaJO3BE3XfWsmWjOC+hrUL2HrqrProytDYcdZxTGowa9NNuQY
 J8o/kRPy9Np4W2PFnoY5X/8gXOekKWDFDoDjus1GEjU5vnMzOT94eAm4nkR9n2mHwWMRJcsYk
 GzU7S2x/vCUzaqD1ClThsN8A3YCtfPf0Xd//afl2EFTeH/Y14VcJqwUOD8jPxHryZ3LNiplWW
 A1rhYHIAuT5R8euGeooT6kxaK2VGrMTbjxenN10jlWYSUPq66kuiaY6SfRfhc57/UAGxk8PhS
 NLO90X/9yrKw6q1QSLRtqCnqll91mv2kEP8NVjM/OifwW4tsUs41iE0/J0t3DTXu1I2Itea6f
 SaqOaFoXv8tXr9c76+5Xya731udqwIEuK2tk96EEmtOS1hFaSNlfDBHkgh0Els97UImvxjMap
 Qc5aPtdejHH2DgV8XOzKoezcFsw+T0jeSoWYPsiZScuyyPIFwHhodJ0aHFJLrZ+ZpHr6lAwha
 rxxZbApiXorrqG8WxTVxCqcOpQk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 04:16, David Sterba wrote:
> Hi,
> 
> this round there are a lot of cleanups and moved code so the diffstat
> looks huge, otherwise there are some nice performance improvements and
> an update to raid56 reliability. Please pull, thanks.
> 
> ---
> 
> User visible features:
> 
> - raid56 reliability vs performance trade off
>    - fix destructive RMW for raid5 data (raid6 still needs work) - do full RMW
>      cycle for writes and verify all checksums before overwrite, this should
>      prevent rewriting potentially corrupted data without notice

Unfortunately, the "RMW" term seems abused.

I'd change the sentence into:

   do full checksum verification for all data during RMW cycle.

>    - stripes are cached in memory which should reduce the performance impact but
>      still can hurt some workloads

The cache behavior is not changed in this big chunk of raid56 work, but 
commit f6065f8edeb2 ("btrfs: raid56: don't trust any cached sector in 
__raid56_parity_recover()") is still the main thing affecting recovery path.

Thus although we didn't change the cache policy, it will still be bad 
for recovery cases (missing device, or some sector has mimsatch csum).


>    - checksums are verified after repair again
>    - this is the last option without introducing additional features (write
>      intent bitmap, journal, another tree), the RMW cycle was supposed to be
>      avoided by the original implementation exactly for performance reasons but
>      that caused all the reliability problems

I don't know if the term "RMW" here is correctly used.

RMW is read-modify-write, which is the essential procedure for all 
RAID56 sub-stripe writes.
Thus it's something can not be avoided, and the new code didn't avoid it 
at all.

The only new behavior is the extra verification during RMW.
(Thus it can be called RVMW, but I don't think anyone can recognize it 
anyway)

I'd change the "the RMW cycle ..." sentence into:

   the extra checksum read/verification was supposed to be avoided by the
   original implementation exactly for performance reasons ...

> 
> - discard=async by default for devices that support it
> 
> - implement emergency flush reserve to avoid almost all unnecessary transaction
>    aborts due to ENOSPC in cases where there are too many delayed refs or
>    delayed allocation
> 
> - skip block group synchronization if there's no change in used bytes, can
>    reduce transaction commit count for some workloads
> 
> Performance improvements:
> 
> - fiemap and lseek
>    - overall speedup due to skipping unnecessary or duplicate searches (-40% run time)
>    - cache some data structures and sharedness of extents (-30% run time)
> 
> - send
>    - faster backref resolution when finding clones
>    - cached leaf to root mapping for faster backref walking
>    - improved clone/sharing detection
>    - overall run time improvements (-70%)
> 
> Core:
> 
> - module initialization converted to a table of function pointers run in a
>    sequence
> 
> - preparation for fscrypt, extend passing file names across calls, dir item can
>    store encryption status
> 
> - raid56 updates
>    - more accurate error tracking of sectors within stripe
>    - simplify recovery path and remove dedicated endio worker kthread
>    - simplify scrub call paths
>    - refactoring to support the full RMW write

   - refactoring to support the extra data checksum verification during
     RMW cycle.

Thanks,
Qu
> 
> - tree block parentness checks consolidated and done at metadata read time
> 
> - improved error handling
> 
> - cleanups
>    - move a lot of code for better synchronization between kernel and user space
>      sources, split big files
>    - enum cleanups
>    - GFP flag cleanups
>    - header file cleanups, prototypes, dependencies
>    - redundant parameter cleanups
>    - inline extent handling simplifications
>    - inode parameter conversion
>    - data structure cleanups, reductions, renames, merges
> 
> ----------------------------------------------------------------
> The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:
> 
>    Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-tag
> 
> for you to fetch changes up to b7af0635c87ff78d6bd523298ab7471f9ffd3ce5:
> 
>    btrfs: print transaction aborted messages with an error level (2022-12-05 18:00:59 +0100)
> 
> ----------------------------------------------------------------
> Anand Jain (2):
>        btrfs: merge module cleanup sequence to one helper
>        btrfs: move device->name RCU allocation and assign to btrfs_alloc_device()
> 
> Artem Chernyshev (1):
>        btrfs: replace strncpy() with strscpy()
> 
> Boris Burkov (2):
>        btrfs: skip reclaim if block_group is empty
>        btrfs: re-check reclaim condition in reclaim worker
> 
> ChenXiaoSong (1):
>        btrfs: add might_sleep() annotations
> 
> Christoph Hellwig (3):
>        btrfs: move struct btrfs_tree_parent_check out of disk-io.h
>        btrfs: split the bio submission path into a separate file
>        btrfs: move repair_io_failure to bio.c
> 
> David Sterba (63):
>        btrfs: add helper for bit enumeration
>        btrfs: convert BTRFS_ILOCK-* defines to enum bit
>        btrfs: convert extent_io page op defines to enum bits
>        btrfs: convert EXTENT_* bits to enums
>        btrfs: convert QGROUP_* defines to enum bits
>        btrfs: convert __TRANS_* defines to enum bits
>        btrfs: sysfs: convert remaining scnprintf to sysfs_emit
>        btrfs: auto enable discard=async when possible
>        btrfs: simplify generation check in btrfs_get_dentry
>        btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
>        btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
>        btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
>        btrfs: sink gfp_t parameter to alloc_scrub_sector
>        btrfs: update function comments
>        btrfs: fix SPDX comment in tree-mod-log.h
>        btrfs: simplify percent calculation helpers, rename div_factor
>        btrfs: switch extent_page_data bit fields to bools
>        btrfs: merge struct extent_page_data to btrfs_bio_ctrl
>        btrfs: zlib: use copy_page for full page copy
>        btrfs: zoned: use helper to check a power of two zone size
>        btrfs: convert btrfs_block_group::needs_free_space to runtime flag
>        btrfs: convert btrfs_block_group::seq_zone to runtime flag
>        btrfs: change how repair action is passed to btrfs_repair_one_sector
>        btrfs: drop parameter compression_type from btrfs_submit_dio_repair_bio
>        btrfs: change how submit bio callback is passed to btrfs_wq_submit_bio
>        btrfs: simplify btree_submit_bio_start and btrfs_submit_bio_start parameters
>        btrfs: switch async_submit_bio::inode to btrfs_inode
>        btrfs: pass btrfs_inode to btrfs_submit_bio_start
>        btrfs: pass btrfs_inode to btrfs_submit_bio_start_direct_io
>        btrfs: pass btrfs_inode to btrfs_wq_submit_bio
>        btrfs: pass btrfs_inode to btrfs_submit_metadata_bio
>        btrfs: pass btrfs_inode to btrfs_submit_data_write_bio
>        btrfs: pass btrfs_inode to btrfs_submit_data_read_bio
>        btrfs: pass btrfs_inode to btrfs_submit_dio_repair_bio
>        btrfs: pass btrfs_inode to submit_one_bio
>        btrfs: pass btrfs_inode to btrfs_repair_one_sector
>        btrfs: switch btrfs_dio_private::inode to btrfs_inode
>        btrfs: pass btrfs_inode to btrfs_submit_dio_bio
>        btrfs: pass btrfs_inode to btrfs_truncate
>        btrfs: pass btrfs_inode to btrfs_inode_lock
>        btrfs: pass btrfs_inode to btrfs_inode_unlock
>        btrfs: pass btrfs_inode to btrfs_dirty_inode
>        btrfs: pass btrfs_inode to btrfs_add_delalloc_inodes
>        btrfs: switch btrfs_writepage_fixup::inode to btrfs_inode
>        btrfs: pass btrfs_inode to btrfs_check_data_csum
>        btrfs: pass btrfs_inode to __unlink_start_trans
>        btrfs: pass btrfs_inode to btrfs_delete_subvolume
>        btrfs: drop private_data parameter from extent_io_tree_init
>        btrfs: switch extent_io_tree::private_data to btrfs_inode and rename
>        btrfs: pass btrfs_inode to btrfs_merge_delalloc_extent
>        btrfs: pass btrfs_inode to btrfs_set_delalloc_extent
>        btrfs: pass btrfs_inode to btrfs_split_delalloc_extent
>        btrfs: pass btrfs_inode to btrfs_clear_delalloc_extent
>        btrfs: pass btrfs_inode to btrfs_unlink_subvol
>        btrfs: pass btrfs_inode to btrfs_inode_by_name
>        btrfs: pass btrfs_inode to fixup_tree_root_location
>        btrfs: pass btrfs_inode to inode_tree_add
>        btrfs: pass btrfs_inode to btrfs_inherit_iflags
>        btrfs: switch async_chunk::inode to btrfs_inode
>        btrfs: use btrfs_inode inside compress_file_range
>        btrfs: use btrfs_inode inside btrfs_verify_data_csum
>        btrfs: pass btrfs_inode to btrfs_add_delayed_iput
>        btrfs: constify input buffer parameter in compression code
> 
> Filipe Manana (46):
>        btrfs: get the next extent map during fiemap/lseek more efficiently
>        btrfs: skip unnecessary extent map searches during fiemap and lseek
>        btrfs: skip unnecessary delalloc search during fiemap and lseek
>        btrfs: drop pointless memset when cloning extent buffer
>        btrfs: drop redundant bflags initialization when allocating extent buffer
>        btrfs: remove checks for a root with id 0 during backref walking
>        btrfs: remove checks for a 0 inode number during backref walking
>        btrfs: directly pass the inode to btrfs_is_data_extent_shared()
>        btrfs: turn the backref sharedness check cache into a context object
>        btrfs: move ulists to data extent sharedness check context
>        btrfs: remove roots ulist when checking data extent sharedness
>        btrfs: remove useless logic when finding parent nodes
>        btrfs: cache sharedness of the last few data extents during fiemap
>        btrfs: move up backref sharedness cache store and lookup functions
>        btrfs: avoid duplicated resolution of indirect backrefs during fiemap
>        btrfs: avoid unnecessary resolution of indirect backrefs during fiemap
>        btrfs: switch GFP_ATOMIC to GFP_NOFS when fixing up low keys
>        btrfs: remove gfp_t flag from btrfs_tree_mod_log_insert_key()
>        btrfs: update stale comment for nowait direct IO writes
>        btrfs: send: avoid unnecessary path allocations when finding extent clone
>        btrfs: send: update comment at find_extent_clone()
>        btrfs: send: drop unnecessary backref context field initializations
>        btrfs: send: avoid unnecessary backref lookups when finding clone source
>        btrfs: send: optimize clone detection to increase extent sharing
>        btrfs: use a single argument for extent offset in backref walking functions
>        btrfs: use a structure to pass arguments to backref walking functions
>        btrfs: reuse roots ulist on each leaf iteration for iterate_extent_inodes()
>        btrfs: constify ulist parameter of ulist_next()
>        btrfs: send: cache leaf to roots mapping during backref walking
>        btrfs: send: skip unnecessary backref iterations
>        btrfs: send: avoid double extent tree search when finding clone source
>        btrfs: send: skip resolution of our own backref when finding clone source
>        btrfs: send: bump the extent reference count limit for backref walking
>        btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
>        btrfs: add an early exit when searching for delalloc range for lseek/fiemap
>        btrfs: skip unnecessary delalloc searches during lseek/fiemap
>        btrfs: search for delalloc more efficiently during lseek/fiemap
>        btrfs: remove no longer used btrfs_next_extent_map()
>        btrfs: allow passing a cached state record to count_range_bits()
>        btrfs: update stale comment for count_range_bits()
>        btrfs: use cached state when looking for delalloc ranges with fiemap
>        btrfs: use cached state when looking for delalloc ranges with lseek
>        btrfs: unify overwrite_item() and do_overwrite_item()
>        btrfs: remove outdated logic from overwrite_item() and add assertion
>        btrfs: do not BUG_ON() on ENOMEM when dropping extent items for a range
>        btrfs: print transaction aborted messages with an error level
> 
> Josef Bacik (91):
>        btrfs: add a cached_state to try_lock_extent
>        btrfs: use cached_state for btrfs_check_nocow_lock
>        btrfs: use a cached_state everywhere in relocation
>        btrfs: cache the failed state when locking extents
>        btrfs: add cached_state to read_extent_buffer_subpage
>        btrfs: remove unused set/clear_pending_info helpers
>        btrfs: remove unused BTRFS_TOTAL_BYTES_PINNED_BATCH
>        btrfs: remove unused BTRFS_IOPRIO_READA
>        btrfs: move btrfs on-disk definitions out of ctree.h
>        btrfs: move btrfs_get_block_group helper out of disk-io.h
>        btrfs: move maximum limits to btrfs_tree.h
>        btrfs: move BTRFS_MAX_MIRRORS into scrub.c
>        btrfs: move discard stat defs to free-space-cache.h
>        btrfs: move btrfs_should_fragment_free_space into block-group.c
>        btrfs: move flush related definitions to space-info.h
>        btrfs: move btrfs_print_data_csum_error into inode.c
>        btrfs: move trans_handle_cachep out of ctree.h
>        btrfs: move btrfs_path_cachep out of ctree.h
>        btrfs: move free space cachep's out of ctree.h
>        btrfs: move btrfs_next_old_item into ctree.c
>        btrfs: move the btrfs_verity_descriptor_item defs up in ctree.h
>        btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
>        btrfs: do not use GFP_ATOMIC in the read endio
>        btrfs: remove unused unlock_extent_atomic
>        btrfs: do not panic if we can't allocate a prealloc extent state
>        btrfs: move fs wide helpers out of ctree.h
>        btrfs: move assert helpers out of ctree.h
>        btrfs: move the printk helpers out of ctree.h
>        btrfs: push printk index code into their respective helpers
>        btrfs: move BTRFS_FS_STATE* definitions and helpers to fs.h
>        btrfs: convert incompat and compat flag test helpers to macros
>        btrfs: move mount option definitions to fs.h
>        btrfs: move fs_info::flags enum to fs.h
>        btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
>        btrfs: remove fs_info::pending_changes and related code
>        btrfs: move the compat/incompat flag masks to fs.h
>        btrfs: rename struct-funcs.c to accessors.c
>        btrfs: move btrfs_map_token to accessors
>        btrfs: move accessor helpers into accessors.h
>        btrfs: remove temporary btrfs_map_token declaration in ctree.h
>        btrfs: move btrfs_fs_info declarations into fs.h
>        btrfs: move the lockdep helpers into locking.h
>        btrfs: minor whitespace in ctree.h
>        btrfs: remove extra space info prototypes in ctree.h
>        btrfs: move btrfs_account_ro_block_groups_free_space into space-info.c
>        btrfs: move extent-tree helpers into their own header file
>        btrfs: move delalloc space related prototypes to delalloc-space.h
>        btrfs: delete unused function prototypes in ctree.h
>        btrfs: move root tree prototypes to their own header
>        btrfs: remove unused function prototypes
>        btrfs: remove unused btrfs_cond_migrate_bytes
>        btrfs: convert discard stat defs to enum
>        btrfs: move btrfs_chunk_item_size out of ctree.h
>        btrfs: add dependencies to fs.h and block-rsv.h
>        btrfs: add blk_types.h include to compression.h
>        btrfs: move the printk and assert helpers to messages.c
>        btrfs: move inode prototypes to btrfs_inode.h
>        btrfs: rename tree-defrag.c to defrag.c
>        btrfs: move the auto defrag code to defrag.c
>        btrfs: move the file defrag code into defrag.c
>        btrfs: move defrag related prototypes to their own header
>        btrfs: move dir-item prototypes into dir-item.h
>        btrfs: move file-item prototypes into their own header
>        btrfs: move uuid tree prototypes to uuid-tree.h
>        btrfs: move ioctl prototypes into ioctl.h
>        btrfs: move file prototypes to file.h
>        btrfs: move the 32bit warn defines into messages.h
>        btrfs: move the snapshot drop related prototypes to extent-tree.h
>        btrfs: move acl prototypes into acl.h
>        btrfs: move relocation prototypes into relocation.h
>        btrfs: move scrub prototypes into scrub.h
>        btrfs: move dev-replace prototypes into dev-replace.h
>        btrfs: move verity prototypes into verity.h
>        btrfs: move CONFIG_BTRFS_FS_RUN_SANITY_TESTS checks to fs.h
>        btrfs: move super prototypes into super.h
>        btrfs: move super_block specific helpers into super.h
>        btrfs: move orphan prototypes into orphan.h
>        btrfs: move root helpers back into ctree.h
>        btrfs: move leaf_data_end into ctree.c
>        btrfs: move file_extent_item helpers into file-item.h
>        btrfs: move eb offset helpers into extent_io.h
>        btrfs: move the csum helpers into ctree.h
>        btrfs: pass the extent buffer for the btrfs_item_nr helpers
>        btrfs: add eb to btrfs_node_key_ptr_offset
>        btrfs: add helpers for manipulating leaf items and data
>        btrfs: remove BTRFS_LEAF_DATA_OFFSET
>        btrfs: add nr_global_roots to the super block definition
>        btrfs: add stack helpers for a few btrfs items
>        btrfs: fix uninitialized parent in insert_state
>        btrfs: fix uninitialized variable in find_first_clear_extent_bit
>        btrfs: sync some cleanups from progs into uapi/btrfs.h
> 
> Li zeming (1):
>        btrfs: allocate btrfs_io_context without GFP_NOFAIL
> 
> Omar Sandoval (1):
>        btrfs: extend btrfs_dir_item type to store encryption status
> 
> Peng Hao (1):
>        btrfs: simplify cleanup after error in btrfs_create_tree
> 
> Qu Wenruo (32):
>        btrfs: raid56: cleanup for function __free_raid_bio()
>        btrfs: raid56: allocate memory separately for rbio pointers
>        btrfs: raid56: make it more explicit that cache rbio should have all its data sectors uptodate
>        btrfs: make module init/exit match their sequence
>        btrfs: skip update of block group item if used bytes are the same
>        btrfs: selftests: remove impossible inline extent at non-zero file offset
>        btrfs: make inline extent read calculation much simpler
>        btrfs: do not reset extent map members for inline extents read
>        btrfs: remove new_inline argument from btrfs_extent_item_to_extent_map()
>        btrfs: extract the inline extent read code into its own function
>        btrfs: raid56: extract the vertical stripe recovery code into recover_vertical()
>        btrfs: raid56: extract the pq generation code into a helper
>        btrfs: raid56: extract the recovery bio list build code into a helper
>        btrfs: raid56: extract sector recovery code into a helper
>        btrfs: raid56: switch recovery path to a single function
>        btrfs: raid56: extract the rmw bio list build code into a helper
>        btrfs: raid56: extract rwm write bios assembly into a helper
>        btrfs: raid56: introduce the main entrance for RMW path
>        btrfs: raid56: switch write path to rmw_rbio()
>        btrfs: raid56: extract scrub read bio list assembly code into a helper
>        btrfs: raid56: switch scrub path to use a single function
>        btrfs: remove the unused endio_raid56_workers and btrfs_raid_bio::end_io_work
>        btrfs: raid56: introduce btrfs_raid_bio::error_bitmap
>        btrfs: raid56: migrate recovery and scrub recovery path to use error_bitmap
>        btrfs: raid56: remove the old error tracking system
>        btrfs: concentrate all tree block parentness check parameters into one structure
>        btrfs: move tree block parentness check into validate_extent_buffer()
>        btrfs: use btrfs_dev_name() helper to handle missing devices better
>        btrfs: refactor checksum calculations in btrfs_lookup_csums_range()
>        btrfs: introduce a bitmap based csum range search function
>        btrfs: raid56: prepare data checksums for later RMW verification
>        btrfs: raid56: do data csum verification during RMW cycle
> 
> Sweet Tea Dorminy (3):
>        btrfs: use struct qstr instead of name and namelen pairs
>        btrfs: setup qstr from dentrys using fscrypt helper
>        btrfs: use struct fscrypt_str instead of struct qstr
> 
> Wang Yugui (1):
>        btrfs: send add define for v2 buffer size
> 
> void0red (1):
>        btrfs: fix extent map use-after-free when handling missing device in read_one_chunk
> 
>   fs/btrfs/Makefile                        |    6 +-
>   fs/btrfs/{struct-funcs.c => accessors.c} |   12 +-
>   fs/btrfs/accessors.h                     | 1073 ++++++++
>   fs/btrfs/acl.c                           |    2 +-
>   fs/btrfs/acl.h                           |   27 +
>   fs/btrfs/backref.c                       | 1001 +++++---
>   fs/btrfs/backref.h                       |  195 +-
>   fs/btrfs/bio.c                           |  381 +++
>   fs/btrfs/bio.h                           |  127 +
>   fs/btrfs/block-group.c                   |  152 +-
>   fs/btrfs/block-group.h                   |   30 +-
>   fs/btrfs/block-rsv.c                     |   43 +-
>   fs/btrfs/block-rsv.h                     |    6 +-
>   fs/btrfs/btrfs_inode.h                   |  161 +-
>   fs/btrfs/check-integrity.c               |    4 +-
>   fs/btrfs/compression.c                   |   18 +-
>   fs/btrfs/compression.h                   |   11 +-
>   fs/btrfs/ctree.c                         |  311 ++-
>   fs/btrfs/ctree.h                         | 3927 ++----------------------------
>   fs/btrfs/defrag.c                        | 1376 +++++++++++
>   fs/btrfs/defrag.h                        |   22 +
>   fs/btrfs/delalloc-space.c                |   61 +-
>   fs/btrfs/delalloc-space.h                |    3 +
>   fs/btrfs/delayed-inode.c                 |   17 +-
>   fs/btrfs/delayed-inode.h                 |    2 +-
>   fs/btrfs/delayed-ref.c                   |   21 +-
>   fs/btrfs/dev-replace.c                   |   28 +-
>   fs/btrfs/dev-replace.h                   |    8 +
>   fs/btrfs/dir-item.c                      |   60 +-
>   fs/btrfs/dir-item.h                      |   42 +
>   fs/btrfs/discard.c                       |  112 +-
>   fs/btrfs/disk-io.c                       |  247 +-
>   fs/btrfs/disk-io.h                       |   35 +-
>   fs/btrfs/export.c                        |   25 +-
>   fs/btrfs/export.h                        |    3 +-
>   fs/btrfs/extent-io-tree.c                |  192 +-
>   fs/btrfs/extent-io-tree.h                |  100 +-
>   fs/btrfs/extent-tree.c                   |   55 +-
>   fs/btrfs/extent-tree.h                   |   78 +
>   fs/btrfs/extent_io.c                     |  482 ++--
>   fs/btrfs/extent_io.h                     |   67 +-
>   fs/btrfs/extent_map.c                    |   75 +-
>   fs/btrfs/file-item.c                     |  258 +-
>   fs/btrfs/file-item.h                     |   69 +
>   fs/btrfs/file.c                          |  621 ++---
>   fs/btrfs/file.h                          |   33 +
>   fs/btrfs/free-space-cache.c              |   52 +-
>   fs/btrfs/free-space-cache.h              |   13 +
>   fs/btrfs/free-space-tree.c               |   15 +-
>   fs/btrfs/fs.c                            |   94 +
>   fs/btrfs/fs.h                            |  976 ++++++++
>   fs/btrfs/inode-item.c                    |   79 +-
>   fs/btrfs/inode-item.h                    |   20 +-
>   fs/btrfs/inode.c                         |  904 +++----
>   fs/btrfs/ioctl.c                         |  945 +------
>   fs/btrfs/ioctl.h                         |   17 +
>   fs/btrfs/locking.c                       |    1 +
>   fs/btrfs/locking.h                       |   76 +
>   fs/btrfs/lzo.c                           |    4 +-
>   fs/btrfs/messages.c                      |  353 +++
>   fs/btrfs/messages.h                      |  245 ++
>   fs/btrfs/misc.h                          |   24 +-
>   fs/btrfs/ordered-data.c                  |   25 +-
>   fs/btrfs/ordered-data.h                  |    3 +-
>   fs/btrfs/orphan.c                        |    1 +
>   fs/btrfs/orphan.h                        |   11 +
>   fs/btrfs/print-tree.c                    |   21 +-
>   fs/btrfs/props.c                         |    8 +-
>   fs/btrfs/props.h                         |    2 +-
>   fs/btrfs/qgroup.c                        |   78 +-
>   fs/btrfs/qgroup.h                        |   11 +-
>   fs/btrfs/raid56.c                        | 2066 ++++++++--------
>   fs/btrfs/raid56.h                        |   33 +-
>   fs/btrfs/rcu-string.h                    |    6 +-
>   fs/btrfs/ref-verify.c                    |    3 +
>   fs/btrfs/reflink.c                       |   30 +-
>   fs/btrfs/relocation.c                    |   94 +-
>   fs/btrfs/relocation.h                    |   23 +
>   fs/btrfs/root-tree.c                     |   24 +-
>   fs/btrfs/root-tree.h                     |   34 +
>   fs/btrfs/scrub.c                         |   75 +-
>   fs/btrfs/scrub.h                         |   16 +
>   fs/btrfs/send.c                          |  488 +++-
>   fs/btrfs/send.h                          |    6 +-
>   fs/btrfs/space-info.c                    |   86 +-
>   fs/btrfs/space-info.h                    |   78 +
>   fs/btrfs/subpage.c                       |    1 +
>   fs/btrfs/super.c                         |  554 +----
>   fs/btrfs/super.h                         |   29 +
>   fs/btrfs/sysfs.c                         |   16 +-
>   fs/btrfs/tests/btrfs-tests.c             |    3 +-
>   fs/btrfs/tests/extent-buffer-tests.c     |    1 +
>   fs/btrfs/tests/extent-io-tests.c         |    4 +-
>   fs/btrfs/tests/free-space-tree-tests.c   |    3 +-
>   fs/btrfs/tests/inode-tests.c             |   58 +-
>   fs/btrfs/tests/qgroup-tests.c            |   52 +-
>   fs/btrfs/transaction.c                   |   92 +-
>   fs/btrfs/transaction.h                   |   22 +-
>   fs/btrfs/tree-checker.c                  |   10 +-
>   fs/btrfs/tree-checker.h                  |   35 +-
>   fs/btrfs/tree-defrag.c                   |  132 -
>   fs/btrfs/tree-log.c                      |  452 ++--
>   fs/btrfs/tree-log.h                      |    5 +-
>   fs/btrfs/tree-mod-log.c                  |   36 +-
>   fs/btrfs/tree-mod-log.h                  |    4 +-
>   fs/btrfs/ulist.c                         |   38 +-
>   fs/btrfs/ulist.h                         |    2 +-
>   fs/btrfs/uuid-tree.c                     |    5 +-
>   fs/btrfs/uuid-tree.h                     |   12 +
>   fs/btrfs/verity.c                        |    6 +
>   fs/btrfs/verity.h                        |   28 +
>   fs/btrfs/volumes.c                       |  454 +---
>   fs/btrfs/volumes.h                       |  116 +-
>   fs/btrfs/xattr.c                         |    4 +
>   fs/btrfs/zlib.c                          |    6 +-
>   fs/btrfs/zoned.c                         |   18 +-
>   fs/btrfs/zoned.h                         |    1 +
>   fs/btrfs/zstd.c                          |    4 +-
>   include/trace/events/btrfs.h             |   27 +-
>   include/uapi/linux/btrfs.h               |   36 +-
>   include/uapi/linux/btrfs_tree.h          |  235 ++
>   121 files changed, 11439 insertions(+), 9681 deletions(-)
>   rename fs/btrfs/{struct-funcs.c => accessors.c} (95%)
>   create mode 100644 fs/btrfs/accessors.h
>   create mode 100644 fs/btrfs/acl.h
>   create mode 100644 fs/btrfs/bio.c
>   create mode 100644 fs/btrfs/bio.h
>   create mode 100644 fs/btrfs/defrag.c
>   create mode 100644 fs/btrfs/defrag.h
>   create mode 100644 fs/btrfs/dir-item.h
>   create mode 100644 fs/btrfs/extent-tree.h
>   create mode 100644 fs/btrfs/file-item.h
>   create mode 100644 fs/btrfs/file.h
>   create mode 100644 fs/btrfs/fs.c
>   create mode 100644 fs/btrfs/fs.h
>   create mode 100644 fs/btrfs/ioctl.h
>   create mode 100644 fs/btrfs/messages.c
>   create mode 100644 fs/btrfs/messages.h
>   create mode 100644 fs/btrfs/orphan.h
>   create mode 100644 fs/btrfs/relocation.h
>   create mode 100644 fs/btrfs/root-tree.h
>   create mode 100644 fs/btrfs/scrub.h
>   create mode 100644 fs/btrfs/super.h
>   delete mode 100644 fs/btrfs/tree-defrag.c
>   create mode 100644 fs/btrfs/uuid-tree.h
>   create mode 100644 fs/btrfs/verity.h

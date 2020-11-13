Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98CA2B14E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 04:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgKMDxt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 22:53:49 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44774 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKMDxt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 22:53:49 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C584A8A2F4F; Thu, 12 Nov 2020 22:53:47 -0500 (EST)
Date:   Thu, 12 Nov 2020 22:53:42 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/42] Cleanup error handling in relocation
Message-ID: <20201113035342.GB31381@hungrycats.org>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 12, 2020 at 04:18:27PM -0500, Josef Bacik wrote:
> Hello,
> 
> Relocation is the last place that is not able to handle errors at all, which
> results in all sorts of lovely panics if you encounter corruptions or IO errors.
> I'm going to start cleaning up relocation, but before I move code around I want
> the error handling to be somewhat sane, so I'm not changing behavior and error
> handling at the same time.
> 
> These patches are purely about error handling, there is no behavior changing
> other than returning errors up the chain properly.  There is a lot of room for
> follow up cleanups, which will happen next.  However I wanted to get this series
> done today and out so we could get it merged ASAP, and then the follow up
> cleanups can happen later as they are less important and less critical.
> 
> The only exception to the above is the patch to add the error injection sites
> for btrfs_cow_block and btrfs_search_slot, and a lockdep fix that I discovered
> while running my tests, those are the first two patches in the series.
> 
> I tested this with my error injection stress test, where I keep track of all
> stack traces that have been tested and only inject errors when we have a new
> stack trace, which means I should have covered all of the various error
> conditions.  With this patchset I'm no longer panicing while stressing the error
> conditions.  Thanks,

I just threw this patch set on top of kdave/for-next
(a12315094469d573e41fe3eee91c99a83cec02df) and I got something that
looks like runaway balances:

	[Thu Nov 12 22:16:37 2020] BTRFS info (device dm-0): balance: start -dlimit=9
	[Thu Nov 12 22:16:37 2020] BTRFS info (device dm-0): relocating block group 37256442150912 flags data
	[Thu Nov 12 22:16:38 2020] BTRFS info (device dm-0): found 19 extents, loops 1, stage: move data extents
	[Thu Nov 12 22:16:41 2020] BTRFS info (device dm-0): found 19 extents, loops 2, stage: move data extents
	[Thu Nov 12 22:16:45 2020] BTRFS info (device dm-0): found 19 extents, loops 3, stage: move data extents
	[Thu Nov 12 22:16:46 2020] BTRFS info (device dm-0): found 19 extents, loops 4, stage: move data extents
	[Thu Nov 12 22:16:47 2020] BTRFS info (device dm-0): found 19 extents, loops 5, stage: move data extents
	[Thu Nov 12 22:16:47 2020] avg_delayed_ref_runtime = 3492558, time = 750175264685, count = 214792
	[Thu Nov 12 22:16:50 2020] BTRFS info (device dm-0): found 19 extents, loops 6, stage: move data extents
	[Thu Nov 12 22:16:55 2020] BTRFS info (device dm-0): found 19 extents, loops 7, stage: move data extents
	[Thu Nov 12 22:16:58 2020] BTRFS info (device dm-0): found 19 extents, loops 8, stage: move data extents
	[Thu Nov 12 22:17:02 2020] BTRFS info (device dm-0): found 19 extents, loops 9, stage: move data extents
	[Thu Nov 12 22:17:07 2020] BTRFS info (device dm-0): found 19 extents, loops 10, stage: move data extents
	[Thu Nov 12 22:17:11 2020] BTRFS info (device dm-0): found 19 extents, loops 11, stage: move data extents
	[Thu Nov 12 22:17:15 2020] BTRFS info (device dm-0): found 19 extents, loops 12, stage: move data extents
	[Thu Nov 12 22:17:19 2020] BTRFS info (device dm-0): found 19 extents, loops 13, stage: move data extents
	[Thu Nov 12 22:17:23 2020] BTRFS info (device dm-0): found 19 extents, loops 14, stage: move data extents
	[Thu Nov 12 22:17:27 2020] BTRFS info (device dm-0): found 19 extents, loops 15, stage: move data extents
	[Thu Nov 12 22:17:31 2020] BTRFS info (device dm-0): found 19 extents, loops 16, stage: move data extents
	[Thu Nov 12 22:17:35 2020] BTRFS info (device dm-0): found 19 extents, loops 17, stage: move data extents
	[Thu Nov 12 22:17:40 2020] BTRFS info (device dm-0): found 19 extents, loops 18, stage: move data extents
	[Thu Nov 12 22:17:47 2020] BTRFS info (device dm-0): found 19 extents, loops 19, stage: move data extents
	[Thu Nov 12 22:17:51 2020] BTRFS info (device dm-0): found 19 extents, loops 20, stage: move data extents
	[Thu Nov 12 22:17:55 2020] BTRFS info (device dm-0): found 19 extents, loops 21, stage: move data extents
	[Thu Nov 12 22:17:59 2020] BTRFS info (device dm-0): found 19 extents, loops 22, stage: move data extents
	[Thu Nov 12 22:18:04 2020] BTRFS info (device dm-0): found 19 extents, loops 23, stage: move data extents
	[Thu Nov 12 22:18:07 2020] BTRFS info (device dm-0): found 19 extents, loops 24, stage: move data extents
	[Thu Nov 12 22:18:11 2020] BTRFS info (device dm-0): found 19 extents, loops 25, stage: move data extents
	[Thu Nov 12 22:18:15 2020] BTRFS info (device dm-0): found 19 extents, loops 26, stage: move data extents
	[Thu Nov 12 22:18:20 2020] BTRFS info (device dm-0): found 19 extents, loops 27, stage: move data extents
	[Thu Nov 12 22:18:24 2020] BTRFS info (device dm-0): found 19 extents, loops 28, stage: move data extents
	[Thu Nov 12 22:18:28 2020] BTRFS info (device dm-0): found 19 extents, loops 29, stage: move data extents
	[Thu Nov 12 22:18:32 2020] BTRFS info (device dm-0): found 19 extents, loops 30, stage: move data extents
	[Thu Nov 12 22:18:38 2020] BTRFS info (device dm-0): found 19 extents, loops 31, stage: move data extents
	[Thu Nov 12 22:18:45 2020] BTRFS info (device dm-0): found 19 extents, loops 32, stage: move data extents
	[Thu Nov 12 22:18:49 2020] BTRFS info (device dm-0): found 19 extents, loops 33, stage: move data extents
	[Thu Nov 12 22:18:53 2020] BTRFS info (device dm-0): found 19 extents, loops 34, stage: move data extents
	[Thu Nov 12 22:18:59 2020] BTRFS info (device dm-0): found 19 extents, loops 35, stage: move data extents
	[Thu Nov 12 22:19:02 2020] BTRFS info (device dm-0): found 19 extents, loops 36, stage: move data extents
	[Thu Nov 12 22:19:06 2020] BTRFS info (device dm-0): found 19 extents, loops 37, stage: move data extents
	[Thu Nov 12 22:19:12 2020] BTRFS info (device dm-0): found 19 extents, loops 38, stage: move data extents
	[Thu Nov 12 22:19:15 2020] BTRFS info (device dm-0): found 19 extents, loops 39, stage: move data extents
	[Thu Nov 12 22:19:20 2020] BTRFS info (device dm-0): found 19 extents, loops 40, stage: move data extents
	[Thu Nov 12 22:19:23 2020] BTRFS info (device dm-0): found 19 extents, loops 41, stage: move data extents
	[Thu Nov 12 22:19:27 2020] BTRFS info (device dm-0): found 19 extents, loops 42, stage: move data extents
	[Thu Nov 12 22:19:31 2020] BTRFS info (device dm-0): found 19 extents, loops 43, stage: move data extents
	[Thu Nov 12 22:19:35 2020] BTRFS info (device dm-0): found 19 extents, loops 44, stage: move data extents
	[Thu Nov 12 22:19:38 2020] BTRFS info (device dm-0): found 19 extents, loops 45, stage: move data extents
	[Thu Nov 12 22:19:42 2020] BTRFS info (device dm-0): found 19 extents, loops 46, stage: move data extents
	[Thu Nov 12 22:19:46 2020] BTRFS info (device dm-0): found 19 extents, loops 47, stage: move data extents
	[Thu Nov 12 22:19:51 2020] BTRFS info (device dm-0): found 19 extents, loops 48, stage: move data extents
	[Thu Nov 12 22:19:54 2020] BTRFS info (device dm-0): found 19 extents, loops 49, stage: move data extents
	[Thu Nov 12 22:19:57 2020] BTRFS info (device dm-0): found 19 extents, loops 50, stage: move data extents
	[Thu Nov 12 22:19:58 2020] BTRFS info (device dm-0): found 19 extents, loops 51, stage: move data extents
	[Thu Nov 12 22:19:58 2020] BTRFS info (device dm-0): found 19 extents, loops 52, stage: move data extents
	[Thu Nov 12 22:20:02 2020] BTRFS info (device dm-0): found 19 extents, loops 53, stage: move data extents
	[Thu Nov 12 22:20:06 2020] BTRFS info (device dm-0): found 19 extents, loops 54, stage: move data extents
	[Thu Nov 12 22:20:10 2020] BTRFS info (device dm-0): found 19 extents, loops 55, stage: move data extents
	[Thu Nov 12 22:20:14 2020] BTRFS info (device dm-0): found 19 extents, loops 56, stage: move data extents
	[Thu Nov 12 22:20:26 2020] BTRFS info (device dm-0): found 19 extents, loops 57, stage: move data extents
	[Thu Nov 12 22:21:05 2020] BTRFS info (device dm-0): found 19 extents, loops 58, stage: move data extents
	[Thu Nov 12 22:21:16 2020] BTRFS info (device dm-0): found 19 extents, loops 59, stage: move data extents
	[Thu Nov 12 22:21:20 2020] BTRFS info (device dm-0): found 19 extents, loops 60, stage: move data extents
	[Thu Nov 12 22:21:25 2020] BTRFS info (device dm-0): found 19 extents, loops 61, stage: move data extents
	[Thu Nov 12 22:21:31 2020] BTRFS info (device dm-0): found 19 extents, loops 62, stage: move data extents
	[Thu Nov 12 22:21:37 2020] BTRFS info (device dm-0): found 19 extents, loops 63, stage: move data extents

The "loops N" is something I added for testing previous runaway balance
fixes as I got tired of counting them from scripts all the time.

The same for-next kernel without patches had been running for 48 hours
before this with no strange balance loop counts, so this looks like new
behavior from this patch series.

On a metadata block group the extent count does change over time:

	[Thu Nov 12 22:45:23 2020] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[Thu Nov 12 22:45:23 2020] BTRFS info (device dm-0): relocating block group 37252147183616 flags metadata|raid1
	[Thu Nov 12 22:45:31 2020] BTRFS info (device dm-0): found 21944 extents, loops 1, stage: move data extents
	[Thu Nov 12 22:45:51 2020] BTRFS info (device dm-0): found 21482 extents, loops 2, stage: move data extents
	[Thu Nov 12 22:46:00 2020] BTRFS info (device dm-0): found 20066 extents, loops 3, stage: move data extents
	[Thu Nov 12 22:46:02 2020] BTRFS info (device dm-0): found 20000 extents, loops 4, stage: move data extents
	[Thu Nov 12 22:46:06 2020] BTRFS info (device dm-0): found 19986 extents, loops 5, stage: move data extents
	[Thu Nov 12 22:46:08 2020] BTRFS info (device dm-0): found 19980 extents, loops 6, stage: move data extents
	[Thu Nov 12 22:46:12 2020] BTRFS info (device dm-0): found 19978 extents, loops 7, stage: move data extents
	[Thu Nov 12 22:46:15 2020] BTRFS info (device dm-0): found 19971 extents, loops 8, stage: move data extents
	[Thu Nov 12 22:46:18 2020] BTRFS info (device dm-0): found 19958 extents, loops 9, stage: move data extents
	[Thu Nov 12 22:46:21 2020] BTRFS info (device dm-0): found 19955 extents, loops 10, stage: move data extents
	[Thu Nov 12 22:46:24 2020] BTRFS info (device dm-0): found 19943 extents, loops 11, stage: move data extents
	[Thu Nov 12 22:46:27 2020] BTRFS info (device dm-0): found 19939 extents, loops 12, stage: move data extents
	[Thu Nov 12 22:46:30 2020] BTRFS info (device dm-0): found 19927 extents, loops 13, stage: move data extents
	[Thu Nov 12 22:46:33 2020] BTRFS info (device dm-0): found 19925 extents, loops 14, stage: move data extents
	[Thu Nov 12 22:46:48 2020] BTRFS info (device dm-0): found 19891 extents, loops 15, stage: move data extents
	[Thu Nov 12 22:47:06 2020] BTRFS info (device dm-0): found 19808 extents, loops 16, stage: move data extents
	[Thu Nov 12 22:47:10 2020] BTRFS info (device dm-0): found 19805 extents, loops 17, stage: move data extents
	[Thu Nov 12 22:47:13 2020] BTRFS info (device dm-0): found 19803 extents, loops 18, stage: move data extents
	[Thu Nov 12 22:47:15 2020] BTRFS info (device dm-0): found 19802 extents, loops 19, stage: move data extents
	[Thu Nov 12 22:47:18 2020] BTRFS info (device dm-0): found 19802 extents, loops 20, stage: move data extents
	[Thu Nov 12 22:47:21 2020] BTRFS info (device dm-0): found 19802 extents, loops 21, stage: move data extents
	[Thu Nov 12 22:47:24 2020] BTRFS info (device dm-0): found 19802 extents, loops 22, stage: move data extents
	[Thu Nov 12 22:47:28 2020] BTRFS info (device dm-0): found 19802 extents, loops 23, stage: move data extents
	[Thu Nov 12 22:47:30 2020] BTRFS info (device dm-0): found 19802 extents, loops 24, stage: move data extents
	[Thu Nov 12 22:47:34 2020] BTRFS info (device dm-0): found 19802 extents, loops 25, stage: move data extents
	[Thu Nov 12 22:47:36 2020] BTRFS info (device dm-0): found 19800 extents, loops 26, stage: move data extents
	[Thu Nov 12 22:47:40 2020] BTRFS info (device dm-0): found 19800 extents, loops 27, stage: move data extents
	[Thu Nov 12 22:47:43 2020] BTRFS info (device dm-0): found 19800 extents, loops 28, stage: move data extents
	[Thu Nov 12 22:47:56 2020] BTRFS info (device dm-0): found 19800 extents, loops 29, stage: move data extents
	[Thu Nov 12 22:48:10 2020] BTRFS info (device dm-0): found 19770 extents, loops 30, stage: move data extents
	[Thu Nov 12 22:48:15 2020] BTRFS info (device dm-0): found 19765 extents, loops 31, stage: move data extents
	[Thu Nov 12 22:48:17 2020] BTRFS info (device dm-0): found 19764 extents, loops 32, stage: move data extents
	[Thu Nov 12 22:48:19 2020] BTRFS info (device dm-0): found 19764 extents, loops 33, stage: move data extents
	[Thu Nov 12 22:48:23 2020] BTRFS info (device dm-0): found 19764 extents, loops 34, stage: move data extents
	[Thu Nov 12 22:48:25 2020] BTRFS info (device dm-0): found 19764 extents, loops 35, stage: move data extents
	[Thu Nov 12 22:48:29 2020] BTRFS info (device dm-0): found 19764 extents, loops 36, stage: move data extents
	[Thu Nov 12 22:48:32 2020] BTRFS info (device dm-0): found 19763 extents, loops 37, stage: move data extents
	[Thu Nov 12 22:48:35 2020] BTRFS info (device dm-0): found 19763 extents, loops 38, stage: move data extents
	[Thu Nov 12 22:48:38 2020] BTRFS info (device dm-0): found 19763 extents, loops 39, stage: move data extents
	[Thu Nov 12 22:48:41 2020] BTRFS info (device dm-0): found 19763 extents, loops 40, stage: move data extents
	[Thu Nov 12 22:48:44 2020] BTRFS info (device dm-0): found 19763 extents, loops 41, stage: move data extents

> Josef
> 
> Josef Bacik (42):
>   btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
>   btrfs: fix lockdep splat in btrfs_recover_relocation
>   btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
>   btrfs: convert BUG_ON()'s in relocate_tree_block
>   btrfs: return an error from btrfs_record_root_in_trans
>   btrfs: handle errors from select_reloc_root()
>   btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
>   btrfs: check record_root_in_trans related failures in
>     select_reloc_root
>   btrfs: do proper error handling in record_reloc_root_in_trans
>   btrfs: handle btrfs_record_root_in_trans failure in
>     btrfs_rename_exchange
>   btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
>   btrfs: handle btrfs_record_root_in_trans failure in
>     btrfs_delete_subvolume
>   btrfs: handle btrfs_record_root_in_trans failure in
>     btrfs_recover_log_trees
>   btrfs: handle btrfs_record_root_in_trans failure in create_subvol
>   btrfs: btrfs: handle btrfs_record_root_in_trans failure in
>     relocate_tree_block
>   btrfs: handle btrfs_record_root_in_trans failure in start_transaction
>   btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
>   btrfs: handle record_root_in_trans failure in
>     btrfs_record_root_in_trans
>   btrfs: handle record_root_in_trans failure in create_pending_snapshot
>   btrfs: do not panic in __add_reloc_root
>   btrfs: have proper error handling in btrfs_init_reloc_root
>   btrfs: do proper error handling in create_reloc_root
>   btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
>   btrfs: change insert_dirty_subvol to return errors
>   btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
>   btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
>   btrfs: do proper error handling in btrfs_update_reloc_root
>   btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
>   btrfs: handle initial btrfs_cow_block error in replace_path
>   btrfs: handle the loop btrfs_cow_block error in replace_path
>   btrfs: handle btrfs_search_slot failure in replace_path
>   btrfs: handle errors in reference count manipulation in replace_path
>   btrfs: handle extent reference errors in do_relocation
>   btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
>   btrfs: remove the extent item sanity checks in relocate_block_group
>   btrfs: do proper error handling in create_reloc_inode
>   btrfs: handle __add_reloc_root failure in btrfs_recover_relocation
>   btrfs: handle __add_reloc_root failure in btrfs_reloc_post_snapshot
>   btrfs: cleanup error handling in prepare_to_merge
>   btrfs: handle extent corruption with select_one_root properly
>   btrfs: do proper error handling in merge_reloc_roots
>   btrfs: check return value of btrfs_commit_transaction in relocation
> 
>  fs/btrfs/ctree.c        |   2 +
>  fs/btrfs/inode.c        |  21 ++-
>  fs/btrfs/ioctl.c        |   6 +-
>  fs/btrfs/relocation.c   | 372 ++++++++++++++++++++++++++++++----------
>  fs/btrfs/transaction.c  |  37 ++--
>  fs/btrfs/tree-checker.c |   5 +
>  fs/btrfs/tree-log.c     |   8 +-
>  fs/btrfs/volumes.c      |   2 +
>  8 files changed, 342 insertions(+), 111 deletions(-)
> 
> -- 
> 2.26.2
> 

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D64B9F6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiBQLyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 06:54:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiBQLyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 06:54:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97195291FA6
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 03:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47085B82175
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 11:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64967C340E8;
        Thu, 17 Feb 2022 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645098824;
        bh=8y+DO6aOB1Mw9m6sSymrW25+iJigt8HwG9yONNqbblk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8OniMj5trkNp2BGTphg3qgLI1EVBHUWJdhaD27zghybxmoWmxXO9pTDrMhQVPMvq
         FvTA/z4Zzj9RBzaz4klid+St5mDFmNQIYZRGfscGMCJwd+o4QVy7U/LNcR+pABXMs1
         YiUH8BUkFbv2TcwWAykObkJlT+c7rXGAUwNJ5SEQzVksrPQ/EyEJzS/WT7m9wppPFA
         NNL8AG+hbvzj7j/RLn3AgARcAfTNVZ7EAmWjKmIOm7xOd0fpx7LAEehiyE3IBX+uqu
         KgEa3PT0/lFDjzCtsfl41bNdvDaq3OeC0fRBxtsylVXjyEwBVXtj22iPfuW05WWXTi
         IHowItab3omlg==
Date:   Thu, 17 Feb 2022 11:53:41 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] btrfs: clean deleted snapshots on mount
Message-ID: <Yg43Rdbh3CNSzzEB@debian9.Home>
References: <cover.1645038250.git.josef@toxicpanda.com>
 <12c9eec886e4544b71389770a069c90fac0401b9.1645038250.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c9eec886e4544b71389770a069c90fac0401b9.1645038250.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 16, 2022 at 02:06:53PM -0500, Josef Bacik wrote:
> We hit a bug with a recovering relocation on mount for one of our file
> systems in production.  I reproduced this locally by injecting errors
> into snapshot delete with balance running at the same time.  This
> presented as an error while looking up an extent item
> 
> ------------[ cut here ]------------
> WARNING: CPU: 5 PID: 1501 at fs/btrfs/extent-tree.c:866 lookup_inline_extent_backref+0x647/0x680
> CPU: 5 PID: 1501 Comm: btrfs-balance Not tainted 5.16.0-rc8+ #8
> RIP: 0010:lookup_inline_extent_backref+0x647/0x680
> RSP: 0018:ffffae0a023ab960 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000000000
> RBP: ffff943fd2a39b60 R08: 0000000000000000 R09: 0000000000000001
> R10: 0001434088152de0 R11: 0000000000000000 R12: 0000000001d05000
> R13: ffff943fd2a39b60 R14: ffff943fdb96f2a0 R15: ffff9442fc923000
> FS:  0000000000000000(0000) GS:ffff944e9eb40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1157b1fca8 CR3: 000000010f092000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  insert_inline_extent_backref+0x46/0xd0
>  __btrfs_inc_extent_ref.isra.0+0x5f/0x200
>  ? btrfs_merge_delayed_refs+0x164/0x190
>  __btrfs_run_delayed_refs+0x561/0xfa0
>  ? btrfs_search_slot+0x7b4/0xb30
>  ? btrfs_update_root+0x1a9/0x2c0
>  btrfs_run_delayed_refs+0x73/0x1f0
>  ? btrfs_update_root+0x1a9/0x2c0
>  btrfs_commit_transaction+0x50/0xa50
>  ? btrfs_update_reloc_root+0x122/0x220
>  prepare_to_merge+0x29f/0x320
>  relocate_block_group+0x2b8/0x550
>  btrfs_relocate_block_group+0x1a6/0x350
>  btrfs_relocate_chunk+0x27/0xe0
>  btrfs_balance+0x777/0xe60
>  balance_kthread+0x35/0x50
>  ? btrfs_balance+0xe60/0xe60
>  kthread+0x16b/0x190
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x22/0x30
>  </TASK>
> ---[ end trace 7ebc95131709d2b0 ]---
> 
> Normally snapshot deletion and relocation are excluded from running at
> the same time by the fs_info->cleaner_mutex.  However if we had a
> pending balance waiting to get the ->cleaner_mutex, and a snapshot
> deletion was running, and then the box crashed, we would come up in a
> state where we have a half deleted snapshot.
> 
> Again, in the normal case the snapshot deletion needs to complete before
> relocation can start, but in this case relocation could very well start
> before the snapshot deletion completes, as we simply add the root to the
> dead roots list and wait for the next time the cleaner runs to clean up
> the snapshot.
> 
> Fix this by simply cleaning all of the deleted snapshots at mount time,
> before we start messing with relocation.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b6a81c39d5f4..ae8c201070f2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3380,6 +3380,19 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>  	up_read(&fs_info->cleanup_work_sem);
>  
>  	mutex_lock(&fs_info->cleaner_mutex);
> +	/*
> +	 * If there are any DEAD_TREE's we must recover them here, otherwise we
> +	 * could re-start relocation and attempt to relocate blocks that are
> +	 * within a half-deleted snapshot.  Under normal operations we can't run
> +	 * relocation and snapshot delete at the same time, however if we had a
> +	 * snapshot deletion happening prior to this mount there's no way to
> +	 * guarantee that the deletion will start before we re-start (or a user
> +	 * starts) the relocation.  So do the cleanup here in order to prevent
> +	 * problems.
> +	 */
> +	while (btrfs_clean_one_deleted_snapshot(fs_info->tree_root))
> +		cond_resched();

Unless I missed something subtle, this deletes the snapshots synchronously at
mount time, meaning that if we have many and/or large snapshots to delete,
this will slowdown a mount for a long time. And this will happen even if
the above scenario did not happen.

We already have people often report slow mount times (several minutes) likely
due to large extent trees and many block groups, so synchronously deleting
snapshots will make things a lot more slower. Such an increase in mount time
is bad for user experience.

Can we do this asynchronously, still ensuring that balance is not resumed before
all snapshots are deleted? Or at the very least do this synchonously only if we
a have relocation to resume - as this is right now, it will do the snapshot
deletion even if we have no relocation to resume.

Thanks.


> +
>  	ret = btrfs_recover_relocation(fs_info->tree_root);
>  	mutex_unlock(&fs_info->cleaner_mutex);
>  	if (ret < 0) {
> -- 
> 2.26.3
> 

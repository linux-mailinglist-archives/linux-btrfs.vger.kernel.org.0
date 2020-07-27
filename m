Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655F922F3AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 17:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgG0PRy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 11:17:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgG0PRq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 11:17:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07B93AC97;
        Mon, 27 Jul 2020 15:17:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AD42DA701; Mon, 27 Jul 2020 17:17:17 +0200 (CEST)
Date:   Mon, 27 Jul 2020 17:17:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: free fs roots on failed mount
Message-ID: <20200727151717.GO3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200727141947.GN3703@twin.jikos.cz>
 <b8a83f87-752d-98a5-3674-fde808b77af4@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a83f87-752d-98a5-3674-fde808b77af4@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 10:33:32AM -0400, Josef Bacik wrote:
> >> @@ -3441,6 +3440,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >>   	btrfs_put_block_group_cache(fs_info);
> >>   
> >>   fail_tree_roots:
> >> +	btrfs_free_fs_roots(fs_info);
> >>   	free_root_pointers(fs_info, true);
> > 
> > The data reloc tree is freed inside free_root_pointers, that it's also
> > in the radix tree is for convenience so I'd rather fix it inside
> > free_root_pointers and not reorder btrfs_free_fs_roots.
> 
> We can't do that, because free_root_pointers() is called to drop the extent 
> buffers when we're looping through the backup roots.  btrfs_free_fs_roots() is 
> the correct thing to do here, it goes through anything that ended up in the 
> radix tree.  Thanks,

I see, free_root_pointers is used elsewhere. I'm concerned about the
reordeing because there are several functions that are now called after
the roots are freed.

(before)	btrfs_free_fs_roots(fs_info);

		kthread_stop(fs_info->cleaner_kthread);
		filemap_write_and_wait(fs_info->btree_inode->i_mapping);
		btrfs_sysfs_remove_mounted(fs_info);
		btrfs_sysfs_remove_fsid(fs_info->fs_devices);
		btrfs_put_block_group_cache(fs_info);

(after)		btrfs_free_fs_roots(fs_info);

If something called by btrfs_free_fs_roots depends on structures
removed/cleaned by the other functions, eg. btrfs_put_block_group_cache
ti could be a problem.

I haven't spotted anything so far, the functions are called after
failure still during mount, this is easier than shutdown sequence after
a full mount.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FC257A78
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgHaNc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:32:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgHaN3b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:29:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1A64AD04;
        Mon, 31 Aug 2020 13:28:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3384EDA840; Mon, 31 Aug 2020 15:27:36 +0200 (CEST)
Date:   Mon, 31 Aug 2020 15:27:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: Track subdirectories in nlink
Message-ID: <20200831132735.GY28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200827150426.23842-1-nborisov@suse.com>
 <20200827150426.23842-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827150426.23842-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 27, 2020 at 06:04:25PM +0300, Nikolay Borisov wrote:
> This adds the necessary calls to inc_nlink so that the number of
> subdirectories are accounted for in the i_nlink count of a directory. It
> works also for subvolumes and snapshots. Unfortunately the state of the
> on-disk i_nlink is codified in the tree checker so I had to remove the
> check but such filesystems will refuse to mount on older kernels.

Not refusing to mount but it would return EUCLEAN when accessing the
directory and probably turning the fs to read-only, aborting any
running transactions on the way.

> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/inode.c        | 13 +++++++++++--
>  fs/btrfs/ioctl.c        | 10 +++++++---
>  fs/btrfs/transaction.c  | 12 ++++++++----
>  fs/btrfs/tree-checker.c |  7 +------
>  4 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 40fed3285f62..e82eb501fe0d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3635,6 +3635,8 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>  	inode_inc_iversion(&dir->vfs_inode);
>  	inode->vfs_inode.i_ctime = dir->vfs_inode.i_mtime =
>  		dir->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
> +	if (S_ISDIR(inode->vfs_inode.i_mode))
> +		drop_nlink(&dir->vfs_inode);

This should not be unconditional, only decrease links if it's not 1,
similarly the inc_nlink calls.

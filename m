Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8F20F094
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgF3Iec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 04:34:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgF3Iea (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 04:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19FF6AD8D;
        Tue, 30 Jun 2020 08:34:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1804DA790; Tue, 30 Jun 2020 10:34:13 +0200 (CEST)
Date:   Tue, 30 Jun 2020 10:34:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Introduce btrfs_inode_lock()/unlock()
Message-ID: <20200630083413.GS27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
 <20200622162017.21773-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622162017.21773-5-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 22, 2020 at 11:20:13AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_inode_lock/unlock() acquires the inode->i_rwsem depending on the
> flags passed. ilock_flags determines the type of lock to be taken:
> 
> BTRFS_ILOCK_SHARED - for shared locks, for possible parallel DIO
> BTRFS_ILOCK_TRY - for the RWF_NOWAIT sequence
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h |  8 ++++++++
>  fs/btrfs/file.c  | 51 +++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 161533040978..346fea668ca0 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2953,6 +2953,14 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
>  			       struct btrfs_ioctl_balance_args *bargs);
>  
>  /* file.c */
> +
> +/* ilock flags definition */
> +#define BTRFS_ILOCK_SHARED	0x1
> +#define BTRFS_ILOCK_TRY 	0x2
> +
> +int btrfs_inode_lock(struct inode *inode, int ilock_flags);
> +void btrfs_inode_unlock(struct inode *inode, int ilock_flags);

There's another lock in btrfs_inode, and the locking functions added
here have the 'btrfs_' prefix, yet take the VFS inode structure. This is
confusing.

The flags are not btrfs-specific so it could be even a generic VFS
helper but for now I think it can be in fs/btrfs until it's finalized.

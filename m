Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8154207912
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404912AbgFXQ3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:29:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:46870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404911AbgFXQ3E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20426ADC5;
        Wed, 24 Jun 2020 16:29:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 37935DA79B; Wed, 24 Jun 2020 18:19:13 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:19:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Introduce btrfs_inode_lock()/unlock()
Message-ID: <20200624161913.GY27795@twin.jikos.cz>
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

Please use enums and add them to a new file inode.h.

> +int btrfs_inode_lock(struct inode *inode, int ilock_flags);
> +void btrfs_inode_unlock(struct inode *inode, int ilock_flags);
> +
>  int __init btrfs_auto_defrag_init(void);
>  void __cold btrfs_auto_defrag_exit(void);
>  int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index ba7c3b2cf1c5..1a9a0a9e4b3d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -70,6 +70,37 @@ static int __compare_inode_defrag(struct inode_defrag *defrag1,
>  		return 0;
>  }
>  
> +int btrfs_inode_lock(struct inode *inode, int ilock_flags)
> +void btrfs_inode_unlock(struct inode *inode, int ilock_flags)

And the helpers should be in inode.c, not file.c

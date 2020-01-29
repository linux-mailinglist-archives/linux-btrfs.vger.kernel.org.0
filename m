Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7F14D116
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 20:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgA2TPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 14:15:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:36290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgA2TPB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 14:15:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E3817AC22;
        Wed, 29 Jan 2020 19:14:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32A3EDA730; Wed, 29 Jan 2020 20:14:40 +0100 (CET)
Date:   Wed, 29 Jan 2020 20:14:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] btrfs: optimize barrier usage for Rmw atomics
Message-ID: <20200129191439.GN3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Davidlohr Bueso <dave@stgolabs.net>,
        dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20200129180324.24099-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129180324.24099-1-dave@stgolabs.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 29, 2020 at 10:03:24AM -0800, Davidlohr Bueso wrote:
> Use smp_mb__after_atomic() instead of smp_mb() and avoid the
> unnecessary barrier for non LL/SC architectures, such as x86.

So that's a conflicting advice from what we got when discussing wich
barriers to use in 6282675e6708ec78518cc0e9ad1f1f73d7c5c53d and the
memory is still fresh. My first idea was to take the
smp_mb__after_atomic and __before_atomic variants and after discussion
with various people the plain smp_wmb/smp_rmb were suggested and used in
the end.

I can dig the email threads and excerpts from irc conversations, maybe
Nik has them at hand too. We do want to get rid of all unnecessary and
uncommented barriers in btrfs code, so I appreciate your patch.

> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  fs/btrfs/btrfs_inode.h | 2 +-
>  fs/btrfs/file.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 4e12a477d32e..54e0d2ae22cc 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -325,7 +325,7 @@ struct btrfs_dio_private {
>  static inline void btrfs_inode_block_unlocked_dio(struct btrfs_inode *inode)
>  {
>  	set_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);
> -	smp_mb();
> +	smp_mb__after_atomic();

In this case I think we should use the smp_wmb/smp_rmb pattern rather
than the full barrier.

>  }
>  
>  static inline void btrfs_inode_resume_unlocked_dio(struct btrfs_inode *inode)
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a16da274c9aa..ea79ab068079 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2143,7 +2143,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  	}
>  	atomic_inc(&root->log_batch);
>  
> -	smp_mb();
> +	smp_mb__after_atomic();

That's the problem with uncommented barriers that it's not clear what
are they related to. In this case it's not the atomic_inc above that
would justify __after_atomic. The patch that added it is years old so
any change to that barrier would require deeper analysis.

>  	if (btrfs_inode_in_log(BTRFS_I(inode), fs_info->generation) ||
>  	    BTRFS_I(inode)->last_trans <= fs_info->last_trans_committed) {
>  		/*

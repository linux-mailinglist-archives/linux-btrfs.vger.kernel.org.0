Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D112043680F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJUQlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:41:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55444 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:41:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E258218E1;
        Thu, 21 Oct 2021 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634834326;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtkjKCHSlW7ArvSCs/VFKNYvDqlzL8FAk+hb7wmRLqw=;
        b=KTVfDplQloptvCYDVa9B60D1Cqg9I3GQqoAWKzDXWA74hVb/+Q2D6whjh7EQ7YGetMOGVM
        zwsgt9wWXJFcZ+J/j3GmjKuxy4/yrDae/7smkGGBxWX9IlfvH7UowOb5zi+sVmY+Vho6XV
        TTHuckuZISXIjSqQTopJULLT48muIdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634834326;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtkjKCHSlW7ArvSCs/VFKNYvDqlzL8FAk+hb7wmRLqw=;
        b=LB4otqLTaxnVRk7AhHkOtAykAk17SXdWV3dNUvU2kiy2dL5milYovhVKzjNN2Rd7px6xP9
        MksjgmYTZeCz9wBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 03D3BA3B88;
        Thu, 21 Oct 2021 16:38:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50EE2DA7A3; Thu, 21 Oct 2021 18:38:17 +0200 (CEST)
Date:   Thu, 21 Oct 2021 18:38:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] fs: export an inode_update_time helper
Message-ID: <20211021163817.GH20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        hch@lst.de, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1634231213.git.josef@toxicpanda.com>
 <32a87813b58c1ddc3ae4d769cd2b667901621f6a.1634231213.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a87813b58c1ddc3ae4d769cd2b667901621f6a.1634231213.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 01:11:00PM -0400, Josef Bacik wrote:
> If you already have an inode and need to update the time on the inode
> there is no way to do this properly.  Export this helper to allow file
> systems to update time on the inode so the appropriate handler is
> called, either ->update_time or generic_update_time.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I'd like to get ack from Christoph, though it's a simple change it's
still in another subsystem.

> ---
>  fs/inode.c         | 7 ++++---
>  include/linux/fs.h | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index ed0cab8a32db..9abc88d7959c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1782,12 +1782,13 @@ EXPORT_SYMBOL(generic_update_time);
>   * This does the actual work of updating an inodes time or version.  Must have
>   * had called mnt_want_write() before calling this.
>   */
> -static int update_time(struct inode *inode, struct timespec64 *time, int flags)
> +int inode_update_time(struct inode *inode, struct timespec64 *time, int flags)
>  {
>  	if (inode->i_op->update_time)
>  		return inode->i_op->update_time(inode, time, flags);
>  	return generic_update_time(inode, time, flags);
>  }
> +EXPORT_SYMBOL(inode_update_time);
>  
>  /**
>   *	atime_needs_update	-	update the access time
> @@ -1857,7 +1858,7 @@ void touch_atime(const struct path *path)
>  	 * of the fs read only, e.g. subvolumes in Btrfs.
>  	 */
>  	now = current_time(inode);
> -	update_time(inode, &now, S_ATIME);
> +	inode_update_time(inode, &now, S_ATIME);
>  	__mnt_drop_write(mnt);
>  skip_update:
>  	sb_end_write(inode->i_sb);
> @@ -2002,7 +2003,7 @@ int file_update_time(struct file *file)
>  	if (__mnt_want_write_file(file))
>  		return 0;
>  
> -	ret = update_time(inode, &now, sync_it);
> +	ret = inode_update_time(inode, &now, sync_it);
>  	__mnt_drop_write_file(file);
>  
>  	return ret;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e7a633353fd2..20e2fe398ab6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2498,6 +2498,8 @@ enum file_time_flags {
>  
>  extern bool atime_needs_update(const struct path *, struct inode *);
>  extern void touch_atime(const struct path *);
> +extern int inode_update_time(struct inode *inode, struct timespec64 *time,
> +			     int flags);

As was pointed out in the past for similar patches, the 'extern' can be
dropped, so I'll that.

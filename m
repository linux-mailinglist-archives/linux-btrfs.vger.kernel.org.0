Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5721599D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 20:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgBKTfF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 14:35:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:37094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBKTfF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 14:35:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC928AD82;
        Tue, 11 Feb 2020 19:35:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C040DA703; Tue, 11 Feb 2020 20:34:50 +0100 (CET)
Date:   Tue, 11 Feb 2020 20:34:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        wqu@suse.com
Subject: Re: [PATCH] btrfs: ioctl: resize: Only how new size if size changed
Message-ID: <20200211193449.GH2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        wqu@suse.com
References: <20200211135526.22793-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211135526.22793-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 11, 2020 at 10:55:26AM -0300, Marcos Paulo de Souza wrote:
> There is no point to inform the user about "new size" if didn't changed
> at all.

Makes sense. I'll also update the message to show the old and new sizes.

> Signed-off-by: Marcos Paulo de Souza <marcos@mpdesouza.com>
> ---
>  fs/btrfs/ioctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index be5350582955..fa31a8021d24 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1712,9 +1712,6 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>  
>  	new_size = round_down(new_size, fs_info->sectorsize);
>  
> -	btrfs_info_in_rcu(fs_info, "new size for %s is %llu",
> -			  rcu_str_deref(device->name), new_size);
> -
>  	if (new_size > old_size) {
>  		trans = btrfs_start_transaction(root, 0);
>  		if (IS_ERR(trans)) {
> @@ -1727,6 +1724,9 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>  		ret = btrfs_shrink_device(device, new_size);
>  	} /* equal, nothing need to do */
>  
> +	if (ret == 0 && new_size != old_size)
> +		btrfs_info_in_rcu(fs_info, "new size for %s is %llu",
> +			  rcu_str_deref(device->name), new_size);

And maybe also print devid, other messages usually print both.

>  out_free:
>  	kfree(vol_args);
>  out:
> -- 
> 2.24.0

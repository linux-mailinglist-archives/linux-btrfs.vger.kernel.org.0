Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB749287C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 15:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiAROde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 09:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245449AbiAROdU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 09:33:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28C4C06173E
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 06:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAA3B816CE
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 14:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A64C00446;
        Tue, 18 Jan 2022 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642516397;
        bh=vHTR3gy62Q/7LVp6JrlSPzmhlMkK0NanL7ShA27qjJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtSlTHKxGd3voDhADc0M6tJWkPob/CEP0Q28MdMb32/BvUufE3gakdDPxu8C1k8AA
         7HmQ9CrBzJDtDeH+PuYTq/8ghBgM7l3Xna1K9xQjdmo+IcskS1oyf0VpBckK9LB4my
         E51JNg3/TBY0+GaDJWmsQGVVfWx7LEOz9Yi/l2Q6ww3GLr1HizRMlhcf3ZksgbMN2r
         AqtA1a1ZjRGzRwc4Bshu9oOXyhHKfaZ6fVP9ECv6Gd0417D/ycuKYp2loLW/vrvXzm
         uZrv/gzjO7ftcHnL6BMqA+kuztaoqQFNMXF1DWCOAqdydh/9QPJULvcilVoUde/L7m
         XBATh2nfYrEsg==
Date:   Tue, 18 Jan 2022 14:33:14 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anthony Ruhier <aruhier@mailbox.org>
Subject: Re: [PATCH v2] btrfs: defrag: fix the wrong number of defragged
 sectors
Message-ID: <YebPqrBwFcqD3oUe@debian9.Home>
References: <20220118071904.29991-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118071904.29991-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 03:19:04PM +0800, Qu Wenruo wrote:
> [BUG]
> There are users using autodefrag mount option reporting obvious increase
> in IO:
> 
> > If I compare the write average (in total, I don't have it per process)
> > when taking idle periods on the same machine:
> >     Linux 5.16:
> >         without autodefrag: ~ 10KiB/s
> >         with autodefrag: between 1 and 2MiB/s.
> >
> >     Linux 5.15:
> >         with autodefrag:~ 10KiB/s (around the same as without
> > autodefrag on 5.16)
> 
> [CAUSE]
> When autodefrag mount option is enabled, btrfs_defrag_file() will be
> called with @max_sectors = BTRFS_DEFRAG_BATCH (1024) to limit how many
> sectors we can defrag in one try.
> 
> And then use the number of sectors defragged to determine if we need to
> re-defrag.
> 
> But commit b18c3ab2343d ("btrfs: defrag: introduce helper to defrag one
> cluster") uses wrong unit to increase @sectors_defragged, which should
> be in unit of sector, not byte.
> 
> This means, if we have defragged any sector, then @sectors_defragged
> will be >= sectorsize (normally 4096), which is larger than
> BTRFS_DEFRAG_BATCH.
> 
> This makes the @max_sectors check in defrag_one_cluster() to underflow,
> rendering the whole @max_sectors check useless.
> 
> Thus causing way more IO for autodefrag mount options, as now there is
> no limit on how many sectors can really be defragged.
> 
> [FIX]
> Fix the problems by:
> 
> - Use sector as unit when increaseing @sectors_defragged
> 
> - Include @sectors_defragged > @max_sectors case to break the loop
> 
> - Add extra comment on the return value of btrfs_defrag_file()
> 
> Reported-by: Anthony Ruhier <aruhier@mailbox.org>
> Fixes: b18c3ab2343d ("btrfs: defrag: introduce helper to defrag one cluster")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Please, in the future also add a link to the thread reporting the issue.
This makes it much easier to find more details, instead of grepping in
a mailbox or lore for the reporter's name...

Link: https://lore.kernel.org/linux-btrfs/0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org/

> ---
> Changelog:
> v2:
> - Update the commit message to include the root cause of extra IO
> 
> - Keep @sectors_defragged update where it is
>   Since the over-reported @sectors_defragged is not the real reason,
>   keep the patch smaller.
> ---
>  fs/btrfs/ioctl.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6ad2bc2e5af3..2a77273d91fe 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1442,8 +1442,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  	list_for_each_entry(entry, &target_list, list) {
>  		u32 range_len = entry->len;
>  
> -		/* Reached the limit */
> -		if (max_sectors && max_sectors == *sectors_defragged)
> +		/* Reached or beyond the limit */
> +		if (max_sectors && *sectors_defragged >= max_sectors)
>  			break;
>  
>  		if (max_sectors)
> @@ -1465,7 +1465,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  				       extent_thresh, newer_than, do_compress);
>  		if (ret < 0)
>  			break;
> -		*sectors_defragged += range_len;
> +		*sectors_defragged += range_len >>
> +				      inode->root->fs_info->sectorsize_bits;
>  	}
>  out:
>  	list_for_each_entry_safe(entry, tmp, &target_list, list) {
> @@ -1484,6 +1485,9 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>   * @newer_than:	   minimum transid to defrag
>   * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
>   *		   will be defragged.
> + *
> + * Return <0 for error.
> + * Return >=0 for the number of sectors defragged.
>   */
>  int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  		      struct btrfs_ioctl_defrag_range_args *range,
> -- 
> 2.34.1
> 

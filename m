Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7004497F1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfHUPkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:40:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:34488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfHUPkO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:40:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6608ADD9
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 15:40:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BFC67DA7DB; Wed, 21 Aug 2019 17:40:39 +0200 (CEST)
Date:   Wed, 21 Aug 2019 17:40:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/6] btrfs: Simplify extent type check
Message-ID: <20190821154039.GA2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190805144708.5432-1-nborisov@suse.com>
 <20190805144708.5432-6-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805144708.5432-6-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 05:47:07PM +0300, Nikolay Borisov wrote:
> Extent type can only be regular/prealloc/inline. The main branch of the
> 'if' already handles the first two, leaving the 'else' to handle inline.
> Furthermore, tree-checker ensures that leaf items are correct.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/inode.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8e24b7641247..6c3f9f3a7ed1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1502,18 +1502,14 @@ static noinline int run_delalloc_nocow(struct inode *inode,
>  			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
>  				goto out_check;
>  			nocow = true;
> -		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
> -			extent_end = found_key.offset +
> -				btrfs_file_extent_ram_bytes(leaf, fi);
> -			extent_end = ALIGN(extent_end,
> -					   fs_info->sectorsize);
> +		} else {
> +			extent_end = found_key.offset + ram_bytes;
> +			extent_end = ALIGN(extent_end, fs_info->sectorsize);
>  			/* Skip extents outside of our requested range */
>  			if (extent_end <= start) {
>  				path->slots[0]++;
>  				goto next_slot;
>  			}
> -		} else {
> -			BUG();

I am not sure if we should delete this or leave it (with a message what
happened). There are other places that switch value from a known set and
have a catch-all branch.

With your change the 'catch-all' is the inline extent type. It's true
that the checker should not let an unknown type appear in this code,
however I'd rather make it explicit that something is seriously wrong if
there's an unexpected type rather than silently continuing.

The BUG can be turned to actual error handling so we don't need to crash
at least.

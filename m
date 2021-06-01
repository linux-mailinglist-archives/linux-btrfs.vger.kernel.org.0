Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1E3977D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFAQWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 12:22:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQWK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 12:22:10 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 618E821961;
        Tue,  1 Jun 2021 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622564428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tetm2hLQ73RD8WHgGzYc5DIpUBIhB9ij0gvK1/b13Bs=;
        b=C/0fTuJxX3wJ/YuXxHErn68X20q0CC79SrpxFO+5POPrhptpnt8uwjCQz9SoG2VYfL97pu
        P1cGB6GUJ0tmrHr8soAagsabef2EsvFrDEs29q7F5oOIZkHIkvliHEss0ZfNh1yMKQyLS0
        6U+11hStDMDwbSs9iWKtircJFXTmohw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622564428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tetm2hLQ73RD8WHgGzYc5DIpUBIhB9ij0gvK1/b13Bs=;
        b=GGJKM60DSYBMUFzQCZv0WfNbZBAXSaHOoIrb9UNv7GdJOJE/lghMIO59GZGChQRrM0tRAk
        ulqSfuLbUSAtEhAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 30351A3B8B;
        Tue,  1 Jun 2021 16:20:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C5ABBDA704; Tue,  1 Jun 2021 18:17:47 +0200 (CEST)
Date:   Tue, 1 Jun 2021 18:17:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: zoned: limit ordered extent to zoned append
 size
Message-ID: <20210601161747.GH31483@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <cover.1622552385.git.johannes.thumshirn@wdc.com>
 <da3a097233a87541120dbb2a9624841c7a9e3962.1622552385.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da3a097233a87541120dbb2a9624841c7a9e3962.1622552385.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 01, 2021 at 10:02:10PM +0900, Johannes Thumshirn wrote:
> Damien reported a test failure with btrfs/209. The test itself ran fine,
> but the fsck run afterwards reported a corrupted filesystem.
> 
> The filesystem corruption happens because we're splitting an extent and
> then writing the extent twice. We have to split the extent though, because
> we're creating too large extents for a REQ_OP_ZONE_APPEND operation.
> 
> When dumping the extent tree, we can see two EXTENT_ITEMs at the same
> start address but different lengths.
> 
> $ btrfs inspect dump-tree /dev/nullb1 -t extent
> ...
>    item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53
>            refs 1 gen 7 flags DATA
>            extent data backref root FS_TREE objectid 257 offset 786432 count 1
>    item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53
>            refs 1 gen 7 flags DATA
>            extent data backref root FS_TREE objectid 257 offset 786432 count 1
> 
> On a zoned filesystem, limit the size of an ordered extent to the maximum
> size that can be issued as a single REQ_OP_ZONE_APPEND operation.
> 
> Note: This patch breaks fstests btrfs/079, as it increases the number of
> on-disk extents from 80 to 83 per 10M write.
> 
> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ctree.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 5d0398528a7a..6fbafaaebda0 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1373,7 +1373,10 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  
>  static inline u64 btrfs_get_max_extent_size(struct btrfs_fs_info *fs_info)
>  {
> -	return BTRFS_MAX_EXTENT_SIZE;
> +	if (!fs_info || !fs_info->max_zone_append_size)
> +		return BTRFS_MAX_EXTENT_SIZE;
> +	return min_t(u64, BTRFS_MAX_EXTENT_SIZE,
> +		     ALIGN_DOWN(fs_info->max_zone_append_size, PAGE_SIZE));

Should this be set only once in btrfs_check_zoned_mode ?

>  }
>  
>  /*
> -- 
> 2.31.1
> 

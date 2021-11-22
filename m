Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFF84594B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhKVScQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 13:32:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50978 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhKVScO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 13:32:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B2D11FD58;
        Mon, 22 Nov 2021 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637605747;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Tg/k08OKFFh+CsJQ8nZKuF31qrOw76rSOvkaEutfd8=;
        b=UmRwRTCeJNS1t5AZCh4JR9XSULrgtXkhslC0JPz0fRfWkTabh5NDlo/YELK/3Pzo4QMilS
        LQDUoDVfilGxg9uWmijblvHUgrjH5XV7IG44TBPvtkjgwe2Tnczf4Su1x/9P6ZfD0sJINX
        o4Zug/56DNGIogpl0Cklr4jrs16l7Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637605747;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Tg/k08OKFFh+CsJQ8nZKuF31qrOw76rSOvkaEutfd8=;
        b=AdKlwKTd1vadATS13/YdQcOosQ9vNkXQGYP/gOdKFhswC5rId2bkztP2hJBqK3r6AWvZLX
        K6g/ApV3JTJynbAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 34B50A3B83;
        Mon, 22 Nov 2021 18:29:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BE89DA735; Mon, 22 Nov 2021 19:29:00 +0100 (CET)
Date:   Mon, 22 Nov 2021 19:29:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't bother stripe length if the profile is not
 stripe based
Message-ID: <20211122182900.GO28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211119061933.13560-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119061933.13560-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 19, 2021 at 02:19:33PM +0800, Qu Wenruo wrote:
> [BUG]
> When debugging calc_bio_boundaries(), I found that even for RAID1
> metadata, we're following stripe length to calculate stripe boundary.
> 
>  # mkfs.btrfs -m raid1 -d raid1 /dev/test/scratch[12]
>  # mount /dev/test/scratch /mnt/btrfs
>  # xfs_io -f -c "pwrite 0 64K" /mnt/btrfs/file
>  # umount
> 
> Above very basic operations will make calc_bio_boundaries() to report
> the following result:
> 
>  submit_extent_page: r/i=1/1 file_offset=22036480 len_to_stripe_boundary=49152
>  submit_extent_page: r/i=1/1 file_offset=30474240 len_to_stripe_boundary=65536
>  ...
>  submit_extent_page: r/i=1/1 file_offset=30523392 len_to_stripe_boundary=16384
>  submit_extent_page: r/i=1/1 file_offset=30457856 len_to_stripe_boundary=16384
>  submit_extent_page: r/i=5/257 file_offset=0 len_to_stripe_boundary=65536
>  submit_extent_page: r/i=5/257 file_offset=65536 len_to_stripe_boundary=65536
>  submit_extent_page: r/i=1/1 file_offset=30490624 len_to_stripe_boundary=49152
>  submit_extent_page: r/i=1/1 file_offset=30507008 len_to_stripe_boundary=32768
> 
> Where "r/i" is the rootid and inode, 1/1 means they metadata.
> The remaining names match the member used in kernel.
> 
> Even all data/metadata are using raid1, we're still following stripe
> length.
> 
> [CAUSE]
> This behavior is caused by a wrong condition in btrfs_get_io_geometry():
> 
> 	if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> 		/* Fill using stripe_len */
> 		len = min_t(u64, em->len - offset, max_len);
> 	} else {
> 		len = em->len - offset;
> 	}
> 
> This means, only for SINGLE we will not follow stripe_len.
> 
> However for profiles like RAID1*, DUP, they don't need to bother
> stripe_len.
> 
> This can lead to unnecessry bio split for RAID1*/DUP profiles, and can
> even be a blockage for future zoned RAID support.
> 
> [FIX]
> Introduce one single-use macro, BTRFS_BLOCK_GROUP_STRIPE_MASK, and
> change the condition to only calculate the length using stripe length
> for stripe based profiles.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> @@ -6296,6 +6296,10 @@ static bool need_full_stripe(enum btrfs_map_op op)
>  	return (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS);
>  }
>  
> +
> +#define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |\
> +					 BTRFS_BLOCK_GROUP_RAID10 |\
> +					 BTRFS_BLOCK_GROUP_RAID56_MASK)

I've moved the defintion to the beginning of the file, even if it's for
a single use, such definitions should go to somewhere we can find them
easily and not 6000 lines down the file. The nature of the bit mask is
generic and we could need to use it again for other purposes.

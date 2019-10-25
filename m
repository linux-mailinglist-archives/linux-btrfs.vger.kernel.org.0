Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23B0E4AF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393490AbfJYMYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 08:24:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43991 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391200AbfJYMX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 08:23:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id a194so1509725qkg.10
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IeqG4Q35AsY5u3KJBX1y/MlCxEdTk0iBkibjhmNR4uI=;
        b=U/TMWBSjH2uE3GoCeqZPLKewkAzrpdvcek/JBaE7u3JBJ+qTWX76qSztFpr4Y9DN/Y
         QIHDtRH40czgu4eds/dstJUvGGNy2VVsx8xek4NtQF4bV+8JFKM4fZsIfyByp8j9BIl9
         o3hHZ64GLcv/B4YELWzD00+3Bw7W4C4nGZHbZGRc4RCraM7bpE8sWp1OVrXSqKN9IJ96
         yowuqRkwLY49fS4pdNW6z60IZ/F8CkfKUrwEZgpbG0p09snw1PB81XSfFeEICTX/tvRJ
         SWaqu2Lt7bd9MsMeeTBYYItA7hlX+1KAYT77mC1HpcSQtbIT70CU3kJMajpkIK0vTqyq
         R6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IeqG4Q35AsY5u3KJBX1y/MlCxEdTk0iBkibjhmNR4uI=;
        b=N6nU9XfJdIaUJR9LJ28jyulHnBVOeWwTvxOcdn5h2PVeBT2vkXuzwj0WeCmx1jOxZ3
         Q4+qRX0ZeVbQ73muDoVz24UfigPDxZr9cY1ahYycdUDq9EmT6Do9fTQfrZLb/2E9IlSJ
         +9yE1GwBp6sIb+KDLfEpBBGyl0bpPkatE8pM2pNyN6FE8H044C5HqmW6OyhKvSXvdIkq
         o0gqyd6Lmkc9vYOeAoydsMD70g7eat4qka5WWgAKnTKQc//S9XDNWb6wkqi/I3ixI4qy
         ZxpKogWCTPWSi4Wv3P2ZAez1EQD8cHo0suV0dWC8yKeM4yzi7K/C9tXrayyvCBz4hj1B
         TlVg==
X-Gm-Message-State: APjAAAUu08unAddLolngq7pVAt8zgkt/tWxFJVyW97gdvwe73OIgTBAK
        2Hv1BeBw2ll6/k2bj4IPH3bW0xrJhlneDA==
X-Google-Smtp-Source: APXvYqxg8LI38CSE1BBl80S+Rpf4m5fPgumOdQQzhuH+hdRfNvN43LUsu2aIfXR9xCecy5NUw12xNA==
X-Received: by 2002:ae9:ea05:: with SMTP id f5mr2709558qkg.370.1572006236658;
        Fri, 25 Oct 2019 05:23:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fad0])
        by smtp.gmail.com with ESMTPSA id j28sm1220552qkl.1.2019.10.25.05.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:23:55 -0700 (PDT)
Date:   Fri, 25 Oct 2019 08:23:54 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 2/2] btrfs: extent-tree: Ensure we trim ranges across
 block group boundary
Message-ID: <20191025122353.uh63eb7ub77dyhyp@MacBook-Pro-91.local>
References: <20191025085956.48352-1-wqu@suse.com>
 <20191025085956.48352-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025085956.48352-3-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 04:59:56PM +0800, Qu Wenruo wrote:
> [BUG]
> When deleting large files (which cross block group boundary) with discard
> mount option, we find some btrfs_discard_extent() calls only trimmed part
> of its space, not the whole range:
> 
>   btrfs_discard_extent: type=0x1 start=19626196992 len=2144530432 trimmed=1073741824 ratio=50%
> 
> type:		bbio->map_type, in above case, it's SINGLE DATA.
> start:		Logical address of this trim
> len:		Logical length of this trim
> trimmed:	Physically trimmed bytes
> ratio:		trimmed / len
> 
> Thus leading some unused space not discarded.
> 
> [CAUSE]
> When discard mount option is specified, after a transaction is fully
> committed (super block written to disk), we begin to cleanup pinned
> extents in the following call chain:
> 
> btrfs_commit_transaction()
> |- btrfs_finish_extent_commit()
>    |- find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY);
>    |- btrfs_discard_extent()
> 
> However pinned extents are recorded in an extent_io_tree, which can
> merge adjacent extent states.
> 
> When a large file get deleted and it has adjacent file extents across
> block group boundary, we will get a large merged range, like this:
> 
>       |<---    BG1    --->|<---      BG2     --->|
>       |//////|<--   Range to discard   --->|/////|
> 
> To discard that range, we have the following calls:
> btrfs_discard_extent()
> |- btrfs_map_block()
> |  Returned bbio will end at BG1's end. As btrfs_map_block()
> |  never returns result across block group boundary.
> |- btrfs_issuse_discard()
>    Issue discard for each stripe.
> 
> So we will only discard the range in BG1, not the remaining part in BG2.
> 
> Furthermore, this bug is not that reliably observed, for above case, if
> there is no other extent in BG2, BG2 will be empty and btrfs will trim
> all space of BG2, covering up the bug.
> 
> [FIX]
> - Allow __btrfs_map_block_for_discard() to modify @length parameter
>   btrfs_map_block() uses its @length paramter to notify the caller how
>   many bytes are mapped in current call.
>   With __btrfs_map_block_for_discard() also modifing the @length,
>   btrfs_discard_extent() now understands when to do extra trim.
> 
> - Call btrfs_map_block() in a loop until we hit the range end
>   Since we now know how many bytes are mapped each time, we can iterate
>   through each block group boundary and issue correct trim for each
>   range.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 41 +++++++++++++++++++++++++++++++----------
>  fs/btrfs/volumes.c     |  6 ++++--
>  2 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 49cb26fa7c63..ff2838bd677d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1306,8 +1306,10 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>  int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  			 u64 num_bytes, u64 *actual_bytes)
>  {
> -	int ret;
> +	int ret = 0;
>  	u64 discarded_bytes = 0;
> +	u64 end = bytenr + num_bytes;
> +	u64 cur = bytenr;
>  	struct btrfs_bio *bbio = NULL;
>  
>  
> @@ -1316,15 +1318,23 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  	 * associated to its stripes that don't go away while we are discarding.
>  	 */
>  	btrfs_bio_counter_inc_blocked(fs_info);
> -	/* Tell the block device(s) that the sectors can be discarded */
> -	ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, bytenr, &num_bytes,
> -			      &bbio, 0);
> -	/* Error condition is -ENOMEM */
> -	if (!ret) {
> -		struct btrfs_bio_stripe *stripe = bbio->stripes;
> +	while (cur < end) {
> +		struct btrfs_bio_stripe *stripe;
>  		int i;
>  
> +		num_bytes = end - cur;
> +		/* Tell the block device(s) that the sectors can be discarded */
> +		ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, cur,
> +				      &num_bytes, &bbio, 0);
> +		/*
> +		 * Error can be -ENOMEM, -ENOENT (no such chunk mapping) or
> +		 * -EOPNOTSUPP. For any such error, @num_bytes is not updated,
> +		 * thus we can't continue anyway.
> +		 */
> +		if (ret < 0)
> +			goto out;
>  
> +		stripe = bbio->stripes;
>  		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
>  			u64 bytes;
>  			struct request_queue *req_q;
> @@ -1341,10 +1351,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  						  stripe->physical,
>  						  stripe->length,
>  						  &bytes);
> -			if (!ret)
> +			if (!ret) {
>  				discarded_bytes += bytes;
> -			else if (ret != -EOPNOTSUPP)
> -				break; /* Logic errors or -ENOMEM, or -EIO but I don't know how that could happen JDM */
> +			} else if (ret != -EOPNOTSUPP) {
> +				/*
> +				 * Logic errors or -ENOMEM, or -EIO but I don't
> +				 * know how that could happen JDM
> +				 *
> +				 * Ans since there are two loops, explicitly

Hate for there to be a v5 at this point, but it should be "and".  Anyway

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

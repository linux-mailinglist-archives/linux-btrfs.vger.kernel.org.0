Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45E43C2995
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhGITbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 15:31:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGITbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 15:31:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 78D0A2241C;
        Fri,  9 Jul 2021 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625858936;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trZl/8V05/jBvrgbhQQqtSnMtOShMRLRs2w3HftjDyg=;
        b=rSAxo73wmXUftcUlE/dYiaCYPUEXKAG3m5cmmX4sUxCHPHWtj/ucOQeufnlac6JRXci7N4
        bB6bRykzeZZi5j0sf72ymVr1qYqMMghX7FvX/YOc/9Omse71AC5eEkaRocApmMYtetL7YM
        p4f+xLAeEzkho5OyUZkAcz9kKFgQ9tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625858936;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trZl/8V05/jBvrgbhQQqtSnMtOShMRLRs2w3HftjDyg=;
        b=x2vqs4utlL36Wm1ckLaI9lNXDTpMbPVg1itO2VeoAsDDnxdYbGEh5GUqFMro6TbAYGhQA8
        7FGULJLWEtqvumAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 71887A3B9B;
        Fri,  9 Jul 2021 19:28:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 995CCDA8E2; Fri,  9 Jul 2021 21:26:21 +0200 (CEST)
Date:   Fri, 9 Jul 2021 21:26:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 03/15] btrfs: rework btrfs_decompress_buf2page()
Message-ID: <20210709192621.GI2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705020110.89358-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 05, 2021 at 10:00:58AM +0800, Qu Wenruo wrote:
> +int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
> +			      struct compressed_bio *cb, u32 decompressed)
>  {
> -	unsigned long buf_offset;
> -	unsigned long current_buf_start;
> -	unsigned long start_byte;
> -	unsigned long prev_start_byte;
> -	unsigned long working_bytes = total_out - buf_start;
> -	unsigned long bytes;
> -	struct bio_vec bvec = bio_iter_iovec(bio, bio->bi_iter);
> -
> -	/*
> -	 * start byte is the first byte of the page we're currently
> -	 * copying into relative to the start of the compressed data.
> -	 */
> -	start_byte = page_offset(bvec.bv_page) - disk_start;
> -
> -	/* we haven't yet hit data corresponding to this page */
> -	if (total_out <= start_byte)
> -		return 1;
> +	struct bio *orig_bio = cb->orig_bio;
> +	u32 cur_offset;	/* Offset inside the full decompressed extent */
>  
> -	/*
> -	 * the start of the data we care about is offset into
> -	 * the middle of our working buffer
> -	 */
> -	if (total_out > start_byte && buf_start < start_byte) {
> -		buf_offset = start_byte - buf_start;
> -		working_bytes -= buf_offset;
> -	} else {
> -		buf_offset = 0;
> -	}
> -	current_buf_start = buf_start;
> +	cur_offset = decompressed;
> +	/* The main loop to do the copy */
> +	while (cur_offset < decompressed + buf_len) {
> +		struct bio_vec bvec = bio_iter_iovec(orig_bio,
> +						     orig_bio->bi_iter);
> +		size_t copy_len;
> +		u32 copy_start;
> +		u32 bvec_offset; /* Offset inside the full decompressed extent */
>  
> -	/* copy bytes from the working buffer into the pages */
> -	while (working_bytes > 0) {
> -		bytes = min_t(unsigned long, bvec.bv_len,
> -				PAGE_SIZE - (buf_offset % PAGE_SIZE));
> -		bytes = min(bytes, working_bytes);
> +		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);

Looks like a duplicate initialization, the same is in the delcaration,
I'll keep the first one as it's a simple struct init.

>  
> -		memcpy_to_page(bvec.bv_page, bvec.bv_offset, buf + buf_offset,
> -			       bytes);
> -		flush_dcache_page(bvec.bv_page);
> +		/*
> +		 * cb->start may underflow, but minusing that value can still
> +		 * give us correct offset inside the full decompressed extent.
> +		 */
> +		bvec_offset = page_offset(bvec.bv_page) + bvec.bv_offset
> +			      - cb->start;

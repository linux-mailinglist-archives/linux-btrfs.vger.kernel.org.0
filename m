Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485E032849F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhCAQjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 11:39:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:33208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhCAQfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 11:35:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3D63AF19;
        Mon,  1 Mar 2021 16:35:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 091C3DA7AA; Mon,  1 Mar 2021 17:33:09 +0100 (CET)
Date:   Mon, 1 Mar 2021 17:33:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/12] btrfs: extent_io: introduce
 end_bio_subpage_eb_writepage() function
Message-ID: <20210301163309.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210222063357.92930-1-wqu@suse.com>
 <20210222063357.92930-10-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222063357.92930-10-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 02:33:54PM +0800, Qu Wenruo wrote:
> +static void end_bio_subpage_eb_writepage(struct btrfs_fs_info *fs_info,
> +					 struct bio *bio)
> +{
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	ASSERT(!bio_flagged(bio, BIO_CLONED));
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		struct page *page = bvec->bv_page;
> +		u64 bvec_start = page_offset(page) + bvec->bv_offset;
> +		u64 bvec_end = bvec_start + bvec->bv_len - 1;
> +		u64 cur_bytenr = bvec_start;
> +
> +		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
> +
> +		/* Iterate through all extent buffers in the range */
> +		while (cur_bytenr <= bvec_end) {
> +			struct extent_buffer *eb;
> +			int done;
> +
> +			/*
> +			 * Here we can't use find_extent_buffer(), as it may
> +			 * try to lock eb->refs_lock, which is not safe in endio 

Please make sure you don't leave whitespace damage in newly added code,
'git am' then fails to apply the patches and I need to fix it manually.

warning: 1 line adds whitespace errors.
*
* You have some suspicious patch lines:
*
* In fs/btrfs/extent_io.c
* trailing whitespace (line 4090)
fs/btrfs/extent_io.c:4090:                       * try to lock eb->refs_lock, which is not safe in endio

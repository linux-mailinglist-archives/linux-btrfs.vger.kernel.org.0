Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2C2B9CAB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKSVK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 16:10:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:34732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgKSVK0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 16:10:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21588ABDE;
        Thu, 19 Nov 2020 21:10:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8F88DA701; Thu, 19 Nov 2020 22:08:38 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:08:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 03/24] btrfs: extent_io: replace
 extent_start/extent_len with better structure for end_bio_extent_readpage()
Message-ID: <20201119210838.GL20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:28PM +0800, Qu Wenruo wrote:
> In end_bio_extent_readpage() we had a strange dance around
> extent_start/extent_len.
> 
> Hides behind the strange dance is, it's just calling
> endio_readpage_release_extent() on each bvec range.
> 
> Here is an example to explain the original work flow:
>   Bio is for inode 257, containing 2 pages, for range [1M, 1M+8K)
> 
>   end_bio_extent_extent_readpage() entered
>   |- extent_start = 0;
>   |- extent_end = 0;
>   |- bio_for_each_segment_all() {
>   |  |- /* Got the 1st bvec */
>   |  |- start = SZ_1M;
>   |  |- end = SZ_1M + SZ_4K - 1;
>   |  |- update = 1;
>   |  |- if (extent_len == 0) {
>   |  |  |- extent_start = start; /* SZ_1M */
>   |  |  |- extent_len = end + 1 - start; /* SZ_1M */
>   |  |  }
>   |  |
>   |  |- /* Got the 2nd bvec */
>   |  |- start = SZ_1M + 4K;
>   |  |- end = SZ_1M + 4K - 1;
>   |  |- update = 1;
>   |  |- if (extent_start + extent_len == start) {
>   |  |  |- extent_len += end + 1 - start; /* SZ_8K */
>   |  |  }
>   |  } /* All bio vec iterated */
>   |
>   |- if (extent_len) {
>      |- endio_readpage_release_extent(tree, extent_start, extent_len,
> 				      update);
> 	/* extent_start == SZ_1M, extent_len == SZ_8K, uptodate = 1 */
> 
> As the above flow shows, the existing code in end_bio_extent_readpage()
> is just accumulate extent_start/extent_len, and when the contiguous range
> breaks, call endio_readpage_release_extent() for the range.
> 
> However current behavior has something not really considered:
> - The inode can change
>   For bio, their pages don't need to have contig page_offset.
>   This means, even pages from different inode can be packed into one
>   bio.
> 
> - Bvec cross page boundary
>   There is a feature called multi-page bvec, where bvec->bv_len can go
>   beyond bvec->bv_page boundary.
> 
> - Poor readability
> 
> This patch will address the problem by:
> - Introduce a proper structure, processed_extent, to record processed
>   extent range
> - Integrate inode/start/end/uptodate check into
>   endio_readpage_release_extent()
> - Add more comment on each step.
>   This should greatly improve the readability, now in
>   end_bio_extent_readpage() there are only two
>   endio_readpage_release_extent() calls.
> 
> - Add inode contig check
>   Now we also ensure the inode is the same before checking the range
>   contig.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next.

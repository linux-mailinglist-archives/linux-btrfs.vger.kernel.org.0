Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95982B9CAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 22:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgKSVKK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 16:10:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:34392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgKSVKK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 16:10:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74581ABDE;
        Thu, 19 Nov 2020 21:10:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3304ADA701; Thu, 19 Nov 2020 22:08:22 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:08:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 02/24] btrfs: extent-io-tests: remove invalid tests
Message-ID: <20201119210822.GK20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:27PM +0800, Qu Wenruo wrote:
> In extent-io-test, there are two invalid tests:
> - Invalid nodesize for test_eb_bitmaps()
>   Instead of the sectorsize and nodesize combination passed in, we're
>   always using hand-crafted nodesize, e.g:
> 
> 	len = (sectorsize < BTRFS_MAX_METADATA_BLOCKSIZE)
> 		? sectorsize * 4 : sectorsize;
> 
>   In above case, if we have 32K page size, then we will get a length of
>   128K, which is beyond max node size, and obviously invalid.
> 
>   Thankfully most machines are either 4K or 64K page size, thus we
>   haven't yet hit such case.
> 
> - Invalid extent buffer bytenr
>   For 64K page size, the only combination we're going to test is
>   sectorsize = nodesize = 64K.
>   However in that case, we will try to test an eb which bytenr is not
>   sectorsize aligned:
> 
> 	/* Do it over again with an extent buffer which isn't page-aligned. */
> 	eb = __alloc_dummy_extent_buffer(fs_info, nodesize / 2, len);
> 
>   Sector alignedment is a hard requirement for any sector size.
>   The only exception is superblock. But anything else should follow
>   sector size alignment.
> 
>   This is definitely an invalid test case.
> 
> This patch will fix both problems by:
> - Honor the sectorsize/nodesize combination
>   Now we won't bother to hand-craft a strange length and use it as
>   nodesize.
> 
> - Use sectorsize as the 2nd run extent buffer start
>   This would test the case where extent buffer is aligned to sectorsize
>   but not always aligned to nodesize.
> 
> Please note that, later subpage related cleanup will reduce
> extent_buffer::pages[] to exact what we need, making the sector
> unaligned extent buffer operations to cause problem.
> 
> Since only extent_io self tests utilize this invalid feature, this
> patch is required for all later cleanup/refactors.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next.

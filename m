Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1574B39F87A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhFHOLU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 10:11:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhFHOLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 10:11:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2F5EE219C2;
        Tue,  8 Jun 2021 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623161366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znTv/BVwq1EJhMLoWnEo9JXghbV09mKp72OZ7c4B3t8=;
        b=Df9lAwvx+A1LTZCP8jRs3QlwwiTyIcIr9cnJdWj3ftMK5SNH+/m8nIyIh9MFKKVkwsCMuq
        AxP0Nnx2pmiOUiBGPuueY6lRtDplRf9aspZS+83ZC9FdNwqgnUZZ4BSGEbwknptuvWiIOG
        VoljwDaCIyMPNEbg+02wReOawl0DbZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623161366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znTv/BVwq1EJhMLoWnEo9JXghbV09mKp72OZ7c4B3t8=;
        b=qJFWu+OLZZSryEFYTFPVoHygQ+HyW8TRz+OYl71BGrnHc9Gbfd7kkhaEkcksKHHFXqo8Gd
        n9CzsHd4hJgHA4BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 26860A3B88;
        Tue,  8 Jun 2021 14:09:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 253EEDAF1B; Tue,  8 Jun 2021 16:06:41 +0200 (CEST)
Date:   Tue, 8 Jun 2021 16:06:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix embarrassing bugs in find_next_dirty_byte()
Message-ID: <20210608140641.GP31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210605001428.26072-1-wqu@suse.com>
 <20210607170830.GF31483@twin.jikos.cz>
 <347fa13d-6a8e-9e4f-a06e-b7133fc446c7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347fa13d-6a8e-9e4f-a06e-b7133fc446c7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 08, 2021 at 10:02:34AM +0800, Qu Wenruo wrote:
> >> -		return;
> >> -	}
> >> -	ASSERT(first_bit_zero > 0 &&
> >> -	       first_bit_zero <= BTRFS_SUBPAGE_BITMAP_SIZE);
> >> -	*end = page_offset(page) + first_bit_zero * fs_info->sectorsize;
> >> -	ASSERT(*end > *start);
> >> +	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bit,
> >> +			       BTRFS_SUBPAGE_BITMAP_SIZE);
> >> +	*start = page_offset(page) + range_start_bit * fs_info->sectorsize;
> >> +	*end = page_offset(page) + range_end_bit * fs_info->sectorsize;
> >
> > Makes sense. We want the u16 for the storage but the more complex
> > calculations could be done using the bitmap helpers, and converted back
> > eventually.
> >
> Talking about bitmap, I think it's also a good time to consider the
> future expansion.
> 
> - Extra sectorsize/page size support
>    We want to support things like 16K page size, in that case we
>    only needs 4 bits for each bitmap.
> 
> - Better support for nodesize >= page size case
>    If we can ensure all of our metadata are nodesize aligned,
>    we can fall back to existing metadata handler.
>    This reduces memory usage, and can support 16K page size better.
> 
>    But the cost is, if chunk is not properly aligned, we will reject
>    certain extent buffer read.
> 
> My current plan is to make btrfs_subpage bitmaps to be fitted into one
> longer bitmap.
> And in btrfs_info, introduce some structure to record which bit range
> are for each subpage bitmap, the range will be calculated at mount time
> using both sectorsize and page size.
> 
> E.g. For 4K sectorsize, 16K page size, uptodate bitmap will be at bits
> range [0, 4), error bitmap will be at bits [4, 8).
> 
> Then we can make all subpage bitmap operations using real bitmap operators.

Great, I had the same idea to merge all bitmaps into one value. For
clarity the first implementation has it all separated as we don't want
to hunt bugs in the bit manipulations.

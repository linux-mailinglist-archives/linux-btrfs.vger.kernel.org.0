Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352473F4EED
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHWREL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 13:04:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48782 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWREK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 13:04:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 105E51FFCA;
        Mon, 23 Aug 2021 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629738206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCpimD5ASdt5PBSAEdWTmaLL7nseDQxkfEOoH5MtdmA=;
        b=va2+OHFM8HO06iSQRiI1oc7L+CRUBefg4zSGwg7sBNz3wfjeqri7eHm6wZRZNe63WY2UZH
        0PClgAYYKUU5y2ukVqmmjbONkWRxNwOx2vAa6dmvV3TtBY6ODU7D4UOkAt/GusnXnt9xA4
        g94+VgzlmMECGlKFaYIiJBxEdbHd6sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629738206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCpimD5ASdt5PBSAEdWTmaLL7nseDQxkfEOoH5MtdmA=;
        b=U1UetmONa7ztV3LwLXt1e7xx3pLyw2rd1gnbTf19jNKfamTzOGH596H0f3ZguzSSCW4sHR
        RDSOm4ZGoEIMpxDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 09264A3BB0;
        Mon, 23 Aug 2021 17:03:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82880DA725; Mon, 23 Aug 2021 19:00:26 +0200 (CEST)
Date:   Mon, 23 Aug 2021 19:00:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
Message-ID: <20210823170026.GI5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-5-wqu@suse.com>
 <9599db38-cff8-fac5-c6db-ec1d53beeed3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9599db38-cff8-fac5-c6db-ec1d53beeed3@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 04:43:56PM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.08.21 г. 12:38, Qu Wenruo wrote:
> > Currently we use u16 bitmap to make 4k sectorsize work for 64K page
> > size.
> > 
> > But this u16 bitmap is not large enough to contain larger page size like
> > 128K, nor is space efficient for 16K page size.
> > 
> > To handle both cases, here we pack all subpage bitmaps into a larger
> > bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
> > subpage usage.
> > 
> > Each sub-bitmap will has its start bit number recorded in
> > btrfs_subpage_info::*_start, and its bitmap length will be recorded in
> > btrfs_subpage_info::bitmap_nr_bits.
> > 
> > All subpage bitmap operations will be converted from using direct u16
> > operations to bitmap operations, with above *_start calculated.
> > 
> > For 64K page size with 4K sectorsize, this should not cause much
> > difference.
> > 
> > While for 16K page size, we will only need 1 unsigned long (u32) to
> > store all the bitmaps, which saves quite some space.
> > 
> > Furthermore, this allows us to support larger page size like 128K and
> > 258K.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> <snip>
> 
> > +#define GANG_LOOKUP_SIZE	16
> >  static struct extent_buffer *get_next_extent_buffer(
> >  		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
> >  {
> > -	struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZE];
> > +	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> >  	struct extent_buffer *found = NULL;
> >  	u64 page_start = page_offset(page);
> > -	int ret;
> > -	int i;
> > +	u64 cur = page_start;
> >  
> >  	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
> > -	ASSERT(PAGE_SIZE / fs_info->nodesize <= BTRFS_SUBPAGE_BITMAP_SIZE);
> >  	lockdep_assert_held(&fs_info->buffer_lock);
> >  
> > -	ret = radix_tree_gang_lookup(&fs_info->buffer_radix, (void **)gang,
> > -			bytenr >> fs_info->sectorsize_bits,
> > -			PAGE_SIZE / fs_info->nodesize);
> > -	for (i = 0; i < ret; i++) {
> > -		/* Already beyond page end */
> > -		if (gang[i]->start >= page_start + PAGE_SIZE)
> > -			break;
> > -		/* Found one */
> > -		if (gang[i]->start >= bytenr) {
> > -			found = gang[i];
> > -			break;
> > +	while (cur < page_start + PAGE_SIZE) {
> > +		int ret;
> > +		int i;
> > +
> > +		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> > +				(void **)gang, cur >> fs_info->sectorsize_bits,
> > +				min_t(unsigned int, GANG_LOOKUP_SIZE,
> > +				      PAGE_SIZE / fs_info->nodesize));
> > +		if (ret == 0)
> > +			goto out;
> > +		for (i = 0; i < ret; i++) {
> > +			/* Already beyond page end */
> > +			if (gang[i]->start >= page_start + PAGE_SIZE)
> 
> nit: this could be rewritten as (in_range(gang[i]->start, page_start,
> PAGE_SIZE)

Yes it could though I won't do that myself as it touches the logic and
code flow so I don't count it as trivial fixups I usually do. I'll fold
a fixup if you or Qu send it.

Return-Path: <linux-btrfs+bounces-19176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B698C71A29
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 02:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 018BF28C17
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59187238159;
	Thu, 20 Nov 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="L7KQsxCx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEpTFRgW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD8233D88
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600413; cv=none; b=eD1SUUUo/lju4l+pJpaWxIZqKOfYtZzkpHMEAuglkV/ivKep71Fa9uzz9x1tDwlu9zUX+0WYMYZM/njWAVl55SXAGZSGtNYHwVbfbUSfxpW+0OJhLGVI5QOxWV4MXH6XI9qL4FA8Gm3Mr9BDxYzPfGjV72QX13rssG/OViVfOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600413; c=relaxed/simple;
	bh=imuqxPpub0GajS3GYdTGeCm621rcrqGse5jwOa5C0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcH95UwSVMZUolqI+Pxv21uKk/b2fX6fO9TcBeZ0vSVzjztHi+XsbXZVnJBqOGA/7hK/bCZJuuSkMHqh7HrwbYk0VXvkHkCbx4LzwE9N7artMiUNYVuU8VfRn7JiUEdhXHUX5c+tZW7BZ6xpagxSuRfHIpdELfmcCBKnO9s1LZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=L7KQsxCx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEpTFRgW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4388A14001EE;
	Wed, 19 Nov 2025 20:00:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 20:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763600410; x=1763686810; bh=2wuS08TUgo
	aJMzj8o66nqOL09H64rg+V2QuStVwL98M=; b=L7KQsxCxDRwk5P2K2h68moesVz
	zOQcbDC736rLhbN4uoIONxjHDoWoYc4hNarasRUosSWwp/i+NVkO+zfhNFgZEfHc
	vyie0EjSA7VP3ECQmuOYrI2uftPav3njEfMhM+9cE8iU25Kj3pwjDGbZuQtyM90e
	QfSxqFpQTos1J/LHWz1aWWR7POtpFol59+Cnn17Jlr2iJcembJptHI+FcBlrbCwi
	pJT7FzgPxz09KK5pU/f1ocmL8eTrYE4EXBQqfGXemsmdy9BSMjlY2b13zADfGj51
	KUx2C6Wb/MuIQsh9giqELzQyKwAKT9yXt2wXAaJmCYby7l9JLQmmHCCldOxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763600410; x=1763686810; bh=2wuS08TUgoaJMzj8o66nqOL09H64rg+V2Qu
	StVwL98M=; b=gEpTFRgWoYPNcDT04bnOJLXiuQXj+3lmZS4Iczk+ywk/Jmi1Bt+
	XWc5G9uar7Np0VWF8kUlWnjsGzOa566r9guXrXntegAXz9W6AHy9ssg3XLCLHY4B
	0rFTDKLmntzK37SbzWarDtLsg1qSAeh2ZyxNcI/9gw70OEa4o02cQ5qk27USeFpr
	sBXHQfd4P5UJa1TIj+tz3xL37HZ/gifA6KRb5sowM8hOhGhgdV5TSS3Z/N5nPnUe
	aAel9Uf55AVCeIS/+P+YXUrQU6SzLWw+zSis+gfanczOl3jd8n6MumrKvzzduY9p
	9Shnjco6qPZwXJHeTd8nKDmwDi/A/pT8wWw==
X-ME-Sender: <xms:GWgeaYxAyh076BJ6emlakZI2iebS9eekfON344SyRDOHtHOBsTi8Vw>
    <xme:GWgeaSTjviY9AjyjXJ2FkhIDBpQZuHilKXQAhpIYUtGJItsfxzgIoOObfKlRpbDhI
    VQgBAROg5qpkoLj_oVZ6Z1A7BnR9UADgOE_YDXd0JNIBKKuNiD4onw>
X-ME-Received: <xmr:GWgeaX8E0tAPRxfN50lMiY-a82jYshxAmvNFj4abBmE7YlnBYbdbjez8Vm73I6TwtPF_OD0_5mwhOFgXbFfwKf1Phgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GWgeaRpNZAiMy67f4vg2N7xwL2JFefhg_78IVBq4U05hKv35mgXYLA>
    <xmx:GWgeacmtuDnl8Zex9qPt_hDEGjEqQmc--t9JMgG1xgFw42yIcRtQFw>
    <xmx:GWgeaQKAqKCoIwA-MmiqRV-8pMG8wg9Wfb_AV3lB4JZZKE6FJAdbUA>
    <xmx:GWgeaZz_LGT6DbM0zUNou_rrszC9ZYtbihaZ-uR0VxmvgpF22lItgw>
    <xmx:GmgeaY-1Bhl98OI3_b6JlmwhKDa0z6FhAEGy1S6EKjvKG9wAnQgurXwT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 20:00:09 -0500 (EST)
Date: Wed, 19 Nov 2025 16:59:24 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: extract the io finishing code into a helper
Message-ID: <20251120005924.GA2522273@zen.localdomain>
References: <cover.1763596717.git.wqu@suse.com>
 <bd044ad0afecc8d8f65700800cf45939f7bb2d88.1763596717.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd044ad0afecc8d8f65700800cf45939f7bb2d88.1763596717.git.wqu@suse.com>

On Thu, Nov 20, 2025 at 10:34:32AM +1030, Qu Wenruo wrote:
> Currently we have a code block, which finishes IO for a range beyond
> i_size, deep inside the loop of extent_writepage_io().
> 
> Extract it into a helper, finish_io_beyond_eof(), to reduce the level
> of indents.
> 
> Furthermore slightly change the parameter passed into the helper,
> currently we fully finish the IO for the range beyond EOF, but that
> range may be beyond the range [start, start + len), that means we may
> finish the IO for ranges which we should not touch.

I'm a little confused about this. I can't see any changes to the
effective parameters to anything but btrfs_lookup_first_ordered_range()
but that is getting the first ordered_extent

So allowing more past [cur, end] via [cur, folio_end] shouldn't change
what ordered_extent we get, as we are asserting that we get one with
the narrower search, and we are getting the first one.

the params to min(), btrfs_mark_ordered_io_finished(), and
btrfs_clear_folio_dirty() seem unchanged.

What am I missing?

Thanks,
Boris

> 
> So call the finish_io_beyond_eof() only for the range we should touch.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 62 +++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4fc3b3d776ee..cbee93a929f3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1684,6 +1684,40 @@ static int submit_one_sector(struct btrfs_inode *inode,
>  	return 0;
>  }
>  
> +static void finish_io_beyond_eof(struct btrfs_inode *inode, struct folio *folio, > +				 u64 start, u32 len, loff_t i_size)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct btrfs_ordered_extent *ordered;
> +
> +	ASSERT(start >= i_size);
> +
> +	ordered = btrfs_lookup_first_ordered_range(inode, start, len);
> +
> +	/*
> +	 * We have just run delalloc before getting here, so
> +	 * there must be an ordered extent.
> +	 */
> +	ASSERT(ordered != NULL);
> +	spin_lock(&inode->ordered_tree_lock);
> +	set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> +	ordered->truncated_len = min(ordered->truncated_len,
> +				     start - ordered->file_offset);
> +	spin_unlock(&inode->ordered_tree_lock);
> +	btrfs_put_ordered_extent(ordered);
> +
> +	btrfs_mark_ordered_io_finished(inode, folio, start, len, true);
> +	/*
> +	 * This range is beyond i_size, thus we don't need to
> +	 * bother writing back.
> +	 * But we still need to clear the dirty subpage bit, or
> +	 * the next time the folio gets dirtied, we will try to
> +	 * writeback the sectors with subpage dirty bits,
> +	 * causing writeback without ordered extent.
> +	 */
> +	btrfs_folio_clear_dirty(fs_info, folio, start, len);
> +}
> +
>  /*
>   * Helper for extent_writepage().  This calls the writepage start hooks,
>   * and does the loop to map the page into extents and bios.
> @@ -1739,33 +1773,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
>  
>  		if (cur >= i_size) {
> -			struct btrfs_ordered_extent *ordered;
> -
> -			ordered = btrfs_lookup_first_ordered_range(inode, cur,
> -								   folio_end - cur);
> -			/*
> -			 * We have just run delalloc before getting here, so
> -			 * there must be an ordered extent.
> -			 */
> -			ASSERT(ordered != NULL);
> -			spin_lock(&inode->ordered_tree_lock);
> -			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> -			ordered->truncated_len = min(ordered->truncated_len,
> -						     cur - ordered->file_offset);
> -			spin_unlock(&inode->ordered_tree_lock);
> -			btrfs_put_ordered_extent(ordered);
> -
> -			btrfs_mark_ordered_io_finished(inode, folio, cur,
> -						       end - cur, true);
> -			/*
> -			 * This range is beyond i_size, thus we don't need to
> -			 * bother writing back.
> -			 * But we still need to clear the dirty subpage bit, or
> -			 * the next time the folio gets dirtied, we will try to
> -			 * writeback the sectors with subpage dirty bits,
> -			 * causing writeback without ordered extent.
> -			 */
> -			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
> +			finish_io_beyond_eof(inode, folio, cur, start + len - cur, i_size);

AFAICT, start + len is still end here, why not do end - cur?

>  			break;
>  		}
>  		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
> -- 
> 2.52.0
> 


Return-Path: <linux-btrfs+bounces-13737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B4AAACC28
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948343BBEA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4F28134F;
	Tue,  6 May 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iX2QlvO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/ztHyE1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB481DE2D6
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552307; cv=none; b=J88jHmaZfDjB5OQZu/H94upcLtshf9iHLZGslPTS6GrSUy5kCfSQuoAMUFR8oqv0aCD4EPzaHUHrwMtP+SGolP4TpLtnyPJLSelufOF7R+IlUGSkOFB1CBmYXzjsOEaIZ4osL0aInOHGSyjqkhFacdHveND1MuOa/uDSuf4h+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552307; c=relaxed/simple;
	bh=NmngM5fgOM6IZNkDS7eOLY7Kjs+UGaf0nscz1sENUlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8NeobHzr7l9e4v3YKUofvNn78G5JnfNyZlUvkfqbh70Ba5e6al2xnDkxSmNwaBJ92uBjUNi6E1w022RQqXh8KOriXlkx5M64om/pejx5kbSfbPW4kOhyiX6L8BbGcKqBO0kXsWLoZ+gvextGL7qKBD1pOU0PLT0bpE7ImlKfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iX2QlvO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/ztHyE1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 793FA2540225;
	Tue,  6 May 2025 13:25:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 13:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746552304; x=1746638704; bh=4qTUlxcZSm
	6UmukjGQYWN7oJPnjqAAK9+qOxil7SdN0=; b=iX2QlvO++imEZvYr4EVQNT+s38
	RUY7Bo/IqZ7mU+RzEqGqdqHEb9vr7BMDFIUh1uvm8cgqrU81MVaVA9uF2iPk5ZpX
	+1S1Vnm+sjS/8PjDnFbUOm3o9m4vgy99rYhmYZjiGA5fA35x1WPOiPaI9+b6elG+
	laNb/AStXz7O+oEnhsok7IcnZMiBhGUwXWQmJb9qe68FgRFJbW9jIE4mwZPtuMMj
	WmMcYNVVKJMJnFCIUuUlzsOHm1skS0LnoGZ5mSE4PY12PGUvI3VZNuN7I0q421f4
	LUMpXiIJ6hAyeNAJPbYKTMQVpZUKrna6lvZ9+9zPzb40wBy0YkcwgOFvDIaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746552304; x=1746638704; bh=4qTUlxcZSm6UmukjGQYWN7oJPnjqAAK9+qO
	xil7SdN0=; b=E/ztHyE1hVNYPH/4UH6cySn3zJCRv48i6OBEvBFfqEhIEL4E/Rb
	2KKdTMsy+fm8jR3x85tboYTFduGd2o6AZptNbhvT8NBEeRFeIsEwucvpkIT0JYVD
	eTqbKQYcbM5wmxG784GTFxqiStWCunv+PDqwr7HH8ILayamhNZzKomBkRB00PcAE
	sFUKDPffZJjOP5j2lgU2Ho4LRso4yyv9c90AZbn5MCsHRtciZtgudT9nUZGlQgL/
	RWp1RADJcxeiqTuGypsrvbfvnTC5Qw7m1400ZsI+cp7rh7dTiMAkIyJqBN5k16Bo
	9Lz7SR3BAr3uemDKUIkoYm2Re2kz6ZATGsA==
X-ME-Sender: <xms:70UaaPEpRI2mJlYXbBD59VeAg_e-OTMklF0sg_c9vTIPU3fqf_kagA>
    <xme:70UaaMV91lNxoZbbQROWCMSSHdsWSYbRSOkTrhGS6WEEEva9a3Z9xiaOm4qPXCGnc
    wkTpicXg8024UELhBM>
X-ME-Received: <xmr:70UaaBLjTiYU3VL6ZapUbN6suA9ICpAdldi78WuHGj7uOyE9mdFOHGPAyV2FuLLi6cjQEtGUdWc4O22wlvj7xIdHtdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8EUaaNFGFGUIjcLBLIJFBvJ1aVK4CTUdxHkTq9wVvXOIYLJ1js6-UQ>
    <xmx:8EUaaFWxMQRpqQLYnVE4FQTKepMV3YB9drUbCbAvKB-23JcEMMAKYg>
    <xmx:8EUaaIN7vR9ZTuaQdtk3D1w6XWCUBq75pPwUGIGttM0XRT3N2tziZw>
    <xmx:8EUaaE3aBqo1YqBV2YV14-6Wmk2nsHHokDLA46pae8YBEghOyBEWeA>
    <xmx:8EUaaJnHf4Ml4tPUfnpiJg-AIo5yZG9kk0vNBgwqx-GZPkYXAkumRRMP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 13:25:03 -0400 (EDT)
Date: Tue, 6 May 2025 10:25:48 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 2/2] btrfs: handle aligned EOF truncation correctly
 for subpage cases
Message-ID: <20250506172548.GA2613127@zen.localdomain>
References: <cover.1745619801.git.wqu@suse.com>
 <36e15c8873b16d55be79dfd3f1fe2a416066ded6.1745619801.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e15c8873b16d55be79dfd3f1fe2a416066ded6.1745619801.git.wqu@suse.com>

On Sat, Apr 26, 2025 at 08:06:50AM +0930, Qu Wenruo wrote:
> [BUG]
> For the following fsx -e 1 run, the btrfs still fails the run on 64K
> page size with 4K fs block size:
> 
> READ BAD DATA: offset = 0x26b3a, size = 0xfafa, fname = /mnt/btrfs/junk
> OFFSET      GOOD    BAD     RANGE
> 0x26b3a     0x0000  0x15b4  0x0
> operation# (mod 256) for the bad data may be 21
> [...]
> LOG DUMP (28 total operations):
> 1(  1 mod 256): SKIPPED (no operation)
> 2(  2 mod 256): SKIPPED (no operation)
> 3(  3 mod 256): SKIPPED (no operation)
> 4(  4 mod 256): SKIPPED (no operation)
> 5(  5 mod 256): WRITE    0x1ea90 thru 0x285e0	(0x9b51 bytes) HOLE
> 6(  6 mod 256): ZERO     0x1b1a8 thru 0x20bd4	(0x5a2d bytes)
> 7(  7 mod 256): FALLOC   0x22b1a thru 0x272fa	(0x47e0 bytes) INTERIOR
> 8(  8 mod 256): WRITE    0x741d thru 0x13522	(0xc106 bytes)
> 9(  9 mod 256): MAPWRITE 0x73ee thru 0xdeeb	(0x6afe bytes)
> 10( 10 mod 256): FALLOC   0xb719 thru 0xb994	(0x27b bytes) INTERIOR
> 11( 11 mod 256): COPY 0x15ed8 thru 0x18be1	(0x2d0a bytes) to 0x25f6e thru 0x28c77
> 12( 12 mod 256): ZERO     0x1615e thru 0x1770e	(0x15b1 bytes)
> 13( 13 mod 256): SKIPPED (no operation)
> 14( 14 mod 256): DEDUPE 0x20000 thru 0x27fff	(0x8000 bytes) to 0x1000 thru 0x8fff
> 15( 15 mod 256): SKIPPED (no operation)
> 16( 16 mod 256): CLONE 0xa000 thru 0xffff	(0x6000 bytes) to 0x36000 thru 0x3bfff
> 17( 17 mod 256): ZERO     0x14adc thru 0x1b78a	(0x6caf bytes)
> 18( 18 mod 256): TRUNCATE DOWN	from 0x3c000 to 0x1e2e3	******WWWW
> 19( 19 mod 256): CLONE 0x4000 thru 0x11fff	(0xe000 bytes) to 0x16000 thru 0x23fff
> 20( 20 mod 256): FALLOC   0x311e1 thru 0x3681b	(0x563a bytes) PAST_EOF
> 21( 21 mod 256): FALLOC   0x351c5 thru 0x40000	(0xae3b bytes) EXTENDING
> 22( 22 mod 256): WRITE    0x920 thru 0x7e51	(0x7532 bytes)
> 23( 23 mod 256): COPY 0x2b58 thru 0xc508	(0x99b1 bytes) to 0x117b1 thru 0x1b161
> 24( 24 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3c9a5
> 25( 25 mod 256): SKIPPED (no operation)
> 26( 26 mod 256): MAPWRITE 0x25020 thru 0x26b06	(0x1ae7 bytes)
> 27( 27 mod 256): SKIPPED (no operation)
> 28( 28 mod 256): READ     0x26b3a thru 0x36633	(0xfafa bytes)	***RRRR***
> 
> [CAUSE]
> The involved operations are:
> 
>  fallocating to largest ever: 0x40000
>  21 pollute_eof	0x24000 thru	0x2ffff	(0xc000 bytes)
>  21 falloc	from 0x351c5 to 0x40000 (0xae3b bytes)
>  28 read	0x26b3a thru	0x36633	(0xfafa bytes)
> 
> At operation #21 a pollute_eof is done, by memory mappaed write into
> range [0x24000, 0x2ffff).
> At this stage, the inode size is 0x24000, which is block aligned.
> 
> Then fallocate happens, and since it's expanding the inode, it will call
> btrfs_truncate_block() to truncate any unaligned range.
> 
> But since the inode size is already block aligned,
> btrfs_truncate_block() does nothing and exit.
> 
> However remember the folio at 0x20000 has some range polluted already,
> although they will not be written back to disk, it still affects the
> page cache, resulting the later operation #28 to read out the polluted
> value.
> 
> [FIX]
> Instead of early exit from btrfs_truncate_block() if the range is
> already block aligned, do extra filio zeroing if the fs block size is
> smaller than the page size and we're truncating beyond EOF.
> 
> This is to address exactly the above case where memory mapped write can
> still leave some garbage beyond EOF.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 08dda7b0883f..e6bb604917a6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4770,6 +4770,52 @@ static bool is_inside_block(u64 bytenr, u64 blockstart, u32 blocksize)
>  	return false;
>  }
>  
> +static int truncate_block_zero_beyond_eof(struct btrfs_inode *inode, u64 start)
> +{
> +	const pgoff_t index = start >> PAGE_SHIFT;
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	struct folio *folio;
> +	u64 zero_start;
> +	u64 zero_end;
> +	int ret = 0;
> +
> +again:
> +	folio = filemap_lock_folio(mapping, index);
> +	/* No folio present. */
> +	if (IS_ERR(folio))
> +		return 0;
> +
> +	if (!folio_test_uptodate(folio)) {
> +		ret = btrfs_read_folio(NULL, folio);
> +		folio_lock(folio);
> +		if (folio->mapping != mapping) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			goto again;
> +		}
> +		if (!folio_test_uptodate(folio)) {
> +			ret = -EIO;
> +			goto out_unlock;
> +		}
> +	}
> +	folio_wait_writeback(folio);
> +
> +	/*
> +	 * We do not need to lock extents nor wait for OE, as it's already
> +	 * beyond EOF.
> +	 */
> +
> +	zero_start = max_t(u64, folio_pos(folio), start);
> +	zero_end = folio_pos(folio) + folio_size(folio) - 1;
> +	folio_zero_range(folio, zero_start - folio_pos(folio),
> +			 zero_end - zero_start + 1);
> +
> +out_unlock:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	return ret;
> +}
> +
>  /*
>   * Handle the truncation of a fs block.
>   *
> @@ -4816,8 +4862,15 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 from, u64 start, u64 end
>  	       from, start, end);
>  
>  	/* The range is aligned at both ends. */
> -	if (IS_ALIGNED(start, blocksize) && IS_ALIGNED(end + 1, blocksize))
> +	if (IS_ALIGNED(start, blocksize) && IS_ALIGNED(end + 1, blocksize)) {
> +		/*
> +		 * For block size < page size case, we may have polluted blocks
> +		 * beyond EOF. So we also need to zero them out.
> +		 */
> +		if (end == (u64)-1 && blocksize < PAGE_SIZE)
> +			ret = truncate_block_zero_beyond_eof(inode, start);
>  		goto out;
> +	}
>  
>  	/*
>  	 * @from may not be inside the head nor tail block. In that case
> -- 
> 2.49.0
> 


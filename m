Return-Path: <linux-btrfs+bounces-20289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83664D059DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 19:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14CBB303BC1F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22A4319873;
	Thu,  8 Jan 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KfrTu8a5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M657glgH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2902F999A
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897742; cv=none; b=hQGIuzzkPX7Ff7eeQFNZjyGy4KyHGqnRoM4FlgPtjTAvENu59DyCD5EObVoZlDubTCRt3Ra2bdwJhDDJh934hn+oucI6CwnTqaxauO2/tGa4UrEAEe2zayIPeqrdUx1LK4RKQO9vDm+H3MCtmL1ZOxdXzWSziC9z7AvtalUmz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897742; c=relaxed/simple;
	bh=4Jd142tKNaIWqDUE+ocYqNWHSB9PiBnqnOpqKwHg5uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP4CnmDXfatFML9/ouK0Yy2KQyRIT2j8tNW8mbsgPnjBpQsrlfU69cUD9Vo36k+yN8BWUar7AkzIRaNEERx9/ZFtTY5/iu7GKoOYvWgGESIDdx/utvIzqXeZ/MoyPu6X9/DDcu8uVwG02ALlVIFguWufn1EBondvr5yAmoJJWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KfrTu8a5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M657glgH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E652C7A006A;
	Thu,  8 Jan 2026 13:42:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Jan 2026 13:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767897739; x=1767984139; bh=agsJojpLO2
	7SULLN1rjmXzfQEQHWlg1j2/kYrnP9L7E=; b=KfrTu8a5xCDLLeg546kzrrMi7K
	LHWz4HTGvRGXDGKMwOVdsw0GcxNUZZ+uQL4qOqccr+uuV+zT6BuPuDDeXx/fdyb7
	jKjOCRoYTWx3lZ37t1kJw/6H4bF0jm7WqrXWi0+kzUVwn2CNQvK/HLoSdrpkLDnn
	7jbUNzKYQY5mbIwHVVMvzZXlPx9/HY/8/F4iK7bXOeScAyjvCHnPaH1+AWrouybR
	pZ1ZoxnNfGR2bTXFS7cOpatJPxBagVwg2qnZ/tP7L9WmzBwBPrKVDQ7msQ0K+Zt3
	KnEi7dxVUHF7KWBZQK0K52GQpDPudwjQZbpd1DjNz2ShQX4lirrQAF2ezAng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767897739; x=1767984139; bh=agsJojpLO27SULLN1rjmXzfQEQHWlg1j2/k
	YrnP9L7E=; b=M657glgHAPNWHh9QG4yTZNhSMeEofLDaGxqKpLNQPA+uiDH06aC
	Q8UaKC7O3W6oYEq0XrLW/JUSK84pT/g6VrmPXBn9fkURx/FU+mGJ12nou1Ml/gJt
	uDjOVUdYmTBfWF5NzfVJok/jDrBcsP2Pi84bejzzpKDrjMdBQX7uye5Bm1TxwYDJ
	vUqhKkX6Tj1JM0qabhXFAZ6XuSrHNlkHCgh6y1Aq+lUsqHSR2rXXH5gE1IN/PZV8
	mJCiETwcnHKRZdB5LeXwSBF85KKwQkitq5OlEYX9vbgix5WdYJcOaJG7SfL1+fyk
	NOB9DPbxE/HVWwALkpWgzBMfv9fPjYkW9Qg==
X-ME-Sender: <xms:i_pfaSk6rx_-55Q1oyn7VL1ai-7BJHPVFjVnnIbBCdpXhshtOeXt8Q>
    <xme:i_pfaf04PPDRxe0HUbO-ecjcpQQH75J6BjarlLn-91aRjQVtfmUn8hfvNmydDDqYD
    rdl138nsYe-DytfMEFMDvhCJi_lmUxy7cHyZZyPmKrWFDhKFHiLjQW5>
X-ME-Received: <xmr:i_pfaeSHXIjToXAF-97G6Iga8a_sDuJTYeaYvaBtYsr5TGGzBcfkOPCQ7Pcv_Y0Grv_Ch7-wbxOzkZmmW1Qc5RQI1_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeiieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i_pfaRv9hlfOw1AtgW5tBu6bJhbVIYIbhyE_eHgqxHXyAhe4WMuXeQ>
    <xmx:i_pfaTaEijRueU_nnqYVWiIc5jlWP-Ptv2TPhJ0XCIABimnd6--inA>
    <xmx:i_pfaWu6IiV6XNvUyPm3pm_etrkTdT162oB63Tj58HmrB9SuXdEvQw>
    <xmx:i_pfaVE0foNDNLZB6XseldiqF352DqKL1pqnhhO5RR3FGlCXjfbkTA>
    <xmx:i_pfadQrm0M6SKBzK_FnjBBbEz1CHMLVazRKS8MWoU_IGFR-oae9DdpI>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 13:42:19 -0500 (EST)
Date: Thu, 8 Jan 2026 10:42:28 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/12] btrfs: zstd: reuse total in and out parameters for
 calculations
Message-ID: <20260108184228.GI2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <1e419f75980c1014c0fa860ba7ba650f5d51da3c.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e419f75980c1014c0fa860ba7ba650f5d51da3c.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:33PM +0100, David Sterba wrote:
> Reduce the stack consumption which is 240 bytes on release config by 16
> bytes. The local variables are not adding anything on top of the
> parameters. As a calling convention if the compression helper returns an
> error the parameters are considered invalid.

I don't think that's technically true, as btrfs_compress_folios() does
an ASSERT(*total_in < orig_len) unconditionally.

However, I don't think it makes your change invalid.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/zstd.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index c9cddcfa337b91..4edc5f6f63a110 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -408,8 +408,6 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  	int nr_folios = 0;
>  	struct folio *in_folio = NULL;  /* The current folio to read. */
>  	struct folio *out_folio = NULL; /* The current folio to write to. */
> -	unsigned long tot_in = 0;
> -	unsigned long tot_out = 0;
>  	unsigned long len = *total_out;
>  	const unsigned long nr_dest_folios = *out_folios;
>  	const u64 orig_end = start + len;
> @@ -471,23 +469,23 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  		}
>  
>  		/* Check to see if we are making it bigger */
> -		if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
> -				tot_in + workspace->in_buf.pos <
> -				tot_out + workspace->out_buf.pos) {
> +		if (*total_in + workspace->in_buf.pos > blocksize * 2 &&
> +				*total_in + workspace->in_buf.pos <
> +				*total_out + workspace->out_buf.pos) {
>  			ret = -E2BIG;
>  			goto out;
>  		}
>  
>  		/* We've reached the end of our output range */
>  		if (workspace->out_buf.pos >= max_out) {
> -			tot_out += workspace->out_buf.pos;
> +			*total_out += workspace->out_buf.pos;
>  			ret = -E2BIG;
>  			goto out;
>  		}
>  
>  		/* Check if we need more output space */
>  		if (workspace->out_buf.pos == workspace->out_buf.size) {
> -			tot_out += min_folio_size;
> +			*total_out += min_folio_size;
>  			max_out -= min_folio_size;
>  			if (nr_folios == nr_dest_folios) {
>  				ret = -E2BIG;
> @@ -506,13 +504,13 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  
>  		/* We've reached the end of the input */
>  		if (workspace->in_buf.pos >= len) {
> -			tot_in += workspace->in_buf.pos;
> +			*total_in += workspace->in_buf.pos;
>  			break;
>  		}
>  
>  		/* Check if we need more input */
>  		if (workspace->in_buf.pos == workspace->in_buf.size) {
> -			tot_in += workspace->in_buf.size;
> +			*total_in += workspace->in_buf.size;
>  			kunmap_local(workspace->in_buf.src);
>  			workspace->in_buf.src = NULL;
>  			folio_put(in_folio);
> @@ -542,16 +540,16 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  			goto out;
>  		}
>  		if (ret2 == 0) {
> -			tot_out += workspace->out_buf.pos;
> +			*total_out += workspace->out_buf.pos;
>  			break;
>  		}
>  		if (workspace->out_buf.pos >= max_out) {
> -			tot_out += workspace->out_buf.pos;
> +			*total_out += workspace->out_buf.pos;
>  			ret = -E2BIG;
>  			goto out;
>  		}
>  
> -		tot_out += min_folio_size;
> +		*total_out += min_folio_size;
>  		max_out -= min_folio_size;
>  		if (nr_folios == nr_dest_folios) {
>  			ret = -E2BIG;
> @@ -568,14 +566,12 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  		workspace->out_buf.size = min_t(size_t, max_out, min_folio_size);
>  	}
>  
> -	if (tot_out >= tot_in) {
> +	if (*total_out >= *total_in) {
>  		ret = -E2BIG;
>  		goto out;
>  	}
>  
>  	ret = 0;
> -	*total_in = tot_in;
> -	*total_out = tot_out;
>  out:
>  	*out_folios = nr_folios;
>  	if (workspace->in_buf.src) {
> -- 
> 2.51.1
> 


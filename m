Return-Path: <linux-btrfs+bounces-19226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8EC75FBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 19:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 59F8228A8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8733D6E6;
	Thu, 20 Nov 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iALQ1mav";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zH3BXKtr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F94248880
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665103; cv=none; b=InhGWpPg0wO12qyOG94SRzxWbLSpbn8eltBrfz8IQWjrGW01OKFvZEREUVGX60zZVBpe3UaEcDq4fXafjxfl5fw2mnW8pKhPlPci7NU/p8lj/vW9F0zk362ZxTXakMUz8Tzqlip3SvygmdjUOo6YQ2NW83Cw9WeKgU9YUbwUiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665103; c=relaxed/simple;
	bh=OdywFzfFIo14bmLRibrc7rNkqXNbWPHiGfy+lMXLk3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsOFQ8Lo7cSOCLzt5dDPf3zwSfdQIx6PKCV6s7QlFwjlrJa4HSrTkdOcWQZ7qvTWE/PW7kNH6FSshviRseauRRmxLjuZVFsmuGi+oTagMRuRDub91xmJtYm9JQvyi3mcLRyDPY7I8GfKy5aTfirJpvhH5t7zlA7/N1eJh8PcHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iALQ1mav; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zH3BXKtr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B2AD81D00287;
	Thu, 20 Nov 2025 13:58:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 20 Nov 2025 13:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763665099; x=1763751499; bh=noNLJtTo+z
	pNK4NaDtnTTHSrvToBWieJMzrZQPqEmnU=; b=iALQ1mavJqHhdCsCJIeqjPMupG
	/hco9j1pIuGvw++ebkrBGVbreVmo6zdrBjCwt7ZFb1AunikJ/eaMogS7bRfXA/ux
	rl1zgjmMVdmEr7vu3PyESRgiEPlMkgurox5l/FfX9HnaBbyOndLAD7ujCA5MRxLS
	CKNFqSMyf62PlOvW9TMnzGykzzH0q+JB7uJFSP7NPiVU/SiTVCfWOuxA1NqyLfeR
	dxzRoovEt2K1+vV6hobLVZMLYuuwGsohFSHP4nkhC1sGhGywINoWulSvwvt8w4Eq
	bt5WIFzlAmff94f0QoUfe6CrR0b6BJS+yo235AyacSX9Y+27qiXjMkovhbkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763665099; x=1763751499; bh=noNLJtTo+zpNK4NaDtnTTHSrvToBWieJMzr
	ZQPqEmnU=; b=zH3BXKtrnhX34DRJOeR75jhYI9hdlParPb8Msrl9oahymyvjHYu
	10AmLqMFx7on3GK1wKrHbjn4pNUA+EE3dxQIoDJh9WW24/v14dln9TS427CjkxiL
	djupBILnQA5N75kl+dmIEpB6qGzod9L6CtZehsIVzkTkjmAyhh+Vf3Gkrjyyi/VB
	Z22KsRJ5UMqpAAWZ/IDy5tJOeuHJvUkakUvOlsOFvvRKPUc5vTTo7YFnHlcom+4J
	I7QeBUAK/CUFYmtpIw1EAipvXw8IO9kzBO2nRFS4mocKeEzRqpZJK8SkuNgc0FHW
	ghFO17En5+9S+mHyw9Mtz+mhjtqyW1KifUA==
X-ME-Sender: <xms:y2QfaZkwA1hLTKZLWJFEWikiOTMcfTnBZHryaao8EC0IXOoLPof9Vg>
    <xme:y2Qfaa3GpKpk65MU1W-gvCpaSxI_ModhQdr6sa7uHWfO9kmshslR2ZsKsjg1W4Q6u
    G2Rdn8OlynWypR5Ovg98lpU2QpEGSADAEojVIlTmuM-7saswWdOpqg>
X-ME-Received: <xmr:y2QfadT7bBQzfPU9I5mXZTAa8XiiJLj3jZowxtTtHwCF__QoJjXqi--S7VjhF5xOnsKdT636Ayns7ukVurlX077DjaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:y2QfaUv68cO00wK_g0mp_tehowWc-W96fMS2QOasb5__SMhej2w_ig>
    <xmx:y2QfaaZx0YWMN1iFaR939jQ23HnmtQvxwZNDdTVsI1yB4osAXceohg>
    <xmx:y2QfaRtz6HzOrY8UM_KDlgpcsStEEtGEvyqX6jIeRpk_I5iSpGn--g>
    <xmx:y2QfaUH322hZ-cN1OZeAYVfk-TznkEYoMn8DMazPfjPEPnzmeEgm3w>
    <xmx:y2QfaSXNSY2gpeycCQq09hB6JlHDJhn5RBWWlEBt7RQuZI62EN913PvG>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 13:58:18 -0500 (EST)
Date: Thu, 20 Nov 2025 10:57:32 -0800
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: drop premature generation setting in
 btrfs_init_new_buffer()
Message-ID: <20251120185732.GA2899191@zen.localdomain>
References: <20251120140030.2770-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120140030.2770-2-sunk67188@gmail.com>

On Thu, Nov 20, 2025 at 09:57:02PM +0800, Sun YangKai wrote:
> In btrfs_init_new_buffer(), we set the buffer's generation just for the check in
> btrfs_clear_buffer_dirty(). So just pass NULL to skip the check and we don't need
> to set the generation before erasing the buffer.
> 
> No functional change.
> 
> See commit messages for details.

Looks good, thanks
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Sun YangKai (2):
>   btrfs: add comment for btrfs_clear_buffer_dirty
>   btrfs: drop premature generation setting in btrfs_init_new_buffer()
> 
>  fs/btrfs/extent-tree.c |  6 ++----
>  fs/btrfs/extent_io.c   | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> -- 
> 2.51.2
> 


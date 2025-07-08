Return-Path: <linux-btrfs+bounces-15336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419E4AFCFF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 18:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D137AF9FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E57A2E3367;
	Tue,  8 Jul 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KtTHtYec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AV62bH57"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AC2E3AF8
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990411; cv=none; b=RXKHggE/mjo37y87JxDfkA9gx2ZDzlbN6PMzsNQ88bpoqxLbQJMD/pnA9g/pnzySlreOh6xGkkQR07UjaISDxQFXIfQI19bMxCnis3eMT7fXuURpWsQBfiSvX93FNANQVvIoBlfMyZpuuRXrkH5RwdXOJ0FTzbUmLIoKR8smruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990411; c=relaxed/simple;
	bh=x8NK2PIYJYFRtOjIMXCU7lLbZ4g+C4aG35WdbBXl1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkRLUXTKNDv4HCmABhXMd5F7SwX3YOdC9+UuGd0q8XcGqnB0Exg5VvzO0MnKRzL5rcei2+GirooPEZzBEsMLxjhX4OS8UZcR7Erupn4PpiTwYMfyGhh7z3OZF842wOsRvGarCr5/++SDTlPptsfRiwaJHE+S6oDrSecORb715Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KtTHtYec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AV62bH57; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C50D14005D5;
	Tue,  8 Jul 2025 12:00:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 12:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751990408; x=1752076808; bh=tWVVjm9U2K
	rci7ROqysvb5RtDY8fyJ/ej60mKzCVw+I=; b=KtTHtYecK/6UeSNKJSO7onzQxv
	LxNXl3Mr+3bFWSP79KInriJx229Xlz5vyqKuUxiQ853VN0RFQ64VLx2agybXF/RU
	zWmWGCe2HSJ0+HDZePyDBfPRK1JSxSxrATLtVlysO89xHqd+f65nPghrahd84wKn
	yWu0M8eU0ynFImaWetpUNYXtD7WAaC7L3cEcicb2C/IeTxqykuACxdbg3lzMPDwd
	tA1jdA+9e/GteTT6e4jaBIFQwKmOmODsz5U81pg1zPrJbkVxgtbDRJ8CMbbpj93g
	EtCJzBaO7rCvw5+0Bgc55283iAspARYz9UcrI7pOnfZ6eU8ZwLLiwqTQWDUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751990408; x=1752076808; bh=tWVVjm9U2Krci7ROqysvb5RtDY8fyJ/ej60
	mKzCVw+I=; b=AV62bH57/reeJCkoZMMQW57ziEk/OlBsmFHREnRSxdzKeaABgjF
	p1GlnfK01nsrdX+6GBPQ8+VtkXFZ4+l/EbT5db59z1XkqLOCkXxh48+VNowcIAwk
	qL+QYp6BbjRQd3zEhqoiCxqs2QY3AtT4hCIxsQ0PEKafSAZq6mNIiKNVf8gTv5KH
	5EhZ4gxKVpqBBCSHpdVdr0PX7sYi7KrIojPHGm4e6N1+M+vGbmsO3aif77xZQUCH
	Nk1vK/duoiyv06aTXPvlgU5qGz4mLpknxZ47bFFbppQBIX9y8uxWh0HERXRWt6eM
	rMmY014Ez4SvgrLk2DNV0T9/n2l9xmtFiww==
X-ME-Sender: <xms:h0BtaLBhI1ylQfYsPcEWcdoFO3k38C_hCgN2Nsrj5CX6rjJMGdxXxw>
    <xme:h0BtaEzAkueDXjpMo7txs-wL8_8ITbvgwb3cGMGpe1gCLmlgvWCS2jkuEHKuWaIyP
    cNooi2duQqvdO2vuT0>
X-ME-Received: <xmr:h0BtaACsGolNc97lFj0ZV1nv2nyOSqz0NyMM7TMSCWmsohRTxw4pMYX8gtuTZGqmSNFt44pxERRdxlUV38wYLKfGUtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjthhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhthhhu
    mhhshhhirhhnseifuggtrdgtohhm
X-ME-Proxy: <xmx:h0BtaJa3RFFcOIZ3IQSQSK7K23sHtf1YLiFGDZqkSbUxlby8QwT8DQ>
    <xmx:h0BtaAhwDLS-6Qw23D7YvVqWQofwajgqxNoNmzKW5eClp4oR9SfL4A>
    <xmx:h0BtaD7tJXtN85PulSjlCLRagAX_Pigkd3ORsR4OOyc82iMO3KKQ0Q>
    <xmx:h0BtaP53ol5CWmcSG8PgQcN6PR8oKVHj-HaaIZ9vHyHtWsmLhokSrg>
    <xmx:iEBtaBYoL8FUvpGRe7K9nrAnyZr3uFoaL_KyAO_gV33KZM6YrV_qmYs->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 12:00:07 -0400 (EDT)
Date: Tue, 8 Jul 2025 09:01:32 -0700
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 0/2] btrfs: be less verbose on automatic bg reclaim
Message-ID: <20250708160057.GA2659713@zen.localdomain>
References: <20250708065504.63525-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708065504.63525-1-jth@kernel.org>

On Tue, Jul 08, 2025 at 08:55:01AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> BTRFS filesystems with active automatic block-group reclaim (this
> especially hits zoned file systems where automatic block-group reclaim is
> used for garbage collection) do a lot of log spamming, because every
> relocated block group is accompanied by three prints at info level.
> 
> The first patch removes the info message that is only present with
> automatic block group reclaim, we have a tracepoint right next to it so
> there's no need for the message at all.
> 
> The second patch introduces a `verbose` parameter for
> `btrfs_relocate_chunk()` and `btrfs_relocate_block_group()` to control if
> we want to add printks or not. Automatic reclaim calls into
> `btrfs_relocate_chunk()` setting `verbose` to false while the user-space
> triggered balance code path sets `verbose` to true retaining the old
> behaviour. 

We also struggle with the spam at Meta with automatic reclaim enabled
though quite a bit less with dynamic.. :) In particular, users often
think it means there is some kind of btrfs error happening.

This looks like a good compromise to me, and I'd be quite happy to see
it go in.

Reviewed-by: Boris Burkov <boris@bur.io>

Thanks!

> 
> Johannes Thumshirn (2):
>   btrfs: remove redundant auto reclaim log message
>   btrfs: don't print relocation messages from auto reclaim
> 
>  fs/btrfs/block-group.c |  8 +-------
>  fs/btrfs/relocation.c  | 12 ++++++++----
>  fs/btrfs/relocation.h  |  3 ++-
>  fs/btrfs/volumes.c     | 14 ++++++++------
>  fs/btrfs/volumes.h     |  3 ++-
>  5 files changed, 21 insertions(+), 19 deletions(-)
> 
> -- 
> 2.50.0
> 


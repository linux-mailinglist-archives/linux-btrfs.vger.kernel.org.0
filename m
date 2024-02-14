Return-Path: <linux-btrfs+bounces-2388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939EA8551F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BBF282771
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A484A127B5D;
	Wed, 14 Feb 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Puy/BnW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPvky8BQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE8604AB
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934785; cv=none; b=IoFKc2P3KU6FySW+xEBMtUK/SGGw1VK2DgvCzNOs4q3Ax1VC/Hr9QtxBdrvYQtV6f2rgSVBSBJdhyr72OltXPYF1M2//CQhIF6xbB5sydEwCITlu1uL+QKq3mvHKoCcunLJcpKBRpoSDJet2Nl0/j2t6FkT4MV9FRx+iqV7PLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934785; c=relaxed/simple;
	bh=ZdFy+UD26xPwhsDX5HDlldFn/jeorGm3w97xKmSaXwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfMfUkHAEJ0G0K1MhYlvHttyJuMP0ph2vZbyE/wJDnqbuXOOIqsdr9mhLKyZihFBELIDL1eSSzkuysEHBqp6J0AQr8xQCD+q0brt5/2+YlhYokPDCgihQUls3z5hcp4hhFh4YjIcDE/RRNXgiDk+rpfgLGga1l8CFPNT5GfUDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Puy/BnW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPvky8BQ; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B1A3032009FF;
	Wed, 14 Feb 2024 13:19:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 13:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707934781; x=1708021181; bh=xvXPk/MhxH
	gK+7Fwr/7RNOlnKGHJl8VF1P+9xaREfuM=; b=Puy/BnW34VX8MDw8nFDxD3EorC
	5yurDOIZlZqHRvQ1wcAEiU+0S1x2zJXaN0nSpZwabAMpVISQCkwe38csmbPYDTZi
	qXXR2xhU4UqKDns8UGDZwHuo+ZNmfrRamUpZ73SaOtIzT4u+rcsNmACaEiIBSOP7
	bTFxx/S8EOmlGOOmG7kdEhcvV1bdHSQGFATleOqvYwI8zXOHiRSrKPFVP4Fmxggf
	qPeh2/jFykKRPIXAPliB6994ZAcyoWQfiPio1ndSTUoQyeBSv6efj6aAt4SWDO0p
	LAwvinT+6gt4jnmTdadIqHsGqphmVjNwjt9q4QG5PDN/st3LUHeUElKKwGOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707934781; x=1708021181; bh=xvXPk/MhxHgK+7Fwr/7RNOlnKGHJ
	l8VF1P+9xaREfuM=; b=rPvky8BQE5kJAMMN8P8xEHC7SwacPX2x8PcukudzRv8x
	fXRStN2r3P+i48iDrLbaEhJg+c12PD5idC5Ljgcp0EGmhVXh/RO+FtkVmuD24jmj
	NUBMal4rIxdMFSGDYpiv58AZgG9M+9T92jQGXPQMasMRcmnXounK1WE5AshQJfNC
	80xx8x7kJt5qz/Jf2K8VQ2U3shMGPydg+TlvfSOU2dlv/+BpThayoknVNODA8kSU
	tGKNMc91p8+CCo6scrjAFdAsBbSPb6dNKt5LdQAcKoVuFg2F68/QWh/MlMfWLMsX
	Y63kPt50xFGqyfX6yUo5sF5uDVEfnW+L/eTv0xQsjQ==
X-ME-Sender: <xms:PATNZWVahJAdJMKi82mzrlykAoLrCibxxdm8jDR-I8Ju3fcn-VeCYA>
    <xme:PATNZSlXo6Tmdtp6Ub26YbxNGb8PA-ZnpbU90Kgt2jtZ3IyrvmeBhAqKI9yww8JU4
    osn6A8MLq1i6BAZg1o>
X-ME-Received: <xmr:PATNZaZKB7k0ALt-173S0sMpljiSUsgQA7kN-HpJXHqWa4rUX1oj3BskTHcC9x6S2EH6-9hX8wHVs0YzY4yMPdqR0Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    elffegveegteeugeeltdeuledutddukeehhfduueehgeefveeiheetveeijeeuteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:PATNZdVYF1_YLoLbpkhqGp42pGfqfOO8YLNSG7OvcKGSucIWudpkuw>
    <xmx:PATNZQn1X03GAnlTQEzD0AJocrj9YYodVAeVgxUtp-rizs-bBmTi7Q>
    <xmx:PATNZScHNFsBKc654FnSvap_Eo7QuKVRFn6E2CNqJw4kSgsWVAL1-Q>
    <xmx:PQTNZcvJTv9R8O2cJmp5mvFawaWtCHyYlvcCQ-qIR-0I0w1Wokfh9w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 13:19:40 -0500 (EST)
Date: Wed, 14 Feb 2024 10:21:17 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 0/3] btrfs: make subpage reader/writer counter to be
 sector aware
Message-ID: <20240214182117.GA377066@zen.localdomain>
References: <cover.1707883446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707883446.git.wqu@suse.com>

On Wed, Feb 14, 2024 at 02:34:33PM +1030, Qu Wenruo wrote:
> This can be fetched from github, and the branch would be utilized for
> all newer subpage delalloc update to support full sector sized
> compression and zoned:
> https://github.com/adam900710/linux/tree/subpage_delalloc
> 
> Currently we just trace subpage reader/writer counter using an atomic.
> 
> It's fine for the current subpage usage, but for the future, we want to
> be aware of which subpage sector is locked inside a page, for proper
> compression (we only support full page compression for now) and zoned support.

The logic of the patches seems good and self-consistent to me, I don't
see any issues.

However, I think it would be helpful to at least see the client code to
motivate the bitmap a bit more for the ignorant :)

Also, from a semi-cursory inspection, it looks like this relies on
extent locking to ensure that multiple threads don't collide on the
subpage bitmap, is that correct? You should check with Josef that his
plans with getting rid of the extent locking don't clash with this.

Thanks,
Boris

> 
> So here we introduce a new bitmap, called locked bitmap, to trace which
> sector is locked for read/write.
> 
> And since reader/writer are both exclusive (to each other and to the same
> type of lock), we can safely use the same bitmap for both reader and
> writer.
> 
> In theory we can use the bitmap (the weight of the locked bitmap) to
> indicate how many bytes are under reader/write lock, but it's not
> possible yet:
> 
> - No weight support for bitmap range
>   The bitmap API only provides bitmap_weight(), which always starts at
>   bit 0.
> 
> - Need to distinguish read/write lock
> 
> Thus we still keep the reader/writer atomic counter.
> 
> Qu Wenruo (3):
>   btrfs: unexport btrfs_subpage_start_writer() and
>     btrfs_subpage_end_and_test_writer()
>   btrfs: subpage: make reader lock to utilize bitmap
>   btrfs: subpage: make writer lock to utilize bitmap
> 
>  fs/btrfs/subpage.c | 70 ++++++++++++++++++++++++++++++++++++----------
>  fs/btrfs/subpage.h | 16 +++++++----
>  2 files changed, 66 insertions(+), 20 deletions(-)
> 
> -- 
> 2.43.1
> 


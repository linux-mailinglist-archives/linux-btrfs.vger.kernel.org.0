Return-Path: <linux-btrfs+bounces-5131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D326C8CA4CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 00:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7628B1F22A95
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F4487AE;
	Mon, 20 May 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="cPPiClfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bfq4zAgx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992023759
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245889; cv=none; b=qwcfTdNSIkoLlP+bX/ND2d/Db/hNpUiuFo7oRYD2/8lIgi5vCKSIsMi5ORsQINqgMYZewdLPU3dhgH+zfebU5Wrx/9K1S7pkTXahNMXNYBF++LMISQ9bOccybsCFFSvu//6Odq5VJXvUVKz5nbydf4J9OJ5mss2hj909OPQmCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245889; c=relaxed/simple;
	bh=UGOFJWB0awcLOiDlGTVynduHCPxIK9uNa3GWYLPwovQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9nKt1llMoVOaG17Mtn/HqPG+i3IFZQqacAlSffOL+7AP0kW+Ui5A4kRA9ZgD56yp819qKI1xqYT9joxPKwCAtMPZl+W0+LsllWY3KEVDQLZnypd2K5TWnCKrrRILHiB1INK2viAGmRP/wJ8bvBCeIYhu/uzJZL87rno13DYa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=cPPiClfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bfq4zAgx; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 4F54E1C00067;
	Mon, 20 May 2024 18:58:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 May 2024 18:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1716245886; x=1716332286; bh=ErWIkMtzM/
	gGh/Am+cG9rmcTAirUL6PVos5ZsRwQjFc=; b=cPPiClfl83aeNwCvcNlDQVt/aH
	o0LT9Kzxj6rIzddpVQct5cGvvfwrXzjLU18mHhYBykM9zqg6tKLL5igs1R8m9U/j
	Qadvabp6aX4qUMSjnIMzeN0khWG3uPn0JAokgNKOdxk+5eR7A4g4Pj4HqjK0dXka
	Bb7JV0oSGXoKjfV+bkMjcsOIp7g4jcgPj5F6bezR/l8TuR1gle+sOdvlBGYLQKMl
	Yt/npc7BbSplpFDpQkgZPT6cBTYhZ+FdsdjYBy92D51UhEwMW+Uh86XreKQ4bVwE
	AZqWX5DT8rnrYvOPZ0fetfs4YxFpeb3WL/qx8iaSfG7QBW57wEI5g+xHR7QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716245886; x=1716332286; bh=ErWIkMtzM/gGh/Am+cG9rmcTAirU
	L6PVos5ZsRwQjFc=; b=Bfq4zAgx9O9c7udDPbQRMKxn5b7r4G3q5BEcGhxqlrpz
	t4maHSjDG6AdsAyCi8212c39DwJlE8oxm08V008xxCXnTB7p+nZX9JpaM/sKplJ3
	MAX3xwQNuyqf5RgrNO44UigZoUDrtinV7sXN4vWj5T04ueC16sjdPzaE3LO5JLt2
	EUJCDq39VZpJcTxcVSXPxy3SbR3uhhjvkoWatOXeoEnwB0/mm3IBlHjzqJIzveKH
	OrM8aS6M1+KiA1Jk5urdyg0Xs55KRjmXiCWZFrEPvKEj59DvpRwbwGMXtA9cnfsS
	FsE6Fk2pm1wba2mHEbSg57on4jzqSUIMI4O+3MvWpw==
X-ME-Sender: <xms:ftVLZpEcsxeVcG8eF811jbep1m7z82H3Jz7LaqtAbOuAofnOmHRmcw>
    <xme:ftVLZuWLj178jHEC_Uj-TKfIcobcFtvj8w-54OuJoXYuc1wNMvlULpYMoucrviwzr
    95lsHENWPeKk_qLC04>
X-ME-Received: <xmr:ftVLZrKmSr89hM9JZThv8lMCQ_Q_Qa_DZL7kf1yXeV1FrGSfOgetRyj3DqJkvH9DxvfSvAS3rBMgC2pU-5DnksDEdSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:ftVLZvFRiNEm4UGnIIhR50jTIqPRbOr1WFKG14juz-L4IMSbX38_UA>
    <xmx:ftVLZvUtGXUeg73TMOVearr77EVuODfBFMD-fTrF9gwHW4j3Fmoqwg>
    <xmx:ftVLZqNLxc9qnnYpnTEVV028OCchG1kX1Ek8zrAizWnrs1dTEofwuw>
    <xmx:ftVLZu031z_2k8BjkT9neE9iCswRRVEcP-Rb-DQy1q4rigrXVLYnvg>
    <xmx:ftVLZsgk_keQgbqAdbWCGDkbsNn9WXaPUuEEpnpl6PvNf8PVea-RiFzz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 18:58:06 -0400 (EDT)
Date: Mon, 20 May 2024 16:00:05 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Cleanups and W=2 warning fixes
Message-ID: <20240520230005.GC1820897@zen.localdomain>
References: <cover.1716234472.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>

On Mon, May 20, 2024 at 09:52:08PM +0200, David Sterba wrote:
> We have a clean run of 'make W='1 with gcc 13, there are some
> interesting warnings to fix with level 2 and even 3. We can't enable the
> warning flags by defualt due to reports from generic code.
> 
> This short series removes shadowed variables, adds const and removes
> an unused macro. There are still some shadow variables to fix but the
> remaining cases are with 'ret' variables so I skipped it for now.

These LGTM. I did notice a few typos in the patch titles, though.
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> David Sterba (6):
>   btrfs: remove duplicate name variable declarations
>   btrfs: rename macro local variables that clash with other variables
>   btrfs: use for-local variabls that shadow function variables
btrfs: use for-local variables that shadow function variables
>   btrfs: remove unused define EXTENT_SIZE_PER_ITEM
>   btrfs: keep const whene returnin value from get_unaligned_le8()
btrfs: keep const when returning value from get_unaligned_le8()
>   btrfs: constify parameters of write_eb_member() and its users
> 
>  fs/btrfs/accessors.h   | 12 ++++++------
>  fs/btrfs/extent_io.c   |  6 ++----
>  fs/btrfs/inode.c       |  2 --
>  fs/btrfs/qgroup.c      | 11 +++++------
>  fs/btrfs/space-info.c  |  2 --
>  fs/btrfs/subpage.c     |  8 ++++----
>  fs/btrfs/transaction.h |  6 +++---
>  fs/btrfs/volumes.c     |  9 +++------
>  fs/btrfs/zoned.c       |  8 +++-----
>  9 files changed, 26 insertions(+), 38 deletions(-)
> 
> -- 
> 2.45.0
> 


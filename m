Return-Path: <linux-btrfs+bounces-15864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EA7B1BAF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589EB18A7C3A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B821D5BF;
	Tue,  5 Aug 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hApum/CO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCgz0W7W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08F86359
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422442; cv=none; b=T+zRdNCJDufH7tj6kaM+LTsvFQoHGDWhyjikOXCrZd54VbVvriQfvBZj346P3AvlpVrJSpZUcglOX5iSkW1xT7g88glyiGt4ojOtaL/5wMdqUtg0dbwXxO+KHN1y+VHzQhNOFKqW2hTQYwpaBPyj5o6S9XGsZCNUs3tPL6JyibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422442; c=relaxed/simple;
	bh=lUz+4/GlcZSKq+9WjqgVVzwCqVskIug2GTls0ugsAjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfMVqgv4xSb7Z52kezYtqcO/P6ATrP+QyiADs3PmVubkRudTO0H6pbQSbzq7WuI0L89fOfitPTwAbnWLBt4ka48H7iiTYg2W+0KVQ9dSZ+EfFrCVor4vszEHL19HtW3zWMcSyY/EEJQIwfyzcFVyo3l7UtXNW85zUlwUXF6HYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hApum/CO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCgz0W7W; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A31931400213;
	Tue,  5 Aug 2025 15:33:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 15:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754422439; x=1754508839; bh=uULMviXzFR
	0ZqCtyQH6ZTSWmSWLgQDWdEOxEl3iauno=; b=hApum/CO/sB1Z2A8jfATkOp1/a
	UIdxoZkbKKihUDDYdU/82OnyfrwkG72H1SxNuzvvt5zXGLetIxuuBEVo9+WP7l+w
	02EpUDsgDVJ1Hu6Ell3k78OhpuswdVCm+YV4iyOu8lLwgrsfXXRaYThqbsdR1d0v
	VXxKpveqW+peHW/HRWotHNqAtzyzYucWZsjQymteG1291osX7Y5bk4HtSnA5uVh6
	XV5oK/tvhsAHsOGvOj0PMB4sjH7hh/4mtDJkvh2rp8x1ONH80yOa5pY/5mgaQI2L
	DW1Kt7yP0Ku9PkSor30dSIyXItaV51A7hQ9bEkfTi0ODSyKt2/5r4geyeQtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754422439; x=1754508839; bh=uULMviXzFR0ZqCtyQH6ZTSWmSWLgQDWdEOx
	El3iauno=; b=nCgz0W7Wr07mTN3qC4Z5x7Q+aUBcqRZVMBAuSVCsROsND7NYKDG
	6IuiRcQueLEPMZQau1UYwm87e1pACLtiMP3EL8YJ+njSfl/oZjYc30PS/8YhgDkW
	kd3R2w27qomfq8uP0rAOK34s+GtlHJOu8RJXgXUITHfepj2+CPdPBPsyJ+3A7mw9
	FW/vP2LmjJP4jqN82IgDwNg+0mu/lq5Nc8EZknXImiPNARLLc2ygfXWZNLlU9y8U
	QhN3ezcWzqnPCq6DqC+RqsdRpi4N2VPr2Zt6YvZg5hlfnDX/Jbrusn4WL++ZqOPF
	KDuzmvLcRtcYZJ6UQ3/e9zwC98M97Lt/Ncw==
X-ME-Sender: <xms:p1ySaLyPfv32Zhl5Ait_fwokkVWFgCVVafw88gh1602V1fjcbL1GtQ>
    <xme:p1ySaDcRn2F2gd6TaIeBV4aG8YvkbPudHQSY-fA7Iin2wvk-CgWuZwhAv9noXkwej
    _8qrg4ZrwTPIa6meHw>
X-ME-Received: <xmr:p1ySaHIHwDLSmTX31xpwiD5OGbEipE6iKlWR7E7VqId6t8ZX5krak1RbfQszjQWqSZW2eNjQ6gMeZcxbBvSxhYJJWF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeitddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:p1ySaEEVUsUuczX0Rrhfk_LH7SNLjPPe9zPvBjIO0XaQ03T8KdZ0gg>
    <xmx:p1ySaBpej1bCNBLBLvorC_k0bwS79ikTpyOV9HH9AAw6DYT4hBA4IQ>
    <xmx:p1ySaNQfI9FwW6ghryrb66PdzFkSuflnYyBWxg9o_WWiaK-QY3CxRg>
    <xmx:p1ySaOP8znvcWvlNa9nfZsPcFyIjphzNtgNsB5WSaRS6sJYqo115fg>
    <xmx:p1ySaPjqKGeYTfV1AKEJL0BmPSzSY7BlfhAa4VVcoEfs5uXcqYGp80kE>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 15:33:59 -0400 (EDT)
Date: Tue, 5 Aug 2025 12:34:58 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: check for device item between super
Message-ID: <20250805193458.GD4106638@zen.localdomain>
References: <cover.1754090561.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754090561.git.wqu@suse.com>

On Sat, Aug 02, 2025 at 09:56:18AM +0930, Qu Wenruo wrote:
> Mark has submitted a check enhancement for progs to detect the device
> item mismatch between super blocks and the items inside chunk tree.
> 
> However there is a long existing problem that it will break CI.
> 
> The root cause is that the CI kernel lacks the needed backports, that on
> a lot cases the kernel can lead to such mismatch and being caught by the
> newer progs.

Can you explain why we are contorting around out of date "continuous"
integration? Shouldn't we just get the CI on a new kernel?

> 
> So to merge this long existing fsck enhancement, this series refresh and
> workaround the problem by:

Thanks for putting in the effort to get the enhancement in, by the way!

> 
> - Only reports warnings when such mismatch is detected
>   Such mismatch is not a huge deal, as we always trust the device item in
>   chunk tree more than the super block one.
>   So it won't cause data loss or whatever.

That makes sense to me.

> 
>   So even if the CI kernel doesn't have the fix, self test cases won't
>   report them as a failure.
> 
> - Workaround fsck/057 to avoid failure
>   Test case fsck/057 is a special case, where we manually check the
>   output for warning messages.
> 
>   This is originally to detect problems related seed device, but now it
>   will also detect device item mismatch cause by the older CI kernel.
> 
>   Workaround it by making the keyword more specific to the original
>   problem, not just checking for warnings.

I'm a little skeptical about reducing even the incidental coverage of
the test except for a good reason.

Thanks,
Boris

> 
> With those done, we can finally make CI to accept the new checks even
> the kernel is not uptodate.
> 
> Mark Harmstone (1):
>   btrfs-progs: check that device byte values in superblock match those
>     in chunk root
> 
> Qu Wenruo (1):
>   btrfs-progs: fsck-tests: make the warning check more specific for 057
> 
>  check/main.c                                  | 35 +++++++++++++++++++
>  .../fsck-tests/057-seed-false-alerts/test.sh  |  6 ++--
>  2 files changed, 38 insertions(+), 3 deletions(-)
> 
> --
> 2.50.1
> 


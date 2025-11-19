Return-Path: <linux-btrfs+bounces-19167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3BC7169B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 295B121565
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99852329392;
	Wed, 19 Nov 2025 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jaV+kdA/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNo/7rCP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF132571A
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593477; cv=none; b=u+Do/wrL+GCTL6Mn88ZZqfa8Lfz2fy55d1idX/cnoJK3GvXIP5OnuNPdNG0veIKSXa4wbpO5/ydMt3t1CnbYMMcWTT8gaXuuP3ayyeYDyF+EZ7W5wG/lJkb1RyGzLGD1Rl9U6J/ZbG6HEH+KQvUwt6gM7RJiXQHYOJplMdq9Mds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593477; c=relaxed/simple;
	bh=WhbVLaNVlB0Nm7Wdwe//KyYe6OrgkhwLdxUPBaKI/fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUS8i86M0IVuBkw875+P7Uj4t8qulyMGSwvIvDfI4pI4ILLaiuJt9mnaA5vbNbODocTiCe+A41PxaU95B8/ACkKWVdZnyh6/kQME69QSUxyg8mGjkffoPtmutZz89abivvK2cfxOWME/SVpNa+oPbePHMuIfN7Llz4jTCMtIL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jaV+kdA/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNo/7rCP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3A3D140020C;
	Wed, 19 Nov 2025 18:04:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 19 Nov 2025 18:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763593474; x=1763679874; bh=TFUvV7I77S
	jlEMOSAnDQHfSCQdwj6ZjgKiYtPZiB1jI=; b=jaV+kdA/Jex9m4RVjXo7MPNmj6
	m0pfBmngTijjUFYjrYVwxNPuAemmY/8GZGEe06DDGfFyiWf+H7Zt/29LOcTuza0f
	eG6vAd5YiUjXnfo84UKzhnfXcSh2M8np+2O21Y5Q3cj5FMk65VPis+p9cOBKM95N
	j+iHTSjyUh5bZF4Y/aHFHeiwsN6j+vVs5RkAccRskJhS7IfzSrVMol/rOAPmIK5w
	qgu/0g9203B8C+SngG5te8x+DNbaazuHuMob+85CxqQOmSOdaLrheREWOMEhEqjV
	sseGlbHMH6LFZZBwaSe+fTZ9WGpHGjAQsO6N4a/bpm8EiLfclyUU+ZrEzdGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763593474; x=1763679874; bh=TFUvV7I77SjlEMOSAnDQHfSCQdwj6ZjgKiY
	tPZiB1jI=; b=MNo/7rCPgMKOpOfY+nj9cXvmwwoffkRH/G64dX762r04b7sGUg+
	KrnaKoWPlP7ZbXbMuiZZf4LEoX6jA8rCN6yBonnINu/UWpawew4gmLWZJHtAROrs
	DzCJYjzs5AU+Gv6r+K7U8weIjeo8/eq7eaNPEuJ5tRyYCzeUCjF5PKSWv0Emgrto
	1/fUFMUSEQnZlAWocONCUVmguD+Na6VV2uORAKPKJLXqPYA2Lrv/bMllBsFvB/4h
	bOpUYYdhPwhMJC9jkRAlONfTqTfqTzW+dIUpwEwM9CEjnZWcKR+QtPe7k9RonLkS
	/vH1Nj1mo/T8B1h8FOWJBiCOQbDWpnJO+CA==
X-ME-Sender: <xms:Ak0eaUCzXiEq5XMdKPQD2zDsaDOrEh6Kuy2sczCax6_27xZKlKHzLA>
    <xme:Ak0eachx8eG8LKDhZifclTXtjRmxdl5bpwxMIddHv1MsspnhqFjozkRFklmp-Aoyh
    puN0Iaz4lDwvV8798ZJLjO4sVCFoYSMc4Ri7f4rtS8hMfVDCT92GvY>
X-ME-Received: <xmr:Ak0eaVMYsKi2bsatgHE2omhpFjxvyyKRtdyebXKaUe6Mna6_SZImweINFl9O8YGTErkosDWffPPoHG-QnYBFyIL7mQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ak0eaV42M5fS6gvxdg_fGhwh4KgRz4vFQxOL2eFHV7-OLO3SjiwHhQ>
    <xmx:Ak0eab0XFfAJ7srdClYqbDQOf495KYCybep4jGO06ytdWHV5HeJgVg>
    <xmx:Ak0eaebUIpI_VG9RawsjXLpc2IEv3QkMIaLNMp15AWp77bAQDLYL7A>
    <xmx:Ak0eabD8txdaHbXimrvAdmm3CLBmBDKA-rRS_GIvX4izYHE1fs-67w>
    <xmx:Ak0eaeMsb2JKXFGGJMLn6cGGRZU-RdN0TmzAC1kAx9UJJuPMFk5CYLvo>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 18:04:34 -0500 (EST)
Date: Wed, 19 Nov 2025 15:03:49 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-tests: make test case 066 to be
 repairable
Message-ID: <20251119230349.GC2475306@zen.localdomain>
References: <cover.1763156743.git.wqu@suse.com>
 <59b21f15f2199cd27233c367457935cb2708e63f.1763156743.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b21f15f2199cd27233c367457935cb2708e63f.1763156743.git.wqu@suse.com>

On Sat, Nov 15, 2025 at 08:16:00AM +1030, Qu Wenruo wrote:
> The test case fsck/066 is only to verify we can detect the missing root
> orphan item, no repair for it yet.
> 
> Now the repair ability is added, change the test case to verify the
> repair is also properly done.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  .../.lowmem_repairable                             |  0
>  .../066-missing-root-orphan-item/test.sh           | 14 --------------
>  2 files changed, 14 deletions(-)
>  create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/.lowmem_repairable
>  delete mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh
> 
> diff --git a/tests/fsck-tests/066-missing-root-orphan-item/.lowmem_repairable b/tests/fsck-tests/066-missing-root-orphan-item/.lowmem_repairable
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tests/fsck-tests/066-missing-root-orphan-item/test.sh b/tests/fsck-tests/066-missing-root-orphan-item/test.sh
> deleted file mode 100755
> index 9db625714c1f..000000000000
> --- a/tests/fsck-tests/066-missing-root-orphan-item/test.sh
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -#!/bin/bash
> -#
> -# Verify that check can report missing orphan root itemm as an error
> -
> -source "$TEST_TOP/common" || exit
> -
> -check_prereq btrfs
> -
> -check_image() {
> -	run_mustfail "missing root orphan item not reported as an error" \
> -		"$TOP/btrfs" check "$1"
> -}
> -
> -check_all_images
> -- 
> 2.51.2
> 


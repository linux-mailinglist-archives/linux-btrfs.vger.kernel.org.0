Return-Path: <linux-btrfs+bounces-3292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27387C16A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A241C22155
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBB73535;
	Thu, 14 Mar 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WvBzu/Hg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkvXyDIk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3271E529;
	Thu, 14 Mar 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434394; cv=none; b=upeu/Qw+vCsYLYfTPix/xKcMFpB1fwvQQk5/i1Yt7AYASbInv2mjMPnDtFS9LRxjL8KQ9xAw/B9/kAEZgAQumzmoyvgcQjyjqwKMYZ/w7G1xVQdirMzWaong5Yl0fvK7PF3aEhI6SwIL8rKopvdgUVSr8VGJJwypT6KOQVV8wd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434394; c=relaxed/simple;
	bh=lfRvdprdqGE71PbMk+/Opwv/rPHqsT3Hy2fYnx4A8ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbUIs3SX4h4gUpVw5w7UGRJheTGmyIdrzDGQxRV7jjSEZfIC+WqiUxXYhFE++78p0Utola0iiTkQ+Yx+mPYM3jbBAK02pLgJ4Euv/lDbDIRxeT99DYcS/bPzUAOGCpoD29FkJwVA3Xvtf/69iyopVMb8+rskbgrhXn4JDNgHCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WvBzu/Hg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkvXyDIk; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 20B365C007D;
	Thu, 14 Mar 2024 12:39:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 14 Mar 2024 12:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710434391; x=1710520791; bh=Af7UDvT28U
	+W6NnntmPRntwKTSpOKF3MKosjPk6QOWI=; b=WvBzu/HgyMRx8S1RVI6WY8XLUl
	5HxgmwMiP15QbG2hhn0jfBlZiqMN1kSCdMjj4QBzk8Ggiu4aDPIREiC+1OtCPfWc
	HlIZ55wOB8pGj+qkGETZo8ghXdA34XSnhAb/ZWYsryUnwnr5bP8w2nl2HEH6KbYx
	xNP6ohE+IZySOHTMamLGaG6tMOA47gnzBv9ZzyRSqwgssdcwn6pOa0mAcc2MXoBm
	hR6pex+LOSJoW1XO3JUQljHdtxsYwn9muRLvwHISn5ONhNhc8BWWe4cyucUBY3X+
	/rgwakuzunwDS8kKsftZirpxnGtLsvKDazQC6XPCkITGIoYxlLJeoRhXV0LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710434391; x=1710520791; bh=Af7UDvT28U+W6NnntmPRntwKTSpO
	KF3MKosjPk6QOWI=; b=HkvXyDIkvFnOStvpwvKKBN6gSPDQbpZrVG97HkPD8sUl
	gFB+uieEk27JhruAjljMiTnBn+/+bMpRuuw4CZup1CDEB6LDvWWz5HG6RlktSLBN
	GVQjQ/rPr4k50AJdKnRdD2wmJX6Wl8w3t+YX8uNDmXEHU8WDmjaWaIulkyqA71ze
	EE8lZxXmw0QyBJZZz6SXIRPsatt9R5Dwwui89w6xKbaydIFl4sJfDnOQyIcVUCDP
	FC7FGFUMNwFM32SB8BBCzUe3qbDhzd+cumj/ZwDazewAcMRUXSPvYQNhZV0FZ7ZD
	mmOPULH/xo/59dc8ouD0M6pEX9DDSOFLWbhzunI3/Q==
X-ME-Sender: <xms:VijzZUHx_luMqY73qguPoag3yvjd921mTlDqmDRPyVUeZp1GqJL2DQ>
    <xme:VijzZdU6L0aqK_K9v7QLf8-ipqqSe5DyWLBXlDO8f-uO63mGLYei1m_5gKBtNrtJZ
    XSS6JN91CCETpv_S5Y>
X-ME-Received: <xmr:VijzZeLCszoFDKhJei6A_bu9g1e9DLi1zOH4cN_CLpNWpAvn5z1ha3zEMiUvfkqhcx6MeI67ti-msS6nnRxhtBLtLTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:VijzZWFy3GhFOI_AELxSOvVl80bpW23w-dNxXUaxBAsJQlw6NF8reQ>
    <xmx:VijzZaWdT4Duuy919P3uH-1EZGeUyRS33Wh0scvhfhd2_qzcX1KalQ>
    <xmx:VijzZZP5ihT58F2Xiu5CAh02spDMQEljtv4dBT2CiWrQY20-d7vitA>
    <xmx:VijzZR3nh5sMcoMkahgU07x61Nw_Bd9ho83kjWTObJ113Z-Zqf6Lpw>
    <xmx:VyjzZXja0P3LxO6gY6bxfsYJ4HL-mUwdiyK87vKH-vYe7QSOcG93WQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 12:39:50 -0400 (EDT)
Date: Thu, 14 Mar 2024 09:40:41 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] common/btrfs: introduce
 _require_btrfs_send_version
Message-ID: <20240314164041.GA3483638@zen.localdomain>
References: <cover.1710411934.git.anand.jain@oracle.com>
 <b9f5d4d4ebe898034c36b3b7094b758c2df73e1b.1710411934.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f5d4d4ebe898034c36b3b7094b758c2df73e1b.1710411934.git.anand.jain@oracle.com>

On Thu, Mar 14, 2024 at 04:07:37PM +0530, Anand Jain wrote:
> Rename _require_btrfs_send_v2() to _require_btrfs_send_version() and
> check if the Btrfs kernel supports the v3 stream.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  common/btrfs    | 10 ++++++----
>  tests/btrfs/281 |  2 +-
>  tests/btrfs/284 |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index aa344706cd5f..ae13fb55cbc6 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -662,18 +662,20 @@ _require_btrfs_corrupt_block()
>  	_require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
>  }
>  
> -_require_btrfs_send_v2()
> +_require_btrfs_send_version()
>  {
> +	local version=$1
> +
>  	# Check first if btrfs-progs supports the v2 stream.
>  	_require_btrfs_command send --compressed-data
>  
>  	# Now check the kernel support. If send_stream_version does not exists,
>  	# then it's a kernel that only supports v1.
>  	[ -f /sys/fs/btrfs/features/send_stream_version ] || \
> -		_notrun "kernel does not support send stream v2"
> +		_notrun "kernel does not support send stream $version"
>  
> -	[ $(cat /sys/fs/btrfs/features/send_stream_version) -gt 1 ] || \
> -		_notrun "kernel does not support send stream v2"
> +	[ $(cat /sys/fs/btrfs/features/send_stream_version) -ge $version ] || \
> +		_notrun "kernel does not support send stream $version"
>  }
>  
>  # Get the bytenr associated to a file extent item at a given file offset.
> diff --git a/tests/btrfs/281 b/tests/btrfs/281
> index 6407522567b8..ddc7d9e8b06d 100755
> --- a/tests/btrfs/281
> +++ b/tests/btrfs/281
> @@ -22,7 +22,7 @@ _begin_fstest auto quick send compress clone fiemap
>  _supported_fs btrfs
>  _require_test
>  _require_scratch_reflink
> -_require_btrfs_send_v2
> +_require_btrfs_send_version 2
>  _require_xfs_io_command "fiemap"
>  _require_fssum
>  _require_btrfs_no_nodatacow
> diff --git a/tests/btrfs/284 b/tests/btrfs/284
> index c6692668f7fc..0df494bc8ab4 100755
> --- a/tests/btrfs/284
> +++ b/tests/btrfs/284
> @@ -12,7 +12,7 @@ _begin_fstest auto quick send compress snapshot
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> -_require_btrfs_send_v2
> +_require_btrfs_send_version 2
>  _require_test
>  # The size needed is variable as it depends on the specific randomized
>  # operations from fsstress and on the value of $LOAD_FACTOR. But require at
> -- 
> 2.39.3
> 


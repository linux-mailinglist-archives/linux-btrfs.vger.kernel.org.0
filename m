Return-Path: <linux-btrfs+bounces-15211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88CAF61E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AA2179BD8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5B221F10;
	Wed,  2 Jul 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hwzqoX0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHjJLx3R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D91BC099
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482387; cv=none; b=Y0n3sWgzqIdUFTXgyuRkovs0QFqKC8DjkZ0tNIDKEpUgOR8p4tg33Ty8gp9ppRh28kbVpGmm6Dq+nYa+WxWCz6k/DAVjETdSjcUXbvyGmIKYqAzfTXUf5+qz2onNIlQ2badh214jHxT6KlNswCNHZXJvIPWZD7JSk1SDbdU/fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482387; c=relaxed/simple;
	bh=fffQpfN8O1E3BNloqh+bO9wuFbYG+lrrFaGM64jDrgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtGLiScrLX6CxOCe6xhFWvZzUT0cui6kuHF+KBjSFQQoMw4EWN1O6x4adXK+5hGHymn+tvsGaRlzOWBnu5ceVxPBxjKcu7yqsaHnJ23QBu/R5A5nP/AWJ0WVQzC2B6zcdv+FV5SqqVycLRmLfEQLncXN6WMxz/FhF/LGxg46N3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hwzqoX0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHjJLx3R; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F2D4AEC010E;
	Wed,  2 Jul 2025 14:53:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Jul 2025 14:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751482384; x=1751568784; bh=R935fOF5bZ
	wmg41+uXmMMwGjAXjYIW5s7TZ5yarSLIU=; b=hwzqoX0vD/VtT6E1fkPdHEFF2A
	rr29OK71WciGqqnttHUe08lNJoOTlc93+K1wmOfJy8SThwtuzparplXc3gpCeVVx
	QBE5RGryFVnE2hDwd5aG9KhHXkXb7Q3r511xpOhYllOYVVhDDBzHFto3gncF6J58
	J03dJX5w0ufccX+meQ3qgfZxSUXoJybRNIoNniwxmhzDmZDxzdD1u59Yuh+iMT2/
	AOZY4i5sfL04Ny6DilL0A/exXbhYVnwHx+soF1mSDYZQr+Tkcy9cGm/WNK5vnk36
	Rr9F3wxwYC+nGp8+m+kTngM1EmBUw3N3R4jAho2FOJbEMQrl8DcjoFtL+CAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751482384; x=1751568784; bh=R935fOF5bZwmg41+uXmMMwGjAXjYIW5s7TZ
	5yarSLIU=; b=iHjJLx3RgafiAOuQ8dBtsNgLPNvy+8y9MsSLSvO6z3iZyrxKtHP
	22uHdQKLPOR+AIxNt1GxdkDAlFWnuJkhG/Nl59pC5aYIfd1qWXty4KLlCAEoYcmM
	zZOSYDjVMIuwjbv6loYeGi76lQ+VdYb9xpSWktKDSnDbLA5Ypt5N84iP1tF2mbVQ
	d7zvN/Wck75u7TVaopar7JMGMafA3mE6cj/kF5LFBiB57p6WE6ueY/Ky3vpwDxIT
	FSpwDtCtrkM+B1EPhO4MDWJxw7XfYbwOd4TrVQ9ZXTO/vR8cyPuMIQdwvXbGAqsD
	vnJmpJm2ULXVobLabxnIS0mw9+DKvdqOnew==
X-ME-Sender: <xms:EIBlaIFepJ35lZGM3oaljfnJRVDaEY6son4QPsXVFls4pa2Dq9rOzQ>
    <xme:EIBlaBU_xhCduTaTthf3xFoP7Cp4WQNJqydZB_qK2qUI_QCAWKyYLLcSLahKIcMJA
    kSDBeajMV-dxzruEPk>
X-ME-Received: <xmr:EIBlaCIS0pWIlDrmjhZ93zxcywxaaLY9rcaH6IiTnYlt_6jw7ayGz4ghaFu60XgX_WDm9gtp9iWlCsBGu_IYRddXNTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephedthf
    evgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:EIBlaKGw9_4yaUrYWdJ21WFYzNdnkCVGabakCpgXfEfjtJgzFh0ahw>
    <xmx:EIBlaOWe1sYrWnN7acyYPbZVXk4BneYFfXkGout07mwgvOA_ith6RQ>
    <xmx:EIBlaNMBJg5EbKwoVNopooPpuWEox086rlMnwuPCyJ02sLp6w-9_mg>
    <xmx:EIBlaF3q80anf8p31HBVXPV8JwRhuW3jlcEGY1S9LPsJwog84GL72w>
    <xmx:EIBlaKksNltzd9l0LGQ5eCRnadzjsQV7MX6qhLkqXvWro1opVWBqbIWv>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 14:53:04 -0400 (EDT)
Date: Wed, 2 Jul 2025 11:54:40 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] Set/get accessor speedups
Message-ID: <20250702185440.GD2308047@zen.localdomain>
References: <cover.1751390044.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751390044.git.dsterba@suse.com>

On Tue, Jul 01, 2025 at 07:23:47PM +0200, David Sterba wrote:
> Followup to [1] bringing refactoring that allows compiler to do more
> optimizations and stack usage reduction. As the set/get helpers are
> heavily used in many functions this improves performance. I will provide
> some numbers later as I've done mostly functional tests. During the
> development I've identified a few more possible optimizations to improve
> performance, but this series is OK as is.
> 
> Overall effects of this series:
> 
> Stack:
> 
>   btrfs_set_16                                          -72 (88 -> 16)
>   btrfs_get_32                                          -56 (80 -> 24)
>   btrfs_set_8                                           -72 (88 -> 16)
>   btrfs_set_64                                          -64 (88 -> 24)
>   btrfs_get_8                                           -72 (80 -> 8)
>   btrfs_get_16                                          -64 (80 -> 16)
>   btrfs_set_32                                          -64 (88 -> 24)
>   btrfs_get_64                                          -56 (80 -> 24)
> 
>   NEW (48):
> 	  report_setget_bounds                           48
>   LOST/NEW DELTA:      +48
>   PRE/POST DELTA:     -472
> 
> Code:
> 
>      text    data     bss     dec     hex filename
>   1456601  115665   16088 1588354  183c82 pre/btrfs.ko
>   1454229  115665   16088 1585982  18333e post/btrfs.ko
> 
>   DELTA: -2372

I sent some minor inline questions / suggestions, but overall this looks
great and each patch makes a good deal of sense on its own.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1751032655.git.dsterba@suse.com/
> 
> David Sterba (7):
>   btrfs: accessors: simplify folio bounds checks
>   btrfs: accessors: use type sizeof constants directly
>   btrfs: accessors: inline eb bounds check and factor out the error
>     report
>   btrfs: accessors: compile-time fast path for u8
>   btrfs: accessors: compile-time fast path for u16
>   btrfs: accessors: set target address at initialization
>   btrfs: accessors: factor out split memcpy with two sources
> 
>  fs/btrfs/accessors.c | 84 +++++++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 33 deletions(-)
> 
> -- 
> 2.49.0
> 


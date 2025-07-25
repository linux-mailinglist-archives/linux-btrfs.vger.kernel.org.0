Return-Path: <linux-btrfs+bounces-15675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA836B1238D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 20:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00339542601
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36A28AAE9;
	Fri, 25 Jul 2025 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="h6xRiT0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HheNiHj1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174348CFC
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466956; cv=none; b=QYYlRtACWT6TyQzq/98s9mysXpIS61UF1j6jGfrWngvV9gsa3gI/e7iHBwhH1ESzSI9WL0UyseiZo19chNzDXubjuQjqbSQGQ1W78+9zKOtFO6fc2C9zyXACC90UMLAzqiJESVz8yCFlPpORV3zOZeBzAYYplItGuUlTYvQwKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466956; c=relaxed/simple;
	bh=zO8o08RdmlOdYdJpIHTHIfe5S2EFwFcKhJdSMT6CAmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsURCksTuIZt0NBUr7W9lV/ONJSOtlosAjzuw3EiEhqBGgn+FHqVRIKgSxleqMowdagYxnDTKFqOwcsqkkSnzUfYeV7klDqwRowW3wUwr6oWycUMun7w9Z2cdENcOefzmtHdnjVtZiTyX7TWZonfOMATcV0jvmLeyUf8HHsGfog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=h6xRiT0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HheNiHj1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 284637A0BBB;
	Fri, 25 Jul 2025 14:09:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 25 Jul 2025 14:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753466953; x=1753553353; bh=lrWTp3B1cT
	8bpBsuHYDbtU/t5hL+JQRU6PU7FZ/d6KY=; b=h6xRiT0JQwL3pw9HMWT4CZpBwg
	kr4JtpFHJWcLE6dPZcG+aEljUuz+ywOeqGWEXArYkxY2Lt2aUt17uVYXJr83C3Zp
	lER0SrUHw8tMq0+kMhmZaMSGJ+DhXY9BW/+Y6rzLq+LauNK3uW7hXlL6xVr7jGNE
	kHR9E/37REpytFtrb1syhcVq4WamCa93jpVrGU3atm09VfwNL9veZoXgXcJTQUfw
	bt69rK1iNrsoDMWynBXlaKKN4kIBnOAemrCKD8AEpphyHYE53HJEe3YIk2Bjne1m
	SaPo2wmeARsO+hqjb9TToYn862ZKgCs/C/jLDKF1qVqb3qGcJoeT4AcoPlTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753466953; x=1753553353; bh=lrWTp3B1cT8bpBsuHYDbtU/t5hL+JQRU6PU
	7FZ/d6KY=; b=HheNiHj13Ig9e5fQ+5BakYoLKkBrna1eoVyVKDgl5xSGw/blZmJ
	XnytYmSm0NsvZny3svWbWxbANDM+hi9jPnkCaqRmZ0WA8eCFI7qOstWTCP9hfaZK
	5GU47PdH6USkyL4AqN15MxunTjJJznuFxgdcx7e2CWkg7cPkxRTVJUuufQVlWhVX
	dE/n1GrhtRdHYfTGM+ng3RclUqHnqyGkmLxrKaRwMR1E7WM0olp8Np3Xn6XmEALW
	uL0kZ/HIPTRzGQJEs8CA9GPWOuaSfXssUmAsE2T6pgqrymYJGzEe2t8/i3ztsgBO
	0E9dZI8Lt751geu98BEHZ9cqrwMCVUgsJ8g==
X-ME-Sender: <xms:SMiDaOyEcUFQrT0aMXNr2SPFPWqvu8MmEo05y1wZEXvuGE487m5Itw>
    <xme:SMiDaKeWmkAOtI7iIEmD0BTsOnb42fe1MtGzyFIf8akSX6AFCDwK4uxQve_Lji91Y
    xp8cQ0TEaRenHl0fR8>
X-ME-Received: <xmr:SMiDaCJ4-kBzEfOl8_2Bs0dGlLH0GTfqUm8NFF4FZ1r68_KGAGo9h2DN2621ZZGfxnWIWYGyv8IXBKWKk2ZhuuWd4uE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SMiDaDEwstc5R_Uen8Uaph-X4-8GeHzi3TbSsIgqEGfwAIlqWLdAAw>
    <xmx:SMiDaEp27naiFNemSZi2WYfAqzQJUfrx70B93qApVIqnr-Tqo8Uo8Q>
    <xmx:SMiDaESMm_W3PjySpR2nvKmDjDupHkqgDj8bO3yW6q0RVTrcBeN8kA>
    <xmx:SMiDaJPIwUvYU87IVCjYlG-xOEKs4gWwegU9c1qQonLSqGe-A_cKaA>
    <xmx:SciDaKjNARMpwPXzy2MLKRYsKNk2X8pONmBQA6rk8YvlEQQmALVZqmhg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 14:09:12 -0400 (EDT)
Date: Fri, 25 Jul 2025 11:10:30 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: check: add detection for missing root
 orphan items
Message-ID: <20250725181030.GB1649496@zen.localdomain>
References: <cover.1753414100.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753414100.git.wqu@suse.com>

On Fri, Jul 25, 2025 at 01:10:40PM +0930, Qu Wenruo wrote:
> There is an internal bug report that some half-dropped subvolume makes
> balance to fail.
> 
> It turns out that, the involved subvolume doesn't have an orphan item,
> this means the half-dropped subvolume is never going to be cleaned up.
> 
> Then at balance time, a reloc tree is created for that half-dropped
> subvolume, and since balance doesn't expect to get a half-dropped
> subvolume, it doesn't check the drop_process_key and increased ref on
> already dropped nodes.
> 
> The problem for progs is that, neither original mode nor lowmem detects
> this kind of problem.
> 
> Original mode has a bad logic which prevents us from calling the proper
> orphan item check.
> Lowmem mode doesn't even take orphan item into consideration.
> 
> This series will add the detection part for btrfs-check, for both
> original and lowmem mode, with a hand crafted image for test.

I left one idea on the check/original patch, but the series looks good
overall to me, thanks for the fix.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Qu Wenruo (3):
>   btrfs-progs: check/original: detect missing orphan items correctly
>   btrfs-progs: check/lowmem: detect missing orphan items correctly
>   btrfs-progs: fsck-tests: a new test case for missing root orphan item
> 
>  check/main.c                                    |   3 +--
>  check/mode-lowmem.c                             |  11 +++++++++++
>  .../066-missing-root-orphan-item/default.img.xz | Bin 0 -> 13468 bytes
>  .../066-missing-root-orphan-item/test.sh        |  14 ++++++++++++++
>  4 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/default.img.xz
>  create mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh
> 
> --
> 2.50.0
> 


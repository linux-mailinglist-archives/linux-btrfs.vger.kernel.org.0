Return-Path: <linux-btrfs+bounces-15410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E2AFF4D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 00:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF1A5885FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DCA248889;
	Wed,  9 Jul 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Aq4Gp0rW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4btyyXa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888C23958F
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100597; cv=none; b=UGL6dptIreepJZI1e72hK42FkFEq5UN1S8SQfhw1XSRRpJq9na3fweAu6DaMdP7BUSUGzj95ce36D/M6qwmH1g+IPkqXHVw2Tm4wQ+krk64Ml0nr6o5svbXqY9erya4kYB00oZDxfZxMKn/pK+WXMAVRKBUKxpJRn/sGeWg0j9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100597; c=relaxed/simple;
	bh=mMXgjMdJ+2+cs6Y9bb/joFKmI9POsFEaG6hgnsf3DHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfH7+JksQCpCf8cHEGrA37l7K++yIjxx6B8f2exn/dnY9VD5ZsgTvUUMogobW7cToEWJU0puRZNJ9WZ5UMPzMcZKjzIhrH31MU6UbPPaadOB1qSIO/UL+jDh1Bw2xAH7J6KkneOWGUeHy+dK8qCtXLUk0zp3TxIV+nenQPbjg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Aq4Gp0rW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4btyyXa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 88728EC0466;
	Wed,  9 Jul 2025 18:36:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Jul 2025 18:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1752100594; x=1752186994; bh=bVV1gIVPpb
	LDbXDqlw8/OK+74fxLsWOa/GIvsttEthY=; b=Aq4Gp0rWMwiClfgn/NqkN+tddX
	qEJPVUbmM0Do/E3zrE+jLD8C+Qbqf9mRMUYKuCaPuJE1n2zd7UXBGDnQfmxWc0gz
	oaZLTLH/dINw0SNoUrlOfq1rnSfI03BC5P0nLYentcF75MY/MfrFwuXldRll9z9N
	VcC2/XKY5FmCzXHK2p9hwojKSDH7WvH51TjCi9yh3hI13wCGWwxRwWjWVconWPdL
	GVk5IJ84dGw6nJwL/2z9wj/eEChJycmBx0Ny+2/xNttdyGkUpYi5vo/pztFRzSp6
	TsUZGg4Y27P2ZPOYsGNIDN69Sx02WSUDfdv3EjpXJEluG+P0lh9C9tZVl+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752100594; x=1752186994; bh=bVV1gIVPpbLDbXDqlw8/OK+74fxLsWOa/GI
	vsttEthY=; b=I4btyyXagHgclASue/zjH4C6ZVvqgn9CjynKwRlExKmFFNPDRW/
	jtxZgqbJ5iS+b09rn2lpxzk0SB5dg2OMUu31S8U6HrlzmVPxvfKH7S6uyZ/zl47X
	OLXS5Xl1G3JvlDNB+ohko1r1AsqVO9+k0v8yOYqAHxR41rYea/AMX9p7QauWNhYD
	cDfriu16G3Z5nIxi/8w1aJYOqZzImXB/AayQWpzBjMOmNbAtDmn+VMRKXeexsEb7
	d1nDVJJqlHgpmsqRfq9SkljS6SyXpAYMGKLRVFNTKG1cpI5DLLEpmHeu06syoK0X
	eP0jp9OE98UbTKNYnF94FbjJCLzvRyzXybQ==
X-ME-Sender: <xms:8u5uaM8YTAt2Wv9ZGk_hkhTHfBjRdIpdU51LKt5wPNG_pSbCEiknYQ>
    <xme:8u5uaE6AzcIJDTRuzsjPy62Cv9mtY3lr1nCDCjxLS6xE35Q25gSfac_2kcot65dl0
    eFrAcdbUgsEcysRPJQ>
X-ME-Received: <xmr:8u5uaD3-h6ZWYB1a9IRO5uIBvszbRG4bZe1aSalpZ8f_p6trtAexa8EX8d0mgD7nRVbFYU2DFEmlXjPkVngTUuXsIws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:8u5uaLCLVEYW1gEYfMPxjAPD7JDbv1PNtRUPCzI5PRQAo9eUQR6pqQ>
    <xmx:8u5uaF2FV-shsMqYe59jVltVyZ4cLPuuFSnk6QBUzT-J_m0VlQ_vtQ>
    <xmx:8u5uaFsJZkk00UErl9jZYO1JWX11R73r0tOje9QImPQ_4V1GVOzPVg>
    <xmx:8u5uaF61jyjPjLA94E8GkvSTt0t9ulLRB7LEeOS7PJSG0jCiXrgRWg>
    <xmx:8u5uaGAq12Kmajj5Brza0FG5jfooQqACRpQ7-w0ib7WC3ay0M5VMU5x5>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 18:36:33 -0400 (EDT)
Date: Wed, 9 Jul 2025 15:38:19 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: some improvements around nocow checking
Message-ID: <20250709223819.GA1644995@zen.localdomain>
References: <cover.1752092303.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752092303.git.fdmanana@suse.com>

On Wed, Jul 09, 2025 at 09:20:27PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Improve nocow write checking to avoid less iterations and less work when
> doing buffered writes by checking multiple consecutive extents, plus a
> couple cleanups.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (3):
>   btrfs: update function comment for btrfs_check_nocow_lock()
>   btrfs: assert we can NOCOW the range in btrfs_truncate_block()
>   btrfs: make btrfs_check_nocow_lock() check more than one extent
> 
>  fs/btrfs/file.c  | 43 +++++++++++++++++++++++++++++++++----------
>  fs/btrfs/inode.c |  7 +++++--
>  2 files changed, 38 insertions(+), 12 deletions(-)
> 
> -- 
> 2.47.2
> 


Return-Path: <linux-btrfs+bounces-12651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20B0A74E88
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D153173271
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2E1D90C8;
	Fri, 28 Mar 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Ox3K+DEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n247+Zol"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA170A935
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179392; cv=none; b=owZ7jbUH4Z+9vcv1tAP2IwDff+H9YDy6+AJNJfWCilvdpwAbIDkmYOop4gXUGqltf9HTLljxC8kBMkaFIcX18b3NGaRNclSNEk/suRESBUQghQVk2nonxpViUjVUX5tDlXBwH/vdIGG3HqdWUJVV8IIYPs0xpkiyHyo4LspnB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179392; c=relaxed/simple;
	bh=b+KcEKtnrs2RRzXWiotrOk3TbmaCZ2cM/T2WhsyD8Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upvDnhajkzUuQSrU76Mok7VbkCDS8763I0HF5GR5D3DqeG4vcEXs89gEewDQD0uUS0c6X7HeSNcGKMnN20vc5CtBKNBaD9qf452myzc7q03BmyDTCR2sVgEt7uzyBrrTJG6ZAxT8Pdy47UIZHhVlsiGQlDxJdlYqTDO0NPic5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Ox3K+DEW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n247+Zol; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 07F4E11400E8;
	Fri, 28 Mar 2025 12:29:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 12:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1743179389; x=1743265789; bh=HS+2ZWWvbN
	Ez4T4MrW5LHkj7hKX83ZYXBmAbcjXAMQk=; b=Ox3K+DEW+bHkWgs7OgyTdVfu8E
	kKfI0IY9jP1hbA7aXr+nuWWngFIXSlwkof3ztYgsklWzjZ3L/5DMOEzk2/hSCBQw
	OqRX2ISqR6jeMijylRk5CrJv2AhWt4KeD4fiNJbMB/J4X90EoZLZDJ9qyfjQIF1x
	JxuC7FjyUfd4heiv3sTOSrONwu48thsb8P0obUVMKRmdkx7HEsZpYbitWXdjFo2/
	Utgpm3bWUZJnmzJiQI9HEEijDkPndSHmv3kt923daWjSFyEtaxiMpBf5i6YwB9gy
	nbzK8T+RZic8Jn47Q0bFxaUFRMdXXLmBtiBJrAurMc2+VEMDIPiFBryhHeow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743179389; x=1743265789; bh=HS+2ZWWvbNEz4T4MrW5LHkj7hKX83ZYXBmA
	bcjXAMQk=; b=n247+ZolCGcJmklDOddgSZ9gEluDtpy4z4WJtDmmOhnJgOI6HLB
	31Q5O7WGKqJVtaAVQo83z6iKxLgHwZ4dDxFUiAFWFns1kGVMkRp7S1HtZc68q0OI
	h3oAlOWQDr6Vgj0uhe80Fj2cgZ30cm+6RVj3iaJvGprfcAbqR3Z9ZnFC2m091VXb
	d61Mi61U6AXNfDNgZZmvNxCjdA+qLWx+sW1cYD46sJ+cSVOve1WzoyOK0Qz5SOWI
	GjxoxaiwHqknb5IZXj7q5RErg4l4wt+vx/X1uGfVTKEAptvpNB2FJ9fQ2qLRScEU
	9LHXxI0mz8xv+b0ByDL+ULxs5lAOjH8wHEA==
X-ME-Sender: <xms:fc7mZ49F_qJaa55_Rm4RGKp5WwrMQGYIFlIq0FmfH7gvdfC_2PCWZw>
    <xme:fc7mZws0jEKjzbdxC9NILH2tNQn1RDtzeu4NvTL-zFe3dMNJIvNynehaLkn2YZrb_
    B5H-kAAMMiNNAS87Gc>
X-ME-Received: <xmr:fc7mZ-Bi-MeVpQ5MAHK5_sjmEBCKJYKTQpd-zRhCKUmZ7hWcqggjnWDjh7RgWY8DcNWUM5JON7UHSFFZQ8Hbinzq-Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fc7mZ4fF-viliXKaCkGEjOQdGyjI9WetY-TPE1pFeC4h1kuV5pEWrQ>
    <xmx:fc7mZ9Mo9bbStRduLmd9SEmNFb06p9qAuuo08W_aozhxl_JIGD4YGw>
    <xmx:fc7mZymQekY7mNtl6lDJqrJS6vHe3QO7Lk6O-QG43mph-jKjD4vwDw>
    <xmx:fc7mZ_vIHQbsYEEjgJO0UIhVWPaDYgTPfiGVtxnT9LhRsrVNOI4mCA>
    <xmx:fc7mZ2ZdP4qYhN3fOyGIosz3dJ3-1D6MGtAORDWs2HHchpw9FJcRu3Ne>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 12:29:49 -0400 (EDT)
Date: Fri, 28 Mar 2025 09:30:41 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: some cleanups related to io trees
Message-ID: <20250328163041.GB1042522@zen.localdomain>
References: <cover.1743166248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743166248.git.fdmanana@suse.com>

On Fri, Mar 28, 2025 at 02:24:01PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Remove some no longer used/needed code related to io trees.
> Details in the change logs.

Reviewed-by: Boris Burkov <boris@bur.io>

Thanks,
Boris

> 
> Filipe Manana (3):
>   btrfs: remove leftover EXTENT_UPTODATE clear from an inode's io_tree
>   btrfs: stop searching for EXTENT_DIRTY bit in the excluded extents io tree
>   btrfs: remove EXTENT_UPTODATE io tree flag
> 
>  fs/btrfs/block-group.c           |  9 ++++-----
>  fs/btrfs/extent-io-tree.h        |  8 --------
>  fs/btrfs/inode.c                 | 22 ++++++++++------------
>  fs/btrfs/relocation.c            |  3 ---
>  fs/btrfs/tests/extent-io-tests.c |  1 -
>  fs/btrfs/tests/inode-tests.c     | 12 ++++--------
>  include/trace/events/btrfs.h     |  1 -
>  7 files changed, 18 insertions(+), 38 deletions(-)
> 
> -- 
> 2.45.2
> 


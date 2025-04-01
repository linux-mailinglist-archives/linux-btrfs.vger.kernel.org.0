Return-Path: <linux-btrfs+bounces-12728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A48A77F65
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C23AF654
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A920E318;
	Tue,  1 Apr 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Ll7aov5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVVxiUj1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109320DD51
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522357; cv=none; b=vCqObsZgM7q1A9Dg2GM6yW4HJWus6xBlCC8PsRq6uYCvte0HT4qZGotphvO/cqMD83XKr1o+/pGKXlmi7An+ArjHhCs5W5Q7OmQ7cj9v7DXjR4Ob/xOcSs30AdBJ2CRUaZx1LnzZTsR0DCirfsO8n8uPaWPZhBf3Xd2+pfpkb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522357; c=relaxed/simple;
	bh=FfphYKA4NnPvN8ZCb/T46Igg2eJOVgdHrPhrwQDhay4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS1Shl7d92HPDVc/5KWpqioXUpeF8U21wu4NtDdIPbkQh0l50qyUunE5NyaLuCy2brlWlbda/mTh5ZDAc4TokjutuuF7re9Wkdwpck9+gXs7ApYdYRO1mGOH0qY3MQDGtYMF+QOTBfdM+DOS7gwfNnvDiWRF643r/tqP4rIH0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Ll7aov5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WVVxiUj1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 776EB254024A;
	Tue,  1 Apr 2025 11:45:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Apr 2025 11:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1743522354; x=1743608754; bh=64bsG9zs7C
	3GO0Q0aMm+xKfwe64ozDDm95oT8tJQQHo=; b=Ll7aov5yGHmP2bsfJ0JvZDE3Iz
	VLosz5sIRvg9TS28/yQzJv/6sAzKjV8Ekw7Cwt4pA1V7Dm/I/QB2SDefFJnoq2Hx
	z3tlLZ3p4+6UOHPN9Pw+37Xf0+BH3AKdI92IhFoQF1XnSXQ3esUOE/TZPoIAMeym
	9kODxFANtc9pNRtSl4a6w+TubglLLm4mWiVRM8AoyB2XZGs+sPKNZbE98fYNMPce
	DFwUvKdXtR2kmMqQtcJZHycxIBJgCqHeZv69JF+LLYe7yY+k4tLlDje4NNOp2Ivp
	EZjspei7hvoWjS2C0/aZKADdpjTxNGGEdw1ELFtA4MaxI3UvNCbbWTIxil+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743522354; x=1743608754; bh=64bsG9zs7C3GO0Q0aMm+xKfwe64ozDDm95o
	T8tJQQHo=; b=WVVxiUj1+z0DGXoCFRC9smCLXrHT7ZOsIWTxMCUtcppx9Vu6E/L
	iX2diWr00tU8v9dSSy9rqRrZM1I6a4yPx0gj0tZN7BgZiCxtawj7NxwuFyrLHTrV
	fRzpqgYNucVOOnJEcyYgZmTzGVOGE1ylgVi46SegBZQNwCOt1VHKPR8NRJJ4HtwM
	B8wh6g66RcWfbdWI4qgGPt3c6rQ6qu2LhXybg/yIPBXkwo0nrgLIZr8K6TVaXm9U
	kw6TtwYOJlkOmXEBnUGPC3nkL5fJ1N8VHOWxheiVOBfyD8hQVZTkiyNtB62yWlpG
	owboxBPxkEIEXq18JokXRtrjPZDUemotWig==
X-ME-Sender: <xms:MgrsZ94DkJgzNJr9mYn_-rpMcm03s50QlKw8Ep7Bf4YsYal-xrD2Sg>
    <xme:MgrsZ641abVJZ_XEFMfih5pJq_0hBNt30ogLt7YiZjfRa8JuvsMYm00tV525fnkHo
    5KwijrYXzRnOcC-SPA>
X-ME-Received: <xmr:MgrsZ0eHzhuxI8yPSOBAyCPU6Sbg4veEOjrIiyRoWyF90-LPsfMUbHMRbwmVuQfnSF-if4Zb5KO9FbuKoq_jXApmq88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MgrsZ2LP0PDYNs65SBX3qWWlt019vhOpuL48mDOZpNCHgUimojZUEg>
    <xmx:MgrsZxId1olKT2jtB4EPhV_L8ajpBOVfQ6G3ijc3ugnTZsmzFBKbjA>
    <xmx:MgrsZ_wox_eIZXofZGFsLuj7w4F8CHfgQWxbII6ZxQduhjExvvUJQw>
    <xmx:MgrsZ9JsjDGH5UkzNbW93KVQab0SgvYHXQhTLJPPZXOIACdy7S0Qug>
    <xmx:MgrsZ4X6DN8bvlSbImcm1fggyNDSMhUSELIrZgyHtJwfLuWYMw0jAj1q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 11:45:53 -0400 (EDT)
Date: Tue, 1 Apr 2025 08:46:39 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: some trivial cleanups related to io trees
Message-ID: <20250401154639.GA3199530@zen.localdomain>
References: <cover.1743508707.git.fdmanana@suse.com>
 <cover.1743521098.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743521098.git.fdmanana@suse.com>

On Tue, Apr 01, 2025 at 04:29:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some simple cleanups related to io trees that are very trivial and were
> initally part of a larger patchset. Details in the change logs.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> V2: Added patch 3/4.
> 
> Filipe Manana (4):
>   btrfs: use clear_extent_bit() at try_release_extent_state()
>   btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
>   btrfs: use clear_extent_bits() instead of clear_extent_bit() where possible
>   btrfs: simplify last record detection at test_range_bit_exists()
> 
>  fs/btrfs/extent-io-tree.c    |  8 +++-----
>  fs/btrfs/extent_io.c         |  2 +-
>  fs/btrfs/inode.c             |  3 +--
>  fs/btrfs/reflink.c           |  5 ++---
>  fs/btrfs/tests/inode-tests.c | 24 ++++++++++++------------
>  fs/btrfs/volumes.c           |  7 +++----
>  6 files changed, 22 insertions(+), 27 deletions(-)
> 
> -- 
> 2.45.2
> 


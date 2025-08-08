Return-Path: <linux-btrfs+bounces-15941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E6FB1F026
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 23:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC29175249
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98286255F3F;
	Fri,  8 Aug 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JTlP9XVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vi7rvmVt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675831F2BB5
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754687175; cv=none; b=jf8Fe2paRF4aCJfbof8XEK6WpfOssZ+pxmoI9Coqf172UKJxjWY+pMZRB1oYfkhIlE0NflH2v7+e2sJzrcsmMdLRq9DJmFAoLeZUcDAKX8Z5m1k9+tm7fJJqRw3tV/a2qUNhTL7gzfhSuuYLQZojrZxnnL9ZtGUViloGciYy594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754687175; c=relaxed/simple;
	bh=Ryc98IcZDDHA7Yp/1+eLw6cJPiJUDsPof1GjANuEGYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyof+Adfnytx1LygmjayPlvEyFepRQ9YldsY2Zn2lVptKWy1iz82yOKbkkIsouMs4Lxpng5JOxJ0/ylleoN3BLlNMKHYT9yg0j2Nn9UYMl4//twqFaC2YGeoO56LtC2ytgzOZwxdrY8UQOWYc1b7Iu2fB7LQZHsDLIYbGiTohhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JTlP9XVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vi7rvmVt; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 639BC1D0004D;
	Fri,  8 Aug 2025 17:06:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 08 Aug 2025 17:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754687172; x=1754773572; bh=MGwSHUW966
	n3Ho3Wk7ZDtlfSSC6Bgwq6rGEbJPrw43M=; b=JTlP9XVAmIt5yQjk/CxmStWp9D
	ywNY71xREYiQDdhJ23HFxbOGnvFn8zhZfBtetqLNksoirzUdxHs9eU7NJ0hPoqNV
	D1a6ga28WoNhjQyRT1A+XQjBvjNw0qcZ3y4WP5mJbpZ/u29gb4Z2m21RsGnKfe3O
	YLiKXZDDknfw5BqIOb/5feH3vXfwHTIBSLX5eARfkW0aI0TOUP655IWSfkhIhZ2k
	JK+KmupE91QFI2xznpc2ydYjgWQmYVzVABMfZDXvCbyk4uerxmWdn33eR7K5PxMn
	j7plIqZI2tkCMPLkpPfD56PQrAbDICjSPzM0qgXRCH1XQjurbnbiw1trS0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754687172; x=1754773572; bh=MGwSHUW966n3Ho3Wk7ZDtlfSSC6Bgwq6rGE
	bJPrw43M=; b=Vi7rvmVtN7Abmw45RqVqEMidC8XPzgGqS+IHGoIh58Fr7bjRm7Y
	a9Ai0MJcN6H6QbcmobDCxq+4gb148VyCQS/WuH9SKaxTN0zdNdZSiBObx42ceJJ8
	zA6QZjB24zBRApNbVoBMU9D5MMc6v/nQFrgKkriUz5X0U/FFJ6STK5UcPvs/xD1h
	TNrmrNyT5mJWYBCtbkf/lwYFtzmZZs7ar4RxWcHi5fkTsgL0TpQpyv3rYdOIqrCi
	uGeh2++jGw//vjGrA8AN13M5VYucHmG3RUpFWDpgVdbm8E9+WEGkfv+oOTJ2346y
	fth59+ZnQRBxh30aV5falpavQawUHVkZNsw==
X-ME-Sender: <xms:xGaWaF10dfyLLzbep7d3ZGdjtd5ZGNs0yabWFI_jrS_3LJpT9njCAQ>
    <xme:xGaWaMQPkyS5rkIzEx5aAqwGqCk3qdZFdWxB5ynWPeiVpih-whq9aQUpXkE_ptbPf
    Q5LRMzTgjt3IUroTyQ>
X-ME-Received: <xmr:xGaWaHsXUluySY3gvj5ivuqpFxre5tXW1eKb6uF2_7YMa4w7uKdAd-HpwUBXXSdJiJWcD-pMoxdPesbiGbMyivsiIFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeihe
    eiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xGaWaBb_Ntwgqk4dqm9alPAElQPzEvAu5GloBBtFuXJCFWgSqcXjkw>
    <xmx:xGaWaMtLeAYuhtlfJrFJuwtd7mseC1I3oUImE8xSWDGj69N7rzP0vQ>
    <xmx:xGaWaDFaCZoW1XT4HtaDZLqv4cDO2Cpd54AhxuunheNCB5ZsK4ekhg>
    <xmx:xGaWaHxkAVLJcgivalIAYrpjXYsla38039knyOwmCG7JCQVqMdBJaw>
    <xmx:xGaWaH7AlPHQYDUjBKl5wDVYHhkN3i8mbyXnyRyXN-75CUxaY1mk7civ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 17:06:11 -0400 (EDT)
Date: Fri, 8 Aug 2025 14:07:04 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fixes for races when checking if an inode was
 logged before
Message-ID: <20250808210704.GA2426268@zen.localdomain>
References: <cover.1754432805.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754432805.git.fdmanana@suse.com>

On Wed, Aug 06, 2025 at 12:11:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first patch is actually a new version of a patch sent out before [1],
> because holding the inode's log_mutex at inode_logged() can make lockdep
> unhappy in situations like when logging conflicting inodes, where we are
> already holding the log_mutex of some other inode and could potentially
> result in a ABBA deadlock.
> 
> The second patch splits part of what the initial version of patch 1 fixed,
> but with a different solution that makes the management of an inode's
> last_dir_index_offset field simpler.
> 
> Patch 3 is completely new.
> 
> Details in the change logs.

New version looks good to me. I reproduced the lockdep failure on the
old version and didn't reproduce it in 100 runs on this one.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> [1] - https://lore.kernel.org/linux-btrfs/7585d15c0e9c163d5cdf32307014a4e792e62541.1753807163.git.fdmanana@suse.com/
> 
> Filipe Manana (3):
>   btrfs: fix race between logging inode and checking if it was logged before
>   btrfs: fix race between setting last_dir_index_offset and inode logging
>   btrfs: avoid load/store tearing races when checking if an inode was logged
> 
>  fs/btrfs/btrfs_inode.h |  2 +-
>  fs/btrfs/inode.c       |  1 +
>  fs/btrfs/tree-log.c    | 78 ++++++++++++++++++++++++++++--------------
>  3 files changed, 55 insertions(+), 26 deletions(-)
> 
> -- 
> 2.47.2
> 


Return-Path: <linux-btrfs+bounces-20457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA67D1AD48
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C0C93035CFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C98434DCD7;
	Tue, 13 Jan 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HC4dMWjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeNb3k0n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FF34BA24
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328726; cv=none; b=pITpQ9rqlKAZ93D3ZOeMseq4DJf3uPEyCiVQIVry5rXMNGB9/0LEwJ4Rqx+q3CMZTZOM5s3wdSyonEikSci6oApggN+jQfIRua93NOr+/wdfjVri3/30XUI8dEbmiYO1HrStm4G1fh66ZlFvIXzjqbY8EQuj7jrCpL6312O6UtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328726; c=relaxed/simple;
	bh=mgwIkSf0sYUcpdGkNYXvL2xvOkz4xx5UmTxdl/z9AAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0CGHi/1S10vVOKUdZk1KG3W7Vt3MnTBGCjJiAsjEj9yXSZD9tGLPbniyd6J+fLKt59HD9CKo6MZ0mb8vqYcs39oKqmt2CGZ25l1sRru6I2eVCS0jgVpgP5oAMgQXXurZOh/GmuLdo7DbJaT0saGAz3XrpDCSBbnc0B0ZQkb0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HC4dMWjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeNb3k0n; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D8E19EC0237;
	Tue, 13 Jan 2026 13:25:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 13:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768328723; x=1768415123; bh=1eFALudRU4
	zAPqC7/flRTIsydqHp55OiarIIDFtDtuk=; b=HC4dMWjcIHWBICMChpviYR6VNh
	dk4+jnUUBWehIPN2Q0eyAUUXsIknS3eZhw9nqxkl92KbSyLH4r+9b9FY9iocAmua
	byCIC14YaX5yi4Gs+5bZb7pb3DKESKbaSar+J3n2BUHoa+cYUsgKCpn+9/dXqqPl
	MpEZDA54M/uAn/x9d4LRqCHksO2c02y+SI1ora6XGWs7Xbl97SrFWd0TWDd3OpT9
	nGnogU+Be5nrju6VqLIo5mRSiMwmB3/RpNKQ4For/0lNPIiZauOvMUBWIi7T3pJG
	PGqS3RkRYaWg2Q0tCHVpdnTVQKuXBXAJ7rMap+Yal2DkJwfPQ8JAwPe8pbdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768328723; x=1768415123; bh=1eFALudRU4zAPqC7/flRTIsydqHp55OiarI
	IDFtDtuk=; b=ZeNb3k0nMGQH3/sqZDNNBZlnOtTDTExd8ZVwQ1yVKOab5qLoUaS
	NpPOgJc112Q9MVkz6b6OtCoqt1KwLF9481DF58Js0Wo+Lm4xy6/GX2PRW5J0m+r2
	yc4f9wxocrouPfLpPGrGp9pOMqWm1afCookBOIevVcm/b1kcMfdXDTrbD0+MYKbF
	J68t22wLMqa+ZPoeKYnjDvs5aLh6yKCDTZTU9lLhvvPKMOQ61Rj1HydJl5hgwO6h
	dWfjeJ66LX34fOuJ8dnVyFa4hUIXzFFXxRrxsWGUJ4PfDb//KnpoJOgtNBmxCdrW
	wPeapfnt65Rm/wlbPOjvoWj6+dB1N3nJwmg==
X-ME-Sender: <xms:E45maSDXAKZR5nC1J1WtHPQJNiZP3sL7QTYAJNW2ytwbqnswDUB_vg>
    <xme:E45maSj4tVn3l_nXtfLkT8ulwWcv-fPr2yct_I1CNlX9WueiitAy_VXyLDQvP_nEx
    aqVJ3KNwR61nZIHEfONPsuycyPxsZ08xVUKc9UusZSVMgk_xBrZAA>
X-ME-Received: <xmr:E45maTOPl1hv0craVVBqhxxJbxJqDG8-wQym117Lx_0IgJvvCW1AlLKT9hnlt-Z1EYveDMCIp9CsW9kcNbBS4lmdpLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhtihhnsehurhgsrggtkhhuphdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:E45mab4TDkjNFJR41dgyA0okF9UtTiqTQscs_0pt3pABmLG30p89Dg>
    <xmx:E45maZ2ZqTRYb9BQiyc6azMlCY6PZptrqoprQTrD-W4NU6XcPY7OpQ>
    <xmx:E45maUZhjSxErS7JseQZKMj5NyqJVBpA9gNFHWO5IqnpH0chZAD62A>
    <xmx:E45maZABtDnQwsPDIsFkd6uPmoTkudzbq4wXfC7KzgkOMl6Gc_8Xdg>
    <xmx:E45macMXvcd8soZ0ujJ8h8sTCHj1og5IXu-0g0RJ2p4jo9_QbZwSiVSY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 13:25:23 -0500 (EST)
Date: Tue, 13 Jan 2026 10:25:23 -0800
From: Boris Burkov <boris@bur.io>
To: Martin Raiber <martin@urbackup.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] Improve performance of find_free_extent
Message-ID: <20260113182523.GA972704@zen.localdomain>
References: <0102019bb2ff554d-2be39adf-dd94-4f37-864a-69bbf700de33-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102019bb2ff554d-2be39adf-dd94-4f37-864a-69bbf700de33-000000@eu-west-1.amazonses.com>

On Mon, Jan 12, 2026 at 04:17:16PM +0000, Martin Raiber wrote:
> On a system with large btrfs file system and old (but many cores) CPU, I saw the throughput bottlenecked
> by find_free_extent performance, running in parallel, e.g., by flush_delalloc and btrfs-flush.
> While the logic in find_free_extent can probably be improved (not iterating through tens of 
> thousands of block groups), I was able to fix the immediate problem by using percpu synchronization
> primitives and two other micro-optimizations.

One more high level question, since I haven't worked with you on btrfs
before. Do you have a good setup for running fstests? If not, this is a
sweet patch series and I would be happy to help you test it, since
setting that up can be a pain.

Let me know,
Boris

> 
> Martin Raiber (7):
>   btrfs: Use percpu refcounting for block groups
>   btrfs: Use percpu semaphore for space info groups_sem
>   btrfs: Don't lock data_rwsem if space cache v1 is not used
>   btrfs: Use percpu sem for block_group_cache_lock
>   btrfs: Skip locking percpu semaphores on mount
>   btrfs: Introduce fast path for checking if a block group is done
>   btrfs: Move block group members frequently accessed together  closer
> 
>  fs/btrfs/block-group.c | 168 +++++++++++++++++++++++------------------
>  fs/btrfs/block-group.h |  18 +++--
>  fs/btrfs/disk-io.c     |   6 +-
>  fs/btrfs/extent-tree.c |  24 +++---
>  fs/btrfs/fs.h          |   2 +-
>  fs/btrfs/ioctl.c       |   8 +-
>  fs/btrfs/space-info.c  |  33 +++++---
>  fs/btrfs/space-info.h  |   4 +-
>  fs/btrfs/sysfs.c       |   9 ++-
>  fs/btrfs/zoned.c       |  13 ++--
>  10 files changed, 163 insertions(+), 122 deletions(-)
> 
> -- 
> 2.39.5
> 


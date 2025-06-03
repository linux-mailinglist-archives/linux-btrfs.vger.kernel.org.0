Return-Path: <linux-btrfs+bounces-14422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE09ACCD9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB773A6BD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E97204C00;
	Tue,  3 Jun 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RKxEFqj2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqUpuXoS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C91537A7
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748979018; cv=none; b=cSO17+j/HGO7YTJlIQk6YsPX54dsRkIoXRNdpMEgy+AOsSvQ6Tb2GPxHSzzh9GkjWPUOkwibQzPFCOYypfHCL4Vgj8/QVFtJwXtBEOnPgmqRhXsxo+qSwLDFJyjQANui8BWctv7KAhdsra3PSes/O7aYUQKOEkHQgQYdjQopcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748979018; c=relaxed/simple;
	bh=4ouaHYC/2dbJtsAYEgmJImgE1Y2FKyhjaDuDvtLE6Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8dmYozh3dm/tyNPSP+HpAvIN3IMdl1A/daipkJJlhhto3pTMy/OdMExzXkEXXiMKpC4nz+FLD6xyTPL5LQBPK8e6tdeWAjsG/j+RD3D1TaF1Gwps13SKjfyQF01RCtuSHv1fJCijxCiiPbqyXBKqbfB8tL2n2kqb8Gm1gI7TMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=RKxEFqj2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqUpuXoS; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 883A2114010E;
	Tue,  3 Jun 2025 15:30:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 03 Jun 2025 15:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748979014; x=1749065414; bh=KPGEtsJ5vk
	4vmLbRh4UExEF2Jx5V7MXRGr7fxdyrsLY=; b=RKxEFqj2jRt11PKGuYBNsjGDUY
	1UNVlY4okYPXOohU3qk+jyFxVaW7NsiA7qu3l0I8oFIRby5Re1373HY9Zk7pav6A
	M/LaWmr6Focwj2Bdehs7Ta+NXRHYfBH3baOEEGvzldWXAKAw/ntocexg5FhbvYMK
	DnHLMz+zVbsjc0w9iqpZSd3El6KLqbe4EsplRVAfsGl2lArGNgaUDrkusbqThL0U
	IR3fn+uJhmyb1tqTPbhmF9ajrjOdZNZB1VH/OmBRPs+btQg1TwsMsgBLXqcB3yy9
	gFLG01UHPVFhl/vt0h4iuz2oKvtSWA1k517oDgHEubGgZjBEYpMB6DaIMHKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748979014; x=1749065414; bh=KPGEtsJ5vk4vmLbRh4UExEF2Jx5V7MXRGr7
	fxdyrsLY=; b=UqUpuXoS9veQnHu6WhHzjwkI1jUHZqAgN8/1SDHSd5L2parylBD
	CkXFhXi+npjoNO/9RrwK/YAsxcbM9b8C+tq08qkW7ooqNcNKrh28NUy9GfGxxAf6
	txyF3UhnmlCmse/gdm4KjnKNQQ0sO17MiyQuyKLq2oLie4MC80cC6Iaokhv3IL36
	FwiWNGvtZ5Aqx30O/m0DSlEerbRynrlvwLyObheD3JXXuVrUWzR8CEg6EdlY0Gct
	g38BsgT5cC1+c/ipcKNOou9qv2AOAwk2leiYOFKk2M5+eI/OpHkBUXVnG78qSHOG
	Wxzj2MczN5i506yjoOMQVvKIBFeZ/4VGM+w==
X-ME-Sender: <xms:Rk0_aNAxPJCg1NzQ5uQCitYAhmiNsPkOb9GdrufjioUCpZBMBzNVmQ>
    <xme:Rk0_aLgxGBIryDv2AZ7luw2y7Avgad4BSyo2I2e_e_SwjTdBl8e_0KnZgWgKJTnet
    53YiHtFHM1sSYBFOgo>
X-ME-Received: <xmr:Rk0_aInT-M2OCOTYJj-tXV3lHAl9mlk3WoNfpGdWdl1dnFkbmXTa3c_8MPJMmzTuQO_egtvET9QDY_TAU3Z7iC0LvIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhve
    ehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghn
    rghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Rk0_aHyTLlY5G7HbsQToeJGjEIoBDAZVZNQ0xoTXp91e4g4cQg-O3w>
    <xmx:Rk0_aCT46USiJVD7bf2jX9D5vapTNcA-sPQAF_SHWkXZHYJJgXpqrw>
    <xmx:Rk0_aKabpQY6ijCOKtPXh2Vf3qXjjAwjeDrMHbLqOTcSqKA6X6McVA>
    <xmx:Rk0_aDT7_4HShTvak793Eb5BgWvmf2afzhbHhjiRBcgP_df8rwpFUA>
    <xmx:Rk0_aF8Oz7W3-LFx3l4zOG1LNgwodalB3-nr165ZrUybSBrokZ34Gwdq>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 15:30:13 -0400 (EDT)
Date: Tue, 3 Jun 2025 12:30:11 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: use refcount_t type for extent buffers and
 cleanups
Message-ID: <20250603193011.GC2633115@zen.localdomain>
References: <cover.1748962110.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748962110.git.fdmanana@suse.com>

On Tue, Jun 03, 2025 at 03:50:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Switch from a bare atomic to refcount_t type to track extent buffer
> reference count and a couple cleanups. Details in the change logs.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Filipe Manana (3):
>   btrfs: reorganize logic at free_extent_buffer() for better readability
>   btrfs: add comment for optimization in free_extent_buffer()
>   btrfs: use refcount_t type for the extent buffer reference counter
> 
>  fs/btrfs/ctree.c             | 14 ++++-----
>  fs/btrfs/extent-tree.c       |  2 +-
>  fs/btrfs/extent_io.c         | 55 +++++++++++++++++++-----------------
>  fs/btrfs/extent_io.h         |  2 +-
>  fs/btrfs/fiemap.c            |  2 +-
>  fs/btrfs/print-tree.c        |  2 +-
>  fs/btrfs/qgroup.c            |  6 ++--
>  fs/btrfs/relocation.c        |  4 +--
>  fs/btrfs/tree-log.c          |  4 +--
>  fs/btrfs/zoned.c             |  2 +-
>  include/trace/events/btrfs.h |  2 +-
>  11 files changed, 49 insertions(+), 46 deletions(-)
> 
> -- 
> 2.47.2
> 


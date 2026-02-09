Return-Path: <linux-btrfs+bounces-21565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIb1NNVKimndJAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21565-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 22:00:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BBC114AC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 22:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 511593022623
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8473B37FF69;
	Mon,  9 Feb 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="g48FYtAZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfZ1I+2Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300B25B662
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670683; cv=none; b=uKcFTlq9zlwgi3HRsOVy4uzT9s1wm1DTCRj2yjIY4zlV4toNDFc38sE3Ty3gisRDrejSWZikI1KzHpmqykzTuJZM7Fz6enrrZQoEMdIrdHftWuHuGcZboHT2M4uaq20w5DXbRRR5VpliblCCNgvIfj2JHGEpU+JYYfpRjO8lKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670683; c=relaxed/simple;
	bh=4W3NV6nE0pmV7QzLRGWlf6Mq/ysJ2slvBscHdwwtUtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8Kt4GT/XxnO35k1pQYX66lvYZR+hZV7kkDTkLAs++cBfJxW7nOx30jhMgWUs66nJD8MiDZ0IsJT3AoXKh7gjBKT2m7p75hnQdBgSHf+HfWLz2zUc/Qr2kz3U9ZDx35L/GoBrELvFlCz3b3IZzTsNREc/5IWBq7PZJiUcEQDeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=g48FYtAZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfZ1I+2Y; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 671101D0006C;
	Mon,  9 Feb 2026 15:58:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Feb 2026 15:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770670681; x=1770757081; bh=svxerYOzIB
	0VHD09xt8c0h4O1dWznGYZsEfoA9hvv7U=; b=g48FYtAZBqtggTjkL3t5ZmURjB
	Ulm7naY6WLTe/bfecSd3RslxvxABCsnIttO50jHj0RtAM9nuJ9kMrK5DHPy7wH4v
	ZahJUjfLWj3iZiEb4FzuAW1dYuCS0x4Ll+8CuKGPkIC/YINWOMYhQegZ7ObD7vI5
	f9vB9tesemmQ4b+gkKJdFrhnbDcW5EU74EQxD9czQmB+zr6LGnxcL/foDclug9sg
	BVR6OcUVO7tJcnQkmEM/oLb3Fe9vHyUE6jFWyPOxueyVfbSjr3k5krmXm7nBPrEF
	8VwPTmfNGWWwSlsdUw4TKkJkipa9x/M0ch76yQrUSf8JR2IolnXDdKJfKm1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770670681; x=1770757081; bh=svxerYOzIB0VHD09xt8c0h4O1dWznGYZsEf
	oA9hvv7U=; b=PfZ1I+2YWG31lAfbsnpBxKvp/pDAZZ4wXEQG1sEpXDLrgq6zXDs
	6UQZy/5gHlVYMruIUDNF/o9TaDPfcYNBLa9vyPzD4YPcmMkCOHIGXcBTd02TdJ6p
	RgiyE+dqvD6h0AzHmmuta5kN9GxFAjndk81fAdkhW7isOIudb4ivhxjVEiOHHOcT
	fpBxHw2sn/qqVFxkQVzC8/pZVJJG4lnf0aYRf+JtFA6g5x2SEW1+cziz0/GtxkaL
	LGgRoZ01RZFBmUCKNIcCRJ9SiFykRyxM2eGXsRVUyChjFzmuWTfhWr6CsXujimIl
	9nU5pQBipTZIppM0O8rRvkNFY1rDVZN17Xw==
X-ME-Sender: <xms:WEqKabomyjam334R2hd8-_Ui8HGW6tY1C6LF5e8f5cEf62DGNjkL5A>
    <xme:WEqKabo46comDt-KlzLdexDXEDvKb5WN3Y1CYzmZkGcd4vx2QdGk9v_DDEj7fMkcB
    Ye7P48dyL_PC6N16-25JYQ6zGV-1BarUO8msYFzQV45xAxhVNvoMz0>
X-ME-Received: <xmr:WEqKaV05BbqHtboyzeidS4EKReMzuzjmYEJkcvsm3LuTA2-rocZYF48DIM9ELfwSAl0L4E-FdkgoVvJ8WWwCy6NQ4d4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:WEqKaaBDWZWsiF8HhoVHkmNpjX4hQ9uiUYwEC8Mjboenwar7ANFFbw>
    <xmx:WEqKadcICsv8RZ_lwJHQDpL1xXYw_3UnnczBVtlMgOXRHRSqXG50hA>
    <xmx:WEqKafjYAq2aBhsChmc-0j4V0dqIjcH3kDOIXViGDq9jrWMbxT87Tg>
    <xmx:WEqKaVrkWSn0XQyz6lnb0RpfFbRPoNz8y6Gqdf4Kjz_pYPlYy_55tA>
    <xmx:WUqKaXeGcmlNDmc2DulvjVIRYVqzdmGsp5ZaVH1q0FdyIjVefkVhNYva>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 15:58:00 -0500 (EST)
Date: Mon, 9 Feb 2026 12:57:14 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: remove stale code in read_tree_block() callers
Message-ID: <20260209205714.GB216489@zen.localdomain>
References: <cover.1770634919.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770634919.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21565-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,bur.io:email,bur.io:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: 75BBC114AC6
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:07:09AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (2):
>   btrfs: use the helper extent_buffer_uptodate() everywhere
>   btrfs: remove redundant extent_buffer_uptodate() checks after read_tree_block()
> 
>  fs/btrfs/backref.c      | 10 ----------
>  fs/btrfs/ctree.c        | 13 ++-----------
>  fs/btrfs/disk-io.c      | 10 ----------
>  fs/btrfs/extent_io.c    |  6 +++---
>  fs/btrfs/extent_io.h    |  2 +-
>  fs/btrfs/print-tree.c   |  4 ----
>  fs/btrfs/qgroup.c       |  4 ----
>  fs/btrfs/relocation.c   |  5 +----
>  fs/btrfs/tree-mod-log.c |  8 +++-----
>  9 files changed, 10 insertions(+), 52 deletions(-)
> 
> -- 
> 2.47.2
> 


Return-Path: <linux-btrfs+bounces-21632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BL8BTq/jGmisgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21632-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:41:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69492126AFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D72C33017C2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83634DCFC;
	Wed, 11 Feb 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jxGu8Eh2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYgm9Tnx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9D2D877F
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831666; cv=none; b=jNSetIm0d0pORZjwswN6sMWaDRek6oKzpTon8oOR7kpt9ci0ZZBCMnZlGJa927TKjnF4rIMvAJZ7XZTzRpdWvtYUcJRNchLjuxCO30O5J+Tbb0kq0RtUlylzy5TuTVox6ayNSfsnCfavbqAquDzjmMe1uoCTDMhmRG024E8P4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831666; c=relaxed/simple;
	bh=mYP6d8Qfc+CnoeDOr7xcS/dty8isEbbTkw81aHheEas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiceAY/OY4gY06tCxXiMOOyzptjONo2+DKAwVnO8jZXO8eb0LSL6zP6pO2dyc8r+nUtHn9eQ0MvxA3M3Y14HRIAGXzl+vFCTIaRiFh/p20lrSC/Z1KTUv5kGG1yf5zIKrYfvycHQBuuoa+gR2vcHV2ZoN06o0gzrBiE6e4gstwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jxGu8Eh2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYgm9Tnx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95A7A7A013B;
	Wed, 11 Feb 2026 12:41:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 12:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770831664; x=1770918064; bh=2O/Lwl2VPB
	2Jw0k9g8fBUlI40bR5kaI/6HamjSmGafg=; b=jxGu8Eh2dL44EQOkeTvh8nHq67
	rAvUoy89X+U7fEBjzAP+jrBm0DRaU7LFhCrIJ2FzRQPcjpHmPFxxkGjZ4DZ+RtAb
	I6nJtv5KFNrqo8UsvAA0Uki7lopxWpoDALfvUsETdP8MeDNj5afAspOyQvaB6HWI
	yEAAVoWOCysBwJAoLjkb3V9L0Ap6yGoHGOK40MlqYic6/8FxUZ0utIFLn2IegWun
	18WB8wpCqYxSpFKvA1ArZDrZ6P422SsdaCmTN3dizk/c+axIdZe11CrAIOpWBFVC
	py289Tzpm6b5d56Kz7drX7yDpltntkZvXCvpUnQZH9TZwKayZj9qcJPHPoIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770831664; x=1770918064; bh=2O/Lwl2VPB2Jw0k9g8fBUlI40bR5kaI/6Ha
	mjSmGafg=; b=GYgm9Tnxwg+n7FT/GJM2w/Tw+si+tVLmvsK6e7URv/SRTmmGSXw
	DQcN1wNLxrMqIpm6sL6Pcb3P4e7zZxXv7jtKK/7eDy9H13dYWk8HcfuFDOswfDPX
	5yBJ3HjDUr+xLQpZlz07xRTzlZJxhm8M7Fque1sd6RprmXk8ZOrGsBoMBEDzBH5K
	Ck5kYXqNi9ji+TWG1tok07hCJY+oxEENWKjFqiBAyo7/XYfHM/0jFlrWzZDG3O+n
	7/2jNnlyieFQY3H4pvSnTywGCzXyGB74/C8eV74zHD4N3CO/uTE/EDCFIDUTHxNJ
	+rIxb3QHAHX/h04V/Je/O65e691koW3N3og==
X-ME-Sender: <xms:ML-MaW8VI_rmt9RSF6kukZyqqkiOJlv9hdrNxrSJYwUSrLm6LKSFEQ>
    <xme:ML-Mact5GeMO_w9UTX9UzULPNJr3NY3NpOl8uTyR4MgbZLs8fTdIfua4HHfVtWMM2
    1vNtbil0w9ykqAPHc93gD8YFLmPXkTkMWzxy6-Q91MMgf9XSQ>
X-ME-Received: <xmr:ML-MaZozshoLsHLqTpxDWa-nPybUiHjhWvXWHN4BS8liOMllbCWhXhfMgI-51vt2SBwPi6N527YKOQUHEaoY71z4Blk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:ML-MaZmdDr7ya24X5z436lrES1D_Eb-tdqZdFhGeuzj0LUyqewrkaQ>
    <xmx:ML-MadwNo-6yTh-rquJKtY3h3kUCYlgVmHLwdlM-ed3AxcEf2TvNkg>
    <xmx:ML-MaRl6SEbuMS4ebqx4JT10yTQ9wr4YxNzDKtQLPmNFimZ-BCJHEQ>
    <xmx:ML-MaWclLyO4VbdkffUV8amDBW5-uKtjqhVj5lP3ZijjFVbO7SQjlg>
    <xmx:ML-MaXyh-cLHpV4dZev3JyxOwffFvRk_FobvKHrw6jJN18eKwVC4uKJD>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 12:41:04 -0500 (EST)
Date: Wed, 11 Feb 2026 09:40:14 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: add missing NULL checks when searching for
 roots
Message-ID: <20260211174014.GC1458991@zen.localdomain>
References: <cover.1770580436.git.fdmanana@suse.com>
 <cover.1770724034.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770724034.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21632-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,messagingengine.com:dkim,bur.io:email,bur.io:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69492126AFD
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:57:47AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Remove a wrong but harmless expression before loading an extent root and
> add missing error handling for some root search functions, which can
> return NULL when using the extent tree v2 feature. Some places have the
> NULL checks already, but many others completely ignore it. Chris recently
> reported this with his AI generated reviews.

A few nits/questions on the patches, but please feel free to add

Reviewed-by: Boris Burkov <boris@bur.io>

regardless of how you choose to respond to those.

Thanks,
Boris

> 
> V2: Fixed a return without mutex unlock in patch 2/3, updated patch 3/3
>     to log the logical bytenr of a delayed ref in case we can't find
>     the csum root.
> 
> Filipe Manana (3):
>   btrfs: remove bogus root search condition in load_extent_tree_free()
>   btrfs: check for NULL root after calls to btrfs_extent_root()
>   btrfs: check for NULL root after calls to btrfs_csum_root()
> 
>  fs/btrfs/backref.c         | 28 +++++++++++
>  fs/btrfs/block-group.c     | 39 ++++++++++++++-
>  fs/btrfs/disk-io.c         | 17 ++++++-
>  fs/btrfs/extent-tree.c     | 98 ++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/file-item.c       |  7 +++
>  fs/btrfs/free-space-tree.c |  9 +++-
>  fs/btrfs/inode.c           | 18 ++++++-
>  fs/btrfs/qgroup.c          |  8 ++++
>  fs/btrfs/raid56.c          | 12 ++++-
>  fs/btrfs/relocation.c      | 30 +++++++++++-
>  fs/btrfs/tree-log.c        | 21 ++++++++
>  fs/btrfs/zoned.c           |  7 +++
>  12 files changed, 278 insertions(+), 16 deletions(-)
> 
> -- 
> 2.47.2
> 


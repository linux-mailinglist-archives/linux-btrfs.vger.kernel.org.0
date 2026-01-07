Return-Path: <linux-btrfs+bounces-20217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F1CFFE6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 21:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 925E7303828C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44A340283;
	Wed,  7 Jan 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KTpbBaUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lT8wVmWi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57433F36E
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814447; cv=none; b=j86KQr+/ARE/Mav6tjO3jtYTeMK48QHAqX+n3eV/+hcVK7ymfMmRaJgHF1+oBkW51EkzNJ0uAh3IfGMTQm2jKe4CVCrAW3nK0Scq48H9Mnr/grQ0OzvQnq19FTLAR2NLvVTZcrgLYH803u1YCrXoq67Wcy9iIbq7V4qxlXfDECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814447; c=relaxed/simple;
	bh=zHkEVsBl0esp1E/VxQyR++TnSlrP7Ufp/Xs1qwT2DcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNFgqKYhe5cHzDitk+njd1FVzmyuyQEhLaUwqEAX0UQxODdhgaBEmUVz7HFq519NveKCpzMylhKRPiH12IhKu9q5Ko1TxkcmL927sD9P8byrss/at26QPZ402k9vduk94eU3cMugAJoBqwBtl3Ju5/ajn/oPfSJpYYfVE2PZ+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KTpbBaUr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lT8wVmWi; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E276EC01C6;
	Wed,  7 Jan 2026 14:34:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Jan 2026 14:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767814445; x=1767900845; bh=mZktD/tCsc
	XZY4F0BF/mwyTJ6FD9M+58WFmzoyJwII0=; b=KTpbBaUrAM7beRWdpPJ7eDyx/E
	QZZjdVBxO5bIFkzuZh+WVpaL7zSlAxSxKja5wI7/2tdKWYKZgBtHEwx3Vo8YGovk
	lWr/rcGN+ydUgMEN+MVjLDh9pub8QKW+XfQEDB1j8kbiDyy09RhNCSUSQvvnSKzz
	QKE03Raxi9kblAe0PCNZuJuS6PcFAC4znt+xrFScta/8g6SXmwyMjWHIDITkDHSM
	IrHjmv3+2lS5hKVTlfm//GXWT8ifh/H1R+wq6CV3LWkvnFUnpaCnD+JXXqtSPflS
	dM2zjI2bX3670bPhOFf2X1posav4P1WKa6Nl6mpKWhC7O4z3pVbUD9pXF6ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767814445; x=1767900845; bh=mZktD/tCscXZY4F0BF/mwyTJ6FD9M+58WFm
	zoyJwII0=; b=lT8wVmWiLjJRbnKuzEAUiSMi63xT6jmunefT47Y66rn08n4RRZL
	YyHryXu6VsOqQIuxqMQ2UOpTh5QZG2lN+WHxxTYsM0veIIUl48CpWo7/GtwtQmd+
	Jo3eUKghgHTCfYC7+eP+CRtxERUKZA/sabvN+sRcjYSDQRIc+PKpN6sC/bopoas9
	6xfdy3Lmz07QywW2Kx1w8WUKXOKLUXejxElvNsQdqslkYxlZsOZ2Oe1TRfdOiSuj
	Z0y2Z3YiIbzuojIDRJhMnbHo97HaIlz7bpam3Yr+JMWAOwPYPy/DPOWonOvgEmMG
	Hgiw5npZU51eyWlgFevXW8NyjnoxaOcDllA==
X-ME-Sender: <xms:LbVeaWjHL3Os_sO-X1jBtftE7cEXPhMVgFOWi-_z0noHELDJ84HL3Q>
    <xme:LbVeaXNNqDBFcG69IFOglrkPWB9v2ABOpakqBC3kVkBmT_ddu3Skt_EzdLz4vy3Ae
    bhoVxKjwB99JKGp4jBxXwTpDzo7POA7njU7C4nT6HIaoJx7sw6kJQ>
X-ME-Received: <xmr:LbVeaf6UHDX0dWbKpnKfmMgIB8bM_HjcEjm65jxA9ThnDJaiH314FKyLidz8UbkuBn3vcZMAlGox6BC2cviZOLrIjhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LbVead0h9tLporGCzp48hG2kaUOt3QPAdrRYryGeI-KVT41dpMJrVw>
    <xmx:LbVeaYbkjHAuA5PEw9BaohEXkfTS8cvAfzz3F0jkVJ9MfgT5CvHFZg>
    <xmx:LbVeadBjajxY0vBj13fdXeqCFmD3cM1sMR8W8-ogGKbdd7EQxzi9mA>
    <xmx:LbVeaS9Xi2ReJEStWsnK_JRN2XgzxBfvMJhqyEgze7ive8mjLqKo1A>
    <xmx:LbVeaQT5Hym1SQQNLgsHTjmZjtFUdspK6C25cb1ccSPOgrEQwBoU-YEH>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 14:34:04 -0500 (EST)
Date: Wed, 7 Jan 2026 11:34:15 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/12] btrfs: remove duplicate calculation of eb offset
 in btrfs_bin_search()
Message-ID: <20260107193415.GD2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <bac90390ab73dabc0e8a2da8b5ecdcf25491c675.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac90390ab73dabc0e8a2da8b5ecdcf25491c675.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:24PM +0100, David Sterba wrote:
> In the main search loop the variable 'oil' (offset in folio) is set
> twice, one duplicated when the key fits completely to the contiguous
> range. We can remove it and while it's just a simple calculation, the
> binary search loop is executed many times so micro optimizations add up.
> 
> The code size is reduced by 64 bytes on release config, the loop is
> reorganized a bit and a few instructions shorter.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/ctree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7267b250266579..1eef80c2108331 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -776,7 +776,6 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
>  			const unsigned long idx = get_eb_folio_index(eb, offset);
>  			char *kaddr = folio_address(eb->folios[idx]);
>  
> -			oil = get_eb_offset_in_folio(eb, offset);
>  			tmp = (struct btrfs_disk_key *)(kaddr + oil);
>  		} else {
>  			read_extent_buffer(eb, &unaligned, offset, key_size);
> -- 
> 2.51.1
> 


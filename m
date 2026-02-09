Return-Path: <linux-btrfs+bounces-21561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBW/BYsVimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21561-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:12:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CDB112EDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53F2302736C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF473859D6;
	Mon,  9 Feb 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ebgCy82/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZG21/Wc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2F26B76A
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657103; cv=none; b=OrXLjqAc2Dz2Li9r/LhPpz/F1fvFSQjFQwR30FGRSHWsQIARMuXlKo4HLn1oTXlLsyYsl3aAfyxapOS2SbEaeX9UxHXhANNWiWxXpbZPSKo26cO5VRiWL2FEtxeGJ3QnvHHA3i+fz63a8ZAFFzsIuJT8eDrfjMWux3AT+40qnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657103; c=relaxed/simple;
	bh=oXgadktlvyg/Q1R9QvVZMN5BzYHwy56iYjGnyRkAUuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgOs3xdNq8ZmOgWISG5PjazkiejA4X9Kr3JyoBVrDgK8ybgsSoQodu2wKACU/I+rF40zpqSvYdddPFE/mCBsYr77exTX7mjIJkLtysXKcl03v2ChAoo4kjltihgfBrcwCOJOThwnD/yq+H1HiTtfIpFBVKOr+KgVfKy4c4KZSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ebgCy82/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZG21/Wc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 935461400154;
	Mon,  9 Feb 2026 12:11:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 12:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770657102; x=1770743502; bh=AjPzlcNdlA
	UUyWM83vl6UnQSWbIdk3M+IaPyB5q6qgo=; b=ebgCy82/zjCtXZR3pAG8DrK9C+
	4zNkTulZ43WgoX5Sh5ARi079PXLOGvcGUIQWn2YnevlZ5SuZi+4xMcO5QNSRI2OV
	uECS4wkeALbw/W2GEfeVtKESpqGC6u6cMux22QsCFkqWO9XnAy2YxksCZv80L8y3
	XrbhifUDdUGA90zB7nJL+DbkXiPpZO754mIvcaohBzvLKAVrHRqy3PmglnAlfqZM
	su3XCtw51pXGcsyhC8D4ds/Zgfh7UMuvRAXW+SyuQrvuPgsoIX0J6QDrV6W8pLBo
	m7SzXwfakqPMD3su6V1gSb02CpV8btv4kG0sdDmVsN1NPMe8g8IxUR27ortQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770657102; x=1770743502; bh=AjPzlcNdlAUUyWM83vl6UnQSWbIdk3M+IaP
	yB5q6qgo=; b=fZG21/Wc+QiP6DJaEYStb2CLtLinslP7U1zQWWMQ3ltrBFNc40o
	f9HKVLw+3CxMswAmzFgriFjUUsZ/uEeyVNG2xa/wVoWnCWtEJH6srS/kxk3HEVw7
	EtD7yCCQKzHona+nOo/p7huMm6AyrSVj03m8ptPhl82rMhGFYBjXO9HRAGzGp4rb
	4Sn9GCITHKMgdrw5Stz45nvN/9KXDHZLYThTL+vhDCP6OLCiPW07T7at5gHH2gk8
	ULBRvzSlS+YCQE9+gVMljqAlZGwje7HR46D6+sdbZqrVidin0bOX7gA8TEiTDriS
	M5wEH9p94V6rpzHjg2FiN3HeVHv1od5aFUA==
X-ME-Sender: <xms:ThWKaa6E-AHls5noC3QOC-1Z1EzJRiMd6S0Ede1vQmPKs0qtGO1HVQ>
    <xme:ThWKabXJPgSmqCXfSIarNl3ttloZsHlzqO4V9EouWi5w0T9Fg1x--UsoKC55nZK17
    QoF8Nl0p6m3s-08Qe9b1Glcr5XKE8ZiKQ8iFUGnbHrBDobuxsXE_ZM>
X-ME-Received: <xmr:ThWKaW2ITlUgYL8SADEA-gZrh6Tb49bFTxNqLlYbR30KviPM9BPuQEFxgFPvcqp2ZRGq81BUeC8KVWVjLv8_KRlaL8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeihe
    eiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhkieejudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlmhesmhgv
    thgrrdgtohhm
X-ME-Proxy: <xmx:ThWKaQ2ISBTUgqbNGLqP-eADF9x5-0WxYipMXUm7UTFeIVeiBp_2zQ>
    <xmx:ThWKaR8Xe-ldlUW9r1IV9rJcVPUOC5KncyONp6SohS6ZIsGyi4xEnQ>
    <xmx:ThWKaV0zVD2Jrec8hLuOv2p2l70zvO5i4yN0edhkKl1EzC2jL_khOQ>
    <xmx:ThWKaW92jjAp9HlUpreRONnJD-HSdyyCawB9mUG-i4hpLljbKW7vPw>
    <xmx:ThWKaV2kdBnPZp4gpXjZ8noQ9FDV0n1_y3f3H_GyuKiUe8TqUnrh8nHN>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:11:41 -0500 (EST)
Date: Mon, 9 Feb 2026 09:10:55 -0800
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
Subject: Re: [PATCH] btrfs: hold space_info->lock when clearing periodic
 reclaim ready
Message-ID: <20260209171032.GA216489@zen.localdomain>
References: <20260209130248.29418-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209130248.29418-1-sunk67188@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21561-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zen.localdomain:mid,bur.io:email,bur.io:dkim,meta.com:email]
X-Rspamd-Queue-Id: 75CDB112EDF
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 08:53:39PM +0800, Sun YangKai wrote:
> btrfs_set_periodic_reclaim_ready() requires space_info->lock to be held,
> as enforced by lockdep_assert_held(). However, btrfs_reclaim_sweep() was
> calling it after do_reclaim_sweep() returns, at which point
> space_info->lock is no longer held.
> 
> Fix this by explicitly acquiring space_info->lock before clearing the
> periodic reclaim ready flag in btrfs_reclaim_sweep().
> 
> Fixes: 19eff93dc738 ("btrfs: fix periodic reclaim condition")
> Reported-by: Chris Mason <clm@meta.com>
> Closes: https://lore.kernel.org/linux-btrfs/20260208182556.891815-1-clm@meta.com/
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/space-info.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 1dd65fae6349..931f0dc02b95 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -2205,8 +2205,11 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
>  		if (!btrfs_should_periodic_reclaim(space_info))
>  			continue;
>  		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
> -			if (do_reclaim_sweep(space_info, raid))
> +			if (do_reclaim_sweep(space_info, raid)) {
> +				spin_lock(&space_info->lock);
>  				btrfs_set_periodic_reclaim_ready(space_info, false);
> +				spin_unlock(&space_info->lock);
> +			}
>  		}
>  	}
>  }
> -- 
> 2.52.0
> 


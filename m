Return-Path: <linux-btrfs+bounces-22016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNxQLQeNoGkNkwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22016-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 19:12:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEAD1AD5BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 19:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAA7D302643D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25E33260F;
	Thu, 26 Feb 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GZHYemSu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hXeVAWzb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675E36896C
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127417; cv=none; b=m4gQ4nN0EP33w/vQ5K8s+2hsT9eXALPqbdY8mOpUzto/uWhLu/7adH1SoomF9nGiXHIrPFK2UCk+BNjKaR+0O5n2rp1SxI19kz7+oKSj8ns2vH5LP8XE3NqsaNM4L9mGmVBRZoZ/xGO/lUfgwFuWwCgSN9QVtN+hfT0xDRXURkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127417; c=relaxed/simple;
	bh=3jeLf44Spo57uALCTONI4hOsX0XLKzWvCyej6wglDJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScJESX/H9IrhFB1DQvGOQ7feobB4rngRmWx7h3utGEByQhkqx8pnoHxTGt3D7Ye2vvOHp52jDf0uqeJTsdu9P55JBJ8/g9M8vGk9MXUXDyCrk/ke8yXxpm9XWqIXhriuoX6hexy4nRQZLhEwOKrgf1dXRBEzhYM293heghllgHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GZHYemSu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hXeVAWzb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D526D14001C8;
	Thu, 26 Feb 2026 12:36:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 26 Feb 2026 12:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772127414; x=1772213814; bh=nMqFO/sZz1
	2TaVkCqTVTS1vap/EGhi/pGIW7uHqNYTc=; b=GZHYemSuC0gL5oaTXv1LMxk3l9
	Bg5HGMxHs+b4VsJgewlv0NwgFy/fkKKLgsQHeOApFprA9sAtm4v1xq9neJ46e/0N
	UBk1bRZIG3vp3GUUI6wIUL1HhXA1saIci2M0pzYQu5YJoJCdT6vktHT5c8xC5o81
	7l1rG73opYUrmXokc3MUhMVwRAf9xkqcXnTdz7O6CP1gT8O7rhZfiLQj7t8w8jGx
	aWoNO5xQGJ8Hro9RpbQbi4XyXJ0Kx157PLTorN1ru5vu06zMP3ObYsV3riIcMIVG
	G3pqTGAO2ff/TDqfJ+8o951xkbQeyPLGFHdFkAftg7FxV0CmtTQsqo8hJcVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772127414; x=1772213814; bh=nMqFO/sZz12TaVkCqTVTS1vap/EGhi/pGIW
	7uHqNYTc=; b=hXeVAWzbL/axlpeeuuhlZwUTZvZUpQgne+TLinqILHIcszkCyvx
	UMJw47dsbckLDqIdAXdoBOcS+ptshot3/P7oOxFQ7sajRvbQMqc8WovgJecawlcJ
	fNIP+KxH3J0at7m4S0GQpcir2RLYehM2x9hJQsn60hsWmu2ADVJf740C3VENL7Kp
	Ty2+GFGA2wHRRq+iRsD6vSdiM9Bzwtyi+NrIxaETbOdCDZD4SKOExdthT6hkUPRe
	DD8sFKmSPIHRZkiEWntLGYGyl+WBnrqJLhLUejCXOwZ+4VQcfpKFMoXj/sRgxnmB
	BlWMTBjS7cisqeITzfkqq6r+mCVR9Wz+3Bw==
X-ME-Sender: <xms:toSgafrhbcAD8id3Zf-A6wTBMGi-deI8sMFpXu8rR9-vpu09xxDnsg>
    <xme:toSgafpy2569VgzA6oiVwOSeXTvTUuOPAbobxOBiz4OQGldrp6ms1yxrZIbb7s6PT
    noQ2T7ckQYFJEYRyl_U-DSLgArZ4Dp80yGUIRakHA4x63-rGQiG5CM>
X-ME-Received: <xmr:toSgaZ2GfcscK_9eDI1sl6Cv4Nv0_vsjKEk4Ze46vJcM4vRu-BOPHbPwk7zVPuReWBnilgLFnx6RmgSHn-HXitLloCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghlvgigrdhlhigrkhgrshesiigruggrrhgrrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:toSgaeCn-dEghYAcJGCXKc5xfkZOrEdgDPzhFu9YaaxhAIQbT2lTUA>
    <xmx:toSgaRc4ZqBu42pyV2aslbE-ugvI6XR_o4zf0BEX47btSGKsFd43Fg>
    <xmx:toSgaTh3tmZZmM_0fD3PYtcKyX-4LAXrnP6wCLdQ5AWMdvABwQu65g>
    <xmx:toSgaZrFAf5piL7NqVVe01ktcefi6kNbjTUjV3VntIB1UeXpvAIxCA>
    <xmx:toSgaYz3t-vlpnmxfFPnOq74BFFDzTLUfyxH5EYFkcHTrv7YWkmHSYWK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 12:36:54 -0500 (EST)
Date: Thu, 26 Feb 2026 09:37:46 -0800
From: Boris Burkov <boris@bur.io>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH-RFC] btrfs: for unclustered allocation don't consider
 ffe_ctl->empty_cluster
Message-ID: <20260226173746.GA2968189@zen.localdomain>
References: <20260226113419.28687-1-alex.lyakas@zadara.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226113419.28687-1-alex.lyakas@zadara.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22016-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zadara.com:email,messagingengine.com:dkim,bur.io:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: CCEAD1AD5BB
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 01:34:19PM +0200, Alex Lyakas wrote:
> I encountered an issue when performing unclustered allocation for metadata:
> 
> free_space_ctl->free_space = 2MB
> ffe_ctl->num_bytes = 4096
> ffe_ctl->empty_cluster = 2MB
> ffe_ctl->empty_size = 0
> 
> So early check for free_space_ctl->free_space skips the block group, even though
> it has enough space to do the allocation.
> I think when doing unclustered allocation we should not look at ffe_ctl->empty_cluster.

I see what you are saying, and a the level of this situation and this
line of code, I think you are right.

But as-is, this change does not contain enough reasoning about the
semantics of the allocation algorithm to realistically be anything
but exchanging one bug for two new ones.

What is empty_cluster modelling? Why is it included in this calculation?
Why should it not be included? Where else is empty_cluster used and
should it change under this new interpretation? Does any of this change
if there is actually a cluster active for clustered allocations?

etc. etc.

Thanks,
Boris

> 
> I tested this on stable kernel 6.6.
> 
> Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 03cf9f242c70..84b340a67882 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3885,7 +3885,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
>  		free_space_ctl = bg->free_space_ctl;
>  		spin_lock(&free_space_ctl->tree_lock);
>  		if (free_space_ctl->free_space <
> -		    ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
> +		    ffe_ctl->num_bytes +
>  		    ffe_ctl->empty_size) {
>  			ffe_ctl->total_free_space = max_t(u64,
>  					ffe_ctl->total_free_space,
> -- 
> 2.43.0
> 


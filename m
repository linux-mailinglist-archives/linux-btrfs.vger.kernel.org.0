Return-Path: <linux-btrfs+bounces-21944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK7nHmSXn2k9cwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21944-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 01:44:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC2D19F8C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 01:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3E730495C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA72335553;
	Thu, 26 Feb 2026 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Rk95Q0gU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YMXc0xeM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FF33B958
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066574; cv=none; b=FCD07HIB4oZiAh6iCRzX2KlDWTxfrwokpbWqKCm1g7s7MK3XByK79XK0q7PD0hYvYQjI6Iwv5sDfSkybddwZbve7pcY8VOGUdPGN2U4rDl7twR9Grh65UJUuURqeaLAALRtsWaPiCDPnH1evCs3heydKopHlSMEhfmgQ8AJrgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066574; c=relaxed/simple;
	bh=lCmyLNOESN3qd5IeWlFGdZn2HGIW1l3mvyw32+RAWAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9ldXhhIOyI26zupTSz8Uk4Iq2srXnnWNzVfDW6PscPc/1tGNfEp0RWPzURiZ2b4wQLn98YBtP0Bi6KmAgCqcCaYNZ5/Ra6iwy/cBOVlakN2BZ4B14mCL2VVopMWk+WTsTWiqim9elXHnz965eh/uFLic5C5eiXtbvn7Gv31/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Rk95Q0gU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YMXc0xeM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 551C77A0176;
	Wed, 25 Feb 2026 19:42:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 25 Feb 2026 19:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772066571; x=1772152971; bh=VPxMj23VAw
	Reivll5VjpWhePW/7JhE0dzIroeU1hGN4=; b=Rk95Q0gUvGvz9GXsgaz97Gt/sm
	IeGDxIXHFMbWH1juijn3KH/WVIb+2oob1mie4F/boyFBq/GbVX21+eEv3xs3LAbG
	6aZrDp/KOikOYc5U33cIDcSgg1wnKjxhlXafG7lMg7SjLgMWVVYkPAh79f1u1dMh
	ruJZcVwnzrXsPNekWXAK4pt1BaZzrPfb+VrHQZEKtumJLFzMZmzBD7+ABm6FgfQ4
	9UoDqK73GRLR8nWVfAv0ofRAcRIuia/jerDuKqDSXUI8mqaHfv3UGiUv5joAW3lY
	DqD5ZMynRLinCeWMPS5+l+jKjiNe8j7hP/fa9E7KIEr4NxRf0cEfgir1DTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772066571; x=1772152971; bh=VPxMj23VAwReivll5VjpWhePW/7JhE0dzIr
	oeU1hGN4=; b=YMXc0xeMoRKeBeZqJKkwF39R/UxqjBpONrY8Lvrw90wOmYpzeHd
	xfJZzoA3SmeUvzQZ/7cxJkI+knnN06pR30kL5GJ/ctTVnQWYGboNUkMwYTGo4QY5
	wgEC3EM/GEwuBdmQ2+CpYYhU+wyqNaOyjZ26h6QMBzF83hhE42si/oZW7qvjtrOF
	VHv/Uvd2nqTJWYgAP7duzKvlCrw4eJE7yqQBkW010jm5EJw5Rgv/DO1rUcnRXvC7
	o0s6veleefF4c3LGS3aO8zYcRnzRPTGI4kmUcm7Qi+3gj4Q7RLMUVlW40WDTMrHR
	68NvUeGp++ac/g7XmvS7cSn4gr9FdhNE2LQ==
X-ME-Sender: <xms:Cpefaa70zzMqNwXUsFdV9fw1ymPYi1kG4JEQ0giCffvV8B4t7WYuWw>
    <xme:CpefaZ4hWzL7STmOyvYXeBuhSc6RlCQWtwHvDOP3O14eGk30G1OMHgvCA4Kzgc60R
    JtpmVc00SAk5mGM04sN9JN4WZCt5YPJ51gCdJZZd8lk9hF1so4ziFk>
X-ME-Received: <xmr:CpefaXE68ob4w4LJ9A993eT9HXb-K0cPSHaTFjsSFDi4Jpi-WlzJ990ukZDUFcfGQZzSjgbRjjux279OjT-osPZxRgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CpefaSSxqht0QetffeSFhPRP9CiC6TY44yfCX-8t9-v4Ln_q2UOYzw>
    <xmx:CpefaQtCypEBbqLzwk2g_W9o7kTyIGqrYqkiHYRKZFOsoaJnlzhZng>
    <xmx:CpefaRzsL9QlEmO5qWj90uRXBt9lp2PLyqVv8AAmfGkBxlcYyg5EGQ>
    <xmx:Cpefaa5i7TPjxYmwkgoCPG45wjMxMhGnX-B4WthBPTeNOMsyRX_qDw>
    <xmx:C5efaUHoZRqEpwloZJN28UQzqW2Eh7wRBqLzkqKQpun0lVzod-Wf8Y8k>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 19:42:50 -0500 (EST)
Date: Wed, 25 Feb 2026 16:43:44 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the folio ref count ASSERT() from
 btrfs_free_comp_folio()
Message-ID: <20260226004344.GA2580843@zen.localdomain>
References: <30541df912ac4a2dd502796a823558fe1d88baa0.1772065237.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30541df912ac4a2dd502796a823558fe1d88baa0.1772065237.git.wqu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21944-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,zen.localdomain:mid]
X-Rspamd-Queue-Id: CAC2D19F8C2
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:50:38AM +1030, Qu Wenruo wrote:
> Inside btrfs_free_compr_folio() we have an ASSERT() to make sure when we
> free the folio it should only have one reference (by btrfs).
> 
> However there is never any guarantee that btrfs is the only holder of
> the folio. Memory management may have acquired that folio for whatever
> reasons.
> 
> I do not think we should poke into the very low-level implementation
> of memory management code, and I didn't find any fs code really using
> folio_ref_count() other than during debugging output.
> 
> Just remove the ASSERT() to avoid false triggering.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index e897342bece1..192f133d9eb5 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -224,7 +224,6 @@ void btrfs_free_compr_folio(struct folio *folio)
>  		return;
>  
>  free:
> -	ASSERT(folio_ref_count(folio) == 1);
>  	folio_put(folio);
>  }
>  
> -- 
> 2.53.0
> 


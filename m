Return-Path: <linux-btrfs+bounces-5990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC87918238
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5029CB22D07
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68857181BB8;
	Wed, 26 Jun 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ktt3ebb6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nmUSpZlL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yj4Rji6T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CDGZqC1g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C45156F34
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408182; cv=none; b=K/2PGvEwz5ViDsDaSF1G+yY5VglvuHvFJbx6TiLYo++BnyaCaEQFq+lE8BPMGXEvIE9vRJ6YVYSxH/Wzl0Sa39BtMHaXrckPt0rHs1BHOcmCldBiCMEMH12IMGgY61Yjae29PtUAPA39GyxCbJXtys1aredTK5v9Vtw0IEfA1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408182; c=relaxed/simple;
	bh=B82PjZcbHbRzjr2iiItQxGGy9OebVQByOhhCM5c7H2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO2W4otxmEBOOQESXsci4DNQKhIsXybz40AElSpkv2r1+Wlgd+yGOt+jrOzQB9HRAXrU6bS01TMbppj150Yzk9vLNDn4Jq8Yfa8M0ImXgusSEqaxglpoPyJwwmP40T+rBEJX+JGaye1mAToI0bI7/g5DBA1b4MIvaqGPlIyrplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ktt3ebb6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nmUSpZlL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yj4Rji6T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CDGZqC1g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8E4921A5D;
	Wed, 26 Jun 2024 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719408179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFOptXbGaqtPUMn6HWdkYaCoK8GBHmijWTOhMvbyaGY=;
	b=Ktt3ebb6YqdM7RQOY3gUytHNot+gdyHPaWRQMtPXOyFlnjNa6TK7f+6dvs/LdQDr9VeNEZ
	UNnjfogkSZrdQN2Q5znXWXazynlkLlGkuOZ1XVrZ2aORhQoWXYmBpzsY2+Gi1HOpblo5N+
	61ewZQ13xXcT4ScKQGY+/lEb8sI34Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719408179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFOptXbGaqtPUMn6HWdkYaCoK8GBHmijWTOhMvbyaGY=;
	b=nmUSpZlL6oaYoO2vpCeLcBfYTtwdOb9+e0g9bZk1DPhz1kdlqBg4nb+fw4kaJa7LgPg84E
	BdqjzX4+3AeagKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719408178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFOptXbGaqtPUMn6HWdkYaCoK8GBHmijWTOhMvbyaGY=;
	b=Yj4Rji6TgRAfsGXjAN+0R1+81GWIfi//4SvugNpNsuw9J2NivX4JwwD0VLBqqmTYduwJmf
	p4nJ0IAQlQ2jyE5H/7CSntYMAzbhTSUwt0YHi8GhD1dX8//PoAkQGqbhy0Xoatncy9l7L+
	8SIR8bFo7mLYALGP+M490JhCaDmNRHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719408178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFOptXbGaqtPUMn6HWdkYaCoK8GBHmijWTOhMvbyaGY=;
	b=CDGZqC1glrLfYAQMkeZZ4UIODYWRdf6e2Qe7QescyadPUGRvVq8c+NNkSZ+mMkH/iftiek
	kgj1svIHopkfo8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B30BD13AAD;
	Wed, 26 Jun 2024 13:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tdYwKzIWfGbRPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Jun 2024 13:22:58 +0000
Date: Wed, 26 Jun 2024 15:22:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't check NULL ulist in ulist_prealloc
Message-ID: <20240626132257.GZ25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3034f66918cf06066b769f4d834905e25824ae8c.1719336718.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3034f66918cf06066b769f4d834905e25824ae8c.1719336718.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Tue, Jun 25, 2024 at 10:32:11AM -0700, Boris Burkov wrote:
> There are no callers with a NULL ulist, so the check is not meaningful.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ulist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> index f35d3e93996b..fc59b57257d6 100644
> --- a/fs/btrfs/ulist.c
> +++ b/fs/btrfs/ulist.c
> @@ -110,7 +110,7 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
>  
>  void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
>  {
> -	if (ulist && !ulist->prealloc)
> +	if (!ulist->prealloc)

You can also add an assert so it's visible that it's the assumption.

>  		ulist->prealloc = kzalloc(sizeof(*ulist->prealloc), gfp_mask);
>  }
>  
> -- 
> 2.45.2
> 


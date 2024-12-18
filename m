Return-Path: <linux-btrfs+bounces-10587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27C9F6ED1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC837A3CDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A81FC7C5;
	Wed, 18 Dec 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSJOCP6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpC/oDth";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSJOCP6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpC/oDth"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AD158536
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553283; cv=none; b=hX7hWXzshH1egbzhtgYpc98uY7zP4/B3XESlvoEd5KZMIcPFos3tM6kG0viW94BKzT/MaPwARvtE04/woQ6JTt8L46fDHq2ify0wdrdY99o37DcfzuN1CK7x+Y0SLDU71mzaqip9pNGpbmJyZHEzNiSPsgX5h4Qesd0aIP99a9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553283; c=relaxed/simple;
	bh=0bagFJ6SDEpHUpFqVLkfbTGl+Dd5nNXPgHTyVl0flN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWPrmFqyt9nQHoHzgVz9OIEqzeuQbqhGNjYWv1O+xDBVSznqSPY0xy10O9E27/npswMVnTNSTfOtZNpCoXJ/1kcBfeU3a/sBtBtTPgglKFr+qFnsc3wxY5kphloiLpFdwhX41WJF4JpfOo7ezL4nwIN1fc4bCBhD5g49t6cHVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSJOCP6V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpC/oDth; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSJOCP6V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpC/oDth; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 058151F396;
	Wed, 18 Dec 2024 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734553279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnsyov90ZQtKlkjxSfyj63ccl79T+mOZBMfUQ07UGeQ=;
	b=sSJOCP6VkWdh4V6vK6XrBMvEBauafyHZ3XwUFTSqfqpnvcbX0fahB4WpR1HZxE8ImmFZvs
	pfcFA6dR7lfBOh6Bz9M1EheKy8FQwbuoUwc8ZgmMz2JdzvhiuB4Vf6C7ag9qk6aYI0ENUk
	i5PyTjfFGIlLtfOLmoxEMDTemKFQEdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734553279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnsyov90ZQtKlkjxSfyj63ccl79T+mOZBMfUQ07UGeQ=;
	b=RpC/oDthEqjcrWMJAHNuOdHdn40JDRLV3CyCCFvnypVEhSG0MMkdFMYetgPH/lHlVPncEy
	5dLGsZ88YS1om/Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sSJOCP6V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="RpC/oDth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734553279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnsyov90ZQtKlkjxSfyj63ccl79T+mOZBMfUQ07UGeQ=;
	b=sSJOCP6VkWdh4V6vK6XrBMvEBauafyHZ3XwUFTSqfqpnvcbX0fahB4WpR1HZxE8ImmFZvs
	pfcFA6dR7lfBOh6Bz9M1EheKy8FQwbuoUwc8ZgmMz2JdzvhiuB4Vf6C7ag9qk6aYI0ENUk
	i5PyTjfFGIlLtfOLmoxEMDTemKFQEdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734553279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnsyov90ZQtKlkjxSfyj63ccl79T+mOZBMfUQ07UGeQ=;
	b=RpC/oDthEqjcrWMJAHNuOdHdn40JDRLV3CyCCFvnypVEhSG0MMkdFMYetgPH/lHlVPncEy
	5dLGsZ88YS1om/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD06137CF;
	Wed, 18 Dec 2024 20:21:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qbRzNb4uY2e3DAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 20:21:18 +0000
Date: Wed, 18 Dec 2024 21:21:17 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into
 fs.c
Message-ID: <20241218202117.GG31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734368270.git.fdmanana@suse.com>
 <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 058151F396
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Dec 16, 2024 at 05:17:17PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The ctree module is about the implementation of the btree data structure
> and not a place holder for generic filesystem things like the csum
> algorithm details. Move the functions related to the csum algorithm
> details away from ctree.c and into fs.c, which is a far better place for
> them. Also fix missing punctuation in comments and change one multiline
> comment to a single line comment since everything fits in under 80
> characters.
> 
> For some reason this also sligthly reduces the module's size.
> 
> Before this change:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1782126	 161045	  16920	1960091	 1de89b	fs/btrfs/btrfs.ko
> 
> After this change:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1782094	 161045	  16920	1960059	 1de87b	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ctree.c | 51 ------------------------------------------------
>  fs/btrfs/ctree.h |  6 ------
>  fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/fs.h    |  6 ++++++

Can you please create a new file for checksums? Moving everything to
fs.c looks like we're going to have another ctree.c.


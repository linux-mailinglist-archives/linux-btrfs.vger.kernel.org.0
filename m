Return-Path: <linux-btrfs+bounces-13899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA7AB3F0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48456861FA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F0729614E;
	Mon, 12 May 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TM+O3B6M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="whnp+4Pi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TM+O3B6M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="whnp+4Pi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C081E2602
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071041; cv=none; b=G8JZ7nTM5cjwJSAGC0imfDAJNvdv1HQWh1qYZj39FfhF6QiPugPRb7tfghFuytjcZ06bCtlckznj39EcXhQ4BCpXq7WqDwBluO/30FYtPG4DOIaJJT91+epPRzQ08e/lzyeh1UH9WC0JAXsfEfvlonE01/IF5xKqRvxeKX5YIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071041; c=relaxed/simple;
	bh=ggLkGctho1v7Es+esxcEg6Pz8JTgv5DWKDchyu9gWFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4vxFvWy/pRmKexutSwQfbPiHd8ELvl96Yb8JUGNb2eRaMZd4g3xjjai1xlwuaVPIRsKMSuNKazkeyHF1cLY4BfZs2py8qjotoy/VWodvxK8dZ64YpKQdF1GCIHwCbMLY1KJeplqTROjbXpiQPgXcYg1yX8xZjmqsxt1lHPy18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TM+O3B6M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=whnp+4Pi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TM+O3B6M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=whnp+4Pi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70D2D1F387;
	Mon, 12 May 2025 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747071037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ry5MgFOENFc99tFs+JZJPVhqt1ryankve2RdLbvc6Q=;
	b=TM+O3B6M2OeAyTqBSECTBQBU9e129I4SDnsF/v4w4e5Isq9ZMELJG5clATXsY98z+rroDR
	nlgbrEF2wjmmiXF9ge973Zr5FoBPerWd1ZXq2hglAvht4gsFnTU40q+QnufFSc43gXJ5lP
	8Ct2/FISUPeBFSbJCK05JVEIt7A0sVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747071037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ry5MgFOENFc99tFs+JZJPVhqt1ryankve2RdLbvc6Q=;
	b=whnp+4Pi+f+vgY5v5C1c+Z+pTKXX7GZt42ZOq25VT9AS9gp+XKsP+qNOHjKWzlRLpvAr6P
	xoF6TCHijDnOq2Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TM+O3B6M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=whnp+4Pi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747071037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ry5MgFOENFc99tFs+JZJPVhqt1ryankve2RdLbvc6Q=;
	b=TM+O3B6M2OeAyTqBSECTBQBU9e129I4SDnsF/v4w4e5Isq9ZMELJG5clATXsY98z+rroDR
	nlgbrEF2wjmmiXF9ge973Zr5FoBPerWd1ZXq2hglAvht4gsFnTU40q+QnufFSc43gXJ5lP
	8Ct2/FISUPeBFSbJCK05JVEIt7A0sVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747071037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ry5MgFOENFc99tFs+JZJPVhqt1ryankve2RdLbvc6Q=;
	b=whnp+4Pi+f+vgY5v5C1c+Z+pTKXX7GZt42ZOq25VT9AS9gp+XKsP+qNOHjKWzlRLpvAr6P
	xoF6TCHijDnOq2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5862A137D2;
	Mon, 12 May 2025 17:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8fEWFT0wImj7dAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:30:37 +0000
Date: Mon, 12 May 2025 19:30:36 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove superfluous return value check at
 btrfs_dio_iomap_begin()
Message-ID: <20250512173036.GT9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <77971c6472d403679457a3d241e4c70df45eff4c.1746808801.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77971c6472d403679457a3d241e4c70df45eff4c.1746808801.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 70D2D1F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.21

On Fri, May 09, 2025 at 06:05:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the if statement that checks the return value from
> btrfs_check_data_free_space(), there's no point to check if 'ret' is not
> zero in the else branch, since the main if branch checked that it's zero,
> so in the else branch it necessarily has a non-zero value.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>


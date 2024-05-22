Return-Path: <linux-btrfs+bounces-5213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A3D8CC594
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253E3285933
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32871422C9;
	Wed, 22 May 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A5B7KhaG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B1fOGKfL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDgVnOZS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r82FM/Hu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83A76048
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399240; cv=none; b=kZOUQbIQUgvJdrtTaMYvJSrAjwSZQL7zYIFGUb8JYYwpB3Lcu0B8kLdKJeXpCFbF0nnmCkA9yS3Qx2vRiIRwAuQprZY0KQWsYM9VU2XmNHLu+bv9iVFPB33RShZGSUzBjCAQopHKlmk05v6CsMv7KibmmuUBgNa54+ln+D2toa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399240; c=relaxed/simple;
	bh=p2GIyPGpnMQuO8tRXSsqoS93SPELQrZY0V1M6cs6CHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCpfgOPCARzxPj4umEFLVWL2qVwOpxaHu5YHZS6D67RO5Sa47w4PchPR9/DWA47nqG5WCFsr7OKEBqhjJzEP4Y6QR7uUcflLdy2zJ2kdn0hwC8ktP89gTqOpqm/z0VuqdigGRaOrbpUgiFjcLxt4g0p2VQdzo3LPCiG60BPPQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A5B7KhaG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B1fOGKfL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tDgVnOZS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r82FM/Hu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB8231F397;
	Wed, 22 May 2024 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716399237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGfLYoLgR1RRRKNJ7YEyEOzuE6/2t6reAO1aa3BT5DA=;
	b=A5B7KhaGHtP8fp7TJqv3CjhkrMmntnhTGm2NkeQbb1L4+p/2EngjrA/dATA8huUpQVULj/
	mqKvz0/QOga5pxXLIc1gYBHCPgJ2Ne16G54zRZ65KWQQuIx/qLtXpfEEFBCu/A06ycyUgX
	OdI0LI/lszLuwRO8e+SX0nFED3Aj1GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716399237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGfLYoLgR1RRRKNJ7YEyEOzuE6/2t6reAO1aa3BT5DA=;
	b=B1fOGKfL5ASPrqc3J/PjmRcHuS9C4yyKS1O1EP0YKiUZEuaMGcaHa2gcd4S5mP97RBENKC
	RkjA10UMdrlZm9DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716399235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGfLYoLgR1RRRKNJ7YEyEOzuE6/2t6reAO1aa3BT5DA=;
	b=tDgVnOZSImLhExpblPt0SRpHqFV1ZnkF1hZo010icf5gd0coUFFcLb55zn+vrYLDVSPFw4
	wT964NxQHdi2u2OXTfTPRKBq3nRFGZP7fud4XSrT5Zq9zJl7iGA58TpyykLOy10eMnaM3Q
	0PIsGXsykRpjUYkt1uWKOlswe/lMxus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716399235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGfLYoLgR1RRRKNJ7YEyEOzuE6/2t6reAO1aa3BT5DA=;
	b=r82FM/Hu1r0vHhrSe2Sp0e4UEfLjyWvRfvOPdZqdYcB/Nij0uhIptghlyRntWdd3g4eSzo
	HBoHPM3YUa6o4LBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B057813A1E;
	Wed, 22 May 2024 17:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id POfrKoMsTmaXBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 May 2024 17:33:55 +0000
Date: Wed, 22 May 2024 19:33:45 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move fiemap code from extent_io.c to inode.c
Message-ID: <20240522173345.GA17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b686d5a9dbccf9fbfafc5d805bdf463083c1544c.1716388860.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b686d5a9dbccf9fbfafc5d805bdf463083c1544c.1716388860.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Wed, May 22, 2024 at 03:43:58PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the core of the fiemap code lives in extent_io.c, which does
> not make any sense because it's not related to extent IO at all (and it
> was not as well before the big rewrite of fiemap I did some time ago).
> 
> Fiemap is an inode operation and its entry point is defined at inode.c,
> where it really belongs. So move all the fiemap code from extent_io.c
> into inode.c. This is a simple move without any other changes, only
> extent_fiemap() is made static after being moved to inode.c and its
> prototype declaration removed from extent_io.h.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/extent_io.c | 871 ------------------------------------------
>  fs/btrfs/extent_io.h |   2 -
>  fs/btrfs/inode.c     | 872 +++++++++++++++++++++++++++++++++++++++++++

With so much code moved and no dependencies, you could also move it to a
new file so we don't bloat inode.c.


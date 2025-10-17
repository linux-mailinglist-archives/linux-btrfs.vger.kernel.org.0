Return-Path: <linux-btrfs+bounces-17969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72BBEAE36
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558545C0054
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D896F2D3EEA;
	Fri, 17 Oct 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GG0iJmvl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTLki53Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MNgSMCf5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XNr3DYTk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF042D062A
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719400; cv=none; b=VpYwQQ3UnzGiF4oFB4DLMPAJ9u32lyCKIGuyVSVp8OwMOdLDBraubHNkjIA5FyVUf9mKkR1FGXQ7HuXBxw7kj17KfPhwkJolWLUAmxtHFt/WFUGUWkXgkFKrTcr8iG3IS00uZ7UwCNgNkIaSAD+j5+uyxQ04fkimCVGwpCGspws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719400; c=relaxed/simple;
	bh=FvYSAhuDrZUMg+LKW5F/XmdLjCSz0XzOqsc6C+HmJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UngRGKo4zyFE2UUFQdx2Vq6iy3Id4cqnOCfSsa/aewd2ei/m6/4f6NW3Zj1WSGNp6TbAvdjZiZQ6zDdE3r8m15ejQDp56f7gQrG8kuBo025WVZkA1ysDLBamPD2gtn1PR3Lbb7dO8/QLcox2IATbvFxmItppeAxwF051OiKjk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GG0iJmvl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTLki53Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MNgSMCf5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XNr3DYTk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDBBB2225E;
	Fri, 17 Oct 2025 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760719396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvYSAhuDrZUMg+LKW5F/XmdLjCSz0XzOqsc6C+HmJfA=;
	b=GG0iJmvlYt6XimlRwyZprNeuHdYCqEeEvdGtYgp4DwXX6g+3beePNnXdJtHiVtBIzNHEPw
	Vv9qdDxGzutYHeJZXeZ75Y+jsYiaLC20cQZgY8pspi9DgO1a/wiNKbNytSXAJmLhuqd/xn
	IlrfCM7ghv25KsGtyElV65w+yVEMFmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760719396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvYSAhuDrZUMg+LKW5F/XmdLjCSz0XzOqsc6C+HmJfA=;
	b=QTLki53Y1dVXlLvkuQ8iTC5uYTzSigEqTOIIPwKpWjtdI4enqnIfkaBoBeCM0kjfjcwwFu
	5vZxcs22Fm1JUQCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MNgSMCf5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XNr3DYTk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760719395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvYSAhuDrZUMg+LKW5F/XmdLjCSz0XzOqsc6C+HmJfA=;
	b=MNgSMCf5he2EJwRcDIXyNFxWfxEwzn1AlLrDs9TlnUISx8EYu2QcYvhwKfhDlFl2PMbZHd
	lg+poGvKUVgj40vF95x2EYwmP0T9S7mXyRqRgcxgUnoOWv0AffsPj1vfDEEk2bJ6Ugput8
	24IHrE0/EbvDmyMQiVg9LFCrS4uy26U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760719395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvYSAhuDrZUMg+LKW5F/XmdLjCSz0XzOqsc6C+HmJfA=;
	b=XNr3DYTk7LHn/u+BorD8HoTvIHLGS0G5sfF9n41pPNL6jj2Jf9kU+FERiknvr/0/XJLi6y
	wbWWz5I9y+bl/sDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4B4713A71;
	Fri, 17 Oct 2025 16:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hOLWLyNy8mj3WgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 Oct 2025 16:43:15 +0000
Date: Fri, 17 Oct 2025 18:43:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 8/8] btrfs-progs: string-utils: do not escape space while
 printing
Message-ID: <20251017164314.GL13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251015121157.1348124-1-neelx@suse.com>
 <20251015121157.1348124-9-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015121157.1348124-9-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: DDBBB2225E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Oct 15, 2025 at 02:11:56PM +0200, Daniel Vacek wrote:
> Space is a valid printable character in C. On the other hand
> string "\ " in fact results in an unknown escape sequence.

The space is escaped because the helper is used to print stream dump
or tree dump where space is the separator, so this patch would break it.
Unless there's another reason than esaped space is not valid in C then
we can't do that.


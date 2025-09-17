Return-Path: <linux-btrfs+bounces-16874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60887B800BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28DC324F62
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 04:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E37B238179;
	Wed, 17 Sep 2025 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnVDaCTQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SAMhR/aH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnVDaCTQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SAMhR/aH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B221D3C0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084048; cv=none; b=mkpoag7rA9llumvUsjuC25XLq8rJualbyrT0uDfIDOXy/5FErzyvJ0STrraChwUDc6F+8qM8tCjAf6eRCVjI1dn3F2MBCaDq9lfWso9iPjvQEIrVC74CQ56JUtbQfdEiOBsP3NYASWMWY4RIDMgtweZJGjMzUJWJ/0BmnhAXvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084048; c=relaxed/simple;
	bh=RTF80+PpKhk6mUH5uQgs68xU1WHflX0HpMAFPFxAF24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceg2K+vdvMio0bt7qjBZ/T/nmxKQwonOXQa9DLJId3DNJ+HvLB6G29ZYXGt3Ku4QcCRZBgfe9uVD0JjSYt5WOXmal4OkQD1gI/reyPL4amIhWuCckQSWiuoOAml1/HXJkZ9yP189MPywz31iWObzMHk4vOTsZEOq780hsDpwGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnVDaCTQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SAMhR/aH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnVDaCTQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SAMhR/aH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9995722330;
	Wed, 17 Sep 2025 04:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758084044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uNm8qbDPxh3A/osdceQ4RqoJTXHoxTKrGwBpdyccAo=;
	b=JnVDaCTQvqvN4yoOEzJsc71wPlKBljVb5fv+cDYgcDqbUm6aVB+ps7i2WYXEdWwBSpgYKI
	CgM87C515ZnHITBmsPPPEHTUofoJC9fDtGznK40s7lnBu7BVOGo0VDKoqS8ux3FFy+JhEb
	1TPHoZxEz9vktP9AADsfQiKcRmO/WQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758084044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uNm8qbDPxh3A/osdceQ4RqoJTXHoxTKrGwBpdyccAo=;
	b=SAMhR/aHNCZnV87hezPInLLZF/v9VZ290kEijB/sYQxysaXXtueRuMiFjZ9a5qQ6C07Vcq
	HGTiGz8lp+fA/kCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758084044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uNm8qbDPxh3A/osdceQ4RqoJTXHoxTKrGwBpdyccAo=;
	b=JnVDaCTQvqvN4yoOEzJsc71wPlKBljVb5fv+cDYgcDqbUm6aVB+ps7i2WYXEdWwBSpgYKI
	CgM87C515ZnHITBmsPPPEHTUofoJC9fDtGznK40s7lnBu7BVOGo0VDKoqS8ux3FFy+JhEb
	1TPHoZxEz9vktP9AADsfQiKcRmO/WQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758084044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uNm8qbDPxh3A/osdceQ4RqoJTXHoxTKrGwBpdyccAo=;
	b=SAMhR/aHNCZnV87hezPInLLZF/v9VZ290kEijB/sYQxysaXXtueRuMiFjZ9a5qQ6C07Vcq
	HGTiGz8lp+fA/kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A2DB1368D;
	Wed, 17 Sep 2025 04:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 33A/Hcw7ymj/QAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 17 Sep 2025 04:40:44 +0000
Date: Wed, 17 Sep 2025 06:40:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: WenRuo Qu <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: tree-checker: fix the incorrect inode ref size
 check
Message-ID: <20250917044043.GE5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b01a9d93d21d7be986b45b84baffc3237e5ec3e5.1757975029.git.wqu@suse.com>
 <a5de779f-e62a-4fa2-9aae-167d312f17bc@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5de779f-e62a-4fa2-9aae-167d312f17bc@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Sep 16, 2025 at 06:48:26AM +0000, Johannes Thumshirn wrote:
> On 9/16/25 12:24 AM, Qu Wenruo wrote:
> > [BUG]
> > Inside check_inode_ref(), we need to make sure every structure,
> > including the btrfs_inode_extref header, is covered by the item.
> >
> > But our code is incorrectly using "sizeof(iref)", where @iref is just a
> > pointer.
> >
> > This means "sizeof(iref)" will always be "sizeof(void *)", which is much
> > smaller than "sizeof(struct btrfs_inode_extref)".
> >
> > This will allow some bad inode extrefs to sneak in, defeating
> > tree-checker.
> >
> > [FIX]
> > Fix the typo by calling "sizeof(*iref)", which is the same as
> > "sizeof(struct btrfs_inode_extref)", and will be the correct behavior we
> > want.
> >
> > Fixes: 71bf92a9b877 ("btrfs: tree-checker: Add check for INODE_REF")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> 
> This is the reason I always go for "sizeof(struct XXX)".

In this case the sizes refer to the on-disk format so this should be the
explicit struct sizeof everywhere (but it is not).


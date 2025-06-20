Return-Path: <linux-btrfs+bounces-14816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAAAE1AE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D35817780E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0A28A1C5;
	Fri, 20 Jun 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u0oXERgJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZavtSotM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T9WXQkAi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aS6aEaO+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F672080E8
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422300; cv=none; b=Sai+qW++r4YZzWbcHFU//bILrsMnMHMs2tYqExCfhhc+6o+0/tNuppDNUG/mvZv0KAt5X8+5mL+qZPCaWa8FfD6AesRpkacYz6+OqIm3TT211bl8xL4wn78J39P174mJcIuLjgtNEIkKaBJPR1FEZoyF+se1bIsBDvTjmUCmk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422300; c=relaxed/simple;
	bh=kQ57ynQHlzguTCtd25OsxWeyGSATwkUu6klxgJ1OZn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrXNNyZDvmo5AQ8GFYnsy4yWQksFl/k2tRTaJfwyzlC+AEH/qJvJAetDg+uRPaHnflVI/grFN6RQZwX+vyIBedzDPu6YpdcaihNi1EmyLGM433HivsCh5Itx7aGLbyL/ZK81UlNvPZhCb6LK1etMkGQYBONb+HP+rPojoZ2w0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u0oXERgJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZavtSotM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T9WXQkAi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aS6aEaO+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D42942120C;
	Fri, 20 Jun 2025 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750422297;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PW0iIxe9ZNKz17kTP3+6HZcuvg8xdWqNczi9Txt7Pp0=;
	b=u0oXERgJHTutHWiOm+ygaHwy89GT4IZJri/RIUWIIKTK/czp6vP7JmRoau4cNWjGaphzkQ
	RhLVMifvg1K+F7aVhFab6+8SnTlpFLKNWw90Y5V7wVnnGGK44zwV3ZyPmjBj8p9qsPqEnM
	6xvX6AI2I1I1FyKFXx5QS7cyX7Q/3Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750422297;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PW0iIxe9ZNKz17kTP3+6HZcuvg8xdWqNczi9Txt7Pp0=;
	b=ZavtSotMpV2nh21UjGd3bXEh2z3O3+ruGxKDBANM7uYgdwQH4tUwIRy0+I4Dt9CJUBlNay
	GXPAfdNwnnV+4zCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750422295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PW0iIxe9ZNKz17kTP3+6HZcuvg8xdWqNczi9Txt7Pp0=;
	b=T9WXQkAiRRPOXDg+V4xHTMigfcOQXpaPp2A1oablK+TaNJ0f1r8gS08yFaXkSLs8KEkHht
	CNY0oV/0zZ5TNcl86Q6hSnrw/M+U1/H8lD2VotU7QloDYMF2/ZbSd3oFg4nvCzsElRLWAj
	RJnq7eNhO5iALfLkLmQOLhNhrUA//1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750422295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PW0iIxe9ZNKz17kTP3+6HZcuvg8xdWqNczi9Txt7Pp0=;
	b=aS6aEaO+CCuZZnYULAyFGoDasenUbhXj2IGBsIRLZRvpj361nzdPji9PlygjawnYLo/kZ1
	McWhV2z653UiDVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA39C136BA;
	Fri, 20 Jun 2025 12:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qq5LKRdTVWg+JwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 12:24:55 +0000
Date: Fri, 20 Jun 2025 14:24:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Brahmajit Das <listout@listout.xyz>
Cc: Mark Harmstone <mark@harmstone.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, kees@kernel.org
Subject: Re: [PATCH] btrfs: replace deprecated strcpy with strscpy
Message-ID: <20250620122454.GQ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250619140623.3139-1-listout@listout.xyz>
 <c278bbd3-c024-41ea-8640-d7bf7e8cff47@harmstone.com>
 <gsykswmdo5yusthxun4y5duhim6etxirrfezq6o6w4tlalcvxp@3wqjjzurypzc>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsykswmdo5yusthxun4y5duhim6etxirrfezq6o6w4tlalcvxp@3wqjjzurypzc>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[godbolt.org:url,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Jun 19, 2025 at 11:32:58PM +0530, Brahmajit Das wrote:
> On 19.06.2025 18:03, Mark Harmstone wrote:
> > On 19/06/2025 3.06 pm, Brahmajit Das wrote:
> > > strcpy is deprecated due to lack of bounds checking. This patch replaces
> > > strcpy with strscpy, the recommended alternative for null terminated
> > > strings, to follow best practices.
> > 
> > I think calling strcpy "deprecated" is a bit tendentious. IMHO the way to proceed
> > is to use KASAN, which catches the misuse of strcpy as well as other bugs.
> > 
> Understood, thanks for point it out.
> > > ...snip...
> > 
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -215,7 +215,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
> > >   	u32 size_bp = size_buf;
> > >   	if (!flags) {
> > > -		strcpy(bp, "NONE");
> > > +		memcpy(bp, "NONE", 4);
> > >   		return;
> > >   	}
> > 
> > These aren't equivalent. strcpy copies the source plus its trailing null - the
> > equivalent would be memcpy(bp, "NONE", 4). So 4 here should really be 5 - but
> > you shouldn't be hardcoding magic numbers anyway.
> > 
> > On top of that memcpy is just as "unsafe" as strcpy, so there's no benefit to
> > this particular change. gcc -O2 compiles it the same way anyway:
> > https://godbolt.org/z/8fEaKTTzo
> > 
> > Mark
> > 
> 
> I was planning to use strscpy, but it doesn't work with char pointers,
> hence went with memcpy. If you or anyone has a better approach for this,
> I'm more than happy to send that as a v3.

As the code is structured, you can move "NONE" as initial value of buf
in describe_relocation() and just return from "if (!flags)".


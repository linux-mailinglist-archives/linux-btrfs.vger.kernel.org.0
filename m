Return-Path: <linux-btrfs+bounces-12018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11BCA4FBD4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5937A31D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2F2063E9;
	Wed,  5 Mar 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvoFtwmT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RNvQNb1W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvoFtwmT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RNvQNb1W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEB205AB0
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170309; cv=none; b=VjBXITg63A3V0DIu+2HYGU5MPOWc36gBTbD88RI1VjDyvbhiQhqPo0iOU7lUGTOlYjFieoBEjExrrBd88b3hSCakSHHZngCUM6ZntWFgky1Q65mbt16U5uZhRIR4fSpvMAdIlqxlLekMZUBLnnm1FOkZjJqT5rEp0Wlpc26MIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170309; c=relaxed/simple;
	bh=7le0azVsRwxkZ2pxXVX34E5CXyzTxjqEBLhjYz6/EJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjVcMXfTO/+W7TVgtZxq5RvuDD5nRm9dGgEH5vicZtaRGwJqhxkLf6/t3yosWRQ55vt2ZuTRuhjKPnx1hrULrltPmpwMxgukDf1J+2p94hudne1hArPV22Nso+epiiPTUyUno00yMeRTOmk0qfM7uIp0oP3lquyLn69BN1VsS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvoFtwmT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RNvQNb1W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvoFtwmT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RNvQNb1W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0DEDC1F74C;
	Wed,  5 Mar 2025 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741170305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPH+SECyvxafHBlJEk1aODWlF5+/c05b340DwKC3YAQ=;
	b=wvoFtwmThcBpnuHdXQ4wWUepUQBth4TSvMqTXOMQGE+4raSxOep7hj8NinPh76M3a7L7KR
	0z0gMCngYdcE0G8ojhsjw0K7+m54o+2b3Pppq8tfDMcHqLvZPkT7Os0dMtlxczkzrHVPfI
	kefSB6V3pp4qeJcv26fFmBmDSYoGp/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741170305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPH+SECyvxafHBlJEk1aODWlF5+/c05b340DwKC3YAQ=;
	b=RNvQNb1WbOtfZvQWCs79h/KvKOkSANJORDcRuQpYmaANjWWcRAGb0rzLjpvwybjySLM4of
	yMFT5o//3ZLzvIDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741170305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPH+SECyvxafHBlJEk1aODWlF5+/c05b340DwKC3YAQ=;
	b=wvoFtwmThcBpnuHdXQ4wWUepUQBth4TSvMqTXOMQGE+4raSxOep7hj8NinPh76M3a7L7KR
	0z0gMCngYdcE0G8ojhsjw0K7+m54o+2b3Pppq8tfDMcHqLvZPkT7Os0dMtlxczkzrHVPfI
	kefSB6V3pp4qeJcv26fFmBmDSYoGp/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741170305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPH+SECyvxafHBlJEk1aODWlF5+/c05b340DwKC3YAQ=;
	b=RNvQNb1WbOtfZvQWCs79h/KvKOkSANJORDcRuQpYmaANjWWcRAGb0rzLjpvwybjySLM4of
	yMFT5o//3ZLzvIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1AB31366F;
	Wed,  5 Mar 2025 10:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y0l5NoAmyGfGfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Mar 2025 10:25:04 +0000
Date: Wed, 5 Mar 2025 11:24:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fi defrag: allow passing compression levels
Message-ID: <20250305102459.GC5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250304172712.573328-1-neelx@suse.com>
 <e8cd2383-1466-4f4f-bc88-cf0ba8f04e60@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8cd2383-1466-4f4f-bc88-cf0ba8f04e60@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Mar 05, 2025 at 08:10:24AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/3/5 03:57, Daniel Vacek 写道:
> > zlib and zstd compression methods support using compression levels.
> > Enable defrag to pass them to kernel.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >   Documentation/ch-compression.rst | 10 +++---
> >   cmds/filesystem.c                | 55 ++++++++++++++++++++++++++++++--
> >   kernel-shared/uapi/btrfs.h       | 10 +++++-
> >   libbtrfs/ioctl.h                 |  1 +
> >   libbtrfsutil/btrfs.h             | 12 +++++--
> >   5 files changed, 77 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/ch-compression.rst b/Documentation/ch-compression.rst
> > index a9ec8f1e..f7cdda86 100644
> > --- a/Documentation/ch-compression.rst
> > +++ b/Documentation/ch-compression.rst
> > @@ -25,8 +25,8 @@ LZO
> >           * good backward compatibility
> >   ZSTD
> >           * compression comparable to ZLIB with higher compression/decompression speeds and different ratio
> > -        * levels: 1 to 15, mapped directly (higher levels are not available)
> > -        * since 4.14, levels since 5.1
> > +        * levels: -15 to 15, mapped directly, default is 3
> > +        * since 4.14, levels 1 to 15 since 5.1, -15 to -1 since 6.15
> 
> I believe the doc updates can be a separate patch since it's not related
> to the new defrag ioctl flag.

In progs I don't mind either way, included in the functional change or
separate.


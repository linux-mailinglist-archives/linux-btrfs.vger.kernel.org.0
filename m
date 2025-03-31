Return-Path: <linux-btrfs+bounces-12701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33557A7711C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 00:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755A73AA05B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 22:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8A21C19A;
	Mon, 31 Mar 2025 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="strTa0Lr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGQON3YF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="strTa0Lr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGQON3YF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149353232
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743461834; cv=none; b=ukJKRf9rgaqxc9PdLDqUpxorYm2DlRcNmVJktSh5e/mtAYumSCFOV1A989p6nRWFg/WT2Lds+u7jzdvvkVg8/YngtvBV6o/q8SdHezEuoQP+4sF3GK/4TyS8mSrDev/vSlasYAQ3GNDB0uGZ6WuhhUCZu/CAIdXR8lFxQ/lcGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743461834; c=relaxed/simple;
	bh=zKFJSHs161Kj1rJcsiHjj79fh80o5f52Hf7drc9dp2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYUFu75MK6ooU99eXtxPGQuJy9cQIbGTQs70muEXUTPM0JAiXolV32UE9cV0gHIuJtmtRtN0+OA75WJNto9L4I3BHeNpMhpyFPYeR24Pi4fsgjAB0zl38xPe3BTBwI29G9OUs0Jcic9vRkkHGdsmlleQNUqcxABIZYY3WpLNTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=strTa0Lr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGQON3YF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=strTa0Lr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGQON3YF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8DAC1F38D;
	Mon, 31 Mar 2025 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743461830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ys8hL+LIRtio497s+LkIzT4yGVnFde+A4h/mMPP/Uc=;
	b=strTa0LrdY/lei6xcNrLLZKRde++1vLwty3AHzIBMNnzD+EXOeuuUdPAChzcDOaq/sou17
	Tv97dd6PfNH9he1+fSGjap3gJAcnvLiMsgRLxkAmytt6QNhB9Jg5/aSBE16otVhpD4CqDD
	wo20FU2rxXSOlHYABJfd1xPxLEH63F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743461830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ys8hL+LIRtio497s+LkIzT4yGVnFde+A4h/mMPP/Uc=;
	b=VGQON3YFhGxK8y72Yy/tW2pIIrIZMgN3IUxYsqBV9Ps9y7/xqr5jO+roahCMwR/B3yUHiW
	cMG0FP/Tm3qh/7DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=strTa0Lr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VGQON3YF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743461830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ys8hL+LIRtio497s+LkIzT4yGVnFde+A4h/mMPP/Uc=;
	b=strTa0LrdY/lei6xcNrLLZKRde++1vLwty3AHzIBMNnzD+EXOeuuUdPAChzcDOaq/sou17
	Tv97dd6PfNH9he1+fSGjap3gJAcnvLiMsgRLxkAmytt6QNhB9Jg5/aSBE16otVhpD4CqDD
	wo20FU2rxXSOlHYABJfd1xPxLEH63F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743461830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ys8hL+LIRtio497s+LkIzT4yGVnFde+A4h/mMPP/Uc=;
	b=VGQON3YFhGxK8y72Yy/tW2pIIrIZMgN3IUxYsqBV9Ps9y7/xqr5jO+roahCMwR/B3yUHiW
	cMG0FP/Tm3qh/7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E19A139A1;
	Mon, 31 Mar 2025 22:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E9c8IsYd62cGTAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 31 Mar 2025 22:57:10 +0000
Date: Tue, 1 Apr 2025 00:57:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
Message-ID: <20250331225705.GN32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250331082347.1407151-1-neelx@suse.com>
 <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B8DAC1F38D
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 01, 2025 at 07:44:01AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/3/31 20:36, Daniel Vacek 写道:
> [...]
> >>>                        btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >>>                        btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >>>                        btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> >>> +             } else if (strncmp(param->string, "zstd-fast", 9) == 0) {
> >>> +                     ctx->compress_type = BTRFS_COMPRESS_ZSTD;
> >>> +                     ctx->compress_level =
> >>> +                             -btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
> >>> +                                                       param->string + 9
> >>
> >> Can we just use some temporary variable to save the return value of
> >> btrfs_compress_str2level()?
> >
> > I don't see any added value. Isn't `ctx->compress_level` temporary
> > enough at this point? Note that the FS is not mounted yet so there's
> > no other consumer of `ctx`.
> >
> > Or did you mean just for readability?
> 
> Doing all the same checks and flipping the sign of ctx->compress_level
> is already cursed to me.
> 
> Isn't something like this easier to understand?
> 
> 	level = btrfs_compress_str2level();
> 	if (level > 0)
> 		ctx->compress_level = -level;
> 	else
> 		ctx->compress_level = level;
> 
> >
> >> );
> >>> +                     if (ctx->compress_level > 0)
> >>> +                             ctx->compress_level = -ctx->compress_level;
> >>
> >> This also means, if we pass something like "compress=zstd-fast:-9", it
> >> will still set the level to the correct -9.
> >>
> >> Not some weird double negative, which is good.
> >>
> >> But I'm also wondering, should we even allow minus value for "zstd-fast".
> >
> > It was meant as a safety in a sense that `s/zstd:-/zstd-fast:-/` still
> > works the same. Hence it defines that "fast level -3 <===> fast level
> > 3" (which is still level -3 in internal zstd representation).
> > So if you mounted `compress=zstd-fast:-9` it's understood you actually
> > meant `compress=zstd-fast:9` in the same way as if you did
> > `compress=zstd:-9`.
> >
> > I thought this was solid. Or would you rather bail out with -EINVAL?
> 
> I prefer to bail out with -EINVAL, but it's only my personal choice.

I tend to agree with you, the idea for the alias was based on feedback
that upstream zstd calls the levels fast, not by the negative numbers.
So I think we stick to the zstd: and zstd-fast: prefixes followed only
by the positive numbers.

We can make this change before 6.15 final so it's not in any released
kernel and we don't have to deal with compatibility.


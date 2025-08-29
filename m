Return-Path: <linux-btrfs+bounces-16517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE84B3AEC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 02:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB11F3B1D2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 00:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0C2B652;
	Fri, 29 Aug 2025 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHakK5hV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OG9oi8hQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHakK5hV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OG9oi8hQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01D256D
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425768; cv=none; b=hU0olv+wFNZFdopHw+ROVWB0DHh6mrfFJvo/cQP1wV6IBynBrKDDiBsnbWio+uggl0rTr8oUS9QdksJ8tjX9mnLzXHLew1uShbkv3N5+2XkAvP2LMIfiStoD+QLwHP2oJuKD3QSK2JpbzWwx0O7eqKIgdFvx0VHUOcHj8f8MCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425768; c=relaxed/simple;
	bh=el5+OesOQi3fUaalpbqHjd+lzWwf9NhU1PR1mwdmkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khYy9MR2T6SCw/CJQFBOTti5XGP2dLWqAyhCExKvHQkm18bWyxfI7FttWyZC+81I+YhRGHW6AY3xUQKRDYzyYjbIUcXaXOhkwgZHGEon27fdNvbZVQP5pOQVVHQ3g7MiQGjU3qECrBTp9i9bp88kQccZzHM+/MG5c+JPEY3Ls5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHakK5hV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OG9oi8hQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHakK5hV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OG9oi8hQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0434F33A26;
	Fri, 29 Aug 2025 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756425765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+j874v/wuGLcFgAL9bmP/C4kNlq6y3Es6BC5N8UpMEo=;
	b=oHakK5hVcPcxJYJnzH8Ajf8Evp+hJhJeJ/iXu58D20h7dcABH/al2QyLQZDEQLJ8o2BaDB
	g1ZvH0Bg4dEnN24q+3i2UniRBfo7DsMx22IuXYZ+SDU2JdCPfi28ZTlOANAEgMSs3U9Fte
	OFmiqUxId6EwTY/KcCfLnjfilTJv/Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756425765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+j874v/wuGLcFgAL9bmP/C4kNlq6y3Es6BC5N8UpMEo=;
	b=OG9oi8hQfaMoWNYHTTvG8uzwLcPFHm5+krgF/HlNoqgIUUQ8jJOQdRlSXsSQOWAGbzsx1p
	Btrc6YxYAZtwwtBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oHakK5hV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OG9oi8hQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756425765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+j874v/wuGLcFgAL9bmP/C4kNlq6y3Es6BC5N8UpMEo=;
	b=oHakK5hVcPcxJYJnzH8Ajf8Evp+hJhJeJ/iXu58D20h7dcABH/al2QyLQZDEQLJ8o2BaDB
	g1ZvH0Bg4dEnN24q+3i2UniRBfo7DsMx22IuXYZ+SDU2JdCPfi28ZTlOANAEgMSs3U9Fte
	OFmiqUxId6EwTY/KcCfLnjfilTJv/Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756425765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+j874v/wuGLcFgAL9bmP/C4kNlq6y3Es6BC5N8UpMEo=;
	b=OG9oi8hQfaMoWNYHTTvG8uzwLcPFHm5+krgF/HlNoqgIUUQ8jJOQdRlSXsSQOWAGbzsx1p
	Btrc6YxYAZtwwtBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E510D1372E;
	Fri, 29 Aug 2025 00:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xrfBNyTusGgBcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Aug 2025 00:02:44 +0000
Date: Fri, 29 Aug 2025 02:02:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20250829000243.GH29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250826165619.GC29826@twin.jikos.cz>
 <5006600.GXAFRqVoOG@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5006600.GXAFRqVoOG@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0434F33A26
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Wed, Aug 27, 2025 at 08:24:33PM +0800, Sun YangKai wrote:
> > On Fri, Aug 22, 2025 at 11:51:18PM +0800, Sun YangKai wrote:
> > > > Please split the patch to parts that have the described trivial changes,
> > > > and then one patch per function in case it's not trivial and needs some
> > > > adjustments.
> > > 
> > > After learning more about the auto-free/cleanup mechanism, I realized that
> > > its only advantage is to eliminate the need for the goto out; pattern.
> > > Therefore, it seems unnecessary to apply this conversion in non-trivial
> > > cases.
> > I wouldn't say it's the only advantage, the code readability is also
> > improved. The path is an auxiliary object and if the freeing is handled
> > automatically then it reduces the cognitive load and the error cleanup
> > paths.
> > 
> > > Moreover, if the cleanup code contains other logic, it might be better to
> > > leave it unchanged even in trivial cases.
> > 
> > Depends on what we want. So far we've started with the path auto
> > cleaning but there are more possibilities like using the raw __free
> > cleanup with kfree. If this is combined and leads to simpler exit and
> > cleanup blocks I think it's worth. In the trivial cases it's clear it
> > does not interfere with the rest of the code and does not complicate any
> > logic there.
> > 
> > > > The freeing followed by other code can be still converted to auto
> > > > cleaning but there must be an explicit path = NULL after the free.
> > > 
> > > I'm sorry, I didn't understand. If the freeing is followed by other code,
> > > maybe we could just leave them untouched?
> > 
> > Maybe yes, this is up to consideration on a per site basis, I've seen
> > examples where conversion to auto path cleaning would not hurt.
> > 
> > Let me know if you want to continue with this because I think you don't
> > seem to see the value in the conversions (which is fine of course).
> 
> I apologize if my previous comments came across as unclear — I certainly see 
> the value in the conversions. My intention was actually to discuss in which 
> specific scenarios these conversions would be most proper, so that we can align 
> on how to apply them.
> 
> Based on your suggestions, I'll restrict the conversions to the following 
> scenarios:
> 
> 1. Cases where there are no operations between btrfs_free_path and the 
> function return.

OK

> 2. Cases where only simple cleanup operations (such as kfree, kvfree, 
> clear_bit, and fs_path_free) are present between btrfs_free_path and the 
> function return.

Also OK

> Please let me know if these criteria align with what you had in mind.

Yes please do the trivial ones described above, we'll see what's left
after that.


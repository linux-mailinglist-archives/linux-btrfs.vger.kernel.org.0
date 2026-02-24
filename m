Return-Path: <linux-btrfs+bounces-21872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJMmADStnWmgQwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21872-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 14:52:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDA188091
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 14:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B75033066BE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218039B4A2;
	Tue, 24 Feb 2026 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27+zAAse";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QCsTvjc0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HzpaC9P8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3HEHFmU5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD62874FA
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941162; cv=none; b=iJA8joxUbRlmPa3h3vU9rnjQVnF9MfF5HcWl4KLQ5LFVF1IDfTKNRm16Qodf5Z0pJnH6q7gMh+2Qph4WbqlfW6fL75a7esbR+w9DxCCUjABQQb3+vFlcF63cB+ZZ8gdDDZ0JAOB0JS03ZiIB9109L9oSz4u1tBJaAYIr2ZHglTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941162; c=relaxed/simple;
	bh=LH+G2U6RPWykWhO2JNW7ADKaaHd8XhN5aVC598XN29s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J94Dq4ZGOsnxOqfemq/ZYovnMDHoeucmc59LILqQ4rqCPyxJ0/yRVVicZPA5XQsNaFDrBzFZpCgikgxq5FSX9025zKp5RcVDZP7YjqNEF/3u8LgxNQWLi97ILrC4dMQHAHJt9/EV/xrLXIAGY5rDuu3vbATQ+e3f7sIHACTFGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27+zAAse; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QCsTvjc0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HzpaC9P8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3HEHFmU5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8FF55BCDC;
	Tue, 24 Feb 2026 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771941159;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkRq5ye6Pe91phtbLBRxS/V+bYQF3Ax39UaxFgJ9CxE=;
	b=27+zAAseBICsKwxLB02LhEBwGAo0JE+iUNstsDdS5pMhFyV2XBo69ZkBFZ7ewnUrMpThhA
	xlt6H2/MJPCcSxkjvdMZOF170pWD1tj6F/hmSKuPNea7cjkGq0GttkDef8i6sxAGyCT0m2
	aXhYZcItwy0kvZw0Uz026UwYcpoQVKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771941159;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkRq5ye6Pe91phtbLBRxS/V+bYQF3Ax39UaxFgJ9CxE=;
	b=QCsTvjc0LTXzuHV8rwLqv5sZjXY66ly7sgH8kYkqBD9uEYm69un+RhiLCwUbEvZP7e2k9E
	uA57c514HKxCKjDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HzpaC9P8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3HEHFmU5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771941157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkRq5ye6Pe91phtbLBRxS/V+bYQF3Ax39UaxFgJ9CxE=;
	b=HzpaC9P8QzX0ikvGwsbH5TyNpV60RhDfiXpTNfbCWVUCIcfPjTa/Xpcg0ZNIx3x4S4s9H/
	SUYdvKmKndp5eVxujJ+T6Fh1f/9NmP2ooikAFKYpsd79FTJ7yPc+zbVvtchwWAAIYpdTDX
	MKmE27ixTw+3R8ndrAYq+yeORB/kbvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771941157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkRq5ye6Pe91phtbLBRxS/V+bYQF3Ax39UaxFgJ9CxE=;
	b=3HEHFmU5gm+NBwBQtYxCmjDmSb6K3OmLazSZl4DXkYl+MOsznqXqYZ814B23alBtadIrbi
	IwMR1ZTuDoCAQwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B803EA68;
	Tue, 24 Feb 2026 13:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ndLjLCWtnWk7JAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 13:52:37 +0000
Date: Tue, 24 Feb 2026 14:52:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>,
	dsterba@suse.com, clm@fb.com, naohiro.aota@wdc.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kees@kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Message-ID: <20260224135236.GS26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260223234451.277369-1-mssola@mssola.com>
 <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
 <3c295815-6359-472c-9703-c755b4623aed@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c295815-6359-472c-9703-c755b4623aed@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-21872-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim,mssola.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92FDA188091
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 03:12:07PM +1030, Qu Wenruo wrote:
> 在 2026/2/24 15:07, Qu Wenruo 写道:
> > 在 2026/2/24 10:14, Miquel Sabaté Solà 写道:
> >> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
> >> introduced, among many others, the kzalloc_objs() helper, which has some
> >> benefits over kcalloc().
> >>
> >> Cc: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
> >> ---
> >>   fs/btrfs/block-group.c       | 2 +-
> >>   fs/btrfs/raid56.c            | 8 ++++----
> >>   fs/btrfs/tests/zoned-tests.c | 2 +-
> >>   fs/btrfs/volumes.c           | 6 ++----
> >>   fs/btrfs/zoned.c             | 5 ++---
> >>   5 files changed, 10 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index 37bea850b3f0..8d85b4707690 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info 
> >> *fs_info, u64 chunk_start,
> >>       if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> >>           io_stripe_size = 
> >> btrfs_stripe_nr_to_offset(nr_data_stripes(map));
> >> -    buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
> >> +    buf = kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);
> > 
> > Not sure if we should use *buf for the type.
> > 
> > I still remember we had some bugs related to incorrect type usage.
> > 
> > Another thing is, we may not want to use the kzalloc version.
> > We don't want to waste CPU time just to zero out the content meanwhile 
> > we're ensured to re-assign the contents.
> > 
> > Thus kmalloc_objs() maybe better.
> 
> Sorry I only mean for some particular call sites, like this one.
> 
> Not all call sites can be converted to kmalloc version, and will need 
> proper inspection one by one.

I'd rather keep the zeroing version, we do it almost everywhere as a
precaution. The CPU time spent on that is not significant.


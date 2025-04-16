Return-Path: <linux-btrfs+bounces-13106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D8A90CFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64AA019E08E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1424229B35;
	Wed, 16 Apr 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCD63ns1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lvqK7uH0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCD63ns1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lvqK7uH0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C450226D08
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834861; cv=none; b=E5bZMLIx1RLjwj4PTfJNy5qnf0BZjkCwchE4P5Mn029LRM8pqRBg4gN1zRyGQt8H3KImlE4NYEWougCsYcUgovKA2axdrnkhhzfoIbemW4SFcQ6uP8O30u04YDsp8SVlBSfvcVQlxTNAbpU68lA0vmVTVZ+Xs1vsmFRB2OFbzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834861; c=relaxed/simple;
	bh=5yA04NJe/w88xvvONWDI9J+hO1f17gzO5wt0Y2LFSvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkIDWCHMMDqT+A5+SCTmu8FarWP1RMurMf0/U6EjPMNHpIvMjFuxXe4aN/A6kyi7pDEAK8iPOugP71KywmYXxyIXVOk+ueu8DZZnWG9A4kx/yFfoAlfCFLkw4YH0zjFaHdKSK5i9+DDBtcKhImNlPy5T0dYP7v+AjqzMn2ikh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCD63ns1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lvqK7uH0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCD63ns1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lvqK7uH0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C1E01F745;
	Wed, 16 Apr 2025 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744834857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMMqM69frYFbzPEAB5eaPbOuJG3qmuyFPb5ooJwgvM=;
	b=FCD63ns1Beb362cppebs4P/ig2UCGslPiLRqQ6Vh+jsNuef3MascBXBXi19/A22Hgkm/n2
	YwGwZHw+vpEDoGOxWuubmofqAaIMLXb2VE+FfQHcyaE/KBJTTA/mpG7MFIj7F8HsdMl/sx
	3ucGLctTWJoo5TwCUxGfWEP4W3qFTPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744834857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMMqM69frYFbzPEAB5eaPbOuJG3qmuyFPb5ooJwgvM=;
	b=lvqK7uH0syO8mc+DyvCjkOaqBD5lXjDX93DNdV/v9DzWqvTfS75iZrE6LnOcZjST1UZyjq
	54BJigO07Z5d7MCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FCD63ns1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lvqK7uH0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744834857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMMqM69frYFbzPEAB5eaPbOuJG3qmuyFPb5ooJwgvM=;
	b=FCD63ns1Beb362cppebs4P/ig2UCGslPiLRqQ6Vh+jsNuef3MascBXBXi19/A22Hgkm/n2
	YwGwZHw+vpEDoGOxWuubmofqAaIMLXb2VE+FfQHcyaE/KBJTTA/mpG7MFIj7F8HsdMl/sx
	3ucGLctTWJoo5TwCUxGfWEP4W3qFTPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744834857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMMqM69frYFbzPEAB5eaPbOuJG3qmuyFPb5ooJwgvM=;
	b=lvqK7uH0syO8mc+DyvCjkOaqBD5lXjDX93DNdV/v9DzWqvTfS75iZrE6LnOcZjST1UZyjq
	54BJigO07Z5d7MCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F637139A1;
	Wed, 16 Apr 2025 20:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GzMRCykRAGg2LQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 20:20:57 +0000
Date: Wed, 16 Apr 2025 22:20:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Assertion and debugging helpers
Message-ID: <20250416202055.GG13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744794336.git.dsterba@suse.com>
 <dbdf0811-6359-428b-bf23-79e793973c12@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbdf0811-6359-428b-bf23-79e793973c12@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5C1E01F745
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Apr 16, 2025 at 08:25:56PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/16 18:38, David Sterba 写道:
> > Hi,
> > 
> > this is a RFC series. We need to improve debugging and logging helpers
> > so there's no ASSERT(0) or the convoluted
> > WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)). This was mentioned in past
> > discussions so here's my proposal.
> > 
> > The series is only build tested, I'd like to hear some feedback if this
> > is going the right direction or if there are suggestions for fine
> > tuning.
> > 
> > 1) Add verbose ASSERT macro, so we can print additional information when
> > it triggers, namely printing the values of the assertion expression.
> > More details in the first patch, basic pattern is something like
> > 
> >      VASSERT(value > limit, "value=%llu limit=%llu", value, limit);
> 
> I think the idea is pretty good for debug.
> 
> I have hit too many cases where outputting the values will immediately 
> help me pinning down the cause, other than adding extra outputs and then 
> curse myself being too stupid.
> 
> 
> But the concern is, we already have too many different debugging tools 
> just inside btrfs:
> 
> - btrfs_warn()/btrfs_err()/btrfs_crit()
>    These are the most sane ones so far, and they saves us a lot of time
>    debugging things like memory bitflip in tree-checkers.

Neither of that is mean for debugging, this is for users and for system
logs. The rules are described at https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#message-level

Though now that I see it, it does not mention btrfs_crit(), we have
about 60 of them and I think some of them could be turned to
btrfs_err().

> - btrfs_debug()
>    Looks like the least used ones, if someone is actively utilizing it,
>    please let me know.

Yeah, I think they've been there historically but I don't see any
consistent use. We may start deleting them as well or turning to trace
points if it's some notable event like repairing a block. Where it may
make sense is some internal debugging infrastructure like the leak
checkers to do a report before umount.

We can still keep the macros and helpers if anybody needs to write
custom debugging messages, I do that rather with btrfs_err with
searchable prefix so it's logged by default.

> - WARN_ON()

This is probably the most disordered way of debugging also present in
the release builds. The known problem is also that some systems are
configured to panic on warn so even a harmless warning has a bad impact.
I'd like to have them all audited and removed or replaced by something
more specific with an error so we don't have to guess the intentions for
the warnings. But this needs to be done case by case, there are about
300 of them.

> - ASSERT()
>    I'm definitely the abuser, almost all my patches have utilized one at
>    least.

This is actually good, please add more. The best time to add assertions
is when the code is written because the invariants and assumptions are
known.

We have the documentation at
https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#handling-unexpected-conditions
it may need some updates to give better guidelines.

> Now we will have another one, and we will need another set of rules for 
> the newer one.
> 
> I know everyone loves new things, but I think we should sometimes to get 
> it more consistent.

I'd like to unify and eventually reduce the number of the logging or
debugging primitives we use.

> So, if we're pushing towards VASSERT(), then it should replace all 
> ASSERT() eventually. At least mark the ASSERT() macro deprecated and 
> stop new usages.

You can consider VASSERT equivalent to ASSERT, the only reason it's a
different macro now is because I'd have to implement the variable number
of arguments and printk. But I can look into that, I agree that having
just ASSERT would be best in the long term.


Return-Path: <linux-btrfs+bounces-19913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5ABCD242A
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 01:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230C1305DCEB
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561D2045AD;
	Sat, 20 Dec 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KdBJWuKB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jSaV6ug";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KdBJWuKB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jSaV6ug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2F1EDA03
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Dec 2025 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190283; cv=none; b=fhkJ+OfI9C8jG2m/nQtpq7WfQeIDuumwnv3ZY01W7UmQkcAPqZo0OLO/zC1h70Tc23uMu24I4HGxKZt+vw5lfkrYzFJvpgZWnj/YBPOq5GgkgYeCOFPPBbN6Rgs2J0gxjOjn18c3xUe/vSXmTOtXnqU2qlNg0ifYqnVZjB4aAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190283; c=relaxed/simple;
	bh=nRMWHvesVOB/nLV0kxLFdAv/rhSliZFw0zVMxQ8dNMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfLn/QcVfh9HYm1K+mmJ7LZyw1ixG8v+alwQRwyJhy8mSIKxs1pP7eD+gbxFwAwlaHP2kvLCgZ0hwORqB9kPPNZEruhCNeockPd/D88bpiopNs/05PvR0gxveZ/oBIo0SpQutyGt4l9EY3qaNPevzj4xH6mEskTegygUnB3Akhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KdBJWuKB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jSaV6ug; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KdBJWuKB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jSaV6ug; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD3C233743;
	Sat, 20 Dec 2025 00:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766190276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv8DnT9Pl2Qua0BArgzjaEYGVadRYHtQdksUGrEvoVc=;
	b=KdBJWuKByg4yQeDY86I1Q9MP5J5M1p93kcJ4nSUXgee/QApXdafV8dQtAnjCdWWChB9DIs
	ZCnsZvD8UupJ1Rm2AX1CcVhwdCPPHAQlfPXPmuonASuuzqkrzirwQ9ukXr5op5AOLX3+mD
	Sn00o7HHdTgUbfJlsoaymDH4c0lapBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766190276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv8DnT9Pl2Qua0BArgzjaEYGVadRYHtQdksUGrEvoVc=;
	b=2jSaV6ugT+ckpQ3ft9KO3kTT0/wg2UaZmOoB+rw+NgypSNaSbGIw5LzQeE8JIJvDmoDdny
	fHB25urVMQAMUmDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KdBJWuKB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2jSaV6ug
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766190276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv8DnT9Pl2Qua0BArgzjaEYGVadRYHtQdksUGrEvoVc=;
	b=KdBJWuKByg4yQeDY86I1Q9MP5J5M1p93kcJ4nSUXgee/QApXdafV8dQtAnjCdWWChB9DIs
	ZCnsZvD8UupJ1Rm2AX1CcVhwdCPPHAQlfPXPmuonASuuzqkrzirwQ9ukXr5op5AOLX3+mD
	Sn00o7HHdTgUbfJlsoaymDH4c0lapBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766190276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv8DnT9Pl2Qua0BArgzjaEYGVadRYHtQdksUGrEvoVc=;
	b=2jSaV6ugT+ckpQ3ft9KO3kTT0/wg2UaZmOoB+rw+NgypSNaSbGIw5LzQeE8JIJvDmoDdny
	fHB25urVMQAMUmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9528D139DE;
	Sat, 20 Dec 2025 00:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K9wxJMTsRWkGLAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 20 Dec 2025 00:24:36 +0000
Date: Sat, 20 Dec 2025 01:24:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: show correct warning if can't read data reloc tree
Message-ID: <20251220002427.GD3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251219181550.12901-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219181550.12901-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: AD3C233743
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Fri, Dec 19, 2025 at 06:15:28PM +0000, Mark Harmstone wrote:
> If a filesystem is missing its data reloc tree, we get something like
> this in dmesg:
> 
>   BTRFS warning (device loop11): failed to read root (objectid=4): -2
>   BTRFS error (device loop11): open_ctree failed: -2
> 
> objectid is BTRFS_DEV_TREE_OBJECTID, but this should actually be the
> value of BTRFS_DATA_RELOC_TREE_OBJECTID.
> 
> btrfs_read_roots() prints location.objectid on failure, but this isn't
> set when reading the data reloc tree. Set location.objectid to the
> correct value on failure, so that the error message makes sense.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Added to for-next, thanks.


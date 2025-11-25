Return-Path: <linux-btrfs+bounces-19346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B2C8606E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 17:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBB4E4028
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDB5326930;
	Tue, 25 Nov 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kkt+9xbQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="23+2uELL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kkt+9xbQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="23+2uELL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6F242D8E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089173; cv=none; b=CU1rjP9QTrBgRKVgLl/rVplmQhJWA7aAT8pO3Z6pPvopPNcApKe3FjQ2lDySNjMvdWLWQ4a4gVpBEfrPi+HnHnlIycD7WOUnBqquUVMe+4axKIsL5d6QNZTyQRkUrAnGhlQqPNXloFfAFDT33LFJ1V3Tbw4RLpc3+NWnGO8r/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089173; c=relaxed/simple;
	bh=ze2GDEzNDSWZ9hEOWTpVjN4cYYrDAySyKEr8AemhTLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBRLC6ZB6K2Ja4equTaFZaXkzNFX91XEfR7PNEQZa3pyAruaDCGn7F9yCuH8PibReoli49kNNdzIACkj1NN3IMDcMffyXSzs+vZ5xbhwKuyd4mLy/S7aFdT0fNDbYnSPF8oY+J9Kg8L5McnnPPkltaIhCLxBIfw5ebmEzbZye1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kkt+9xbQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=23+2uELL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kkt+9xbQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=23+2uELL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5714E2171F;
	Tue, 25 Nov 2025 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764089168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6GTS6d26NhOQvJ+af1KK6C3PcVoE4DCzzPmhElDMb8=;
	b=kkt+9xbQan12irGY+J+ZjY+1qmUsCjhj+3cUasYQgsuhjvwcnw46w3TqgQDwLkrqrCP9CV
	5jDgZvX8hRNA8pJZ+8ygfvxq0mwShXNYb9171j/nn82drPRqvlIenCzwu6FzYKgZe8x8kj
	3mMEkS/pJlwYv2CeE815iE8rWevqyPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764089168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6GTS6d26NhOQvJ+af1KK6C3PcVoE4DCzzPmhElDMb8=;
	b=23+2uELLF9krJLJVPSDGdsQ7X25f4TE/gENL8rK6XUPq6Y/XOhRIQGmXn84T/ZwTZ+I3tg
	ul9PSl2JtLxJzcAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kkt+9xbQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=23+2uELL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764089168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6GTS6d26NhOQvJ+af1KK6C3PcVoE4DCzzPmhElDMb8=;
	b=kkt+9xbQan12irGY+J+ZjY+1qmUsCjhj+3cUasYQgsuhjvwcnw46w3TqgQDwLkrqrCP9CV
	5jDgZvX8hRNA8pJZ+8ygfvxq0mwShXNYb9171j/nn82drPRqvlIenCzwu6FzYKgZe8x8kj
	3mMEkS/pJlwYv2CeE815iE8rWevqyPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764089168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6GTS6d26NhOQvJ+af1KK6C3PcVoE4DCzzPmhElDMb8=;
	b=23+2uELLF9krJLJVPSDGdsQ7X25f4TE/gENL8rK6XUPq6Y/XOhRIQGmXn84T/ZwTZ+I3tg
	ul9PSl2JtLxJzcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3615E3EA63;
	Tue, 25 Nov 2025 16:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5PQJDVDdJWlpbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Nov 2025 16:46:08 +0000
Date: Tue, 25 Nov 2025 17:46:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: use true/false for boolean parameters in
 btrfs_{inc,dec}_ref
Message-ID: <20251125164603.GZ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251122063516.4516-2-sunk67188@gmail.com>
 <20251122063516.4516-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122063516.4516-3-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5714E2171F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Sat, Nov 22, 2025 at 02:00:43PM +0800, Sun YangKai wrote:
> Replace integer literals 0/1 with true/false when calling
> btrfs_inc_ref() and btrfs_dec_ref() to make the code self-documenting
> and avoid mixing bool/integer types.
> 
> No functional change intended.

You don't need to write this sentence to the changelog, in this case
it's obvious it's a simple change, and complicated changes would be
explained in full.


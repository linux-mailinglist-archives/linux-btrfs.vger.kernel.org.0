Return-Path: <linux-btrfs+bounces-21359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN1hOc1Rg2mJlQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21359-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 15:03:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F7E6CF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3D54300D682
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA32286408;
	Wed,  4 Feb 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QF+T+uNr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OWyfKxt5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IepbqCxj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MbncMzi9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC6285CB9
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213826; cv=none; b=afPKNHv9XJF1ivAgISPzUDSNmAjxNrif4x/QdtEBXk0n9SzwHIRpKGvDvpCeg/tGtAzPcoJomS1irobpYk3ILGhr+TH1bHsBOrJSk5CsRHVn/mXt1YLDu8cJSNX4LSKWI4TTisZ9FHEucb4b3HD3HVe4NN9NhXxDYdrkkzj3NmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213826; c=relaxed/simple;
	bh=A3ngxaNVFe9cKT4pzwtL7DYM1tdAv4eKOo2lnOBJVB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB0zwEtt9B5l5muztxiMCL8H3tkU/dp6/BEuokJ6fZPPGPJkbDml0mA9yiaOE9h8+iB5a7EkR7ZzPDdN0zZVcpjtjsJ27wjAKtmw3hwl/S7Qv0y/6svg5ADP6XEEB8hcQ4FUePO2h65NwjMkaF5+DZYRxhh8huUCDEeFcDcLTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QF+T+uNr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OWyfKxt5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IepbqCxj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MbncMzi9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44E523E73D;
	Wed,  4 Feb 2026 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770213824;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXcRIZNOiKqJMuSz2h98HwkqbhfKWyOwRd5ZBnk0hfs=;
	b=QF+T+uNrK6fbkRpmnpnb6/HNhWKzj/Z1vchnbikxK48av58SinwHhVVjF9fzfqy9mR6N17
	BaBHWpoeMVgzmvOA/5i0j2Wika2I8jlsLGBHkaG/ak1TvRs2VcCNoia75fG9wCj/84aBrR
	ci7uP6q3ZRF9kiVo8U6wlo88u60puOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770213824;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXcRIZNOiKqJMuSz2h98HwkqbhfKWyOwRd5ZBnk0hfs=;
	b=OWyfKxt5kE8Nz4z9oY4BZwQ3ofwza6dYUp6DujUUCjnJN4nSBjSz+8nuTMOOnc3VeMkc/A
	1V0yecHXsBFIA9Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770213823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXcRIZNOiKqJMuSz2h98HwkqbhfKWyOwRd5ZBnk0hfs=;
	b=IepbqCxjN0I2sS2Pw18R4GwmozY/c3a72F3+XN3ttMjEdy9MCTi68GTH00e6DwBOwY5PhE
	3tv8wIWhR7ywBVDQgTzEt1iJzHGiI5yQYEzG/JJpm9reNjXi3UoOXP7yfephrqW+RfZ8wZ
	vxse0Nn8MjYf4MDZyORyb8wcZ0lRfuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770213823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXcRIZNOiKqJMuSz2h98HwkqbhfKWyOwRd5ZBnk0hfs=;
	b=MbncMzi9P4xvl41dURTmjzDYQxTYO82QlOwMiRTXxuEYU3X8Ew/5/tzIMeLB7TDWJtUKIB
	GMQ3z23/qUcEMMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB5C3EA63;
	Wed,  4 Feb 2026 14:03:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zUhQB79Rg2lEKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Feb 2026 14:03:43 +0000
Date: Wed, 4 Feb 2026 15:03:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Adarsh Das <adarshdas950@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: clean up two FIXMEs related to
 btrfs_search_slot output handling
Message-ID: <20260204140341.GQ26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260203172357.65383-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203172357.65383-1-adarshdas950@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21359-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	HAS_REPLYTO(0.00)[dsterba@suse.cz]
X-Rspamd-Queue-Id: A02F7E6CF6
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:53:55PM +0530, Adarsh Das wrote:
> Both patches fix cases where a search with offset (u64)-1 gets an
> unexpected exact match. The first silently returned success, and the
> second crashed the kernel. Both now both log an error and return -EUCLEAN.
> 
> Adarsh Das (2):
>   btrfs: handle unexpected exact match in btrfs_set_inode_index_count()
>   btrfs: replace BUG() with error handling in __btrfs_balance()

Added to for-next, thanks.


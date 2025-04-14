Return-Path: <linux-btrfs+bounces-12983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74205A87BCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B17173025
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3825F964;
	Mon, 14 Apr 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PFAoR7Ek";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Prcl1iwK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxKvh6lM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tHz5QMMA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8825D906
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622582; cv=none; b=b76Tg2mnpdkIOQ5mux3vboYQ+y1g82oqgkEGkjaOO+XqwDcbZk1An5DSNnAehBJD6DsOTB+MEgWpl6T564szsLi+2RGM2u53UsvyBff4tRRTSx0yvy4Q2uq1oerlQNoGtf6Z9fp42D83EE1Ex7ZONooKCHgtsiCZS1P/iabcVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622582; c=relaxed/simple;
	bh=xnCc7LUdCE8A0jAetS5WlNpM1cLLzzzYqwEDyHMWkD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3reU+Zj3BCWUJCmHBnwRvk9stRuS9bgyQH6+77ZQIEUzNVeTxn6m6PWpF5XTUvRPc6kBGsSsOFKqP0Ldaz0IV2aaGJGsEGj3nyX2/51daKfmRPkEC4WHH8u1tvjDhO2Qf7q8VbWPz5JyDEcQkg5egJ/CdECdouxKWS1Ch8XAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PFAoR7Ek; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Prcl1iwK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxKvh6lM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tHz5QMMA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5853A2125D;
	Mon, 14 Apr 2025 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744622578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTJ2sT8ir4Gfn1MTTn6LhWi1R6St8alGrdGiGAdMgLg=;
	b=PFAoR7Ek0yy6zm05Efw1DG7iNMKzXoOMdUIswbk+bimpGO5kAxL5tbwu/CLS9V6QfX/5OI
	Q99+YGnGcgW0AOtRs5ndOE7oHzgEgtrMaRGMrsTfSglMBQjtQ/1GkK7ludn+xTehJTzUa1
	3IOSV7IKDxG22h1E9eitimY5nhZ9l98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744622578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTJ2sT8ir4Gfn1MTTn6LhWi1R6St8alGrdGiGAdMgLg=;
	b=Prcl1iwKct5UEhVTw0+5YwBdMzJ3v9ofwQPxV1yYXGc5dyNt6/zUPPGSN4mZbKBTxKAs9l
	aZqTNShSXLj3trCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zxKvh6lM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tHz5QMMA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744622577;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTJ2sT8ir4Gfn1MTTn6LhWi1R6St8alGrdGiGAdMgLg=;
	b=zxKvh6lMdtNRaakbbadbPmIZ3J9qbkgki0pYzHKV7q5r3xT3werS80Vrz+AQvKbsOjbIs4
	YsAmq+uKn3oDFkV8bKwfbVl4u/q7pw2VYqYYXrp1FJdAR0DA/AcnJFh0N2TcpL2WjpV3IS
	6vROV6hQaunpkYlbfivTZnZtlQGWXJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744622577;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTJ2sT8ir4Gfn1MTTn6LhWi1R6St8alGrdGiGAdMgLg=;
	b=tHz5QMMApoC++KogAIvXz+VrZovgm5mj5aFxNuVX3TN7AMfZ7y77m/knPafb6ealWlH2t2
	EGRaG+dlbZB2P4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37583136A7;
	Mon, 14 Apr 2025 09:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VkIoDfHT/Gc6MQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Apr 2025 09:22:57 +0000
Date: Mon, 14 Apr 2025 11:22:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: use BTRFS_PATH_AUTO_FREE in
 btrfs_truncate_inode_items()
Message-ID: <20250414092251.GB16750@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250411034425.173648-1-frank.li@vivo.com>
 <CAPjX3Fe34HVF2JUi2DEyxqShFhadxy7M7F6xTA_yVn5ywHMBhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Fe34HVF2JUi2DEyxqShFhadxy7M7F6xTA_yVn5ywHMBhQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5853A2125D
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 11, 2025 at 04:17:38PM +0200, Daniel Vacek wrote:
> On Fri, 11 Apr 2025 at 05:25, Yangtao Li <frank.li@vivo.com> wrote:
> >
> > All cleanup paths lead to btrfs_path_free so we can define path with the
> > automatic free callback.
> >
> > And David Sterba point out that:
> >         We may still find cases worth converting, the typical pattern is
> >         btrfs_path_alloc() somewhere near top of the function and
> >         btrfs_free_path() called right before a return.
> >
> > So let's convert it.
> >
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/btrfs/inode-item.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> And what about the other functions in that file? We could even get rid
> of two allocations passing the path from ..._inode_ref() to
> ..._inode_extref().

If you mean to pass the path object from btrfs_del_inode_ref() to
btrfs_del_inode_extref() yeah this looks like a good optimization and
reducing the allocations (and potential failures).

The other cases in the "..._inode_ref" is btrfs_insert_inode_ref() ->
btrfs_insert_inode_extref().


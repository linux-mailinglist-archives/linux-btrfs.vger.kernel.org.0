Return-Path: <linux-btrfs+bounces-13038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95957A8A4BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3427F3ACC9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF929B76A;
	Tue, 15 Apr 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WtrzozNu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5YpNjzs4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VPBQPNXm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LvJd3XBZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D41494A3
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736188; cv=none; b=XFGD3niyHxLcBOb+xcAzMUVS3VSn1oXKfu4sGrpKdxckIkudwrjyWmkYr+WaRNZM7r1dxEd0Z5vN48jKk9XqdELU5eqjTMiESSkiOuD09h1hNbdFuQv0H6cSgQPIR6KZl+a6fX3xhzirgkU2PLUAPrhjuus3j3okmypsb2hyuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736188; c=relaxed/simple;
	bh=nvKJNwdkY59IRgR8oQHj65EXd7mGG2FjBnI13GWNDKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0/M1K7BRf8rz4YfF0KwAGHuk86yi7tQ4YcYmdkc2DAlOw6bfxxOinjV/CetmFCn9IdntVWUJaQxmaq1y4TwPG2lI9GNEK3lfQ8bfBsHKOXUTYludnpbePP04/P2DSDLq0ES6aHCrKpgktqv4jO7kPg9h+fdnOapmZ9/ADve4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WtrzozNu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5YpNjzs4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VPBQPNXm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LvJd3XBZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D694721185;
	Tue, 15 Apr 2025 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744736185;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhhsZ9+6PesM7nozGYDV2ADpryOPgfTLgFa4TXtmMlM=;
	b=WtrzozNuWEamySfie+xotVXAjHPaF5ATkG+sYZQ39abfREv755pyZbjIrZz3eAWQzIsyzn
	SSCIiJ1Rz79DZ1ewMW1O+A6u7uXweRruaaHxlD3S90CQkYfGnfhfSHJ9lZNN0Rp0/Vqi6l
	szMs6m2+S4viSzitBEAlv/ctR21DYdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744736185;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhhsZ9+6PesM7nozGYDV2ADpryOPgfTLgFa4TXtmMlM=;
	b=5YpNjzs4C+/bnfEcBLmE1WL2VjKvIdXnPRzaZ5mah+bXp+dwvdnsKjDRMdPp3uur/QGYUn
	CPnf6K3gbX/lX8Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VPBQPNXm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LvJd3XBZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744736184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhhsZ9+6PesM7nozGYDV2ADpryOPgfTLgFa4TXtmMlM=;
	b=VPBQPNXm/BIKzR6gN/DQ1+E6WmOKO7xfz3p1Fjfe+sEGZ8C86KQ5SeIZbNepxTuRZIH3AI
	9lEP6VzVMPaIhdHVnN+rR4nHFwqSeaznyjodJF5bd0T45X0cmonkaOYQxxKJ2fUWyZvjr0
	246LV+yRGlhf4yBO4XFmJ/e6NxDNgFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744736184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhhsZ9+6PesM7nozGYDV2ADpryOPgfTLgFa4TXtmMlM=;
	b=LvJd3XBZmhEilZ2HCYUxicqaEE7rSkpenaHAZ57KPEtRHIXT4/f14WW2Yk4PEblk4FvNJM
	j7X3do5i3U2EbpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2A56137A5;
	Tue, 15 Apr 2025 16:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mlBEK7iP/mdvagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 16:56:24 +0000
Date: Tue, 15 Apr 2025 18:56:23 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
Message-ID: <20250415165623.GI16750@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250331082347.1407151-1-neelx@suse.com>
 <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com>
 <20250331225705.GN32661@twin.jikos.cz>
 <CAPjX3FfVgmmqbT2O0mg9YyMnNf3z7mN5ShnXiN1cL9P=4iUrTg@mail.gmail.com>
 <CAPjX3FfOJMFC8cXCqLa2yS1qSYmhu5cjV__+7xVRFGuKu=RqiA@mail.gmail.com>
 <f6b92c77-d702-465b-a36a-93c42ecf59a8@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6b92c77-d702-465b-a36a-93c42ecf59a8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D694721185
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmx.com,fb.com,toxicpanda.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmx.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 15, 2025 at 01:20:15PM +0930, Qu Wenruo wrote:
> 在 2025/4/14 16:23, Daniel Vacek 写道:
> > On Wed, 2 Apr 2025 at 16:31, Daniel Vacek <neelx@suse.com> wrote:
> [...]
> >> I'd still opt for keeping full range and functionality including
> >> negative levels using the plain `zstd:N` option and having the other
> >> just as an additional alias (for maybe being a bit nicer to some
> >> humans, but not a big deal really and a matter of preference).
> >> Checking the official documentation, it still mentions "negative
> >> compression levels" being the fast option.
> >>
> >> https://facebook.github.io/zstd/
> >> https://facebook.github.io/zstd/zstd_manual.html
> >>
> >> The deprecation part looks like just some gossip. It looks more about
> >> the cli tool api and we are defining a kernel mount api - perfectly
> >> unrelated.
> > 
> > Any feedback, Dave? I tend to drop this ida of `zstd-fast` alias.
> 
> Not Dave here, but if the future of "zstd-fast" is not that clear, we 
> can definitely wait for a while.
> 
> It's always safer to adapt when the terminology is mature enough.

Thanks all for the feedback, OK let's put it on hold.


Return-Path: <linux-btrfs+bounces-12291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DEA621ED
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A5C173C28
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 23:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E81F4621;
	Fri, 14 Mar 2025 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IzImvG7m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YkZoC6Cd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IzImvG7m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YkZoC6Cd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0A1F92E
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995499; cv=none; b=Je9ZUYS+dxMeMnl3e/3gyYQ/HejzVdIMsWvz0bO1fTRH2od7CvTH3WYfJUT8meGyQMsi7jN+yXew9w+jC/2YzpThJQi5FFIxt9FZHTQ7ti6l9CBvpHJMm+qO6tXpqLMrleVUbZoujc2oDhAeOCMxB+4sUXTMWiNPvmcDEyS/jBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995499; c=relaxed/simple;
	bh=ZFdI38XA8tfCD2zWFYjS726PMuUr0lMlZ0O32/rjuTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofGH8riDpH5lrXIjg9yspZbXDZ4sd6q60NJcO6bbm250ZffDSzpCpyGePqJCKGLjq5jQQYO7phTThYCyzcTBspbMLhVnfhP9QBPw8AaxXkMOp3tphyMbY/dp2xMaVlTZOs7j349CRnp23QSvU5nLAMY6puws68i5tTa6NQFUFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IzImvG7m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YkZoC6Cd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IzImvG7m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YkZoC6Cd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 617CF21194;
	Fri, 14 Mar 2025 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741995495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPPs9QxV/v/vtTTCwT+ZaaVu/E4Tn06Ev+5G0vcRrJs=;
	b=IzImvG7mEL1VOUn7b06JbrUczvyH4WK2KkaASV8H8AqLENDcO0pt7Q4aiFqyq2/PKViEAy
	UaY3xB92IjgpclhV3Bqt5h+cT0DoyJ3lYn7pGNJlhxbq9Erv6sK7njsaGaki1z8Iwyy5Wr
	mq2HWOM8MQabS9kxfgArumF0fsvhF/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741995495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPPs9QxV/v/vtTTCwT+ZaaVu/E4Tn06Ev+5G0vcRrJs=;
	b=YkZoC6Cd87yBvitGtLCGipH4zs8bRG82czyS5IteTPtIzPnicPYXx81vJyEzwMWob/VpXF
	MCTSNycF7xv9JvBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IzImvG7m;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YkZoC6Cd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741995495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPPs9QxV/v/vtTTCwT+ZaaVu/E4Tn06Ev+5G0vcRrJs=;
	b=IzImvG7mEL1VOUn7b06JbrUczvyH4WK2KkaASV8H8AqLENDcO0pt7Q4aiFqyq2/PKViEAy
	UaY3xB92IjgpclhV3Bqt5h+cT0DoyJ3lYn7pGNJlhxbq9Erv6sK7njsaGaki1z8Iwyy5Wr
	mq2HWOM8MQabS9kxfgArumF0fsvhF/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741995495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPPs9QxV/v/vtTTCwT+ZaaVu/E4Tn06Ev+5G0vcRrJs=;
	b=YkZoC6Cd87yBvitGtLCGipH4zs8bRG82czyS5IteTPtIzPnicPYXx81vJyEzwMWob/VpXF
	MCTSNycF7xv9JvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46200132DD;
	Fri, 14 Mar 2025 23:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nCuXEOe91GcLTAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 14 Mar 2025 23:38:15 +0000
Date: Sat, 15 Mar 2025 00:38:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: send: remove the again label inside
 put_file_data()
Message-ID: <20250314233813.GU32661@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741839616.git.wqu@suse.com>
 <ab9bc3e04e0344667b72edff9127e3fece6c4ab6.1741839616.git.wqu@suse.com>
 <20250314165253.GR32661@twin.jikos.cz>
 <78d2f543-1ffc-4454-830c-e52a6eae024c@gmx.com>
 <20250314225803.GT32661@twin.jikos.cz>
 <eb9c52ec-a902-4750-9b1f-3d0a2fea963e@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9c52ec-a902-4750-9b1f-3d0a2fea963e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 617CF21194
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sat, Mar 15, 2025 at 09:55:31AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/3/15 09:28, David Sterba 写道:
> > On Sat, Mar 15, 2025 at 08:20:43AM +1030, Qu Wenruo wrote:
> >> 在 2025/3/15 03:22, David Sterba 写道:
> >>> On Thu, Mar 13, 2025 at 02:50:43PM +1030, Qu Wenruo wrote:
> >>>> The again label is not really necessary and can be replaced by a simple
> >>>> continue.
> >>>
> >>> This should also say why it's needed.
> >>
> >> Do you mean why we need to continue, or why the old label was needed?
> > 
> > Something about that old and new code is equivalent and what implies
> > that (no changes in the variables). Changes in the control flow could
> > change invariants.
> 
> I thought all developers here should understand what "continue" keyword 
> does.
> 
> Do you really want me to copy the official definition of "continue" 
> keyword here as a commit message?

Do you really think this is my point and that I need this kind of
information?  Or that I'm asking to give a brief explanation 'why the
change is ok', the changelog only says 'what' the code does.


Return-Path: <linux-btrfs+bounces-11909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54060A4800B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 14:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA083AF8E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D8F22F397;
	Thu, 27 Feb 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WznRMGeq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KElZl/zt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4Rdp+06";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bzaHLqI1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC05225408
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664443; cv=none; b=EqMH0sQZZbnOGSKBU7M3/wEVP+6g8FSdE/Lvlc1fNtIzZFRBg74348n4MPXCn9tV2FBvSzjsrKrjGOpLvplHaUSEZHcDRr8wZBZT0cqHtbyR14Ygmv4N/Lw09LnTzjWyG7+hr5p8aXE20KNqs9gyYDBTSMvKW1ytRrWiwR/xn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664443; c=relaxed/simple;
	bh=R/1rxf3xBT9mG0payAeSK6dq03YM+M5hxYT9kEm+XfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip7m21c9d1FY1VHbdyy1CePfYnfjxFBQIYVjrJRsSPoq5fNRM1D0aqbe84a2PR/RlUs39Xp4NGgsBSjRUefWfSPg3eB5rnY1dxw4dH0d/h6ToDH8KBLAvZ5CbMRdPZZcPaAq5XQ38TGUeufWexjkA19yGCshW6gyC4G8HSZs9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WznRMGeq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KElZl/zt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4Rdp+06; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bzaHLqI1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7E501F785;
	Thu, 27 Feb 2025 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740664440;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdALOx9re/KB7iZE2YRXnwPvv+M+Npj/b4y80O4b/Mw=;
	b=WznRMGeqw3vIybGofJqikKypHhFLwgbWPtMppkx6TKOQOBivYIzp0Y62s4i2S/ZVO0Xy4T
	BGsiLfWL176230p5bMttvbECBdb11OXxaFQb8TogaDRAQQlY6Ocxm5BqdIrkJYpW31qgsL
	8Jcj8CfteE69YphdHwB9RKBqCPIxA+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740664440;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdALOx9re/KB7iZE2YRXnwPvv+M+Npj/b4y80O4b/Mw=;
	b=KElZl/ztAo3neIR8V+k30QAXwW53IreAzIQk1gj1SBEr7mcuPgzti5wMXoYcpANc+bYmNq
	3blRAYkBsAo20/Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J4Rdp+06;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bzaHLqI1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740664438;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdALOx9re/KB7iZE2YRXnwPvv+M+Npj/b4y80O4b/Mw=;
	b=J4Rdp+06g0EaTSFJmT5eu/6twlQREmm7mGu2INcO/7c3YX/R9li+AEzbPfTGjn32sSCLiI
	5J6cH9eJPmX+zhA9GKBIItt/jt/cYXX/Y7/BzJC6vNF12zmQeK4IunYw6QkRx9N4+6gyrL
	3NJtO3MMb5++66jWhQgEhy7gb4rnsy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740664438;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdALOx9re/KB7iZE2YRXnwPvv+M+Npj/b4y80O4b/Mw=;
	b=bzaHLqI1d4TnVvav/NKfW3EsbCV/hiDB2j0/SLy4eJsRhDAbwwzbtcT89ysXrXse/a05+I
	eEI+C6b8iiK5PrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BADE01376A;
	Thu, 27 Feb 2025 13:53:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZHphLXZuwGfhaQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Feb 2025 13:53:58 +0000
Date: Thu, 27 Feb 2025 14:53:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/27] Struct btrfs_path auto cleaning conversions
Message-ID: <20250227135353.GC5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740562070.git.dsterba@suse.com>
 <20250227095522.GA5777@twin.jikos.cz>
 <99ff81f2-39a7-4a60-9cf0-b61f87fc0133@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ff81f2-39a7-4a60-9cf0-b61f87fc0133@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D7E501F785
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Feb 27, 2025 at 10:56:57AM +0000, Johannes Thumshirn wrote:
> On 27.02.25 10:55, David Sterba wrote:
> > Daniel noted that the trivial patches are maybe too trivial and should
> > be grouped into fewer patches. I agree after looking at the series now,
> > so I'll rework it
> 
> Agreed, though I must say it was super nice for reviewing them, one tiny 
> little change at a time.

Yeah, I think grouping the simple declaration/free removal patches to
one would still be easy to review as the scope is always just one
function and nothing is needed to be kept in memory. Which roughly cuts
the size of the patchset to half.


Return-Path: <linux-btrfs+bounces-12654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E2A74F93
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0136516A309
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4A1DB14C;
	Fri, 28 Mar 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QQDDE1XZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRsh8Al0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QQDDE1XZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRsh8Al0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB08F5B
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183413; cv=none; b=DCSj657TfuqzbU/FDtwilmrZzcFe3lYqAOiqvr/hmfVkzK9g9TxJ2p1KUZLIVQiqaCoQicVjsdKqNU8SIioztBQGGzZScg0HVdsqgQIu6lgHXmC2RHpkImBrKaUkjzr4CVQ+6kAGJ1bXfsZqemMXO3Q5mnVxE1EIt3XSZGlhjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183413; c=relaxed/simple;
	bh=6aovyy0sjCkSSbLMwDc4zY4IguqvIQ28JtOeDFFEQWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF33YxvogFM965MR7yQlsprGtTaN1cReBekn84hAfQIzgFsZt4lVjOczwnG9+Q8vnSu9ClxwaRgLWNMAniXKGEbgJ7AyejadciibzrFCpp1GozV3vwcSMyKf0UEcUzeg9kwSZ+n7LvXOfQlBABgChtifxxvUIGMALRbDsVt9duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QQDDE1XZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRsh8Al0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QQDDE1XZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRsh8Al0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF38C211AC;
	Fri, 28 Mar 2025 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743183409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvLurGgv0rSnX2dsj/9ROgdrD/NdgS2EGeBDGTCRPZY=;
	b=QQDDE1XZV40CHaVHXMLfTYx6YKxgHqj9w5TvXyWVxKkJlXhjd/emQ14Nbw9TCNcOmz0vyE
	hpz0RcLR8BripqOXD9kxcPpeJh9rbn1ePz3UiCFFylhxzIYvsQKKyZ7koYij0c/ZYUonIv
	sCUHXP/LKCR8kDPsJXceRLDEPAYdIsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743183409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvLurGgv0rSnX2dsj/9ROgdrD/NdgS2EGeBDGTCRPZY=;
	b=eRsh8Al0G7Mr8ZZ/zZ7Uoccar2IupabvhpMFt2NHdfqxsJl3ZDS7M9TAzZi/lha4s0TOa+
	sYgmLpy7so02D9BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743183409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvLurGgv0rSnX2dsj/9ROgdrD/NdgS2EGeBDGTCRPZY=;
	b=QQDDE1XZV40CHaVHXMLfTYx6YKxgHqj9w5TvXyWVxKkJlXhjd/emQ14Nbw9TCNcOmz0vyE
	hpz0RcLR8BripqOXD9kxcPpeJh9rbn1ePz3UiCFFylhxzIYvsQKKyZ7koYij0c/ZYUonIv
	sCUHXP/LKCR8kDPsJXceRLDEPAYdIsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743183409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvLurGgv0rSnX2dsj/9ROgdrD/NdgS2EGeBDGTCRPZY=;
	b=eRsh8Al0G7Mr8ZZ/zZ7Uoccar2IupabvhpMFt2NHdfqxsJl3ZDS7M9TAzZi/lha4s0TOa+
	sYgmLpy7so02D9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C06D013998;
	Fri, 28 Mar 2025 17:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CW81LjHe5mcWMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Mar 2025 17:36:49 +0000
Date: Fri, 28 Mar 2025 18:36:44 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.15
Message-ID: <20250328173644.GG32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742834133.git.dsterba@suse.com>
 <20250328132751.GA1379678@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328132751.GA1379678@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Mar 28, 2025 at 09:27:51AM -0400, Josef Bacik wrote:
> On Mon, Mar 24, 2025 at 05:37:51PM +0100, David Sterba wrote:
> > Hi,
> > 
> > please pull the following btrfs updates, thanks.
> > 
> > User visible changes:
> > 
> > - fall back to buffered write if direct io is done on a file that requires
> >   checksums
> 
> <trimming the everybody linux-btrfs from the cc list>
> 
> What?  We use this constantly in a bunch of places to avoid page cache overhead,
> it's perfectly legitimate to do DIO to a file that requires checksums.  Does the
> vm case mess this up?  Absolutely, but that's why we say use NOCOW for that
> case.  We've always had this behavior, we've always been clear that if you break
> it you buy it.  This is a huge regression for a pretty significant use case.

The patch has been up for like 2 months and you could have said "don't
because reasons" any time before the pull request. Now we're left with a
revert, or other alternatives making the use cases working.


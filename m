Return-Path: <linux-btrfs+bounces-2523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0AD85A639
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 15:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334771C21643
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7362EB0A;
	Mon, 19 Feb 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iH50lUMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mOW6zDP8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3MXHgMCM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pgPS+YMb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015281DDFA
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353721; cv=none; b=ql9yjJjyskMQsmxiS/jHMQHPOJiMi8NMVQ1ChT3h+B6hXRdZZVUWfSyTeV/D/s3t+hAPuKP0RNnXoeNtX5mrKbhI5/DHkeGHJi0KM1LY7F8e7Ciw6ssUsN6H0PAQ9ly+zKrxlReH3yAjoXKF2yjnAMG7FZk4DWM8/bPY3N0wvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353721; c=relaxed/simple;
	bh=N0LodCv4BRiPmE0U0iMvxOEVjjxpVAxzHKNTADWGLqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpw1M9rjolEkCZmPzf5bwwKlB17HHVHoiOvqhECu4esg1TZQWRQ20VS8nxjtDm8rKxH/nLl1aV+Aawtr8oiJKNQHci7/CZ7F+uLP0r8guSnaoOAT6pXbxp8eFZxpss24sExFPRvuu1s6G7gr19ysgHFVjoCZhWSYFo/lc1/83pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iH50lUMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mOW6zDP8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3MXHgMCM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pgPS+YMb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC3B91F803;
	Mon, 19 Feb 2024 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708353718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPiul9/My0qsGGF2+MyNsNyHik0zvJ1FIAk+pZBQyjo=;
	b=iH50lUMfSIMh6T4TiHHxUmUJ367C/l3SM9e5Y/KjJsfkLqE73vShbZNyUzbj5AKNOAil21
	YAlX+0G9Cpvr6cEfL/qW8FEYPo3iF9y9iRuwCp+EUIICqlLX5ltLBzFEb3lm1uxK1PuloR
	WIi7KycyauP0o/UkHuNAd/sjeU9F+2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708353718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPiul9/My0qsGGF2+MyNsNyHik0zvJ1FIAk+pZBQyjo=;
	b=mOW6zDP8Hh01angBFa8lKIPhwjBPjBCM5jQ4HUrgigeWt6EopYenfIWWa5ToziwbK6+/Ne
	4sYm1KsLzwus3BBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708353717;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPiul9/My0qsGGF2+MyNsNyHik0zvJ1FIAk+pZBQyjo=;
	b=3MXHgMCMfijbYZFzgsZJIJ8AuKYo7F1WMzY8ZAKsk7I2dhiRdzHd80NkyOLEsnNEEkMe9O
	ynBEFo0gVteJoc1Rd0WcXf/mtxOI5Gd9HRygOVb3mX/SGl4KfPkdjISg9qAVru27dcp+fh
	v7d3+Q21vryyswZF8qb0OgbuLjjxHzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708353717;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPiul9/My0qsGGF2+MyNsNyHik0zvJ1FIAk+pZBQyjo=;
	b=pgPS+YMb3M+sHt94DrecV7IiNsDTsHGOge+MX9MBMv1b3sCyOZgkzFjZ4YqJXpd9lBhK/Q
	vEFz5YKyTRk5v2Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CBC26139C6;
	Mon, 19 Feb 2024 14:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PTOHMbVo02XyFgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 19 Feb 2024 14:41:57 +0000
Date: Mon, 19 Feb 2024 15:41:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/10] btrfs: simplify conditions in
 btrfs_free_chunk_map()
Message-ID: <20240219144121.GV355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1708339010.git.dsterba@suse.com>
 <cd9ae501762221ffca5408ffb59f1a3b990de14e.1708339010.git.dsterba@suse.com>
 <CAL3q7H6MyuNBkRaYHzwid6ccOSYC0Yym2VgwozsqZbVS_6Fzvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6MyuNBkRaYHzwid6ccOSYC0Yym2VgwozsqZbVS_6Fzvw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3MXHgMCM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pgPS+YMb
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DC3B91F803
X-Spam-Level: 
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Mon, Feb 19, 2024 at 12:27:44PM +0000, Filipe Manana wrote:
> On Mon, Feb 19, 2024 at 11:14 AM David Sterba <dsterba@suse.com> wrote:
> >
> > The helper is simple enough for inlining, we can further simplify it by
> > removing the check for map pointer validity. After this patch all
> > callers always pass a valid pointer.
> 
> So by making btrfs_free_chunk_map() to not ignore a NULL pointer, we
> are adding rather
> surprising behaviour and inconsistency.
> 
> Most free functions ignore a NULL pointer, take the example of the
> kfree() family and even free() family in the standard C library,
> as well as most of the free functions we have in btrfs as well, which
> are modeled on that common pattern.
> 
> Ignoring NULL makes error handling simpler, by not having the need to
> take special care to call the free function with a non-NULL pointer.
> 
> Besides that, this change doesn't seem to improve anything.

The goal is to reduce a static inline function size as its code is
duplicated many times (in this case 36x) so anything that does not need
to be there is removed. The improvement is smaller code size, one less
condition to check.

OTOH that it's a freeing function and would not accept a NULL pointer is
indeed inconsistent and potentially problematic so I'll drop the patch.


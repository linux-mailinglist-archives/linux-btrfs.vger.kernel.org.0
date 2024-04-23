Return-Path: <linux-btrfs+bounces-4500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BD8AE9CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE41C22DB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604FF13B293;
	Tue, 23 Apr 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kYHpLDkH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iDgKYK0Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1evyy4Cl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V3cxaLrz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD88F5E;
	Tue, 23 Apr 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883538; cv=none; b=UTVEySOiiJmVhxSdwZbOTrOdeXjxRD2VgAQuG9kuY0KgHYLI/ihGd4drhF8fsl7idjn5zuvdHwfQ8guBD33VUs1sdpV0fM8NFr5iIkA4Ej6zms2Q4KyAu++HV/wsGDIzUWolC/ucXSd9LncaNXmikx55j53uPHkkPmVdY50pdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883538; c=relaxed/simple;
	bh=gPByzlowu52gZBR0jPs98e/qH0LAV1N1EdaNJp9k5pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9edEq/S4EC2QfnlXWQXU+px8aSlsMGRKvnGpK1RZFviLVoyVNOxfnEkzJV+KJjYs4P71mX4r2O1X8h1ZPD8qL8EMfunLNR2XBiv8v8k921N/NbVYXfJlsoGG9nnkovhkrIwsAEH/T4wRhko422LWfjkT8NtCgOEY1OAfu2CCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kYHpLDkH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iDgKYK0Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1evyy4Cl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V3cxaLrz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E128D600B8;
	Tue, 23 Apr 2024 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713883535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERxOOMezRAufIKqgnoffsNNUlab+BjMEAF6+1TvdqL0=;
	b=kYHpLDkHdRQHUO1ImpunLE2b+SuGC8tpIhIpKCZ3ftKd3KHoFYV0RoM07n6lxcqokvr2Sm
	7cnoUIUEi2KVdSuiUTYx8CJ8sDJkSZ1tQjYoEiNC//Ea9w6saukAwUi8thmUw4EbqUTWzm
	tqSKhTzFHTVMA626W0tBctGtN6mUF3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713883535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERxOOMezRAufIKqgnoffsNNUlab+BjMEAF6+1TvdqL0=;
	b=iDgKYK0Qtdgpl1cAc8B+ZT8wMjb8Fks1FJhQJht044mBoApnXedDU1NrW5lYMjiXcgptoC
	YGEwQFgEDkW4K7Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713883534;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERxOOMezRAufIKqgnoffsNNUlab+BjMEAF6+1TvdqL0=;
	b=1evyy4Cl+UoOgOnUIXg1/q4G5gjdSMMfixQ9AUFI3ZH1o4Ji3ZEE7xe6lduUFDUScD9NRC
	U+AoxYUdaKdUEymg+XTYyoA/OlCGQGJOFflWUcTAiJhTqG7+8L6hNXmyMTmVyOtLp+oUAg
	oI1Z3yPCLULJo7wFclpk/jYpNxpDkWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713883534;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERxOOMezRAufIKqgnoffsNNUlab+BjMEAF6+1TvdqL0=;
	b=V3cxaLrzAwF9PoRBfy+nEXrfs7bAIm0jGSbLKDT06xCnPrOa+fQwscTdxYcbeoWNhVGS/G
	CE18HfQ/g2ubJ+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4D4113894;
	Tue, 23 Apr 2024 14:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ESPiL47JJ2ZyAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Apr 2024 14:45:34 +0000
Date: Tue, 23 Apr 2024 16:38:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Pavel Machek <pavel@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: add missing mutex_unlock in
 btrfs_relocate_sys_chunks()
Message-ID: <20240423143801.GI3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240419-btrfs_unlock-v1-1-c3557976a691@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-btrfs_unlock-v1-1-c3557976a691@codewreck.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.69 / 50.00];
	BAYES_HAM(-2.69)[98.66%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto]
X-Spam-Score: -3.69
X-Spam-Flag: NO

On Fri, Apr 19, 2024 at 11:22:48AM +0900, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> The previous patch forgot to unlock in the error path
> 
> Link: https://lore.kernel.org/all/Zh%2fHpAGFqa7YAFuM@duo.ucw.cz
> Reported-by: Pavel Machek <pavel@denx.de>
> Cc: stable@vger.kernel.org
> Fixes: 7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()")
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Added to for-next, thanks for catching it.


Return-Path: <linux-btrfs+bounces-13791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D87AAE287
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 16:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F33B245F4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD1328BA89;
	Wed,  7 May 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qYIOaCWp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHUXyZA3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qYIOaCWp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHUXyZA3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1728980B
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627254; cv=none; b=DIE5utM5nwWG+Coe2kgMus1Swf7GXjBm927or2QI3QBqsMTvKafokvHsLAyDseXvUr0rZtNY5dKe2K9yTJrFCXtc8KxbJUNUonvTyPLTKuW3l5kPXNzgTBD0/wqnbdJF4IkYHgVSkQvqcIy1oyPtCJrcq5LXQv61Ei0p0vtOFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627254; c=relaxed/simple;
	bh=U7pBCzrIW0KnwzsJGeK5F1oB8PzHqIO1Cc82hD+Rhmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD9vRPer0ummn/F696HRixKDVEew1+0kjkp2CGkz3O1Ichjw260IxPLJOOA300Ku5eHHuRlSaXSmmdiYHPA3o7NX7C3iNMf1IOCzKiYZZmVaCKgwIdPrpDByrywgGmWxKgs8IJtp6BZBX+ycFL7vzQhqFkwyMs3YlyuPKe7tyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qYIOaCWp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHUXyZA3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qYIOaCWp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHUXyZA3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 327D32123B;
	Wed,  7 May 2025 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746627251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4F+lmQfDzO1utDvoQ1V5GTpLQaeGDhuvUOdxa8KD7cw=;
	b=qYIOaCWpZhsLWlZo/yD0frKhX34LnLUxbyzDb1Sgc7aNDXDJlftxrAC11MxDHz2zYSXYFj
	QJZV07n8aU9/zKlKW0ZV1OVHpaYsRPwKIoJ4RFseACkI5t0HP6DWRZ0Lsb4Qt8NNGPS6uM
	9xfUcRIzsagfglNWCPh4g0AbseKCH/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746627251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4F+lmQfDzO1utDvoQ1V5GTpLQaeGDhuvUOdxa8KD7cw=;
	b=xHUXyZA3cF4kNzY9ScKBML+wdF77e+nolc3cO0OXB6b9J0gHp8Mn6XOoDFRip/3ipjG5NT
	9p63X72vH6ywr2Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qYIOaCWp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xHUXyZA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746627251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4F+lmQfDzO1utDvoQ1V5GTpLQaeGDhuvUOdxa8KD7cw=;
	b=qYIOaCWpZhsLWlZo/yD0frKhX34LnLUxbyzDb1Sgc7aNDXDJlftxrAC11MxDHz2zYSXYFj
	QJZV07n8aU9/zKlKW0ZV1OVHpaYsRPwKIoJ4RFseACkI5t0HP6DWRZ0Lsb4Qt8NNGPS6uM
	9xfUcRIzsagfglNWCPh4g0AbseKCH/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746627251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4F+lmQfDzO1utDvoQ1V5GTpLQaeGDhuvUOdxa8KD7cw=;
	b=xHUXyZA3cF4kNzY9ScKBML+wdF77e+nolc3cO0OXB6b9J0gHp8Mn6XOoDFRip/3ipjG5NT
	9p63X72vH6ywr2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EACD139D9;
	Wed,  7 May 2025 14:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0P8RA7NqG2jJUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 May 2025 14:14:11 +0000
Date: Wed, 7 May 2025 16:14:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Venkat <venkat88@linux.ibm.com>, quwenruo.btrfs@gmx.com,
	linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	ritesh.list@gmail.com, disgoel@linux.ibm.com,
	David Sterba <dsterba@suse.com>
Subject: Re: [linux-next-20250320][btrfs] Kernel OOPs while running btrfs/108
Message-ID: <20250507141409.GG9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <0B1A34F5-2EEB-491E-9DD0-FC128B0D9E07@linux.ibm.com>
 <CAL3q7H7PqVRnDuooSr6OhvUQ3G5V2gq6VEDpqTqNX9jHmq97aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7PqVRnDuooSr6OhvUQ3G5V2gq6VEDpqTqNX9jHmq97aw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 327D32123B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,gmx.com,vger.kernel.org,lists.ozlabs.org,gmail.com,suse.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.71

On Wed, May 07, 2025 at 02:04:47PM +0100, Filipe Manana wrote:
> On Wed, May 7, 2025 at 10:02 AM Venkat <venkat88@linux.ibm.com> wrote:
> >
> > +Disha,
> >
> > Hello Qu,
> >
> > I still see this failure on next-20250505.
> >
> > May I know, when will this be fixed.
> 
> The two patches pointed out before by Qu are still being added to linux-next.
> Qu reported this on the thread for the patches:
> 
> https://lore.kernel.org/linux-btrfs/0146825e-a1b1-4789-b4f5-a0894347babe@gmx.com/
> 
> There was no reply from the author and David added them again to
> for-next/linux-next.
> 
> David, can you drop them out from for-next? Why are they being added
> again when there were no changes since last time?

The patches have been there for like 4 -rc kernels without reported
problems. I will remove them again.


Return-Path: <linux-btrfs+bounces-4941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBDC8C4719
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4C91F22C0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172E3BB23;
	Mon, 13 May 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Us5w2aOM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHoxYaBe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2Gw1pVr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bh0b+MSW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F321C6A4
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626004; cv=none; b=MnX97k7HwQL3g3OX8Wsb25BJTHjG6dvJRQhXpSXHk2RKIKQnDl7TauYIsM4KXzV6CMFHVIv1nTVhnWYS+YhrRj36e6BT+CmIPtmtlJyd/DAJUxayuD6PjinTOwQluUScj9+T/6E6SqeCtMn8XbI9GWC/LKqLtmGy5sgBqDcDymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626004; c=relaxed/simple;
	bh=78oMNo5HWbLG6e332BhOh+64ODaUGb1w8Gvpiiy6a0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kARRLX34mvs4LxcWlt1cUx/j1Gk1anL+VgFz/1oxHX67ckKqg9iW/+h1zmvk9Vl3zMOOIXTzZjJ+63vSMTDLQ4Kbg6Qkquw8m7Q9U9DbJB7B0IcsRP0X2zilYSwTxHwCK/+BfAADEjz2Ortmx1a7jGXQkBx33EAs1JYyGkMmQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Us5w2aOM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IHoxYaBe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2Gw1pVr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bh0b+MSW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2246C5CB96;
	Mon, 13 May 2024 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715626000;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCdNOGRy9Y44zgHaIlRSA1lqHN24aetpvxRWOuuuMuY=;
	b=Us5w2aOMFD6EtkSH7uPwbrOteU4fVYL0FqUg95M9qy8+qan2E9TM+c7vqcarV+Dyjgx2Zz
	QDRgv6ui3GIuAidw4hsMFCAXC5njhzWBO52QgWi8KBsVGXvW5aoP+0OliRUmcjSsh7zOJN
	GcepEoikJTlEYglITBokmljFDnzktps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715626000;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCdNOGRy9Y44zgHaIlRSA1lqHN24aetpvxRWOuuuMuY=;
	b=IHoxYaBeLZRgm8zV4qr69HdIpKKA448O1ydhRyYpfhoZAAU8GCVwETOkQx6rcqQyncnMCF
	42A4FphJDj9odwDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i2Gw1pVr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Bh0b+MSW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715625999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCdNOGRy9Y44zgHaIlRSA1lqHN24aetpvxRWOuuuMuY=;
	b=i2Gw1pVrxJULpNR1ZN9Adt+lKxBkmj37Tu+2sg9+irfzC3PVTlrFLGWN9hF4WpwQNF8lKZ
	Z23+u/TLNE4qaEZwD2mDN2gC/1tFscT39Upi73mpfN9ojyMHlAYnxH6Ib9ZVUGoVxXQtlX
	EKvXHN6X14YEkwB78bpEXzQB8t2kS1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715625999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCdNOGRy9Y44zgHaIlRSA1lqHN24aetpvxRWOuuuMuY=;
	b=Bh0b+MSWe36EfG0KMAqiamqG1V3QH4aWr8N0eYAf3+OGCeaw8Vej9tNzf9QnN6DL9Stv9W
	R54y3V5kREgg7DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BD561372E;
	Mon, 13 May 2024 18:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPp1Ag9gQmaQCwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 13 May 2024 18:46:39 +0000
Date: Mon, 13 May 2024 20:39:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/8] btrfs: don't allocate file extent tree for non
 regular files
Message-ID: <20240513183918.GC4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715169723.git.fdmanana@suse.com>
 <13d914be0518dc3f4a8086f96275c3b8bf113d63.1715169723.git.fdmanana@suse.com>
 <39f3094b-4e6a-4f72-8ba7-c013a33a05ad@gmx.com>
 <CAL3q7H655KkXXTYutyReiJf41F61-qzveCJh9nmKfOH8f47Row@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H655KkXXTYutyReiJf41F61-qzveCJh9nmKfOH8f47Row@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.79)[99.10%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2246C5CB96
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, May 09, 2024 at 09:41:50AM +0100, Filipe Manana wrote:
> On Thu, May 9, 2024 at 1:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > 在 2024/5/8 21:47, fdmanana@kernel.org 写道:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When not using the NO_HOLES feature we always allocate an io tree for an
> > > inode's file_extent_tree.
> >
> > I'm wondering can we discard non-NO_HOLES support directly so that we
> > can get rid of the file_extent_tree completely?
> >
> > Initially I'm wondering why NO_HOLES makes a difference, especially as
> > NO_HOLES can be set halfway, thus we can still have explicit hole extents.
> >
> > But it turns out that the whole file_extent_tree() is only to handle
> > non-NO_HOLES case so that we always have a hole for the whole file range
> > until i_size.
> >
> > Considering NO_HOLES is considered safe at 4.0 kernel, can we start
> > deprecating non-NO_HOLES?
> 
> NO_HOLES is a mkfs default for only 2 or 3 years IIRC. It's not that long.
> 
> And how do you know everyone is already using NO_HOLES?
> Last week I saw a user filesystem that doesn't use it.
> 
> And probably there are many more.

I think so. Soft deprecation can start but we still have to keep the
code around and given that many filesystems do not change features since
mkfs the time ("mkfs and forget") there are many created before the 5.15
defaults change. So, estimmated hard deprecation time is when the kernel
5.15 will be out of LTS support upstream or distros we care about. Rough
estimate is 10 years from now.


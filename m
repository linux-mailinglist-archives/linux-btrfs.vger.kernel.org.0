Return-Path: <linux-btrfs+bounces-14999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBE4AEA02C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380A13A287C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B63288CB5;
	Thu, 26 Jun 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PORqX+LL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XNxV2O9a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PORqX+LL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XNxV2O9a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136041F7586
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947384; cv=none; b=uFs0AKgoMtIN9s7A8u0s1dXg7ZizPnF4WeY+51ZercdFEdQlYDB0ER0u2Ex+70hXE9XfzztM5tSIkpqF7c+s3ETEq3f99+HQblhoM/rML8svGX8elO0elO6PxQHCB3jLakI29gE9lIgXXMdK12wJ0PGHzHbSRZuyAGXg/jN4VMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947384; c=relaxed/simple;
	bh=O43jBg5PlGRgnYkcgpSnjSs8TPfPXwZr62jh2UkRjEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWXcX9Hg/vZ9nk8q3NAtKzapkLN3mC6WLR9iomTCN26OtEV2tr/OkWOSxVN9UEXb1DFMoM7UtXK0DaWUI/hqvqyisLhuCOrPGCWmAku7qLvJK5jJYUCT+LWhOnNkSsDwCdol9PjByrgJYHOYB9R1Tfq/DdV3Gr3gT1M/cYJz3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PORqX+LL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XNxV2O9a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PORqX+LL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XNxV2O9a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09FD7210ED;
	Thu, 26 Jun 2025 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750947381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M2Ga9haPuULBwaCbUgMwDmG09jGfbVce6iaCePM0qA=;
	b=PORqX+LLi/Bk87YTOc9N0tTmUSZD1oY6DZr5mdDZzcVDSe5T6GuY9FARTeUimCwj9fA9I5
	FT+tR2EmyIhvY4hQ297Iqu0xZ4kufANbJL1OgSxtUqGdX4nLt3ryO5lUFD//b1KPK20FiR
	8xCCnPVbA3XxI0KdYsDGiYEkslaAinw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750947381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M2Ga9haPuULBwaCbUgMwDmG09jGfbVce6iaCePM0qA=;
	b=XNxV2O9ahOY6MDB6oIN+tTY/zyV9m+Td7YQWP24WTqwyZlay3hMLinsrQF0ev5h8pWAvCb
	qALtCttcXNOyIoAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PORqX+LL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XNxV2O9a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750947381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M2Ga9haPuULBwaCbUgMwDmG09jGfbVce6iaCePM0qA=;
	b=PORqX+LLi/Bk87YTOc9N0tTmUSZD1oY6DZr5mdDZzcVDSe5T6GuY9FARTeUimCwj9fA9I5
	FT+tR2EmyIhvY4hQ297Iqu0xZ4kufANbJL1OgSxtUqGdX4nLt3ryO5lUFD//b1KPK20FiR
	8xCCnPVbA3XxI0KdYsDGiYEkslaAinw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750947381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M2Ga9haPuULBwaCbUgMwDmG09jGfbVce6iaCePM0qA=;
	b=XNxV2O9ahOY6MDB6oIN+tTY/zyV9m+Td7YQWP24WTqwyZlay3hMLinsrQF0ev5h8pWAvCb
	qALtCttcXNOyIoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B8E138A7;
	Thu, 26 Jun 2025 14:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 83u4MzRWXWjMKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 26 Jun 2025 14:16:20 +0000
Date: Thu, 26 Jun 2025 16:16:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: cen zhang <zzzccc427@gmail.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com
Subject: Re: [BUG] btrfs: Assertion failed in btrfs_exclop_balance on balance
 ioctl
Message-ID: <20250626141615.GC31241@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAFRLqsVDimnqBx0_pDF-bqEQ3epha2d3r6cKm-0b6UdzkkE42Q@mail.gmail.com>
 <bbe21da7-eed3-4fb9-afd9-6f1c70c0eaed@gmx.com>
 <20250626141151.GB31241@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626141151.GB31241@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 09FD7210ED
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	FREEMAIL_TO(0.00)[gmx.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Jun 26, 2025 at 04:11:51PM +0200, David Sterba wrote:
> On Thu, Jun 26, 2025 at 06:50:17PM +0930, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/6/26 17:37, cen zhang 写道:
> > > Hello Btrfs maintainers,
> > > 
> > > I would like to report a kernel BUG, which appears to be a state
> > > management issue in the balance ioctl path.
> > > 
> > > The kernel panics due to a failed assertion in btrfs_exclop_balance()
> > > at fs/btrfs/fs.c:127. The assertion fs_info->exclusive_operation ==
> > > BTRFS_EXCLOP_BALANCE_PAUSED fails, indicating that the function was
> > > called with an unexpected exclusive operation state.
> > > 
> > > Here are the relevant details:
> > > 
> > > Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
> > > Hardware: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996)
> > 
> > Reproducer please?
> > 
> > I guess you guys are running syzbot, then please provide the usual 
> > syzbot assets.
> 
> This might be the but that was once reported, I'll try to look it up,
> some edge case of the exclusive ops and the convoluted balance states.

There were several reports and proposed fixes, some of them got merged
https://lore.kernel.org/linux-btrfs/?q=xiaoshoukui

The possible and not merged fix is
https://lore.kernel.org/linux-btrfs/20230810034810.23934-1-xiaoshoukui@gmail.com/

it's adding more balance state bits, this just adds to the number of
possible states and maybe adds more unhandled cases.


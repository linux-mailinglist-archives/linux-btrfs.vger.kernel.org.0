Return-Path: <linux-btrfs+bounces-19581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4ACAE2BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 21:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1606A30573A1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E372D660E;
	Mon,  8 Dec 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jr80NvT6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qKpGtwtX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsmRXphd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VzxPr67H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B222D1F64
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765226667; cv=none; b=b3TBUlX9/J0tUQ9NWNn5WmMVJF4JJ+eHKcKieF6WueAv6eTQsrFGHaUE5GHzecV3qvcbKTcCClZKnYk5RnMzguIDUQ3DOc0iLy6G2Fsn6oZcMRMgMQaYxsHDw7f28Mv1Wvk5C47tMki63ud6zpQNBImigIKHFa4neszzmCowoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765226667; c=relaxed/simple;
	bh=fEJI8CuGn8QcClNLvfqtNHDLseGGlkHaorQlpCfHibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpOvZ5hui6+MaiuA9SPyvKQE+pfR7dYxdpxGaHnCkQTPrsBZhyvj0pA9xalx6VppHCpaomoLwvU3FCHfGOqguWQ/3L1T+42NbngBfqeeHp9ORwXyZZNaLD/9ObOxNTb/IynT8toUvallK40brDba2T+6igYJC5KOz2IMDGABIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jr80NvT6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qKpGtwtX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IsmRXphd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VzxPr67H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1AE05BD62;
	Mon,  8 Dec 2025 20:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765226663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju8/OzBXflg+tG4+XTlv9sa0aLYjLtbBEuDkdu0TgSw=;
	b=Jr80NvT6rxLTzmT00hbdCFf5YVH4Jvy+SrsVS3kR0THlLG6mcV4T6DqXctow/O6dFrzXky
	FWcSXC4T6tE9MdHm0N0QnHZxonU803h3AqgxMd6kVL8gYk/pkqmITvplsOKYU7F06Y66BB
	AcvoRb2sMzDihc/hkXUdQqEn/J+DDyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765226663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju8/OzBXflg+tG4+XTlv9sa0aLYjLtbBEuDkdu0TgSw=;
	b=qKpGtwtXr32nQunxeIla4Ns1tTwoUcg9hRAfhk4U0ZBWmcv+i9AWEuUmZo7bfZB/EL38N4
	+9pYijWHAhxxNGCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IsmRXphd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VzxPr67H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765226661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju8/OzBXflg+tG4+XTlv9sa0aLYjLtbBEuDkdu0TgSw=;
	b=IsmRXphdMMMCRSzqBBpYtXfORnYKuqT3PoTX/ulGfYUvUEzoiWyx/S1dBHQAdH9kXdfPU1
	GZth4cD+veN5ZzRfeOqQChgyTleydRtbJTXcYRe9FAtfSGAUJwRYy+neFLRY+SagKl0MTC
	78IzULUr7rHPvYHn/URAmiNZtRxLTJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765226661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju8/OzBXflg+tG4+XTlv9sa0aLYjLtbBEuDkdu0TgSw=;
	b=VzxPr67HfibODm8GKzA/tAfbwRsQys4A5bFXG9dWOukxx4d9xenGU/Bs5+bA1zeTmGwGL5
	H9E5pzjq94VLYnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAA7F3EA63;
	Mon,  8 Dec 2025 20:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ovUxKaU4N2l7EAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Dec 2025 20:44:21 +0000
Date: Mon, 8 Dec 2025 21:44:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: shrink the size of btrfs_bio
Message-ID: <20251208204420.GD4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
 <20251208191903.GA4859@twin.jikos.cz>
 <3bbfc8bc-0b15-461b-90a4-a59d2b7fd97e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bbfc8bc-0b15-461b-90a4-a59d2b7fd97e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: C1AE05BD62
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Tue, Dec 09, 2025 at 06:56:47AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/12/9 05:49, David Sterba 写道:
> > On Fri, Dec 05, 2025 at 06:34:30PM +1030, Qu Wenruo wrote:
> >> This is done by:
> >>
> >> - Shrink the size of btrfs_bio::mirror_num
> >>    From 32 bits unsigned int to 8 bits u8.
> > 
> > What is the explanation for this? IIRC the mirror num on raid56 refers
> > to the device index,
> 
> You're right, u8 can not cut the max number of devices for RAID6.
> (RAID5 only has two mirrors, mirror 0 meaning reading from data stripes, 
> mirror 1 means rebuild using other data and P stripe)
> 
> BTRFS_MAX_DEVICES() is around 500 for the default 16K node size, which 
> is already beyond 255.
> 
> Although in the real world it can hardly go that extreme, but without a 
> proper rejection/sanity checks, we can not do the shrink now.
> 
> I'd like to limit the device number to something more realistic.
> Would the device limit of 32 cut for both RAID5 and RAID6?
> (And maybe apply this limit to RAID10/RAID0 too?)
> 
> Or someone would prefer more devices?

I'd rather not add such artificial limit, I find 32 to small anyway.
Using say 200+ devices will likely hit other boundaries like fitting
items into some structures or performance reasons, but this does not
justify setting some data structure to u8/1 byte.

With u16 and 16K devices this sounds future proof enough and we may use
u16 in the sructures to save bytes (although it generates a bit worse
code).


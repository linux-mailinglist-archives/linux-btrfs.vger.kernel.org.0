Return-Path: <linux-btrfs+bounces-10690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF199FFA53
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 15:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9924E18837B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C31B395A;
	Thu,  2 Jan 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q32dAgHj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0g3wS91H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q32dAgHj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0g3wS91H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E571B3952
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827574; cv=none; b=guReuvR6jemHCu0YVwBxx1k3PiFzqOKPaayYo0i+g92A5l+EV+vp3/uvjp16Fg7ZPs0T4YomkttUUraJS9uzXwdp3QuEOWq8vwFpzcrjm35jbJE5LpEh2wGzWWsx+2coBtMwp1jAAHyzkn5uzXILa8q1wkKosol85t+BHzZQXfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827574; c=relaxed/simple;
	bh=RO46IGtk5YmKhgJ8v0vltm+7ynn5EY/MGwnbUXEKFuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/bGeSqB5WB4PWnFrjv/PjAJyRE9M9XFUxZBkoKxU+hMJe06uyUb7VsupG3J1MJcghIPPPD7KJtxX5K+hI3r1z6QS2eFFrFS+I+pYw1JwLKQA6CwuEzFk2fT5zPyVTphzo3r4+nQV3YbeibQUACWTLBc74x9D78n96lrH1oOsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q32dAgHj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0g3wS91H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q32dAgHj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0g3wS91H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80A641F787;
	Thu,  2 Jan 2025 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735827570;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RO5QmWYPrFHwQyKg9oXzVSxLx9AecvbRYLa1QJ2KDO4=;
	b=q32dAgHj1z/uFL5sfSMugOcJ01NN1ufQULy5WN2c2rH8ok9pAaL0lHe9huT6ffwUKgliPR
	FsoWPms8R3XLt8YN1c6X0xOPzMxPwPEDy6GxPa3liQ9TFMNwfB5TnSK/Ff8gpBJVFYldwU
	JYd5dT22PAGaHATXfQ+0biuL2zzSWI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735827570;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RO5QmWYPrFHwQyKg9oXzVSxLx9AecvbRYLa1QJ2KDO4=;
	b=0g3wS91H3WbAW0E6B9nvpZglDURgGpEMFeVcT+PRV3rvhD1PHtCUEVgzNvmgS0pcoMpoIq
	ennw1JxHkyAhxbCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735827570;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RO5QmWYPrFHwQyKg9oXzVSxLx9AecvbRYLa1QJ2KDO4=;
	b=q32dAgHj1z/uFL5sfSMugOcJ01NN1ufQULy5WN2c2rH8ok9pAaL0lHe9huT6ffwUKgliPR
	FsoWPms8R3XLt8YN1c6X0xOPzMxPwPEDy6GxPa3liQ9TFMNwfB5TnSK/Ff8gpBJVFYldwU
	JYd5dT22PAGaHATXfQ+0biuL2zzSWI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735827570;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RO5QmWYPrFHwQyKg9oXzVSxLx9AecvbRYLa1QJ2KDO4=;
	b=0g3wS91H3WbAW0E6B9nvpZglDURgGpEMFeVcT+PRV3rvhD1PHtCUEVgzNvmgS0pcoMpoIq
	ennw1JxHkyAhxbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65A3313418;
	Thu,  2 Jan 2025 14:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yhqTGHKgdme3EgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 Jan 2025 14:19:30 +0000
Date: Thu, 2 Jan 2025 15:19:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/11] btrfs: zoned: split out data relocation space_info
Message-ID: <20250102141925.GQ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1733384171.git.naohiro.aota@wdc.com>
 <7c716895-1c7e-45d7-a3a3-e77e32535301@wdc.com>
 <hm5whah2es5oyjv4wdx7ucrnjaowe42kecs2ggadukakbwqjkv@x5lyewbjsb6p>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hm5whah2es5oyjv4wdx7ucrnjaowe42kecs2ggadukakbwqjkv@x5lyewbjsb6p>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Dec 10, 2024 at 05:40:30AM +0000, Naohiro Aota wrote:
> On Sat, Dec 07, 2024 at 11:35:04AM +0000, Johannes Thumshirn wrote:
> > On 05.12.24 08:50, Naohiro Aota wrote:
> > > As discussed in [1], there is a longstanding early ENOSPC issue on the
> > > zoned mode even with simple fio script. This is also causing blktests
> > > zbd/009 to fail [2].
> > > 
> > > [1] https://lore.kernel.org/linux-btrfs/cover.1731571240.git.naohiro.aota@wdc.com/
> > > [2] https://github.com/osandov/blktests/issues/150
> > > 
> > > This series is the second part to fix the ENOSPC issue. This series
> > > introduces "space_info sub-space" and use it split a space_info for data
> > > relocation block group.
> > > 
> > > Current code assumes we have only one space_info for each block group type
> > > (DATA, METADATA, and SYSTEM). We sometime needs multiple space_info to
> > > manage special block groups.
> > > 
> > > One example is handling the data relocation block group for the zoned mode.
> > > That block group is dedicated for writing relocated data and we cannot
> > > allocate any regular extent from that block group, which is implemented in
> > > the zoned extent allocator. That block group still belongs to the normal
> > > data space_info. So, when all the normal data block groups are full and
> > > there are some free space in the dedicated block group, the space_info
> > > looks to have some free space, while it cannot allocate normal extent
> > > anymore. That results in a strange ENOSPC error. We need to have a
> > > space_info for the relocation data block group to represent the situation
> > > properly.
> > 
> > I like the idea and the patches, but I'm a bit concerned it diverges 
> > zoned and non-zoned btrfs quite a bit in handling relocation. I'd be 
> > interested what David and Josef think of it. If no one objects to have 
> > these sub-space_infos zoned specific I'm all good with it as it fixes 
> > real problems.
> 
> Hmm, for that point, we already do the relocation a bit different on zoned
> vs non-zoned. On the zoned mode, the relocated data is always allocated
> from a dedicated block group. This series just move that block group into
> its own space_info (aka sub-space_info) to fix a space accounting issue.
> 
> I admit the concept of sub-space_info is new, so I'd like to hear David and
> Josef's opinion on it.

One thing that sounds ok is that it fixes real problems, even if it's
just for the zoned mode, the exceptions for handling space already
exist.

Conceptually the sub groups also sound ok but this is a design thing and
with reach to user space (e.g. exporting to sysfs or requiring more
detailed 'btrfs fi df' and other utilities). Handling the reloc and
potentially tree-log block groups more transparently sounds like a good
idea. Reusing that for more fine grained space control like tiering
sounds also ok.

> > Would it be useful to also do the same for regular btrfs? And while 
> > we're at it, the treelog block-group for zoned mode could benefit form a 
> > own space-info as well, couldn't it? To not run into premature ENOSPC on 
> > frequent syncs, or is this unlikely to happen (I'm thinking out loud here).
> 
> On the regular mode, it can allocate space for relocation data from any
> block group. So, it is not so useful to separate space_info for
> that. However, it would be interesting to have a dedicated relocation data
> block group as well on the regular mode, because it could reduce the
> fragmentation of relocated data. This would be interesting topic to
> explore.
> 
> Yes, adding treelog sub-space_info is useful too. Apparently, I sometime
> see a test failure due to treelog space_info accounting mismatch. I didn't
> implement that sub-space_info for now, because I'd like to know first that the
> sub-space_info concept itself is the right way to go.


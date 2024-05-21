Return-Path: <linux-btrfs+bounces-5161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F88CB0B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEE628210A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872707EF06;
	Tue, 21 May 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIvMeSa0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F2M9IlbR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIvMeSa0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F2M9IlbR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966C1CD32
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302859; cv=none; b=aDxBVDqU76Z8JAWI5+xGHfWNrmtxz1gPp6Xk9y5bzxaS72lYN4ZZqwSlChLrK/Oku9vExWSnGewZStjtYWaiLx5Qg/b6RF+UtC0rDiTdg9oUCfasN/6quBHOQlB9dIbypmh+r4Z8g7U4meZI0NxAzi/vcZRpmDtBFPtN7Dmn01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302859; c=relaxed/simple;
	bh=H5B//WKh6IXhzRAMv0T61jIGvFZh49lWL996s0HuhC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEYqqQY+4OZAslC+0bZZMWqMlCQamwdUqF+3U+KZfLIvSlDKDqERgWSX8NFQqHx8M6ZHmx4sMsD1XL+/2yJM0Eq83bcjsNmSS7ew+qk64ppGq2DlBpEy2LdQdi/PBypSFndcw1VNsyvW7RPB+ZAkjRUQoIGuwC7dPfUVegIcGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIvMeSa0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F2M9IlbR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIvMeSa0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F2M9IlbR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD6A9347F3;
	Tue, 21 May 2024 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716302855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/Uqe1S6/gVXJkpxytBqiStzCbq2Oyue3lyFoM5TgjU=;
	b=qIvMeSa06Evbox4GLQG+lKEFZberLxNkuaulPp4lqLKuDOgHQ9dD7je5NC8KpQCO8MRybZ
	exCzIzyYX+srt79Ys/2s1Fm3AD5f3wDmEJq9ng/Y0+aj9yCQ40gMVMemI3fmtlM2fyJD04
	8cXF3KQ5ofUWw5RAIxV+u94LGAhoAgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716302855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/Uqe1S6/gVXJkpxytBqiStzCbq2Oyue3lyFoM5TgjU=;
	b=F2M9IlbRagPwH24ap2DXEQZhk3SckAUhdDBnp5v+nf4zsRQe9l7FtYo3hesIjLbtsVaEgE
	XgeJ+XJ0gzgNm6CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716302855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/Uqe1S6/gVXJkpxytBqiStzCbq2Oyue3lyFoM5TgjU=;
	b=qIvMeSa06Evbox4GLQG+lKEFZberLxNkuaulPp4lqLKuDOgHQ9dD7je5NC8KpQCO8MRybZ
	exCzIzyYX+srt79Ys/2s1Fm3AD5f3wDmEJq9ng/Y0+aj9yCQ40gMVMemI3fmtlM2fyJD04
	8cXF3KQ5ofUWw5RAIxV+u94LGAhoAgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716302855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/Uqe1S6/gVXJkpxytBqiStzCbq2Oyue3lyFoM5TgjU=;
	b=F2M9IlbRagPwH24ap2DXEQZhk3SckAUhdDBnp5v+nf4zsRQe9l7FtYo3hesIjLbtsVaEgE
	XgeJ+XJ0gzgNm6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E35613A1E;
	Tue, 21 May 2024 14:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LmdyJge0TGZYAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 14:47:35 +0000
Date: Tue, 21 May 2024 16:47:34 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: avoid data races when accessing an inode's
 delayed_node
Message-ID: <20240521144734.GN17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715951291.git.fdmanana@suse.com>
 <20240520154844.GF17126@twin.jikos.cz>
 <CAL3q7H5LhdkQq7aeU+yD_6RS9mYeBa5=5doB7OQ4xj0M4xuhFg@mail.gmail.com>
 <20240520202026.GI17126@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520202026.GI17126@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Mon, May 20, 2024 at 10:20:26PM +0200, David Sterba wrote:
> On Mon, May 20, 2024 at 05:58:37PM +0100, Filipe Manana wrote:
> > On Mon, May 20, 2024 at 4:48 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Fri, May 17, 2024 at 02:13:23PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > We do have some data races when accessing an inode's delayed_node, namely
> > > > we use READ_ONCE() in a couple places while there's no pairing WRITE_ONCE()
> > > > anywhere, and in one place (btrfs_dirty_inode()) we neither user READ_ONCE()
> > > > nor take the lock that protects the delayed_node. So fix these and add
> > > > helpers to access and update an inode's delayed_node.
> > > >
> > > > Filipe Manana (3):
> > > >   btrfs: always set an inode's delayed_inode with WRITE_ONCE()
> > > >   btrfs: use READ_ONCE() when accessing delayed_node at btrfs_dirty_node()
> > > >   btrfs: add and use helpers to get and set an inode's delayed_node
> > >
> > > The READ_ONCE for delayed nodes has been there historically but I don't
> > > think it's needed everywhere. The legitimate case is in
> > > btrfs_get_delayed_node() where first use is without lock and then again
> > > recheck under the lock so we do want to read fresh value. This is to
> > > prevent compiler optimization to coalesce the reads.
> > >
> > > Writing to delayed node under lock also does not need WRITE_ONCE.
> > >
> > > IOW, I would rather remove use of the _ONCE helpers and not add more as
> > > it is not the pattern where it's supposed to be used. You say it's to
> > > prevent load tearing but for a pointer type this does not happen and is
> > > an assumption of the hardware.
> > 
> > If you are sure that pointers aren't subject to load/store tearing
> > issues, then I'm fine with dropping the patchset.
> 
> This will be in some CPU manual, the thread on LWN
> https://lwn.net/Articles/793895/
> mentions that. I base my claim on reading about that in various other
> discussions on LKML over time. Pointers match the unsigned long type
> that is the machine word and register size, assignment from register to
> register/memory happens in one go. What could be problematic is constant
> (immediate) assigned to register on architectures like SPARC that have
> fixed size instructions and the constatnt has to be written in two
> steps.
> 
> The need for READ_ONCE/WRITE_ONCE is to prevent compiler optimizations
> and also the load tearing, but for native types up to unsigned long this
> seems to be true.
> 
> https://elixir.bootlin.com/linux/latest/source/include/asm-generic/rwonce.h#L29
> 
> The only requirement that can possibly cause the tearing even for
> pointer is if it's not aligned and could be split over two cachelines.
> This should be the case for structures defined in a normal way (ie. no
> forced mis-alignment or __packed).

For future reference: documented for example in Intel 64 and IA-32
Architectures, Software Developer's Manual, volume 3A, 9.2 Memory
ordering.

From section 9.2.3.1: "[...] Instructions that read or write a quadword
(8 bytes) whose address is aligned on an 8 byte boundary."


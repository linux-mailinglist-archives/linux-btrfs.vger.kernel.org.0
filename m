Return-Path: <linux-btrfs+bounces-5127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF98CA332
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 22:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73540B2171A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466441384B3;
	Mon, 20 May 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkRORJMA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vnB3cFHI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VS7VeVzT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nBGt/W/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6B137C48
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236431; cv=none; b=nsAUfcWeYj/Fjdl2fIHjBD3TQADTumV0o9ZPDwCsV8FaDeEnZi+i4NWSwzJf4Vhq0yFdIHvU5gcxA4R9aHaqaPq0+v7wuKvMZ9VQZh1cti4Qf3n3c7NzlZI7ZDOaKma2bhuj/IwXBG9xsbedJ9Xty78zMxmAMdToLnGceAodkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236431; c=relaxed/simple;
	bh=NfGtyac9c+nYuZ5IgxDun1QZ67u6PaGC32Ac9lGoGog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtE8v8wGuP7Za9Ia65HRIKNzyroI/ujLO3BkBgaKoZdDFqwEtYG0cvbLFRkFo6ihFFgJ3ZJmAwqdW1NGRbYYJ5IlQ6FL4aC4g3qP/6uQLjVnEItjmhEu0fbr9uqnZqslGnlp+Q4D57wMHeqOqhUd41OVQkYLSYhHlRYVKCPOFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkRORJMA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vnB3cFHI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VS7VeVzT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nBGt/W/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C44091F7B5;
	Mon, 20 May 2024 20:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716236428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3gRlkhM73gUvaN9bXMCfOt5j7EVCMxr1mi05lrdVW4=;
	b=GkRORJMAeoadHTQDOVklDAuwOCegoYGJ9wxjija+LGMSGllCU9CsBbiG1jU62xdveoDe/l
	O97iruoxs3obrwyFy+I88kpMc8BAzIJVtS+lZ0iA+XG5fIeuUdx0dWoFJqGX2nKQREywNz
	VrfrxJva3ijwyxK3GmxKSl5P4fj4rNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716236428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3gRlkhM73gUvaN9bXMCfOt5j7EVCMxr1mi05lrdVW4=;
	b=vnB3cFHIyOwoGd8FhkR0dzrYT07Jx+ZricUIdCcsyHN2rY461RrgJKVKSeM6eL7qkfGDUy
	b6vGbN0yLJ53tVBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VS7VeVzT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4nBGt/W/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716236427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3gRlkhM73gUvaN9bXMCfOt5j7EVCMxr1mi05lrdVW4=;
	b=VS7VeVzTce5J5ZMp1RIgXnqYQ5Xin2SPinqGIddl42VUJQQzlpggGwLz1x13gkgIN8zNN/
	Jw9XDUa1/jTE0v/wuCnc5WWh2IeV2z7jLEhhZTsyWiRJ1ZItnOFOERwC44fY3mFCB/PJUV
	4nsv3yeZbXryQyG6CQIpD27/hnCDscM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716236427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3gRlkhM73gUvaN9bXMCfOt5j7EVCMxr1mi05lrdVW4=;
	b=4nBGt/W/i9pAc0TumollMUTXtabrL166D3GerFjL3MVz0xUnqyXVB7GyttvFw5VW6uAOQ+
	GO/sP17I5ZIyExAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D4E13A21;
	Mon, 20 May 2024 20:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +u4MKIuwS2ZgUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 20 May 2024 20:20:27 +0000
Date: Mon, 20 May 2024 22:20:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: avoid data races when accessing an inode's
 delayed_node
Message-ID: <20240520202026.GI17126@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715951291.git.fdmanana@suse.com>
 <20240520154844.GF17126@twin.jikos.cz>
 <CAL3q7H5LhdkQq7aeU+yD_6RS9mYeBa5=5doB7OQ4xj0M4xuhFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5LhdkQq7aeU+yD_6RS9mYeBa5=5doB7OQ4xj0M4xuhFg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C44091F7B5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,suse.com:email]

On Mon, May 20, 2024 at 05:58:37PM +0100, Filipe Manana wrote:
> On Mon, May 20, 2024 at 4:48 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Fri, May 17, 2024 at 02:13:23PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > We do have some data races when accessing an inode's delayed_node, namely
> > > we use READ_ONCE() in a couple places while there's no pairing WRITE_ONCE()
> > > anywhere, and in one place (btrfs_dirty_inode()) we neither user READ_ONCE()
> > > nor take the lock that protects the delayed_node. So fix these and add
> > > helpers to access and update an inode's delayed_node.
> > >
> > > Filipe Manana (3):
> > >   btrfs: always set an inode's delayed_inode with WRITE_ONCE()
> > >   btrfs: use READ_ONCE() when accessing delayed_node at btrfs_dirty_node()
> > >   btrfs: add and use helpers to get and set an inode's delayed_node
> >
> > The READ_ONCE for delayed nodes has been there historically but I don't
> > think it's needed everywhere. The legitimate case is in
> > btrfs_get_delayed_node() where first use is without lock and then again
> > recheck under the lock so we do want to read fresh value. This is to
> > prevent compiler optimization to coalesce the reads.
> >
> > Writing to delayed node under lock also does not need WRITE_ONCE.
> >
> > IOW, I would rather remove use of the _ONCE helpers and not add more as
> > it is not the pattern where it's supposed to be used. You say it's to
> > prevent load tearing but for a pointer type this does not happen and is
> > an assumption of the hardware.
> 
> If you are sure that pointers aren't subject to load/store tearing
> issues, then I'm fine with dropping the patchset.

This will be in some CPU manual, the thread on LWN
https://lwn.net/Articles/793895/
mentions that. I base my claim on reading about that in various other
discussions on LKML over time. Pointers match the unsigned long type
that is the machine word and register size, assignment from register to
register/memory happens in one go. What could be problematic is constant
(immediate) assigned to register on architectures like SPARC that have
fixed size instructions and the constatnt has to be written in two
steps.

The need for READ_ONCE/WRITE_ONCE is to prevent compiler optimizations
and also the load tearing, but for native types up to unsigned long this
seems to be true.

https://elixir.bootlin.com/linux/latest/source/include/asm-generic/rwonce.h#L29

The only requirement that can possibly cause the tearing even for
pointer is if it's not aligned and could be split over two cachelines.
This should be the case for structures defined in a normal way (ie. no
forced mis-alignment or __packed).

In case of u64 we use _ONCE access because of 32bit architectures if
there's an unlocked access.


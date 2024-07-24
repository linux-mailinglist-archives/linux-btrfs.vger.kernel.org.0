Return-Path: <linux-btrfs+bounces-6679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071393B179
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A58283556
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70164158DC5;
	Wed, 24 Jul 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FuBQFIif";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHN8vmjI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FuBQFIif";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHN8vmjI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528A158A01;
	Wed, 24 Jul 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827104; cv=none; b=NJ698u9eVPR0gcN1G5XvcwU5gv/nqyyCw/cyqCjJRv2LKwJ9tSTpiF2+CPrScgOmITqxHMKLNXIXYiw7/+EygLYwTVpZffurbVOxR2NAcVv5rJj5a11LWe3FXiD4ARWxwk7DrllhbDhelXQmM6kfWLzKkbvIghMvWSL/od9k46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827104; c=relaxed/simple;
	bh=BcgE8AAOOwfeCRgY9SSi3X9+4INB9fz0CrgbbVMvhIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOIf1Dsk/PuX2euhXxWVlhmlXQVrVe3LbGKFGZwCDX4stNlGSXPBEDPU9nGtbm107NW5SJylmCjdfmu4GIJ9iYNbAmJXSWV1CdE5ivF5bTS9c+ee7H1R1NM4Cr79Q9UdidxiLVrG47mm4FTAhlDC9/VMpUdPjepffZmAhYIOAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FuBQFIif; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHN8vmjI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FuBQFIif; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHN8vmjI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEF7D1F7A1;
	Wed, 24 Jul 2024 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721827100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
	b=FuBQFIif1Yc1oeaBaLW8lYkBmLdefhslLAjPwWKBZbbVN5sjFwRfwigAdgW5tiVqWpummx
	DTB9pwhyVNO18d0Y60YgB+rwgvkBLAcpLA0bhGMGMOWwOVzKG3/ZCsKOLKbqo0M1GG7oCw
	0xTOW2S/R5iNPlqQ6qvgOSW2wD+1dXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721827100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
	b=PHN8vmjIum5QrnGQwAC7nE4RlXzg3zgNLTPQcaz+P3mWJGTWTtJ5fKrjHLBSb9vudv11Mh
	7uxDRJLj0Sko68Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FuBQFIif;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PHN8vmjI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721827100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
	b=FuBQFIif1Yc1oeaBaLW8lYkBmLdefhslLAjPwWKBZbbVN5sjFwRfwigAdgW5tiVqWpummx
	DTB9pwhyVNO18d0Y60YgB+rwgvkBLAcpLA0bhGMGMOWwOVzKG3/ZCsKOLKbqo0M1GG7oCw
	0xTOW2S/R5iNPlqQ6qvgOSW2wD+1dXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721827100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
	b=PHN8vmjIum5QrnGQwAC7nE4RlXzg3zgNLTPQcaz+P3mWJGTWTtJ5fKrjHLBSb9vudv11Mh
	7uxDRJLj0Sko68Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A741324F;
	Wed, 24 Jul 2024 13:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id noIPARz/oGbdEwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 24 Jul 2024 13:18:20 +0000
Date: Wed, 24 Jul 2024 15:18:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: ltp@lists.linux.it, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
	Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Avinesh Kumar <akumar@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c in
 kernel 6.6
Message-ID: <20240724131816.GA950793@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240719174325.GA775414@pevik>
 <20240722090012.mlvkaenuxar2x3vr@quack3>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722090012.mlvkaenuxar2x3vr@quack3>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BEF7D1F7A1
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.it,vger.kernel.org,kernel.dk,suse.com,gmail.com,suse.cz,suse.de,infradead.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

Hi all,


[ Cc Peter and Mike ]
> Hi!

> On Fri 19-07-24 19:43:25, Petr Vorel wrote:
> > LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3])
> > slowed down on kernel 6.6 on Btrfs and XFS, when run with default
> > parameters. These tests create 100 MB sparse file and write zeros (using
> > libaio or O_DIRECT) while 16 other processes reads the buffer and check
> > only zero is there.

> So the performance of this test is irrelevant because combining buffered
> reads with direct IO writes was always in "better don't do it" territory.
> Definitely not if you care about perfomance.

> > Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> > same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> > (Non default parameter creates much smaller file, thus the change is not that
> > obvious).

> But still it's kind of curious what caused the 9x slow down. So I'd be
> curious to know the result of the bisection :). Thanks for report!

It looks to be the slowdown was introduced by commit 63304558ba5d
("sched/eevdf: Curb wakeup-preemption") [1] from v6.6-rc1.

I also compiled current next (next-20240724), it's also slow  and reverting
commit from it returns the original speed on both Btrfs and XFS.

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63304558ba5dcaaff9e052ee43cfdcc7f9c29e85

> 								Honza


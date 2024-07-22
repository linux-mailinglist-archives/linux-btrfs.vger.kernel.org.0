Return-Path: <linux-btrfs+bounces-6640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD414938BAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1401F21AF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18732169AD0;
	Mon, 22 Jul 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZerB9KeA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dz9WzWKj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EO+BcFlt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kq0XYAPn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5EE17BC9;
	Mon, 22 Jul 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638818; cv=none; b=gmqFLmvqvDIu8zflLAxxmluWLabA+4c0AgqhPiObN8+4Pu5ix7mFerwk4mDuVaZX1B3UkNYTj1gDBDt31Pc+PMTHykoS0Vg8EW1gIrOwoWB2/dTsUq5CuPXkFowj5HoP+dzT+Ex5Sz+Gk4vlrMJwi6NP6Ho9PXBiX7dxJC8rhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638818; c=relaxed/simple;
	bh=JLcAuyPiDSx30GwijESCvZoCYSsXqen8tvQhGfPrm7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OORxaEjQA/zKu2+Ays/lHUaPZnkx4r15aLSINZYeZKCEgYRpZ6AiHtMM2ZwXDPvr4XOhqTr11jETf6+A9XrTQ7DGiOhp0s3tCwPexJY+vxAKkcYGqUzccuVRydFg0089AjMzdiRxtZUGWut/xGGjB+dUISXYb0w862Uz4y2b5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZerB9KeA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dz9WzWKj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EO+BcFlt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kq0XYAPn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB88E1FB57;
	Mon, 22 Jul 2024 09:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721638814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJB5XV0FFOvBs4JvmakQ5Jf3QQ6Nlki0oGRThRpQx04=;
	b=ZerB9KeAoC/Qb6ux5YuIWdkGVTGZ0eNBykK9nNkxOan4r4dZ6YcS012m1g91qpbfJR1p6l
	35vKs/jJZwNnXkKYAUASi3lg0QflYQRTQxpUQNr43WSmdQ3IkP7J81DFd3ZaDKjzGvlOUr
	5WSGhoLR/lc6xib3O31gRqXZTmq8AQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721638814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJB5XV0FFOvBs4JvmakQ5Jf3QQ6Nlki0oGRThRpQx04=;
	b=Dz9WzWKj4/yPCQUOjpYkL8hs+ulr1qns8Z434ZHFkJGRRoBha4gvt8eLvUDODX/fpwvYND
	T9u9baF40+454cAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EO+BcFlt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kq0XYAPn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721638812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJB5XV0FFOvBs4JvmakQ5Jf3QQ6Nlki0oGRThRpQx04=;
	b=EO+BcFltopxN5MEedbkTKXtfdPWF2jvEATCLj5+tozALURZIQTBcMPrtVeLyt5uroMBjLs
	0cYEO2HgX9flK++3wTBgpNlm/pyLJKzs0ASZ5JEsoDfVeUcbCIzBM66Tik49qEH3rfJFbd
	oWjdomn/u68xQlkGmbk/n3IgF+pU2WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721638812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJB5XV0FFOvBs4JvmakQ5Jf3QQ6Nlki0oGRThRpQx04=;
	b=kq0XYAPn5xIieWgtgglBQPLp8GIOShK4lUhS1c+IgrCExk9iKk2qA3mi88koLszv8U7P8I
	z0iih/bIIPaW2PBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD4E2136A9;
	Mon, 22 Jul 2024 09:00:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lx9FKpwfnmbpZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jul 2024 09:00:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 29ED1A08BD; Mon, 22 Jul 2024 11:00:12 +0200 (CEST)
Date: Mon, 22 Jul 2024 11:00:12 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c in
 kernel 6.6
Message-ID: <20240722090012.mlvkaenuxar2x3vr@quack3>
References: <20240719174325.GA775414@pevik>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719174325.GA775414@pevik>
X-Spam-Score: -3.81
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BB88E1FB57
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.it,vger.kernel.org,kernel.dk,suse.cz,suse.com,gmail.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Flag: NO

Hi!

On Fri 19-07-24 19:43:25, Petr Vorel wrote:
> LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3])
> slowed down on kernel 6.6 on Btrfs and XFS, when run with default
> parameters. These tests create 100 MB sparse file and write zeros (using
> libaio or O_DIRECT) while 16 other processes reads the buffer and check
> only zero is there.

So the performance of this test is irrelevant because combining buffered
reads with direct IO writes was always in "better don't do it" territory.
Definitely not if you care about perfomance.

> Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> (Non default parameter creates much smaller file, thus the change is not that
> obvious).

But still it's kind of curious what caused the 9x slow down. So I'd be
curious to know the result of the bisection :). Thanks for report!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


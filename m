Return-Path: <linux-btrfs+bounces-6641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005A938FB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 15:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7991F2190F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF016D9B3;
	Mon, 22 Jul 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DnrlcPpe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8V40oSO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DnrlcPpe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8V40oSO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8516A38B;
	Mon, 22 Jul 2024 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654040; cv=none; b=FVEkexlv9qzpIHrkaLc7QpjBZBtgpiFgDnFbGRzrJMpQV3fRqdISMEqIMYMzRnh5RhChvHOD/Gu8toH+IEyObwEsonPXNtVA/kjgIatyZ7MswHYM0KI2opaO84OVWC6zTzEyjc+KYgtLMcrSiYJtVVSmkhn7UA+4R6h2UJsgQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654040; c=relaxed/simple;
	bh=E7rO4+raxSImGQ+Lcvo8Hj4gA2KG0L/pi5voylWaDJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU3DxlBjasT2jpgJzLakyzzzCX7E1C3NLmvn9ZsZe+5Jny1ZPvLYCOJCtf1hO3pIuVPsDXxt19pYfuJhoxZgpmRxBT9csMdWdqZ0zx2VfnC2IJhTKBAqloE2CKFinN9gAm9Y5RGJqwmjuN5JfgvbhgCeSW2RYgihFC55/6QLUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DnrlcPpe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k8V40oSO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DnrlcPpe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k8V40oSO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE43121B49;
	Mon, 22 Jul 2024 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721654036;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
	b=DnrlcPpe3Ryh2Ac3vewtY2k6bQM7+wu1YJX0CahKi3yE5N51G3zL9WEWenroKYneSNCzNd
	w555qxHnXtiJZR9Afm1rRveVOyBW98iPQ+z45anB2ErQcKEV+4tW389x4eZWDYTEO3hNwh
	BzHY/Tc2fETyKXkf98u+qG1+/CGek3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721654036;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
	b=k8V40oSOrSysVQaDlq2nGICzlZsL88be1X8mCxHYWPSMTc2GVbatr7G9syghOi9DKL7AJT
	9/FwoaozLW3hZbBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DnrlcPpe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k8V40oSO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721654036;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
	b=DnrlcPpe3Ryh2Ac3vewtY2k6bQM7+wu1YJX0CahKi3yE5N51G3zL9WEWenroKYneSNCzNd
	w555qxHnXtiJZR9Afm1rRveVOyBW98iPQ+z45anB2ErQcKEV+4tW389x4eZWDYTEO3hNwh
	BzHY/Tc2fETyKXkf98u+qG1+/CGek3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721654036;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
	b=k8V40oSOrSysVQaDlq2nGICzlZsL88be1X8mCxHYWPSMTc2GVbatr7G9syghOi9DKL7AJT
	9/FwoaozLW3hZbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B3AB136A9;
	Mon, 22 Jul 2024 13:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DzdLGRRbnmZgMwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 22 Jul 2024 13:13:56 +0000
Date: Mon, 22 Jul 2024 15:13:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: ltp@lists.linux.it, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
	Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c in
 kernel 6.6
Message-ID: <20240722131354.GA858324@pevik>
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
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE43121B49
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.it,vger.kernel.org,kernel.dk,suse.com,gmail.com,suse.cz,suse.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO

Hi Jan, all,

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

Thanks a lot for having a look, Jan!

> > Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> > same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> > (Non default parameter creates much smaller file, thus the change is not that
> > obvious).

> But still it's kind of curious what caused the 9x slow down. So I'd be
> curious to know the result of the bisection :). Thanks for report!

I'm already working on it, report soon.

Kind regards,
Petr

> 								Honza


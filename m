Return-Path: <linux-btrfs+bounces-6614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39599937D2C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 22:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF1EB21B85
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18605148858;
	Fri, 19 Jul 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZkpV10C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jB439O0v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Grk5NTCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C6z9S11G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39861148308;
	Fri, 19 Jul 2024 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721420044; cv=none; b=A8Cx/cJnSZICAw9HC3HKeP7a55E136B1YuKE6BF7RfQnFYzalh76IPu6/8j8F2x0qdkDRV+a5d/rVbszcTiBVpQaE1juWhMJ353H9vS/Y6+xmQzAgG0pQKG9AJ5j72OdR9g29MTpmtFWLlP9d78qgqFKPu+a61fFqAdC53Pn0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721420044; c=relaxed/simple;
	bh=CkZNhvKU2DQf8NwMK82XmuMFe0JHfe2CGQhVcFakQM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjym23M354qP+CV6d7IHLZ3PAG/sdnvoO4BFWgqn+OaeSxq38GzELryIn3Z892nMdo91hdY42NonTaaHtFgSYGKTMrMfB9BY6dJe1v4b5rLVnEm/Ju0sIcWRgiFq/SrRKvvEsDHPRg8BCsPJM+eT/Q+8E8HVbUqr1JqGzRzpj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZkpV10C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jB439O0v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Grk5NTCg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C6z9S11G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0DCD41F7A5;
	Fri, 19 Jul 2024 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721420040;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkZNhvKU2DQf8NwMK82XmuMFe0JHfe2CGQhVcFakQM4=;
	b=mZkpV10CMyhafVWkXGJTf4KoCeEtMjkiAq0a+Dzsgyu+3Btqold9XPiGVkm1z2chANJIoo
	i8QdBE0zrm7Xy03Z/NYWf9ivaIeTSTMDJKl9d7k/6ZpQdh6khJl8AZJyjkCoVtuAVC+7kn
	go410SJqZAwBwkwA4M220p0K9byRGuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721420040;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkZNhvKU2DQf8NwMK82XmuMFe0JHfe2CGQhVcFakQM4=;
	b=jB439O0v3Jk6qmwrc8QT+cGWq/lW91AvVM8a2MNNcCcQPLV5jzyOQBnU1ZiZJCuA7Om98K
	FsM1I5+XH8iYl0CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Grk5NTCg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C6z9S11G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721420039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkZNhvKU2DQf8NwMK82XmuMFe0JHfe2CGQhVcFakQM4=;
	b=Grk5NTCgnDXOqfQERiZ7hI7cpEURm8HmBI7iqf3LF3L+xElLWuTQnk1fcwHxUOQht8/SKE
	hQY9ptWWamXejy57kIcnLkgtB0btRwFvqffXuV1Dx19nGL8eORoGSmn/i8YrtA7W2Ea4Ov
	DNEERyRCJglxuysRWn3FZM2FhpVSCxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721420039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkZNhvKU2DQf8NwMK82XmuMFe0JHfe2CGQhVcFakQM4=;
	b=C6z9S11G4trphls1mHd3AtzeGAiR7k6RJqDn7YVH6n7pL2mczCELS+u3KRvkG0j2VbIx8z
	XhRzMRRS7QKw6FCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7B1E13808;
	Fri, 19 Jul 2024 20:13:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QgiaJwbJmmZwSQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 19 Jul 2024 20:13:58 +0000
Date: Fri, 19 Jul 2024 22:13:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: ltp@lists.linux.it, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
	Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c in
 kernel 6.6
Message-ID: <20240719201352.GA782769@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240719174325.GA775414@pevik>
 <a59b75dd-8e82-4508-a34e-230827557dcb@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59b75dd-8e82-4508-a34e-230827557dcb@kernel.dk>
X-Spamd-Result: default: False [0.49 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.it,vger.kernel.org,suse.cz,suse.com,gmail.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 0DCD41F7A5
X-Spam-Score: 0.49
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /

Hi Jens, all,

> On 7/19/24 11:43 AM, Petr Vorel wrote:
> > Hi all,

> > LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3]) slowed
> > down on kernel 6.6 on Btrfs and XFS, when run with default parameters. These
> > tests create 100 MB sparse file and write zeros (using libaio or O_DIRECT) while
> > 16 other processes reads the buffer and check only zero is there.

> > Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> > same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> > (Non default parameter creates much smaller file, thus the change is not that
> > obvious).

> > Because the slowdown has been here for few kernel releases I suppose nobody
> > complained and the test is somehow artificial (nobody uses this in a real world).
> > But still it'd be good to double check the problem. I can bisect a particular
> > commit.

> > Because 2 filesystems affected, could be "Improve asynchronous iomap DIO
> > performance" [4] block layer change somehow related?

> No, because that got disabled before release for unrelated reasons. Why
> don't you just bisect it, since you have a simple test case?

Jens, thanks for info. Sure, I'll bisect next week and report.

The reason I reported before bisecting is because it wouldn't be the first time
the test was "artificial" and therefore reported problem was not fixed. If it's
a real problem I would expect it would be also caught by other people or even by
fstests.

Kind regards,
Petr


Return-Path: <linux-btrfs+bounces-9912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904289D9A38
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6494AB24616
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C731D61A7;
	Tue, 26 Nov 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEU6hnPg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJVgfVlt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEU6hnPg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJVgfVlt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFC1D54E3
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633888; cv=none; b=h2LxB0cNajHsqbNtY+u2jGeL/RaNeV4kUR7wA4IEO9oWcPEmaqjwZN+I3l7BDbequRixKCq1DvOVUQZjjCNsxoCHgIWISx3ACB9x4SIfg5fOowtyW8hcXUG7K+UmtN/UQ+FdYZXDK3cHDaL+8/kWl67X2esEBVmtfabYrK/KvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633888; c=relaxed/simple;
	bh=VqzdxWR7D5kTd9vTZdBQyJOW4y0cM5iXl6YPc4fI540=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRtEXlDwVyJaAuTMFCGCv4RcDIGwJNjo9E46PULD1TzbmFCPzipF7s2xGaqoUAwFixUIn3aHjAZIXj1vZAuWgP45W0HPkxML70RJt+fQZJPfsHIqokDh/1kQl/S9N1j/HosiF8MZY/2mLO5Z1fvlIOlhISfExrl5fn5UdhWGdI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEU6hnPg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJVgfVlt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEU6hnPg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJVgfVlt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB771F74C;
	Tue, 26 Nov 2024 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732633885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQLC76IrntFLv3YKJL1Cwuzv/j4WVlK6RmahEIePNR0=;
	b=xEU6hnPgHtID17aPV0aZB5wHXQED4nSc57JnR5CYdxbB5+Odz22WSUinDbXMAYuZPDo/nm
	TJy8mIqs7wAv3EFcT1fARitYHhG9eFrkrVLxKHsGTHXidd1rcstBIVedvEIIFn2SJf8rRd
	NWcnPYV05tvdRw+ly45R70eqUN4ebUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732633885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQLC76IrntFLv3YKJL1Cwuzv/j4WVlK6RmahEIePNR0=;
	b=KJVgfVltU5ellO2h1RPG6g0ySiPYf4FGG0OQr72F42xjWCiDnWioslZVd2eBWERXw2gxqA
	nVIw8rZdWZM4F7Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xEU6hnPg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KJVgfVlt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732633885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQLC76IrntFLv3YKJL1Cwuzv/j4WVlK6RmahEIePNR0=;
	b=xEU6hnPgHtID17aPV0aZB5wHXQED4nSc57JnR5CYdxbB5+Odz22WSUinDbXMAYuZPDo/nm
	TJy8mIqs7wAv3EFcT1fARitYHhG9eFrkrVLxKHsGTHXidd1rcstBIVedvEIIFn2SJf8rRd
	NWcnPYV05tvdRw+ly45R70eqUN4ebUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732633885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQLC76IrntFLv3YKJL1Cwuzv/j4WVlK6RmahEIePNR0=;
	b=KJVgfVltU5ellO2h1RPG6g0ySiPYf4FGG0OQr72F42xjWCiDnWioslZVd2eBWERXw2gxqA
	nVIw8rZdWZM4F7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2492113890;
	Tue, 26 Nov 2024 15:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hm6tCB3lRWdqBwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 15:11:25 +0000
Date: Tue, 26 Nov 2024 16:11:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-btrfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: Re: [PATCH] btrfs: add FS_IOC_READ_VERITY_METADATA ioctl
Message-ID: <20241126151123.GF31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241125084111.141386-1-allison.karlitskaya@redhat.com>
 <20241125181117.GB1242949@google.com>
 <CAOYeF9W0BUAkrAf0LTpKiD_Au5W8OUdeBZAdDOYxu=HLbC=jHQ@mail.gmail.com>
 <20241126023313.GA3095319@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126023313.GA3095319@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4DB771F74C
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Nov 26, 2024 at 02:33:13AM +0000, Eric Biggers wrote:
> On Mon, Nov 25, 2024 at 09:06:25PM +0100, Allison Karlitskaya wrote:
> > hi Eric,
> > 
> > Thanks for the reply.
> > 
> > On Mon, 25 Nov 2024 at 19:11, Eric Biggers <ebiggers@kernel.org> wrote:
> > > At the time, btrfs did not support fs-verity.
> > 
> > Oops.  I missed that detail. :)  I wonder why they did the
> > implementation without the metadata ioctl, then...
> > 
> > Would you like me to change the commit message?  (or feel free to do
> > it yourself...)
> 
> Please go ahead and update it.  Thanks!
> 
> BTW, I recommend that this be taken through the btrfs tree.

Yes this should go through our tree. Thanks for the patch and
evaluation. I've noticed one patch in fstests being skipped due to the
missing ioctl. Nobody knows why it wasn't added or what it could be
useful for but as there is a use case then we'll add it.


Return-Path: <linux-btrfs+bounces-10040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6848F9E297A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4656CB334B9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0001F9F6B;
	Tue,  3 Dec 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EcLAPmWp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o47bXGXC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wSTbhD6+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KP6j6OrR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AC1F4731;
	Tue,  3 Dec 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245291; cv=none; b=uKu0K85dFS1z4K0e1XAYJQ/l21Nl3TpbpClSygSmSf5PKiF0EMLNGgVXjU6vU7qlB1oTKMsVlhUfZyCdKFMNyjqCjDyCtI7LLYjtC0R3NplVAh9V9wU3vN3RZvEjstS94vt1rJnZ2Ht4JRGng4j+eJWtgu9JmL/ijFuxCY5RwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245291; c=relaxed/simple;
	bh=T50CD9tpq4orDR9cE7WAK/hyuHYxICOLZHTgZAAmPZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoHhJJavv9Nd37V5gPiBV262KLYhfOwSz3QMkcwxnXhpVbHYc+eS+i3PLbvt8A6zHql7ZNUBF/gbTxIAXkVVYt8W5gFW+Gvkx5/Qs2VuKItouNbYdVuIZrafofZqsbG2uQwI9HP4OXzQgcRobRXdtisCNJUa6lWzSUsl6zLPfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EcLAPmWp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o47bXGXC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wSTbhD6+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KP6j6OrR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A1162116D;
	Tue,  3 Dec 2024 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733245287;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Bf8ZhvDOqUYIczVxGOdzzygS/liFz2uGDXwN1p/LjA=;
	b=EcLAPmWpvJgs3dOWT+PSZkwdI5cE4Pqja3/vKeqrG2dlWQApXoxiN21KUgE6LADA/1TL8B
	iOeNTZhL0UtD4FCLwfbKdJRj8Kv2ppVMhfjWul7pWMz2gOAqKjbMGuFDE3iilkeJnLY/nR
	7wgZxF14zwt1UCxSQ1bQY4KqGbF02us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733245287;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Bf8ZhvDOqUYIczVxGOdzzygS/liFz2uGDXwN1p/LjA=;
	b=o47bXGXCpE01TBLOAS7urCrBxSb03u48wuUItZ1L9noD5WiJROVy9EiAOc/JxIUG3RQ1xr
	r3wWiWBkYh90DDCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wSTbhD6+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KP6j6OrR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733245286;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Bf8ZhvDOqUYIczVxGOdzzygS/liFz2uGDXwN1p/LjA=;
	b=wSTbhD6+M3gmC7Pji0sFbbFUU0W5Kqpn6VTcZGWbRZasotpMLPZ9HGZNn5MG3VaMniKvl4
	Na+ceQQEebuH8SPcD8RfFq00pEcZc7EKNdpl01S/rXkweg955g6UAM2hHEK2UmrCF3rnIw
	Uklt335D5rFJOEIc8uqPqLiy7G3atZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733245286;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Bf8ZhvDOqUYIczVxGOdzzygS/liFz2uGDXwN1p/LjA=;
	b=KP6j6OrRt2mUc9H+IODVuykmKla5usRzGGErI7cmEiM7hNupO/NkEHpKow9oQ+syCRB0o4
	woo1ppCXd715GQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3904C139C2;
	Tue,  3 Dec 2024 17:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9MvDDGY5T2dKZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Dec 2024 17:01:26 +0000
Date: Tue, 3 Dec 2024 18:01:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: fix a few zoned append issues v2 (now with Ccs)
Message-ID: <20241203170120.GE31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241104062647.91160-1-hch@lst.de>
 <20241108144857.GA8543@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108144857.GA8543@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 8A1162116D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 08, 2024 at 03:48:57PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 04, 2024 at 07:26:28AM +0100, Christoph Hellwig wrote:
> > Hi Jens, hi Damien, hi btrfs maintainers,
> 
> How should we proceed with this?  Should Jens just pick up the block
> bits and the btrfs maintainers pick up the btrfs once they are
> ready and the block bits made it upstream?

The block layer patches are now in master, I'm adding the remaining
patches to btrfs for-next.


Return-Path: <linux-btrfs+bounces-9599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3AE9C77E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344F61F21072
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909213CA93;
	Wed, 13 Nov 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="helnGw1z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vw07JzBJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="helnGw1z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vw07JzBJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5797083B;
	Wed, 13 Nov 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513298; cv=none; b=Wc9a7c2ssw3pkZtodityT7wHV3VMU2xWlkQa26dNJLJKe/cSysuyFEVZV1QIGMD+7opqPLbUT/zRHgQmN3+G0QbH3XBv30Uh18gcBPd3TsRRJEvNwr0CAGD3vd6qNFzpi48XkWD+JAALZIE3YDV+D7B75LXtQKzcpbQaAY3Tz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513298; c=relaxed/simple;
	bh=FeA4bpgiNidNL2opV8gP3BBCHF0vODranb5dontX6+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcVXsUQZ9qzNd0WNiT6xr1mCsAP6Zve31MTpjTT8R2g7mK24If7V2YvcpQhrS5hhZKD/MBGEBoBLazEFr4qwozYFmoNIIHwc42Dyy93bAGy0xNjxwzgKwVK3Uvny1E9dSpuuaGFnBEfNyRvlGgo7iI9F8+61QGBUEv1QD0BzCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=helnGw1z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vw07JzBJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=helnGw1z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vw07JzBJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0CD421166;
	Wed, 13 Nov 2024 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731513294;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUuf4uNap9rncTSP9UYbe3/HtwXFGkUWLN9x+qDvWY8=;
	b=helnGw1zmqop/3BeWJzx15qvaVwjv9XUtWObsZPNLMHLjOFL1vHkm1VgZbTavkN/efibla
	M23rsRgERwxgWWm7Q4DF6QQ3BDgeLPQt7QAcHHJOPOowy18U8ZC30DiTw7Afn5OtMOrOvc
	sRTMcSnS9YuxA0DFcykxwLnLYd8QWag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731513294;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUuf4uNap9rncTSP9UYbe3/HtwXFGkUWLN9x+qDvWY8=;
	b=vw07JzBJnECEu6LJJQo6/NYeTo9IomdrtKlZcxfJFWY1MpTIJ/MHt8d2/2bujebEb7uMtV
	DiAVKlsm1F9wymDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731513294;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUuf4uNap9rncTSP9UYbe3/HtwXFGkUWLN9x+qDvWY8=;
	b=helnGw1zmqop/3BeWJzx15qvaVwjv9XUtWObsZPNLMHLjOFL1vHkm1VgZbTavkN/efibla
	M23rsRgERwxgWWm7Q4DF6QQ3BDgeLPQt7QAcHHJOPOowy18U8ZC30DiTw7Afn5OtMOrOvc
	sRTMcSnS9YuxA0DFcykxwLnLYd8QWag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731513294;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUuf4uNap9rncTSP9UYbe3/HtwXFGkUWLN9x+qDvWY8=;
	b=vw07JzBJnECEu6LJJQo6/NYeTo9IomdrtKlZcxfJFWY1MpTIJ/MHt8d2/2bujebEb7uMtV
	DiAVKlsm1F9wymDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EF5013A6E;
	Wed, 13 Nov 2024 15:54:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1G1FJs7LNGfLJgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 13 Nov 2024 15:54:54 +0000
Date: Wed, 13 Nov 2024 16:54:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: validate queue limits in btrfs
Message-ID: <20241113155449.GQ31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241113084541.34315-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113084541.34315-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Nov 13, 2024 at 09:45:34AM +0100, Christoph Hellwig wrote:
> Hi Jens, hi btrfs maintainers,
> 
> a recent patch from me exposed the fact that btrfs did call the helper
> to validate the queue limits, which is also used to fill in precalculated
> values.  This series fixes that and is needed to fix a blktests regression
> in the current block tree.   I'd thus recommend to merge it through the
> block tree ASAP.

Ok, ack for the btrfs patch, thanks.


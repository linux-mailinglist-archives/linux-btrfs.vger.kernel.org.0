Return-Path: <linux-btrfs+bounces-7751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35310968F5B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3991C226ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89566188015;
	Mon,  2 Sep 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zb3YpfcM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Figpib6A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zb3YpfcM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Figpib6A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709E1714A4;
	Mon,  2 Sep 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725314230; cv=none; b=gmP576v/9P+fVS3dwKGj1X/FT3i5mzzll7vh8IpYDL/Hlzaj1Ty76+NY8X3liI2qcMVbNB2qgssMPLiYDPOOMRcHNxAPsaqVZbGi1gjH7v0NOLUeFxj/e2eTSiUFvXmjZA5CO7piQ454v2gw1xjd+Ec6a8nxO5dY0rKI2P+D5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725314230; c=relaxed/simple;
	bh=7CPKsxb2gORqbTacYSriwx0RFnwmDkI0esY3VpZKuSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH0s/WG61D49rTQ472gOzXsWltU/9/iY0eafcZ33KPp5A1JaTt9Qeu4cdpT5sEwqx8g0CJmsGTXOxlE+gxUDPEE2eC4DWDFOa/jb1fHVjqD1aPEfRziGR3pNG60VhMja7ohdsNOXye/X+/Lx7d51HJC4LCw9TlD1hReO7dy2UHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zb3YpfcM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Figpib6A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zb3YpfcM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Figpib6A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 300AF1FBBE;
	Mon,  2 Sep 2024 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725314227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CPKsxb2gORqbTacYSriwx0RFnwmDkI0esY3VpZKuSA=;
	b=Zb3YpfcMP7B9j0LGt5+ncOuNcljXfYjifwfiINHBlXideLpA0aNLQ82dowDbhsUHM14byc
	UjRh4xzzThWW6/FF+zwszjxok3/AioBFK2BPW0xl+2odccz0QAg0KM5Qwh9CrVA/jihlfk
	JVc4pXBHbJw4D8bTuaikFnBk/JJVjd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725314227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CPKsxb2gORqbTacYSriwx0RFnwmDkI0esY3VpZKuSA=;
	b=Figpib6AKIaKZID3Q5T0R72k8j476sDkQ4F2J5dkYqZuEOM3IZgLWJsXqXm5CRlMDxf3wh
	8LVdMyg7SY/+2iBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725314227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CPKsxb2gORqbTacYSriwx0RFnwmDkI0esY3VpZKuSA=;
	b=Zb3YpfcMP7B9j0LGt5+ncOuNcljXfYjifwfiINHBlXideLpA0aNLQ82dowDbhsUHM14byc
	UjRh4xzzThWW6/FF+zwszjxok3/AioBFK2BPW0xl+2odccz0QAg0KM5Qwh9CrVA/jihlfk
	JVc4pXBHbJw4D8bTuaikFnBk/JJVjd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725314227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CPKsxb2gORqbTacYSriwx0RFnwmDkI0esY3VpZKuSA=;
	b=Figpib6AKIaKZID3Q5T0R72k8j476sDkQ4F2J5dkYqZuEOM3IZgLWJsXqXm5CRlMDxf3wh
	8LVdMyg7SY/+2iBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10E5D1398F;
	Mon,  2 Sep 2024 21:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MeKrA7M01mZpMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 21:57:07 +0000
Date: Mon, 2 Sep 2024 23:57:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] block: Export bio_discard_limit
Message-ID: <20240902215705.GF26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
 <20240902205828.943155-2-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902205828.943155-2-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 02, 2024 at 10:56:10PM +0200, Luca Stefani wrote:
> It can be used to calculate the sector size limit of each
> discard call allowing filesystem to implement their own
> chunked discard logic with customized behavior, for example
> cancellation due to signals.

Maybe to add context for block layer people why we want to export this:

The fs trim loops over ranges and sends discard requests, some ranges
can be large so it's all transparently handled by blkdev_issue_discard()
and processed in smaller chunks.

We need to insert checks for cancellation (or suspend) requests into the
the loop. Rather than setting an arbitrary chunk length on the
filesystem level I've suggested to use bio_discard_limit() assuming it
will do optimal number of IO requests. Then we don't have to guess
whether 1G or 10G is the right value, unnecessarily increasing the
number of requests when the device could handle larger ranges.


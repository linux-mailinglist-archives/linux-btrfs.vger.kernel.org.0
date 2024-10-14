Return-Path: <linux-btrfs+bounces-8897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B399D1BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B5B2845B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7B1A76CE;
	Mon, 14 Oct 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gk3Pg5j7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vGjjALy8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFwCjadQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+VzMLtD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0A1C7608
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918971; cv=none; b=lFyQ2O6HyzPaGg1OgepgU9nhfHW2o+EmOYOPiIiW8jrT34bnTX6+7Wq/DuyHYG+/OjAqcsu2D7xtIPxz0myKaN0A6dA9qvYLrZDS12joPOfsm+RLqERPAWjQACon18Pd/RPUPymJJ1Ez0/7ClOsLp4607RoQPZTngi4kPqbJ1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918971; c=relaxed/simple;
	bh=OtnnX3Wsg5V78tvsZZM93loD7e9ey4E9LRiT7f6QVSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3YJa5yZjUf6V9xakQquDjjK8NEJagKdW2DFzgzINIrQyyBNQwXXvySErxy9sRN2HCewREkQOT6o6tdyA3eVUB5weM1wDOJEoF9fuyKWN2nM738gpvoAcNlFtBqnrjsJFEntUax4RK0XPDUELNx5scQMqfTibCrKsEWDc3/ZKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gk3Pg5j7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vGjjALy8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFwCjadQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+VzMLtD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 910C11F7C8;
	Mon, 14 Oct 2024 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728918967;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2W4L1yqNU5z0aKvEc8HzPZlFr5Pnkpbd5OCoaNCXWY=;
	b=Gk3Pg5j7xOzD/W82tW4xndiJmsYWcte8gOOB1bl+6udNTnx1lJGdOX2Bl+4GMvM8ZNvf5c
	R1KevZpx5qu4L1NjVJz4+VssOtDw7Aea/tGy+TqH39cPMYcGjv+QLaT5XtysGHKTyK2Z1L
	OEjf25lEKII54FW1VzaS8OOZr61JeQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728918967;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2W4L1yqNU5z0aKvEc8HzPZlFr5Pnkpbd5OCoaNCXWY=;
	b=vGjjALy8/Wa+/nnbku5ozDU/UOfqVG7eYRLD95kvawUH6EiThOQHgz4x7rnmKQQVVle4u3
	OEGTWRltbGPwAFAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728918965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2W4L1yqNU5z0aKvEc8HzPZlFr5Pnkpbd5OCoaNCXWY=;
	b=HFwCjadQ9Etzyj6NvAcQ8SsvNAdXOBSNUyQYRJNoJ5L+QLUqOylWODPb3lZ/g+vVmUF2Ip
	2dCZcDsi4h+bKwxzoOeuUbWyVe4Qz9bP/dQWHzosjmkaBLa2YKQhj56iQNCsHSXpcJ54Dr
	6ptFWj39tgqFuykzdFZclitWFVmteEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728918965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2W4L1yqNU5z0aKvEc8HzPZlFr5Pnkpbd5OCoaNCXWY=;
	b=a+VzMLtDWI82m3vjZl1BHkwg+20s6V176gyKlliZbIxDFssfjq6fEmCm5S3LcXJE9SgxuP
	jPa78KFpOsfAIkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74FEF13A42;
	Mon, 14 Oct 2024 15:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GL0KHLU1DWd/dgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Oct 2024 15:16:05 +0000
Date: Mon, 14 Oct 2024 17:16:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: try to search for data csums in commit root
Message-ID: <20241014151603.GC1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <0a59693a70f542120a0302e9864e7f9b86e1cb4c.1728415983.git.boris@bur.io>
 <20241011174603.GA1609@twin.jikos.cz>
 <20241011194831.GA2832667@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011194831.GA2832667@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Oct 11, 2024 at 12:48:31PM -0700, Boris Burkov wrote:
> > Can you please find another way how to store this? Maybe the bio flags
> > have some bits free. Otherwise this adds 8 bytes to btrfs_bio, while
> > this structure should be optimized for size.  It's ok to use bool for
> > simplicity in the first versions when you're testing the locking.
> 
> Ooh, good point!
> 
> I started looking into it some more and it's tricky but I have a few
> ideas, curious what you think:
> 
> 1. Export the btrfs_bio_ctrl and optionally wire it through the
>    callstack. For data reads it is still live on the stack, we just can't
>    be sure that containerof will work in general. Or just wire the bool
>    through the calls. This is pretty "trivial" but also ugly.
> 2. We already allocate an io context in multi-device scenarios. we could
>    allocate a smaller one for single. That doesn't seem that different
>    than adding a flags to btrfs_bio.
> 3. Figure out how to stuff it into struct btrfs_bio. For example, I
>    think we aren't using btrfs_bio->private until later, so we could put
>    a to-be-overwritten submit control struct in there.

Maybe this could work but seems fragile as the private pointer is used
for other strucutres and purposes. All in a void pointer. We need to
store only a single bit of information, so this can work with some stub
pointer type that can be at least recognized when mistakenly
dereference.

> 4. Figure out how to stuff it into struct bio. This would be your
>    bi_flags idea. However, I'm confused how to do that safely. Doesn't
>    the block layer own those bits? It seems aggressive for me to try
>    to use them. bio has a bi_private as well, which might be unset in
>    the context we care about.

#define BTRFS_BIO_FLAG_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST + 1)

I don't see any code in block/* that would verify the bio bits. Also the
REQ_ bits could be used, we already do that with REQ_BTRFS_CGROUP_PUNT
and at some point the REQ_DRV was used (removed in a39da514eba81e687db).

> I'm leaning towards option 3: taking advantage of the yet unset
> btrfs_bio->private


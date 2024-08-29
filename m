Return-Path: <linux-btrfs+bounces-7664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B23B964CEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 19:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFF7B21ECB
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95311B6555;
	Thu, 29 Aug 2024 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/ZKYx2z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="waVHTsT6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/ZKYx2z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="waVHTsT6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2771B0120
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953021; cv=none; b=Oc632iT4wdyhKzPcvAw+YaTi23/tMQkgWz6Ng/NPSxU5EoMqIBb6yJdoHuvsKFYs4WqN3Qv3CWoh4/ZGdSuHUzI8BlVARDeqXENUpMsqGgq95HA/NqyQkxElndFrWzccF2/AX8QaHVGjGh6leS5+R/Xh0wgtUbmbsdCdziN5Eq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953021; c=relaxed/simple;
	bh=1dNAKHwHGhR1EbatZueWIc5wYz72ZtYp+WQCudESuuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXUCPwvZVxjM8Spasd6FpbK4MF+d6uEmckg47iqErdOzfw5/GVmsprtzxTGg7xgaxHAlmxMjc7cS9GZZoYmpkf8ZgnVfLQyJnJZUJirUKoBwW5OBgF3Mhp8+9whVxh5VQEan9hMvAmdpi02dE2ZTPbpQ/o0XwmUQyhM0wu7St8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/ZKYx2z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=waVHTsT6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/ZKYx2z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=waVHTsT6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CF871F455;
	Thu, 29 Aug 2024 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724953017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw/jLU0VoO1d5YagOE/vIIzcYzzO1gcP4aC5LM86vTM=;
	b=O/ZKYx2z+CR1CBtPISPyeB2mN2+HdYt5zXyZbHcbNbKRyRDfbb9swfQS/kN/yeg1YihgtT
	2q2JX3fBSQW2ax++tmtpAyPLyb1iTZgsmNrkcqmcVHuSB5oRdHfzgF/chOYQ9Y3H3U/+7R
	b9crBD5jdzfgtQx0ZPOfm2gLs2f2wDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724953017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw/jLU0VoO1d5YagOE/vIIzcYzzO1gcP4aC5LM86vTM=;
	b=waVHTsT6DtdkByk3u5CY9efa1yhGILprae2bxszChDilaPmGk0d7Fpa+EHN0Rzz88mtwvv
	AvRtYgv5I5yYzrAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724953017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw/jLU0VoO1d5YagOE/vIIzcYzzO1gcP4aC5LM86vTM=;
	b=O/ZKYx2z+CR1CBtPISPyeB2mN2+HdYt5zXyZbHcbNbKRyRDfbb9swfQS/kN/yeg1YihgtT
	2q2JX3fBSQW2ax++tmtpAyPLyb1iTZgsmNrkcqmcVHuSB5oRdHfzgF/chOYQ9Y3H3U/+7R
	b9crBD5jdzfgtQx0ZPOfm2gLs2f2wDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724953017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw/jLU0VoO1d5YagOE/vIIzcYzzO1gcP4aC5LM86vTM=;
	b=waVHTsT6DtdkByk3u5CY9efa1yhGILprae2bxszChDilaPmGk0d7Fpa+EHN0Rzz88mtwvv
	AvRtYgv5I5yYzrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46D4C13408;
	Thu, 29 Aug 2024 17:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jE4OEbmx0GaXDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 17:36:57 +0000
Date: Thu, 29 Aug 2024 19:36:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Josef Bacik <josef@toxicpanda.com>, Leo Martins <loemra.dev@gmail.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <20240829173655.GN25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
 <20240827203058.GA2576577@perftesting>
 <20240828001601.GC25962@twin.jikos.cz>
 <Zs9ZuApvQCH4ITT9@devvm12410.ftw0.facebook.com>
 <20240828175419.GI25962@twin.jikos.cz>
 <Zs9ycrywZ/yIboGO@devvm12410.ftw0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9ycrywZ/yIboGO@devvm12410.ftw0.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[toxicpanda.com,gmail.com,vger.kernel.org,fb.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Wed, Aug 28, 2024 at 11:54:42AM -0700, Boris Burkov wrote:
> > > This pattern came from the cleanup.h documentation:
> > > https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L11
> > 
> > [...] @free should typically include a NULL test before calling a function
> > 
> > Typically yes, but we don't need to do it twice.
> 
> I believe we do if we want to get the desired compiler behavior in the
> release case. Whether or not the resource-freeing function we call
> checks NULL is not relevant to the point of checking it here in the
> macro.

I'm trying to understand why we're discussing that, maybe I'm missing
some aspect that makes it important to stick to the recommended use.
I've been reading the macros and looking for potential use, from that
POV no "if(NULL)" check is needed when it's done in the freeing
function.

There will be few cases that we will review when using the macros and
then we can forget about the details and it will work.

> > > As far as I can tell, it will only be relevant if we end up using the
> > > 'return_ptr' functionality in the cleanup library, which seems
> > > relatively unlikely for btrfs_path.
> > 
> > So return_ptr undoes __free, in that case we shouldn't use it at all,
> > the macros obscure what the code does, this is IMHO taking it too far.
> 
> This may well be taking it too far, but it is a common and valid
> pattern of RAII: auto freeing the half-initialized parts of structure
> automatically on the error exit paths in the initialization, while
> releasing the local cleanup responsibility on success.
> 
> Look at their alloc_obj example again:
> https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L31
> and the explanation that acknowledges kfree handles NULL:
> https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L43
> 
> Suppose we were initializing some object that owned a path (and cleaned
> it up itself on death), then initializing that object we would create a
> __free owned path (to cleanup on every error path), but then once we were
> sure we were done, we would release the auto free and let the owning object
> take over before returning it to the caller. Freeing the path in this case
> would be a bug, as the owning object would have it freed under it.
> 
> That's almost certainly nonsense for btrfs_path and will never happen,
> but it isn't in general,

You got me worried in the previous paragraph, I agree it will never
happen so I'm less inclined to prepare for such cases.

> so if we do add a __free, it makes sense to me
> to do it by the book. If we really want to avoid this double check, then
> we should add a comment saying that btrfs_path will never be released,
> so it doesn't make sense to support that pattern.

Sorry I don't understand this, can you please provide pseudo-code
examples? Why wouldn't be btrfs_path released?


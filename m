Return-Path: <linux-btrfs+bounces-13890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6470AB3CB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABC0189ABA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76D23C8D5;
	Mon, 12 May 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaUNwJoX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq9Z5Ym+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaUNwJoX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq9Z5Ym+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF523C518
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065189; cv=none; b=qEvGki6yZRPaxnON3bQT9ol3QvNecgsfXAJnHUqob998LNG34F8UcoMem076QnfUBShR1Pn86Yr5gHkHpagzSOMb9+cpNe0yLqTiXJSeEnLh5GF7XV5Y+kKdlVnFd79nRn9fHZRGB5xUypYct0IHbE4JBIjnZXiOY4TGKDrmZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065189; c=relaxed/simple;
	bh=sHGfT/esHxH/EpEUw8csMFgDpzk/LLy/h0fSfAToUDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mArRLhj66EUell7ABY2SsFnhxts+4FIzN1+Sm2qk+gGYiQdfD2G8EGK1wtIPKSq3baunFj4PMlwoPb7q7/W6tX748K1AsDt1jyJvc5X/cS7T2MSpDt3oLZ+LoPkuoT4rjiAIasFavLdY4F1bOYEsqHRqGhzpaPFMmL4UkusG7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaUNwJoX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq9Z5Ym+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaUNwJoX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq9Z5Ym+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 193E61F388;
	Mon, 12 May 2025 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747065186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RC4H8NDtvZ6AgBXzPCZxlyV+F16cipyF+sZdXWlS4Hw=;
	b=eaUNwJoXd8lzDxmNq6Bmpm23R+FtoruLEdPGolxtia5JeYRJt5c9IF5pRd9xyF21nvi6QG
	jRXfUODoJxWJHd8Q0JXH4mMAaacjrTg/gKzlWGLfP8w62Xf7hFVnmiIr445kCI899rOBl/
	oRuiyEzi3UTC0JEqIJKd/4g5Mi4WIoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747065186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RC4H8NDtvZ6AgBXzPCZxlyV+F16cipyF+sZdXWlS4Hw=;
	b=gq9Z5Ym+Hba/gURfxjtBvBhJGf2o3bdPC229XrCuW1ycGe38qKobg3VTBbwtvnLsOClzHq
	6ueAd+sfOOI+qeBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eaUNwJoX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gq9Z5Ym+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747065186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RC4H8NDtvZ6AgBXzPCZxlyV+F16cipyF+sZdXWlS4Hw=;
	b=eaUNwJoXd8lzDxmNq6Bmpm23R+FtoruLEdPGolxtia5JeYRJt5c9IF5pRd9xyF21nvi6QG
	jRXfUODoJxWJHd8Q0JXH4mMAaacjrTg/gKzlWGLfP8w62Xf7hFVnmiIr445kCI899rOBl/
	oRuiyEzi3UTC0JEqIJKd/4g5Mi4WIoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747065186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RC4H8NDtvZ6AgBXzPCZxlyV+F16cipyF+sZdXWlS4Hw=;
	b=gq9Z5Ym+Hba/gURfxjtBvBhJGf2o3bdPC229XrCuW1ycGe38qKobg3VTBbwtvnLsOClzHq
	6ueAd+sfOOI+qeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF6581397F;
	Mon, 12 May 2025 15:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TBAyOmEZImiMWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 15:53:05 +0000
Date: Mon, 12 May 2025 17:52:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fdmanana@kernel.org
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
Message-ID: <20250512155256.GM9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
 <20250512145939.GL9140@twin.jikos.cz>
 <CAPjX3Ff+XrWHJq_cBPUaK5memR3eMh-xpCeR7rk3uOa3yPE8Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Ff+XrWHJq_cBPUaK5memR3eMh-xpCeR7rk3uOa3yPE8Mg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 193E61F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Mon, May 12, 2025 at 05:07:12PM +0200, Daniel Vacek wrote:
> On Mon, 12 May 2025 at 16:59, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, May 06, 2025 at 09:47:32AM -0700, Boris Burkov wrote:
> > > @@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
> > >       return eb;
> > >  }
> > >
> > > +/*
> > > + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> > > + * does not call folio_put(), and we need to set the folios to NULL so that
> > > + * btrfs_release_extent_buffer() will not detach them a second time.
> > > + */
> > > +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> > > +{
> > > +     int num_folios = num_extent_folios(eb);
> > > +
> > > +     for (int i = 0; i < num_folios; i++) {
> >
> > You can use num_extent_folios() directly without the temporary variable,
> > see bd06bce1b387c5 ("btrfs: use num_extent_folios() in for loop bounds")
> 
> Not if the loop does eb->folios[0] = NULL; We've been there and had to
> actually change it this way.
> 
> Using num_extent_folios() directly is a bug here.

Ok then it needs a comment before somebody will want to clean it up.


Return-Path: <linux-btrfs+bounces-15325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5DAFCD93
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0048580953
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47242DFA28;
	Tue,  8 Jul 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWkHGW8E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtsUrQX5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWkHGW8E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtsUrQX5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE37E0FF
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984862; cv=none; b=k0lTk85BGti8KLcqyugR7sMrNDWhmBP5W3j/HjSE//T8SqDjqqmVRuVTH7YsleEV5wa2bn65NJfkmvl6z4SeEma8B3JfyuQxXmvniFuqK+WabZ+xw6h1BtUewpA1cLvvcIAEnd683JpMcWxCwQWfZhfLavDyOeja8L2kRrN5LAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984862; c=relaxed/simple;
	bh=ear+QCXz/zWyPtkgNIKTRwnZPBDaGTjXSjKKjtY+4yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIONdzb+Qisk2sc4mbQv+2nSlGhhDEr/tcilKmWHirUbOq9tHUBNcZHwOlnF/42b8kxMZBlJir5gM/1TaEaVgLeSmHYyO3FNzigoNsKGBD773h2iorwvFqL8q5UQEPhM9Ddr2S34CQSgKAQz5NeHFuwDpLJlr0MdYVOTHFOiIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWkHGW8E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtsUrQX5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWkHGW8E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtsUrQX5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AB531F38D;
	Tue,  8 Jul 2025 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751984858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ydhq+UYnb4a/cowpPR7W8w+yF+W6w+4Ej145WoMQPU=;
	b=dWkHGW8EIgTKYQQTG9XS9v8P+HWjWQnALI/uTUXAi9fz5G1yUJSTqPf+W9+eUzuWnvUorW
	KngzrozLpIuCARDjbgiauXjZ9cgmlqLI9ZDW51hRrDWIlzuOwMVjl7ZeHG8PQjspcSsvd7
	svy+U8NWRwgQ2YVzu6G+pR+EGz9iiis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751984858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ydhq+UYnb4a/cowpPR7W8w+yF+W6w+4Ej145WoMQPU=;
	b=vtsUrQX510ISbs3uo24a5SKXNta/Oxc6M7JTN9IQyOHqMvLi3CcLeTaAHpECqbppVlx76s
	8qKsgs0nLfaGEUCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751984858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ydhq+UYnb4a/cowpPR7W8w+yF+W6w+4Ej145WoMQPU=;
	b=dWkHGW8EIgTKYQQTG9XS9v8P+HWjWQnALI/uTUXAi9fz5G1yUJSTqPf+W9+eUzuWnvUorW
	KngzrozLpIuCARDjbgiauXjZ9cgmlqLI9ZDW51hRrDWIlzuOwMVjl7ZeHG8PQjspcSsvd7
	svy+U8NWRwgQ2YVzu6G+pR+EGz9iiis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751984858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ydhq+UYnb4a/cowpPR7W8w+yF+W6w+4Ej145WoMQPU=;
	b=vtsUrQX510ISbs3uo24a5SKXNta/Oxc6M7JTN9IQyOHqMvLi3CcLeTaAHpECqbppVlx76s
	8qKsgs0nLfaGEUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3708713A68;
	Tue,  8 Jul 2025 14:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DpskDdoqbWhdSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Jul 2025 14:27:38 +0000
Date: Tue, 8 Jul 2025 16:27:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Alan Huang <mmpgouride@gmail.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	wqu@suse.com
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
Message-ID: <20250708142732.GM4453@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250708132540.28285-1-dsterba@suse.com>
 <23A10F0D-C9CD-4A92-AEEB-8AF8E092DB4E@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23A10F0D-C9CD-4A92-AEEB-8AF8E092DB4E@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,lwn.net:url,suse.com:email];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,suse.cz:replyto,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Jul 08, 2025 at 10:18:09PM +0800, Alan Huang wrote:
> On Jul 8, 2025, at 21:25, David Sterba <dsterba@suse.com> wrote:
> > 
> > Implement sb->freeze_super that can instruct our threads to pause
> > themselves. In case of (read-write) scrub this means to undo
> > mnt_want_write, implemented as sb_start_write()/sb_end_write().
> > The freeze_super callback is necessary otherwise the call
> > sb_want_write() inside the generic implementation hangs.
> > 
> > This works with concurrent scrub running and 'fsfreeze --freeze', not
> > with process freezing (like with suspend).
> > 
> > References: https://lwn.net/Articles/1018341/
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> > fs/btrfs/fs.h    |  2 ++
> > fs/btrfs/scrub.c | 21 +++++++++++++++++++++
> > fs/btrfs/super.c | 36 ++++++++++++++++++++++++++++++++----
> > 3 files changed, 55 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index 8cc07cc70b12..005828a6ab17 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -137,6 +137,8 @@ enum {
> > BTRFS_FS_QUOTA_OVERRIDE,
> > /* Used to record internally whether fs has been frozen */
> > BTRFS_FS_FROZEN,
> > + /* Started freezing, pause your progress. */
> > + BTRFS_FS_FREEZING,
> > /*
> > * Indicate that balance has been set up from the ioctl and is in the
> > * main phase. The fs_info::balance_ctl is initialized.
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index 6776e6ab8d10..9a6bce6ea191 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -2250,6 +2250,27 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
> > ret = -ECANCELED;
> > break;
> > }
> > +
> > + /* Freezing? */
> > + if (test_bit(BTRFS_FS_FREEZING, &fs_info->flags)) {
> > + atomic_inc(&fs_info->scrubs_paused);
> > + smp_mb();
> 
> The memory barrier before wake_up seems not needed

Yeah, possibly smp_mb__after_atomic(), I took the simplest approach not
to get distracted by reasoning about barriers.


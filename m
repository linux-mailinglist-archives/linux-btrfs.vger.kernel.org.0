Return-Path: <linux-btrfs+bounces-3514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C88873E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1A4B22B48
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17B7A137;
	Fri, 22 Mar 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HI4XygVi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l9+9b/4l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iEAR/L4U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNQIK5np"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8C79B86;
	Fri, 22 Mar 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135708; cv=none; b=bjENnjCPIQPbTUZy1y9FzD5WtY4pz3pu2h/+EdFM7i0v3Q9SyBjPYqD43aMW969yQl3B3kIIOOEQptRKCctVtBowLMLF22O8ovoj8KrSdReyLr3yFIUzaviXgY6Uo7S9WWlBtN6p189uSYibxnFDX0mXEMSt9aRZbTtJrERbnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135708; c=relaxed/simple;
	bh=gjBO/n3tvNmqzJTwN1vMsW3KvoK7d6Ksag+l88ycBNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCMH2wdpAESDNRAC13otH9WQEfGEcs+sIUQ/L6bsPgjXKlrFaqkKzP+BvlKn56vZwDDFSG/GdO6zkqllCC/ldgKgwKnUzfNMalABdmTqJPx6r33dE001bI0aYQHe9sdK06R8ZIy5Yr4/UIeCOnPJjvzSzQhjvYl0Le+FjBKonMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HI4XygVi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l9+9b/4l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iEAR/L4U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNQIK5np; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED5EA38917;
	Fri, 22 Mar 2024 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711135704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MlXKbWYWf6ZszMJFknPMYT3hDt5uq28CojVsP5eYUQg=;
	b=HI4XygVileQBgOlO3oxKBk5qvy/FD1U9riFbB0clDw9ZdKc6sKToAIJGxIbjVN0nlAhIaJ
	Q1ZZ2wJEgkYD8uJ/gevZOrv0XpWmVRFV3ORb64xNPfgKLi7t6gEcxGjfI384cRTwgh6Q1k
	ltXPhNzd3klxOjKA4DcmFP0hlljJB8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711135704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MlXKbWYWf6ZszMJFknPMYT3hDt5uq28CojVsP5eYUQg=;
	b=l9+9b/4lAwnZo6EzAjsoa4+UTcENRACdLdQ84xKNdNpweIwbG2z1PphynFVrSEU0Xtb49E
	0qPichFqjJQ92bCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711135703;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MlXKbWYWf6ZszMJFknPMYT3hDt5uq28CojVsP5eYUQg=;
	b=iEAR/L4UcAVyozNbJg2EWDUw6wakuDp9lxWd+RZevlUiAxm+Ql/uHB1aXPwmCWUFvxWDMF
	WWrav2zkCXG3n3MHnRHSghmf7QHtHvFuXr+rFi7HUK9ZAp/WKwuzCA9/tNXv4Qgp6bvaqc
	kFRXxp3JOxxchdPX8CzFNOYAcZYjxGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711135703;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MlXKbWYWf6ZszMJFknPMYT3hDt5uq28CojVsP5eYUQg=;
	b=rNQIK5npFbBT4BOwts65yq8c7DLMY5YBrBG8cHRx7PvxKCBddA4+iJF5dNZsvjjRKMj/nE
	ak0HP8hSfczkc6BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CCEBA138E8;
	Fri, 22 Mar 2024 19:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Uc5sMdfb/WV5KwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 22 Mar 2024 19:28:23 +0000
Date: Fri, 22 Mar 2024 20:21:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix race in read_extent_buffer_pages()
Message-ID: <20240322192108.GK14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="iEAR/L4U";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rNQIK5np
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: ED5EA38917
X-Spam-Flag: NO

On Fri, Mar 15, 2024 at 09:14:29PM -0400, Tavian Barnes wrote:
> To prevent concurrent reads for the same extent buffer,
> read_extent_buffer_pages() performs these checks:
> 
>     /* (1) */
>     if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>         return 0;
> 
>     /* (2) */
>     if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
>         goto done;
> 
> At this point, it seems safe to start the actual read operation. Once
> that completes, end_bbio_meta_read() does
> 
>     /* (3) */
>     set_extent_buffer_uptodate(eb);
> 
>     /* (4) */
>     clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> 
> Normally, this is enough to ensure only one read happens, and all other
> callers wait for it to finish before returning.  Unfortunately, there is
> a racey interleaving:
> 
>     Thread A | Thread B | Thread C
>     ---------+----------+---------
>        (1)   |          |
>              |    (1)   |
>        (2)   |          |
>        (3)   |          |
>        (4)   |          |
>              |    (2)   |
>              |          |    (1)
> 
> When this happens, thread B kicks of an unnecessary read. Worse, thread
> C will see UPTODATE set and return immediately, while the read from
> thread B is still in progress.  This race could result in tree-checker
> errors like this as the extent buffer is concurrently modified:
> 
>     BTRFS critical (device dm-0): corrupted node, root=256
>     block=8550954455682405139 owner mismatch, have 11858205567642294356
>     expect [256, 18446744073709551360]
> 
> Fix it by testing UPTODATE again after setting the READING bit, and if
> it's been set, skip the unnecessary read.
> 
> Fixes: d7172f52e993 ("btrfs: use per-buffer locking for extent_buffer reading")
> Link: https://lore.kernel.org/linux-btrfs/CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com/
> Link: https://lore.kernel.org/linux-btrfs/f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com/
> Link: https://lore.kernel.org/linux-btrfs/c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com/
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>

Thank you very much for taking the time to debug the issue and for the
fix. It is a rare occurrence that a tough bug is followed by a fix from
the same person (outside of the developer group) and is certainly
appreciated.


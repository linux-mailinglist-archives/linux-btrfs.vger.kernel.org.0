Return-Path: <linux-btrfs+bounces-3555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F7388A8B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 17:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78FF1C61B01
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388B1442F0;
	Mon, 25 Mar 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nVnVBm2I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oF+aZ73H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yMGnLxgl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ueDDsZj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B9481B9;
	Mon, 25 Mar 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375939; cv=none; b=jxTfu+uXD0FcHmQcq62I546fJEATRQ4rTNTglK7rpHVlQ9qTJVGKHyLNfFP9PGBnbldPzg/8CQ/o8UrXYrsfNTyYup+rDl67Fg7qVATSZ+MkiMhgFtzEN6rK1t8jWaBi4nFQzuvhdnbfFRQ+I9iiFuWEdWuTlGoU/yaTZ1vfl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375939; c=relaxed/simple;
	bh=TzG/5JvXxF0JUHmaB2rBPKjBsvYfGQMLsovDtlcFUi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BppaJcXSKNRPEdAgSUbW/CeVZz3setdzq9b2VicsW1WIUUT5j3joIDnT4+7rlrpTWSAJ0r59YjH7sxpnA4jAYm07RCnLJf2xG9ZGOkmIXvfKae+Thy+YbIDqgFeDlAGPAZ6uyjAoVYL+z/403aBJ293vAWSFu9aOJgRpGWavO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nVnVBm2I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oF+aZ73H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yMGnLxgl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ueDDsZj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3BAB5C780;
	Mon, 25 Mar 2024 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711375934;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItTJVT5nAX87K/Z5OvY7omTInh/1LcJz1dpUI80klZk=;
	b=nVnVBm2I4wmWVWtmOkflWOnei47LnzrZAZ7/Bxk9nmjN+rsjMsF4KcKrAQxAJtO6jA2cKd
	wolQ4BmWEoSSY6LM3+AhiEgRTlHPxV2gh2a+E9XzM/qPetSj6ZT9HVk3jdO5+p78jTONDv
	/dPoai3xWdk1nLJBH4oMpaJVajyM5G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711375934;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItTJVT5nAX87K/Z5OvY7omTInh/1LcJz1dpUI80klZk=;
	b=oF+aZ73H8BmSMuL0jjB/nCOTIl8faY1i0GG4RUFj7ys9Iv8lLH2dp4pXpNQRl7CuzkKY7F
	7CI4qLo4CS9SFHAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711375933;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItTJVT5nAX87K/Z5OvY7omTInh/1LcJz1dpUI80klZk=;
	b=yMGnLxgla1G+PnAsNeIHM5sA7XO7oDbhMFE4OxE2uobyUjWSiJWtkFz8gZaGC6dlnxosAa
	rTvCsXVndoLb2G597bUNfLYaR18R6Atw5YVLS+8raop19WhF6GS/gQYmU4rXouj/+iMAC3
	JiCnWh0zkrUC58k5M9ySi+5fcac1Frc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711375933;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItTJVT5nAX87K/Z5OvY7omTInh/1LcJz1dpUI80klZk=;
	b=5ueDDsZjNlN/UJGUxihSjpSxT4CTGP/UjOTdcUuwUwh+/FpQD2Z3AEIu45vYJPVwu2j6+P
	eEPTT8hoHfYaxWAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A184A13A71;
	Mon, 25 Mar 2024 14:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UNYQJz2GAWYyKQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 25 Mar 2024 14:12:13 +0000
Date: Mon, 25 Mar 2024 15:04:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix race in read_extent_buffer_pages()
Message-ID: <20240325140452.GM14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
 <20240322192108.GK14596@twin.jikos.cz>
 <CABg4E-n=iWjM3K0dvrrwQ9BOEiqTawJ4YUVL6RPWaq2DT2AKvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABg4E-n=iWjM3K0dvrrwQ9BOEiqTawJ4YUVL6RPWaq2DT2AKvQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-0.30)[-0.297];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yMGnLxgl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5ueDDsZj
X-Rspamd-Queue-Id: C3BAB5C780

On Fri, Mar 22, 2024 at 06:50:07PM -0400, Tavian Barnes wrote:
> On Fri, Mar 22, 2024 at 3:28 PM David Sterba <dsterba@suse.cz> wrote:
> > On Fri, Mar 15, 2024 at 09:14:29PM -0400, Tavian Barnes wrote:
> > > To prevent concurrent reads for the same extent buffer,
> > > read_extent_buffer_pages() performs these checks:
> > >
> > >     /* (1) */
> > >     if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> > >         return 0;
> > >
> > >     /* (2) */
> > >     if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
> > >         goto done;
> > >
> > > At this point, it seems safe to start the actual read operation. Once
> > > that completes, end_bbio_meta_read() does
> > >
> > >     /* (3) */
> > >     set_extent_buffer_uptodate(eb);
> > >
> > >     /* (4) */
> > >     clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> > >
> > > Normally, this is enough to ensure only one read happens, and all other
> > > callers wait for it to finish before returning.  Unfortunately, there is
> > > a racey interleaving:
> > >
> > >     Thread A | Thread B | Thread C
> > >     ---------+----------+---------
> > >        (1)   |          |
> > >              |    (1)   |
> > >        (2)   |          |
> > >        (3)   |          |
> > >        (4)   |          |
> > >              |    (2)   |
> > >              |          |    (1)
> > >
> > > When this happens, thread B kicks of an unnecessary read. Worse, thread
> > > C will see UPTODATE set and return immediately, while the read from
> > > thread B is still in progress.  This race could result in tree-checker
> > > errors like this as the extent buffer is concurrently modified:
> > >
> > >     BTRFS critical (device dm-0): corrupted node, root=256
> > >     block=8550954455682405139 owner mismatch, have 11858205567642294356
> > >     expect [256, 18446744073709551360]
> > >
> > > Fix it by testing UPTODATE again after setting the READING bit, and if
> > > it's been set, skip the unnecessary read.
> > >
> > > Fixes: d7172f52e993 ("btrfs: use per-buffer locking for extent_buffer reading")
> > > Link: https://lore.kernel.org/linux-btrfs/CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com/
> > > Link: https://lore.kernel.org/linux-btrfs/f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com/
> > > Link: https://lore.kernel.org/linux-btrfs/c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com/
> > > Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
> >
> > Thank you very much for taking the time to debug the issue and for the
> > fix. It is a rare occurrence that a tough bug is followed by a fix from
> > the same person (outside of the developer group) and is certainly
> > appreciated.
> 
> Thank you!
> 
> Sorry to nitpick, but the paragraph you added to the commit message
> [1] has a typo:
> 
> > There are reports from tree-checker that detects corrupted nodes,
> > without any obvious pattern so possibly an overwrite in memory.
> > After some debugging it turns out there's a race when reading an extent
> > buffer the uptodate status is can be missed.
> 
> s/is can/can/

I will fix that, thanks.


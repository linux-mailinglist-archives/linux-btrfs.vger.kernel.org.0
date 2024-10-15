Return-Path: <linux-btrfs+bounces-8922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410999DAB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 02:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A828305E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC590BA4B;
	Tue, 15 Oct 2024 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HDWsp0Yv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uVk1LLw4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HDWsp0Yv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uVk1LLw4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AE33C5
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952319; cv=none; b=o82I/yDwGR1fr6X2YFIrrhEthsvN1HxQKg2v8cWECIbydh3vd0oUvL34JqmqMisBKKQwARKahAA9EMCPuUe+jdPCSzbjlEl/HwYYt7/TlQR4mzmYY0bnREQaivy2E/l4ASWbiH8iA0r8zDAzhr5lz932L+gudmAuhozuIJkJars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952319; c=relaxed/simple;
	bh=uAUJmYIzHV2KURPKwaTHIQb5Lfk1xKiBvE6ZCVE4j+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU6QHyQO+ZGB95ahuG3u+p2zG5i5YaTShXDLBx072HO2xKOz2FZ55sdam++pzO2JvWxxZa+G+GvdLAp4s5p7EVfY9+ltWuSpjS3JFZFWp+7PVxcstKZZ74vcsQ3PslAhdgbka1hl3FLhvvf57VJ0qbik7zzUUsMlQgyXZQvvXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HDWsp0Yv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uVk1LLw4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HDWsp0Yv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uVk1LLw4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61B731FE06;
	Tue, 15 Oct 2024 00:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728952314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE9bzDmMCiD4j0ssCcmy5JvWhn/FeeLHIQYfLk3Q14g=;
	b=HDWsp0Yv9QomuKiEKxGm21Ae8iYq+I02rj7V3Lmfpl4hROThbSVM4zc9ZjHzemqbTusQUq
	G/xDMt3/bGjwSka4HCENx01r1GVqAt8y86/Y4x3UF7LzbyjQmUhQ8Cm9PXad5/NmR4MXxX
	8ntV43Dg7B+pmadqO50++Be7RvT/R6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728952314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE9bzDmMCiD4j0ssCcmy5JvWhn/FeeLHIQYfLk3Q14g=;
	b=uVk1LLw4m/GGWv5Inek/8jaWCQozlWUTrkJ5PfhOVFo5uq0dcm9iKT8NJiH0FzqiSlwF5b
	AgpN8vHB1UJg75Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HDWsp0Yv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uVk1LLw4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728952314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE9bzDmMCiD4j0ssCcmy5JvWhn/FeeLHIQYfLk3Q14g=;
	b=HDWsp0Yv9QomuKiEKxGm21Ae8iYq+I02rj7V3Lmfpl4hROThbSVM4zc9ZjHzemqbTusQUq
	G/xDMt3/bGjwSka4HCENx01r1GVqAt8y86/Y4x3UF7LzbyjQmUhQ8Cm9PXad5/NmR4MXxX
	8ntV43Dg7B+pmadqO50++Be7RvT/R6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728952314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE9bzDmMCiD4j0ssCcmy5JvWhn/FeeLHIQYfLk3Q14g=;
	b=uVk1LLw4m/GGWv5Inek/8jaWCQozlWUTrkJ5PfhOVFo5uq0dcm9iKT8NJiH0FzqiSlwF5b
	AgpN8vHB1UJg75Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36E45136C7;
	Tue, 15 Oct 2024 00:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eQndDPq3DWcSEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Oct 2024 00:31:54 +0000
Date: Tue, 15 Oct 2024 02:31:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
Message-ID: <20241015003148.GG1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
 <20241014141622.GB1609@twin.jikos.cz>
 <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 61B731FE06
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
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmx.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Oct 15, 2024 at 07:25:20AM +1030, Qu Wenruo wrote:
> 在 2024/10/15 00:46, David Sterba 写道:
> > On Mon, Oct 14, 2024 at 03:06:31PM +1030, Qu Wenruo wrote:
> >> __filemap_get_folio() provides the flag FGP_STABLE to wait for
> >> writeback.
> >>
> >> There are two call sites doing __filemap_get_folio() then
> >> folio_wait_writeback():
> >>
> >> - btrfs_truncate_block()
> >> - defrag_prepare_one_folio()
> >>
> >> We can directly utilize that flag instead of manually calling
> >> folio_wait_writeback().
> >
> > We can do that but I'm missing a justification for that. The explicit
> > writeback calls are done at a different points than what FGP_STABLE
> > does. So what's the difference?
> >
> 
> TL;DR, it's not safe to read folio before waiting for writeback in theory.
> 
> There is a possible race, mostly related to my previous attempt of
> subpage partial uptodate support:
> 
>               Thread A          |           Thread B
> -------------------------------+-----------------------------
> extent_writepage_io()          |
> |- submit_one_sector()         |
>    |- folio_set_writeback()     |
>       The folio is partial dirty|
>       and uninvolved sectors are|
>       not uptodate              |
>                                 | btrfs_truncate_block()
>                                 | |- btrfs_do_readpage()
>                                 |   |- submit_one_folio
>                                 |      This will read all sectors
>                                 |      from disk, but that writeback
>                                 |      sector is not yet finished
> 
> In this case, we can read out garbage from disk, since the write is not
> yet finished.
> 
> This is not yet possible, because we always read out the whole page so
> in that case thread B won't trigger a read.
> 
> But this already shows the way we wait for writeback is not safe.
> And that's why no other filesystems manually wait for writeback after
> reading the folio.
> 
> Thus I think doing FGP_STABLE is way more safer, and that's why all
> other fses are doing this way instead.

I'm not disputing we need it and I may be missing something, what I
noticed in the patch is maybe a generic pattern, structure read at some
time and then synced/written, but there could be some change in
bettween.  One example is one you show (theoretically or not).

The writeback is a kind of synchronization point, but also in parallel
with the data/metadata in page cache. If the state, regarding writeback,
is not safe and we can either get old data or could get partially synced
data (ie. ok in page cache but not regarding writeback) it is a
problematic pattern.

You found two cases, truncate and defrag. Both are different I think,
truncate comes from normal MM operations, while defrag is triggered by
an ioctl (still trying to be in sync with MM).

I'm not sure we can copy what other filesystems do, even if it's just on
the basic principle of COW vs update in place + journaling. We copy the
and do the next update and don't have to care about previous state, so
even a split between read and writeback does no harm.


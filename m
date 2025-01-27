Return-Path: <linux-btrfs+bounces-11089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C34A1DD45
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 21:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E76188632E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53893193402;
	Mon, 27 Jan 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J6bpirUK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XB9CVRT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J6bpirUK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XB9CVRT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA1AB64A
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009043; cv=none; b=ozFS1aCbIyvIXsK6u7wE777mXFuej5BKm1xpja9LtmgsAgtxG7tCNdXcL1t4Pxf5llxhPitvTpLCKdd0dvYsf63uoYN8iXEuPr/gzuEraN3Og1009n1a+D+8u2Yh5ZnhbZkcoFxsrDq8unI6veAAo39Jdl1XC8UCodtvTUBYLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009043; c=relaxed/simple;
	bh=TvkIdbtlQgk1MGIYzxTJ4t7VNHyACcoYnfD4qJFvg5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhdrGqDYuCPrmQGTdp1fZIVJe0sMW888eC5C2pxc7S2BUXtBivRnB2+PoypeVv/GHLhqSOAmSlePbmnJ+i3rKInHAkSykhfcS16sTPACfMDRKv7tcfoKE3mmwuLdxqUYyZP/f7CVHhSPp/6Ryo+UVXEb1Lm/NUBX4LB4eBhvNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J6bpirUK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XB9CVRT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J6bpirUK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XB9CVRT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01AA11F383;
	Mon, 27 Jan 2025 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738009039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7lysCpCY3+3Qe7dU+egToxSldHovM465bg1/PIHVEQ=;
	b=J6bpirUKA43mrOB3LYIYWvRw3WqJrlmvskkUiVS9v7ZP/nKrlaKle1rZP09kFObVJKpQmA
	013kGFbbDKy0DWcaMglMAKE3RtwROuroNPKycgs8d48OcDPu0KjvtmNXcT/klZ9ZFh5G/2
	Zw3HLrte1tnw1UjIs74/cj75nTbTD6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738009039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7lysCpCY3+3Qe7dU+egToxSldHovM465bg1/PIHVEQ=;
	b=0XB9CVRTH4i8ebTjvkst5WCcvAyMYlxn2ld/MJttMuxidHaruzvWtpcazc+QzIicUZ3rBt
	4LCf94HROQM+wpDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J6bpirUK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0XB9CVRT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738009039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7lysCpCY3+3Qe7dU+egToxSldHovM465bg1/PIHVEQ=;
	b=J6bpirUKA43mrOB3LYIYWvRw3WqJrlmvskkUiVS9v7ZP/nKrlaKle1rZP09kFObVJKpQmA
	013kGFbbDKy0DWcaMglMAKE3RtwROuroNPKycgs8d48OcDPu0KjvtmNXcT/klZ9ZFh5G/2
	Zw3HLrte1tnw1UjIs74/cj75nTbTD6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738009039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7lysCpCY3+3Qe7dU+egToxSldHovM465bg1/PIHVEQ=;
	b=0XB9CVRTH4i8ebTjvkst5WCcvAyMYlxn2ld/MJttMuxidHaruzvWtpcazc+QzIicUZ3rBt
	4LCf94HROQM+wpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D26FD137C0;
	Mon, 27 Jan 2025 20:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VtreMs7pl2f2egAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 27 Jan 2025 20:17:18 +0000
Date: Mon, 27 Jan 2025 21:17:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Daniel Vacek <neelx@suse.com>,
	"dsterba@suse.cz" <dsterba@suse.cz>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250127201717.GT5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz>
 <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 01AA11F383
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Jan 27, 2025 at 05:42:28PM +0000, Mark Harmstone wrote:
> On 24/1/25 12:25, Filipe Manana wrote:
> >>
> >> It will only retry precisely when more concurrent requests race here.
> >> And thanks to cmpxchg only one of them wins and increments. The others
> >> retry in another iteration of the loop.
> >>
> >> I think this way no lock is needed and the previous behavior is preserved.
> > 
> > That looks fine to me. But under heavy concurrency, there's the
> > potential to loop too much, so I would at least add a cond_resched()
> > call before doing the goto.
> > With the mutex there's the advantage of not looping and wasting CPU if
> > such high concurrency happens, tasks will be blocked and yield the cpu
> > for other tasks.
> 
> And then we have the problem of the function potentially sleeping, which 
> was one of the things I'm trying to avoid.
> 
> I still think an atomic is the correct choice here:
> 
> * Skipped integers aren't a problem, as there's no reliance on the 
> numbers being contiguous.
> * The overflow check is wasted cycles, and should never have been there 
> in the first place.

We do many checks that almost never happen but declare the range of the
expected values and can catch eventual bugs caused by the "impossible"
reasons like memory bitflips or consequences of other errors that only
show up due to such checks. I would not cosider one condition wasted
cycles in this case, unless we really are optimizing a hot path and
counting the cycles.

> Even if we were to grab a new integer a billion 
> times a second, it would take 584 years to wrap around.

Good to know, but I would not use that as an argument.  This may hold if
you predict based on contemporary hardware. New technologies can bring
an order of magnitude improvement, eg. like NVMe brought compared to SSD
technology.


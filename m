Return-Path: <linux-btrfs+bounces-10778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC049A04375
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9803A37EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF901F1319;
	Tue,  7 Jan 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1zRcQpN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gdj+hF96";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1zRcQpN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gdj+hF96"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0425A1EE006
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Jan 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261770; cv=none; b=gBoGtQzCjycBSUN8brHOIEgN01R8B8rZETtptTrEKJiVG6Wf/oKTw9qcHXF1Sq5PyZNW60G0t0ZqnI7cabHIMr+Uc4JViM3gZ9PuJfoZMswp+kX9umb6iV6Oua231ErCQY5jDNuRSxbt11ToCXOjtw5QkW64oxcewPoHjjRv4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261770; c=relaxed/simple;
	bh=EFrEd+fcx1REKxY/j+Q8z+Fmmg0yamy22O4sf+T+Iu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk7qTha3gF0i/g6RGRaihvLyby7B5ACvo6/nEORkvrTwauwU0n4FM8xqbv1sNaB90Z8TgjR2Wz8zhiClNtQnqPWbwn/jPIO2jZF0peSWXJxwGaZAxneMq4Xe7IztMkQkBKge46ec54awFCZ7fYZyu1L3Nxlj8hdfUSC+/fwFb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1zRcQpN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gdj+hF96; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1zRcQpN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gdj+hF96; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD1C121133;
	Tue,  7 Jan 2025 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736261765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25owiHqwXBA+2ZDSwuI7HOOVpqYirBkKjIodqClOzr8=;
	b=F1zRcQpN7JUZdUg1jlxJdZWjEAcNq1gOf0nggJda5pGMOi+OpJJCDONOHmSOB6shmS7Ymb
	MyYfNISCh+KE0mTno+y5+VlHFwRgJfnbJ+t2OXJ7PgbmQGUma1+eTqAgCKkIDoTH8MxR3o
	Dky23R1vnT2chmyxaDRp7xFWK3EUntU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736261765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25owiHqwXBA+2ZDSwuI7HOOVpqYirBkKjIodqClOzr8=;
	b=gdj+hF962Nl68RwbIO7nczs7e3rtxDklLVW1PqN0mKUOco8dCc0okGo+ynYLDrG+0J67I/
	kgPs3KFQwaBbLPAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F1zRcQpN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gdj+hF96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736261765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25owiHqwXBA+2ZDSwuI7HOOVpqYirBkKjIodqClOzr8=;
	b=F1zRcQpN7JUZdUg1jlxJdZWjEAcNq1gOf0nggJda5pGMOi+OpJJCDONOHmSOB6shmS7Ymb
	MyYfNISCh+KE0mTno+y5+VlHFwRgJfnbJ+t2OXJ7PgbmQGUma1+eTqAgCKkIDoTH8MxR3o
	Dky23R1vnT2chmyxaDRp7xFWK3EUntU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736261765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25owiHqwXBA+2ZDSwuI7HOOVpqYirBkKjIodqClOzr8=;
	b=gdj+hF962Nl68RwbIO7nczs7e3rtxDklLVW1PqN0mKUOco8dCc0okGo+ynYLDrG+0J67I/
	kgPs3KFQwaBbLPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB8AF13A9E;
	Tue,  7 Jan 2025 14:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +2uNLYVAfWdAQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 07 Jan 2025 14:56:05 +0000
Date: Tue, 7 Jan 2025 15:56:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
	Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
	waxhead@dirtcellar.net
Subject: Re: [PATCH v5 00/10] raid1 balancing methods
Message-ID: <20250107145604.GE31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1735748715.git.anand.jain@oracle.com>
 <20250102135808.GP31418@twin.jikos.cz>
 <42d63c80-61a9-4c53-b9c5-be8025a65b97@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d63c80-61a9-4c53-b9c5-be8025a65b97@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: DD1C121133
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Jan 02, 2025 at 10:29:13PM +0530, Anand Jain wrote:
> On 2/1/25 19:28, David Sterba wrote:
> > On Thu, Jan 02, 2025 at 02:06:29AM +0800, Anand Jain wrote:
> >> v5:
> >> Fixes based on review comments:
> >>    . Rewrite `btrfs_read_policy_to_enum()` using `sysfs_match_string()`
> >>      and `strncpy()`.
> >>    . Rewrite the round-robin method based on read counts.
> >>    . Fix the smatch indentation warning.
> >>   - Change the default minimum contiguous device read size for round-robin
> >>     from 256K to 192K, as the latter performs slightly better.
> > 
> > This depends on the device and load and the read pattern so any number
> > is fine, I'd rather stick to something that looks sensible if the
> > difference is slight. Changing that later based on extensive benchmarks.
> > 
> 
> The optimization should target the generic read-write workload, where I
> find 256k or more reasonable, though I am unable to demonstrate this at
> the moment. It's a good idea to gather more feedback. I've sent a fix
> with SZ_256K and for a missed bug, hoping both are folded into their
> patches. Thx.

As discussed, the min contig size will be tuned. Per current testing the
balancing seems to work so we can keep it as is for now.

> >>   - Introduce a framework to track filesystem read counts. (New patch)
> >>   - Reran defrag performance numbers
> >>        $ xfs_io -f -d -c 'pwrite -S 0xab 0 1000000000' /btrfs/P6B
> >>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
> >>
> >> |         | Time  | Read I/O Count  | gain  |
> >> |         | Real  | devid1 | devid2 | w-PID |
> >> |---------|-------|--------|--------|-------|
> >> | pid     | 11.14s| 3808   | 0      |  -    |
> >> | rotation|       |        |        |       |
> >> |   196608|  6.54s| 2532   | 1276   | 41.29%|
> >> |   262144|  8.42s| 1907   | 1901   | 24.41%|
> >> | devid:1 | 10.95s| 3807   | 0      | 1.70% |
> >>
> >> v4:
> > 
> > As we're at rc5 we need to get this series to for-next soon, before rc6
> > is released this Sunday. I'll do one review pass and then move the
> > patches to for-next. I'm not convinced we should do the module parameter
> > but as this is to ease testing let's do it.

The testing delayed it but now the series is in for-next, with some
cleanups and fixups I did. The remaining thing is to accept suffixed
sizes as sysfs (ie. use memparse), I did not implement it as the feature
is usable without that and we need to get it merged now.


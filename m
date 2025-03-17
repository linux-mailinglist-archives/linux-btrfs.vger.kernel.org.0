Return-Path: <linux-btrfs+bounces-12343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4948A65DE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 20:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7DE3B7CCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFE81EA7E2;
	Mon, 17 Mar 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MnqDRmkJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMaDgJbT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L3vJmwuW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kVVeHEcx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707515573A
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239604; cv=none; b=t0enxDvboyfmWeQxURSPvNUc1zaLeFc7GsMeY2vpl6FZ1pnh6dhi0o4I7MRCJrBRAWQcnCjUjAcno+FYuDlbDeU4I65NkATm9NujlhgGFoXzKs6R7bHGWrEV/RqnuStdPiDBkNUSH7A57U1d3qk1aWVQHWW/Y+XRrsraCMd8RMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239604; c=relaxed/simple;
	bh=tpv8UIeCbShk+QLKA1DYUc5mRKeANCP8ckHK/0VgXsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drvul3tZ9hqpWlFGbY7ClOAwNbOM0Dx1hMALHeWgI3ZGOP0uftmjhzNS2oxw9xMDMknZh+NKgURw8CPd5diETO8orkEMdA+QsIpwqDjCRSfb97vnzDsHhOhEV95oXYp6zTNfrLNrNQDK+FErEIvsEJ9lsohTuvMokYJgHkyche8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MnqDRmkJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMaDgJbT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L3vJmwuW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kVVeHEcx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B65AE21B46;
	Mon, 17 Mar 2025 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742239601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws8nI3M8yfYzmDuAw0gtkM2kduV7WGmYve45iQIEyYc=;
	b=MnqDRmkJHVPcXzXx3pWLwQVEkLsIoVGdmn0vkMbZHc9AHQZgmoQY1QrKXyXXMT7FYkdzD6
	+jsXl1KU9LXazd85nZfN77YJzYum/KUuEZ1Na66tUQWKHc59U+aNZGtmWsv8Twh1Y1A3Jk
	rSOmUi1tqB8NMGztClyB4247Sb8NuyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742239601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws8nI3M8yfYzmDuAw0gtkM2kduV7WGmYve45iQIEyYc=;
	b=sMaDgJbTYKykW8r3J9AvF5yQZalP0dRePoH7pW9o3ABI7wAi5LbehuRxMfaragMRjK+R9q
	LdpKA1nXYbDGQeBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742239600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws8nI3M8yfYzmDuAw0gtkM2kduV7WGmYve45iQIEyYc=;
	b=L3vJmwuWySc6QjqI/OZfz4v0mpvBvZARXSHIU6nW0AVn289ljfSm5RCGg+5BHS7oKXTTxC
	eKNDCDncIFYMx+OPTFidQe9vd5cZM4w+26AVpeqIwXXBdKJaCuZHQ85T2WrsnfqzvaKG+T
	3wVazszqqc6CBh3UwWRIuSorpr+rOrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742239600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws8nI3M8yfYzmDuAw0gtkM2kduV7WGmYve45iQIEyYc=;
	b=kVVeHEcx1W6AMKdsQGtBR+ossSGNkioqFDoxcyAF1FvlQRFgrCcut3b/akrJTiDZoxBG5p
	gO4TcU2lCwxv4RDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92F57139D2;
	Mon, 17 Mar 2025 19:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZQSmI3B32GdLSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Mar 2025 19:26:40 +0000
Date: Mon, 17 Mar 2025 20:26:39 +0100
From: David Sterba <dsterba@suse.cz>
To: David Laight <david.laight.linux@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>, Li Zetao <lizetao1@huawei.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] btrfs: fix signedness issue in min()
Message-ID: <20250317192638.GA32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250314155447.124842-1-arnd@kernel.org>
 <20250317141637.5ee242ad@pumpkin>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317141637.5ee242ad@pumpkin>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Mon, Mar 17, 2025 at 02:16:37PM +0000, David Laight wrote:
> On Fri, 14 Mar 2025 16:54:41 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Comparing a u64 to an loff_t causes a warning in min()
> > 
> > fs/btrfs/extent_io.c: In function 'extent_write_locked_range':
> > include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_588' declared with attribute error: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
> > fs/btrfs/extent_io.c:2472:27: note: in expansion of macro 'min'
> >  2472 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
> >       |                           ^~~
> > 
> > Use min_t() instead.
> 
> It would be slightly better to use min_unsigned() since, regardless of the types
> involved, it can't discard significant bits.
> 
> OTOH the real problem here is that both folio_pos() and folio_size() return signed types.

folio_size() returns size_t:

static inline size_t folio_size(const struct folio *folio)
{
	return PAGE_SIZE << folio_order(folio);
}

Otherwise the min_t with force u64 is ok and lots of min() use (in
btrfs) was converted to the typed variant in case the types don't match.


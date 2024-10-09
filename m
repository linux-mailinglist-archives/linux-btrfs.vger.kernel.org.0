Return-Path: <linux-btrfs+bounces-8732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F4997051
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CA61C229A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBF1F4FC9;
	Wed,  9 Oct 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XooOIQ2F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eq3LJeDc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XooOIQ2F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eq3LJeDc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322B1F4FC2;
	Wed,  9 Oct 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488230; cv=none; b=SRYYsySDG4rbuLZ5JPj7xNZZ88BmA4mtr3F+QyLVlErgDVsXC27lNaw1NjuIcchePedwu2STuaOJWJWTC15hlA7ay99XtTcb4jaaVwDuD7lLbIuPbpD14xktXgQ7opLl4LJRRe8eQ7yR6P5SCq/2u2aSrDDyLbDt1TKu2arGx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488230; c=relaxed/simple;
	bh=yrWK9guy4QSl6qtQfqv509X0npMUw4ahN/8mznSDu3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+xpjf9TPtnZQn4QXk2HOeZnzY1NzprYHZO/qEqI24tIMnF+5+I8khiQo3lFC5PqIEpkyrm02ZXhXFaPCfoUQl2EjhPIalkkmq+jGH+QZjriMnxjYPP/OhEAboYVmqqzqbpoWHBK79MHbAVJFKeuQlcvP8APPlFLj8qIQ9l6Muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XooOIQ2F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eq3LJeDc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XooOIQ2F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eq3LJeDc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 328ED1F896;
	Wed,  9 Oct 2024 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728488205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNjL0RSe+pEK01YoJ4LcI5i4jyH5jOdUOpsxh2f8Gbg=;
	b=XooOIQ2FTDzKMFmK04SgigiPIsBbMhZyOs0u4xZ//UFBYiD530ZmZGd87NOhyjqaFn3MaK
	f8bQeLiDXy02satFUGVLpi297p1cGN2gqZBIONIR8vwwGY/zWDGfEztuv9zREq6KRuH1rc
	UFoJjh/B9ziBuMaNfTwPomaJjSCajQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728488205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNjL0RSe+pEK01YoJ4LcI5i4jyH5jOdUOpsxh2f8Gbg=;
	b=Eq3LJeDcLQ5edAAhku6R8PeobEF4P8P/b7qZAm889pwHEQeHvX5tnx6+B44A7tBJpxJwXB
	CX79zOcInd2504BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XooOIQ2F;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Eq3LJeDc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728488205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNjL0RSe+pEK01YoJ4LcI5i4jyH5jOdUOpsxh2f8Gbg=;
	b=XooOIQ2FTDzKMFmK04SgigiPIsBbMhZyOs0u4xZ//UFBYiD530ZmZGd87NOhyjqaFn3MaK
	f8bQeLiDXy02satFUGVLpi297p1cGN2gqZBIONIR8vwwGY/zWDGfEztuv9zREq6KRuH1rc
	UFoJjh/B9ziBuMaNfTwPomaJjSCajQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728488205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNjL0RSe+pEK01YoJ4LcI5i4jyH5jOdUOpsxh2f8Gbg=;
	b=Eq3LJeDcLQ5edAAhku6R8PeobEF4P8P/b7qZAm889pwHEQeHvX5tnx6+B44A7tBJpxJwXB
	CX79zOcInd2504BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B07813A58;
	Wed,  9 Oct 2024 15:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ciBAg2jBmf5WgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 09 Oct 2024 15:36:45 +0000
Date: Wed, 9 Oct 2024 17:36:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 04/28] range: Add range_overlaps()
Message-ID: <20241009153641.GK1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
 <20241008161032.GB1609@twin.jikos.cz>
 <ZwaW9gXuh_JzqRfh@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwaW9gXuh_JzqRfh@black.fi.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 328ED1F896
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Oct 09, 2024 at 05:45:10PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 08, 2024 at 06:10:32PM +0200, David Sterba wrote:
> > On Mon, Oct 07, 2024 at 06:16:10PM -0500, Ira Weiny wrote:
> 
> ...
> 
> > > +static inline bool range_overlaps(struct range *r1, struct range *r2)
> > 
> > I've noticed only now, you can constify the arguments, but this applise
> > to other range_* functions so that can be done later in one go.
> 
> Frankly you may add the same to each new API being added to the file and
> the "one go" will never happen.

Yeah, but it's a minor issue for a 28 patchset, I don't know if there
are some other major things still to do so that a v5 is expected.

If anybody is interested, reviewing APIs and interfaces with focus on
some data structure and const is relatively easy, compile test is
typically enough. The hard part is to find the missing ones. There's no
compiler aid thad I'd know of (-Wsuggest-attribute=const is not for
parameters), so it's been reading a file top-down for me.

> So, I support your first part with
> constifying, but I think it would be rather done now to start that "one
> go" to happen.

Agreed, one patch on top is probably the least intrusive way.


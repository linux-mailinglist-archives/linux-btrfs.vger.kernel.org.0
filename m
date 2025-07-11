Return-Path: <linux-btrfs+bounces-15471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD3CB02248
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 19:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0400A4A2E5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED42EF667;
	Fri, 11 Jul 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WhZ5OGDw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BtDIjzq6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WhZ5OGDw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BtDIjzq6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD16ADD
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253343; cv=none; b=KhMRU/nuahQiGAFMKLLpe8HIROsJi2AOMvUdkpJ3BjPSoi09P6KQ2fDIhqYJZcR7EHr6YfZJ1YECM5vfsMwm8AieIaXLMicffX8d7XkyYJzsfMM4833iIwPHanoXIKyPK96FviVtQcU8RDL9Q39DMyS2x5QpWUbVAkNSIw+jlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253343; c=relaxed/simple;
	bh=sfVvEJYO2etFKYY/EDRGGjN5YnTQQz+OgJcAa/gNkw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcAX+zPRydlW88WLH7Bx1bujE+hF+bl3OrMCBwB4hCapRkZeKMU14hIJQYFQ7VvC6xZWxjx75lBmSgR/WV0O+xwbZ6/EYR9QLHJIfWKYAdRaszWxwMjNGPhozSzqFqwJQX/7/1AcjCaPnQqF17yMvU8n3e+WpKnIgenQZhjXOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WhZ5OGDw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BtDIjzq6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WhZ5OGDw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BtDIjzq6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B81E41F747;
	Fri, 11 Jul 2025 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752253339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iY4sXGB2+eKd6NHpwCEbJWu4pfPj6ufMnMtGfWmWIeE=;
	b=WhZ5OGDwvFpEXPTH/v2ASmbKr5mnLTpvi3v/L/hacDn6ccllWrW0WvFnA3VIBqMzTjVSNu
	WZjhIiIUrkOKcF9mE6a+o4U8BojUEcLQLZ7UaZiDCKCdqiWpfIfATjRC2Bnpyu1LsvwY67
	2hz+6QDs5oU0L2SSJ6Sv+GBJY9PXXps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752253339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iY4sXGB2+eKd6NHpwCEbJWu4pfPj6ufMnMtGfWmWIeE=;
	b=BtDIjzq6lYKXmLQmtMU0K0lleeQlXbNOI0YNfYaAJBp3vmdESUaV5RBcAfWdUna3NMkJTf
	I71XZ5QJEIfnDNBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752253339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iY4sXGB2+eKd6NHpwCEbJWu4pfPj6ufMnMtGfWmWIeE=;
	b=WhZ5OGDwvFpEXPTH/v2ASmbKr5mnLTpvi3v/L/hacDn6ccllWrW0WvFnA3VIBqMzTjVSNu
	WZjhIiIUrkOKcF9mE6a+o4U8BojUEcLQLZ7UaZiDCKCdqiWpfIfATjRC2Bnpyu1LsvwY67
	2hz+6QDs5oU0L2SSJ6Sv+GBJY9PXXps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752253339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iY4sXGB2+eKd6NHpwCEbJWu4pfPj6ufMnMtGfWmWIeE=;
	b=BtDIjzq6lYKXmLQmtMU0K0lleeQlXbNOI0YNfYaAJBp3vmdESUaV5RBcAfWdUna3NMkJTf
	I71XZ5QJEIfnDNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C175138A5;
	Fri, 11 Jul 2025 17:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ViUzAJtDcWh9AwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Jul 2025 17:02:19 +0000
Date: Fri, 11 Jul 2025 19:02:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v7] btrfs: try to search for data csums in commit root
Message-ID: <20250711170212.GD22472@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <112a66d49285e38d7a567aa780d9545baafd3deb.1752101883.git.boris@bur.io>
 <98154adb-057a-44d7-97a4-9bfd669b9454@suse.com>
 <20250710152606.GB588947@zen.localdomain>
 <1dbd43cb-7e1f-455c-8de8-4b91826b800e@gmx.com>
 <20250711100246.GB22472@twin.jikos.cz>
 <20250711162149.GA1448937@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711162149.GA1448937@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmx.com,suse.com,vger.kernel.org,fb.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Jul 11, 2025 at 09:21:49AM -0700, Boris Burkov wrote:
> On Fri, Jul 11, 2025 at 12:02:46PM +0200, David Sterba wrote:
> > On Fri, Jul 11, 2025 at 06:57:06AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/7/11 00:56, Boris Burkov 写道:
> > > > On Thu, Jul 10, 2025 at 04:45:35PM +0930, Qu Wenruo wrote:
> > > [...]
> > > >> If that's the case, I'd prefer to have a dedicated flag for it.
> > > >>
> > > >> In fact there is a 7 bytes hole inside btrfs_bio, and we don't need to
> > > >> bother the extra helpers for this.
> > > > 
> > > > I'm happy either way. Sterba said he preferred to not add fields to the
> > > > btrfs_bio on v2:
> > > > https://lore.kernel.org/linux-btrfs/20241011174603.GA1609@twin.jikos.cz/
> > > > 
> > > > But at that point I didn't even try to find a neat spot in the struct to
> > > > slot it in, and just dumped a bool on the end of the struct.
> > > > 
> > > > For my learning, how are you finding the 7 byte hole? Do you have a tool
> > > > for dumping a particular compiled version of the struct you like? I
> > > > started trying to count up the sizes of stuff in struct btrfs_bio and
> > > > quickly lost steam halfway through the union with nested structs.
> > > 
> > > The tried and true pa_hole tool.
> > 
> > It's 'pahole' from https://github.com/acmel/dwarves
> 
> Would you like me to redo the flag packed carefully in btrfs_bio or leave it
> like this in the bio.bi_flags?

At the time of posting v2 there was no hole, we got status added in
d48e1dea3931de6 ("btrfs: fix error propagation of split bios") so it
does not need to be in the flags anymore.


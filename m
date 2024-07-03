Return-Path: <linux-btrfs+bounces-6171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB8C926256
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE401F23E68
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C49717C23E;
	Wed,  3 Jul 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6GrTVU1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LaN2UJdK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6GrTVU1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LaN2UJdK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE817B4F8
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014829; cv=none; b=hFuMqfL5+ckbtZjTFOovaUxpL8JUayeKd72awKGzw4TT6vbc7wQtQ4DAQtVe44bexTJg9x8FAaIwX4Ce7k0mdXaRTWidO4iS0lsW7SKXj6zFFi8w5zyjrOn9LqlOsBiGRKQm0aglk/ORMTvB1Oo2of+uAV9QJ26ouCEvdZwlJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014829; c=relaxed/simple;
	bh=io39C0Glrn+W7t6Mpp0MUI3XHl+s5gMbsJR1aqW4pAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpV7CdmjfgHUpYpD+bejLVx4LXGSVoTkWyoDnB1Fqcofjm/zSpPvXd4GKt8a8OOA3stdk8pD3m+VsiAeaG0ptfo2XeI7dvgidPGcT6YiCsmLc7cddzV22qTKL54ByXoTU8u3T6WD07v3TiWQIhxKWyZNhhQdYpVRVP4pkbjXHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6GrTVU1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LaN2UJdK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6GrTVU1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LaN2UJdK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F8621F452;
	Wed,  3 Jul 2024 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720014825;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrZXjWhojYVNXfFn0K4O/P+mlW8GDXmPNzNGaBxORKU=;
	b=t6GrTVU1UR1lehDrpxPctWLho1O1WoZMdXJRAuWr4h3WrdlYuuGbQHnKAjfYXtyy6Am3za
	6CyuYftercPOankjPU4wwXfvAFYpmhM+ywSkBfX2kXA6LHayo7zyrhvUMY+L54G7yHw0n/
	O1rvghECmTrYbp8EPTRrMW65I1Qf6E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720014825;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrZXjWhojYVNXfFn0K4O/P+mlW8GDXmPNzNGaBxORKU=;
	b=LaN2UJdKCAsKDDWFPp6tzw+ssiAeP+xFW8J6QGTfntL4SvdiGygPdq9y1+Zb9ZwwhPCvfB
	cPBCy9CuwHMDRaBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720014825;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrZXjWhojYVNXfFn0K4O/P+mlW8GDXmPNzNGaBxORKU=;
	b=t6GrTVU1UR1lehDrpxPctWLho1O1WoZMdXJRAuWr4h3WrdlYuuGbQHnKAjfYXtyy6Am3za
	6CyuYftercPOankjPU4wwXfvAFYpmhM+ywSkBfX2kXA6LHayo7zyrhvUMY+L54G7yHw0n/
	O1rvghECmTrYbp8EPTRrMW65I1Qf6E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720014825;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrZXjWhojYVNXfFn0K4O/P+mlW8GDXmPNzNGaBxORKU=;
	b=LaN2UJdKCAsKDDWFPp6tzw+ssiAeP+xFW8J6QGTfntL4SvdiGygPdq9y1+Zb9ZwwhPCvfB
	cPBCy9CuwHMDRaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE0113974;
	Wed,  3 Jul 2024 13:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n4LvFulXhWbeMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 03 Jul 2024 13:53:45 +0000
Date: Wed, 3 Jul 2024 15:53:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: prefer to allocate larger folio for metadata
Message-ID: <20240703135340.GP21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <96e9e2c1ac180a3b6c8c29a06c4a618c8d4dc2d9.1719734174.git.wqu@suse.com>
 <20240702161131.GH21023@twin.jikos.cz>
 <8a0251c7-b594-4992-bdeb-1064d04be3b4@gmx.com>
 <3bd15793-7a52-44ca-9e9f-e846563cb8ee@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bd15793-7a52-44ca-9e9f-e846563cb8ee@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Jul 03, 2024 at 02:03:14PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/3 07:49, Qu Wenruo 写道:
> >
> >
> > 在 2024/7/3 01:41, David Sterba 写道:
> >> On Sun, Jun 30, 2024 at 05:26:59PM +0930, Qu Wenruo wrote:
> >>> For btrfs metadata, the high order folios are only utilized when all the
> >>> following conditions are met:
> >>>
> >>> - The extent buffer start is aligned to nodesize
> >>>    This should be the common case for any btrfs in the last 5 years.
> >>>
> >>> - The nodesize is larger than page size
> >>>    Or there is no need to use larger folios at all.
> >>>
> >>> - MM layer can fulfill our folio allocation request
> >>>
> >>> - The larger folio must exactly cover the extent buffer
> >>>    No longer no smaller, must be an exact fit.
> >>>
> >>>    This is to make extent buffer accessors much easier.
> >>>    They only need to check the first slot in eb->folios[], to determine
> >>>    their access unit (need per-page handling or a large folio covering
> >>>    the whole eb).
> >>>
> >>> There is another small blockage, filemap APIs can not guarantee the
> >>> folio size.
> >>> For example, by default we go 16K nodesize on x86_64, meaning a larger
> >>> folio we expect would be with order 2 (size 16K).
> >>> We don't accept 2 order 1 (size 8K) folios, or we fall back to 4 order 0
> >>> (page sized) folios.
> >>>
> >>> So here we go a different workaround, allocate a order 2 folio first,
> >>> then attach them to the filemap of metadata.
> >>>
> >>> Thus here comes several results related to the attach attempt of eb
> >>> folios:
> >>>
> >>> 1) We can attach the pre-allocated eb folio to filemap
> >>>     This is the most simple and hot path, we just continue our work
> >>>     setting up the extent buffer.
> >>>
> >>> 2) There is an existing folio in the filemap
> >>>
> >>>     2.0) Subpage case
> >>>          We would reuse the folio no matter what, subpage is doing a
> >>>     different way handling folio->private (a bitmap other than a
> >>>     pointer to an existing eb).
> >>>
> >>>     2.1) There is already a live extent buffer attached to the filemap
> >>>          folio
> >>>     This should be more or less hot path, we grab the existing eb
> >>>     and free the current one.
> >>>
> >>>     2.2) No live eb.
> >>>     2.2.1) The filemap folio is larger than eb folio
> >>>            This is a better case, we can reuse the filemap folio, but
> >>>       we need to cleanup all the pre-allocated folios of the
> >>>       new eb before reusing.
> >>>       Later code should take the folio size change into
> >>>       consideration.
> >>>
> >>>     2.2.2) The filemap folio is the same size of eb folio
> >>>            We just free the current folio, and reuse the filemap one.
> >>>       No other special handling needed.
> >>>
> >>>     2.2.3) The filemap folio is smaller than eb folio
> >>>            This is the most tricky corner case, we can not easily
> >>> replace
> >>>       the folio in filemap using our eb folio.
> >>>
> >>>       Thus here we return -EAGAIN, to inform our caller to re-try
> >>>       with order 0 (of course with our larger folio freed).
> >>>
> >>> Otherwise all the needed infrastructure is already here, we only need to
> >>> try allocate larger folio as our first try in alloc_eb_folio_array().
> >>
> >> How do you want to proceed with that? I think we need more time to
> >> finish conversions to folios.
> >
> > That's for data folios.
> >
> > For metadata, the conversion is already finished for several releases.
> >
> >> There are still a few left and then we
> >> need time to test it (to catch bugs like where fixed the two recent
> >> __folio_put patches).
> >>
> >> Keeping this patch in for-next would give us mixed results or we could
> >> miss bugs that would not happen without large folios.
> >
> > I want it to be tested by the CI first.
> >
> > It passes locally, but I only have aarch64 4K page size system available
> > for now.
> >
> >> For a 6.11 devel
> >> cycle it's too late to merge, for 6.12 maybe but that would not give us
> >> enough time for testing so 6.13 sounds like the first target. I don't
> >> think we need to rush such change, debugging the recent extent buffer
> >> bugs shows that they're are pretty hard and hinder everything else.
> >>
> > Yes, that's totally true.
> >
> > Thus I hope more CI runs can be excerised on this change.
> > And it needs the MM change in the first place, and I'm pretty sure the
> > MM change would take some time to be merged anyway.
> 
> Another solution would be, hide it behind CONFIG_BTRFS_DEBUG, so that we
> can still push it for 6.12 release meanwhile keep our CI farms running
> for it.

If you need an MM patch we can't push it to for-next that gets included
in linux-next, the DEBUG option does not change that.


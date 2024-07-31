Return-Path: <linux-btrfs+bounces-6920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8449434D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBF51C220D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8413B1BD4F4;
	Wed, 31 Jul 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0BTdETQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fcNraPgv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0BTdETQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fcNraPgv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5A1BBBC8
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446010; cv=none; b=QYrIIr0BLXxDadT85GFDR+O3WlbgSw21P8+7u8mqWKuMDO0AijGYOlpvDoGesTseJwNtHEXkWBOmUPWnABxsiYEDvbNoJzkhRQQbBN1sbcwiDYZ/dO37o7KwRxGUdtiMhoLQ2vd+G6RJy4s5JdlYWA3DMsRCX1F7/CgDiL4MOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446010; c=relaxed/simple;
	bh=Jiqhbwd0PjfO77KIZeRs4Zw5bRvtFkj7GbmisQB+CGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMy1EyZkKJyIkxzmLWJMWTF9REIj6K4WeO1G/4g2OtPBnfuMgyU8pUrSrellsnd3XUEa9pt4Tl+0nx89xb3ntpbrjGpJBDQ7Oo0VUSgzUKDkPx9K1LmH7iLYB2bYNOTCBq2FU3Xsc5eREKnimfnGuk/TAEwwzoEFnyul43k14VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0BTdETQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fcNraPgv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0BTdETQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fcNraPgv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7DFA21A65;
	Wed, 31 Jul 2024 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722446006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgCkJyrl/5Q4LWKVaOBYvL2ddV/k1KvMTcm3jIZJ0JQ=;
	b=v0BTdETQEnwCskYSAu0CUXs1XnUny2Rm+4PMvDp48guI0gUfm2ZiBjcDRN+5h2hpgtl2Ox
	Kc5+MYoUP7UYoQtGgOFddsIJxbhTZMzwfuPXKpat7w8rH1ucha2yvcJ4mAUQLPMyrAwI0Z
	sa1X/RFCKjD120QQ/TpMMmR56KPP8Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722446006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgCkJyrl/5Q4LWKVaOBYvL2ddV/k1KvMTcm3jIZJ0JQ=;
	b=fcNraPgvsJCfor8+cd/lMfJprMrymGE3zNQgfAkHk1csgIsZKd0+NVcj5aH8RDnEd0ktob
	TtkzfZir0tsfW9BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722446006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgCkJyrl/5Q4LWKVaOBYvL2ddV/k1KvMTcm3jIZJ0JQ=;
	b=v0BTdETQEnwCskYSAu0CUXs1XnUny2Rm+4PMvDp48guI0gUfm2ZiBjcDRN+5h2hpgtl2Ox
	Kc5+MYoUP7UYoQtGgOFddsIJxbhTZMzwfuPXKpat7w8rH1ucha2yvcJ4mAUQLPMyrAwI0Z
	sa1X/RFCKjD120QQ/TpMMmR56KPP8Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722446006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgCkJyrl/5Q4LWKVaOBYvL2ddV/k1KvMTcm3jIZJ0JQ=;
	b=fcNraPgvsJCfor8+cd/lMfJprMrymGE3zNQgfAkHk1csgIsZKd0+NVcj5aH8RDnEd0ktob
	TtkzfZir0tsfW9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEF1F13297;
	Wed, 31 Jul 2024 17:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CnI0KrZwqmZXJgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jul 2024 17:13:26 +0000
Date: Wed, 31 Jul 2024 19:13:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: remove __GFP_NOFAIL usage for debug builds
Message-ID: <20240731171321.GT17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1720159494.git.wqu@suse.com>
 <20240705145543.GB879955@perftesting>
 <20240730135538.GC17473@twin.jikos.cz>
 <aaa0e841-fc2f-458f-9561-c7116c8a646e@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaa0e841-fc2f-458f-9561-c7116c8a646e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Jul 31, 2024 at 07:47:51AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/30 23:25, David Sterba 写道:
> > On Fri, Jul 05, 2024 at 10:55:43AM -0400, Josef Bacik wrote:
> >> On Fri, Jul 05, 2024 at 03:45:37PM +0930, Qu Wenruo wrote:
> >>> This patchset removes all __GFP_NOFAIL flags usage inside btrfs for
> >>> DEBUG builds.
> >>>
> >>> There are 3 call sites utilizing __GFP_NOFAIL:
> >>>
> >>> - __alloc_extent_buffer()
> >>>    It's for the extent_buffer structure allocation.
> >>>    All callers are already handling the errors.
> >>>
> >>> - attach_eb_folio_to_filemap()
> >>>    It's for the filemap_add_folio() call, the flag is also passed to mem
> >>>    cgroup, which I suspect is not handling larger folio and __GFP_NOFAIL
> >>>    correctly, as I'm hitting soft lockups when testing larger folios
> >>>
> >>>    New error handling is added.
> >>>
> >>> - btrfs_alloc_folio_array()
> >>>    This is for page allocation for extent buffers.
> >>>    All callers are already handling the errors.
> >>>
> >>> Furthermore, to enable more testing while not affecting end users, the
> >>> change is only implemented for DEBUG builds.
> >>>
> >>> Qu Wenruo (3):
> >>>    btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
> >>>    btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filemap()
> >>>    btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array()
> >>
> >> The reason I want to leave NOFAIL is because in a cgroup memory constrained
> >> environment we could get an errant ENOMEM on some sort of metadata operation,
> >> which then gets turned into an aborted transaction.  I don't want a memory
> >> constrained cgroup flipping the whole file system read only because it got an
> >> ENOMEM in a place where we have no choice but to abort the transaction.
> >>
> >> If we could eliminate that possibility then hooray, but that's not actually
> >> possible, because any COW for a multi-modification case (think finish ordered
> >> io) could result in an ENOMEM and thus a transaction abort.  We need to live
> >> with NOFAIL for these cases.  Thanks,
> > 
> > I agree with keeping NOFAIL.  Please add the above as a comment to
> > btrfs_alloc_folio_array().
> 
> That will soon no longer be a problem.
> 
> The cgroup guys are fine if certain inode should not be limited by mem 
> cgroup, so I already have patches to use root mem cgroup so that it will 
> not be charged at all.
> 
> https://lore.kernel.org/linux-mm/6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com/
> 
> Furthermore, using NOFAIL just to workaround mem cgroup looks like an 
> abuse to me.

It's not just because of cgroup, the nofail semantics for metadata
means that MM subsystem should try to get some memory instead of
failing, where the filesystem operation can wait a bit. What josef
described regarding transaction aborts applies in general.


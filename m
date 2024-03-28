Return-Path: <linux-btrfs+bounces-3735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8ED89093F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 20:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FFB1F2B47E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F313A251;
	Thu, 28 Mar 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bb5Ebvjg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQzi1PTb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5713A242
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654027; cv=none; b=GpDu0vWn0xfiyPGH2mg5nieFI+SwibvU5lND0VdglhSnHKZG3k44tQRAIw5Lfu9SyY6METP1Z4zp9ijhCAFe/FR2G3YVtp0yO99zT5QZR3pRj2BwIUCgUVprpjincsvHHHl9e28z+yCbS2IaWiynkRhlkxyRufWEY7PBuZ8TP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654027; c=relaxed/simple;
	bh=oz4uLCLoLoiBjqF4vioc6AlC0qubtGXzzb3z5eidUmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAqmtgXyy8c8KM1N75RuDsQvXLndNt3XxFRZNjMPgiqeqgqNm8Khy2GHdJpnNRVYT7gTtESWbG71c56H/FP8dSqDEbdqwsaK8sJ+uOzGt2wVwvo2cQGhbUVhvlf46rMO6mzJbUvrFiwwnNt5G7GIOuG05TTJZJ3wVxnGN876YpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bb5Ebvjg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uQzi1PTb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7170D3433C;
	Thu, 28 Mar 2024 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711654023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tp4SpL7IdWUKC4oum/eCAtICI5+bLWDxNy6YCbQpXyY=;
	b=Bb5EbvjgzvkAL78e+58XhE5ZrfTs4OoQBSYYFOX6xTJBm5zekFjTGiOxaGb5QtCAXohHWG
	jQjVfMcmBbjFtnGfTPnqSE5QSxJBjHh0eJA/At8SL33ejhtxDfX8UQPW+hmDFqAXi2WIY8
	qUiOtmYD8AqSDsFyUq641v+zxoMx4N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711654023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tp4SpL7IdWUKC4oum/eCAtICI5+bLWDxNy6YCbQpXyY=;
	b=uQzi1PTbiBewtlSBC8jga53Hd4TNDXphM3It9pddHSXZ+6ivBXcZboT1HvULk6WSQnBA3E
	H8+YrntF67YFjqDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F81A13A94;
	Thu, 28 Mar 2024 19:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id R5LFEofEBWYUMAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 28 Mar 2024 19:27:03 +0000
Date: Thu, 28 Mar 2024 20:19:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: compression: migrate to folio interfaces
Message-ID: <20240328191940.GA14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706521511.git.wqu@suse.com>
 <20240326233335.GV14596@twin.jikos.cz>
 <750c6ff1-8d33-4470-b914-be8e10a9e678@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750c6ff1-8d33-4470-b914-be8e10a9e678@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.81
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.81 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: 7170D3433C

On Thu, Mar 28, 2024 at 12:52:39PM +1030, Qu Wenruo wrote:
> >> And the final patch is the core conversion, as we have several structure
> >> relying on page array, it's impossible to just convert one algorithm to
> >> folio meanwhile keep all the other using pages.
> >>
> >>
> >> Qu Wenruo (6):
> >>    btrfs: compression: add error handling for missed page cache
> >>    btrfs: compression: convert page allocation to folio interfaces
> >>    btrfs: make insert_inline_extent() to accept one page directly
> >>    btrfs: migrate insert_inline_extent() to folio interfaces
> >>    btrfs: introduce btrfs_alloc_folio_array()
> >>    btrfs: compression: migrate compression/decompression paths to folios
> >
> > I added this patchset to my misc-next and it was in linux-next until
> > now. The bug that was a blocker for folio conversions is now fixed,
> > also thanks to you, so we can continue with the conversions. As this
> > patchset is 2 months old I'm not sure if it would be helpful to start
> > commenting and do the normal iteration round, I did a review and style
> > fixup round and moved it to for-next. Please have a look and let me know
> > if you find something wrong. I did mostly whitespace changes, though I
> > did remove the ASSERT(0), if there's btrfs_crit message it's quite
> > noticeable, and removed the local variable for fs_info in the first one.
> >
> > The conversions are all direct and seem safe to me, we won't do
> > multi-page folios yet, so the intemediate steps are the right way to go.
> > Thanks.
> >
> 
> Well, since I'm reading through all the commits in misc-next, I found
> some typos from myself:
> 
> - btrfs: prefer to allocate larger folio for metadata
>    * No longer no smaller, must be an exact fit.
>      No larger no smaller, ...
> 
>    * So here we go a different workaround, allocate a order 2 folio first
>                                        ... allocate an order 2 ...

I have this patch only for testing and did not do a typo-fixing pass as
updates are still expected. Also I found some problems with this patch
in page migration, I've sent the logs to slack.

> And these patches must be dropped:
> 
> - btrfs: defrag: prepare defrag for larger data folio size
> - btrfs: introduce cached folio size
> 
>    These two introduced and utilize fs_info->folio_shift, for filemap
>    code, which is completely wrong. As filemap always expect an index
>    with PAGE_SHIFT.

Ok, will drop them.


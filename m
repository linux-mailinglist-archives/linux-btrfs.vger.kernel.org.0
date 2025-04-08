Return-Path: <linux-btrfs+bounces-12895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC9A8192E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 01:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5AA4A7C70
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 23:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE062561DC;
	Tue,  8 Apr 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ROHckuH+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUIySyB4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ROHckuH+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUIySyB4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B344A21
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153951; cv=none; b=od0Ia8frMRhCLeT+5FPu7Kq89QX+xJY5dx5fVkJNtlg4U2vxlBUTEpM3vGsxXAUfeWB+Q80ROwF5c00tNlpzDVYCAQlmd9Ha0pnBMk6bo6bYOzT0qnhAf87C7nhfG6Ny6EszQF9caBZ86sIJHG68n5RrPgYeJDBnEVP8Amg9awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153951; c=relaxed/simple;
	bh=qJbvIPZHt5nxV5TaDGqJz4lbOD38dYQ0GSVA9S8EmdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olAgGKr0pTjFQDIH7aompmEP6R/sm3XEWBR9RXvKCo+lpCLcZAdVwiDm8OAaTYyozskdkLa5HE1/JhuMP/CYop4tuK9uHxgw5vnEWdSywsy2WvEHB1DOxWlWpjrIU0PDVhqtaUlj4kVIYKk7xP9UH8E1dKDBL3rZHQU9UrwCcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ROHckuH+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OUIySyB4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ROHckuH+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OUIySyB4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C05631F388;
	Tue,  8 Apr 2025 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744153947;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul4hW6+DAIMX8wPtIHgLzEj+JKcL5OgpopVmxsjIMTw=;
	b=ROHckuH+uhMyfBNmRtRRNSOElaeoc6u4vYms1UL8ZRp0h6/6GSAGS7WLtCaajwyCJKo8lB
	nmKCF9EwoC0o+P5Eyn3ILssp/7r3Ynmm9nGA1RF2Fdk4pDBx4vvLt9ZVqNDhaUnsXpcFe1
	gAoOezLzTXG+RUEQA1rehjkyLONOzcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744153947;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul4hW6+DAIMX8wPtIHgLzEj+JKcL5OgpopVmxsjIMTw=;
	b=OUIySyB4jkj1oniOYAYEpxooKXK9Qgw5q4QEhyXoRSjwNOeqrFlub7lMIZMWif3Ysbwcwz
	3s7weoYiKD08//BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ROHckuH+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OUIySyB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744153947;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul4hW6+DAIMX8wPtIHgLzEj+JKcL5OgpopVmxsjIMTw=;
	b=ROHckuH+uhMyfBNmRtRRNSOElaeoc6u4vYms1UL8ZRp0h6/6GSAGS7WLtCaajwyCJKo8lB
	nmKCF9EwoC0o+P5Eyn3ILssp/7r3Ynmm9nGA1RF2Fdk4pDBx4vvLt9ZVqNDhaUnsXpcFe1
	gAoOezLzTXG+RUEQA1rehjkyLONOzcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744153947;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul4hW6+DAIMX8wPtIHgLzEj+JKcL5OgpopVmxsjIMTw=;
	b=OUIySyB4jkj1oniOYAYEpxooKXK9Qgw5q4QEhyXoRSjwNOeqrFlub7lMIZMWif3Ysbwcwz
	3s7weoYiKD08//BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97A6F13691;
	Tue,  8 Apr 2025 23:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N8q8JFut9WcdVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Apr 2025 23:12:27 +0000
Date: Wed, 9 Apr 2025 01:12:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: use folio_contains() for EOF detection
Message-ID: <20250408231226.GF13292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743731232.git.wqu@suse.com>
 <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
 <20250407183912.GB32661@twin.jikos.cz>
 <313da654-15aa-437a-847d-e125e83df977@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <313da654-15aa-437a-847d-e125e83df977@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C05631F388
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmx.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 08, 2025 at 07:28:58AM +0930, Qu Wenruo wrote:
> 在 2025/4/8 04:09, David Sterba 写道:
> > On Fri, Apr 04, 2025 at 12:17:41PM +1030, Qu Wenruo wrote:
> >> Currently we use the following pattern to detect if the folio contains
> >> the end of a file:
> >>
> >> 	if (folio->index == end_index)
> >> 		folio_zero_range();
> >>
> >> But that only works if the folio is page sized.
> >>
> >> For the following case, it will not work and leave the range beyond EOF
> >> uninitialized:
> >>
> >>    The page size is 4K, and the fs block size is also 4K.
> >>
> >> 	16K        20K       24K
> >>          |          |     |   |
> >> 	                 |
> >>                           EOF at 22K
> >>
> >> And we have a large folio sized 8K at file offset 16K.
> >>
> >> In that case, the old "folio->index == end_index" will not work, thus
> >> we the range [22K, 24K) will not be zeroed out.
> >>
> >> Fix the following call sites which use the above pattern:
> >>
> >> - add_ra_bio_pages()
> >>
> >> - extent_writepage()
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/compression.c | 2 +-
> >>   fs/btrfs/extent_io.c   | 6 +++---
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> >> index cb954f9bc332..7aa63681f92a 100644
> >> --- a/fs/btrfs/compression.c
> >> +++ b/fs/btrfs/compression.c
> >> @@ -523,7 +523,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
> >>   		free_extent_map(em);
> >>   		unlock_extent(tree, cur, page_end, NULL);
> >>
> >> -		if (folio->index == end_index) {
> >> +		if (folio_contains(folio, end_index)) {
> >>   			size_t zero_offset = offset_in_folio(folio, isize);
> >>
> >>   			if (zero_offset) {
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index 013268f70621..f0d51f6ed951 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -221,7 +221,7 @@ static void __process_folios_contig(struct address_space *mapping,
> >>   }
> >>
> >>   static noinline void unlock_delalloc_folio(const struct inode *inode,
> >> -					   const struct folio *locked_folio,
> >> +					   struct folio *locked_folio,
> >
> > I'm not happy to see removing const from the parameters as it's quite
> > tedious to find them. Here it's not necessary as it's still not changing
> > the folio, only required because folio API is not const-clean,
> > folio_contains() in particular.
> >
> 
> Yes, I'm not happy with that either, and I'm planning to constify the
> parameters for those helpers in a dedicated series.

Thanks, but don't let it distract you from the more important folio
changes. I noticed there are missing consts in the page API too, like
page_offset() or the folio/page boundary like folio_pos() or
folio_pgoff(). This is can wait, my comment was more like a note to self
to have a look later.


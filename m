Return-Path: <linux-btrfs+bounces-11029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D22A181B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C993A5081
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0E1F4705;
	Tue, 21 Jan 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e9KVwyQL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSNkkmYU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e9KVwyQL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSNkkmYU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A91C36
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475822; cv=none; b=SzazyBjRFjy8TT3A06B56VLJGRJ6LQE+QuRcwwPJaH8YG2MfrTULNuA4KJoQ5zDblgv3x2e4EMBkcEIYpuU3mvRVaq72kvPJL5qdJpX53Z2kNEF8vQ5vTJPDIFNOW+tlYRTu5ZsqPtbeoNzqF6sxyC6GjBKT9bDzgauO9jFflOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475822; c=relaxed/simple;
	bh=mQmOaROA5eRYvComvfwS9Y6Q3hzMNIqefIJJOszybWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWPX+svjzVgsnMl7V/2st/eRUhH83ykAJrsO4+k1HpmoW5nk0Prkk6r6ewCLWusEiSUT6OH9gFUwYQfKZWmhIdh6K5Kyld1lluuAoOKs78u05Heh17EbM2g2/0Xlkpa385iarQOVcsj+no+m4Be0/jGikgUEWkIcRRdhONRQeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e9KVwyQL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSNkkmYU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e9KVwyQL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSNkkmYU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72C481F393;
	Tue, 21 Jan 2025 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737475818;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1gm3pP8iBQokD+4Hhw7R4yukjbKzCVXZBiwatsd64k=;
	b=e9KVwyQLJ9nV6TrhO+VuJQ+YZuTysqOYUWvoIHjKZawMwOHa/12QwWOQSisES+Q0AhYAB1
	y9bOSeE7cnBZ27oMefLW6MfBjBI8xuPZY8gegUBlpBfjwPDxxFG6xqdw9mNg0mxUiR3Ce4
	6Q74N6Y0oYZtNiSfLTakUEXIqti+WHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737475818;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1gm3pP8iBQokD+4Hhw7R4yukjbKzCVXZBiwatsd64k=;
	b=VSNkkmYUjUVi3QV5+noXWbRBIrxRa5NFvu/nnmgpXm4cgnDvPS34Exu9yFUQ9HAJsrxOeo
	fbqhvCM7KaoCbyAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737475818;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1gm3pP8iBQokD+4Hhw7R4yukjbKzCVXZBiwatsd64k=;
	b=e9KVwyQLJ9nV6TrhO+VuJQ+YZuTysqOYUWvoIHjKZawMwOHa/12QwWOQSisES+Q0AhYAB1
	y9bOSeE7cnBZ27oMefLW6MfBjBI8xuPZY8gegUBlpBfjwPDxxFG6xqdw9mNg0mxUiR3Ce4
	6Q74N6Y0oYZtNiSfLTakUEXIqti+WHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737475818;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1gm3pP8iBQokD+4Hhw7R4yukjbKzCVXZBiwatsd64k=;
	b=VSNkkmYUjUVi3QV5+noXWbRBIrxRa5NFvu/nnmgpXm4cgnDvPS34Exu9yFUQ9HAJsrxOeo
	fbqhvCM7KaoCbyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3343C13963;
	Tue, 21 Jan 2025 16:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nM6AC+rGj2ccOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 Jan 2025 16:10:18 +0000
Date: Tue, 21 Jan 2025 17:10:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Fix two misuses of folio_shift()
Message-ID: <20250121161011.GG5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250121054054.4008049-1-willy@infradead.org>
 <20250121054054.4008049-2-willy@infradead.org>
 <33fa9947-cead-4f38-a61a-39b053f37a03@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33fa9947-cead-4f38-a61a-39b053f37a03@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Jan 21, 2025 at 05:51:40PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/1/21 16:10, Matthew Wilcox (Oracle) 写道:
> > It is meaningless to shift a byte count by folio_shift().  The folio index
> > is in units of PAGE_SIZE, not folio_size().  We can use folio_contains()
> > to make this work for arbitrary-order folios, so remove the assertion
> > that the folios are of order 0.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >   fs/btrfs/extent_io.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 289ecb8ce217..c9b0ee841501 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -523,8 +523,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
> >   		u64 end;
> >   		u32 len;
> >   
> > -		/* For now only order 0 folios are supported for data. */
> > -		ASSERT(folio_order(folio) == 0);
> 
> I'd prefer to keep this ASSERT(), as all the btrfs_folio_*() helpers can 
> only handle page sized folio for now.
> 
> >   		btrfs_debug(fs_info,
> >   			"%s: bi_sector=%llu, err=%d, mirror=%u",
> >   			__func__, bio->bi_iter.bi_sector, bio->bi_status,
> > @@ -552,7 +550,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
> >   
> >   		if (likely(uptodate)) {
> >   			loff_t i_size = i_size_read(inode);
> > -			pgoff_t end_index = i_size >> folio_shift(folio);
> >   
> >   			/*
> >   			 * Zero out the remaining part if this range straddles
> > @@ -563,7 +560,8 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
> >   			 *
> >   			 * NOTE: i_size is exclusive while end is inclusive.
> >   			 */
> > -			if (folio_index(folio) == end_index && i_size <= end) {
> > +			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
> 
> Although folio_contains() is already a pretty good improvement, can we 
> have a bytenr/i_sized based solution for fs usages?

Good point, something like folio_contains_offset() that does the correct
shifts.


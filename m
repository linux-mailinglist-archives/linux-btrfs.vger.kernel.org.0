Return-Path: <linux-btrfs+bounces-13553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B268AA4E69
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E17165B28
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342525F786;
	Wed, 30 Apr 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ee+YoZEN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oKBA3Qil";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtBXm4Oz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/ls/9nmy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77052AE8B
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023025; cv=none; b=FXvnyAgrA45QFGF06Ms3KSeQ3yJt26s3yNVtwxSipBVUUbCTf8oqIgfrtKXOoUG/B7b489ujKmhBhppwAyPuPkA/WiHzhUfInFuFB+NLLKOToGN9quW66Z1mRYpKWktQoCh7OSbuHtm/B9WAL6+81+RlHnYIhxryQzZNbOpLWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023025; c=relaxed/simple;
	bh=C2MJghkCDVDAdkeaRUbVZKkNrhVkZbLTD/Kdic6+XqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrurSHdZYOwfCEb7pifGYEln6vYOGKrwTOLvp/y++AJ+NPud5mthuCySoB1khjacca28+/Eijza43XalZpcdEY8B69VB3OSjOZnTXHyNRMESopTzYela9ymAFTxqjLmIluv86nQo22CmXOqgiHJ0rpAV4iQdadAimzyThKmaJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ee+YoZEN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oKBA3Qil; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtBXm4Oz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/ls/9nmy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F287F21962;
	Wed, 30 Apr 2025 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746023021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoqgZ+SGiQx0nqIExAB9bQY0k4lWT8MA/ATCOyCQzJw=;
	b=ee+YoZEN6qlbOL6zA4l8tYsuTupW9qBfm1mnE8xD0BFZCSi2bEHWKOp4wLafy3u71RXQeU
	CUzjDrHzAGOlWSHyYXYc6sCX/6FAYIk0bY72YVpJAmPYpxm0UpUP3xs3lQrKXemokbd4FN
	US08HHRaGEwKzzxNsU+lLDiKiQX4NxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746023021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoqgZ+SGiQx0nqIExAB9bQY0k4lWT8MA/ATCOyCQzJw=;
	b=oKBA3QilMm/TA00LP6R+y1C+GwmB492bI2A3L4Si4moclcMaLs/sGmNmEGkx1E0y0+st8I
	7LsIdDaiLt4TTNDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rtBXm4Oz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/ls/9nmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746023020;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoqgZ+SGiQx0nqIExAB9bQY0k4lWT8MA/ATCOyCQzJw=;
	b=rtBXm4OzE21O9iYd4f5O9c4IxD5Mt4tuiMPnMVwPmzo6Tq5AjPEjhhJSw1Jhwwo7sdsaoc
	Jgetm6bjZPVG40vvFcRZA3luT2xk0CskyC0uKerVqfo/KTIZhehIs2r3I6BDoDwSoZS9ty
	8+wg4c++nzF+qoEampmnaIIuX3aS9Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746023020;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoqgZ+SGiQx0nqIExAB9bQY0k4lWT8MA/ATCOyCQzJw=;
	b=/ls/9nmy4JxrMMzMWM5b2zUxvCUuWna33sdDUhewNNrwlzpKcLLFPgRVmHNndaqjK0vig1
	jEW5CpmaeqhDoQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBBD6139E7;
	Wed, 30 Apr 2025 14:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ByuDMWwyEmgSCQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Apr 2025 14:23:40 +0000
Date: Wed, 30 Apr 2025 16:23:35 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: get rid of goto in alloc_test_extent_buffer()
Message-ID: <20250430142335.GI9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250425072358.51788-1-neelx@suse.com>
 <20250425113907.GC31681@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425113907.GC31681@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [0.79 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Spamd-Bar: /
X-Rspamd-Queue-Id: F287F21962
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.79
X-Spam-Level: 

On Fri, Apr 25, 2025 at 01:39:07PM +0200, David Sterba wrote:
> On Fri, Apr 25, 2025 at 09:23:57AM +0200, Daniel Vacek wrote:
> > The `free_eb` label is used only once. Simplify by moving the code inplace.
> > 
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index ea38c73d4bc5f..20cdddd924852 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3004,15 +3004,13 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
> >  			goto again;
> >  		}
> >  		xa_unlock_irq(&fs_info->buffer_tree);
> > -		goto free_eb;
> > +		btrfs_release_extent_buffer(eb);
> > +		return exists;
> >  	}
> >  	xa_unlock_irq(&fs_info->buffer_tree);
> >  	check_buffer_tree_ref(eb);
> >  
> >  	return eb;
> > -free_eb:
> > -	btrfs_release_extent_buffer(eb);
> 
> So the xarray conversion removed the other use of the free_eb label and
> calls btrfs_release_extent_buffer() + return. Doing the same here and
> removing the label completely looks as an improvement, as the whole
> function does direct returns instead of goto exit block.
> 
> Reviewed-by: David Sterba <dsterba@suse.com>

Xarray conversion is now in for-next so I've added this patch too.


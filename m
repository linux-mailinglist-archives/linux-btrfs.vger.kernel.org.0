Return-Path: <linux-btrfs+bounces-9954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B658B9DB8F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76940283645
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C391A9B2B;
	Thu, 28 Nov 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbFUvIar";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVlEQEMP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/P5XFrL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrPFPeTC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA251AA1FA
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801130; cv=none; b=f2oKL2LyRfvZEVsJ9LqJDUcc7JIBnYP0wWYwJ5r/BZ/3Wae7wp/jKQHPYHhcFG4St8YgOHJmfNsxHxYXOS/mQUQc3AyA1CJ0a+Cxv+Pm8hy1mWrFokx7ddhKxCkEtW+XQlMzirOXjCWEdVzbphYB81whurkDnZa8avGSoDBbReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801130; c=relaxed/simple;
	bh=IcObyt622mQ8NTvqTj8lKowCTD1+HBU5Vx4Vb8tR6mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPAbbrfZNT5XVolPkJZ+4zc78Zpc2hh0mpNJHhJnhresuA8p2+/wIwdMYmW8L2yYjQGuiOQPF3MoklOvynyc8RRZwHykQXuvx9GsQQ6YzRUaJ7Zv60DbjTqlxyb1gBP0kQ1wV8P7crTiJd4fnYT4gOfzaUv9usISRx66bYWJTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbFUvIar; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVlEQEMP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/P5XFrL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrPFPeTC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB1AB21176;
	Thu, 28 Nov 2024 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732801127;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK9d5zb9OHQ44Sx4iEG2cAGj0NNfdYYQ5QMKNoCO4Ik=;
	b=AbFUvIarxk2txNPHGJypg32ddW4VZFIDYj963vmyQ9ZbEoRszt9zERBdb174GLf7VUi44C
	oOXn9AwK6o/jkziiTmxGQXnK93PBnaHOUnCzIskcnTYi+TrGPQZlD06cVysWR312dZEid2
	Mw2lTYKvvBcCv4Putvi7TyrRjNNIl/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732801127;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK9d5zb9OHQ44Sx4iEG2cAGj0NNfdYYQ5QMKNoCO4Ik=;
	b=GVlEQEMPSadjxqyNKcBY8ZW65tL1Aj8gZ9KL4ITMNBHnDUC39Cm2wRjiOj9EMTH7hUQpHn
	7tgRhI3HKpM/SBCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Q/P5XFrL";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PrPFPeTC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732801126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK9d5zb9OHQ44Sx4iEG2cAGj0NNfdYYQ5QMKNoCO4Ik=;
	b=Q/P5XFrLGBwYiZFxyWmYi0X0elRV3u4MG91GaB0zaWTD1RkCJV+Rf4Xr1ECXF0++Qly4Tf
	L3sqfmrzvM/wtx68HM3gCR70xplCwDOJst/QqKYICze9darZArlqTAOB2zCYEz9hT/wLXZ
	01rGslZXXUi6yVOoLs7SxPbXUHaOzr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732801126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK9d5zb9OHQ44Sx4iEG2cAGj0NNfdYYQ5QMKNoCO4Ik=;
	b=PrPFPeTCMjss9xsjsItwbRjnw9egYaiKTh7d0y3dJ2m2tTKIFoWVQ+YxHqsXrZSqJc7Bq5
	jFPk9fvsE5anj1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D365513690;
	Thu, 28 Nov 2024 13:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3wIMM2ZySGf0AQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Nov 2024 13:38:46 +0000
Date: Thu, 28 Nov 2024 14:38:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject out-of-band dirty folios during writeback
Message-ID: <20241128133841.GU31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2bbe9b35968132d387379dd486da9b21d45e1889.1731399977.git.wqu@suse.com>
 <20241125161128.GC31418@twin.jikos.cz>
 <20241125162552.GD31418@twin.jikos.cz>
 <74048e24-dd8e-4162-ac08-2b6e799393bd@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74048e24-dd8e-4162-ac08-2b6e799393bd@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: EB1AB21176
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
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Nov 26, 2024 at 01:03:23PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/11/26 02:55, David Sterba 写道:
> > On Mon, Nov 25, 2024 at 05:11:28PM +0100, David Sterba wrote:
> >> On Tue, Nov 12, 2024 at 06:56:51PM +1030, Qu Wenruo wrote:
> >>> An out-of-band folio means the folio is marked dirty but without
> >>> notifying the filesystem.
> >>>
> >>> This used to be a problem related to get_user_page(), but with the
> >>> introduction of pin_user_pages_locked(), we should no longer hit such
> >>> case anymore.
> >>>
> >>> In btrfs, we have a long history of handling such out-of-band dirty
> >>> folios by:
> >>>
> >>> - Mark extent io tree EXTENT_DELALLOC during btrfs_dirty_folio()
> >>>    So that any buffered write into the page cache will have
> >>>    EXTENT_DEALLOC flag set for the corresponding range in btrfs' extent
> >>>    io tree.
> >>>
> >>> - Marking the folio ordered during delalloc
> >>>    This is based on EXTENT_DELALLOC flag in the extent io tree.
> >>>
> >>> - During folio submission for writeback check the ordered flag
> >>>    If the folio has no ordered folio, it means it doesn't go through
> >>>    the initial btrfs_dirty_folio(), thus it's definitely an out-of-band
> >>>    one.
> >>>
> >>>    If we got one, we go through COW fixup, which will re-dirty the folio
> >>>    with proper handling in another workqueue.
> >>>
> >>> Such workaround is a blockage for us to migrate to iomap (it requires
> >>> extra flags to trace if a folio is dirtied by the fs or not) and I'd
> >>> argue it's not data checksum safe, since the folio can be modified
> >>> halfway.
> >>>
> >>> But with the introduction of pin_user_pages_locked() during v5.8 merge
> >>
> >> I don't see pin_user_pages_locked() in git, only
> >> pin_user_pages_unlocked() but that does not seem to be the right one.
> >> 5.8 is quite old so there could have been changes and renames but still
> >> the reason why we can drop the cow fixup eventually should be correct.
> >
> > Well, it got removed in 5.18 again, ad6c441266dcd5 ("mm/gup: remove
> > unused pin_user_pages_locked()").
> >
> 
> My bad, the more correct term is just pin_user_pages().
> 
> It's also mentioned inside the core-api/pin_user_pages.rst, and it looks
> like the CASE 5 is exactly what caused the original out-of-band dirty
> pages. (get_uiser_pages(), write, put_pages()).

IIRC the problem was with unmap(), something unmapping last page in the
whole range that touched page table entries rather than wrting to the
pages.  Which would point to case 3.

Unless there are more fixups like the pin_user_pages() reference, please
add it to for-next. Thanks.


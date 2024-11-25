Return-Path: <linux-btrfs+bounces-9897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B879D8B09
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 18:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A38BB2EA90
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F421B4152;
	Mon, 25 Nov 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="owCKARG9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mm7DZ2EC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="owCKARG9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mm7DZ2EC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2372AD25
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551957; cv=none; b=pIK05zi6tT7v04Wb846aVI/5ugSr1iXOm6u0dvWp0B51oufX1TXn+Y+k8Hc5780Mlbut/YL6WMa5EVDV2QSTnjm9JY8PUDcU73M9LvXrJUvQmPcxOqGcQZ5f6La0X5u4YHnmswtIX33aefO6h9dqvDF8RI0L+yU/Bmcdv1YiQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551957; c=relaxed/simple;
	bh=ZK26Ie+gVkduv/VV8h4aBYMX3NQLQe/Vd2jEZvMAGp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAotnMOKptQRgvST8SNjMuLjiVXxv+mdlP16xBC+wsGDgJdb9ffO9h+5IVIeOXe2IBkm9O9FdjgfLT2FaWhmmuSjezN2teGurAdpr7SjqzvlFE4tSnWcRjV7sMKtEhWVR+Z8wuN8yuD6PS8OMV1Dsh69n1k8M0Ys4GaL1t/+CwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=owCKARG9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mm7DZ2EC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=owCKARG9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mm7DZ2EC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E8D11F442;
	Mon, 25 Nov 2024 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732551954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgUEa5vNpxBfN3cbov+KKYGIPdViE5a31bwpCk4tz6Q=;
	b=owCKARG95sp18Vol13Fqugafs7v4eQFU6fAAIYt5g0zNb/2gec34qhPJbPJJglnuQlVLEp
	0xqvYzagZqTBzStLIfn6dxNyJ3I36mXuCQask1KOU3swHkgwzYVuoJcAWCfdjupn1MO5Ib
	wtCYJS6/ynmJLKzzm2XjZQw44tjpuTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732551954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgUEa5vNpxBfN3cbov+KKYGIPdViE5a31bwpCk4tz6Q=;
	b=mm7DZ2ECE+FCY26DmFaGCZrZ8tgKp9gMo77WQvEy+JDNbZqbb7Ryc+hhChN885Jhi9N2Dn
	HAuR05ue2qQTGLBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732551954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgUEa5vNpxBfN3cbov+KKYGIPdViE5a31bwpCk4tz6Q=;
	b=owCKARG95sp18Vol13Fqugafs7v4eQFU6fAAIYt5g0zNb/2gec34qhPJbPJJglnuQlVLEp
	0xqvYzagZqTBzStLIfn6dxNyJ3I36mXuCQask1KOU3swHkgwzYVuoJcAWCfdjupn1MO5Ib
	wtCYJS6/ynmJLKzzm2XjZQw44tjpuTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732551954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgUEa5vNpxBfN3cbov+KKYGIPdViE5a31bwpCk4tz6Q=;
	b=mm7DZ2ECE+FCY26DmFaGCZrZ8tgKp9gMo77WQvEy+JDNbZqbb7Ryc+hhChN885Jhi9N2Dn
	HAuR05ue2qQTGLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1708913890;
	Mon, 25 Nov 2024 16:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OaZJBBKlRGfScAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Nov 2024 16:25:54 +0000
Date: Mon, 25 Nov 2024 17:25:52 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject out-of-band dirty folios during writeback
Message-ID: <20241125162552.GD31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2bbe9b35968132d387379dd486da9b21d45e1889.1731399977.git.wqu@suse.com>
 <20241125161128.GC31418@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125161128.GC31418@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: 1.00

On Mon, Nov 25, 2024 at 05:11:28PM +0100, David Sterba wrote:
> On Tue, Nov 12, 2024 at 06:56:51PM +1030, Qu Wenruo wrote:
> > An out-of-band folio means the folio is marked dirty but without
> > notifying the filesystem.
> > 
> > This used to be a problem related to get_user_page(), but with the
> > introduction of pin_user_pages_locked(), we should no longer hit such
> > case anymore.
> > 
> > In btrfs, we have a long history of handling such out-of-band dirty
> > folios by:
> > 
> > - Mark extent io tree EXTENT_DELALLOC during btrfs_dirty_folio()
> >   So that any buffered write into the page cache will have
> >   EXTENT_DEALLOC flag set for the corresponding range in btrfs' extent
> >   io tree.
> > 
> > - Marking the folio ordered during delalloc
> >   This is based on EXTENT_DELALLOC flag in the extent io tree.
> > 
> > - During folio submission for writeback check the ordered flag
> >   If the folio has no ordered folio, it means it doesn't go through
> >   the initial btrfs_dirty_folio(), thus it's definitely an out-of-band
> >   one.
> > 
> >   If we got one, we go through COW fixup, which will re-dirty the folio
> >   with proper handling in another workqueue.
> > 
> > Such workaround is a blockage for us to migrate to iomap (it requires
> > extra flags to trace if a folio is dirtied by the fs or not) and I'd
> > argue it's not data checksum safe, since the folio can be modified
> > halfway.
> > 
> > But with the introduction of pin_user_pages_locked() during v5.8 merge
> 
> I don't see pin_user_pages_locked() in git, only
> pin_user_pages_unlocked() but that does not seem to be the right one.
> 5.8 is quite old so there could have been changes and renames but still
> the reason why we can drop the cow fixup eventually should be correct.

Well, it got removed in 5.18 again, ad6c441266dcd5 ("mm/gup: remove
unused pin_user_pages_locked()").


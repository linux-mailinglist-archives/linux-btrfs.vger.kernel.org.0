Return-Path: <linux-btrfs+bounces-6147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0671924356
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 18:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA7D2836EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8F1BD02E;
	Tue,  2 Jul 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EknYONnh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mJpqaiZn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EknYONnh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mJpqaiZn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46E1BBBD7
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936696; cv=none; b=YDojt/sB6xOT+DvdrFwYqT2U1Qy+ofYA4KaTsItaNK0nfgYzRAI+mAqMqOYIjZS+CmwnXxE5pRlg+FFeR7z3GE4zdxRn1qRx1unvGw7n6LvH70Adn7pQ41uVwXiCV47F5IDKz5dvdb1D2VWMdeKj7X1e/3wKTTpEFq16V84/kR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936696; c=relaxed/simple;
	bh=g4w4xRod6kFEHyAOWT74JdV9yQNoxF/fMscm4aSMJyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfhdbL+YRfpawG3v4RrdqNcuTTBO93Jeb/7F3L9uJoKGZt5TDACQ7WDNXiVfakTfHcWgTg2BbfwWewglCpmqbUPdTjyBkw1ChpaKU/dTUjjEGOhtqHsvOtNqb+tp7dmMOYSJ9upd95GOuGARZI5KCszWxleE/AiDE2BdHX2TOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EknYONnh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mJpqaiZn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EknYONnh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mJpqaiZn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F7761FBAC;
	Tue,  2 Jul 2024 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719936693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ggku3U7xHtvOanvObRz/KB1B8BtHfs4jJPOwlH09aNo=;
	b=EknYONnhTekO4OmbYgUNSTgycIoQWgKllD8SSVtDt3U68MQIsjSmP0ANWv61+f5ts0Q2pw
	C+vtwkXDHvbCyHaW4Q5QT6TBEhTO61bkNTiMC9d/qenFcgUJq4Ah2pn3Cw1K0slJ5UqBt1
	4liQwJ6Dm6y/6Nl/VSahoviXwdeTrM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719936693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ggku3U7xHtvOanvObRz/KB1B8BtHfs4jJPOwlH09aNo=;
	b=mJpqaiZnaUAFqlMi7bM7iLXKdFiC75oOuc0pqW+wmtr0Wap9q82eujvkGV9Qsif8M9SsF8
	s7rwwgHXupfXE2CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719936693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ggku3U7xHtvOanvObRz/KB1B8BtHfs4jJPOwlH09aNo=;
	b=EknYONnhTekO4OmbYgUNSTgycIoQWgKllD8SSVtDt3U68MQIsjSmP0ANWv61+f5ts0Q2pw
	C+vtwkXDHvbCyHaW4Q5QT6TBEhTO61bkNTiMC9d/qenFcgUJq4Ah2pn3Cw1K0slJ5UqBt1
	4liQwJ6Dm6y/6Nl/VSahoviXwdeTrM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719936693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ggku3U7xHtvOanvObRz/KB1B8BtHfs4jJPOwlH09aNo=;
	b=mJpqaiZnaUAFqlMi7bM7iLXKdFiC75oOuc0pqW+wmtr0Wap9q82eujvkGV9Qsif8M9SsF8
	s7rwwgHXupfXE2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC43713A9A;
	Tue,  2 Jul 2024 16:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QaEyNbQmhGbfNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 16:11:32 +0000
Date: Tue, 2 Jul 2024 18:11:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: prefer to allocate larger folio for metadata
Message-ID: <20240702161131.GH21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <96e9e2c1ac180a3b6c8c29a06c4a618c8d4dc2d9.1719734174.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e9e2c1ac180a3b6c8c29a06c4a618c8d4dc2d9.1719734174.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Sun, Jun 30, 2024 at 05:26:59PM +0930, Qu Wenruo wrote:
> For btrfs metadata, the high order folios are only utilized when all the
> following conditions are met:
> 
> - The extent buffer start is aligned to nodesize
>   This should be the common case for any btrfs in the last 5 years.
> 
> - The nodesize is larger than page size
>   Or there is no need to use larger folios at all.
> 
> - MM layer can fulfill our folio allocation request
> 
> - The larger folio must exactly cover the extent buffer
>   No longer no smaller, must be an exact fit.
> 
>   This is to make extent buffer accessors much easier.
>   They only need to check the first slot in eb->folios[], to determine
>   their access unit (need per-page handling or a large folio covering
>   the whole eb).
> 
> There is another small blockage, filemap APIs can not guarantee the
> folio size.
> For example, by default we go 16K nodesize on x86_64, meaning a larger
> folio we expect would be with order 2 (size 16K).
> We don't accept 2 order 1 (size 8K) folios, or we fall back to 4 order 0
> (page sized) folios.
> 
> So here we go a different workaround, allocate a order 2 folio first,
> then attach them to the filemap of metadata.
> 
> Thus here comes several results related to the attach attempt of eb
> folios:
> 
> 1) We can attach the pre-allocated eb folio to filemap
>    This is the most simple and hot path, we just continue our work
>    setting up the extent buffer.
> 
> 2) There is an existing folio in the filemap
> 
>    2.0) Subpage case
>         We would reuse the folio no matter what, subpage is doing a
> 	different way handling folio->private (a bitmap other than a
> 	pointer to an existing eb).
> 
>    2.1) There is already a live extent buffer attached to the filemap
>         folio
> 	This should be more or less hot path, we grab the existing eb
> 	and free the current one.
> 
>    2.2) No live eb.
>    2.2.1) The filemap folio is larger than eb folio
>           This is a better case, we can reuse the filemap folio, but
> 	  we need to cleanup all the pre-allocated folios of the
> 	  new eb before reusing.
> 	  Later code should take the folio size change into
> 	  consideration.
> 
>    2.2.2) The filemap folio is the same size of eb folio
>           We just free the current folio, and reuse the filemap one.
> 	  No other special handling needed.
> 
>    2.2.3) The filemap folio is smaller than eb folio
>           This is the most tricky corner case, we can not easily replace
> 	  the folio in filemap using our eb folio.
> 
> 	  Thus here we return -EAGAIN, to inform our caller to re-try
> 	  with order 0 (of course with our larger folio freed).
> 
> Otherwise all the needed infrastructure is already here, we only need to
> try allocate larger folio as our first try in alloc_eb_folio_array().

How do you want to proceed with that? I think we need more time to
finish conversions to folios. There are still a few left and then we
need time to test it (to catch bugs like where fixed the two recent
__folio_put patches).

Keeping this patch in for-next would give us mixed results or we could
miss bugs that would not happen without large folios. For a 6.11 devel
cycle it's too late to merge, for 6.12 maybe but that would not give us
enough time for testing so 6.13 sounds like the first target. I don't
think we need to rush such change, debugging the recent extent buffer
bugs shows that they're are pretty hard and hinder everything else.


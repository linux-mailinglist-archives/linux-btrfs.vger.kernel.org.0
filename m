Return-Path: <linux-btrfs+bounces-7802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0B196A81F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 22:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F4F1F23FAA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677FD191477;
	Tue,  3 Sep 2024 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ghlp3O0R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYielTBN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ghlp3O0R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYielTBN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4B1DC725
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394448; cv=none; b=tjFI4OzHn0E3mgZGIbfrgC+6KMtqYwN6gyPNvEqgHBwKaoM32CdaRKa6Ywwo488T0tbWLcEE0t1d1h3dzXARBzoGTq4chVKhRjoxMtaW485d73aqQmQ+I3a8ZsnVLng64kM3LCItCTm+4uD0MD7t8sf8TLHRc0tZj1aUXKTkbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394448; c=relaxed/simple;
	bh=LhAQ9ErEitb3yKRD7XOrv3BLAHCii/mmXJlqoM//GWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgpceuGDiQgCWUZu9CAWm66WOuEv6tpuqpX5YLnJDULtvj68Z0hiRKnnipABgSKC0b8Djo/6Jx5cuovN7t6aTd63usS33XTmP7eFKIggE7NyRgNI4OZPUGcChK2Z8anwBzfkgzLjQaDV/quix2W3G4sRJfc9Tdfiae5fvi+QgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ghlp3O0R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYielTBN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ghlp3O0R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYielTBN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A0831F46E;
	Tue,  3 Sep 2024 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725394444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEa8DGwuxSDKAR+JZn2UiA/g9QBLB1MPuZqYFJvQ9NM=;
	b=ghlp3O0RHiUhsLuksdo649Wcmj8TLAkzxfLyAcqjxxRHP0qR0Kq2mDUXD5LPOwl2Dvya8D
	ITquIMA+3Sfyws+Au6omf2BVOigrrZ6QkBEa8tivcHDkqc/8wHfbd9S6BaswiAcOkCXZ24
	nNS7xGxsMuRkvMvzYPOt4/Tgn83fDU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725394444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEa8DGwuxSDKAR+JZn2UiA/g9QBLB1MPuZqYFJvQ9NM=;
	b=MYielTBNZeLxSO4k6lDFZGQsCDoRMt6v5WPQZ+3FBW9quxiQ74nssZxwTslnijNWmwbEnT
	Nl+EjFQQ5l/IrrAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ghlp3O0R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MYielTBN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725394444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEa8DGwuxSDKAR+JZn2UiA/g9QBLB1MPuZqYFJvQ9NM=;
	b=ghlp3O0RHiUhsLuksdo649Wcmj8TLAkzxfLyAcqjxxRHP0qR0Kq2mDUXD5LPOwl2Dvya8D
	ITquIMA+3Sfyws+Au6omf2BVOigrrZ6QkBEa8tivcHDkqc/8wHfbd9S6BaswiAcOkCXZ24
	nNS7xGxsMuRkvMvzYPOt4/Tgn83fDU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725394444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEa8DGwuxSDKAR+JZn2UiA/g9QBLB1MPuZqYFJvQ9NM=;
	b=MYielTBNZeLxSO4k6lDFZGQsCDoRMt6v5WPQZ+3FBW9quxiQ74nssZxwTslnijNWmwbEnT
	Nl+EjFQQ5l/IrrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72716139D5;
	Tue,  3 Sep 2024 20:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eb/CGwxu12bsPgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Sep 2024 20:14:04 +0000
Date: Tue, 3 Sep 2024 22:13:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_folio_end_all_writers()
Message-ID: <20240903201358.GL26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <60a56967e6ebbeb47726c31883a6d453abc561c8.1725002293.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a56967e6ebbeb47726c31883a6d453abc561c8.1725002293.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 8A0831F46E
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 30, 2024 at 04:48:20PM +0930, Qu Wenruo wrote:
> The function btrfs_folio_end_all_writers() is only utilized in
> extent_writepage() as a way to unlock all subpage range (for both
> successful submission and error handling).
> 
> Meanwhile we have a similar function, btrfs_folio_end_writer_lock().
> 
> The difference is, btrfs_folio_end_writer_lock() expects a range that is
> a subset of the already locked range.
> 
> This limit on btrfs_folio_end_writer_lock() is a little overkilled,
> preventing it from being utilized for error paths.
> 
> So here we enhance btrfs_folio_end_writer_lock() to accept a superset of
> the locked range, and only end the locked subset.
> This means we can replace btrfs_folio_end_all_writers() with
> btrfs_folio_end_writer_lock() instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

I'm like 50% sure I see what's going on here, the patch has been in
linux-next and we need to merge it to for-next this week.


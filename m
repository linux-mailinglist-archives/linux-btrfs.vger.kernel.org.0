Return-Path: <linux-btrfs+bounces-13891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D88AB3D00
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8F4178CC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F00A2475CF;
	Mon, 12 May 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6GYvmPr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6/hXYjI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oeHxExuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8qeau+aZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC78B216E1B
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066156; cv=none; b=eW6Of11mWkrjwlU15m9OTw7XzXUz0cOIMVkKifQuAs+2Ozx6MtwfUdyfNVGt4q3pwT7eu/zepxYTueuITggIa8Lnraiob45SEXqaItmBc65LNNoHOTMQMRtZcrfdtTKRRjka3qYfu5Roct4Z4vUJ0bphkOsuN3a/0dIq3oX8ko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066156; c=relaxed/simple;
	bh=zIcmsddQT8i41yAekTfBaP/L4YFdEutw0j29GMFl0TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9MQDKoNN/37yUoh/F1wLZKK24TxHaevpZb/0LV1EAyOKwl4wBDKUS7m3vEnsnW+SPH4mp0/qrS1LnlRVVZRRLXGTQHEMCT97objFi7hQ+j7RmVakjv0918D9HJYdCb3XOi5rBcMa7Fw/otFKrJDrQ9EWZsBbRIp/N8SYBZQBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6GYvmPr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W6/hXYjI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oeHxExuj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8qeau+aZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 668F821157;
	Mon, 12 May 2025 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747066151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8Pq7qcrsaGWPnyv+0gXfz+SVV7JUy0qnotaJZ7rZ88=;
	b=y6GYvmPrBJ3FJGqoyeHtBkk3hin6DDIH9rsFzgtvMqf5gNKzdTTTeBopwcCMoF8MH1LqLI
	M4DH0ORA8HQaeHjE52TiN/cvD1CoRKthUe2utkR5s69vCIB72RX3L1FRJVU9KVphg6ofYI
	lzUrRG1Y4KMaQGwv5P9MmEgxHZtFVU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747066151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8Pq7qcrsaGWPnyv+0gXfz+SVV7JUy0qnotaJZ7rZ88=;
	b=W6/hXYjIQFZhaCFtw7j/J9F0QOp6dN+piz5maBVEpTJsHVrBrwa9Y1CFXXzLm55xpVQLDg
	LcNgbTOX1WVxOoDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oeHxExuj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8qeau+aZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747066150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8Pq7qcrsaGWPnyv+0gXfz+SVV7JUy0qnotaJZ7rZ88=;
	b=oeHxExujjwUJcXLQvPRUA8hLwkqvxWzIt8oVuKhodne/gtuMvfh7roz5RLxBv8t2HjtLGX
	dt9un3/IV7rdtLatj9rhDIcCT/rip93enGPwzwspNpNVfzQGVSi1QWuExggBeHAH0ch4Yu
	/xeiKJKfgKOa33B6K1OzpyqdT0DtFzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747066150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8Pq7qcrsaGWPnyv+0gXfz+SVV7JUy0qnotaJZ7rZ88=;
	b=8qeau+aZst9YIXYDpNoFf46fgwrpjheOliOS9ydyQs4WvPhaB7bFttIZP+FuhZsgwzSzyh
	iyxnA+7qV+9DghDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4329F1397F;
	Mon, 12 May 2025 16:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FpkzECYdImhDXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 16:09:10 +0000
Date: Mon, 12 May 2025 18:09:09 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Daniel Vacek <neelx@suse.com>, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fdmanana@kernel.org
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
Message-ID: <20250512160909.GN9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
 <20250512145939.GL9140@twin.jikos.cz>
 <CAPjX3Ff+XrWHJq_cBPUaK5memR3eMh-xpCeR7rk3uOa3yPE8Mg@mail.gmail.com>
 <20250512155256.GM9140@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512155256.GM9140@twin.jikos.cz>
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
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 668F821157
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: 0.79

On Mon, May 12, 2025 at 05:52:56PM +0200, David Sterba wrote:
> On Mon, May 12, 2025 at 05:07:12PM +0200, Daniel Vacek wrote:
> > On Mon, 12 May 2025 at 16:59, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Tue, May 06, 2025 at 09:47:32AM -0700, Boris Burkov wrote:
> > > > @@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
> > > >       return eb;
> > > >  }
> > > >
> > > > +/*
> > > > + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> > > > + * does not call folio_put(), and we need to set the folios to NULL so that
> > > > + * btrfs_release_extent_buffer() will not detach them a second time.
> > > > + */
> > > > +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> > > > +{
> > > > +     int num_folios = num_extent_folios(eb);
> > > > +
> > > > +     for (int i = 0; i < num_folios; i++) {
> > >
> > > You can use num_extent_folios() directly without the temporary variable,
> > > see bd06bce1b387c5 ("btrfs: use num_extent_folios() in for loop bounds")
> > 
> > Not if the loop does eb->folios[0] = NULL; We've been there and had to
> > actually change it this way.
> > 
> > Using num_extent_folios() directly is a bug here.
> 
> Ok then it needs a comment before somebody will want to clean it up.

Also this makes num_extent_folios() a bit dangerous when the eb->folios
change in the loop, not what I expected when the __pure attribute was
added. In case this introdues more subtle bugs we'll probably have to
revert it.


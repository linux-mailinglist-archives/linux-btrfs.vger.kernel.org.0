Return-Path: <linux-btrfs+bounces-1946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC7843678
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 07:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2C11F25254
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 06:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A863EA92;
	Wed, 31 Jan 2024 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0zTVtWd0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VnXuxaQK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0zTVtWd0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VnXuxaQK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D33EA67
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706681615; cv=none; b=C8fG3sbaAAO8xZN9JnJGGpoSdQrv+PMHn7PvoFW6S7AgS4DcNP6XvqF2Iq0b32LfFcm25BQMSS4ktQTkdMagPo080KffDXjy9TNbgOTA6wlEc5i2QqQ/3uz/jrMvJF6qiFLqL5pYO2IWOyMSty3+uhwfhnOj6Gw/WOIv4sp6ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706681615; c=relaxed/simple;
	bh=NtaPvoK7Gh78fT0gCvwdrv12vCU8GMZqwgbtPWb01QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG51v0Xz5/7VBBzyNj+0qEgb09YAb0R83j/FHD63mRiLi6S8VFsPtcFtDDtvHAOh2lSGowG5m7FAEgr7G2iwSoT9IdDtV0bKlOWJABC2SxQ2MWTQS/aEKhAOwwo34hDVu2maH/X4qyAflqoFbrFTDSE1N4BF0l6pI7cXvWOnDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0zTVtWd0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VnXuxaQK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0zTVtWd0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VnXuxaQK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCE2B1FB54;
	Wed, 31 Jan 2024 06:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706681611;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDED8bseYJr0vztAj/G9EM4BLn6ZU8B1s+bpisJ5nVY=;
	b=0zTVtWd0OhO9/1FPqGh393WKu6zK1r87BOOR1jhJcyFGNIipxLDtkZLpzZf+N69CLQCbWB
	TZHuCyyWNTUyUf8sdi1LPx+FGkgEAgMPlIFqbV4rj8zwzbNhCr63MpYiX/hQpvK7gM12Ua
	5uAl94Pcad6Vb2oekvZLygIu4jjbXsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706681611;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDED8bseYJr0vztAj/G9EM4BLn6ZU8B1s+bpisJ5nVY=;
	b=VnXuxaQKoCasTS1iPCMo8I8Cg6zyMcNPoG27ATimMkruE9420qJ60qH3tzQGA/oLEXks2A
	e7FrKYWroAALCsDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706681611;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDED8bseYJr0vztAj/G9EM4BLn6ZU8B1s+bpisJ5nVY=;
	b=0zTVtWd0OhO9/1FPqGh393WKu6zK1r87BOOR1jhJcyFGNIipxLDtkZLpzZf+N69CLQCbWB
	TZHuCyyWNTUyUf8sdi1LPx+FGkgEAgMPlIFqbV4rj8zwzbNhCr63MpYiX/hQpvK7gM12Ua
	5uAl94Pcad6Vb2oekvZLygIu4jjbXsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706681611;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDED8bseYJr0vztAj/G9EM4BLn6ZU8B1s+bpisJ5nVY=;
	b=VnXuxaQKoCasTS1iPCMo8I8Cg6zyMcNPoG27ATimMkruE9420qJ60qH3tzQGA/oLEXks2A
	e7FrKYWroAALCsDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A053D139D9;
	Wed, 31 Jan 2024 06:13:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wD73JgvluWVyfAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 06:13:31 +0000
Date: Wed, 31 Jan 2024 07:13:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 0/3] page to folio conversion
Message-ID: <20240131061302.GF31555@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706037337.git.rgoldwyn@suse.com>
 <20240129080442.GV31555@twin.jikos.cz>
 <CAEg-Je8L1B0JHmmcir5GpThPqACpLXm13sT6v2yS4pV_4Ty+0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je8L1B0JHmmcir5GpThPqACpLXm13sT6v2yS4pV_4Ty+0g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0zTVtWd0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VnXuxaQK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[27.79%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: BCE2B1FB54
X-Spam-Flag: NO

On Wed, Jan 31, 2024 at 04:29:36AM +0000, Neal Gompa wrote:
> On Mon, Jan 29, 2024 at 8:05 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Jan 23, 2024 at 01:28:04PM -0600, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > >
> > > These patches transform some page usage to folio. All references and data
> > > of page/folio is within the scope of the function changed.
> > >
> > > Changes since v1:
> > > Review comments -
> > >   * Added WARN_ON(folio_order(folio)) to ensure future development knows
> > >     this code assumes folio_size(folio) == PAGE_SIZE
> > >   * namespace restoration: prefix variable names with folio_
> > >   * Line adjustments
> > >
> > > Goldwyn Rodrigues (3):
> > >   btrfs: page to folio conversion: prealloc_file_extent_cluster()
> > >   btrfs: convert relocate_one_page() to relocate_one_folio()
> > >   btrfs: page to folio conversion in put_file_data()
> >
> > The conversion looks straightforward like we've been doing elsewhere,
> > however the CI is still not in a shape to validate arm + subpage, I've
> > seen the hosts not pass with various sets of patches (removed potential
> > breakage and keeping potential fixes).
> >
> > There are more folio conversions coming so I'd like to get them all in
> > so we can switch to the big folios eventually but without the CI
> > verification of subpage it's a bit risky.
> >
> 
> Wait, we don't? I thought Josef had specifically added Fedora Asahi
> runners specifically for subpage testing[1]?

Yes, but we don't have yet a stable testing base with all-pass results
on all configuration and with quirks disabling unreliable tests. There
are crashes reported with various sets of patches that are likely
caused by folio changes but it's hard to narrow down which ones.


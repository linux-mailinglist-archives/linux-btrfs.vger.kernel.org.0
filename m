Return-Path: <linux-btrfs+bounces-3607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0AD88C6CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4401C63B12
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161B13C833;
	Tue, 26 Mar 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lc/RpHIY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UNmr/YOY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lc/RpHIY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UNmr/YOY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC392757FD
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466674; cv=none; b=iWEMVcCmVrSPVGqiNKR/OH7u/PeoNWGzhT5StkJeriIIL+G8Ei3iKd26XWfJuuHkL0Ck8jmWAwLZDwtZVf4WGws1yCrw1NMnqhwwL94hPY0ZLO4hKmfvccY249hDn5krlauWAcC2VWz0uUr1+gKj5zRX7/p1KIkZhdk97R906Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466674; c=relaxed/simple;
	bh=OFUZvXyGhejhQpjFOOr/1b9zWb0ss4GxxfBkggOgqbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSrbv29cMuQQTEfmyyxqcCPILnwAhBrVSEZ1jRg6p6Sk1/VnB8B2iMU97mO1j6+kcgSsQ/BvgAFuWb8IlO8yHMj3dE/C5Pjj2fXAZtjmNhndSJzD2unv/1A9J+GFe9zdUKLOPaUVGZd5mO3ZF2zLyNBwdLOYhzkX54Yirpw579w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lc/RpHIY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UNmr/YOY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lc/RpHIY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UNmr/YOY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32B4937D51;
	Tue, 26 Mar 2024 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711466671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqYWy6hh2Qe3AYcN3CCfvqQ0NsQrUCBZsGqwrlTuQu0=;
	b=lc/RpHIYiBr3+5ZMz2cONohTZdzppnZTmSXIjFnP0XO/LiJlOVWreLXWE6XeEEwlRt7cQe
	1GS0n3X5o6GjSaD/DMS5lk14WIyFmDzRklzQMjknDVkbYz9MCFgW3RK7lPQyHaewC2kKub
	IHmPYoTzxiHE85VZGDHtecvCOjbmcpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711466671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqYWy6hh2Qe3AYcN3CCfvqQ0NsQrUCBZsGqwrlTuQu0=;
	b=UNmr/YOYA+9AC2PEBx1z6+J2wPTCm1W5s5GbleN3vngKXfwz99+F12miX7euc8ZMh44tKU
	717AfD3hgsiklyDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711466671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqYWy6hh2Qe3AYcN3CCfvqQ0NsQrUCBZsGqwrlTuQu0=;
	b=lc/RpHIYiBr3+5ZMz2cONohTZdzppnZTmSXIjFnP0XO/LiJlOVWreLXWE6XeEEwlRt7cQe
	1GS0n3X5o6GjSaD/DMS5lk14WIyFmDzRklzQMjknDVkbYz9MCFgW3RK7lPQyHaewC2kKub
	IHmPYoTzxiHE85VZGDHtecvCOjbmcpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711466671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqYWy6hh2Qe3AYcN3CCfvqQ0NsQrUCBZsGqwrlTuQu0=;
	b=UNmr/YOYA+9AC2PEBx1z6+J2wPTCm1W5s5GbleN3vngKXfwz99+F12miX7euc8ZMh44tKU
	717AfD3hgsiklyDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1660113587;
	Tue, 26 Mar 2024 15:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gndPBa/oAmbhVAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 26 Mar 2024 15:24:31 +0000
Date: Tue, 26 Mar 2024 16:17:13 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 0/3] page to folio conversion
Message-ID: <20240326151712.GS14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706037337.git.rgoldwyn@suse.com>
 <20240129080442.GV31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129080442.GV31555@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.01
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.86%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Mon, Jan 29, 2024 at 09:04:42AM +0100, David Sterba wrote:
> On Tue, Jan 23, 2024 at 01:28:04PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > These patches transform some page usage to folio. All references and data
> > of page/folio is within the scope of the function changed.
> > 
> > Changes since v1:
> > Review comments - 
> >   * Added WARN_ON(folio_order(folio)) to ensure future development knows
> >     this code assumes folio_size(folio) == PAGE_SIZE
> >   * namespace restoration: prefix variable names with folio_
> >   * Line adjustments
> > 
> > Goldwyn Rodrigues (3):
> >   btrfs: page to folio conversion: prealloc_file_extent_cluster()
> >   btrfs: convert relocate_one_page() to relocate_one_folio()
> >   btrfs: page to folio conversion in put_file_data()
> 
> The conversion looks straightforward like we've been doing elsewhere,
> however the CI is still not in a shape to validate arm + subpage, I've
> seen the hosts not pass with various sets of patches (removed potential
> breakage and keeping potential fixes).
> 
> There are more folio conversions coming so I'd like to get them all in
> so we can switch to the big folios eventually but without the CI
> verification of subpage it's a bit risky.

The patches have been in my misc-next (and in linux-next), no problems
reported so far. The extent buffer problems have been fixed so folios
can changes can be added again. As this patches is 2 months old I've
moved it to for-next with some code style fixups and changelog updates.


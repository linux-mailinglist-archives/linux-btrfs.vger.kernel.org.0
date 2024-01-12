Return-Path: <linux-btrfs+bounces-1414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F28782C2B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 16:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCCB1F23502
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB96EB50;
	Fri, 12 Jan 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ksq33r8t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tx9hDkmr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ksq33r8t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tx9hDkmr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD46BB5C
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DF5121F31;
	Fri, 12 Jan 2024 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705073214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2hm8Vr8tMeXNYWkJsT0rfWwPm3refIBIQz0YiKgEu4=;
	b=ksq33r8tDNUGCKa/DuC8GZUS3cYl5xz5E+YziPC+y/xq30fA6HctPzGInUco4NfIx04YOV
	XRHsgDTikmelfqSfKOgmc6RVcDIzaDmei8jqm02Y2H23Uuqc9sDDVjoOlALjvZKryZtyg6
	eZ3+NWB1dPpM0J3ofuKB/BqWm6Pa8PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705073214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2hm8Vr8tMeXNYWkJsT0rfWwPm3refIBIQz0YiKgEu4=;
	b=Tx9hDkmrU/i/sLxpisn3ijIL2d1D5CH62B+g4EA5HrWUyASeoj6/8uU8ykF9Y81bwWrCRK
	pesy885WDhFMpbBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705073214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2hm8Vr8tMeXNYWkJsT0rfWwPm3refIBIQz0YiKgEu4=;
	b=ksq33r8tDNUGCKa/DuC8GZUS3cYl5xz5E+YziPC+y/xq30fA6HctPzGInUco4NfIx04YOV
	XRHsgDTikmelfqSfKOgmc6RVcDIzaDmei8jqm02Y2H23Uuqc9sDDVjoOlALjvZKryZtyg6
	eZ3+NWB1dPpM0J3ofuKB/BqWm6Pa8PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705073214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2hm8Vr8tMeXNYWkJsT0rfWwPm3refIBIQz0YiKgEu4=;
	b=Tx9hDkmrU/i/sLxpisn3ijIL2d1D5CH62B+g4EA5HrWUyASeoj6/8uU8ykF9Y81bwWrCRK
	pesy885WDhFMpbBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 50401139D7;
	Fri, 12 Jan 2024 15:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GhT2ET5aoWXqHQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 12 Jan 2024 15:26:54 +0000
Date: Fri, 12 Jan 2024 16:26:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: Re: [PATCH] btrfs: page to folio conversion in
 btrfs_truncate_block()
Message-ID: <20240112152638.GO31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cn7d3gijpqxtmlytcv4ztac3eb7ukd54co4csitaw6czn6bfxr@3wopycxp755q>
 <20240111182516.GM31555@twin.jikos.cz>
 <rdvzhdajctrwzyualrppin2hxj2bt6wijgmp3njp74iw6us72y@ry2lxh6wkwtc>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rdvzhdajctrwzyualrppin2hxj2bt6wijgmp3njp74iw6us72y@ry2lxh6wkwtc>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.01
X-Spamd-Result: default: False [-5.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[51.51%]
X-Spam-Flag: NO

On Fri, Jan 12, 2024 at 06:05:42AM -0600, Goldwyn Rodrigues wrote:
> On 19:40 11/01, David Sterba wrote:
> > On Wed, Jan 10, 2024 at 07:56:13PM -0600, Goldwyn Rodrigues wrote:
> > > Convert use of struct page to struct folio inside btrfs_truncate_block().
> > > The only page based function is set_page_extent_mapped(). All other
> > > functions have folio equivalents.
> > > 
> > > Had to use __filemap_get_folio() because filemap_grab_folio() does not
> > > allow passing allocation mask as a parameter.
> > > 
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > 
> > There are some overly long lines, I can fix that unless you'd like to
> > commit the patch yourself.
> 
> Yes, you can fix them. I will wait for Josef's docs to start committing
> myself.

Ok, added to for-next.


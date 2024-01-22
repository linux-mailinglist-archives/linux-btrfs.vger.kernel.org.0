Return-Path: <linux-btrfs+bounces-1613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F983746D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D981F23283
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3D481AD;
	Mon, 22 Jan 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ggeTKuiJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="URVBrMg0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1S/T3XT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YURQ7C1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED347A40
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956324; cv=none; b=FXaaht/eEFxyVxVGzSFj3pnYd6vubH8AXgEgH1Xdr0JuufjXGuz2OLpZCZDY5X/HjiUkwg5Li39KcTPLkNAmqKidoCxOkRSQojeBldhH77R4BlaEBjYrRp4HlVLpMmOpNmb4PX8Bm8Ux68TMg3k465QKUTENKha8kHr+P6KBK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956324; c=relaxed/simple;
	bh=GDk0lDdDpl8RQaiviAZu39b8YGFiFXpwLaUfbevn0nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoWdLsVaQglMfHP9KN2gjfU1Au0kb7dPvEXp2ws4JmzbP5HEM86Ux/TaKzuUCkgim3C+4aNMzid14sM+sM4/IWZ/t+hmlwKn5vTSbdOtimtplC1xZGBe/R9CXJIg64P/QiRXEycN3p7Ya5B8sUHUH3Sju4Jo05Qlr7I2lijlM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ggeTKuiJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=URVBrMg0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1S/T3XT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YURQ7C1m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B437421F62;
	Mon, 22 Jan 2024 20:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956320;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z31TjBmtAxBEBDYHm1wBuriB/k7B9sgRTohki+SfhWQ=;
	b=ggeTKuiJZAOl3bXmK2COl2Mj6omvyrRhUoDprINVPIhweej2775uapskKDy9KdaMt60d8n
	FgzsXuA6iyjVHVfhX0qTN7pVIzxX4Rt0bVcsahN1nQdaa9uuHPFxCOBlZhnJWA/jRi1D6w
	OGhIR0/yElYnOm5/u3xore9dRsyfRiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956320;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z31TjBmtAxBEBDYHm1wBuriB/k7B9sgRTohki+SfhWQ=;
	b=URVBrMg0NIHWtKUfoFnyw7HugLqAebdbQu3V9jNHVj4RbjQyHjxCw2dAtQLo4Xi6OzDfsV
	v63TYBpH2qtpiWCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956319;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z31TjBmtAxBEBDYHm1wBuriB/k7B9sgRTohki+SfhWQ=;
	b=v1S/T3XTZBpUrzeIWUYOZ3sPBWfTljoWvBRKUq/FIcjesTZSHv5G5yNUyjgWJGuGWkbyFt
	2u7rNau8v6hdukb/OI4dZ87DsQ+svU0TGdUynSaEbrX676NefLWDfmN/cx28Af96bOh0wD
	1WK/VeHQEkab3tOogT8YUjmZ/328f/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956319;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z31TjBmtAxBEBDYHm1wBuriB/k7B9sgRTohki+SfhWQ=;
	b=YURQ7C1m+QNCSjwhJ3F8auK6B3+qakv6v9gWHJEY389TmuZw9YRANQ8dc0RA8pufOFwWc8
	Q98OxUSyAVCYRBAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A44D613310;
	Mon, 22 Jan 2024 20:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 83TDJ9/TrmV0ewAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 20:45:19 +0000
Date: Mon, 22 Jan 2024 21:44:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/4] btrfs: page to folio conversion:
 prealloc_file_extent_cluster()
Message-ID: <20240122204458.GX31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <55f236028fe97c2119ad8aa51cc6e5fe0cb04d0b.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f236028fe97c2119ad8aa51cc6e5fe0cb04d0b.1705605787.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="v1S/T3XT";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YURQ7C1m
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.22 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.51%]
X-Spam-Score: -1.22
X-Rspamd-Queue-Id: B437421F62
X-Spam-Flag: NO

On Thu, Jan 18, 2024 at 01:46:38PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Convert usage of page to folio in prealloc_file_extent_cluster(). This converts
> all page-based function calls to folio-based.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>


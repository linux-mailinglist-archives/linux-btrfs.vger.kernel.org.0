Return-Path: <linux-btrfs+bounces-13785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D053AADF72
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED661BC4B6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6909280319;
	Wed,  7 May 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G49xcCPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+aM7uV/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G49xcCPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+aM7uV/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5438280010
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621806; cv=none; b=OXOTi3V03IuSi9dOF+gmJcG8UuxsUTjuYU77wxNmCoTlrW3WUD02ilzo2JAn5t5N85gtgZIKhMwQX2HFQ/2uwtUxl///lSRnsYBGWXCH4wv5ZYvyn/JW1dySqmG4cs1bKuWaUizT45OKcftWiFM0at6jpZa8o22wCnicNBle59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621806; c=relaxed/simple;
	bh=Jh7ppQVGS2zPm+OYaM+dtZNb0pZ8S7BvWa5QYfNSdKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma2yQLgIVVefHaP1p8rRl0FkugBtTVARjJrXMw13id1G0cPYMdGcAROUBR6VZC33Jp6CgIOMa5AWZfOrWqVzcsSBeJqsRZeT/6mogioYh2dk9sSh5QLKRR/sGWZc8YDL+FHUEpWdiTFWNp4V/sbLSpLTVHTOhdcXaU2XDTg8axM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G49xcCPx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+aM7uV/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G49xcCPx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+aM7uV/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBF7A1F394;
	Wed,  7 May 2025 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746621802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Np014JMWsug6VDUnPXLhSGre5ID36rype2ECZNFtuR0=;
	b=G49xcCPxiA+v1H7dw6gOOmLeksF1ZTvj+ctYgBCW8A4X3DpprngnDA864O6eV/pfJfMhED
	Zhc5bWszorwpoTKbK4D0kXUB0rQ9Qbvh/9gQ+8wvaVw6A2wUo7CkWtHjxcV/VRaeGQHjzP
	mSVmFOEwYX5Iy4HW16PgSXvcMK5ydUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746621802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Np014JMWsug6VDUnPXLhSGre5ID36rype2ECZNFtuR0=;
	b=F+aM7uV/fiJ9gCpnu+ToZwzcNVeeVlu2OuH2XLZ8vMEwcb0dB5tw38i3mTx7/4FGhksM4D
	5ED6VSf1RZW0mXAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G49xcCPx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="F+aM7uV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746621802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Np014JMWsug6VDUnPXLhSGre5ID36rype2ECZNFtuR0=;
	b=G49xcCPxiA+v1H7dw6gOOmLeksF1ZTvj+ctYgBCW8A4X3DpprngnDA864O6eV/pfJfMhED
	Zhc5bWszorwpoTKbK4D0kXUB0rQ9Qbvh/9gQ+8wvaVw6A2wUo7CkWtHjxcV/VRaeGQHjzP
	mSVmFOEwYX5Iy4HW16PgSXvcMK5ydUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746621802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Np014JMWsug6VDUnPXLhSGre5ID36rype2ECZNFtuR0=;
	b=F+aM7uV/fiJ9gCpnu+ToZwzcNVeeVlu2OuH2XLZ8vMEwcb0dB5tw38i3mTx7/4FGhksM4D
	5ED6VSf1RZW0mXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E81139D9;
	Wed,  7 May 2025 12:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NnHkI2pVG2iXNgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 May 2025 12:43:22 +0000
Date: Wed, 7 May 2025 14:43:21 +0200
From: David Sterba <dsterba@suse.cz>
To: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	qat-linux <qat-linux@intel.com>, "embg@meta.com" <embg@meta.com>,
	"Collet, Yann" <cyan@meta.com>,
	"Will, Brian" <brian.will@intel.com>,
	"Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20250507124321.GF9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BBF7A1F394
X-Spam-Flag: NO
X-Spam-Score: -3.21
X-Spam-Level: 
X-Spamd-Result: default: False [-3.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Action: no action

On Tue, May 06, 2025 at 04:38:11PM +0100, Cabiddu, Giovanni wrote:
> Hi David,
> 
> I've resumed work on this, now that I have all necessary dependencies to
> offload ZSTD to QAT.
> 
> On Mon, Apr 29, 2024 at 04:41:29PM +0100, David Sterba wrote:
> ...
> > I'd skip the style and implementation details for now. The absence of
> > compression level support seems like the biggest problem, also in
> > combination with uncondtional use of the acomp interface.
> Regarding compression levels, Herbert suggested a new interface that
> would effectively address this concern [1].

It seems to be sufficient for passing the level from filesystem to
crypto layer.

One thing I'm not sure is considered is that zstd has different
requirements for workspace size depending on the level. In btrfs this is
done in zstd_calc_ws_mem_sizes().

> > We'd have to enhance the compression format specifier to make it
> > configurable in the sense: if accelerator is available use it, otherwise
> > do CPU and synchronous compression.
> For usability, wouldn't it be better to have a transparent solution? If
> an accelerator is present, use it, rather than having a configuration
> knob.
> 
> In any case, I would like to understand the best way forward here. I
> would like to offload both zlib_deflate and ZSTD. However, I wouldn't
> like to replicate the logic that calls the acomp APIs in both
> fs/btrfs/zlib.c and fs/btrfs/zstd.c.

This looks doable, acomp_comp_pages() from your patch could work for
both, the only difference is the parameter to crypto_alloc_acomp() and
eventually the level.

Otherwise, how to go forward with that. I think we'd need to get a few
iterations staring from what you have, with added support for the levels
and then we'll remove/replace the problematic parts like the numerous
allocations.

As the first step, please send an update with the acomp levels added to
zlib callbacks, so it works in normal conditons with all the
allocations.

We'll need to move repeatedly used structures to the workspaces so that
will be the second step. Once we settle on someting reasonable we can
extend it and add zstd support.


Return-Path: <linux-btrfs+bounces-19427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB7C9358D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 02:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923693A9363
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 01:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E018619CD05;
	Sat, 29 Nov 2025 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fm04iEpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Pt7R3+T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fm04iEpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Pt7R3+T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83239405F7
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Nov 2025 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764378539; cv=none; b=kcGZtIb9BdPS+kFz0RA+YsdMJI2aUzoTS8C6WvlRzmSn50ghFGQMfw8sKefFWMrI2mV4mHp5eWHn19+crxIVRZ5b0w/XtbkHNiLJm/ZhTi2wUFP4HS6+O3FKDayutu5aj6nenISTPewBzeOOnI3lxYOT/n/KgCo4cKM1JwiwKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764378539; c=relaxed/simple;
	bh=Or9GakIldhJCoifMt0p7QzNLYjKANIRXOYqHcZWLiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUilz+NKUXkwOsfMBkywpVyzU4x+28v03r/KC99eDbFRNvNmEM3uKXEBlavBlCl3CJxU9C4p1NrdcAV+hokCsBg+4LsFnzayx3fVwV0p4mNQrGcxjf+mouSp/R++L3nYfiZuKtSoeh/dk3DL5jy/cxZIJkTKI+6G9+hPnPEyRj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fm04iEpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Pt7R3+T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fm04iEpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Pt7R3+T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B74443368F;
	Sat, 29 Nov 2025 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764378535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYYg2ILVf747ZTr7u01AUot7xiOAhPCbCGrg8sKzk0w=;
	b=fm04iEpuOBjvT5uBfjEHhrN33hMC14kpfAkV+bsgqbeCWlCQGZIkDvvTSBx9hrGFp+7qxP
	z98g0QGt23GmD5MXoezX4iR+IpJctVbkWBr/MqPTKR4+WpOiRYj+5mjrHBWlGKg/2wuoh0
	SpOhEjOcJ7ti0QzT1M/IfMUaYqAJ/hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764378535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYYg2ILVf747ZTr7u01AUot7xiOAhPCbCGrg8sKzk0w=;
	b=7Pt7R3+TSVvicbXgYq9gymR6nbX8Ac7KNA2dE5BFhW10D0CeoPmepH1E4pI1qTjQ+qzD2t
	p3KG+ae9L5WrTrAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764378535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYYg2ILVf747ZTr7u01AUot7xiOAhPCbCGrg8sKzk0w=;
	b=fm04iEpuOBjvT5uBfjEHhrN33hMC14kpfAkV+bsgqbeCWlCQGZIkDvvTSBx9hrGFp+7qxP
	z98g0QGt23GmD5MXoezX4iR+IpJctVbkWBr/MqPTKR4+WpOiRYj+5mjrHBWlGKg/2wuoh0
	SpOhEjOcJ7ti0QzT1M/IfMUaYqAJ/hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764378535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYYg2ILVf747ZTr7u01AUot7xiOAhPCbCGrg8sKzk0w=;
	b=7Pt7R3+TSVvicbXgYq9gymR6nbX8Ac7KNA2dE5BFhW10D0CeoPmepH1E4pI1qTjQ+qzD2t
	p3KG+ae9L5WrTrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94C5A3EA63;
	Sat, 29 Nov 2025 01:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DliZI6dHKmm2JwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 29 Nov 2025 01:08:55 +0000
Date: Sat, 29 Nov 2025 02:08:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Qu Wenruo <wqu@suse.com>, clm@fb.com, dsterba@suse.com, terrelln@fb.com,
	herbert@gondor.apana.org.au, linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org, qat-linux@intel.com, cyan@meta.com,
	brian.will@intel.com, weigang.li@intel.com,
	senozhatsky@chromium.org
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <20251129010854.GF13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Fri, Nov 28, 2025 at 10:40:33PM +0000, Giovanni Cabiddu wrote:
> On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
> > 在 2025/11/29 05:35, Giovanni Cabiddu 写道:
> > > Add support for hardware-accelerated compression using the acomp API in
> > > the crypto framework, enabling offload of zlib and zstd compression to
> > > hardware accelerators. Hardware offload reduces CPU load during
> > > compression, improving performance.
> > > 
> > > The implementation follows a generic design that works with any acomp
> > > implementation, though this enablement targets Intel QAT devices
> > > (similarly to what done in EROFS).
> > > 
> > > Input folios are organized into a scatter-gather list and submitted to
> > > the accelerator in a single asynchronous request. The calling thread
> > > sleeps while the hardware performs compression, freeing the CPU for
> > > other tasks.  Upon completion, the acomp callback wakes the thread to
> > > continue processing.
> > > 
> > > Offload is supported for:
> > >    - zlib: compression and decompression
> > >    - zstd: compression only
> > > 
> > > Offload is only attempted when the data size exceeds a minimum threshold,
> > > ensuring that small operations remain efficient by avoiding hardware setup
> > > overhead. All required buffers are pre-allocated in the workspace to
> > > eliminate allocations in the data path.
> > > 
> > > This feature maintains full compatibility with the existing BTRFS disk
> > > format. Files compressed by hardware can be decompressed by software
> > > implementations and vice versa.
> > > 
> > > The feature is wrapped in CONFIG_BTRFS_EXPERIMENTAL and can be enabled
> > > at runtime via the sysfs parameter /sys/fs/btrfs/<UUID>/offload_compress.
> > 
> > Not an compression/crypto expert, thus just comment on the btrfs part.
> > 
> > sysfs is not a good long-term solution. Since it's already behind
> > experiemental flags, you can just enable it unconditionally (with proper
> > checks of-course).
> The reason for introducing a sysfs attribute is to allow disabling the
> feature to be able to unload the QAT driver or to assign a QAT device to
> user space for example to QATlib or DPDK.
> 
> In the initial implementation, there was no sysfs switch because the
> acomp tfm was allocated in the data path. With the current design,
> where the tfm is allocated in the workspace, the driver remains
> permanently in use.
> 
> Is there any other alternative to a sysfs attribute to dynamically
> enable/disable this feature?

At least for the duration of the experimental phase the sysfs is the
right interface for enabing/disabling the QAT support.

In the long term I'd still recommend sysfs, this is easily accessible by
scripts unlike alternative way of ioctl. I don't know about other
reasonable options for that, certainly not a mount option.


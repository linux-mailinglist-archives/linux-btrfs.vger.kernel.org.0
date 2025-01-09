Return-Path: <linux-btrfs+bounces-10876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0693A07F61
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE630169945
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650AF194A60;
	Thu,  9 Jan 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1D7lDuW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uJHfKmNd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1D7lDuW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uJHfKmNd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92D19047F
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445254; cv=none; b=dgJX3EwKJ8MiWPfYb4X4miHk3GqT2IjwC9wk4z2pjtBOncC9bE1K/lLYhNBbDmb/F/2qkpLbsH0fTr91ZS9bV1z3IrgCRYcGtqt1SeLQIA0Dj7FN5hvYizLkwarNeLS0jIxpUc5RCI27r3qwbyYO08KgxO/ANkVa3D6iTRW4hR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445254; c=relaxed/simple;
	bh=JytGjsKm1DGiqXsTM8V/YLlxLFFf4I0y7FIR/esoF9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIv19lEnmFiIhD40EOUGMrjyDSv2t86Lt+MtdLcB/nIKZIBo3twuJuV5csC66+dKeIf7GCRKMXBVLCnIXM2zAjjvpO8kjchHY7N8NqmbvMikIqyEvPM2Uh0HpvTV85V6CJFVOAOLJLARmShfOfMJNDZgzEOuyQiH+uUxsWxlIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1D7lDuW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uJHfKmNd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1D7lDuW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uJHfKmNd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C5392115C;
	Thu,  9 Jan 2025 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736445247;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooIcttySaAlk6Rsyg6kvLC6xlsqhqXD6kG+2wPN2Vzw=;
	b=O1D7lDuWYAAk5nydxSpqJ0PYiTQ8h9mPo9IDc2xE9O3+AGvPOLOPAXOY7hnBGpJczSdgzq
	McVpRRMcLImzQF84FxtySrjVRI1mr1bJDjiSbWNA9cm309zH1ADQtzfk+3b0chSSPULOmn
	FQb8f1yOZ1y7hbFlICg5R84vmBF/sN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736445247;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooIcttySaAlk6Rsyg6kvLC6xlsqhqXD6kG+2wPN2Vzw=;
	b=uJHfKmNdjyeTMp6iimSlM/leBSeRMU9DSJWv/BjPWN57vfAPNr/sbEdFhe905S9hHbR2h7
	Ge9WWmjeBTE4ZAAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736445247;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooIcttySaAlk6Rsyg6kvLC6xlsqhqXD6kG+2wPN2Vzw=;
	b=O1D7lDuWYAAk5nydxSpqJ0PYiTQ8h9mPo9IDc2xE9O3+AGvPOLOPAXOY7hnBGpJczSdgzq
	McVpRRMcLImzQF84FxtySrjVRI1mr1bJDjiSbWNA9cm309zH1ADQtzfk+3b0chSSPULOmn
	FQb8f1yOZ1y7hbFlICg5R84vmBF/sN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736445247;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooIcttySaAlk6Rsyg6kvLC6xlsqhqXD6kG+2wPN2Vzw=;
	b=uJHfKmNdjyeTMp6iimSlM/leBSeRMU9DSJWv/BjPWN57vfAPNr/sbEdFhe905S9hHbR2h7
	Ge9WWmjeBTE4ZAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55A2713876;
	Thu,  9 Jan 2025 17:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3A2qFD8NgGfxHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 Jan 2025 17:54:07 +0000
Date: Thu, 9 Jan 2025 18:54:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Jing Xia <j.xia@samsung.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: Re: Re: Re: [PATCH] fs/btrfs: Pass write-hint for buffered IO
Message-ID: <20250109175405.GH2097@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240920055208.29635-1-j.xia@samsung.com>
 <CGME20241115030334epcas5p3e8a335a111b09c1296ff7dc67b5413e7@epcas5p3.samsung.com>
 <20241115030512.3319144-1-j.xia@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115030512.3319144-1-j.xia@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Nov 15, 2024 at 11:05:12AM +0800, Jing Xia wrote:
> > > On Tue, Sep 03, 2024 at 01:40:12PM +0800, j.xia wrote:
> > > > Commit 449813515d3e ("block, fs: Restore the per-bio/request data
> > > > lifetime fields") restored write-hint support in btrfs. But that is
> > > > applicable only for direct IO. This patch supports passing
> > > > write-hint for buffered IO from btrfs file system to block layer
> > > > by filling bi_write_hint of struct bio in alloc_new_bio().
> > > 
> > > What's the status of the write hints? The commit chain is revert,
> >   
> >   "enum rw_hint" include/linux/rw_hint.h defines the status.
> > 
> > > removal and mentioning that NVMe does not make use of the write hint so
> > > what hardware is using it?
> > 
> >   New NVMe Flexible Data Placement (FDP) SSD (TP4146) is able to 
> >   use hint to place data in different streams. 
> >   The related patch is
> >   Link: https://lore.kernel.org/all/20240910150200.6589-6-joshi.k@samsung.com
> > 
> > > 
> > > The patch is probably ok as it passes the information from inode to bio,
> > > otherwise btrfs does not make any use of it, we have heuristics around
> > > extent size, not the expected write lifetime expectancy.
> > 
> 
> 
> fcntl() interface can be used to set/get write life time hints.
> Now the write hint can be passed from inode->i_write_hint to
> bio->bi_write_hint for direct IO. This patch completes this
> feature for buffered IO.

FYI, I'm merging this to Btrfs for 6.14. I've talked to Johannes,
there seems to be a use case for RocksDB at least that can set the
temperatures and code-wise it's trivial change. The status of device
support is still ongoing. Given the hint is only passed by the
filesystem it's up to the application to use it properly.


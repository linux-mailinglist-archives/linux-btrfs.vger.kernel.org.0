Return-Path: <linux-btrfs+bounces-7116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4F94EBBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 13:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E17C1F2231E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C51741FA;
	Mon, 12 Aug 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c+zQGBRX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvOxM4nG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c+zQGBRX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvOxM4nG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92702130495
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461827; cv=none; b=m87ex6MupeDqh7/efe/5bO0cq219ks5SjZhioist1924QC6xntwnOMD7vWN8Q4n5xbHQWveesorUclCSoCquXcSgE0GsgGpmN8LG3OulmStNfGkRJqGWpxMzfyJAEbvZ5SogjJTo24Pq+LA/cg7W6BZ2ktjzKy2b3M85b9S+csk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461827; c=relaxed/simple;
	bh=WJOVGwPc2bmDarDQBuTsJFbT9jJMgtPAvzGeafD1sHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4Ub6jGAG5BL6V4aqQXVVdEUV3Vx3Kt9ySzdbjegVjTLe1Gdq4rtYi8J07Le+jVzPjO/6A0qTl/taeWTtmUh8CZt01unqSE7tZfrb3M93Pj8NHYVwr+xMIcn1Py2X3OmGktnuugdoKLtcy0kUBHW1ObyvKFDiEshQt6X0oaojIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c+zQGBRX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvOxM4nG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c+zQGBRX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvOxM4nG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E75122516;
	Mon, 12 Aug 2024 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723461823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agXbP0s7mlI3oV0H30+A5MdwEC8kQnfU3/VcyRJPzTU=;
	b=c+zQGBRXcekRvhF57D+Td+jVggg2v80vH5CcPD+u0ys4k2Q81VG/bpak5FqJ40KJYMzQBi
	87W+sE8CzaKeT4iact632Cy7qh1GxbCZV9BkOVGfnLfUDChpSxPf9Ir1V6nAPXcs6H92gK
	kXVD2BADCHAmdpteUM+jE2mhDdoBtEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723461823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agXbP0s7mlI3oV0H30+A5MdwEC8kQnfU3/VcyRJPzTU=;
	b=hvOxM4nGCUKjblrjmpkOzEDU0kxyGDfc08lpkmi2i11R1OgB7yUYLFB7NyDKmGiW/9Voh6
	GM19y1gtGpQbLICA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c+zQGBRX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hvOxM4nG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723461823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agXbP0s7mlI3oV0H30+A5MdwEC8kQnfU3/VcyRJPzTU=;
	b=c+zQGBRXcekRvhF57D+Td+jVggg2v80vH5CcPD+u0ys4k2Q81VG/bpak5FqJ40KJYMzQBi
	87W+sE8CzaKeT4iact632Cy7qh1GxbCZV9BkOVGfnLfUDChpSxPf9Ir1V6nAPXcs6H92gK
	kXVD2BADCHAmdpteUM+jE2mhDdoBtEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723461823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agXbP0s7mlI3oV0H30+A5MdwEC8kQnfU3/VcyRJPzTU=;
	b=hvOxM4nGCUKjblrjmpkOzEDU0kxyGDfc08lpkmi2i11R1OgB7yUYLFB7NyDKmGiW/9Voh6
	GM19y1gtGpQbLICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 424C5137BA;
	Mon, 12 Aug 2024 11:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5XixD7/wuWbSUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 Aug 2024 11:23:43 +0000
Date: Mon, 12 Aug 2024 13:23:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@meta.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add io_uring interface for encoded reads
Message-ID: <20240812112342.GE25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240809173552.929988-1-maharmstone@fb.com>
 <20240809183418.GC25962@twin.jikos.cz>
 <879d0861-9a67-4e02-b6ec-60f2c6c6cb40@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <879d0861-9a67-4e02-b6ec-60f2c6c6cb40@meta.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5E75122516
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 09:20:19AM +0000, Mark Harmstone wrote:
> On 9/8/24 19:34, David Sterba wrote:
> > Where is the CAP_SYS_ADMIN check done? It's not in this patch so I
> > assume it's somewhere in io_uring but I don't see it. Thanks.
> 
> It still gets done in btrfs_ioctl_encoded_read, which gets called by 
> io_uring in a task with the process context.

Oh of course. The io_uring wrapper is simple so the check does not have
to be lifted from the function.


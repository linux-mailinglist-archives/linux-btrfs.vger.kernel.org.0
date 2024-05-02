Return-Path: <linux-btrfs+bounces-4673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC38B9D0C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318EF1F21B1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F40159912;
	Thu,  2 May 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="af6R4eUa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiANHri3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="af6R4eUa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiANHri3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535B1552EE
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662495; cv=none; b=ZRvEo+m6pnFONU0NXn0Of4esM4p/la8FLf8q4EERhRYJATJTptwXsirVFeic7ikNx5RGIbMG1DcAzNwsGuME8uWE5A3nnjbdr15h074QKth4TeFgOr+9DWD84SEyPfCc0uibUFRssQinmik9nHSjk+tIaymOxbBJjHVGUWAEwgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662495; c=relaxed/simple;
	bh=mP9zlwalgNTQLSgcU3zTlVbbKgcP0ceDQ+CEfsemkg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGfgcOySVV+no0fPskwPgwXY4r34OonLX3U4N9NmAFpvSeF7TyQUWOWOLhGAKNEhxxn83zS37GSm8nJWQQ6xFpwKS+nQNZwz6nh5zbO2ypm3EW0kGNIcO4gqXghlaMFnKPfyl55XSRGWhetN6og+NaM1BrBJe+hht5ABfxEbWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=af6R4eUa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiANHri3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=af6R4eUa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiANHri3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1B1B371EA;
	Thu,  2 May 2024 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714662491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5E8yNd9DvbiWMpWreJURCUoJWVtz1iWuzEKMtqe9ck=;
	b=af6R4eUaG2Yjo9yENRtAjCeKywWOQQKZOINJHGLbII7RfaC2g7ATQW4oCc2Bi5ICNIver7
	0BEz2JoOli0joXhrjqh770ZjKQqbsUV+40+2aM7jo8Sobf3lw0HLBpxPWUvy82O85wjKat
	ayk3WEp34EoMXpcdzwRGIRwfOFSLFv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714662491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5E8yNd9DvbiWMpWreJURCUoJWVtz1iWuzEKMtqe9ck=;
	b=uiANHri3s6eBVLXbXTto1A/jn9IbblH0NilJkd1FkZaADhXYchjnKiDddxK3xCNZ/hsiJY
	XRSGh0W/XnfteFDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714662491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5E8yNd9DvbiWMpWreJURCUoJWVtz1iWuzEKMtqe9ck=;
	b=af6R4eUaG2Yjo9yENRtAjCeKywWOQQKZOINJHGLbII7RfaC2g7ATQW4oCc2Bi5ICNIver7
	0BEz2JoOli0joXhrjqh770ZjKQqbsUV+40+2aM7jo8Sobf3lw0HLBpxPWUvy82O85wjKat
	ayk3WEp34EoMXpcdzwRGIRwfOFSLFv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714662491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5E8yNd9DvbiWMpWreJURCUoJWVtz1iWuzEKMtqe9ck=;
	b=uiANHri3s6eBVLXbXTto1A/jn9IbblH0NilJkd1FkZaADhXYchjnKiDddxK3xCNZ/hsiJY
	XRSGh0W/XnfteFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE20F1386E;
	Thu,  2 May 2024 15:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mE47LlusM2a6cQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 May 2024 15:08:11 +0000
Date: Thu, 2 May 2024 17:00:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240502150056.GR2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain>
 <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 01, 2024 at 07:35:09AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/30 20:29, David Sterba 写道:
> > On Tue, Apr 30, 2024 at 07:35:11AM +0930, Qu Wenruo wrote:
> >>
> >>
> >> 在 2024/4/30 02:01, David Sterba 写道:
> >>> On Mon, Apr 29, 2024 at 06:13:33AM -0700, Boris Burkov wrote:
> >>>> I support the auto deletion in the kernel as you propose, I think it
> >>>> just makes sense. Who wants stale, empty qgroups around that aren't
> >>>> attached to any subvol? I suppose that with the drop_thresh thing, it is
> >>>> possible some parent qgroup still reflects the usage until the next full
> >>>> scan?
> >>>
> >>> The stale qgroups have been out for a long time so removing them after
> >>> subvolume deletion is changing default behaviour, this always breaks
> >>> somebody's scripts or tools.
> >>
> >> If needed I can introduce a compat bit (the first one), to tell the
> >> behavior difference.
> >>
> >> And if we go the compat bit way, I believe it can be the first example
> >> on how to do a kernel behavior change correctly without breaking any
> >> user space assumption.
> >
> > I don't see how a compat bit would work here, we use them for feature
> > compatibility and for general access to data (full or read-only). What
> > we do with individual behavioral changes are sysfs files. They're
> > detectable by scripts and can be also used for configuration. In this
> > case enabling/disabling autoclean of the qgroups.
> 
> I mean the compat bit, which is fully empty now.

Which compat bit and in which structure? What I mean is the super block
incompat/compat bits but what you described below does not match it.

> The new bit would be something like BTRFS_QGROUP_AUTO_REMOVAL, with that
> set, btrfs would auto remove any stale qgroups (for regular qgroups though).
> 
> Without that, it would be as usual (no auto removal).


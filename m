Return-Path: <linux-btrfs+bounces-8857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B2E99A843
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 17:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F551C22B7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C719F105;
	Fri, 11 Oct 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d5qfUiLA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LT8BECbB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d5qfUiLA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LT8BECbB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F219E985
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661685; cv=none; b=R2HV4tEVrNBhtoGucHuNJzbMN8vIHw1tQ9dO+tJ6L3s3YTYwsU0neHvWwk17wH9YWhwKFCgqiXQEZK+hvmSa07SmoiaxCZaHj7zNOe4aFjIxqfAtuYzkfKm0VdJO0Ll8yQi90iHt1bnbtOWPNvCr05SrGxlLpZKSzPBWMRdFA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661685; c=relaxed/simple;
	bh=CLPnFqp68XBLGpWMW0lZonNWX8pGLxkVrDTaG247Qd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6/WnaGJxa7zQxO2MdIG5r+W6SJyTpIhFuf8/DM90kx/ppJe2uETHL9ByhJrhRZGZOJjz+dghCg4NOtBwRegPcNb9Rgc8DGurNEp+MYP+PNeIIysvE6MIpEfveW5EfOq6iCC/As0l0xuqNceUKl9mJ3BBpdY8iEu1CrvUQKoUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d5qfUiLA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LT8BECbB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d5qfUiLA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LT8BECbB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D35321EE2;
	Fri, 11 Oct 2024 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728661681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3aLvkXbp031TuRJ8A9jT7UiyPMU+2PdhO7EgbBaLks=;
	b=d5qfUiLA7CyEntRkDj51ZmoGICalL3VGcECfeRiZAS+snEKh3KSb1dzpSR0kQ75UqNDcDi
	nSpQOZozuPPFEsOxXjEqM46S/iXnAXhoHZHH73krciuCN/DWymR0d/n/NyFzYBPSqYvE9p
	QNt35YxmZY4zTmQG4whPqKMWBWBMa9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728661681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3aLvkXbp031TuRJ8A9jT7UiyPMU+2PdhO7EgbBaLks=;
	b=LT8BECbBpsys/Pt4T7XrH6Wd1Ho2tNLG4hvCvzOFNdOwv30FjRHNf/WeFHivSv40QOjY86
	FIk3PaKPYoEVsKBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728661681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3aLvkXbp031TuRJ8A9jT7UiyPMU+2PdhO7EgbBaLks=;
	b=d5qfUiLA7CyEntRkDj51ZmoGICalL3VGcECfeRiZAS+snEKh3KSb1dzpSR0kQ75UqNDcDi
	nSpQOZozuPPFEsOxXjEqM46S/iXnAXhoHZHH73krciuCN/DWymR0d/n/NyFzYBPSqYvE9p
	QNt35YxmZY4zTmQG4whPqKMWBWBMa9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728661681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3aLvkXbp031TuRJ8A9jT7UiyPMU+2PdhO7EgbBaLks=;
	b=LT8BECbBpsys/Pt4T7XrH6Wd1Ho2tNLG4hvCvzOFNdOwv30FjRHNf/WeFHivSv40QOjY86
	FIk3PaKPYoEVsKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67C2B1370C;
	Fri, 11 Oct 2024 15:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tpTQGLFICWdfLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Oct 2024 15:48:01 +0000
Date: Fri, 11 Oct 2024 17:48:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Yuwei Han <hrx@bupt.moe>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [RFC] New ioctl to query deleted subvolumes
Message-ID: <20241011154800.GW1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241009180300.GN1609@twin.jikos.cz>
 <308CF1DDC38EE68A+91e40dff-783f-43f4-9e49-a5cd4fa0b7a8@bupt.moe>
 <20241010170841.GR1609@twin.jikos.cz>
 <E2F46BD92527EA46+29cb502c-a5ee-48db-a439-ab692a3747b9@bupt.moe>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2F46BD92527EA46+29cb502c-a5ee-48db-a439-ab692a3747b9@bupt.moe>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Oct 11, 2024 at 08:06:00PM +0800, Yuwei Han wrote:
> > So the ioctl mode is there to emulate that, for the common case of "wait
> > for all subvolumes currently queued for deletion".

> There is a misunderstanding. What I mean is that why users need to 
> "confirm" subvol is deleted? I can't come up with actual usage. Hope you 
> can help me with that.

Ok so the question is why to do it all, I think Roman answered it
quite well. As deleted subvolume can free some space, waiting until
cleaning is done is the right time to check 'df'.


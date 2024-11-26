Return-Path: <linux-btrfs+bounces-9916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C09D9AA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06160284702
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA241D63F7;
	Tue, 26 Nov 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e5p+Jy1S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQNPLa3H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e5p+Jy1S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQNPLa3H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F91C9B7A
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636240; cv=none; b=pqTBa8SSUApGlt3OXFi8wgFePlCe5cB/Vd/O7OMyeKNsiUAjpZWHFGym6h3gI6zCiP/Co3VFrkgXPU5hBHt/ZTe8/VfiYhs1KFgnrANqmmaQ4kNszpvcYh6hZz82bHEe4p1Ba2unEn0oD9fhLUkj9EDu0nXvCovPZ2W4gS8cT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636240; c=relaxed/simple;
	bh=tZPGpXQVbPfpG1Z1TOnw+qj1IOlMMvTjANdHUugXlVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US2tO1Gf60a74cSLc+2Dz95q7i9OjBbWZOnjF/sxFA+m8Gyn0ChBgto5DPtf83f8M2TC3hTf7O3w5pwRo91OLgRyGG4EntJm6Of2rplzm60qtr3uECEEHgmELVu1KMUyCAq8NdqWJEG3xQ/TnMA6R1q3ujTDh0JQhxxLllpO6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e5p+Jy1S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQNPLa3H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e5p+Jy1S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQNPLa3H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4023B2117A;
	Tue, 26 Nov 2024 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732636235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdi+nLXtYAIr8QfVvDbTOWgLW8FFwJcTJ7mmI6g4/Qw=;
	b=e5p+Jy1SYAZnWqJv0hmYZcsX0FJ/N0oWhkc3O9BI/59fmFXr3giC7bsE34x56l0eJjdCAT
	Zk6laPUHuatYOOZa9mYdnNdZjKA4BnD/K+WuOabiSOZ0nLCTbrbTTnAXcniBGwX3tIq61Z
	+6Rvx8GZNQglBVYbAWpPKsES5mENYjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732636235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdi+nLXtYAIr8QfVvDbTOWgLW8FFwJcTJ7mmI6g4/Qw=;
	b=HQNPLa3H9i/Qs88ewyAtmiidEmlNh0R1D3ddsdB9Olf3u5L32D3Lj1tgIKUel0OD3SwWiA
	AwODH+irZnOUF4CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e5p+Jy1S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HQNPLa3H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732636235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdi+nLXtYAIr8QfVvDbTOWgLW8FFwJcTJ7mmI6g4/Qw=;
	b=e5p+Jy1SYAZnWqJv0hmYZcsX0FJ/N0oWhkc3O9BI/59fmFXr3giC7bsE34x56l0eJjdCAT
	Zk6laPUHuatYOOZa9mYdnNdZjKA4BnD/K+WuOabiSOZ0nLCTbrbTTnAXcniBGwX3tIq61Z
	+6Rvx8GZNQglBVYbAWpPKsES5mENYjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732636235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdi+nLXtYAIr8QfVvDbTOWgLW8FFwJcTJ7mmI6g4/Qw=;
	b=HQNPLa3H9i/Qs88ewyAtmiidEmlNh0R1D3ddsdB9Olf3u5L32D3Lj1tgIKUel0OD3SwWiA
	AwODH+irZnOUF4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21A7613890;
	Tue, 26 Nov 2024 15:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7IbtB0vuRWdgFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 15:50:35 +0000
Date: Tue, 26 Nov 2024 16:50:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fixes for the new fd-based API
Message-ID: <20241126155029.GI31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1730249396.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730249396.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4023B2117A
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Oct 30, 2024 at 11:25:46AM +1030, Qu Wenruo wrote:
> There are two critical bugs, all introduced by the same new fd-based
> mount API migration.
> 
> The first one will break the per-subvolume RW/RO mount, if using the
> new fd-based mount API.
> This is caused by the untrue promise that the new API will not set the
> RO flag for the fsconfig() call (which sets the super flags), but only
> set RO attribute for the mount point.
> 
> Based on the bad promise, we skip the RO->RW reconfiguration for the new
> API based mount call. But since the new fd-based mount is already
> rolling out to the end users, and it still sets RO flags for both super
> and mount point.
> 
> So we should still do the same RO->RW reconfiguration, no matter the
> API.
> 
> 
> The second one is a long existing problem related the RO->RW
> reconfiguration itself, where we retry without any lock, resulting race
> between reconfiguration and RO/RW mounts.
> 
> This will leads to a failure to mount, exposed by SLE-micro bug report.
> 
> 
> Those two bugs are all small but critical to the core function of btrfs,
> thus should be queued for -rc kernels.
> 
> Qu Wenruo (2):
>   btrfs: fix per-subvolume RO/RW flags with new mount API
>   btrfs: fix mount failure due to remount races

For the record, the first patch got merged to 6.12 and I've not added
the second one to for-next, targeting some 6.13-rc. 


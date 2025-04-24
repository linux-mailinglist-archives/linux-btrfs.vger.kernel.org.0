Return-Path: <linux-btrfs+bounces-13359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE71A9A107
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 08:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B54D1946231
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3481D90AD;
	Thu, 24 Apr 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIXaHmHc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/qxUy4pU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIXaHmHc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/qxUy4pU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44066198A11
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475013; cv=none; b=INLYetygPQcEZJex/2CLpx+Q4my0WFTiggD2KbaETVQXwUlvZS93nNv4Vox2Og4m2hK6YEb2DPNWLnu2XceHQiotEG0elhcmv8lZAwWvNMsERmU5RQYuI2udoKu8ZyLtcBvJDxLVxp8Fx49iDb99icsunPkMIS7JvTnyHvXMCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475013; c=relaxed/simple;
	bh=PDDCx0TepA4GPCm4upLa2SWgdkicN+y7Bhe/TOCfzLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK1cG8huMWgfQoVqYoKrp59vWk2El6//SjGu6FnNiUntyF5E79KFFmNHigZgTA3smv07wikLZd5CcQEhpS+Fuu15ceFVBmXclC4TLLIqGVwtFsk5DEIMAwAAjpkp6nz9S2qptoS9EJ7g93s9/7MmhLFquCfvFvoJqo3zm+SDgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIXaHmHc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/qxUy4pU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIXaHmHc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/qxUy4pU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D0351F38E;
	Thu, 24 Apr 2025 06:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745475009;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZu0O3h6RIJSGLY1vYyljpaXFZCR9VxIslFvgbnF/D4=;
	b=lIXaHmHc2ECNSiagqJ9QDZ05rewcs7VWVkGDggEQBm8b3pFHwu8+kUpHIGx1FKuY4vK1yM
	sSTtEkNvujVmVxTdNXVpgMJVfL7JATkhCOYkFUyBbx+i9YZLpt3D66zGMBfs3S9BCZz35f
	gFtGkqPsiPJVtKT4xfe76Fh5HDIuyYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745475009;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZu0O3h6RIJSGLY1vYyljpaXFZCR9VxIslFvgbnF/D4=;
	b=/qxUy4pULGZJLkAUsJVEOcSOlLZds66fODe9ERPj2bCCo/NkH5YgnVMhQqCpcPPIlsV/xn
	Azzny0hOHcxB/IBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745475009;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZu0O3h6RIJSGLY1vYyljpaXFZCR9VxIslFvgbnF/D4=;
	b=lIXaHmHc2ECNSiagqJ9QDZ05rewcs7VWVkGDggEQBm8b3pFHwu8+kUpHIGx1FKuY4vK1yM
	sSTtEkNvujVmVxTdNXVpgMJVfL7JATkhCOYkFUyBbx+i9YZLpt3D66zGMBfs3S9BCZz35f
	gFtGkqPsiPJVtKT4xfe76Fh5HDIuyYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745475009;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZu0O3h6RIJSGLY1vYyljpaXFZCR9VxIslFvgbnF/D4=;
	b=/qxUy4pULGZJLkAUsJVEOcSOlLZds66fODe9ERPj2bCCo/NkH5YgnVMhQqCpcPPIlsV/xn
	Azzny0hOHcxB/IBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E385D1393C;
	Thu, 24 Apr 2025 06:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JGISN8DVCWigXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 24 Apr 2025 06:10:08 +0000
Date: Thu, 24 Apr 2025 08:09:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] Cleanups of blk_status_t use
Message-ID: <20250424060959.GI3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745422901.git.dsterba@suse.com>
 <1142ff0f-4296-4877-b8b6-1be2f78ff9ad@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1142ff0f-4296-4877-b8b6-1be2f78ff9ad@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 24, 2025 at 03:04:21PM +0930, Qu Wenruo wrote:
> 在 2025/4/24 01:27, David Sterba 写道:
> > Use the blk_status_t only for interaction with block layer API and
> > remove it from our functions. Do some naming unifications and minor
> > cleanups.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although I'm wondering if it's even possible to require a forced 
> compiler warning when using blk_status_t as other types and vice verse?

There already is forced type for the non-zero values

https://elixir.bootlin.com/linux/v6.14.3/source/include/linux/blk_types.h#L96
typedef u8 __bitwise blk_status_t;
typedef u16 blk_short_t;
#define	BLK_STS_OK 0
#define BLK_STS_NOTSUPP		((__force blk_status_t)1)
#define BLK_STS_TIMEOUT		((__force blk_status_t)2)
#define BLK_STS_NOSPC		((__force blk_status_t)3)
...

and from what I've seen there were no type mismatches.


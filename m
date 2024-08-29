Return-Path: <linux-btrfs+bounces-7661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07B9649F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24263B20D2A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612BD1B3758;
	Thu, 29 Aug 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5sWcG+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RuXgNkK4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5sWcG+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RuXgNkK4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7661B3725;
	Thu, 29 Aug 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945181; cv=none; b=bkHIgdE/eZjsgVUL7WTKP9zBXHxl5mUrp0n5eTZXI8NJ/8Zpi2MnZhiiuOssfhG4lH1bXLGgj+gzLjd6VdvNhG917pwZWLrNxojsKV7D+2UpX0CtmERAD0i1daiyltPvpVFpmvmFAcA09GTeVJs4oAKLyuq160UW1rysUI2At3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945181; c=relaxed/simple;
	bh=4AzVlidiVub3x1Wk1+N4GhpDYIF/K+dVA+RFHIp5jdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa7zBzBCe+3QhHTzZPx+YytwQOPyC2x7NS4SjqP2NcKOc1Vwwr+uwwUf0n+5Seqal3CNpUTQSCrBXRRSdPEPfh+AbAZz6QW0OOok9HFWN7jXav0UMGIMC3rED7T5xVwafTGpQ3MpX/OInFrh/wdXrSvjNPCYgIjvxLyq8fKPHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5sWcG+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RuXgNkK4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5sWcG+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RuXgNkK4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FFC921B9D;
	Thu, 29 Aug 2024 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724945171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo0JVSwVkkM7rFafROeru0QLUH+EphkuxjdhxvwSkPM=;
	b=P5sWcG+YOEHu551aRvlYlHHmaciNn2c1btSPKmULasifgntFs1XekjfS9oqmy1Bs44HfIk
	SrFINudVszLXTmBJ/TaQDVlOlPl2dptSydxePCv6FZAUi23C5You/T+VYLQ/fV/gaprWBr
	2JQqlEPUDA0ZeRNAz5ZRGRrLYMBXMWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724945171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo0JVSwVkkM7rFafROeru0QLUH+EphkuxjdhxvwSkPM=;
	b=RuXgNkK4S2U60Glryne5gpCzPDqRjPM64p+pcaBiwrkRkdb4BYPxtSAYqDLrpnPj+83gkf
	iL+ZEjtnub5z6eCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P5sWcG+Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RuXgNkK4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724945171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo0JVSwVkkM7rFafROeru0QLUH+EphkuxjdhxvwSkPM=;
	b=P5sWcG+YOEHu551aRvlYlHHmaciNn2c1btSPKmULasifgntFs1XekjfS9oqmy1Bs44HfIk
	SrFINudVszLXTmBJ/TaQDVlOlPl2dptSydxePCv6FZAUi23C5You/T+VYLQ/fV/gaprWBr
	2JQqlEPUDA0ZeRNAz5ZRGRrLYMBXMWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724945171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo0JVSwVkkM7rFafROeru0QLUH+EphkuxjdhxvwSkPM=;
	b=RuXgNkK4S2U60Glryne5gpCzPDqRjPM64p+pcaBiwrkRkdb4BYPxtSAYqDLrpnPj+83gkf
	iL+ZEjtnub5z6eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A50F139B0;
	Thu, 29 Aug 2024 15:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lg+hHROT0GZtaAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 15:26:11 +0000
Date: Thu, 29 Aug 2024 17:26:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
	quwenruo.btrfs@gmx.com, willy@infradead.org,
	dan.carpenter@linaro.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 00/14] btrfs: Cleaned up folio->page conversion
Message-ID: <20240829152610.GK25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240828182908.3735344-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828182908.3735344-1-lizetao1@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9FFC921B9D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,toxicpanda.com,suse.com,gmx.com,infradead.org,linaro.org,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Aug 29, 2024 at 02:28:54AM +0800, Li Zetao wrote:
> Hi all,
> 
> In btrfs, because there are some interfaces that do not use folio,
> there is page-folio-page mutual conversion. This patch set should
> clean up folio-page conversion as much as possible and use folio
> directly to reduce invalid conversions.
> 
> This patch set starts with the rectification of function parameters,
> using folio as parameters directly. And some of those functions have
> already been converted to folio internally, so this part has little
> impact. 
> 
> I have tested with fsstress more than 10 hours, and no problems were
> found. For the convenience of reviewing, I try my best to only modify
> a single interface in each patch.
> 
> Josef also worked on converting pages to folios, and this patch set was
> inspired by him[1].
> 
> Considering Josef's suggestion[2], this patchset has passed most of the
> xfs/btrfs use cases, include btrfs/060 and btrfs/069.
> 
> This patchset is based on commit bcdaf0fe6a52("btrfs: initialize
> last_extent_end to fix -Wmaybe-uninitialized warning in extent_fiemap()")
> 
> v1 -> v2:
>  * Change clear_page_extent_mapped() to clear_folio_extent_mapped()
>  * Fix a bug[3] when folio is valid and it should be unlocked and put
>  in copy_inline_to_page().

I've tested the series a few times and so far no problems, the changes
are straightforward. I'll add it to for-next soon. Thanks.


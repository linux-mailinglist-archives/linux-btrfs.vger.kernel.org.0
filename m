Return-Path: <linux-btrfs+bounces-13725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D94AAC5A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CB11C0488A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE8281363;
	Tue,  6 May 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIpoj2cL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="czMkkcc4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIpoj2cL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="czMkkcc4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0423D28F
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537558; cv=none; b=qYLBP0TNNw1sPFS6q+GXILdwtThUcFOLqvAHsxPpB/BKf5k2kTjLud3IkmWDXU0N7lxzifWjhzK4YYCBev1VPx6OhjIjKR5H9UESs/bBGObg+xxZw6xazBwUYTCdbzKjt/Kwnhpc6C8kKvhKmyCc4HcRVSgUcj8wHaBzP963HEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537558; c=relaxed/simple;
	bh=kIHdzZUWaPSLTucHGZ4qp7MHA4evJhh6qsl6uhhy/YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUSiXpBDQ9v9eMMSkB7/LLsLwEJsyU6aZpk06HjoO8vK8KHAOhIIPpy4RIvLkeoKlJzmQ2EoMO+PS13Ym5X26rtWmDy5SbJzCYeSaIwmk+Q6j9rXFKQXiTgXjgEh5EAEUek+RiDlszrczcTkrsRRtcLbMdCV4RKI8XqnfUyyYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hIpoj2cL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=czMkkcc4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hIpoj2cL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=czMkkcc4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FA29211BF;
	Tue,  6 May 2025 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746537555;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mabCLK1CTWLb6dTp8UKgjcLgS2EFRv+m63UaRzr+4k=;
	b=hIpoj2cLeneGAz9bfBIcqJ+ksPzEyQOlvl8h8g5NnAaq2xDQSSFsW7L0w5nGnUS2DQqDxd
	QQgcSGL4P9PLhJGjQwQ2XRuyv8s6fjKiBYSjs/siDQGjX5Zf8ZIpsu0Nw4Lt7/vQAr2iNt
	64xH40FSNDDezrY8xycVWBm6kd6d/fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746537555;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mabCLK1CTWLb6dTp8UKgjcLgS2EFRv+m63UaRzr+4k=;
	b=czMkkcc4aCrr9X5Mcd6OpopnaecCpIOpGEGePcxXfzuf68ozuhr+8ESODe1pIVcQcOQ7ni
	5t1SNzBos5altNAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746537555;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mabCLK1CTWLb6dTp8UKgjcLgS2EFRv+m63UaRzr+4k=;
	b=hIpoj2cLeneGAz9bfBIcqJ+ksPzEyQOlvl8h8g5NnAaq2xDQSSFsW7L0w5nGnUS2DQqDxd
	QQgcSGL4P9PLhJGjQwQ2XRuyv8s6fjKiBYSjs/siDQGjX5Zf8ZIpsu0Nw4Lt7/vQAr2iNt
	64xH40FSNDDezrY8xycVWBm6kd6d/fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746537555;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mabCLK1CTWLb6dTp8UKgjcLgS2EFRv+m63UaRzr+4k=;
	b=czMkkcc4aCrr9X5Mcd6OpopnaecCpIOpGEGePcxXfzuf68ozuhr+8ESODe1pIVcQcOQ7ni
	5t1SNzBos5altNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C6D8137CF;
	Tue,  6 May 2025 13:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ou1ZAlMMGmjwOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 May 2025 13:19:15 +0000
Date: Tue, 6 May 2025 15:19:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>, clm@fb.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 099/642] btrfs: prevent inline data extents
 read from touching blocks beyond its range
Message-ID: <20250506131913.GD9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-99-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505221419.2672473-99-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, May 05, 2025 at 06:05:15PM -0400, Sasha Levin wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> [ Upstream commit 1a5b5668d711d3d1ef447446beab920826decec3 ]
> 
> Currently reading an inline data extent will zero out the remaining
> range in the page.
> 
> This is not yet causing problems even for block size < page size
> (subpage) cases because:
> 
> 1) An inline data extent always starts at file offset 0
>    Meaning at page read, we always read the inline extent first, before
>    any other blocks in the page. Then later blocks are properly read out
>    and re-fill the zeroed out ranges.
> 
> 2) Currently btrfs will read out the whole page if a buffered write is
>    not page aligned
>    So a page is either fully uptodate at buffered write time (covers the
>    whole page), or we will read out the whole page first.
>    Meaning there is nothing to lose for such an inline extent read.
> 
> But it's still not ideal:
> 
> - We're zeroing out the page twice
>   Once done by read_inline_extent()/uncompress_inline(), once done by
>   btrfs_do_readpage() for ranges beyond i_size.
> 
> - We're touching blocks that don't belong to the inline extent
>   In the incoming patches, we can have a partial uptodate folio, of
>   which some dirty blocks can exist while the page is not fully uptodate:
> 
>   The page size is 16K and block size is 4K:
> 
>   0         4K        8K        12K        16K
>   |         |         |/////////|          |
> 
>   And range [8K, 12K) is dirtied by a buffered write, the remaining
>   blocks are not uptodate.
> 
>   If range [0, 4K) contains an inline data extent, and we try to read
>   the whole page, the current behavior will overwrite range [8K, 12K)
>   with zero and cause data loss.
> 
> So to make the behavior more consistent and in preparation for future
> changes, limit the inline data extents read to only zero out the range
> inside the first block, not the whole page.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is not a stable dependency and the patch is not fixing anything
but a preparation so this does not make much sense for stable backports,
please drop it. Thanks.


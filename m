Return-Path: <linux-btrfs+bounces-11903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E29A47BD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 12:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381411893BE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349122A7E6;
	Thu, 27 Feb 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlKegBS6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TZBRWKc1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SkbiUxID";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M6Q2qV23"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8722838F
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654973; cv=none; b=Iw+J8xbye4pbGYqToQNRDmlMTmk9XUQ2mCS1uisg5aSaQOHozZ1UVGVNKmW/ZY9oZFKKaadi5JdxKR2YDqkQwmZNvpjANTpH6LDJ8FHfJEnj5U4t6JVBbGQ71klSsFA/7he3g6Miae+MgpPEXnNIEDu2INZBkzC6ePiy9TbMjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654973; c=relaxed/simple;
	bh=tD/kW8Kg9yqK9nCSgHpL1I10iDyDFzeWZarZnK/i4wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF2bSLQuifPQLUOqjzLnW9LN7EJbQcSfofr378JbSvw4Gkvx9LcIGoqPGrE4XaEyGJZcjHInU0yPa0FwmkTE1MfQNWWtZ+/MJfDLMDpeGWWAnn9VdpKx2+qmhKOlllJBFVQs3xDSrs+NmFLHtevGqdrVrNJ8q6XzCSBXYsvTo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlKegBS6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TZBRWKc1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SkbiUxID; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M6Q2qV23; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEC771F38F;
	Thu, 27 Feb 2025 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740654969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjADxXTHfUakN2trXdG7rzMP9/Xfvz0dwTJk0PTFk88=;
	b=LlKegBS6kyqdGqMWuzpfGDP5XHLvqBRvYzOZhKmGtTai8AZMzDI/2J+GS+ycuBEeS6JyzG
	dmCZvbpwtdcE1b8WytbAWmD1IANzSIZCVqFqK5Dj4lR5j3nYoALC5It8aCCm+pzxmSw8xT
	NL/zfDOoPWDfvFZ2JuykcytiCNkCes0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740654969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjADxXTHfUakN2trXdG7rzMP9/Xfvz0dwTJk0PTFk88=;
	b=TZBRWKc1/oqhM0dtx+vI/0AtCPo2ehjPhi6dHDUgNCL0sQXz4iqgHKjH1ppIlX5PvITHv4
	hdeebLENUbvtpZBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SkbiUxID;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=M6Q2qV23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740654968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjADxXTHfUakN2trXdG7rzMP9/Xfvz0dwTJk0PTFk88=;
	b=SkbiUxIDAoZ+FR1FwsF4qtVxV1DIH9HI58gBz4q3RYw6IA3BHOhhVQrUl5kj7ELR4GjgMl
	9vXr128UryUMfAM2Ta8jgiwtFEXYe/S6lE1C45QNLA92z7Q/0iYe+PfdAGv1T29GPLmwcf
	Mo2BoRB+HmIqxgF6rcJPAbgAhkcomaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740654968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjADxXTHfUakN2trXdG7rzMP9/Xfvz0dwTJk0PTFk88=;
	b=M6Q2qV23exRPD88PwhFLf8zCTyuCXk7he1j2lh+hyfQqUveAUmUP391ESAGXCjKF0pB3Yr
	QPirRim/Wu1DK1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB26313888;
	Thu, 27 Feb 2025 11:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cttMNXhJwGd9NgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Feb 2025 11:16:08 +0000
Date: Thu, 27 Feb 2025 12:16:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] btrfs: make subpage handling be feature full
Message-ID: <20250227111603.GB5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740635497.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740635497.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: EEC771F38F
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Feb 27, 2025 at 04:24:38PM +1030, Qu Wenruo wrote:
> [CHANGLOG]
> v2:
> - Add a new bug fix which is exposed by recent 2K block size tests on
>   x86_64
>   It's a self deadlock where the folio_end_writeback() is called with
>   subpage lock hold, and folio_end_writeback() will eventually call
>   btrfs_release_folio() and try to lock the same spin lock.
> 
> Since the introduction of btrfs subapge support in v5.15, there are
> quite some limitations:
> 
> - No RAID56 support
>   Added in v5.19.
> 
> - No memory efficient scrub support
>   Added in v6.4.
> 
> - No block perfect compressed write support
>   Previously btrfs requires the dirty range to be fully page aligned, or
>   it will skip compression completely.
> 
>   Added in v6.13.
> 
> - Various subpage related error handling fixes
>   Added in v6.14.
> 
> - No support to create inline data extent
> - No partial uptodate page support
>   This is a long existing optimization supported by EXT4/XFS and
>   is required to pass generic/563 with subpage block size.
> 
> The last two are addressed in this patchset.

That's great, thank you very much. I think not all patches have a
reviewed-by tag but I'd like to get it to for-next very soon.  The next
is rc5 and we should have all features in. This also means the 2K
nodesize block so we can give it more testing.


Return-Path: <linux-btrfs+bounces-20303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189BDD06594
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 22:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571D7302BA6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC2532F751;
	Thu,  8 Jan 2026 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sk/2fIhL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lcpn8sNG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sk/2fIhL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lcpn8sNG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1C244660
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908426; cv=none; b=jTCKb2bVsx1TmxEFLMbB3vmT3eFu8XRJ3OnvQm99vl2MYc5iEg+V3taw3/JuqB86bEfpOrmR0vf/awFDsRpoRlkM+xLADsIM/LwGmSsbCH7Ft8L/glZH56dIkv1yjWKcBRuzModOyidLHOhZ4eaQq06DhSBVc/UOgVa1wJmh7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908426; c=relaxed/simple;
	bh=K+1VT1FdcpSJ3n1RjH3iap72KFX5gGqxhPwBFI55+U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYL3mMFA560R6UzUkoUBdZSQ0vvTfMkEofnHcF4mjtepn8OfeTwp6SSNICRXy6qYIfARxgg0TaeEf2XsMdVplW7bcrTrBo4FLIj/pMDS+H+eWnPfs4Ipo1hQyQ8uZAL74EHy06Z5Ay5uGzw95epcpdVQoQvVQSlvh41msUYvUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sk/2fIhL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lcpn8sNG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sk/2fIhL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lcpn8sNG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6333F34AFE;
	Thu,  8 Jan 2026 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767908423;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMTnF2xAq4vBy6j26sVEEaHn/c+fBFSZoOuhG8Lw1iI=;
	b=sk/2fIhL6VwNhQpIcpN89EE6gJxFlYYBXgtatmTO0lM/s2bVzRW1vEvmClXoMyXJV7bOQv
	GKlzaz+7DZX9b+aJDyAf9h+uHC672HKcbkm/RafeeOyBJgeENtWMMhsnymsBlVTWbvzGbO
	zVY//yZIQDwmhSX1sMMhlTMFsKR91N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767908423;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMTnF2xAq4vBy6j26sVEEaHn/c+fBFSZoOuhG8Lw1iI=;
	b=Lcpn8sNG9ZiHwFUBfqUJ/ZzAv97Hhh0iCGq1xBGJlRLYNJLeBRUbJ3+ZGI1/t2lcFQBeKP
	/N1Bx+F7xY9+DTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767908423;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMTnF2xAq4vBy6j26sVEEaHn/c+fBFSZoOuhG8Lw1iI=;
	b=sk/2fIhL6VwNhQpIcpN89EE6gJxFlYYBXgtatmTO0lM/s2bVzRW1vEvmClXoMyXJV7bOQv
	GKlzaz+7DZX9b+aJDyAf9h+uHC672HKcbkm/RafeeOyBJgeENtWMMhsnymsBlVTWbvzGbO
	zVY//yZIQDwmhSX1sMMhlTMFsKR91N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767908423;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMTnF2xAq4vBy6j26sVEEaHn/c+fBFSZoOuhG8Lw1iI=;
	b=Lcpn8sNG9ZiHwFUBfqUJ/ZzAv97Hhh0iCGq1xBGJlRLYNJLeBRUbJ3+ZGI1/t2lcFQBeKP
	/N1Bx+F7xY9+DTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B2F23EA63;
	Thu,  8 Jan 2026 21:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c8nsEUckYGnlZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 21:40:23 +0000
Date: Thu, 8 Jan 2026 22:40:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove offload csum mode
Message-ID: <20260108214022.GN21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <318d41265ab70ffc1220355b3396209d12b23373.1767845479.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318d41265ab70ffc1220355b3396209d12b23373.1767845479.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -7.99
X-Spamd-Result: default: False [-7.99 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,twin.jikos.cz:mid];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Jan 08, 2026 at 02:41:26PM +1030, Qu Wenruo wrote:
> The offload csum mode is introduced to allow developers to compare the
> performance of generating checksum for data writes at different timings:
> 
> - During btrfs_submit_chunk()
>   This is the most common one, if any of the following condition is met
>   we go this path:
> 
>   * The csum is fast
>     For now it's CRC32C and xxhash.
> 
>   * It's a synchronous write
> 
>   * Zoned
> 
> - Delay the checksum generation to a workqueue
> 
> However since commit dd57c78aec39 ("btrfs: introduce
> btrfs_bio::async_csum") we no longer need to bother any of them.
> 
> As if it's an experimental build, async checksum generation at the
> background will be faster anyway.
> 
> And if not an experimental build, we won't even have the offload csum
> mode support.
> 
> Considering the async csum will be the new default, let's remove the
> offload csum mode code.
> 
> There will be no impact to end users, and offload csum mode is still
> under experimental features.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
>  fs/btrfs/bio.c     |  5 -----
>  fs/btrfs/sysfs.c   | 44 --------------------------------------------
>  fs/btrfs/volumes.h |  3 ---

Please also remove the entry from Kconfig.


Return-Path: <linux-btrfs+bounces-19684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553CCB7C53
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 04:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6032E304809C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 03:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A172F7467;
	Fri, 12 Dec 2025 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iRDK9AST";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2sSIF3Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iRDK9AST";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2sSIF3Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022D2F6934
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509548; cv=none; b=YYA6h2n+wOcZZ9FrRLnkv0CbIkK2AHNZUQvot7AjU26aYBtjh5vC5StrDDOG3L4LIJpYxHd7SfxPa1Yqz3D6o1HvwMTpFI1n9C0wtS7sa8GBvQd28r7zSL5QZcCARnP5FDQxoaIfzfom3j+hn44nvq5JVfQrjLA3+SKtjXAnNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509548; c=relaxed/simple;
	bh=MSM7R6FtUiwahX69PmCFOOcgeLlnvrFA/j3RABho1PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtolCl80jzfwx1QId/MkaNOJLd+GPQ/+T7UnKWxazVTDtJsvnkpZbceGvaotUJIzx7N4q4IcYBY0kNfGoEByFIB+dz+htUMaXjZ1b92D9Et9XQMlUf4Ms12vlV5T5dJ1lsrPHnybF3sVn2WJ3omrTIMj7J86t9eEYDRTYrHOZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iRDK9AST; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2sSIF3Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iRDK9AST; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2sSIF3Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08D545BE52;
	Fri, 12 Dec 2025 03:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765509540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7VLHFp8jlG/cGrZ8qmMLeClBYPe9zCzM1ul2i1+/4=;
	b=iRDK9ASTntnpsh/7Y1Lu7fWtwlEkp4hQ0cPR99TJvVz1arb3VKqeJUJs85Y5wv63Xerzf8
	7WB/rRjQ5mn/SKbwseRcmyZSIkvY1Y5jwJhMdysPJMPcJGJ8gff1ZORTAWHaaEJpAZvxC5
	aMsZgc3WbRDuK1xrmgt8S9smhgPX4SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765509540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7VLHFp8jlG/cGrZ8qmMLeClBYPe9zCzM1ul2i1+/4=;
	b=G2sSIF3Z2YmO/0SRsOkYv4vk5xVed7SeGW3UtMutCp2DOUv8ou4AjiDDF24bmzmQyXye1D
	3Ra8K6910O7JQmBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765509540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7VLHFp8jlG/cGrZ8qmMLeClBYPe9zCzM1ul2i1+/4=;
	b=iRDK9ASTntnpsh/7Y1Lu7fWtwlEkp4hQ0cPR99TJvVz1arb3VKqeJUJs85Y5wv63Xerzf8
	7WB/rRjQ5mn/SKbwseRcmyZSIkvY1Y5jwJhMdysPJMPcJGJ8gff1ZORTAWHaaEJpAZvxC5
	aMsZgc3WbRDuK1xrmgt8S9smhgPX4SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765509540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7VLHFp8jlG/cGrZ8qmMLeClBYPe9zCzM1ul2i1+/4=;
	b=G2sSIF3Z2YmO/0SRsOkYv4vk5xVed7SeGW3UtMutCp2DOUv8ou4AjiDDF24bmzmQyXye1D
	3Ra8K6910O7JQmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D63AD3EA63;
	Fri, 12 Dec 2025 03:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7DgiNKOJO2mpawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 12 Dec 2025 03:18:59 +0000
Date: Fri, 12 Dec 2025 04:18:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: shrink the size of btrfs_bio
Message-ID: <20251212031854.GP4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0f25d1779166876e3bd4c1509d8eaf67968a6f65.1765229068.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f25d1779166876e3bd4c1509d8eaf67968a6f65.1765229068.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.95 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.15)[-0.769];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[wdc.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,twin.jikos.cz:mid,suse.cz:replyto];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.95

On Tue, Dec 09, 2025 at 07:55:03AM +1030, Qu Wenruo wrote:
> This is done by:
> 
> - Shrink the size of btrfs_bio::mirror_num
>   From 32 bits unsigned int to u16.
> 
>   Normally btrfs mirror number is either 0 (all profiles), 1 (all
>   profiles), 2 (DUP/RAID1/RAID10/RAID5), 3 (RAID1C3) or 4 (RAID1C4).
> 
>   But for RAID6 the mirror number can go as large as the number of
>   devices of that chunk.
> 
>   Currently the limit for number of devices for a data chunk is
>   BTRFS_MAX_DEVS(), which is around 500 for the default 16K nodesize.
>   And if going the max 64K nodesize, we can have a little over 2000
>   devices for a chunk.
> 
>   Although I'd argue it's way overkilled, we don't reject such cases yet
>   thus u8 is not going to cut it, and have to use u16 (max out at 64K).
> 
> - Use bit fields for boolean members
>   Although it's not always safe for racy call sites, those members are
>   safe.
> 
>   * csum_search_commit_root
>   * is_scrub
>     Those two are set immediately after bbio allocation and no more
>     writes after allocation, thus they are very safe.
> 
>   * async_csum
>   * can_use_append
>     Those two are set for each split range, and after that there is no
>     writes into those two members in different threads, thus they are
>     also safe.
> 
>   And there are spaces for 4 more bits before increasing the size of
>   btrfs_bio again, which should be future proof enough.
> 
> - Reorder the structure members
>   Now we always put the largest member first (after the huge 120 bytes
>   union), making it easier to fill any holes.
> 
> This reduce the size of btrfs_bio by 8 bytes, from 312 bytes to 304 bytes.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Change mirror number from u8 to u16
>   As for RAID6 we can have cases (that's beyond 255 devices in a RAID6
>   chunk) where u8 is not large enough.
>   Thankfully u16 is large enough for the max number of devices possible
>   for a RAID6 chunk.
> 
>   And we have exactly a one-byte hole the in structure, and expanding
>   the widith of @mirror_num will not increase the size of btrfs_bio.

Reviewed-by: David Sterba <dsterba@suse.com>


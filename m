Return-Path: <linux-btrfs+bounces-8085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9626497B2F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D76282CE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD7417B514;
	Tue, 17 Sep 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QjwzFnEa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nFZPvPkg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QjwzFnEa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nFZPvPkg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F41531CC;
	Tue, 17 Sep 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590315; cv=none; b=GiwkAfW4/WWa3ZJNY2kwQee061ONyPW4SwV6UwRVxKp4MVzvy8KRoMmJ+fqboi4avUta4/512VYP0D0NlrLnapEizlszQoKnZFpHmWC36wtStMTFWNi4EFXSfIO8DawYwEKHfKHUORMI79TbjWyqdSFh6c2F9nAgZ676tKAx1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590315; c=relaxed/simple;
	bh=Ydk70KHQM2/FHTUJos6S6apo0Pz30BpsQw+QGuDykS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcB9RvlZAHhRnvV93VeJyM5SrudX+5TEXO6LFthHkcTgyNEVngF5ERvRb5zyMA6mVvDGkTGy76IHxglioRo4v0ULAiNnvqkqjcel4j4E/+r0BTInIij1or3jNWOi4orgzu4C5lL4XGQ/W+Zo6D331yyyjd+Ht+nvCJ7fSraZOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QjwzFnEa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nFZPvPkg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QjwzFnEa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nFZPvPkg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 941D720109;
	Tue, 17 Sep 2024 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726590311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdKW6EkONv4i994oa6L4QX4PlRqTMJWx+W6mB/sTMJE=;
	b=QjwzFnEaK7LkkEKWG7ey9QEDFBRKc31wTDD5QShyD9jmzgzYST1fqJ80/3ebTrx/77Y99G
	CQqjCUDZFXXU0lB/cQStNTjr5XjQ9se5zGDfR3lp+VaHQ0O9yitMDyb0dfoA2pwuRbP7lL
	5maSvDalxascaMzhIRyTqdkzYPB7XhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726590311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdKW6EkONv4i994oa6L4QX4PlRqTMJWx+W6mB/sTMJE=;
	b=nFZPvPkgxvYhU0xP3KKcLTMOswgN9M6tdSoEh7wz4oLrVlKsyAVQkbkQeypmyKqrxKSD0H
	Qj7U5BWPj1rWHmDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726590311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdKW6EkONv4i994oa6L4QX4PlRqTMJWx+W6mB/sTMJE=;
	b=QjwzFnEaK7LkkEKWG7ey9QEDFBRKc31wTDD5QShyD9jmzgzYST1fqJ80/3ebTrx/77Y99G
	CQqjCUDZFXXU0lB/cQStNTjr5XjQ9se5zGDfR3lp+VaHQ0O9yitMDyb0dfoA2pwuRbP7lL
	5maSvDalxascaMzhIRyTqdkzYPB7XhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726590311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdKW6EkONv4i994oa6L4QX4PlRqTMJWx+W6mB/sTMJE=;
	b=nFZPvPkgxvYhU0xP3KKcLTMOswgN9M6tdSoEh7wz4oLrVlKsyAVQkbkQeypmyKqrxKSD0H
	Qj7U5BWPj1rWHmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74EB813AB6;
	Tue, 17 Sep 2024 16:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FSFXHGet6WZ+ZQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 16:25:11 +0000
Date: Tue, 17 Sep 2024 18:25:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] btrfs: Split remaining space to discard in chunks
Message-ID: <20240917162502.GD2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
 <20240916125707.127118-2-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916125707.127118-2-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 16, 2024 at 02:56:14PM +0200, Luca Stefani wrote:
> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
> mostly empty although we will do the split according to our super block
> locations, the last super block ends at 256G, we can submit a huge
> discard for the range [256G, 8T), causing a super large delay.
> 
> We now split the space left to discard based on BTRFS_MAX_DATA_CHUNK_SIZE
> in preparation of introduction of cancellation signals handling.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>  fs/btrfs/extent-tree.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..79b9243c9cd6 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1300,13 +1300,24 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>  		bytes_left = end - start;
>  	}
>  
> -	if (bytes_left) {
> +	while (bytes_left) {
> +		u64 bytes_to_discard = min(SZ_1G, bytes_left);

Please define a separate constant for that and also mention it in the
changelog instead of BTRFS_MAX_DATA_CHUNK_SIZE.

> +
>  		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					   bytes_left >> SECTOR_SHIFT,
> +					   bytes_to_discard >> SECTOR_SHIFT,
>  					   GFP_NOFS);
> -		if (!ret)
> -			*discarded_bytes += bytes_left;
> +
> +		if (ret) {
> +			if (ret != -EOPNOTSUPP)
> +				break;
> +			continue;
> +		}
> +
> +		start += bytes_to_discard;
> +		bytes_left -= bytes_to_discard;
> +		*discarded_bytes += bytes_to_discard;
>  	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.46.0
> 


Return-Path: <linux-btrfs+bounces-7801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408596A77F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2561C23A41
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E706192B67;
	Tue,  3 Sep 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tC957Bon";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZbOff63";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tC957Bon";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZbOff63"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20071D7E2B;
	Tue,  3 Sep 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392385; cv=none; b=fQUUCFIyEBj/w0xzN9msGMQ8l+JSMl2Pn3LPA0oa8m/rTf8m0dBPA3VyfActgcUsJQhpWv1JOvTBfGHaVbk+385QlItkR+Q+dgkwfGLuC1l+cXpxmLoFv0QqYlsMCSyukjyqkVG3HadHDO7MMaCeQBz2tJekvHxlktufF+NAxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392385; c=relaxed/simple;
	bh=obfq3yLxDKCxkgzB/Y8toXSMufaoxwUHO2+IKWwhV1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsctcoqWVxbGZKIgVjkp2lrAahU9PNM3XE9qTp0M3EpTfxByQCZAvGh3SVFDqv0L9i1QmCTbJwz4yGN7C5jSBMOksdPKHA20uUuOxRxvHmDsmDHWkbBYKaeZx5GdmPJUmQRI0o33+uwh/leKHLYOtcVT/XdbL6SC+/okUwHgKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tC957Bon; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZbOff63; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tC957Bon; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZbOff63; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E171A21BA3;
	Tue,  3 Sep 2024 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725392381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LRhwxJzf71SgcP8EDvxZLLW7ErFwCjxTnZAyAVKtBb0=;
	b=tC957Bon8LNd5YZ5enUgtWxHiWV7Kt7+rtmSiIYIhEYgCm6piWIJMGFEcBLPWw6gonPplO
	IPQ0d5RhmGadKdAJGkX2CGvRi1LJJt2PY/L/8SHn+SJMWjY6OX76/Nx7wxQTc0is1qC2Ym
	H841GMkPH8yHonDwGPPMF+6bHRSnXt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725392381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LRhwxJzf71SgcP8EDvxZLLW7ErFwCjxTnZAyAVKtBb0=;
	b=QZbOff63xZpedK8k0mXhIDLG9ENFbJq6FSR9wKu0YcGlb0Zim8ulk3e5UBYWGsCUdmqcJP
	I6zg/79kE96AZaAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725392381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LRhwxJzf71SgcP8EDvxZLLW7ErFwCjxTnZAyAVKtBb0=;
	b=tC957Bon8LNd5YZ5enUgtWxHiWV7Kt7+rtmSiIYIhEYgCm6piWIJMGFEcBLPWw6gonPplO
	IPQ0d5RhmGadKdAJGkX2CGvRi1LJJt2PY/L/8SHn+SJMWjY6OX76/Nx7wxQTc0is1qC2Ym
	H841GMkPH8yHonDwGPPMF+6bHRSnXt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725392381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LRhwxJzf71SgcP8EDvxZLLW7ErFwCjxTnZAyAVKtBb0=;
	b=QZbOff63xZpedK8k0mXhIDLG9ENFbJq6FSR9wKu0YcGlb0Zim8ulk3e5UBYWGsCUdmqcJP
	I6zg/79kE96AZaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C17AA139D5;
	Tue,  3 Sep 2024 19:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q8W1Lv1l12bvNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Sep 2024 19:39:41 +0000
Date: Tue, 3 Sep 2024 21:39:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
Message-ID: <20240903193936.GK26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
 <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Sep 03, 2024 at 09:16:11AM +0200, Luca Stefani wrote:
> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
> mostly empty although we will do the split according to our super block
> locations, the last super block ends at 256G, we can submit a huge
> discard for the range [256G, 8T), causing a super large delay.
> 
> We now split the space left to discard based the block discard limit
> in preparation of introduction of cancellation signals handling.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>  fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..9c1ddf13659e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1301,12 +1301,26 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>  	}
>  
>  	if (bytes_left) {
> -		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					   bytes_left >> SECTOR_SHIFT,
> -					   GFP_NOFS);
> -		if (!ret)
> -			*discarded_bytes += bytes_left;
> +		u64 bytes_to_discard;
> +		struct bio *bio = NULL;
> +		sector_t sector = start >> SECTOR_SHIFT;
> +		sector_t nr_sects = bytes_left >> SECTOR_SHIFT;
> +
> +		while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
> +				GFP_NOFS))) {
> +			ret = submit_bio_wait(bio);
> +			bio_put(bio);
> +
> +			if (!ret)
> +				bytes_to_discard = bio->bi_iter.bi_size;
> +			else if (ret != -EOPNOTSUPP)
> +				return ret;
> +
> +			start += bytes_to_discard;
> +			bytes_left -= bytes_to_discard;
> +		}

This is not what I anticipated, we only wanted to know the optimal
request size but now it's reimplementing the bio submission and compared
to blkdev_issue_discard() it lacks blk_start_plug/blk_finish_plug.

As we won't get the bio_discard_limit() export for some reason I suggest
to go back to setting the maximum chunk limit in our code and set it to
something like 8G.


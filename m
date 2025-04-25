Return-Path: <linux-btrfs+bounces-13417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD5A9C811
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186297B8D77
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFCD24C097;
	Fri, 25 Apr 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJQDFLQ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="COmF0Mn0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJQDFLQ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="COmF0Mn0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A224C66A
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581374; cv=none; b=Bgyn5daUgWeFE8hkn5I7mJyy8RlWBh7JyvFpBma4DmSVR6hn+hVNLZl7yp+zpPd9f7Ceiqxu1O1xpUokeOr/Z6jmHS3UIHl0HPa9843Nw+z4Ih0lpXryDbIuUjYmcE/vaJXkW1wbJYyarXfEXV714tXskJmfiyZf9aQgLeOMezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581374; c=relaxed/simple;
	bh=ANwG0pxB26ed0sZffjo3AOi5WwVnUUFLfQj1UtS+364=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzhMCOTnXSunUFNl/QcxBoXc9o5xWooSet98kEjbePR4cqj6ahgQT/CLi1qDEh+Ah+YxRDj92CS7jpphJWBc+Q9lTPMZO1X9UjHji8F1TyI2lRuigJV/JcdlwJvTLO07YNk+8CZ2sf6WmoR29qA0VsU3VNtzMi6ky5KTJZGGV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJQDFLQ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=COmF0Mn0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJQDFLQ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=COmF0Mn0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 314E721186;
	Fri, 25 Apr 2025 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745581371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMdJbKnFbSWj1cVI7O/NBwqBKrWS538AvA4zziKyl8=;
	b=lJQDFLQ4E9ZRsfzkG47jWxgL1vWIt4vETdIiQCCLPqW6p/4uxdidctZhoTGubrX9/2dyyh
	1UixzQvJgcL5j5Q4D5AO3SOX8G3g7TNbVgftsGMJ2WH1tVcI9Lz4u86ZImRcaYdoWANap2
	aTPDbL8CX96obAaPqfqy8KyZqgDx0Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745581371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMdJbKnFbSWj1cVI7O/NBwqBKrWS538AvA4zziKyl8=;
	b=COmF0Mn0yFkFD+suKcalrILek1qKIGLjVZ0G/a1+ktnu01tzJAMGghtEvDxLZvr9Inr6yv
	3hBaVEUUW2rPm8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745581371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMdJbKnFbSWj1cVI7O/NBwqBKrWS538AvA4zziKyl8=;
	b=lJQDFLQ4E9ZRsfzkG47jWxgL1vWIt4vETdIiQCCLPqW6p/4uxdidctZhoTGubrX9/2dyyh
	1UixzQvJgcL5j5Q4D5AO3SOX8G3g7TNbVgftsGMJ2WH1tVcI9Lz4u86ZImRcaYdoWANap2
	aTPDbL8CX96obAaPqfqy8KyZqgDx0Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745581371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMdJbKnFbSWj1cVI7O/NBwqBKrWS538AvA4zziKyl8=;
	b=COmF0Mn0yFkFD+suKcalrILek1qKIGLjVZ0G/a1+ktnu01tzJAMGghtEvDxLZvr9Inr6yv
	3hBaVEUUW2rPm8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1231C1388F;
	Fri, 25 Apr 2025 11:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bxI6BDt1C2j6NgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Apr 2025 11:42:51 +0000
Date: Fri, 25 Apr 2025 13:42:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: track current commit duration in commit_stats
Message-ID: <20250425114249.GD31681@suse.cz>
Reply-To: dsterba@suse.cz
References: <6cb65fc2544863eb6b3ca48b094cf7004e06af69.1745538939.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb65fc2544863eb6b3ca48b094cf7004e06af69.1745538939.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Apr 24, 2025 at 04:56:34PM -0700, Boris Burkov wrote:
> When debugging/detecting outlier commit stalls, having an indicator that
> we are currently in a long commit critical section can be very useful.
> Extend the commit_stats sysfs file to also include the current commit
> critical section duration.
> 
> Since this requires storing the last commit start time, use that rather
> than a separate stack variable for storing the finished commit durations
> as well.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: David Sterba <dsterba@suse.com>

> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1138,13 +1138,21 @@ static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
>  				       struct kobj_attribute *a, char *buf)
>  {
>  	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	u64 now = ktime_get_ns();
> +	u64 start_time = fs_info->commit_stats.start_time;
> +	u64 pending = 0;
> +
> +	if (start_time)
> +		pending = now - start_time;
>  
>  	return sysfs_emit(buf,
>  		"commits %llu\n"
> +		"cur_commit_ms %llu\n"
>  		"last_commit_ms %llu\n"
>  		"max_commit_ms %llu\n"
>  		"total_commit_ms %llu\n",

This ordering looks logical, the presence of order should not be assumed
by applications, this is line oriented so a grep should always work.

>  		fs_info->commit_stats.commit_count,
> +		div_u64(pending, NSEC_PER_MSEC),
>  		div_u64(fs_info->commit_stats.last_commit_dur, NSEC_PER_MSEC),
>  		div_u64(fs_info->commit_stats.max_commit_dur, NSEC_PER_MSEC),
>  		div_u64(fs_info->commit_stats.total_commit_dur, NSEC_PER_MSEC));


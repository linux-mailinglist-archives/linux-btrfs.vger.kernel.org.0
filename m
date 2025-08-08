Return-Path: <linux-btrfs+bounces-15940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2889B1EDA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 19:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C2314E1728
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23677286424;
	Fri,  8 Aug 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pVx0qYsR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h8EGTfM9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXqj5xWa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5G9DlIjw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3B7082F
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672880; cv=none; b=ViWLfd6vtyMMx49m7cTg2ncPnmKmj1v8DksUDjW8iXXOiJdpXEH2jDr5uAsopEWFqxkRXiu1wZAq62OVkmEIhBetQk3HX7JqM+3WFJ8QC1JRLmPiiGLKiQoiDbmLyPdtvwoBRtgjJWUFoYcn9XEjp1eW+8mxqUv/iBPK8A/22kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672880; c=relaxed/simple;
	bh=ir1uRBqnl78juko6xJ4qFRFk/2Bh8yFj/Y1qMnwWPGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar1FM4YscQ1LF6dsCJZIJr5ITe5Z2O7vlOprUz7p8C8IouuuSC7+3ny/9Ay1fhRwE0jyU44N4FhQm+SxHyKqSjQuB63oATKXc5MUmU6TELy1+LWHcOfiaiQK/UnUbMRKLYi+aqZLDp7v4zFHDZB2Cqg1cb2zYUQgQ0wUBfgFQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pVx0qYsR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h8EGTfM9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXqj5xWa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5G9DlIjw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFE2C5BDE1;
	Fri,  8 Aug 2025 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754672876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBYZfGZmSg+MFtVHo9HixFEs1E+i3EUH50kAtqHT3h8=;
	b=pVx0qYsRvzmT5uzbbagrxQU5urBgUdQuplHgXoa0BylEr7niRySEci6zNipwmWQly1sCwo
	ga+5DhGt4ZviLBcACVaXdN54qPthMP0U24NRnUWm1yVGlBW0l8PgRVLL5HAtOVv5K0s/Fh
	uJNF4HYjPdcCgl+E765HFS9NFwUDjMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754672876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBYZfGZmSg+MFtVHo9HixFEs1E+i3EUH50kAtqHT3h8=;
	b=h8EGTfM9EvJH6eyr9Ao68DcbRbA6JZwZke8sbPCpLUbtAO7UKDqM6mecuoctR1XJzo5YMC
	CkMi9lEyCznJrLCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754672875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBYZfGZmSg+MFtVHo9HixFEs1E+i3EUH50kAtqHT3h8=;
	b=qXqj5xWaqoz0eCRVzFnCfXqObrY5Vw1VYIcXRp6Cpvnuf8fDNwoYtJ7liXLQeGQRn3N2hj
	QAa6xuxXQEuzKIVkNIdEbb8Yh5rvA9Gp4RcJAfxFIGF9u5LND+vQoa1Gn9undNigj+NFmd
	4niZyFEfWKzdcTG/7cCPzbSV/So4Mmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754672875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBYZfGZmSg+MFtVHo9HixFEs1E+i3EUH50kAtqHT3h8=;
	b=5G9DlIjwjBUCIe+7glfBvpLjwX5MAZJNuwglA5ou2Vq6zFDM37jI1fJPW5vdHtfzeeVGHy
	TfnQNnUtyVtHCgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5D3313A7E;
	Fri,  8 Aug 2025 17:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m1zCM+sulmiYXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Aug 2025 17:07:55 +0000
Date: Fri, 8 Aug 2025 19:07:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs-progs: device_get_partition_size*()
 enhancement and cleanup
Message-ID: <20250808170750.GW6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1754455239.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754455239.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Wed, Aug 06, 2025 at 02:18:49PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Include and update Zoltan's fix to device_get_partition_size_sysfs()
>   The "/dev/block/<device>/size" attribute is always in sector unit
>   (512Bytes), independent from the physical device's block size.
> 
>   So the fix is pretty straightforward, just do the left shift before
>   returning.
> 
>   And update the commit message to properly reflect that.
> 
> - Use s64 as the return value of device_get_partition_size*()
>   Kernel ensures the max sector number of a device is LLONG_MAX >> 9,
>   so s64 is more than enough to cover the device size, and we are safe
>   to use the minus part to pass errors.
> 
> - Extra error handling when device_get_partition_size*() failed
>   Ouput an error message and exit.
>   Most callers are already doing that correctly but some are not.
> 
> - Keep the sysfs method as the fallback way to grab device size
>   Since the device_get_partition_size_sysfs() can be easily fixed, no
>   need to use complex path search for sector size.
> 
> - Add a new cleanup to remove is_vol_small()
> 
> Zoltan recently sent a fix to solve the bug in
> device_get_partition_size_sysfs(), which is causing problems for "btrfs
> dev usage".
> 
> It turns out that, the bug is just the attribute
> "/sys/block/<device>/size" is in sector unit (512B), not in bytes.
> 
> So fix the bug first by reporting the correct size in bytes.
> 
> Then remove several unused functions exposed during the error handling
> cleanup.
> 
> Finally cleanup device_get_partition_size*() helpers to provide a proper
> error handling, not just return 0 for errors, but proper minus erro
> code, and extra overflow check.
> 
> Qu Wenruo (5):
>   btrfs-progs: remove the unnecessary device_get_partition_size() call
>   btrfs-progs: remove device_get_partition_size_fd()
>   btrfs-progs: remove is_vol_small() helper
>   btrfs-progs: add error handling for device_get_partition_size()
>   btrfs-progs: add error handling for
>     device_get_partition_size_fd_stat()
> 
> Zoltan Racz (1):
>   btrfs-progs: fix the wrong size from device_get_partition_size_sysfs()

Besides the s64 conversion, the patches look good to me. Please add them
to devel, thanks.


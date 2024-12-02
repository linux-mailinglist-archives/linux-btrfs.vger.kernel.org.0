Return-Path: <linux-btrfs+bounces-10007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B29E0426
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959FD16729B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B9202F95;
	Mon,  2 Dec 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wXpNckGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s8G/QM0a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aMm1J0db";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vpALBTSD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE88201266
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147806; cv=none; b=gxSJSd53iX511/euP0Qvfs7rVPCDkMFRISHPruPy+s9QBGe8UuPwWtblwhcBi9WjbK6SpTbtp2POen1y+oir4LUmQdVEx6I9gnPyeG1jQqvKKNDk8fsq4/H+k9sOPrNZLZcrd8sBj27ifNdwgdAWCA2rsCAQH0MI5Qlp3N92kjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147806; c=relaxed/simple;
	bh=uR50yGKPMhFq2TMXjeV9L5PI8Thw8wokcu11Ap8hOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvoe8OhJjR24vpxT4C1LI+kK84PpirsQo/av1CJxE7MUj/vAjuEl/eA1Wz2A6sVVPHwt+VXAdghd2QHMsTMGCZcJD0hls7LQrkOyAe0cvhjPfMMvwrM0sz7eJUI23IQUwD0xPxN9yJrirfmma7QwpcFHHl1I8zH1aTdZtqaHG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wXpNckGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s8G/QM0a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aMm1J0db; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vpALBTSD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1F8D210F3;
	Mon,  2 Dec 2024 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733147803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
	b=wXpNckGY4IWQoerjUm0PoBaovV+jV6pfZuJNydRIwJrLs8cnVqCEhTTyFHKFRpgXzDCwDt
	2deHD/i2w/c9CCXn9zG9Jg8WIL84ZyHMb0JXuZ363/UnBC/kwqTO3QkIkz2Mzh7cG4RsXH
	tbBu0FyHe5Y4vOTYJCEwctA4aVZay2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733147803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
	b=s8G/QM0ay4m0WNbSa4eP56FiDQOPZxKqQJB3Now9tWQsXkHbcNPCfjrQYw4ac66sculyUI
	kMSPLAjlNg/2EXBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733147802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
	b=aMm1J0dbQagT+jL037gEyVZ/4Uuso7d4Bk/+yCNopxiZrGkKq2xbDTNuztN1+0z4G6suOV
	HUiaGwonGgKoyCiW1Ga01brQWW7VOzZw3V7Oe54sL4c5TFG5LVF2An9SBEoWYj6I8Vsnzm
	gHNvIXZxU/xu1yhnGeQhtVQfFtPvlaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733147802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
	b=vpALBTSDlSehW6F2qrDD/8AZkj9O149rQnmqfix4UTgniLcImwI5HeUcOGy6aET3medKvT
	TDF/breNsQf3EuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CF3139C2;
	Mon,  2 Dec 2024 13:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fq1+Mpq8TWd/FAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 13:56:42 +0000
Date: Mon, 2 Dec 2024 14:56:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: ltp@lists.linux.it, linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 2/3] stat04+lstat03: fix bad blocksize mkfs option
 for xfs
Message-ID: <Z028qctN4vFrfUzx@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-3-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201093606.68993-3-zlang@kernel.org>
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi!
> Not all filesystems use "-b 1024" to set its blocksize. XFS uses
> "-b size=1024", so this test fails as "unknown option -b 1024" on
> xfs.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  testcases/kernel/syscalls/lstat/lstat03.c | 8 ++++++--
>  testcases/kernel/syscalls/stat/stat04.c   | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
> index d48af180b..675fb56f4 100644
> --- a/testcases/kernel/syscalls/lstat/lstat03.c
> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
> @@ -44,8 +44,9 @@ static void run(void)
>  
>  static void setup(void)
>  {
> +	char *opt_name="-b";
>  	char opt_bsize[32];
> -	const char *const fs_opts[] = {opt_bsize, NULL};
> +	const char *const fs_opts[] = {opt_name, opt_bsize, NULL};
                                       ^
				       You can just add "-b" here
				       instead of creating a variable.

>  	struct stat sb;
>  	int pagesize;
>  	int fd;
> @@ -54,7 +55,10 @@ static void setup(void)
>  	SAFE_STAT(".", &sb);
>  	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
>  
> -	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
> +	if (strcmp(tst_device->fs_type, "xfs") == 0)
          ^
	  The more common style is if (!strcmp(...))
> +		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
> +	else
> +		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz


Return-Path: <linux-btrfs+bounces-10006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CFC9E0418
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C459D282D9B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE3202F6E;
	Mon,  2 Dec 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hF65pDMl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yg5qLYtX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hF65pDMl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yg5qLYtX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AE201265
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147716; cv=none; b=BmzJSAOrbvFUgfUWryf4B4MdlufGNrLkRZSN3AJHo/x4uXeVAilqUPIqR5xTOnsn4ruGS5dy837pqZvWLPEay04apMHWnTxEVBQf3MXrIn9gN++HjfGzd9AE2bEnQOL4/aVA7BSqOgjOBZCICkyw2j7bHlxAXRStik5r21k3kwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147716; c=relaxed/simple;
	bh=fRZgzGTwfgDSsHNOiVqqP2kyzs7UodI5BpAMdop9I1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSB5kjKWPkV1SaJrcvTLyQDgzFg7FptYvnftpxGGQz8h7Lil68d/RwcjpYign9bmT7uGcaQ6iRjLpYe8af/XYv5jIWMKGurGlQu6D7PM3Mt4iFQToOFLa6SbPCSLLw1H0N09gZAlDSaxj+GxOrnlFeB7r26GqOl1T+vezLJhml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hF65pDMl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yg5qLYtX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hF65pDMl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yg5qLYtX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 035421F444;
	Mon,  2 Dec 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733147713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
	b=hF65pDMlM16ZpzH0vxgcyqP5gBllHC0yvGNpAjbXc9+9yZnkl9LZpqAgw5YWfzZUiuiP6g
	Myk9hKPl590XRS/Qbzh36Ul1+Tqq7fjgpFBMINP2NE59IZLICmeSdP31dw+eB5rkOAA0a6
	GDK9LMXiOIUyS9eJm09/y0D7Msu5cI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733147713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
	b=yg5qLYtXkw9L9m+mhl3cV432O590z9GPqDe6qiMz7TA0nDwpLc2Ekw4vnFJn7vmES92UX2
	qkT+TLjuT728NlCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hF65pDMl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yg5qLYtX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733147713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
	b=hF65pDMlM16ZpzH0vxgcyqP5gBllHC0yvGNpAjbXc9+9yZnkl9LZpqAgw5YWfzZUiuiP6g
	Myk9hKPl590XRS/Qbzh36Ul1+Tqq7fjgpFBMINP2NE59IZLICmeSdP31dw+eB5rkOAA0a6
	GDK9LMXiOIUyS9eJm09/y0D7Msu5cI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733147713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
	b=yg5qLYtXkw9L9m+mhl3cV432O590z9GPqDe6qiMz7TA0nDwpLc2Ekw4vnFJn7vmES92UX2
	qkT+TLjuT728NlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E72C5139C2;
	Mon,  2 Dec 2024 13:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hbGEN0C8TWfsEwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 13:55:12 +0000
Date: Mon, 2 Dec 2024 14:55:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: ltp@lists.linux.it, linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 3/3] stat04+lstat03: skip test on btrfs
Message-ID: <Z028RzZZQjF3pA4Q@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-4-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201093606.68993-4-zlang@kernel.org>
X-Rspamd-Queue-Id: 035421F444
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi!
> The "-b" option for mkfs.btrfs isn't a blocksize option, it does
> "specify the size of each device as seen by the filesystem" for
> btrfs. There's not an blocksize mkfs option for btrfs, so skip this
> test.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  testcases/kernel/syscalls/lstat/lstat03.c | 2 ++
>  testcases/kernel/syscalls/stat/stat04.c   | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
> index 675fb56f4..f7346893d 100644
> --- a/testcases/kernel/syscalls/lstat/lstat03.c
> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
> @@ -57,6 +57,8 @@ static void setup(void)
>  
>  	if (strcmp(tst_device->fs_type, "xfs") == 0)
>  		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
> +	else if (strcmp(tst_device->fs_type, "btrfs") == 0)
> +		tst_brk(TCONF, "btrfs is not supported");

This is overkill, all we need to skip on Btrfs is the st_blksize test.
We need to set a flag in the test setup and then skip the corresponding
TST_EXP_EXPR().

-- 
Cyril Hrubis
chrubis@suse.cz


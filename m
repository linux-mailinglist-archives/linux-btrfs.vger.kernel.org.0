Return-Path: <linux-btrfs+bounces-1485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F10182F44B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EC11C237A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B2E1CD31;
	Tue, 16 Jan 2024 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X5tKrp3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KtqKGGGA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X5tKrp3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KtqKGGGA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3881BC3C
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429933; cv=none; b=F7bKN36M4pOWVncnXd7NgYpvGqueXWXDeFEXCGPPhVJShAteTyAQoNHYvmd++siE2sP0W+aQKARXm4vPbQMnoOjK0B9zypBl0LQPSvkzqMbZf25mC3l4rbh0kT56A8TRfCk5EpTKCdQU5xtYTu8jwyPo+T7D9lqLYjM5JPzlX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429933; c=relaxed/simple;
	bh=sZo9aqv3M7oIGaAHds/mHTW2gK7/KTNNy35JMVOl8x0=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=lYzm4zHpouYymEapsdxuU6C5wCg+GB7X8uXQaCubyzI4cJro+hFn/Jcnf+g/yBUdTXOZUeYMKu8kCS5Q2vvnRxl/mwA1vMZr0TnC7M2/IzD4hr+kYq5mJxhZItD2fvs5kkH+SFAdd4sfwRg+vvhTZgSUXyehm+Ixw50ZUd774eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X5tKrp3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KtqKGGGA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X5tKrp3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KtqKGGGA; arc=none smtp.client-ip=195.135.223.130
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 397E221C39;
	Tue, 16 Jan 2024 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705429930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6WmPLbC46YjlGZaaxPvhp0ZlvtM6tFtPsM5lBR4lKnY=;
	b=X5tKrp3G8aaq4pQ+ts57y7wk13ehpUGh1TxsG5IAld2zgWO/tXcSfSWejBcCHFhJdE11kE
	532RqBUgrPVuYLoRjT91Dvbi5nl3Il5bJWeInVhcNyb0ZC66IqomW0PKxoFk0yQYT9b4cT
	6K8GTX/Fwt7vkmqD9m8IYNR/D3pbwT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705429930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6WmPLbC46YjlGZaaxPvhp0ZlvtM6tFtPsM5lBR4lKnY=;
	b=KtqKGGGAd9e0iDQ+kmhRg8/mit5MgR7uZmx6hhnahkW+99kdrJ+iio2hZuk7OqACFAxzT2
	6Gj7837If+EhzOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705429930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6WmPLbC46YjlGZaaxPvhp0ZlvtM6tFtPsM5lBR4lKnY=;
	b=X5tKrp3G8aaq4pQ+ts57y7wk13ehpUGh1TxsG5IAld2zgWO/tXcSfSWejBcCHFhJdE11kE
	532RqBUgrPVuYLoRjT91Dvbi5nl3Il5bJWeInVhcNyb0ZC66IqomW0PKxoFk0yQYT9b4cT
	6K8GTX/Fwt7vkmqD9m8IYNR/D3pbwT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705429930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6WmPLbC46YjlGZaaxPvhp0ZlvtM6tFtPsM5lBR4lKnY=;
	b=KtqKGGGAd9e0iDQ+kmhRg8/mit5MgR7uZmx6hhnahkW+99kdrJ+iio2hZuk7OqACFAxzT2
	6Gj7837If+EhzOAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 16B64133CF;
	Tue, 16 Jan 2024 18:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id II/nBKrLpmXEOQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 18:32:10 +0000
Date: Tue, 16 Jan 2024 19:31:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: convert/ext2: new debug environment
 variable to finetune transaction size
Message-ID: <20240116183152.GC31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705135055.git.wqu@suse.com>
 <4c2f12dc417a192f4acfd804831401aadeeb9c42.1705135055.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2f12dc417a192f4acfd804831401aadeeb9c42.1705135055.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X5tKrp3G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KtqKGGGA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.19)[-0.975];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.20
X-Rspamd-Queue-Id: 397E221C39
X-Spam-Flag: NO

On Sat, Jan 13, 2024 at 07:15:29PM +1030, Qu Wenruo wrote:
> Since we got a recent bug report about tree-checker triggered for large
> fs conversion, we need a properly way to trigger the problem for test
> case purpose.
> 
> To trigger that bug, we need to meet several conditions:
> 
> - We need to read some tree blocks which has half-backed inodes
> - We need a large enough enough fs to generate more tree blocks than
>   our cache.
> 
>   For our existing test cases, firstly the fs is not that large, thus
>   we may even go just one transaction to generate all the inodes.
> 
>   Secondly we have a global cache for tree blocks, which means a lot of
>   written tree blocks are still in the cache, thus won't trigger
>   tree-checker.
> 
> To make the problem much easier for our existing test case to expose,
> this patch would introduce a debug environment variable:
> BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD.
> 
> This would affects the threshold for the transaction size, setting it to
> a much smaller value would make the bug much easier to trigger.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/utils.c        | 62 +++++++++++++++++++++++++++++++++++++++++++
>  common/utils.h        |  1 +
>  convert/source-ext2.c |  9 ++++++-
>  3 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/common/utils.c b/common/utils.c
> index 62f0e3f48b39..e6070791f5cc 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -956,6 +956,68 @@ u8 rand_u8(void)
>  	return (u8)(rand_u32());
>  }
>  
> +/*
> + * Parse a u64 value from an environment variable.
> + *
> + * Supports unit suffixes "KMGTP", the suffix is always 2 ** 10 based.
> + * With proper overflow detection.
> + *
> + * The string must end with '\0', anything unexpected non-suffix string,
> + * including space, would lead to -EINVAL and no value updated.
> + */
> +int get_env_u64(const char *env_name, u64 *value_ret)

There already is a function for parsing sizes parse_size_from_string()
in common/parse-utils.c.


Return-Path: <linux-btrfs+bounces-2113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33EB849EBF
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 16:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157C5B2A75F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F6328AC;
	Mon,  5 Feb 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FVXeYpSx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTrLPex/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FVXeYpSx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTrLPex/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAF2D60B;
	Mon,  5 Feb 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148180; cv=none; b=KCf/SkIZL2MHrNnWsWmhWlbr8TqSw/RmeAL4CHCpBAjpOFBpDPOqY/JAAwoTSsVFsIb4MmWALFzeZRHSJKqbqR22RMNyncd3SI61Rzkp+e8Pc4GX+vBNc1leo5fVtb++KLe354HZq/Yf8tCzXCWj7UDnmTjxRRILORiiEi8ewt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148180; c=relaxed/simple;
	bh=gnPYkcewH1Xo0V2THQ+krWUMpM48gSf8BNML1IzKstE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ7FOh9/VRqpbaRy1JdPiPql6t22/bjmhO8LnFj9ZQh9eB9UoqZ5eTyr7qaqQYOQT45fYOTpoISH/3ZsGKaiIW/MfkdqAXka4bE4tTyub0qAWwMkKbcwRlV2wIEbYdGxTQfZOzrpFYgvUB4h9e1pfA4QUGGG+esRneeGLPGZmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FVXeYpSx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTrLPex/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FVXeYpSx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTrLPex/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0730322144;
	Mon,  5 Feb 2024 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707148176;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Epy8iaLBvYFOXCg71QwxtDLZ5rVr9Kq3mC0VWCjemA8=;
	b=FVXeYpSxlpO3Es0E9sDhG546bgxAlpqNS/2fndlE55Qk2bzD9I0RS/pMH1sIETxVRymLBk
	pZHC5LVN6MyLq7MLXSnbPA8yShNi5HViNG6DrEgwyXZ8IMQxVIh9DMGqBd+e5+12/TZqHH
	eehjEyJfh0+KO/wPQoX+Ep+84NGsJYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707148176;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Epy8iaLBvYFOXCg71QwxtDLZ5rVr9Kq3mC0VWCjemA8=;
	b=RTrLPex/fqo/19zm9SRUGs5FXZN/M0U5UyhZEjhHm2xWGzXxgvHhIhCEKdqmh8zGVQGqjJ
	3j1d6g5cEWRYq7AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707148176;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Epy8iaLBvYFOXCg71QwxtDLZ5rVr9Kq3mC0VWCjemA8=;
	b=FVXeYpSxlpO3Es0E9sDhG546bgxAlpqNS/2fndlE55Qk2bzD9I0RS/pMH1sIETxVRymLBk
	pZHC5LVN6MyLq7MLXSnbPA8yShNi5HViNG6DrEgwyXZ8IMQxVIh9DMGqBd+e5+12/TZqHH
	eehjEyJfh0+KO/wPQoX+Ep+84NGsJYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707148176;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Epy8iaLBvYFOXCg71QwxtDLZ5rVr9Kq3mC0VWCjemA8=;
	b=RTrLPex/fqo/19zm9SRUGs5FXZN/M0U5UyhZEjhHm2xWGzXxgvHhIhCEKdqmh8zGVQGqjJ
	3j1d6g5cEWRYq7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6835136F5;
	Mon,  5 Feb 2024 15:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OaEEOI8DwWXDBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Feb 2024 15:49:35 +0000
Date: Mon, 5 Feb 2024 16:49:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240205154907.GH355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FVXeYpSx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="RTrLPex/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 0730322144
X-Spam-Flag: NO

On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but the
> macros BTRFS_IOC_SNAP_DESTROY_V2 is not defined. This will cause
> compile error. Add check for BTRFS_IOC_SNAP_DESTROY_V2 to solve this
> problem.
> 
> BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 were
> introduced together with struct btrfs_ioctl_vol_args_v2 by the
> commit 55e301fd57a6 ("Btrfs: move fs/btrfs/ioctl.h to
> include/uapi/linux/btrfs.h"). So there is no need to check them.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  configure.ac                       |  1 +
>  src/t_snapshot_deleted_subvolume.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b22fc52b..b14b1ab8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -109,6 +109,7 @@ AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
>  #include <stddef.h>
>  #include <linux/btrfs.h>
>  ]])
> +AC_CHECK_DECLS([BTRFS_IOC_SNAP_DESTROY_V2],,,[#include <linux/btrfs.h>])
>  
>  AC_CONFIG_HEADERS([include/config.h])
>  AC_CONFIG_FILES([include/builddefs])
> diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
> index c3adb1c4..402c0515 100644
> --- a/src/t_snapshot_deleted_subvolume.c
> +++ b/src/t_snapshot_deleted_subvolume.c
> @@ -20,11 +20,6 @@
>  #define BTRFS_IOCTL_MAGIC 0x94
>  #endif
>  
> -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
>  #ifndef BTRFS_IOC_SNAP_CREATE_V2
>  #define BTRFS_IOC_SNAP_CREATE_V2 \
>  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
>  };
>  #endif
>  
> +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2

This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
not define the HAVE_... in case it's not found so the #if !HAVE_...
would be wrong. Slightly confusing.

> +#define BTRFS_IOC_SNAP_DESTROY_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
>  int main(int argc, char **argv)
>  {
>  	if (argc != 2) {
> -- 
> 2.39.3
> 


Return-Path: <linux-btrfs+bounces-5158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C28CAF59
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F9B1F23584
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DDB7CF3E;
	Tue, 21 May 2024 13:24:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39478C7E;
	Tue, 21 May 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297884; cv=none; b=RZ0SxHikEfqZkeuzYFFwXPu6l1n0+UoCcyA5hYe1/NHfbjYGqN5N08oulnIAwCnm6zKoe3b1mAAcKugZ4sXIgjeCtKmq6/zZ2RdRVgwn1u+NIwCQcEEwumpsaUuVagBT5nSRV89IfRhHlQ/cP9ydBy4iRZdtLWsHEL3PoOYD6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297884; c=relaxed/simple;
	bh=R+sRij4uYKEKW44nVslXfxrZ6NRvILBPpNgs0dI0vV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPEXou73H/S1iUDWY4o8pjnNE6TjPEKaX+QsawdZZAAuAbEp4OdyLnwsxxpnczzYQoaAAPG/85sGow0vp/D2CmgOGEDufTPzzWw4jSQcnCBHKx1lOsc5QTFlIlf3J3oanLpYM+iN19eAEAMC6e+ukq7bGePq87mSwS/PIXJb6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 37955E801FB;
	Tue, 21 May 2024 15:24:38 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id D74DA1601B2; Tue, 21 May 2024 15:24:37 +0200 (CEST)
Date: Tue, 21 May 2024 15:24:37 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: re-introduce 'norecovery' mount option
Message-ID: <ZkygleyN4dVTxyAn@gardel-login>
References: <44c367eab0f3fbac9567f40da7b274f2125346f3.1716285322.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c367eab0f3fbac9567f40da7b274f2125346f3.1716285322.git.wqu@suse.com>

On Di, 21.05.24 19:27, Qu Wenruo (wqu@suse.com) wrote:

thank you!

lgtm.

> Although 'norecovery' mount option is marked deprecated for a long time
> and a warning message is introduced during the deprecation window, it's
> still actively utilized by several projects that need a safely way to
> mount a btrfs without any writes.
>
> Furthermore this 'norecovery' mount option is supported by most major
> filesystems, which makes it harder to validate our motivation.
>
> This patch would re-introduce the 'norecovery' mount option, and output
> a message to recommend 'rescue=nologreplay' option.
>
> Link: https://lore.kernel.org/linux-btrfs/ZkxZT0J-z0GYvfy8@gardel-login/#t
> Link: https://github.com/systemd/systemd/pull/32892
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1222429
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Reported-by: Jiri Slaby <jslaby@suse.com>
> Fixes: a1912f712188 ("btrfs: remove code for inode_cache and recovery mount options")
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2dbc930a20f7..f05cce7c8b8d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -119,6 +119,7 @@ enum {
>  	Opt_thread_pool,
>  	Opt_treelog,
>  	Opt_user_subvol_rm_allowed,
> +	Opt_norecovery,
>
>  	/* Rescue options */
>  	Opt_rescue,
> @@ -245,6 +246,8 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
>  	__fsparam(NULL, "nologreplay", Opt_nologreplay, fs_param_deprecated, NULL),
>  	/* Deprecated, with alias rescue=usebackuproot */
>  	__fsparam(NULL, "usebackuproot", Opt_usebackuproot, fs_param_deprecated, NULL),
> +	/* For compatibility only, alias for "rescue=nologreplay". */
> +	fsparam_flag("norecovery", Opt_norecovery),
>
>  	/* Debugging options. */
>  	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
> @@ -438,6 +441,11 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
>  		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
>  		break;
> +	case Opt_norecovery:
> +		btrfs_info(NULL,
> +"'norecovery' is for compatibility only, recommended to use 'rescue=nologreplay'");
> +		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
> +		break;
>  	case Opt_flushoncommit:
>  		if (result.negated)
>  			btrfs_clear_opt(ctx->mount_opt, FLUSHONCOMMIT);
> --
> 2.45.1
>
>

Lennart

--
Lennart Poettering, Berlin


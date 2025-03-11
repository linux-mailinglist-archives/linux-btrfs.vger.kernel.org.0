Return-Path: <linux-btrfs+bounces-12209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869E3A5D207
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 22:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAEF3B14ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC3264A7D;
	Tue, 11 Mar 2025 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YTuPi7/j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RI0+Aodt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YTuPi7/j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RI0+Aodt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5B22173D
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730025; cv=none; b=SYn/52emXtY0yoTgQ6UoaWJspnYjR+7fJmlFy+C0FgUdWbhqh0FuLYYrGsTl824rGVTyeOlqKbLIYw36uHtNbAaX1LR41dDavNaV/DGCGx/u3JfaNbeYYPJyvqspuhpBawyVMtUv38iB7MINdMtW9/ioe70GHNrERu5hPsD6Slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730025; c=relaxed/simple;
	bh=H3dCXMHH1pfMpQTPWCgbH8+hwpoparHcnLxG2fzR/v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2r8lMh8BLi/28C0HDl1RjQyHZVvfYTRhE6EWmXA+mmZzpbKdg95UehSS1/gGCN9AOCmJTSX+JqpNCqEK0+bzZDy+kVJytxkoRNnBt8d1jDODLyoDCzgsfWJqTwaR4ZE9ZJuvbfnDri0/ox2LinkeCgnOiBKQsdHmEAAxhN4Y/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YTuPi7/j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RI0+Aodt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YTuPi7/j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RI0+Aodt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B097E21180;
	Tue, 11 Mar 2025 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741730021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOL8lX/s0a3zi81+F7IrmxoAND+rJpaLpc/2P4Cst1Q=;
	b=YTuPi7/jUL2K3HqkxsF3DTw38atHEcx4fI8Qe1REDc8Z4l6Kl8l+TLjMGFHFXWZGdFNC9p
	/sF9IAEW8pGdEsrwbjrdqD2a62ZPE1/24YihERKHVpCMogyj2fuWFd1PZlZAYLJsPRaKcC
	5aj4E2j/fzWIcnfk4SZCkbgKgygZXUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741730021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOL8lX/s0a3zi81+F7IrmxoAND+rJpaLpc/2P4Cst1Q=;
	b=RI0+AodtcVibbgadAI0agtofI6rwjyxVMLTlT+G0gc5d7B5Ddv3JwtNpcCH/wTzkdWIPWg
	CGBFG/BH5zAssOBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741730021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOL8lX/s0a3zi81+F7IrmxoAND+rJpaLpc/2P4Cst1Q=;
	b=YTuPi7/jUL2K3HqkxsF3DTw38atHEcx4fI8Qe1REDc8Z4l6Kl8l+TLjMGFHFXWZGdFNC9p
	/sF9IAEW8pGdEsrwbjrdqD2a62ZPE1/24YihERKHVpCMogyj2fuWFd1PZlZAYLJsPRaKcC
	5aj4E2j/fzWIcnfk4SZCkbgKgygZXUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741730021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOL8lX/s0a3zi81+F7IrmxoAND+rJpaLpc/2P4Cst1Q=;
	b=RI0+AodtcVibbgadAI0agtofI6rwjyxVMLTlT+G0gc5d7B5Ddv3JwtNpcCH/wTzkdWIPWg
	CGBFG/BH5zAssOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98F7C134A0;
	Tue, 11 Mar 2025 21:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5/TNJOWw0GdKWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Mar 2025 21:53:41 +0000
Date: Tue, 11 Mar 2025 22:53:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fi defrag: allow passing compression levels
Message-ID: <20250311215336.GM32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250304172712.573328-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304172712.573328-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 04, 2025 at 06:27:12PM +0100, Daniel Vacek wrote:
> zlib and zstd compression methods support using compression levels.
> Enable defrag to pass them to kernel.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

Added to devel, with some adjustments, thanks. We'll also need a test,
that can fail if the kernel does not support the levels. The github CI
is 6.8 so we won't be able to test it there completely.

> +		case 'L':
> +			/*
> +			 * Do not enforce any limits here, kernel will do itself
> +			 * based on what's supported by the running version.
> +			 * Just clip to the s8 type of the API.

I'm not sure this is a good practice, we know what are the level ranges
so the validation should be done here as well even if kernel will check
them as well. I'll keep it like that for now but may change it
eventually.

> +			 */
> +			compress_level = atoi(optarg);
> +			if (compress_level < -128)
> +				compress_level = -128;
> +			else if (compress_level > 127)
> +				compress_level = 127;
> +			break;

> --- a/libbtrfs/ioctl.h
> +++ b/libbtrfs/ioctl.h
> @@ -398,6 +398,7 @@ struct btrfs_ioctl_clone_range_args {
>  /* flags for the defrag range ioctl */
>  #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>  #define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4

I've removed this, libbtrfs is frozen, deprecated and should not be
used, so there are no feature/API updates.

>  #define BTRFS_SAME_DATA_DIFFERS	1
>  /* For extent-same ioctl */


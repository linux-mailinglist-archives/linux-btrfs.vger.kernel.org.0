Return-Path: <linux-btrfs+bounces-1339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9AA8291A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9101C23AE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 00:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1B81E;
	Wed, 10 Jan 2024 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XIeOON3X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="17duDkrr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XIeOON3X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="17duDkrr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D111C01;
	Wed, 10 Jan 2024 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83D8B1F83D;
	Wed, 10 Jan 2024 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704848083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwQONI/1WbY7fzVABzLgr2p6+VrAvIvrtCgjPL1J3E=;
	b=XIeOON3XeshdOVliOixvFahNpjrp4jHeZ3MUAfQ6rGos+ybMVzj5WmFB9khXig1E867oKv
	wFKk3BVE73iDlAkAIBLIb4pchKJgmZvqqJZSaRq0ts7eQMkEPctqRJUBVcW9mm8+V8iZ0g
	gmnUkLezmvW+bGCNMkNWd2dn8qFFpiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704848083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwQONI/1WbY7fzVABzLgr2p6+VrAvIvrtCgjPL1J3E=;
	b=17duDkrr9fk6U33tqiJpLOL263dLyfVCCL7SQaxCqLGFSy1L+BIj/N0WZneMdrvHFxg2Vd
	+t3O5GN9e0A86gCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704848083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwQONI/1WbY7fzVABzLgr2p6+VrAvIvrtCgjPL1J3E=;
	b=XIeOON3XeshdOVliOixvFahNpjrp4jHeZ3MUAfQ6rGos+ybMVzj5WmFB9khXig1E867oKv
	wFKk3BVE73iDlAkAIBLIb4pchKJgmZvqqJZSaRq0ts7eQMkEPctqRJUBVcW9mm8+V8iZ0g
	gmnUkLezmvW+bGCNMkNWd2dn8qFFpiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704848083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwQONI/1WbY7fzVABzLgr2p6+VrAvIvrtCgjPL1J3E=;
	b=17duDkrr9fk6U33tqiJpLOL263dLyfVCCL7SQaxCqLGFSy1L+BIj/N0WZneMdrvHFxg2Vd
	+t3O5GN9e0A86gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65E3C13786;
	Wed, 10 Jan 2024 00:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bv2vGNPqnWVcawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 00:54:43 +0000
Date: Wed, 10 Jan 2024 01:54:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: defrag: reject unknown flags of
 btrfs_ioctl_defrag_range_args
Message-ID: <20240110005428.GN28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0d35011f8afe8bd55c1f0318b0d2515ea10eac7f.1704839283.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d35011f8afe8bd55c1f0318b0d2515ea10eac7f.1704839283.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.03 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.18)[-0.906];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.05)[60.08%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -5.03

On Wed, Jan 10, 2024 at 08:58:26AM +1030, Qu Wenruo wrote:
> Add extra sanity check for btrfs_ioctl_defrag_range_args::flags.
> 
> This is not really to enhance fuzzing tests, but as a preparation for
> future expansion on btrfs_ioctl_defrag_range_args.
> 
> In the future we're adding new members, allowing more fine tuning for
> btrfs defrag.
> Without the -ENONOTSUPP error, there would be no way to detect if the
> kernel supports those new defrag features.
> 
> cc: stable@vger.kernel.org #4.14+
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/ioctl.c           | 4 ++++
>  include/uapi/linux/btrfs.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a1743904202b..3a846b983b28 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2608,6 +2608,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>  				ret = -EFAULT;
>  				goto out;
>  			}
> +			if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
> +				ret = -EOPNOTSUPP;

This should be EINVAL, this is for invalid parameter values or
combinations, EOPNOTSUPP would be for the whole ioctl as not supported.


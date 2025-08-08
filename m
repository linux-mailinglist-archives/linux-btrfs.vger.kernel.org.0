Return-Path: <linux-btrfs+bounces-15936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B18B1EB1A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A955A1AA6FD7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A7281358;
	Fri,  8 Aug 2025 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cmDrA1oI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J25Pyme3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w0ElO0p6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLrxo+nR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB59281370
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665009; cv=none; b=ox3Edg8pTqike2ui7Eka1EmMYceSn22R2EvB1ZOKtgemZb17DUTYfh6r6Avlss7m+rs6GbE0H1iClkEm4NA+42Xo/qgHrqGEtkslpzYMwGJ927mV3F1yLAN1xx7CHy1CtVBe2dS06vWf/Yukch99YF/wjPCXQbSVioSoSFmME+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665009; c=relaxed/simple;
	bh=kyU9SysSDd2tFKAsHTxZZriy94Nz962Fl7cSdYF71cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huFH6wiDV+GR334S20rHSZGN8UQZRVsnPDqj1F7lZdO+3ORlbA3cIrvnH4psKekjdnO0OMmJ+uHFkADf+F6cW3zXAcRablCMvwr0cA2iM9zobPp9FfFSMyRTa+eTP6egGJZmBkGNhRd2DdhkrcJ/GHnOdro3lhJeufoikPI2TP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cmDrA1oI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J25Pyme3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w0ElO0p6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLrxo+nR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA4B233E45;
	Fri,  8 Aug 2025 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754665006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzYAvvmg9htnsGcdinZLhXOuN1sNJjo2iTfhIWgJtvY=;
	b=cmDrA1oIHoT9H7toez8nrotNUmsSyYp+HU7UxkKuTqxrx1mi7v/iNiC8M5GHOb0q1UbP0i
	NL3MjRCRp2S4uDNPtaPY1fKVsltNSa00Jmm83L7UOf2qPnWGAW92yEoZsRcCbbCCCCeG2+
	4MSAEK9usDyZyh42yMVS40t9+spBl/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754665006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzYAvvmg9htnsGcdinZLhXOuN1sNJjo2iTfhIWgJtvY=;
	b=J25Pyme3/tMCVu1uNqLRtn7iDAGzW+XWHtQVadJNvS++c4nL+D32xaTb9vdnImrbpBIu82
	XzKyG5ILna+o3BAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754665005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzYAvvmg9htnsGcdinZLhXOuN1sNJjo2iTfhIWgJtvY=;
	b=w0ElO0p6n/OU0Y1Py+ca3ZP8tN5m6iptO01CyMPJvNd9E4tEtlf+6k+NQR2ZoGo/tFxXkD
	8j5OJunN5YYzOa8B4P8SlGWimkLv5vY4lmwjWF9au0vv+XXbj/tUmCONvwK4MsPJ9qF9/H
	H5/KEc4BvcykYDG3HMIM4w33KQXzXbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754665005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzYAvvmg9htnsGcdinZLhXOuN1sNJjo2iTfhIWgJtvY=;
	b=fLrxo+nRxiCADgmHyHaadC8/aO0FYM8rxV2md3iDVfYvYVOzLIdx5aEV/K/1jwDawtJTbx
	WUy5/QFROKC3WcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4D7113A7E;
	Fri,  8 Aug 2025 14:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rqHdKy0QlmjnOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Aug 2025 14:56:45 +0000
Date: Fri, 8 Aug 2025 16:56:40 +0200
From: David Sterba <dsterba@suse.cz>
To: sawara04.o@gmail.com
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, brauner@kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: restore mount option info messages during mount
Message-ID: <20250808145640.GT6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250728020719.37318-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728020719.37318-1-sawara04.o@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.50

On Mon, Jul 28, 2025 at 11:07:18AM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> After the fsconfig migration, mount option info messages are no longer
> displayed during mount operations because btrfs_emit_options() is only
> called during remount, not during initial mount.
> 
> Fix this by calling btrfs_emit_options() in btrfs_fill_super() after
> open_ctree() succeeds. Additionally, prevent log duplication by ensuring
> btrfs_check_options() handles validation with warn-level and err-level
> messages, while btrfs_emit_options() provides info-level messages.
> 
> Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>

You're right, the options are not printed.

> ---
>  fs/btrfs/super.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a0c65adce1ab..de4e01abc599 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -88,6 +88,9 @@ struct btrfs_fs_context {
>  	refcount_t refs;
>  };
>  
> +static void btrfs_emit_options(struct btrfs_fs_info *info,
> +			       struct btrfs_fs_context *old);
> +
>  enum {
>  	Opt_acl,
>  	Opt_clear_cache,
> @@ -689,12 +692,9 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
>  
>  	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
>  		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
> -			btrfs_info(info, "disk space caching is enabled");
>  			btrfs_warn(info,
>  "space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2");
>  		}
> -		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
> -			btrfs_info(info, "using free-space-tree");
>  	}
>  
>  	return ret;
> @@ -971,6 +971,8 @@ static int btrfs_fill_super(struct super_block *sb,
>  		return err;
>  	}
>  
> +	btrfs_emit_options(fs_info, NULL);
> +
>  	inode = btrfs_iget(BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
>  	if (IS_ERR(inode)) {
>  		err = PTR_ERR(inode);
> @@ -1428,7 +1430,6 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
>  {
>  	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
>  	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
> -	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");

Shouldn't this rather be NODATACOW? The logic around the option is the
same as for NODATASUM, but for some reason NODATACOW is under
btrfs_info_if_unset() call.

>  	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
>  	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
>  	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
> -- 
> 2.50.1
> 


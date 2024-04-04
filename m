Return-Path: <linux-btrfs+bounces-3934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4A898F3D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 21:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B23A282E4A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9C134743;
	Thu,  4 Apr 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nj/C3MAl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PP4L2GS8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ji3QTxuq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kwfam1vJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92CA74C14;
	Thu,  4 Apr 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260404; cv=none; b=aBHU6zlCNq2ehSLaZw5Yccuf0w9f1gBGOlrVnAs4qj3FWGA6v90ujSiWMCefzAeeZu90728huDo3oWB3mMpUZqP0UOj/NsNd4fcsgg84h8Q1Um87DVLSq+R0OQo1KHBmeriBT/hJaH3Ltcuoxm7+IIaptxvqClQX0g5O7XA+oXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260404; c=relaxed/simple;
	bh=WIaxxb/wJKgOnX2AIsmocmXM/m0z3iob9NXxQddI4Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZoAVwnHGAJE41mhjTP+4ISLlCHMpOBjGznWfiM4yemOoVTWkcmrGcMiVukkaDsLhYGNp/KzS5zuF6eohMwHKokfqrmGfF3Xg2kTwKQAbJP5j4J0rG5JflByDwEhNYAb1w+nDNCFVXayiAQcyGsBCI5gU98JnfIBRKI/RywOIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nj/C3MAl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PP4L2GS8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ji3QTxuq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kwfam1vJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFF871F441;
	Thu,  4 Apr 2024 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712260401;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kGyYdvz1lGwPR6FgbkygCOdLQOLaJs4yjJ3ECXl6LI=;
	b=nj/C3MAlqmkQc/GHgjaqRmYlbJS+5xTV1FMACJvdtg8riSwbl++lq296aqqMGgyVrvVJC+
	g70q7Vn4mDLP5A5HEt0Ei/di0p/ZpZI4M7Ph4s/OBODN9ToGvX17KRfxIaUd+FDzzG/Lec
	vmNUvz2jeguhSMPPHk6DOKhGyrgtkg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712260401;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kGyYdvz1lGwPR6FgbkygCOdLQOLaJs4yjJ3ECXl6LI=;
	b=PP4L2GS8ki1HoCI3//JngIKC4kPQe4Y2WWYWVHX2hQ1snir6WrP+yDv2IDE0jK5yQT9oFr
	AjKHp1X2QpNTkVDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ji3QTxuq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Kwfam1vJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712260400;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kGyYdvz1lGwPR6FgbkygCOdLQOLaJs4yjJ3ECXl6LI=;
	b=ji3QTxuqAvPTAwRGLGMxv6NvIlKIvxIauFBNnrqBXlle6B5cnXc163/s7WIjZH/fdlG+uL
	r/+6ACCwIy+WHlSgHvSJDQe23uCaCHtAitBgBANDtAn7deEPJ9h2jE87HqtwC3r+Fb2emb
	5m4G4RYKxYU7dwIq5h5TSLGEzqwxjCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712260400;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kGyYdvz1lGwPR6FgbkygCOdLQOLaJs4yjJ3ECXl6LI=;
	b=Kwfam1vJR4+biIZroMqZaewwhFLWPbJLzQxsjs4IEXmgvyj6PnMIiIMfEOivT6zj8icM7p
	xM7jzxhWCQ61E2Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C4F6613298;
	Thu,  4 Apr 2024 19:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wxDyLzAFD2ZSbAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 04 Apr 2024 19:53:20 +0000
Date: Thu, 4 Apr 2024 21:45:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, hch@lst.de,
	Damien LeMoal <dlemoal@kernel.org>, Boris Burkov <boris@bur.io>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH RFC PATCH 3/3] btrfs: zoned: kick cleaner kthread if low
 on space
Message-ID: <20240404194558.GK14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-3-4cd558959407@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-hans-v1-3-4cd558959407@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -1.38
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DFF871F441
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.38 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.17)[69.78%];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu, Mar 28, 2024 at 02:56:33PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Kick the cleaner kthread on chunk allocation if we're slowly running out
> of usable space on a zoned filesystem.

For zoned mode it makes more sense, as Boris noted it could be done for
non-zoned too but maybe based on additional criteria as reusing the
space is easier.

Also cleaner does several things so it may start doing subvolume
cleaning or defragmentation at the worst time.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index fb8707f4cab5..25c1a17873db 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1040,6 +1040,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>  u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  				 u64 hole_end, u64 num_bytes)
>  {
> +	struct btrfs_fs_info *fs_info = device->fs_info;
>  	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>  	const u8 shift = zinfo->zone_size_shift;
>  	u64 nzones = num_bytes >> shift;
> @@ -1051,6 +1052,11 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
>  	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
>  
> +	if (!test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags) &&
> +	    btrfs_zoned_should_reclaim(fs_info)) {
> +		wake_up_process(fs_info->cleaner_kthread);

You can drop the BTRFS_FS_CLEANER_RUNNING condition, this is not a
performance sensitive where the wake up of an already running process
would hurt.

> +	}
> +
>  	while (pos < hole_end) {
>  		begin = pos >> shift;
>  		end = begin + nzones;
> 
> -- 
> 2.35.3
> 


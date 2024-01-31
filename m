Return-Path: <linux-btrfs+bounces-1973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA318447C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 20:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9BB1F23712
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE19B36AF9;
	Wed, 31 Jan 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ejkRL1O4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tprqOyEa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EDQkfRMU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLxvMOpV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C83374CF
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727931; cv=none; b=XtGehfooIOb+HZHQpj0U/8cyIJwsd05ifnAFJpZypqQgWsYib7FFMaRGMtn+D2YKXPGBC+Mf2UdWyEm6e/vAvAHfiivmsFluNqhr9FxxMOPHiaojTGPkGMnERPN/gEiU7cKyOMPMEkkaMetgLUtyTCtQVwv65oM726pJCgGYFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727931; c=relaxed/simple;
	bh=cqbL4TnxI3BWdybHVeUJ0a/A9ueRAUNBVIR3iMOGrII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9viHtbKvoMxow8pE6DW3o2n5e9jc298oIDCaBwUakP3eXRFlU/n1ZU7NMaY/GOC3m9LSv84kCFShXSh8CjF3/K24/P6PUkRSKR3mfOHTSA+xu7nMcXNDG7vsp2LKsr5V5hDHASBj4iOQpqwPiZ+sX8DtRMetLKa9cQ0hpe9hE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ejkRL1O4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tprqOyEa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EDQkfRMU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FLxvMOpV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81499220CB;
	Wed, 31 Jan 2024 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706727927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFY4Ye2Xke4XA3PIWDaCe2Qho3T9I4x5wzI4m/rioIU=;
	b=ejkRL1O4b2mkwd3/q1MbMK8PId5IZXDoDkq+1OMlzpNB45/c4dw45vNZi/9Yv2y7eXmfBb
	ahoMexemfkO2JitBko+rCqYIl7Zvtczx4fRnh9a4nuFtuDqMQQ/RBpA4NPYsH0j0wJJVWR
	zkGtBWoeueU1RG+BHlkdpTgvHoumQgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706727927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFY4Ye2Xke4XA3PIWDaCe2Qho3T9I4x5wzI4m/rioIU=;
	b=tprqOyEafku+Rv9cKM6ireq/BaCBhbKTpcxCx4UWzVZO02TPqcSq+pV29f5VNxEMpreF3Y
	ngDlTNeyLeQJdnAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706727925;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFY4Ye2Xke4XA3PIWDaCe2Qho3T9I4x5wzI4m/rioIU=;
	b=EDQkfRMUs1aFz1BSSdEYDFZpkLRi3iOwRyb9jG2WdhnT7K2u/eYBDeynWWNlNOJT08tb/G
	JioxN4lmFjJj4lvYFt8e76AVWmALQ6H0fYsdMzWcnVnog8rk9R616afdaclpvKaYTpm499
	KqpkwBhaKHkaCmme20f/aK/HQgk625o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706727925;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFY4Ye2Xke4XA3PIWDaCe2Qho3T9I4x5wzI4m/rioIU=;
	b=FLxvMOpVWpukWG6DwPQmMQDiAIZq+66zY/YNGvaHu5Xjk0jAYiYAnzf55e49q5X+4kD5BQ
	SWZQvqkrIwZ2I/Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 56806132FA;
	Wed, 31 Jan 2024 19:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XweUFPWZumVxLgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 19:05:25 +0000
Date: Wed, 31 Jan 2024 20:04:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wangyugui@e16-tech.com, clm@meta.com,
	hch@lst.de
Subject: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Message-ID: <20240131190459.GS31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Wed, Jan 31, 2024 at 04:13:45PM +0900, Naohiro Aota wrote:
> We disable offloading checksum to workqueues and do it synchronously when
> the checksum algorithm is fast. However, as reported in the link below,
> RAID0 with multiple devices may suffer from the sync checksum, because
> "fast checksum" is still not fast enough to catch up RAID0 writing.
> 
> To measure the effectiveness of sync checksum for developers, it would be
> better to have a switch for the sync checksum under CONFIG_BTRFS_DEBUG
> hood.
> 
> This commit introduces fs_devices->sync_csum_mode for CONFIG_BTRFS_DEBUG,

Please rename it to offload_checksums, this also inverts the logic but
is IMHO clear what it does.

> so that a btrfs developer can change the behavior by writing to
> /sys/fs/btrfs/<uuid>/sync_csum. The default is "auto" which is the same as
> the previous behavior. Or, you can set "on" or "off" to always/never use
> sync checksum.
> 
> More benchmark should be collected with this knob to implement a proper
> criteria to enable/disable sync checksum.
> 
> Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> v2:
> - Call it "sync checksum" properly
> - Removed a patch to automatically change checksum behavior
> - Hide the sysfs interface under CONFIG_BTRFS_DEBUG
> ---
>  fs/btrfs/bio.c     | 13 ++++++++++++-
>  fs/btrfs/sysfs.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h | 23 +++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 960b81718e29..c896d3cd792b 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -608,8 +608,19 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
>  
>  static bool should_async_write(struct btrfs_bio *bbio)
>  {
> +	bool auto_csum_mode = true;
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
> +
> +	if (fs_devices->sync_csum_mode == BTRFS_SYNC_CSUM_FORCE_ON)
> +		return false;
> +
> +	auto_csum_mode = fs_devices->sync_csum_mode == BTRFS_SYNC_CSUM_AUTO;
> +#endif
> +
>  	/* Submit synchronously if the checksum implementation is fast. */
> -	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> +	if (auto_csum_mode && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>  		return false;
>  
>  	/*
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 84c05246ffd8..ea1e54149ef4 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1306,6 +1306,46 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
>  BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
>  	      btrfs_bg_reclaim_threshold_store);
>  
> +#ifdef CONFIG_BTRFS_DEBUG
> +static ssize_t btrfs_sync_csum_show(struct kobject *kobj,
> +				    struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	switch (fs_devices->sync_csum_mode) {
> +	case BTRFS_SYNC_CSUM_AUTO:
> +		return sysfs_emit(buf, "auto\n");
> +	case BTRFS_SYNC_CSUM_FORCE_ON:
> +		return sysfs_emit(buf, "on\n");
> +	case BTRFS_SYNC_CSUM_FORCE_OFF:
> +		return sysfs_emit(buf, "off\n");

We're using numeric indicators for on/off in other sysfs files, though
here it's a bit more readable.

> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t btrfs_sync_csum_store(struct kobject *kobj,
> +				     struct kobj_attribute *a, const char *buf,
> +				     size_t len)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	if (sysfs_streq(buf, "auto"))

Please use kstrobool, it accepts awide range of "yes/no" values and
check for "auto" only after it returns -EINVAL.

> +		fs_devices->sync_csum_mode = BTRFS_SYNC_CSUM_AUTO;
> +	else if (sysfs_streq(buf, "on"))
> +		fs_devices->sync_csum_mode = BTRFS_SYNC_CSUM_FORCE_ON;
> +	else if (sysfs_streq(buf, "off"))
> +		fs_devices->sync_csum_mode = BTRFS_SYNC_CSUM_FORCE_OFF;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +	return -EINVAL;
> +}


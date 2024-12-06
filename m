Return-Path: <linux-btrfs+bounces-10095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9769E767A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 17:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BDC282ECD
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC71F3D39;
	Fri,  6 Dec 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DyezTirO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3TmMWoOb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DyezTirO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3TmMWoOb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CB206262
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504041; cv=none; b=qMvbqVNK3u+5chkR7fCo9THWeTFqnYWWjtPygyWQVyOVbmLkFVcPgOM7/8OTATiIEGC1VlAjGQpg1ahQYUZ0MySKKwWuXCiBEUjsW/lgYeRyWX1u8GmOffhuPinnHAWG/en196vLC/toDvYMmrsSF0VpqUcgm+UoiGxHTQF9Ck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504041; c=relaxed/simple;
	bh=4+f1hRsuL2d8/VFTmZ5iMO2gTb7x5FyXGfLdfR1UuYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psqT10wYhuXKSQm8g9QopVXJiINGw0Tfy8bFw8oUFCWpV5m8P3hbnmD8U5W2IssRNDS4MmavK4HJCyJ9Idg/KIKj2YwAOnOFubo5vRhCbGf+13bsmP45VdctAKX3L/VwYaXYpvYPAy9U8E743r8RDkOCRPVH1xkDzvJ82U4ElXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DyezTirO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3TmMWoOb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DyezTirO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3TmMWoOb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78BD21F37E;
	Fri,  6 Dec 2024 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733504037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTarlJzKPNsRCrHqt/kOdY2thVJJ3g9WeZi3fnnF1VY=;
	b=DyezTirOG/Wo3le/BU8z9mJ7TJuY2+jNI9791341oUD4IpedWP5y8hLmpyHdr0OCHWD9NF
	G4cmev9iA+1BHgGf1qSgIBiwjGU4uF6bN8QU/BhfNs9I4vEJhbSBs9kxEEmcfmUbNmXqZi
	Ct9s+yzpDn3zNMx/EMAuse0GaKYJ3ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733504037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTarlJzKPNsRCrHqt/kOdY2thVJJ3g9WeZi3fnnF1VY=;
	b=3TmMWoOb8t3oRgyrEWZdbhoPplBb6YrNaYn2pDadW9CvSdNFWT4DoHb2V46vpdgRzEBthG
	wMDlNnR2bspZjNCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733504037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTarlJzKPNsRCrHqt/kOdY2thVJJ3g9WeZi3fnnF1VY=;
	b=DyezTirOG/Wo3le/BU8z9mJ7TJuY2+jNI9791341oUD4IpedWP5y8hLmpyHdr0OCHWD9NF
	G4cmev9iA+1BHgGf1qSgIBiwjGU4uF6bN8QU/BhfNs9I4vEJhbSBs9kxEEmcfmUbNmXqZi
	Ct9s+yzpDn3zNMx/EMAuse0GaKYJ3ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733504037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTarlJzKPNsRCrHqt/kOdY2thVJJ3g9WeZi3fnnF1VY=;
	b=3TmMWoOb8t3oRgyrEWZdbhoPplBb6YrNaYn2pDadW9CvSdNFWT4DoHb2V46vpdgRzEBthG
	wMDlNnR2bspZjNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48E2C138A7;
	Fri,  6 Dec 2024 16:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZDSSESUsU2cxFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 16:53:57 +0000
Date: Fri, 6 Dec 2024 17:53:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v3 04/10] btrfs: handle value associated with raid1
 balancing parameter
Message-ID: <20241206165341.GG31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731076425.git.anand.jain@oracle.com>
 <aab2735202ac9624d32d637f097df874fa217ebc.1731076425.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab2735202ac9624d32d637f097df874fa217ebc.1731076425.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Nov 15, 2024 at 10:54:04PM +0800, Anand Jain wrote:
> This change enables specifying additional configuration values alongside
> the raid1 balancing / read policy in a single input string.
> 
> Updated btrfs_read_policy_to_enum() to parse and handle a value associated
> with the policy in the format `policy:value`, the value part if present is
> converted 64-bit integer. Update btrfs_read_policy_store() to accommodate
> the new parameter.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 7506818ec45f..7907507b8ced 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1307,8 +1307,11 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>  
>  static const char * const btrfs_read_policy_name[] = { "pid" };
>  
> -static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
> +static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)

Why is value signed type?

>  {
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	char *value_str;
> +#endif

Please keep the inline #ifdefs to minimum, with __maybe_unused there
won't be any warning if experimental build is disabled.

>  	bool found = false;
>  	enum btrfs_read_policy index;
>  	char *param;
> @@ -1320,6 +1323,18 @@ static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
>  	if (!param)
>  		return -ENOMEM;
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	/* Separate value from input in policy:value format. */
> +	if ((value_str = strchr(param, ':'))) {
> +		*value_str = '\0';
> +		value_str++;
> +		if (value && kstrtou64(value_str, 10, value) != 0) {

You can assume that the 'value' is always non zero and assert it at the
beginning of the function.

> +			kfree(param);
> +			return -EINVAL;

A negative errno in a function returning enum looks quite strange,
either add an enum type for invalid value or use 'int'.

> +		}
> +	}
> +#endif
> +
>  	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
>  		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
>  			found = true;
> @@ -1367,8 +1382,9 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>  {
>  	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>  	enum btrfs_read_policy index;
> +	s64 value = -1;
>  
> -	index = btrfs_read_policy_to_enum(buf);
> +	index = btrfs_read_policy_to_enum(buf, &value);
>  	if (index == -EINVAL)
>  		return -EINVAL;
>  
> -- 
> 2.46.1
> 


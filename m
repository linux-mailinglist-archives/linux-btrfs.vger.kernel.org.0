Return-Path: <linux-btrfs+bounces-22203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IduD7iHp2nOiAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22203-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 02:15:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB51F9287
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 02:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CDA30B2C94
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 01:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C8307AC6;
	Wed,  4 Mar 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpB51/v8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C34BA21
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586842; cv=none; b=CeJL0Twfl//1HqAbTdeIaW6mOavUe+Nd0sMcOqdOQTYZKZyWqqN6Vhj8R9rlvL0zBGx4ltXmrS64R4P/ddimWAcWN42cPbmiwCcKXoDapsWE0M0f2/jLmxePoXrbN/l8k0Bz+mi6L5qqujAw6nSBihcftdZYjia0tkHowjVI+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586842; c=relaxed/simple;
	bh=OcolgTwlhvBYoSljfco6i5mLqIX9B+y3otjVgM4yhN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNQLAzhJTwzuzhebb4+YBzwjaJcxZAvJEm/ZiojmVgZ6gjI9CFD+oC/qVrR4brSkTnwzNUnFhTABsGJHa4Ox2Pi4r1kT93jajHqLb7RXdPt3qBkPGZybj6rNIOWX4Vq4nae/GHCvsjhm7Knc+czX6X7jlssd7Tuj3b7zFfLVgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpB51/v8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C2EC116C6;
	Wed,  4 Mar 2026 01:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772586842;
	bh=OcolgTwlhvBYoSljfco6i5mLqIX9B+y3otjVgM4yhN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JpB51/v8GEhXMpW2+Ali+x2fnjW0adSnlX1Va0DXhEHNcO8TuIlZjof9dzu+5V4iQ
	 NLUQGM9Jh0KgbWEAY+WzMFZnT/h2bANL0c4qvY4OAAEcNDqcNwUnYtTtd65cPswLV2
	 /9EHujrXNuO7udR7h2IiglHerBhYA5/xJ9uJJRQyfjWzuntNalqrMYHlnX/vkgWT/3
	 j4lW9v61I5Ia9vGudxSOOwY2YIMsrTJQHUWp73X/wGzM8EG8tOskZvaeNeLtZfG4Sr
	 dn3C2NNf8FSerUzTZsMfx5ORkYYseIFaAoXr7nT5xT4m/uKzxm2T/ePTPf66cFgbls
	 Lg+23/sfWX2Zw==
Message-ID: <4586e122-f97b-4db8-940a-05dcf04fafaa@kernel.org>
Date: Wed, 4 Mar 2026 10:14:00 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't take device_list_mutext when quering zone
 info
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
References: <20260303105346.215439-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260303105346.215439-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8CCB51F9287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22203-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On 3/3/26 19:53, Johannes Thumshirn wrote:
> Shin'ichiro reported sporadic hangs when running generic/013 in our CI
> system. When enabling lockdep, there is a lockdep splat when calling
> btrfs_get_dev_zone_info_all_devices() in the mount path that can be
> triggered by i.e. generic/013:
> 

[...]

> 
> Don't hold the device_list_mutex while calling into
> btrfs_get_dev_zone_info() in btrfs_get_dev_zone_info_all_devices() to
> mitigate the issue. This is safe, as no other thread can touch the device
> list at the moment of execution.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me, modulo one nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  fs/btrfs/zoned.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 851b0de7bed7..df44586af57f 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -337,7 +337,10 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
>  	if (!btrfs_fs_incompat(fs_info, ZONED))
>  		return 0;
>  
> -	mutex_lock(&fs_devices->device_list_mutex);
> +	/*
> +	 * No need to take the device_list mutex here, we're still in the mount
> +	 * path and devices cannot be added to removed from the list yet.

s/added to removed from/added to or removed from

> +	 */
>  	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>  		/* We can skip reading of zone info for missing devices */
>  		if (!device->bdev)
> @@ -347,7 +350,6 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
>  		if (ret)
>  			break;
>  	}
> -	mutex_unlock(&fs_devices->device_list_mutex);
>  
>  	return ret;
>  }


-- 
Damien Le Moal
Western Digital Research


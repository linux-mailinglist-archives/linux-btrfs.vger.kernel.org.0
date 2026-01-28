Return-Path: <linux-btrfs+bounces-21159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF5OE8fFeWl0zAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21159-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:16:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF59E1C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62D08301BF46
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB230BF66;
	Wed, 28 Jan 2026 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W6qGaDij"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB415A86D
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588127; cv=none; b=RDk6YOLdrPMGhPpQQslVhUTLp8Ws6+VvhDbbDihYREhQdj5syXpF5ahGwWRSE9gV6BFkctz4w5u9ocX3zs8/+3kAiPpqyJV6vYRRheIPmMr+vv4pQ0wqqM/q4X6DiNG8FKTpbL97EJTV4OTcAx/3YiQoClZDt/L8/Pdy4Z8ecu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588127; c=relaxed/simple;
	bh=17OXzbYv2wYAi7NxDXBgqTMm4xWwXNbnE+zOoU2P1BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTPbkNpfh2H2OGxnj30DaKQp+R+ZLDiw+rrDWXvphHESBHcZw4c8gAnp4PaUDYkPVOhr8N/vEjEFMjYVZCwVi8GB0zmP6AVDbHynW4ntjibJmaX8YnNHktA7/6tSTC36sIxPkyxQc8MKIAhk+jQ+j6fry6UafukaXi0lI3vq4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W6qGaDij; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4807068eacbso1706555e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 00:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769588124; x=1770192924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zE780DCks8ZX8VY8GddINU1g3LpvS8/ODEkl+CovFfQ=;
        b=W6qGaDijMjltmZM2+13chyeYD3LIW7Y1qJRxI+X4VbqUzknWewZCMzwFXzJQCzdJQG
         zFrOwWvRfLqXxLG/AbT6Byi4FyroGcElrdKpsr/XsUAZQaTj5HtTClG4fvlvzXkqDM7W
         g9ogXKHnH+hPKIFs5KR7qyCb9XXS2G0Ke1jop7shpZwO5c+1jvVyWtv5859FyR1Ng/C4
         MyKjnrNvYlepNnPm+62+sDQfs311tXVKJ1ZJvTXmx8rRS5roUozdC///dTfB/iHVXGIu
         MFhcuEW0i50RNkjcnfSrzGYYXmL1U/niWAxxprFJirBh7fsmHxT7rhnxkhg5HBWjxm0Q
         8NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769588124; x=1770192924;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE780DCks8ZX8VY8GddINU1g3LpvS8/ODEkl+CovFfQ=;
        b=poL6JM+PnKSPjQD8AucPR5dVxDr3aWeeVMBopoqMnIAHNrjxmrWbTcdAb/f2hvEVhH
         Z9iYhFMYNj16dKJK1V6Sc/W0QidGkWws9//WDXfRiizfa4+bhFhEN/QBHa5/olumG1Rb
         10lnMIOouhWvfY0QMJbwonmRFKMl3bQI0ATMbV0KeIeHGEO6/+4qbp1SVya6TGr/Sa5u
         85B9K01sGDB4Iy81qhNMwtsniN4RGuHgwFZyb77T0QbjwGTfOGVA2tQL/g2U2H3EettW
         RZ7u61pWcZmEglb685Hcu4RiKh+BL4euJqOgzDnsxxRE9cU4WaVkL6jtyhbIVIqep7Qo
         gtrg==
X-Forwarded-Encrypted: i=1; AJvYcCWuQMuH6OsYGk/1+2Pr0ozVSj7J/TrZEOqyecbnznq9skzt2gyZno+SF4+Udza8Cvl/65eK+P7Znwyb5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/MUMKCVc9SZEckhwmWgR5kdtM5O26MLAYWDOCl06sqBcpWQ0
	5NBC68muZyG5M/4qphUlh2wkpYkSv7xW0i1PlF8dUk4UKsL0iHkjWY7/gyI7u80ZIIM=
X-Gm-Gg: AZuq6aIr+ZMpnnpJvljYArzpqy8WJCmzKNXF4BafdglYjAs7JUnf8bQTA8lBHtgpGLV
	Dlls46m1d13QMw5X6Q+1pdtg/THhUAfx+HAOmBd1mSqWDM9lb2WFUTPeKaFcJniOH4+7B9pOVXo
	pQBv+alV0mM6A/0W6xNhESRWEai5psZmhREKONj7lGDY5CDdtiTTEQM6z2GcDp+BHzuuKqfNHsb
	tTXxEYhE9GJYWSOUnDX8ndvscrcEzCi7vIYvwQvRR+o6y2aJGWKowH7qebQfD8YClQJg1fN48Eu
	uPMFfn21avPXKDHvnnJFIgOnujHNoO8FmZyD4RMA426RQJSn0Mz/ZzkkaUA3j6/QfC/G8xaw9Km
	u5olchVKiPNhRBSzZxz5QTncUCGzDwDFwmTCTdelXB9WQW35xE+z79BaEmt8ZVlBk730jDAyCat
	p8yqPVwU2aCuoQ6L4Rw9Zh10qNzgx3wr86KXAVJD0=
X-Received: by 2002:a05:600c:8b6b:b0:47e:e946:3a59 with SMTP id 5b1f17b1804b1-48069c92effmr53974785e9.34.1769588124182;
        Wed, 28 Jan 2026 00:15:24 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c32944sm1771878b3a.57.2026.01.28.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 00:15:23 -0800 (PST)
Message-ID: <c08ea844-1cb2-4110-a0f7-e437beb193f5@suse.com>
Date: Wed, 28 Jan 2026 18:45:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] btrfs: preserve first error in btrfs_trim_fs
To: jinbaohong <jinbaohong@synology.com>, linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org, dsterba@suse.com, Robbie Ko <robbieko@synology.com>
References: <20260128070641.826722-1-jinbaohong@synology.com>
 <20260128070641.826722-3-jinbaohong@synology.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260128070641.826722-3-jinbaohong@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21159-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9BBF59E1C9
X-Rspamd-Action: no action



在 2026/1/28 17:36, jinbaohong 写道:
> When multiple block groups or devices fail during trim, preserve the
> first error encountered rather than the last one. The first error is
> typically more useful for debugging as it represents the original
> failure, while subsequent errors may be cascading effects.
> 
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: jinbaohong <jinbaohong@synology.com>

The comment of btrfs_trim_fs() is still saying the return value is the 
last error.

Otherwise looks good to me.

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index bd167466b770..6c49465c0632 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6653,7 +6653,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   				ret = btrfs_cache_block_group(cache, true);
>   				if (ret) {
>   					bg_failed++;
> -					bg_ret = ret;
> +					if (!bg_ret)
> +						bg_ret = ret;
>   					continue;
>   				}
>   			}
> @@ -6666,7 +6667,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   			trimmed += group_trimmed;
>   			if (ret) {
>   				bg_failed++;
> -				bg_ret = ret;
> +				if (!bg_ret)
> +					bg_ret = ret;
>   				continue;
>   			}
>   		}
> @@ -6674,7 +6676,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	if (bg_failed)
>   		btrfs_warn(fs_info,
> -			"failed to trim %llu block group(s), last error %d",
> +			"failed to trim %llu block group(s), first error %d",
>   			bg_failed, bg_ret);
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
> @@ -6687,7 +6689,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   		trimmed += group_trimmed;
>   		if (ret) {
>   			dev_failed++;
> -			dev_ret = ret;
> +			if (!dev_ret)
> +				dev_ret = ret;
>   			continue;
>   		}
>   	}
> @@ -6695,7 +6698,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	if (dev_failed)
>   		btrfs_warn(fs_info,
> -			"failed to trim %llu device(s), last error %d",
> +			"failed to trim %llu device(s), first error %d",
>   			dev_failed, dev_ret);
>   	range->len = trimmed;
>   	if (bg_ret)



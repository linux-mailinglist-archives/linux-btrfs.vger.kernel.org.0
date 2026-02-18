Return-Path: <linux-btrfs+bounces-21766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMUYAy0jlmkXbAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21766-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 21:38:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F621597B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 21:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E41B23006836
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F3E348875;
	Wed, 18 Feb 2026 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H1l0Ce08"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E4345CC0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447082; cv=none; b=G+lox342G1FryIaPhoM3iHAQRioKLkC277DIE5PAa6NSnFN2IQqsEf6N3GDMwspNXa6qBXmyV0PLe4rneP6Hs4B9d58TDlV6I3U2z0qyRCqbCr5RuvzoTsFs4f0UelZ8wXggDGPGxJF3tJjPPRl25FI2RZZCloT4U5eDFF5AVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447082; c=relaxed/simple;
	bh=wBji7qpio7DhM/Yd2890xruLWG1KczJQxyAZ5Ps8TDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lro5aA9npdwotqgdA1jT8FCfKyx+NoQ35fawF6Oin77SIJmKSZlPRE1CeTK58aMJfZ2qYzTTmlgtyjYBxmMuU5IujknUwuZudxJyb4t8sPz1laN44w/fPzElm4/6Vt9hxoUr5fSL9i5Rjs9QT0eZcrQl7Mhm0HEWMgpECP/Hpuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H1l0Ce08; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483770e0b25so2885855e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771447079; x=1772051879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m91MB5ynbSYz9+X/GXNmK9UaOYnlSfpd0kkTft/H7eY=;
        b=H1l0Ce08aL2/FiSPlTzUbCJl5ncOq9hz5Rcid6eqsT6lCifKg+G2kIsp+QUqTnAuVP
         WTwiAjdzyHvfG0EpIUBEr+RRJXPHpd/Jc7PlI+AQVNMhjdIvDfvoUFqG9LqEkR10zNcQ
         LD47VtBlb/crjn94aBMuDXeeK+MhgRdumegacVoS1OT1MFYTVsWQPq2xh01m9zK7JzOh
         TZG3yg4JMnHTdgWAtOiSkWg+SFUZKgz25axT+LLxWe5v/SORjayIZ13FB/OurhW5h0lE
         fhS5F4hCyISVspOYSxhyPO8FiVQ+jacPcCJI4KPJtBppYJIT+0VcrYMQSXn44RrIPdXg
         9nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771447079; x=1772051879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m91MB5ynbSYz9+X/GXNmK9UaOYnlSfpd0kkTft/H7eY=;
        b=PU4u7JQW712KrXzmNrkReI92ri9t0hG0dXN9TiRfGkoQxpr7N74r5MTRAKX7H0X39O
         RVuxQrHl/33Vd5NWG6rfY/NqtHm9nr5rKjwjfn8OiL4DVxo70WJFc8WqKAOpZw3iN1Ul
         UIMdABlG6bAO+pqnCFZKhH/JpXgjR7eHSkwwOY14an+AZfEzRFAFyURruY6hQRqzgenQ
         TOzmrFUYlJrN0n3A9Jz4E/p2WxZzCgmnM/jAISxTwd1+KggIZOOaM3gNWU8cTT3udw9M
         aN5csXip453B0Hd348lqr0I+FTv4UwLuds36+G1NPdKEK8HPclvHRJb5J9xHuQXk3FQk
         I37A==
X-Forwarded-Encrypted: i=1; AJvYcCXmBEKJSqT5QQ05K2czbZ/lIfgQDZF3UfWt+D17ShH4Z/Ui0rGGuII62RpspdFQK5DMT4qW+RwDkf5h7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyctgPUepFX4ItcMOImrQqtbhuz3gyCysV1YvA9M0vNQ9YB/RSJ
	ggvPT1yerKaTY3bgNWq/eU/EpgmRpGkpcEjhUAy2b66RrJvoZh/3DAKrNPfAqh8gf7Ybg+DRWaE
	wV0DHpKQ=
X-Gm-Gg: AZuq6aI1JmcUjT2+Aube3nZ4yjpE5GEFCHYdj/y8wHWaVkphKAT/2B6tqGkkGptHbL+
	DWpuqlP6P7giRFL4RQvNzaPOHw6/pQOFYZb4jaTLfVwrSwdG8c4GI6QoMuHsL4GJq13Dj8tazki
	W1J5Oof0xQV6eKNftFHtjRf+MI2AoljxORpQLnKfsk8YiTaMR4SS8KL3O/pUvKrM8T1eyYJKHEj
	kHuLRZL6Divps3nJC5RJ85rQdQn869z3XXibv6GMF0CjWzqzcXtJwoDUu9hu0L2avhPpdqrxyB6
	yXaRQwxvni3FwLKv9ib/ZZyttGxISTmgXhfLnpIJ8wbRqniZxJT8IrDKnJnlVBgKGoRO3GxjqTu
	c0l0nKfEeDBoSCGXAQp96YQ7ReI0CMcf8HSJrZUAxiXs8+ZycLMZeXbrN7A6i0yTamuA1JDbsEE
	DF3ok/lEpUUmj3xQjzPmjjuD5lGK3yQceu7Usn3CSq8DH5RRdon5E=
X-Received: by 2002:a05:600c:6912:b0:483:709e:f22d with SMTP id 5b1f17b1804b1-4837108fc46mr321222395e9.27.1771447078793;
        Wed, 18 Feb 2026 12:37:58 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e6c0dbsm26180247a91.6.2026.02.18.12.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 12:37:58 -0800 (PST)
Message-ID: <be341f62-b4e2-4e25-9406-007b49a45c66@suse.com>
Date: Thu, 19 Feb 2026 07:07:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error messages in btrfs_check_features()
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
References: <20260218111346.31243-1-mark@harmstone.com>
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
In-Reply-To: <20260218111346.31243-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21766-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5F621597B3
X-Rspamd-Action: no action



在 2026/2/18 21:43, Mark Harmstone 写道:
> Commit d7f67ac9 introduced a regression when it comes to handling
> unsupported incompat or compat_ro flags. Beforehand we only printed the
> flags that we didn't recognize, afterwards we printed them all, which is
> less useful. Fix the error handling so it behaves like it used to.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: d7f67ac9a928 ("btrfs: relax block-group-tree feature dependency checks")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f39008591631..7478d1c50cca 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3176,7 +3176,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>   	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>   		btrfs_err(fs_info,
>   		"cannot mount because of unknown incompat features (0x%llx)",
> -		    incompat);
> +		    incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP);
>   		return -EINVAL;
>   	}
>   
> @@ -3208,7 +3208,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>   	if (compat_ro_unsupp && is_rw_mount) {
>   		btrfs_err(fs_info,
>   	"cannot mount read-write because of unknown compat_ro features (0x%llx)",
> -		       compat_ro);
> +		       compat_ro_unsupp);
>   		return -EINVAL;
>   	}
>   
> @@ -3221,7 +3221,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>   	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
>   		btrfs_err(fs_info,
>   "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
> -			  compat_ro);
> +			  compat_ro_unsupp);
>   		return -EINVAL;
>   	}
>   



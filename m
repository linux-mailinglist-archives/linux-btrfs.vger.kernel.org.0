Return-Path: <linux-btrfs+bounces-21332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OqlAptggmkzTQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21332-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 21:54:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3EDEA9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 21:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38FED3031CE0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ABF2FF14C;
	Tue,  3 Feb 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PxFPrjmE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA262ED87F
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152081; cv=none; b=JEd0xXMzu3Msm9hqypKo6iMJyvL2ccoGvID1ZSpgAP+FTOkrqrxNUolhGVOAJ8AwKav6XUfysWwtwIWqfolKrB+/luGOhDzLKWg2AWR5Q/pZ9YcZWWXS7tzC+0likzqdEykXFLzoB4DNaozf/a3y3B9ctNUcl2uRe9NuqbstCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152081; c=relaxed/simple;
	bh=PMP7wj3EaYfXTJTcMG/0zwDePo50++53aBwHDqd3F6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kFhIDVwkm1fDn08trnOvVFrZGRXLUDch9F/OQzc6VTQBqnvne5wqv6Nh0Jmn1dpdJ/LPplQ4D803Wbg5GDpWmXGPRFDitY6178fH8xzlA99io//p9PwBpY9PZGB5kBwIQQ/XF5gL6JkPVNTozQllybV63j+/3h6oM6fxe7UYQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PxFPrjmE; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee07570deso51183775e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 12:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770152078; x=1770756878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uF7nIRXSgakl5DbghyhGN0C1y3W2g34/laMk0S6cZ8s=;
        b=PxFPrjmEVigTvfvtaGB/df/lZ7EM+f5rIOJEAJTykv3OPe/Tyq+qrsYfgwhRfjiDey
         uBRP/eKcCozH2Zuko2jqlOrR9onHFliddsc/ffHsHR/pmm5m5zx2CNE18KlffrXW2MmA
         v9OyfPiSEKDq8T08omPuBo9Uu7B83r9pWvE4pKklvYO0Qp3XBUjfZwgELvoW5IbyvBA+
         AIf5rp7jVwYlPQm1e2H0PFPFi6ne7RjmT7vq8mC+knSX2TQArG+ofMaB3XBsXlvBNVci
         0Espp4sC/fP8TsZL+dh+G1PRRljDJKV6yGLIT3s2T4+HNL8x0ejoearw0ZBiOctBCBfW
         L3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770152078; x=1770756878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF7nIRXSgakl5DbghyhGN0C1y3W2g34/laMk0S6cZ8s=;
        b=wOAuCp9y2SSRlCR3CPzTIFg1mONij/cnMi8yzbDz23UndMwpKtJkQxirGtfab4kuAH
         ol9XF3JMF/C5J4RwS7lBWZKJVVMf5lsB4nn6w0QcD2mZ8UzbzioaMg1Zl6M3nmdDWVT+
         XGBeeXLgQUh7l3UKi933KtJukt8p65ruFbqqzgQbQQSWuQsRJszTcVkVk1o5X49jt4sl
         mkfW2N3cAVgn+FEdZNIycwCfMOb6MZpvL1MWouJOuCxg9XNDc6Kdu6gOjlH0oHfTSVsR
         zteTEYLwPH7CBfAOinh3gAznoOWIpW777KV454F65pEv+KMAJnbs0brElPrRKulOs6O6
         fbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF0zFufdLSXtjOLylNYMCsGs+0KrGtTr0lC7NTJq2InNedS36KPFEavEdRE2wLRnyAEwI6WlNrLyhNCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0cuQlKyxshPAb5mg7k7cYwhrs8EzmYr243gZh1mza3DUtC6M
	LOpM/BJSWoq3fuzHjsrcoGwnaI5KzzkSwQuA10/hTaXMDmD/XQfr3iwc/kXTQpm4f3/a3cEwfgg
	V6cY0ErE=
X-Gm-Gg: AZuq6aJp3ddOfNMK8kA42F8R8wIA9fafbhqN2cpuvCtzuiaR62KFDHn/IHcXFXtTess
	j4BTyD9c42KtjbEYP9PfTSTdvuFjMRAUPnC2fk15XaDKZIIoAUs2Kggxj8ahcNXW9DJKJV1YMda
	MfCj3gDErI4Y8pXz0Usg9+kov5jI3e13zbgVJH48EpEkRJKZdrsE7Q+TwoeVqLEtr6pzPrJOnV5
	ebZCYAmmAJjMOvmw84pO/gmUDnPP872nLsIy11BePdSEzigG6BLGbCNolH5zF2aun3nxg8WYnDw
	Qd57se0kxWyd6/hmQviCPRhb7xHtJ4IgefJQu25v0Ez51vsxlGg1PtBOgE7M90b4Et+IUt0HISY
	B8XlWWbC9I8Dcd6MJ2/T4NcSdA5MiDR8QmvU3HFqmWjagvhSNrv/d1Vqf/1u1vlLg9uJ5egzot1
	BMuJ6xXmxOHv4Vb8ggx7zamENp/YlovK9CDDV3Dd8=
X-Received: by 2002:a05:600c:6099:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-4830e93ebeemr12227805e9.5.1770152078392;
        Tue, 03 Feb 2026 12:54:38 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c83220654sm191645a12.13.2026.02.03.12.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 12:54:37 -0800 (PST)
Message-ID: <b8ac8e23-82ae-4cb0-bea5-53ee52289f48@suse.com>
Date: Wed, 4 Feb 2026 07:24:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: pass boolean literals as the last argument to
 inc_block_group_ro()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9d3d4dbe2624d72d34e3a7012caab2a26a3a6521.1770123608.git.fdmanana@suse.com>
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
In-Reply-To: <9d3d4dbe2624d72d34e3a7012caab2a26a3a6521.1770123608.git.fdmanana@suse.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21332-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 61E3EDEA9D
X-Rspamd-Action: no action



在 2026/2/3 23:32, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The last argument of inc_block_group_ro() is defined as a boolean, but
> every caller is passing an integer literal, 0 or 1 for false and true
> respectively. While this is not incorrect, as 0 and 1 are converted to
> false and true, it's less readable and somewhat awkward since the
> argument is defined as boolean. Replace 0 and 1 with false and true.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/block-group.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 3186ed4fd26d..262581d6da4d 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1663,7 +1663,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>   		spin_unlock(&space_info->lock);
>   
>   		/* We don't want to force the issue, only flip if it's ok. */
> -		ret = inc_block_group_ro(block_group, 0);
> +		ret = inc_block_group_ro(block_group, false);
>   		up_write(&space_info->groups_sem);
>   		if (ret < 0) {
>   			ret = 0;
> @@ -1993,7 +1993,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>   			goto next;
>   		}
>   
> -		ret = inc_block_group_ro(bg, 0);
> +		ret = inc_block_group_ro(bg, false);
>   		up_write(&space_info->groups_sem);
>   		if (ret < 0)
>   			goto next;
> @@ -2518,7 +2518,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   				btrfs_mark_bg_unused(cache);
>   		}
>   	} else {
> -		inc_block_group_ro(cache, 1);
> +		inc_block_group_ro(cache, true);
>   	}
>   
>   	return 0;
> @@ -2674,11 +2674,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   		list_for_each_entry(cache,
>   				&space_info->block_groups[BTRFS_RAID_RAID0],
>   				list)
> -			inc_block_group_ro(cache, 1);
> +			inc_block_group_ro(cache, true);
>   		list_for_each_entry(cache,
>   				&space_info->block_groups[BTRFS_RAID_SINGLE],
>   				list)
> -			inc_block_group_ro(cache, 1);
> +			inc_block_group_ro(cache, true);
>   	}
>   
>   	btrfs_init_global_block_rsv(info);
> @@ -3057,7 +3057,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   	 */
>   	if (sb_rdonly(fs_info->sb)) {
>   		mutex_lock(&fs_info->ro_block_group_mutex);
> -		ret = inc_block_group_ro(cache, 0);
> +		ret = inc_block_group_ro(cache, false);
>   		mutex_unlock(&fs_info->ro_block_group_mutex);
>   		return ret;
>   	}
> @@ -3108,7 +3108,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   		}
>   	}
>   
> -	ret = inc_block_group_ro(cache, 0);
> +	ret = inc_block_group_ro(cache, false);
>   	if (!ret)
>   		goto out;
>   	if (ret == -ETXTBSY)
> @@ -3135,7 +3135,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   	if (ret < 0)
>   		goto out;
>   
> -	ret = inc_block_group_ro(cache, 0);
> +	ret = inc_block_group_ro(cache, false);
>   	if (ret == -ETXTBSY)
>   		goto unlock_out;
>   out:



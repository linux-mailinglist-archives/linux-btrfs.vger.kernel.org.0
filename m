Return-Path: <linux-btrfs+bounces-11817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A3A44EB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 22:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2D53A9AB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425E20E6FB;
	Tue, 25 Feb 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WuVRlsDd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7A1A23BD
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518552; cv=none; b=IXBKER2omWkchNOMPJC0PWmkfYHXmYTZLIP6zCuTyBV4mzsCCZD2rleOdEsJbXiK3+i/FSxyTKh5emLcWvjpEiyNX6wC5u2mVwtWpFByJAq8PvMzXxhT5xP0ZTL2TTAJ2lq40/OzNLhhg78hyd3rt2R1YKOtuYD2iEjgbjU9dww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518552; c=relaxed/simple;
	bh=Xtnq3RhDI1F0mjpN2gEvr8f5Yewsi+xjtiZxWthnvNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3sm1foFotWSI5YmyUbe4v17i4KXFEwlEZ7+JGIrA6/ZQvX8K3VrdQQGpDTt6409+uD85E+U7WvMxZ64oMmoWvMAc0aD0YLD0HUFbVxUdPVZZ+vILmoX9BHsHT392s0070qN6t4rRmniGN8XsV50WV65CwQggZylpRK8y8tLzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WuVRlsDd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390cf7458f5so1049717f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740518548; x=1741123348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O+TAAzGVnDWDFtlFc6W2oZXUMNHkoRIXgVMUB+sYZ44=;
        b=WuVRlsDdDHW9/9DYpUB+jCcW3te6ln/6Lzv4xkbE8cwwHkT2XPDuqvjRW8X/nEUmqf
         Amk3KwA0hXk41TtoH/ewCea+XJ+ty+tiUKZW/xMquxxWWVRjYyjH4WKeCpLeO2Rdd+5H
         iyGhClxUc6A2g+CekSyB/faNLRtvPD74JmjtQnQkMLEME1Ugi7LeCBnND3sRdJM9UiBn
         5yCiHseawgYhmLjEDIFfkwNQz+Tm64TopRZ0c0Aq1V+ObrHPVRze18rsLBPetA+I3ZAd
         cpHSfupEdywGQR66uRgv/inXqbsayKgRq1KGVmITw1SIe666+w8RK6rkORwMuGsdxUlH
         aLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518548; x=1741123348;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+TAAzGVnDWDFtlFc6W2oZXUMNHkoRIXgVMUB+sYZ44=;
        b=cMuz2pyCMsv08TWgqaYKTLtSAF/jBMwPW/Vx29ntxk1S5icNjHhQk9BO/J4Jru4AIj
         Gv9DpBTRSzf19tRvVPyd0SZpAG3nuW7o+1CZvUdD28FbP/FQyf7qKEtc987bzWWgPsFH
         2BsAIfs9oS23vbUFBRhGAXEmg+eSGZyyGAeFnLPtBw4rLPOn0AGJxox1DoSCdB3JpT22
         X13H5N2mOLobWFcw6JT7qCgESsF07ybWj/vGQ6u+5SUekat+ipKZMl0rd0dWRVSYmqUC
         uzA2PoT+8yamIDJ1FL0pYjHJOnrzVL49kKCkBh8+BfDbLTUhy2HhuCBsvJUy7T40DlzI
         ESfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeQthYhOUvDo9K5XFJ98eAAJc1nGj9nmNACcFxl53Z7+SIFkMHKVKdgDLoQg/KYuC9Vll8PK+hmMEJsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFAJJuoJOWOtyOQORa+pwPeFi8RKsNiKiW9T+7WrsNba/p33k
	9qLWXhx0L0MAUoOqvslCHihSpjZAVLO8dGWY5KZ+HcbcbYnpLbtkmYkyf7gfMYw=
X-Gm-Gg: ASbGncuMHbxL8Y/j2Mmw62wkMm230cC0WFPWFjGP3OsYLQ1BzLWwCPNL6BjQGfls1ET
	Qxk/g0g46MZfaoYDq1eB5VzSveC7VyGu5eVXPkKOXwT8cNWnsGD3ehenX0sF78W93/sVhdsV4+K
	0DIsDw9uQB6PPwAnpzHbwPEwDTlmyfEkRmasq//3l5WTBUVYv1+6S+6EefJydl03wOaTOb4AEMo
	ajBRET5UVuxPWS/jBhZTcYUVhx+gzs3ifrhm73BjPrS6wgFVHDcDtGZsgj1dBLSYRECiScRl68f
	AeHDIBp2OSkG/OixdyHChW5a5udlVzjvc5Ng7Pa0UvI9h+x/zZ4Rsg==
X-Google-Smtp-Source: AGHT+IE75e9DPZfshqgcyz53q9QKQceztLXtBTDV3gXXaoLOI+hnMjNK3s6gZgjyBeOFutornyMF3w==
X-Received: by 2002:a05:6000:1549:b0:38d:df29:e14f with SMTP id ffacd0b85a97d-390cc631b46mr5227528f8f.43.1740518548098;
        Tue, 25 Feb 2025 13:22:28 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f7de2sm2065200b3a.106.2025.02.25.13.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:22:27 -0800 (PST)
Message-ID: <1cfc2f43-8ea4-4c39-b543-1f54ba9b284e@suse.com>
Date: Wed, 26 Feb 2025 07:52:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: use min_t() for mismatched type comparison
To: Arnd Bergmann <arnd@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@suse.com>,
 Li Zetao <lizetao1@huawei.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225194416.3076650-1-arnd@kernel.org>
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
In-Reply-To: <20250225194416.3076650-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/26 06:14, Arnd Bergmann 写道:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> loff_t is a signed type, so using min() to compare it against a u64
> causes a compiler warning:
> 
> fs/btrfs/extent_io.c:2497:13: error: call to '__compiletime_assert_728' declared with 'error' attribute: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
>   2497 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
>        |                           ^
> 
> Use min_t() instead.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502211908.aCcQQyEY-lkp@intel.com/
> Fixes: aba063bf9336 ("btrfs: prepare extent_io.c for future larger folio support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks a lot, those fixes will be merged into the next version.

For now the series is only for test purposes as there is a backlog of 
subpage block size related patches pending.

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f0a1da40d641..7dc996e7e249 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2485,7 +2485,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>   		 * code is just in case, but shouldn't actually be run.
>   		 */
>   		if (IS_ERR(folio)) {
> -			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
> +			cur_end = min_t(u64, round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
>   			cur_len = cur_end + 1 - cur;
>   			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
>   						       cur, cur_len, false);
> @@ -2494,7 +2494,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>   			continue;
>   		}
>   
> -		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
> +		cur_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1, end);
>   		cur_len = cur_end + 1 - cur;
>   
>   		ASSERT(folio_test_locked(folio));



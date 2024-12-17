Return-Path: <linux-btrfs+bounces-10458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FED9F4589
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9C7188CF87
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9BC1DB958;
	Tue, 17 Dec 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gw+ANYSc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5CD18A6AE
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422039; cv=none; b=YU9Egl2sMQkaFpZEFth0Y3ptDfD0XXLRlutOu/LtdLpfGzu8IlYhrSIwbxGJNy+fPsuphqmHr6KCmkmW1eHcU7HsQQE4vpscRRJ4Hqi19UeI4nqCUcDZwzTf2YWCUug/57Osaq9eZIKwwuqsgKSELyuiPg2zXQ7lpC8dshqSbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422039; c=relaxed/simple;
	bh=Bpu/O8gr/P186Ez+jiI9p9KSMiybkDvgAlyxwn1PupI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/oQbbYH/AOWO0VCqoydta+PcsfB/kkzDyj6oV8Dtc9BAFYWjzb6L8bxEo1aib7SqmWRnMAkO+NRYxYit/eWgdzEOfFilBLN2/BzhT23a0UuF38SXwQ24bXpdjxF65iZn3k+uC+x59KIw+CcTrs9ngFqNtkLxuhpjCMel13W1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gw+ANYSc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1569667f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 23:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422036; x=1735026836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wgPs939+JTOtFHfLHRar72zvOYaxxVBHfsyOFECZ2dY=;
        b=Gw+ANYSco3BJr4LtZRnt+0ZbTxYKo8DBN8nwQHpz92GuMlfFdQVT34bWGEcC4p7Nfn
         MV8o8nSTzQTp1G1jdnRetTyR8TG4ENBeUY+QRMuMINCHP8bn9Nr5jX4h2BXYTO/k48KY
         2kqWe8ditkEtsFaDfBx63/EQQW5XbRM2ytOKzYh5s9o4t+Wm9twck9h9JCkxdz6cL4pJ
         8nxSfOqbhHA7hwH+InuaWLPcEJibs4OHhECm+YIFtayi36UE4aVf9d2IWiCVrEHYM1ej
         RdOCcNJqhm4P7h3dd/ABnOJkY4O8E/s0/VVI5Mudp3fEvv54O5t/HuqmaeB982ZvvAOs
         9hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422036; x=1735026836;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgPs939+JTOtFHfLHRar72zvOYaxxVBHfsyOFECZ2dY=;
        b=jMiwGAvOPgWJ1ddfGR7Mk+9ZRPLJZUsc/sNDC5xcG3TpiVP45ZScJ4N6uBLVoGJRYo
         nHkl3HVF2Q0EKJ1lMgPAOETyHEUSPzo/hIU9ReSpNvNcYCkziIfF7MdR1Bfk7fCl0/6N
         k+X1MmTXR4l61WOSWE0mpGmSO0BYHVmbhFo75hpJ+2V9Yl3f3x6dBPpNgFlkCeJKHdua
         d+YWzUq3pQ6DSeRzBFZ63tHFjpsq39pEhP0VTtFI9sESUOBYeRthJ9zZD6/aKKVoMnQ6
         zShR1VjY54F0Bk57oemYREVrrtEiogMrH+6GoL39W5raw41almczF6c7dirWQ78BuRsb
         zV/w==
X-Gm-Message-State: AOJu0Yz+gfb2ooI4to12j4LYI+Rp39USQmYOvvUMJgMJ3BgII35F5AMP
	DnbHW6TS1oKAWablW4b1br+u9OjU6E0F18W/dGro22IlOhwKg6rwZUPDjq7m0fs=
X-Gm-Gg: ASbGncsS6KrUIrvUIiQINzAJE6o0x6Zcm+/bEeggXmmtFi6N5sSwOEI7PkUUh9Z7EwS
	0nnf39adbd95a6Kznr2G5V2L5poKiQLPlcMYCPSU2c1FUA55q/rCPjMx7Z0vOQn/7TNrJSOUbzj
	NzB6yTwV29SUuexOGdufbrAW7IYximLt/rp8OnIshgHpBGSK3EqILpSG0Q8f0C9drIH/s+4+o1l
	CL4zUQZGXjrnKlagTtugOgicCMiLlV58/XCrt6Z41584FR3XPWwtEXox7pPCgw181F6a8WpOH1K
	HHCuoP24
X-Google-Smtp-Source: AGHT+IHl7dpftuyHXi5id3CCfsuRjsqcclMHhkC8ECicieZ4eslNd1yDq6PW4i60d2oyveqJ8hLwkg==
X-Received: by 2002:a05:6000:1848:b0:385:e968:f189 with SMTP id ffacd0b85a97d-3888e0c0826mr13609065f8f.51.1734422035350;
        Mon, 16 Dec 2024 23:53:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dd69d9sm53736995ad.111.2024.12.16.23.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 23:53:54 -0800 (PST)
Message-ID: <5e21e7f6-6c91-4395-836e-728ffbcdca04@suse.com>
Date: Tue, 17 Dec 2024 18:23:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/100, btrfs/101: fix device name in their golden
 output
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dchinner@redhat.com,
 Filipe Manana <fdmanana@suse.com>
References: <84afb2bfe9615a98a1ae4de7dfd5fca98771937d.1733851994.git.fdmanana@suse.com>
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
In-Reply-To: <84afb2bfe9615a98a1ae4de7dfd5fca98771937d.1733851994.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/11 04:03, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 88c0291d297c ("fstests: per-test dmerror instances"), the dm
> error device name changed so that it's no longer a plain 'error-test' but
> instead it's that plus a prefix matching the test number, such as
> 'error-test.100' for example. The tests btrfs/100 and btrfs/101 are still
> using the plain old name 'error-test' in their golden output, which makes
> them fail. So update them to use 'error-test.100' and 'error-test.101'.
> 
> Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/100.out | 2 +-
>   tests/btrfs/101.out | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/100.out b/tests/btrfs/100.out
> index 1fe3c0de..e0e6cec2 100644
> --- a/tests/btrfs/100.out
> +++ b/tests/btrfs/100.out
> @@ -2,7 +2,7 @@ QA output created by 100
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
> +	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test.100
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> diff --git a/tests/btrfs/101.out b/tests/btrfs/101.out
> index c2359c7c..fbb5faa1 100644
> --- a/tests/btrfs/101.out
> +++ b/tests/btrfs/101.out
> @@ -2,7 +2,7 @@ QA output created by 101
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
> +	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test.101
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV



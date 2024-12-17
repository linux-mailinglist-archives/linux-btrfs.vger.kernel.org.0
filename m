Return-Path: <linux-btrfs+bounces-10461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2F9F4596
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83691188D945
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE11D934D;
	Tue, 17 Dec 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JekDdSIl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AB1D5CFD
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422290; cv=none; b=l0LmyqTK5BK1KMg2lbun/WoOtPGmwyBF75Mf/mHHKWzi1USxVMBE0ovRjTTQg39QQWbQRvCMkOypXI2wAmXctQhJn0EbzTApk6nxijq1fmMhZCebg3NF5jjHX6hNGXenTi+MEoBODNgQHvJhxgyzKc9QApdyrkfDsFyFUtQQDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422290; c=relaxed/simple;
	bh=zjYFBeGI81TvwSczSswEx2d4FS7UT7vkjnjWbwM8MU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElW116qSxu7Or2iKHkpa2HqaLPSdYGAr46t3XlTz3ULqpd/r7YyCbaw4azIHQng46IO7iD5Al7q0Y6XfncxPsK7UI3umalIPqo65DwXCXFKtXlfSuN6fZd8pD0Z4C8E+KEJOW3d1cpVjIBHW9Iep7PHPcMOIOFfGLyrYMwZselQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JekDdSIl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385dece873cso2249035f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 23:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422285; x=1735027085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WrjFjP+rzv/6lfs/A3ErR2BE8L5FI8AZ1uVimKRsvHU=;
        b=JekDdSIlxV0JoH8G3OZ+MGHqJTw55PXSj7FUJuFDGGDXZ95E/I73aPxH+p8JZ/HGNo
         bEs9N1wbsofS5ammz1+VIFFzv+mRKfg/Xm36nCigfVTWk74kKJC+QaS/SquKPmfPeMMD
         Zdg80pnwfAKkn8pnoU6rxC0SJaG9KrfS7CFoaLqVzZk+5Us2emlYis++fcv9Dfv1u9ED
         F3QtSOX0l2G0eg5DFeu2h80DGm2H19KoXYgz8oUhfN4LR66Q6GJKLtKtOnlaxu/IjNk1
         aZZ+iHJiqbzjwEXfpxi5zzQVd/g7oxxcj+Qd7hQMatHMIVap7m08fU5TgL8fSTnkHhwH
         sFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422285; x=1735027085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrjFjP+rzv/6lfs/A3ErR2BE8L5FI8AZ1uVimKRsvHU=;
        b=jcyUSsyLpGi5aAcnUDaLaXd9dlCtTEtn7SF4U7BuukAFj7FCq/6TxtloG4Jse8NZSN
         CsP1Be/G/4/Ly4z5+3fH+AS6nNpfQz/hzeCciXeKCIXmRNS053IMTQvmXvrEFvcLDEjf
         wvGEsv2DuQwQep9Na4zxCfBgnm3GndiJI6jmYALstDUENKU+Nl8k/IfGLQzQA3uAxmil
         QDXBzGkNXC8SmIf/Z2cYDUvCJc1YeKkJSBMDxZ7yvXkhZS/8de7Q+JRjqhze70SONmCH
         TSHGitmFNucYxWkzzUSASM+KB0fZOIjzg8zFYcC7CZpauwRPa2FaErCm4xRzakKTDh7w
         +/UA==
X-Gm-Message-State: AOJu0YzSQ7LOxHtJqo64tqaNsQGjnkl4R9MaYjEdCx5GSaXXSPKfZv+i
	CfNg+NBT3XS4VLFel4ZyFPBTk04D5OcP/84pwCXSeQP0Iv0MjxU3US8Au0/ZoXY=
X-Gm-Gg: ASbGncsuBMrBRV/Awt0+KK75xZPhlxCmjzf4kzFPo+dxh/zhTiLjS/+Wrn9erDxWlH8
	TP0pwaoM6pwfQMwDVNy0iZP78RywO+5QjbNPizrkei8t+hJ1Qe+SvqJwRLNPkomu+sdbichhtjh
	7iadlC5+Aaj4vR5JUwmiGAum8umWGihybBxidFuM0O2hQkOg4xG+f6gznXEUfWa2VNRoB3/3t6k
	DTW9Uiw5xtBPmKnD+HLoOSA8WxBAxk5c9ZXbHVCHm9Uoi5Sw7IfViwKsnBxhvyrJTMPcJpk0JFj
	Gz5f2lO2
X-Google-Smtp-Source: AGHT+IFqIyYn7Rdka62RpyLZvJ8mxvgAbCLpcmlatdkxdyBjhlq7GFwKME8kk/gse/nmNraNloN0zg==
X-Received: by 2002:a05:6000:186e:b0:385:e429:e59e with SMTP id ffacd0b85a97d-388da5b5c32mr2035964f8f.52.1734422285042;
        Mon, 16 Dec 2024 23:58:05 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bc05a1sm6051809b3a.173.2024.12.16.23.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 23:58:04 -0800 (PST)
Message-ID: <788dc543-9394-4e8b-9780-b1d08c86afec@suse.com>
Date: Tue, 17 Dec 2024 18:28:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/442: fix failure due to missing test number
 argument for fsync-err
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dchinner@redhat.com,
 Filipe Manana <fdmanana@suse.com>
References: <407b633354417bbadeb3e665246f5c5f8000e1e6.1733852293.git.fdmanana@suse.com>
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
In-Reply-To: <407b633354417bbadeb3e665246f5c5f8000e1e6.1733852293.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/11 04:08, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 88c0291d297c ("fstests: per-test dmerror instances") the
> script src/dmerror now has an extra argument, corresponding to a test's
> sequence number, but generic/442 isn't passing that argument so the test
> fails like this:
> 
>    $ ./check generic/442
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    generic/442 4s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/442.out.bad)
>        --- tests/generic/442.out	2020-06-10 19:29:03.850519863 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//generic/442.out.bad	2024-12-10 17:35:59.746597468 +0000
>        @@ -1,2 +1,3 @@
>         QA output created by 442
>        -Test passed!
>        +Usage: /home/fdmanana/git/hub/xfstests/src/dmerror {load_error_table|load_working_table}
>        +system: program exited: 1
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/442.out /home/fdmanana/git/hub/xfstests/results//generic/442.out.bad'  to see the entire diff)
>    Ran: generic/442
>    Failures: generic/442
>    Failed 1 of 1 tests
> 
> Fix this by passing the test's sequence number as an argument.
> 
> Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

BTW, generic/441 has one debug seqres.full output containing the old 
command, which is desynced from the real command.

Thanks,
Qu

> ---
>   tests/generic/442 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/442 b/tests/generic/442
> index c1182b5a..ac1b094a 100755
> --- a/tests/generic/442
> +++ b/tests/generic/442
> @@ -29,7 +29,7 @@ _require_test_program dmerror
>   
>   _dmerror_init
>   
> -$here/src/fsync-err -d $here/src/dmerror $DMERROR_DEV
> +$here/src/fsync-err -d "$here/src/dmerror $seq" $DMERROR_DEV
>   
>   # success, all done
>   _dmerror_load_working_table



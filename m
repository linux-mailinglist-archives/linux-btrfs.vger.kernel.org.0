Return-Path: <linux-btrfs+bounces-14057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EAFAB93C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3995038D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27873226D0D;
	Fri, 16 May 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MaCVJhXb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BF224B1A
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359790; cv=none; b=UYK78i2lOQxKN1xBfAsi9X6zJU4o+ltTjAqW6ie6aIEqEve3ys1GVhftxQlWistkLhT4GcwD2Y/Wkn0FuIdGayGNvpXXgqpuCKW4OparHu1TDlWHAV2OejnfKC0+fkDLaNKWrvvAQ2gHNwuCdkvf009JnuG3fvEe8igbqhnF1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359790; c=relaxed/simple;
	bh=I2XhI4IsdK2SUVstjZNdT8Tc9GNJtRKjEkvObuxIvmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Py1N8ykLBJRlLjfCSSy7QbDJmObQTMo4sI6soKmseuvam2O3S19C/jGJPlF2fZUnU3ZeCq5qnUggNlZ+8QQaGx/K41HuTImeWoQnnZy0cvVXG6KJTpxmhfdPH/joKTeCVsOye0HNKNT/7yCa2vS0hFOwSbLKhb58OP+DLIif0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MaCVJhXb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so12191485e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747359786; x=1747964586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TO6PLI/q/BSJiYFur9Wwnt5xlMXfL+BjuKMlEneUJw0=;
        b=MaCVJhXb3N4S3GBLGG3N/G8255HfRj7e5OEXwd95zPs6ouUYgLwVlQU7Sqxag9KzWs
         Q9FIPNW4OL9sHp8w2Vkjbq3ExpPHPJIhCGWo9zifPQXdlDZCDMpXtwaldzsz5qVJpFj1
         dT489SjNSF/63daVDs655k41mfsMe/Gsu5i0yth+7ndxfHcoEvQ9nva3tbtagDPqdgrQ
         tIpandXV5BPPmaNANFnKfLv+tWEZZ6rut6ssehWh/Jf/UT88eq43zo/VlHQ+ZeysqVzy
         oXhLENNosjDocLpyM7R2na4WJbRH01XaZDPKp2U8MD8EEw+cdC6dSc4bpUPcxNseMJbn
         a0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747359786; x=1747964586;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TO6PLI/q/BSJiYFur9Wwnt5xlMXfL+BjuKMlEneUJw0=;
        b=L683OYwfAuwMqkXiIyxTSphctTEw7+yHo8+Sp54Nvp2w9kdOijZeCcD4Cce8fJk8oX
         XqLm8uNxh8THAh4QLPaDSozdpG45M93gvNQbi8ENzk1heus2D5skcsDCTtED2aMpcQAp
         o+OPbc80C9YTaLOL+pHSXoOE5TYjm0XdE/JyCLdw8XfL+j3OxhTmtZAxu6ljKexwzGJ0
         Pd//IqTJyASFEMAg/kpTW0tnWED60SrgY/GLtC63ZhWT4ybOIbum4aAnSXG51IwEXNF4
         ZsbvL612U+4JgJcLOdVmg5kWAwXcq+ZAzYc3x0Yb1jnZ+FTGRLAQOG3C5U7C6Z9CBKCj
         DKkg==
X-Forwarded-Encrypted: i=1; AJvYcCWo2snPWkZZbbgXxPM0UK4/0YvO69TVKowoXWOnlRs8RAIlVUK+n2S3aynwmK4abs6rm3l54FXVxdSFvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmp1Icd3ByTOj5b8Oal2+DvPDeYsMGtTJy61s1isbQYGjYJX3a
	DhhgyH5zUaxk5iBoQn3Qqep4V4JM0oPi3HuFJ/+8+OPeUdFYl8EdKoLXXd3+1VdsPwKq2ANBeGD
	rk2d9
X-Gm-Gg: ASbGncvp8yrakjbvlAsVh0nOW6IX4WIBiK15XJFhTsl/pTDwM6sK8XNI0AXFVG7yo5s
	g0I8cwkJPGBv8rbxtvBrvvRSUFK/4TEUvgUyqdwcVVFqpTPaPjytRIx125zoovkUrObXUpyfy5W
	tL3hlyxPyCjjcydiOdo5e+d4Titbtf6XEhczjKBKmxUNlJgehV3R1egUIyodoajIvM+zJqCGAPq
	4XoqhWuh5nrIJPN8jAwEjUmnvufVYcgq+5/WTl19LI7HtkHeXPtly/AhkVGUaalNM1nlFKj4VaE
	jNi+dGvKThkJBdK/tX8HvshejHg+zIMDD+MfeNqrQb6nXvAVzdaTLU8nauJNTOylSDUI94mF2iQ
	eb8g=
X-Google-Smtp-Source: AGHT+IELVxoT931HJvA9VA2i78usgLRPkg4rfHZOgiCIJhNE5bQca9ScS4hz2ogztXfIaPPCTHx1nw==
X-Received: by 2002:a05:6000:1883:b0:3a3:5c05:d98b with SMTP id ffacd0b85a97d-3a35c8220bemr1524437f8f.5.1747359785579;
        Thu, 15 May 2025 18:43:05 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a44e7sm545189a12.73.2025.05.15.18.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 18:43:04 -0700 (PDT)
Message-ID: <87850150-493e-4c8e-8bbd-1bb36bc88b5e@suse.com>
Date: Fri, 16 May 2025 11:13:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: mkfs: use path_canonicalize for input device
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <0d9762cf51f6e0e92ac56f02f44836d98af957d5.1747318570.git.anand.jain@oracle.com>
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
In-Reply-To: <0d9762cf51f6e0e92ac56f02f44836d98af957d5.1747318570.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/15 23:46, Anand Jain 写道:
> Canonicalize the input device's path before using it.
> So that we show the device path that matches with the /proc/fs/
> 
> Before:
>    $ mkfs.btrfs -fq /dev/vg_fstests/lv1 /dev/sdb > /dev/null
> 
>    $ blkid --uuid c3bf2107-292d-4c7f-a288-0fa922ebd71a
>    /dev/mapper/vg_fstests-lv1
> 
>    $ mount --verbose /dev/vg_fstests/lv1 /mnt/scratch
>    mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.
> 
>    $ cat /proc/self/mounts | grep scratch
>    /dev/vg_fstests/lv1 /mnt/scratch btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> After:
>    $ mkfs.btrfs -fq /dev/vg_fstests/lv1 /dev/sdb > /dev/null
> 
>    $ blkid --uuid c774b4a6-3ad2-4b15-834a-894dfc898aa9
>    /dev/mapper/vg_fstests-lv1
> 
>    $ mount --verbose /dev/vg_fstests/lv1 /mnt/scratch
>    mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.
> 
>    $ cat /proc/self/mounts | grep scratch
>    /dev/mapper/vg_fstests-lv1 /mnt/scratch btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

I do not think this is the correct way to go.

It looks more like a bug in libblkid.

Please explain why the problem happens, not workaround it without any 
reasons.

Thanks,
Qu

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Link: https://lore.kernel.org/linux-btrfs/5f401c48-29f5-403e-8c39-50188028ad00@oracle.com/
> ---
>   mkfs/main.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 4c2ce98c784c..e6466d88313a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1537,7 +1537,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	for (i = 0; i < device_count; i++) {
> -		file = argv[optind++];
> +		file = path_canonicalize(argv[optind++]);
>   
>   		if (source_dir && path_exists(file) == 0)
>   			ret = 0;
> @@ -1553,7 +1553,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	optind = saved_optind;
>   	device_count = argc - optind;
>   
> -	file = argv[optind++];
> +	file = path_canonicalize(argv[optind++]);
>   	ssd = device_get_rotational(file);
>   	if (opt_zoned) {
>   		if (!zone_size(file)) {
> @@ -1752,7 +1752,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	for (i = saved_optind; i < saved_optind + device_count; i++) {
>   		char *path;
>   
> -		path = argv[i];
> +		path = path_canonicalize(argv[i]);
>   		ret = test_minimum_size(path, min_dev_size);
>   		if (ret < 0) {
>   			error("failed to check size for %s: %m", path);
> @@ -1816,7 +1816,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	opt_oflags = O_RDWR;
>   	for (i = 0; i < device_count; i++) {
>   		if (opt_zoned &&
> -		    zoned_model(argv[optind + i - 1]) == ZONED_HOST_MANAGED) {
> +		    zoned_model(path_canonicalize(argv[optind + i - 1])) ==
> +							ZONED_HOST_MANAGED) {
>   			opt_oflags |= O_DIRECT;
>   			break;
>   		}
> @@ -1824,7 +1825,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   
>   	/* Start threads */
>   	for (i = 0; i < device_count; i++) {
> -		prepare_ctx[i].file = argv[optind + i - 1];
> +		prepare_ctx[i].file = path_canonicalize(argv[optind + i - 1]);
>   		prepare_ctx[i].byte_count = byte_count;
>   		prepare_ctx[i].dev_byte_count = byte_count;
>   		ret = pthread_create(&t_prepare[i], NULL, prepare_one_device,
> @@ -2198,7 +2199,7 @@ out:
>   		optind = saved_optind;
>   		device_count = argc - optind;
>   		while (device_count-- > 0) {
> -			file = argv[optind++];
> +			file = path_canonicalize(argv[optind++]);
>   			if (path_is_block_device(file) == 1)
>   				btrfs_register_one_device(file);
>   		}



Return-Path: <linux-btrfs+bounces-3012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B68718FF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 10:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508661F23CE8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8D524B4;
	Tue,  5 Mar 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W7hZDFO2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE534F8A1
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629563; cv=none; b=A12mtatLIrqjlaurmcfJSsIqk0vf+klzQw2qbfwt9Qyubm9dayedpfqCgrol6HcrT/hVpZk214hrFBTUy8AunXuLmrxsmZeS9cEWJxDK8LMJSzE85DcglVhjkq4fJGj0qEpUgx/VKleE6ziJBXzFE0gcumUAjio+f/VgUBvPS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629563; c=relaxed/simple;
	bh=VKOiHav/yw7Z8MKppwEQwdcpsKQuNnB4Tx+CoLuu32Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pgtNMRxL7kRC2TBTiXfHfuRJP09kHobmRltc5/tIdZc7dKq7l1vANprXiFzF1Aw6GxBxCkSTVTHV3byQzPkbpfwclEUkjxALSwKLzhjZuZmefJmN9ayIm71NtWrlJTwfxXoLc76bl7wXf9X2i3G8JdgLbjmMvZO4h716gpLSlko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W7hZDFO2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d24a727f78so66010421fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709629559; x=1710234359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Q9mhdYZ9+rxVPecvuffO5o2Xu+p4/LqccpCPzMg9nQ=;
        b=W7hZDFO2e3RCS6IiwyKdxgv3F91IHMIepPaerNvQMVOX8YbeHW1ssES6mhT372RQOY
         FVC41b+0zT4e+UyaKfjbsfAA/EJQtiJoTjUTmsXrNjiWDd7wQInE46KZUFGOjO1MKjB6
         wkzV1T4tCPdRVbglm3N2WUhi9iRXPC/rfdjlqZoIk7qv5ksNzb5R5mUEFvJxtk05ejfG
         6g2U3AxLVhmvBeUGWTMgi2yG1ndLlp1l6YIQUea+64/bgGazeseCf5awXslauGTkZmnx
         GAs4MKTiYRAznMeJyLrACoMhcLxSuXeC1uwCm8N1pNGFwl9VIbiN2gM0AXH6TWSrkxNf
         Dbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629559; x=1710234359;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Q9mhdYZ9+rxVPecvuffO5o2Xu+p4/LqccpCPzMg9nQ=;
        b=Bwd2t3UvdsOhbEQgdaAc1pxU1/wljmLCBiYUpE0d6WGo5NU+WjLn8LRtpHIqo20a7t
         pa1Rfur8GgWU6jKElbLwoBKqFJj2h46JIG7Wny8V8YIb0Lkd43WQFF+fmaPYjuxPyYiO
         GSjNivucqsb5a/5rL/sP60aoX5ytfmcQtWcmTGBnakQFi12JY3zOxOLGlcYQORmEVvTN
         6ZiYsXH9Nvs8ZPR0ZfVwt7xFBpa5Wsd+B2nlsk2QcIls4Ui1WZR8mQ9oHTaLpfVl0rCB
         rMkyWW9qYo8khgJKjeDNFw9qHD7vbpVrWTodYDH8nVOR+5hG9TFSgqYpTe+VQoDwAqiQ
         VYsQ==
X-Gm-Message-State: AOJu0YyNv/BD5Jrm/opDvhkSmj2nU2DrpIGQK2bYEIxaAT29xtgCSNuY
	+uNLhbKv5xfvzpq69Sl34R9LK1B5boy5LTPx5StjYZAXP9ObbWQqhy/Qu5F+9OgIERUUDgievkv
	1cPE=
X-Google-Smtp-Source: AGHT+IEYXy/KzlV8JcnTJ2uHzZRkWZYy8YkWQJUjryhcEiJKX0XEkypvow3owRnIy6/yfcDhosVCpg==
X-Received: by 2002:a2e:9804:0:b0:2d2:37d6:350c with SMTP id a4-20020a2e9804000000b002d237d6350cmr1074331ljj.12.1709629559379;
        Tue, 05 Mar 2024 01:05:59 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id y33-20020a17090a53a400b0029ab5abcbe1sm12329178pjh.20.2024.03.05.01.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 01:05:58 -0800 (PST)
Message-ID: <12c38978-9371-48c0-bc73-aa15f8c462b6@suse.com>
Date: Tue, 5 Mar 2024 19:35:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: scrub: fix false alerts on zoned device
 scrubing
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: WA AM <waautomata@gmail.com>, stable@vger.kernel.org,
 Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <cf93c10bb94755f1bee7e70b333db72ba9f0896b.1709629215.git.wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <cf93c10bb94755f1bee7e70b333db72ba9f0896b.1709629215.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please ignore this patch.

Johannes sent out his version before me and it's all my bad I didn't 
check the ML before sending out my version.

Sorry for the noise.

Thanks,
Qu

在 2024/3/5 19:31, Qu Wenruo 写道:
> [BUG]
> When using zoned devices (zbc), scrub would always report super block
> errors like the following:
> 
>    # btrfs scrub start -fB /mnt/btrfs/
>    Starting scrub on devid 1
>    scrub done for b7b5c759-1baa-4561-a0ca-b8d0babcde56
>    Scrub started:    Tue Mar  5 12:49:14 2024
>    Status:           finished
>    Duration:         0:00:00
>    Total to scrub:   288.00KiB
>    Rate:             288.00KiB/s
>    Error summary:    super=2
>      Corrected:      0
>      Uncorrectable:  0
>      Unverified:     0
> 
> [CAUSE]
> Since the very beginning of scrub, we always go with btrfs_sb_offset()
> to grab the super blocks.
> This is fine for regular btrfs filesystems, but for zoned btrfs, super
> blocks are stored in dedicated zones with a ring buffer like structure.
> 
> This means the old btrfs_sb_offset() is not able to give the correct
> bytenr for us to grabbing the super blocks, thus except the primary
> super block, the rest would be garbage and cause the above false alerts.
> 
> [FIX]
> Instead of btrfs_sb_offset(), go with btrfs_sb_log_location() which is
> zoned friendly, to grab the correct super block location.
> 
> This would introduce new error patterns, as btrfs_sb_log_location() can
> fail with extra errors.
> 
> Here for -ENOENT we just end the scrub as there are no more super
> blocks.
> For other errors, we record it as a super block error and exit.
> 
> Reported-by: WA AM <waautomata@gmail.com>
> Link: https://lore.kernel.org/all/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com/
> CC: stable@vger.kernel.org # 5.15+
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/scrub.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> ---
> Changelog:
> v2:
> - Use READ to replace the number 0
> - Continue checking the next super block if we hit a non-ENOENT error
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c4bd0e60db59..201b547aac4c 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2788,7 +2788,6 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   					   struct btrfs_device *scrub_dev)
>   {
>   	int	i;
> -	u64	bytenr;
>   	u64	gen;
>   	int ret = 0;
>   	struct page *page;
> @@ -2812,7 +2811,17 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   		gen = btrfs_get_last_trans_committed(fs_info);
>   
>   	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -		bytenr = btrfs_sb_offset(i);
> +		u64 bytenr;
> +
> +		ret = btrfs_sb_log_location(scrub_dev, i, READ, &bytenr);
> +		if (ret == -ENOENT)
> +			break;
> +		if (ret < 0) {
> +			spin_lock(&sctx->stat_lock);
> +			sctx->stat.super_errors++;
> +			spin_unlock(&sctx->stat_lock);
> +			continue;
> +		}
>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>   		    scrub_dev->commit_total_bytes)
>   			break;


Return-Path: <linux-btrfs+bounces-11816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA1A44EAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 22:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1737E3A2D68
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3219F41B;
	Tue, 25 Feb 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VxWYN9lf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1612AEE4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518385; cv=none; b=G6i+1k31DTWyIhpdwgdaOZNwZcrweR+9+wcpNSDlmoOJ1pR2+vzphC8itvZP3yIv0hfxCrat2RDk9zCSV9cbzL0VffLYpPnfzYZmcNmiVt6Qj3BsdlPGv1GB+wcUFuuNc+spKojRxGKM/cfxy93eQmrEz1IPnLvfs2ngiFJ43kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518385; c=relaxed/simple;
	bh=qB2V8E5FyedQdReORvXPcXhsP3e9KX7L0Ox1j4Gb/Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ed6Y9gwp881u3BqKsU+NjD7YQxWxvKaicZ+LvyQWjUTx9WH9G0xmUF5Kpn/enLc/pbn5TIRX9TwY4pQFBNc2iOWz2yuOwNYNLUTb1LiI7bn+DBvrxMmkoWNidSqji3uuvkOhP35byqlxtWy1YQU/MCAxBcp5jHsWV0/VOZkdc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VxWYN9lf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abec925a135so237934466b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 13:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740518382; x=1741123182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d1+llyTN/W7BKZGO47oPdIlMDiuVLU9SMAqsUJ3oZuE=;
        b=VxWYN9lf9yN9V3C8qnNEUXkIqfFLnOzhO1PC566j8o7+LRC8etgeewzoSoNPQh8Q0X
         HVyTtov9jycPE3zZ2ewuMvthOlyzL6yQ8dIFTVhelvg312QcSJ+7THkgyzSlPUac5XjG
         44x0SUzYzEloT/+tPwaNmWjQ5f70V1XA85QG62Kh0f4Ad//Y+agF5j1FReXbSvbF5wpG
         V35l2NgfvLKKbSX75+SipoBTC7GVR35XBqbEEuCPE0TMBaaszLnfv46kxocolunizwy2
         K9cmmz54ZamGMrkxEnBTu92T7eevzRTs6I+FFLAaoVQgiKYMrS3MMyo4I6JWf2s4uye/
         UD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518382; x=1741123182;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1+llyTN/W7BKZGO47oPdIlMDiuVLU9SMAqsUJ3oZuE=;
        b=p+BFw31pbxckpyj8evYljVYBpEA9NL5MUondJpFTcLGjcWb5BnBkkrZrryVrzYC4VR
         aVkkfhN429P5Z5OOV60Ttd4jCEoSJsb7fQ8UFg5wDW+RV1eXz9DMhDy7UCRuzRMlw2oq
         pGAxmhdYnXyvSXyjrE4GmHy/DOkPbi35m/qum68EFOrRKRtnAFSh3fXCKjcRnvtKNePH
         2e7MN80QLl4eOLH+HWUmK5CHfWwLoW8aK+r1JScVcq/YS0NP8BNlsXXnfI3jAELjvb0v
         sydJRDcDGVphDOrL/X773Oylosdr6NMyathVKwL/rbNC2tOAszwBu67KoriJ9OWHzNHQ
         dDqA==
X-Gm-Message-State: AOJu0YxRkcEKARmZ/E/YxmnQJys8TmoG4kcdWYKDUGF3yOsbkF1k5cK8
	2h0zzNS61WDH7+o82JZf4trM2nkSe5HcmexGsYbOn8YOEvDr1wbJ8gyApyYS+/jb0Kvjc8+/rDn
	5
X-Gm-Gg: ASbGncsb1Oob1U3JyLBLuYSMu7C0jCTIIxrHWH4PgMxkQudN6Q9YmCkWtydPH6dvuD8
	Vpd9E9ie2vYByl37zIl1C8H1PK/Cic5zCP2WAxflpQxeMdvELpbu9tov3LOQg9kdRgsqizEJu4V
	EG5A8BN72aomRqDeU32aV5CAzMAzqkjpGBJJYG3r53EVdarTHW+Fhcrfi4B8MicUbnKZbudwLMw
	UD7GAC4syh8/lqR7zOVtuXlM0c/fydFDiwzp26UinSDvoXbrgdo//wYWsNq8ssokH8ErWhthSgy
	UFVpZ16u9+RCP+KMDuaFUZDsOUHu87yV/ktk+MS8HXdlU8MoIO0axw==
X-Google-Smtp-Source: AGHT+IEQq7CJhJyAX1PMCEcgcDsni564+2HHInC1mNtYNosVpsrJqS5kiJrBFwmZ0vdL8nS3+StO8g==
X-Received: by 2002:a17:907:2cc2:b0:abc:cbf:ff1f with SMTP id a640c23a62f3a-abeeef42910mr75022366b.40.1740518381457;
        Tue, 25 Feb 2025 13:19:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f55acsm2003910b3a.37.2025.02.25.13.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:19:40 -0800 (PST)
Message-ID: <312b2af9-3062-4777-9f9c-35f4aeb8b0d3@suse.com>
Date: Wed, 26 Feb 2025 07:49:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] btrfs: remove the subpage related warning message
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740354271.git.wqu@suse.com>
 <7d10ddfc206a73909763f8a9addfef1e10e5fccf.1740354271.git.wqu@suse.com>
 <CAL3q7H5sT418ruX-s_V5F=5JiU6TthCq1O4K15Uc28oj0Xpv=Q@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5sT418ruX-s_V5F=5JiU6TthCq1O4K15Uc28oj0Xpv=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/26 04:40, Filipe Manana 写道:
> On Sun, Feb 23, 2025 at 11:47 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Since the initial enablement of block size < page size support for
>> btrfs in v5.15, we have hit several milestones for block size < page
>> size (subpage) support:
>>
>> - RAID56 subpage support
>>    In v5.19
>>
>> - Refactored scrub support to support subpage better
>>    In v6.4
>>
>> - Block perfect (previously requires page aligned ranges) compressed write
>>    In v6.13
>>
>> - Various error handling fixes involving subpage
>>    In v6.14
>>
>> Finally the only missing feature is the pretty simple and harmless
>> inlined data extent creation, just done in previous patches.
>>
>> Now btrfs has all of its features ready for both regular and subpage
>> cases, there is no reason to output a warning about the experimental
>> subpage support, and we can finally remove it now.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> I don't have a machine to test block size < page size, but I trust you
> did all the testing besides being the expert on the code base for the
> feature, so:

There will a be a very small patch series (3 patches, < 70 lines of 
modification), to enable 2K block size on DEBUG btrfs builds.

Although with a lot of extra limitations, it should be enough to trigger 
most (if not all) bugs involved in this series.

The fstests to avoid the 2K block size limit will be a much big work 
though...

Thanks,
Qu

> 
> Acked-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>> ---
>>   fs/btrfs/disk-io.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index a799216aa264..c0b40dedceb5 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3414,11 +3414,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>           */
>>          fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
>>
>> -       if (sectorsize < PAGE_SIZE)
>> -               btrfs_warn(fs_info,
>> -               "read-write for sector size %u with page size %lu is experimental",
>> -                          sectorsize, PAGE_SIZE);
>> -
>>          ret = btrfs_init_workqueues(fs_info);
>>          if (ret)
>>                  goto fail_sb_buffer;
>> --
>> 2.48.1
>>
>>



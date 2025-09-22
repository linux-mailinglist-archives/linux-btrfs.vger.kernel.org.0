Return-Path: <linux-btrfs+bounces-17034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD9B8EA82
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 03:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E10A1896667
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 01:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37049659;
	Mon, 22 Sep 2025 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RuTDGBrX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD172629
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503715; cv=none; b=RxZjdznBKwfhPd3FQj3OdlHwlx7M/+FEibTCKO71W21Aa6YFIyso2cHvY2xhvbHMFQ0y2qj5JWE/0++ofMTiikO0BOyd8e5UoaRVoJygspod0zLT6Cdh9XLE6r0uAhckgM1dMPmTFbxcGE0hkQF/D9gwsBXZ83rw8aqCXMTb6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503715; c=relaxed/simple;
	bh=xhvdOxATVw2e60C2H297GqupnkaRtpA9c/+PbZTdtTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrr2zAeTRfSoFFafX09WZiV+jW8hBl1MEYuauUGfiV0cQ1L14oNQc36YtMg6Z0QBE/GEgR8VjCgtfhIch0oKs8wqyzyv7fxq6Px2y3mWVfT6l8ZAxn2c+Yu85OYH0cCqNTc0oTvU9WIUElaNo63l1EACYjzgaiSYg43oXAGhOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RuTDGBrX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so25040665e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 18:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758503711; x=1759108511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRmTQdCZQNvsNB6Ln8BP6WYvgij6I/PfntBJOwIaWCc=;
        b=RuTDGBrXnAYzv2prTFppueSxcX1ibkbsU4lMyIB7ynOmoQL2svNr8RyHf438BJiLJD
         Ohn4aZVKZ9luONUJMdg1YQswJLkeyKu4Kf9qSHtyMuCy0MU3Hie8jIHG25ErX+PrqWXD
         7tmeBXEzTz4d0vIJT95uMWDn2wL0px+u4DXC8eOZHLB+0aBhHEeqZZIY+iyuGC7FRzFh
         0UnCtHbE24nhIds6b2caheY6Z6rOrsW6+mhqsQ0Af2XSKfm5vFc5ySu5l874gWdYCn+o
         hQvNH0PI9Ke6Ahdh7hvL9YRWIxcW/c0Eef4s4Fmz6nZgffqPfTLBdJZMPGaQddc11xE7
         3NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503711; x=1759108511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRmTQdCZQNvsNB6Ln8BP6WYvgij6I/PfntBJOwIaWCc=;
        b=T2xeKOcl7MKsGhtoHi63Qz+3PE1ptgX1QDYEk8iiLWONoxCatNZCm6KRU4qYEwjZS/
         evSQZZcJBOGbjRrMICxlPHCT27GPPSL9uSrRxfTRbz+/7KznoQYUYTGr7xGx8lCTqMIb
         nY0VjU2pUyS2f8FTvIZGDgpXZ3RLle+6tqxoigEZJB7iEN937SKsiLzd5X4EZjpV5tGV
         3xpraqBb1InQREyexQ0d4UtLPioEyRTy/NLzGLA89bb/4WPM6Qhoe/CldIt3rjpr0W9x
         M7GlgXc3isruDGgIA8KYWEp3bWS+z7TPbD3b62VctFJWBnPukgEla7ZLg/vBsz/kZpSc
         Ughg==
X-Forwarded-Encrypted: i=1; AJvYcCWLAxcQfPbo1X1ogDl90YMetg4fvKxzQVieQN5GtqqT2CaC6NZLU8ZdPRxYnSyOaeEe/F/BgZCNZaCiQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2g5dPjND0TjqYNXjrWUGEZvgHttA/seC2sRA1PDtV09sLcoGJ
	QtNTvox0rqlSSObLyFyUAhUJ510Y7NIL+SVcpHWo6GWxWoN9vrKDCYmy3sYpF1NrnGY=
X-Gm-Gg: ASbGncscXo7BZah/JcCrdisHO1iRiERfN4boxvm4/zXA5WtY6PTN6mck7wQ4dAUShvd
	awlXjw6EtW1jdiKkDBJxiIqZBdUS7vT1TnTh0JtF/8hR7HJ9t/yulvDEIjjAr5ZKFsjROpHIuuM
	WpBLtKZXHg6GNqGrki8t3cfq5Ml7WEMU+SflPRRRu59aFgprcEzF2y19wwAgM3sTPkm9vPcZerZ
	yUjqfUzwbvgrZbcrQ3XaHbNYsXZibalAO/Jn4dpWSUqq6qjo14aEMSTz1Cy3y0aVlFCbNpUK/Hy
	t6cwQ0QJRCB1A794Q7TVCsglCKcjGITluJDLL0bP+vzzNvgqoRR66DVbSKSrC5hxkUI0szwZtGU
	4gWWq3Y3jOUltPyiMTCkuq7n+7Yzj3MfNLq1xRBP7oHmMYnNs//VIxj+7iYdu9Q==
X-Google-Smtp-Source: AGHT+IFmJEcsg99o9NEc8e77TnSQ7hZcO0QY90hwdYs/Iz354WL2XoWrkOmv6pDuDvlE9YckKL+rhA==
X-Received: by 2002:a05:6000:420e:b0:3d1:c2cf:da07 with SMTP id ffacd0b85a97d-3ee7bad1634mr7451442f8f.4.1758503710752;
        Sun, 21 Sep 2025 18:15:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55387c93easm4405963a12.52.2025.09.21.18.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 18:15:10 -0700 (PDT)
Message-ID: <2e2977ab-953b-4838-b1ba-a63375eeb31c@suse.com>
Date: Mon, 22 Sep 2025 10:45:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
To: Justin Brown <Justin.Brown@fandingo.org>,
 Chris Murphy <lists@colorremedies.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
 <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
 <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
 <23d859bc-19f9-4cf5-9405-03792dbf2e7a@gmx.com>
 <293aab80-89e4-44fe-b588-977ab24dbf51@app.fastmail.com>
 <CAKZK7ux=z2OT2psm8C06RTM+D4CweQe8dQZxEZ4SNeOwhhfA0g@mail.gmail.com>
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
In-Reply-To: <CAKZK7ux=z2OT2psm8C06RTM+D4CweQe8dQZxEZ4SNeOwhhfA0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/22 10:37, Justin Brown 写道:
> Hi Qu,
> 
> Thanks for the response. I ran a readonly check against all the
> bytenrs, but it doesn't look great:
> 
> [fandingo:~] $ for i in $(sudo  btrfs-find-root -o 3 /dev/mapper/cm |
> grep '^Well' | sed 's/^Well block \([0-9]\+\).*$/\1/g' | sort -n); do
>             echo "######### $i #########" | tee -a /tmp/btrfs-check.txt ;
>             sudo btrfs check --readonly --chunk-root $i /dev/mapper/cm
> 2>&1 | tee -a /tmp/btrfs-check.txt;
> done
> 
> Full output at https://pastebin.com/aWKsc9AH
> 
> There are a lot of repeated errors, which I guess should be expected,
> and a lot of the same numbers repeated. Decent amount of errors that
> look like this:
> 
> ERROR: root [3 0] level 0 does not match 1
> ERROR: cannot read chunk root
> ERROR: cannot open file system
> Opening filesystem to check...

This is a false alert. As even if we specified the chunk root bytenr, 
the level is still got from the super block.

I'll send out a patch to allow specifying the level.

BTW, for that level 0 one, the full chunk tree should be able to loaded 
properly, but there may be one or two missing chunks.


Thanks,
Qu

> 
> and lots of these, sometimes with different numbers as the bytenr decreases.
> 
> ######### 22052864 #########
> parent transid verify failed on 29442048 wanted 2185 found 3178
> parent transid verify failed on 29442048 wanted 2185 found 3178
> parent transid verify failed on 29442048 wanted 2185 found 3178
> Ignoring transid failure
> parent transid verify failed on 1004077056 wanted 4945 found 4933
> parent transid verify failed on 1004077056 wanted 4945 found 4933
> parent transid verify failed on 1004077056 wanted 4945 found 4933
> Ignoring transid failure
> parent transid verify failed on 1004093440 wanted 4945 found 4941
> parent transid verify failed on 1004093440 wanted 4945 found 4941
> parent transid verify failed on 1004093440 wanted 4945 found 4941
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=998031360 item=130 parent
> level=1 child bytenr=1004093440 child level=2
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
> Opening filesystem to check...
> 
> 
> 
> ==================
> ==================
> 
> 
> Chris,
> 
> Here's the output of the backup roots. I have no clue what to make of
> this information, though.
> 
> superblock: bytenr=65536, device=/dev/mapper/cm
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0x05e1f6bc [match]
> bytenr            65536
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
> metadata_uuid        00000000-0000-0000-0000-000000000000
> label            media
> generation        4956
> root            998506496
> sys_array_size        129
> chunk_root_generation    4945
> root_level        0
> chunk_root        27656192
> chunk_root_level    1
> log_root        0
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        8001546444800
> bytes_used        6708315303936
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID )
> incompat_flags        0x361
>              ( MIXED_BACKREF |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    4956
> dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> dev_item.type        0
> dev_item.total_bytes    8001546444800
> dev_item.bytes_used    6856940453888
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> sys_chunk_array[2048]:
>      item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>          io_align 65536 io_width 65536 sector_size 4096
>          num_stripes 2 sub_stripes 1
>              stripe 0 devid 1 offset 22020096
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
>              stripe 1 devid 1 offset 30408704
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> backup_roots[4]:
>      backup 0:
>          backup_tree_root:    1022836736    gen: 4953    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1003782144    gen: 4953    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1003618304    gen: 4953    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708289445888
>          backup_num_devices:    1
> 
>      backup 1:
>          backup_tree_root:    1005043712    gen: 4954    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    997343232    gen: 4954    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708293525504
>          backup_num_devices:    1
> 
>      backup 2:
>          backup_tree_root:    1011204096    gen: 4955    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    602931200    gen: 4955    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708307161088
>          backup_num_devices:    1
> 
>      backup 3:
>          backup_tree_root:    998506496    gen: 4956    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1027489792    gen: 4956    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1025638400    gen: 4956    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708315303936
>          backup_num_devices:    1
> 
> 
> superblock: bytenr=67108864, device=/dev/mapper/cm
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0xa580de72 [match]
> bytenr            67108864
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
> metadata_uuid        00000000-0000-0000-0000-000000000000
> label            media
> generation        4956
> root            998506496
> sys_array_size        129
> chunk_root_generation    4945
> root_level        0
> chunk_root        27656192
> chunk_root_level    1
> log_root        0
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        8001546444800
> bytes_used        6708315303936
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID )
> incompat_flags        0x361
>              ( MIXED_BACKREF |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    4956
> dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> dev_item.type        0
> dev_item.total_bytes    8001546444800
> dev_item.bytes_used    6856940453888
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> sys_chunk_array[2048]:
>      item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>          io_align 65536 io_width 65536 sector_size 4096
>          num_stripes 2 sub_stripes 1
>              stripe 0 devid 1 offset 22020096
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
>              stripe 1 devid 1 offset 30408704
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> backup_roots[4]:
>      backup 0:
>          backup_tree_root:    1022836736    gen: 4953    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1003782144    gen: 4953    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1003618304    gen: 4953    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708289445888
>          backup_num_devices:    1
> 
>      backup 1:
>          backup_tree_root:    1005043712    gen: 4954    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    997343232    gen: 4954    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708293525504
>          backup_num_devices:    1
> 
>      backup 2:
>          backup_tree_root:    1011204096    gen: 4955    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    602931200    gen: 4955    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708307161088
>          backup_num_devices:    1
> 
>      backup 3:
>          backup_tree_root:    998506496    gen: 4956    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1027489792    gen: 4956    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1025638400    gen: 4956    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708315303936
>          backup_num_devices:    1
> 
> 
> superblock: bytenr=274877906944, device=/dev/mapper/cm
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0x58078843 [match]
> bytenr            274877906944
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
> metadata_uuid        00000000-0000-0000-0000-000000000000
> label            media
> generation        4956
> root            998506496
> sys_array_size        129
> chunk_root_generation    4945
> root_level        0
> chunk_root        27656192
> chunk_root_level    1
> log_root        0
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        8001546444800
> bytes_used        6708315303936
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID )
> incompat_flags        0x361
>              ( MIXED_BACKREF |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    4956
> dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> dev_item.type        0
> dev_item.total_bytes    8001546444800
> dev_item.bytes_used    6856940453888
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> sys_chunk_array[2048]:
>      item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>          io_align 65536 io_width 65536 sector_size 4096
>          num_stripes 2 sub_stripes 1
>              stripe 0 devid 1 offset 22020096
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
>              stripe 1 devid 1 offset 30408704
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> backup_roots[4]:
>      backup 0:
>          backup_tree_root:    1022836736    gen: 4953    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1003782144    gen: 4953    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1003618304    gen: 4953    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708289445888
>          backup_num_devices:    1
> 
>      backup 1:
>          backup_tree_root:    1005043712    gen: 4954    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    997343232    gen: 4954    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708293525504
>          backup_num_devices:    1
> 
>      backup 2:
>          backup_tree_root:    1011204096    gen: 4955    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    602931200    gen: 4955    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708307161088
>          backup_num_devices:    1
> 
>      backup 3:
>          backup_tree_root:    998506496    gen: 4956    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1027489792    gen: 4956    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1025638400    gen: 4956    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708315303936
>          backup_num_devices:    1
> 
> 
> 
> Thanks for both of your help,
> fandingo
> 
> 
> On Sun, Sep 21, 2025 at 7:31 PM Chris Murphy <lists@colorremedies.com> wrote:
>>
>> It might be worth looking at all supers and backup roots.
>>
>> btrfs insp dump-s -fa /dev/sdXY
>>
>> The supers should be all the same on HDD. The backup roots might be more reliable for attempting repair compared to SSD where I've seen recent (but zero ref) trees already overwritten by btrfs. That doesn't appear to be the case here, seems like newer trees weren't yet committed to stable media which is ... not good.
>>
>> ---
>> Chris Murphy



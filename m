Return-Path: <linux-btrfs+bounces-14397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD5ACBD9A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 01:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C2118935FA
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092A1FE45D;
	Mon,  2 Jun 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aiiTqNPs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3DF30100
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905509; cv=none; b=BM63admHsG3tLuwGDKGzslcCI/86YUy7jZKIMRJ1WOjp39JpoJTPLpeYuakD2bzCAyueFwcxRwicfsOc9FFiLFqiPTnEZQjecV5SuJeZ+oOVg6zgVH5PmsqTSdICMwJMC/1vmmnCLV6FpbfurWLqk96xzhvZYHYWXbKab4B9S54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905509; c=relaxed/simple;
	bh=SX2CGMOZ6j7zQhh3uPQj5nhG1FYDtg50LYapwwx/MGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EPnFa1x4/n0BB0A7Cy/HEhS2YbDEFU45E2NuRWyzervjUIiuViUGVnPiolvHW8UCCARG0YgkIH23PEm+YPrvyaoaCbnkZ4kUO6M/zizdgaGlhhlYSU0lAgCgKk4EBEKOK9AGoiR7HjnPYRSfBkkLnsP84AsN53jlptaejFowg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aiiTqNPs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so785977f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748905505; x=1749510305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/HB/OaWbP3gvs7kM2DDOFGaeE+8TrxotTvDBDnQTbVo=;
        b=aiiTqNPsTlLKX6gZxxD1vOojiVAxzfhAvz8y8ucf9DKUlvO41JeZIVVNqckh/HqB0G
         eaOCv9MjOLOAD8IJM/L6UdeDQ0BgzNFjrfbuNRW/hdAqjYM1c+Qles/5gbgxDEfMA0Vj
         prsoTa6PU4HsymiS/nhZzULM41KhHPk4oJUUWeUolBo/eBt3MBBijM6e37EW3dDQBLI4
         NEIaJKCRYBlcz1DlT7x6y4khCstxML0bOpQ0YTUIk+cuuJzlUCnYn7jih7EGbSsPC7d6
         nL313WQaJumMaAoJsr8ljAXrQjxFVMQ4Zo5r45P+0VUxCzVw5XsyuoTOS9tFYNp1T4fe
         2N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748905505; x=1749510305;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HB/OaWbP3gvs7kM2DDOFGaeE+8TrxotTvDBDnQTbVo=;
        b=m+HdvKNn3FFbVhd/M98I52U1EJdJ+9JsU3eMYcSPskHVX50nuK1BB7IxO1AONBE796
         rTsOu07Luzhwu8NjsS3LMkgrVl0bS40LdNdGdUYaZ5uDcPLWy3SxYGQo06fvVRzMtSrg
         0Kfxi6LXJoqU6nlo4EHL3F53Wy+T9vVb9kZ8z8zIiWiUGJ8SmWgUtP0/HX6z8T0P2OBT
         Nww9Bv/DDfLyCxhGPVOa2qQVdfEX3JktciGOgprGpotrXiAtufyNzkpl7XHkQMlAfaFl
         WXyCS7l9bQ1NoqRvzndpss+8BXzEPN4cqKn6EVUthwWZgwQBHVQ0hPpPm6XNoY1NDk3X
         bHjg==
X-Forwarded-Encrypted: i=1; AJvYcCXbQBxODt/DmPgpUgZEnD1kFHTH1UiYF4NiWWToRt5yhUUG77lQ0EYSlKIF7z31NCHxP2wQ2TRAMC+lTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxltggG1PSPazEVuA3Uv6hkfVySm0HQipUl3SmF5caqXeaEGckg
	hP/UXDhbM4KCRtJd3H1kcHV63FNgWoeaQwVg7y6NYzg5LbNeuQ/+Bw0JuasO9kQcx2sDDEFBkej
	ias6Q
X-Gm-Gg: ASbGnctl240zgt//I/mCgSUujQxwI3gbnnehAEPGhGHZtF3CUfxlqUpyg85FfCqxyaQ
	OnaGxsl8wN6vpmqc6AMxRqG8EQTOe+mzFALb0QsyqKDUVEkIR1hJVv1T2rvaTztLW/1VnzAtGoQ
	11Fu65UGmtg2m8ywX1JiIoo9FaCjeHcbiKWr6Btkcxzesn8mV3i0G0TzhnOyRQHM+egvyJ8Igni
	yXCLddBgX0KL/OnGkiQGGzxfzho/ezAUZqw2Q2Lu4UJLahFo/zcCX6X1nh5FiP673ySh0Joe3v/
	05nFtBPX3zLiYtE3Ri7A4rmW77sqtCrL9l3Mcka+Vwvso5XifU7rJw9WHz9UodCVZkLSFSTuWi5
	Gi300Bvh8w8WM4g==
X-Google-Smtp-Source: AGHT+IHhtpwatan5rve1jXGjrwHCpvovmbf+fZsUvWIRCt2Kp1co7keda9o+rdmwlG7d7QTrzfO9Og==
X-Received: by 2002:a05:6000:288b:b0:3a4:d6ed:8e07 with SMTP id ffacd0b85a97d-3a4f7a8525amr10817080f8f.32.1748905504895;
        Mon, 02 Jun 2025 16:05:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affb01bbsm8125384b3a.118.2025.06.02.16.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 16:05:04 -0700 (PDT)
Message-ID: <62d4ff91-d65f-4105-8915-3ede238d33ee@suse.com>
Date: Tue, 3 Jun 2025 08:34:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems mounting btrfs
To: "ohrbote@yahoo.com" <ohrbote@yahoo.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1272487245.3927281.1748871755247.ref@mail.yahoo.com>
 <1272487245.3927281.1748871755247@mail.yahoo.com>
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
In-Reply-To: <1272487245.3927281.1748871755247@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/2 23:12, ohrbote@yahoo.com 写道:
> Hi there, two days ago my computer had a kernel panic and I needed to switch it off the hard way. Since then, when I boot, I'm greeted directly with Busybox initramfs shell. I tried to boot into a Live Recovery disk, opened my Luks container and tried to mount the btrfs filesystem. But to no avail. I attached some information and hope to find some help here. Thanks in advance.
> 
> recovery@recovery:~$ sudo mount /dev/mapper/data-root /mnt
> mount: /mnt: mount(2) system call failed: File exists.
> 
> recovery@recovery:~$ sudo btrfs --version
> btrfs-progs v5.16.2

Your progs is too old, please update.

> 
> recovery@recovery:~$ sudo btrfs rescue zero-log /dev/mapper/data-root
> couldn't open RDWR because of unsupported option features (0x7)
> ERROR: could not open ctree

According to the dmesg, the log-replay failed with some existing delayed 
refs.

Normally zero-log should clear the log and at least the initial mount 
should success.

But I still recommend a full "btrfs check --readonly" on the fs with 
latest progs. (after the zero-log run)



> 
> recovery@recovery:~$ sudo btrfs check --clear-space-cache v2 /dev/mapper/data-root
> Opening filesystem to check...
> couldn't open RDWR because of unsupported option features (0x4)
> ERROR: cannot open file system
> 
> recovery@recovery:~$ sudo btrfstune -u /dev/mapper/data-root
> couldn't open RDWR because of unsupported option features (0x7)
> ERROR: open ctree failed

All above tries are very dangerous if the fs is already corrupted.
Thank god the older progs prevented them.

> 
> 
> recovery@recovery:~$ sudo btrfs inspect-internal dump-super /dev/mapper/data-root
> superblock: bytenr=65536, device=/dev/mapper/data-root
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0x0b234e5d [match]
> bytenr            65536
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            8e14c534-278c-471e-a714-37fcc6cb6e10
> metadata_uuid        8e14c534-278c-471e-a714-37fcc6cb6e10
> label
> generation        3079573
> root            2046672715776
> sys_array_size        129
> chunk_root_generation    3027625
> root_level        0
> chunk_root        2120474771456
> chunk_root_level    1
> log_root        2046734286848
> log_root_transid    0
> log_root_level        0
> total_bytes        246373416960
> bytes_used        224159674368
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x7
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID |
>                unknown flag: 0x4 )

Your fs have VERITY feature?
Did you intentionally enabled this feature?

If you have no clue what that feature is and have never enabled that, it 
may be a sign of hardware memory bitflip.

A full memtest is also recommended.

Thanks,
Qu

> incompat_flags        0x371
>              ( MIXED_BACKREF |
>                COMPRESS_ZSTD |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    3079573
> dev_item.uuid        114a9f2b-08e3-4f13-a660-31933f335bbd
> dev_item.fsid        8e14c534-278c-471e-a714-37fcc6cb6e10 [match]
> dev_item.type        0
> dev_item.total_bytes    246373416960
> dev_item.bytes_used    246372368384
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0



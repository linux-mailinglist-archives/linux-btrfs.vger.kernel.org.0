Return-Path: <linux-btrfs+bounces-17016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98AB8E8FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A321A165B9C
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4CB253951;
	Sun, 21 Sep 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UIWJgoOK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302128E3F
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494246; cv=none; b=UxNyvlLElzApzeqE6ZDx3hFlx10L4oEZbnyIW+7ltCROcdr/n39aP2CwQNgce5NEP6kstsbqXza5/C0WiXZuRgPBxAJnEetwhdMbWGhAJZyzB617YPespYD5QJgSBiyzFYnJc+dXN56JVtXf+EMpzjxhNK4oUl5krlPd4cLgWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494246; c=relaxed/simple;
	bh=5ZPmARStahdIfEP0avFGliffGbH4kbNXybzoJ+WmMQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cEFiFM/alKbFqwFgBIfMUxJEknrq0Y9/hPKLG34r3XoeR14UzQhATSmdAYPQzqHjr/zd8nWUQ8kZP4XvpQSFndqkGJOvNo/XiIjRtbRqT78IvKfWX1b12bb42jY4SGZBsXP57Df90VlrDGIILsEcSOZxz+i1WmONOnawjDOLQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UIWJgoOK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3fa528f127fso408551f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758494241; x=1759099041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YNCRmoGMPMmeptCwAs2es67xPzPFkJSwh3Ul4AEBzFE=;
        b=UIWJgoOK06B1HrDoNlGuY8V7CxAvExXESmi13mhoMJhUVSC3e044QVgjjr+sSkc4op
         gJtkrYkGNDFMO9NdwD3gF5GSasozKCfwwyw+kPU+ZOqjBSFCKjMc4dK8qw4GzboRKI1c
         Lj/uzZBwkTTjLZuoTk4E3GWUZjWSAQ5km7ugkNJtHi8Mf3p42uTwklcMCZJH64SIOCqp
         GZQFbq28zffzmfqYpUCxGEgCuKmzwi/9d75i3a1ATg4pDOw3uLxSDyRXS4mTDCb2XAXR
         mgikaS2DKEVfGmhGwPsWuLb3OXYcX0O+mXKsePag8rFA8V0GPihL3OJb0WuqQaLZo7hn
         tv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758494241; x=1759099041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNCRmoGMPMmeptCwAs2es67xPzPFkJSwh3Ul4AEBzFE=;
        b=ZbE+4R+bfVzHKb7YmXKg1cr4kgGHYOhn55Em6eMFW9zw55WLtra6Nv3XHN6cliL6ua
         a36GoraJq4UvVuiB9jdrRbeyEXsEjVKsTRy0pdJkxH0ONwhueRPTxL3ooTOxe5i7HUZ1
         h0e2bGnfM/9L0BXphZQv1UO8AcdFZa7pPKhy68ABaKQiBFtnP5GmAv67kMMT5dAcnQHK
         ppO4SfaF2NlrYk58yYWXYP7u6HhSV2ZxQWOgJUkkcLLTp4Zffp5HSWRproNSTa+hnXoF
         CRFkxUad7iOylfbTPiBg0AMfvWLQ7KaVDEHYXTKm0yVk7JjteEfLMxEcemBkbOECEb9/
         2uJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLhhIArSzN9QlNZa3rXblhRncljSRRkdEFmWeDUmP8To7VEEpXvKZSiLqWTbj3c0lt1M51WNF9PPOhcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRYwSRug92TcNhYKGHhWdHj33b2PGzHxK4d4ro6pAA7ncdkon
	/M+WSmT6hTzf4R9VzEEC2veduEUqe9yW0PGRcvh7Focy0B2kF64zGYwBDcwooDxycQ8=
X-Gm-Gg: ASbGncvzUfjTl48fuhW5YlFCYbJUgAFf5YcksOe/7sb7ebevM+Zo2oAA4EbwmG1FeTq
	yVTEqE9VDAh94XmAmpxgGASwRrXiJlyrygB2oq907hzZnU+4J5KABL79jAvKRAk44XXU2I02M3A
	uPwO883OF8w7qtQzsgLVSoepSxaV0uPhHKd6GOkeT9QcVuQ9N2OnV4pAOrSNO0epDDx3lKqqDha
	Zuq4eW2RXrKU62933BYPOxaanN/lxT7mTlNYE5EcpGXgFkXaea+foJMqpBZELFqrTBBfmeThD5Q
	ojnOit38Okg/q9LS4yRDxASY6j8YJJqoDz+sKXufM0Ut2maLxSA914URTbW0xSAk7H5rTmDLjpT
	C1dtg74aB0XKs7fedwiBj2mbXWaoaV2jLsr9M+J3CmNCFhSnkCTk=
X-Google-Smtp-Source: AGHT+IG9Wd336+QgzB3UMKQKwUeGU0JJizXoxsY1dCAq5WyIK9ufDKCxcOskR3QeSPHeMyc7JoJk8g==
X-Received: by 2002:a05:6000:1acc:b0:3fa:2df7:6a0a with SMTP id ffacd0b85a97d-3fa2df76f17mr1971073f8f.22.1758494241418;
        Sun, 21 Sep 2025 15:37:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40263sm10899256b3a.80.2025.09.21.15.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 15:37:20 -0700 (PDT)
Message-ID: <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
Date: Mon, 22 Sep 2025 08:07:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
To: Justin Brown <Justin.Brown@fandingo.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
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
In-Reply-To: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/22 06:45, Justin Brown 写道:
> Hi,
> 
> I had a pretty bad power outage that fried my server. I pulled a Btrfs
> HDD (1 drive, -d single, -m dup), and I'm trying to recover it. The
> HDD works fine -- the LUKS volume unlocks, and I can dd read from it,
> but the fs seems to be in bad shape. I've spent a few hours
> researching, but a lot of the information out there is really low
> quality. I've tried to stay away from the really dangerous stuff so
> far, but I did try some of the more benign troubleshooting.
> 
> Kernel: 6.16.5-arch1-1
> btrfs-progs v6.16
> 
> [fandingo:~] $ lsblk -o name,size,label,fstype,model /dev/sdc
> NAME  SIZE LABEL       FSTYPE      MODEL
> sdc   7.3T crypt_media crypto_LUKS ST8000VN004-2M2101
> └─cm  7.3T media       btrfs
> 
> [fandingo:~] $ sudo btrfs fi showLabel: 'media'  uuid:
> e2dc4c13-e687-4829-8c24-fa822d9ba04a
>         Total devices 1 FS bytes used 6.10TiB
>         devid    1 size 7.28TiB used 6.24TiB path /dev/mapper/cm
> 
> 
> [fandingo:~] $ sudo mount -o ro /dev/mapper/cm /var/media/
> mount: /var/media: can't read superblock on /dev/mapper/cm.
>        dmesg(1) may have more information after failed mount system call.
> [fandingo:~] 32 $ sudo dmesg
> [ 7546.813999] BTRFS: device label media devid 1 transid 4956
> /dev/mapper/cm (253:5) scanned by mount (6934)
> [ 7546.814345] BTRFS info (device dm-5): first mount of filesystem
> e2dc4c13-e687-4829-8c24-fa822d9ba04a
> [ 7546.814354] BTRFS info (device dm-5): using crc32c (crc32c-x86)
> checksum algorithm
> [ 7546.814743] BTRFS error (device dm-5): level verify failed on
> logical 27656192 mirror 1 wanted 1 found 0
> [ 7546.814831] BTRFS error (device dm-5): level verify failed on
> logical 27656192 mirror 2 wanted 1 found 0
> [ 7546.814837] BTRFS error (device dm-5): failed to read chunk root
> [ 7546.814933] BTRFS error (device dm-5): open_ctree failed: -5
> 
> 
> I've tried a few recovery options, tending towards the more safe side.
> 
> ~$: sudo mount -o ro,rescue=usebackuproot /dev/mapper/cm /var/media
> Same error and dmesg

This means the corruption in not in the last transaction, but may be one 
generations earlier.

This also indicates that some metadata write is lost, which is a huge 
problem.
Not sure if LUKS or the HDD is involved in this case.
> 
> ======
> 
> [fandingo:~] 3s $ sudo btrfs-find-root /dev/mapper/cm

Find root should help in this case, but not the default option.

You need "-o 3" option to tell the program to find chunk root.

Then use the bytenr it reported to pass into "btrfs check --chunk-root 
<bytenr>" to verify which works the best.

Thanks,
Qu

> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> WARNING: cannot read chunk root, continue anyway
> Superblock thinks the generation is 4956
> Superblock thinks the level is 0
> 
> ======
> 
> [fandingo:~] 30s $ sudo btrfs rescue zero-log /dev/mapper/cm
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> ERROR: cannot read chunk root
> ERROR: could not open ctree
> 
> ======
> 
> [fandingo:~] 1 $ sudo btrfs rescue super-recover /dev/mapper/cm
> All supers are valid, no need to recover
> 
> ======
> 
> [fandingo:~] 4s $ sudo btrfs restore /dev/mapper/cm /var/media/
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> Ignoring transid failure
> ERROR: root [3 0] level 0 does not match 1
> 
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> Ignoring transid failure
> ERROR: root [3 0] level 0 does not match 1
> 
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> Ignoring transid failure
> ERROR: root [3 0] level 0 does not match 1
> 
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> 
> =======
> 
> [fandingo:~] 13s $ sudo btrfs inspect-internal dump-tree /dev/mapper/cm
> btrfs-progs v6.16.1
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> ERROR: cannot read chunk root
> ERROR: unable to open /dev/mapper/cm
> 
> Same error for `btrfs inspect-internal tree-stats`.
> 
> =======
> 
> [fandingo:~] 4s $ sudo btrfs inspect-internal dump-super /dev/mapper/cm
> superblock: bytenr=65536, device=/dev/mapper/cm
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x05e1f6bc [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    e2dc4c13-e687-4829-8c24-fa822d9ba04a
> metadata_uuid           00000000-0000-0000-0000-000000000000
> label                   media
> generation              4956
> root                    998506496
> sys_array_size          129
> chunk_root_generation   4945
> root_level              0
> chunk_root              27656192
> chunk_root_level        1
> log_root                0
> log_root_transid (deprecated)   0
> log_root_level          0
> total_bytes             8001546444800
> bytes_used              6708315303936
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x3
>                         ( FREE_SPACE_TREE |
>                           FREE_SPACE_TREE_VALID )
> incompat_flags          0x361
>                         ( MIXED_BACKREF |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA |
>                           NO_HOLES )
> cache_generation        0
> uuid_tree_generation    4956
> dev_item.uuid           529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> dev_item.fsid           e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> dev_item.type           0
> dev_item.total_bytes    8001546444800
> dev_item.bytes_used     6856940453888
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> 
> 
> 
> 
> 
> This HDD is used for occasional archival, and it probably didn't see
> any data writes in the week prior to the power surge. If I could get
> access to any of the data, even old version (eg. that 2607 transid or
> whatever the proper terminology is), would be very useful. Any
> suggestions on what to do from here?
> 
> Thanks,
> fandingo
> 



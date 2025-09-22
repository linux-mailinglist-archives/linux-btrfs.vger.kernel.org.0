Return-Path: <linux-btrfs+bounces-17033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01038B8EA72
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 03:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11BD189A6A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 01:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C12F1459F7;
	Mon, 22 Sep 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b="OBjlRkIt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB212CD8B
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503248; cv=none; b=CMlvOzKTCezi1yIQIw9XDYo6rVVq3nkK17ZLzP5fAndUCHFu9Bax0YmjoRbBshYyqHqZa+IpWeCNhKAqCeWqUWudjv9tIAjMARwPyPoloAdlWwu4OgV+r3VqYa/HH1VaD9Q4kdQBLll522gVhcy/k3nxhTAC3BB7gB5rvn3suo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503248; c=relaxed/simple;
	bh=WaMY8piM7+nmQ4wWfm76bx1afnGfa+lqev9JM2rqKNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bg/PCltxsSXjUPsZxomi7phF4vRy1trWspu57f/8C+pvFT0sbWDChcK+TdhhiuA7/XTsz6etniWJg1uwVW645hoa1DHEOsuY6+2opigNrhbrC6YphJSxzrLUF4thlR5/jpt3ez/NJ3AhXwxXNlK+1ND3br2pCvOcoYEXdG/inTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org; spf=none smtp.mailfrom=fandingo.org; dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b=OBjlRkIt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fandingo.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0787fa12e2so540993766b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fandingo-org.20230601.gappssmtp.com; s=20230601; t=1758503244; x=1759108044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oaEkehQFclxGNPJL9s9OXMNSTqyc/P+yjOMW0TDxg0=;
        b=OBjlRkIt4nMKL2YozEraVlYduAVHzon2LPEoQVWpKMpAqabbcPqhlF4bfFTbWLF/1q
         3NjtMJn3jSLjftfkfRCg1CGv+yT1Zdr+ikILCpgXEwfYya41nd4YsCalQSZrSvigxWBB
         IB8AzP8kGydeAKF7pkVwOTftrGIwu92WbZ32emZc7pjHDUDHUIRPizQ6qoGOnKGrORYc
         aEci0YnaN16jSdm3Ywftt759Y8bWKKEDuJEFQzZvHBbPQXmTZ7v4zgBum8JF6MjsFLzR
         9yZppGADEbhhIE1IrBr1sg7ayARJaQqyK+bZWU4rGtTqrACPwfXYwD2q91NIn9wb9mNy
         CaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503244; x=1759108044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oaEkehQFclxGNPJL9s9OXMNSTqyc/P+yjOMW0TDxg0=;
        b=fmWboC6TDa+HWlxTFezjhtpC46N+hkAKhJFFJpiSMdwVecjMJbDJgM5WaNSLcPmDSZ
         UIxZFVmp/kiotM9PGfK8f8DFEwUnUx83WW4TmKL96p9V/DxyCc1zAvZxd97W2x8CAsRk
         NzkMZnZtYplGla0r9BOl2QAf8+S9Ti/5u4GpzEgsf3b6tLk14jQ2ZnAVRH4nfb5u1/EI
         +CCZSoecyXUjpH1paDn61cCffmQNGYSTxp4gVU2WdwnUK8lttLsJ9x6ghkFl1ccDj0KZ
         rGKtgEhGjnOsKitm0TmKKsdMD1W3CNDiZhbnKCYN1hjRn3lywINrGHAMhZG40Uf9DauL
         qRYA==
X-Forwarded-Encrypted: i=1; AJvYcCXJoQaey0B4u8vynaMzUjZDXLAQ80QfAbAorXhzqzet5pvugJezLTHDLrwl2RhVnI/rx6SuoE/f4KSzOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJ1725HXutNR2mlngNMiHVFKYNOQfx3I0gYldqK+IOKoLHdHw
	F7ucBiZDErlaJSqmeW3C/36ATfIpKFX2reZ0NFvKe1VFuMxjQx/GR95gTojRIJUcvwVUgbws8mg
	swMyUezO19FI6mbUoj4QZ/PnFkX/CTDGUv1RsZvWZKw==
X-Gm-Gg: ASbGncunrJs+Zf+NzWaVJ7fWoUfcbnn1UdL1deDIleLodB/oKNF9Z2jM5RyuCPBj10O
	tL8WRQ6jUVryxVzw+DJV9ntkv2uL53QoPE4KuriiPpmBs4D0cFU/MGATz7oZpxGQa/XXGYkMpFi
	awPO3vy+5fuLt1LQUtiLkZ89oAVo91RWtQRfzgJsq14pJCpQoe9TR4lPHagXgOSg5YgSQeSQHE0
	pAdWHNRSwGLXJJ7to2Qc6fqvQWIBgq0OW3LZeXNJkfGdck5QKQ=
X-Google-Smtp-Source: AGHT+IGrFvZiOLBZdCd5lxj5dH02I2B2LwGZKcVc3TQ5IR6mSZlgn5wtKNu06lRXMoTo2AYTxph9PgDy6pmRq6zFLJk=
X-Received: by 2002:a17:906:dc93:b0:b0c:5929:4cff with SMTP id
 a640c23a62f3a-b24f052bad5mr1127055266b.26.1758503244210; Sun, 21 Sep 2025
 18:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
 <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com> <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
 <23d859bc-19f9-4cf5-9405-03792dbf2e7a@gmx.com> <293aab80-89e4-44fe-b588-977ab24dbf51@app.fastmail.com>
In-Reply-To: <293aab80-89e4-44fe-b588-977ab24dbf51@app.fastmail.com>
From: Justin Brown <Justin.Brown@fandingo.org>
Date: Sun, 21 Sep 2025 20:07:13 -0500
X-Gm-Features: AS18NWCBhVW04cjp8_eHRoAn0jEwfcJ3xN0Q_DDF6MuSAHFfBPlNmwm1febGUiQ
Message-ID: <CAKZK7ux=z2OT2psm8C06RTM+D4CweQe8dQZxEZ4SNeOwhhfA0g@mail.gmail.com>
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
To: Chris Murphy <lists@colorremedies.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>, 
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu,

Thanks for the response. I ran a readonly check against all the
bytenrs, but it doesn't look great:

[fandingo:~] $ for i in $(sudo  btrfs-find-root -o 3 /dev/mapper/cm |
grep '^Well' | sed 's/^Well block \([0-9]\+\).*$/\1/g' | sort -n); do
           echo "######### $i #########" | tee -a /tmp/btrfs-check.txt ;
           sudo btrfs check --readonly --chunk-root $i /dev/mapper/cm
2>&1 | tee -a /tmp/btrfs-check.txt;
done

Full output at https://pastebin.com/aWKsc9AH

There are a lot of repeated errors, which I guess should be expected,
and a lot of the same numbers repeated. Decent amount of errors that
look like this:

ERROR: root [3 0] level 0 does not match 1
ERROR: cannot read chunk root
ERROR: cannot open file system
Opening filesystem to check...

and lots of these, sometimes with different numbers as the bytenr decreases=
.

######### 22052864 #########
parent transid verify failed on 29442048 wanted 2185 found 3178
parent transid verify failed on 29442048 wanted 2185 found 3178
parent transid verify failed on 29442048 wanted 2185 found 3178
Ignoring transid failure
parent transid verify failed on 1004077056 wanted 4945 found 4933
parent transid verify failed on 1004077056 wanted 4945 found 4933
parent transid verify failed on 1004077056 wanted 4945 found 4933
Ignoring transid failure
parent transid verify failed on 1004093440 wanted 4945 found 4941
parent transid verify failed on 1004093440 wanted 4945 found 4941
parent transid verify failed on 1004093440 wanted 4945 found 4941
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D998031360 item=3D130 parent
level=3D1 child bytenr=3D1004093440 child level=3D2
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system
Opening filesystem to check...



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Chris,

Here's the output of the backup roots. I have no clue what to make of
this information, though.

superblock: bytenr=3D65536, device=3D/dev/mapper/cm
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x05e1f6bc [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
metadata_uuid        00000000-0000-0000-0000-000000000000
label            media
generation        4956
root            998506496
sys_array_size        129
chunk_root_generation    4945
root_level        0
chunk_root        27656192
chunk_root_level    1
log_root        0
log_root_transid (deprecated)    0
log_root_level        0
total_bytes        8001546444800
bytes_used        6708315303936
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x3
            ( FREE_SPACE_TREE |
              FREE_SPACE_TREE_VALID )
incompat_flags        0x361
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA |
              NO_HOLES )
cache_generation    0
uuid_tree_generation    4956
dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
dev_item.type        0
dev_item.total_bytes    8001546444800
dev_item.bytes_used    6856940453888
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
sys_chunk_array[2048]:
    item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
        length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
        io_align 65536 io_width 65536 sector_size 4096
        num_stripes 2 sub_stripes 1
            stripe 0 devid 1 offset 22020096
            dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
            stripe 1 devid 1 offset 30408704
            dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
backup_roots[4]:
    backup 0:
        backup_tree_root:    1022836736    gen: 4953    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    1003782144    gen: 4953    level: 2
        backup_fs_root:        1006288896    gen: 4950    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1003618304    gen: 4953    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708289445888
        backup_num_devices:    1

    backup 1:
        backup_tree_root:    1005043712    gen: 4954    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    997343232    gen: 4954    level: 2
        backup_fs_root:        1006288896    gen: 4950    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1005486080    gen: 4955    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708293525504
        backup_num_devices:    1

    backup 2:
        backup_tree_root:    1011204096    gen: 4955    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    602931200    gen: 4955    level: 2
        backup_fs_root:        1023918080    gen: 4955    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1005486080    gen: 4955    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708307161088
        backup_num_devices:    1

    backup 3:
        backup_tree_root:    998506496    gen: 4956    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    1027489792    gen: 4956    level: 2
        backup_fs_root:        1023918080    gen: 4955    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1025638400    gen: 4956    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708315303936
        backup_num_devices:    1


superblock: bytenr=3D67108864, device=3D/dev/mapper/cm
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0xa580de72 [match]
bytenr            67108864
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
metadata_uuid        00000000-0000-0000-0000-000000000000
label            media
generation        4956
root            998506496
sys_array_size        129
chunk_root_generation    4945
root_level        0
chunk_root        27656192
chunk_root_level    1
log_root        0
log_root_transid (deprecated)    0
log_root_level        0
total_bytes        8001546444800
bytes_used        6708315303936
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x3
            ( FREE_SPACE_TREE |
              FREE_SPACE_TREE_VALID )
incompat_flags        0x361
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA |
              NO_HOLES )
cache_generation    0
uuid_tree_generation    4956
dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
dev_item.type        0
dev_item.total_bytes    8001546444800
dev_item.bytes_used    6856940453888
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
sys_chunk_array[2048]:
    item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
        length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
        io_align 65536 io_width 65536 sector_size 4096
        num_stripes 2 sub_stripes 1
            stripe 0 devid 1 offset 22020096
            dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
            stripe 1 devid 1 offset 30408704
            dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
backup_roots[4]:
    backup 0:
        backup_tree_root:    1022836736    gen: 4953    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    1003782144    gen: 4953    level: 2
        backup_fs_root:        1006288896    gen: 4950    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1003618304    gen: 4953    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708289445888
        backup_num_devices:    1

    backup 1:
        backup_tree_root:    1005043712    gen: 4954    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    997343232    gen: 4954    level: 2
        backup_fs_root:        1006288896    gen: 4950    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1005486080    gen: 4955    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708293525504
        backup_num_devices:    1

    backup 2:
        backup_tree_root:    1011204096    gen: 4955    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    602931200    gen: 4955    level: 2
        backup_fs_root:        1023918080    gen: 4955    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1005486080    gen: 4955    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708307161088
        backup_num_devices:    1

    backup 3:
        backup_tree_root:    998506496    gen: 4956    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    1027489792    gen: 4956    level: 2
        backup_fs_root:        1023918080    gen: 4955    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1025638400    gen: 4956    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708315303936
        backup_num_devices:    1


superblock: bytenr=3D274877906944, device=3D/dev/mapper/cm
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x58078843 [match]
bytenr            274877906944
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
metadata_uuid        00000000-0000-0000-0000-000000000000
label            media
generation        4956
root            998506496
sys_array_size        129
chunk_root_generation    4945
root_level        0
chunk_root        27656192
chunk_root_level    1
log_root        0
log_root_transid (deprecated)    0
log_root_level        0
total_bytes        8001546444800
bytes_used        6708315303936
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x3
            ( FREE_SPACE_TREE |
              FREE_SPACE_TREE_VALID )
incompat_flags        0x361
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA |
              NO_HOLES )
cache_generation    0
uuid_tree_generation    4956
dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
dev_item.type        0
dev_item.total_bytes    8001546444800
dev_item.bytes_used    6856940453888
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
sys_chunk_array[2048]:
    item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
        length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
        io_align 65536 io_width 65536 sector_size 4096
        num_stripes 2 sub_stripes 1
            stripe 0 devid 1 offset 22020096
            dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
            stripe 1 devid 1 offset 30408704
            dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
backup_roots[4]:
    backup 0:
        backup_tree_root:    1022836736    gen: 4953    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    1003782144    gen: 4953    level: 2
        backup_fs_root:        1006288896    gen: 4950    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1003618304    gen: 4953    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708289445888
        backup_num_devices:    1

    backup 1:
        backup_tree_root:    1005043712    gen: 4954    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    997343232    gen: 4954    level: 2
        backup_fs_root:        1006288896    gen: 4950    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1005486080    gen: 4955    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708293525504
        backup_num_devices:    1

    backup 2:
        backup_tree_root:    1011204096    gen: 4955    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    602931200    gen: 4955    level: 2
        backup_fs_root:        1023918080    gen: 4955    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1005486080    gen: 4955    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708307161088
        backup_num_devices:    1

    backup 3:
        backup_tree_root:    998506496    gen: 4956    level: 0
        backup_chunk_root:    27656192    gen: 4945    level: 1
        backup_extent_root:    1027489792    gen: 4956    level: 2
        backup_fs_root:        1023918080    gen: 4955    level: 0
        backup_dev_root:    1055571968    gen: 4945    level: 1
        csum_root:    1025638400    gen: 4956    level: 3
        backup_total_bytes:    8001546444800
        backup_bytes_used:    6708315303936
        backup_num_devices:    1



Thanks for both of your help,
fandingo


On Sun, Sep 21, 2025 at 7:31=E2=80=AFPM Chris Murphy <lists@colorremedies.c=
om> wrote:
>
> It might be worth looking at all supers and backup roots.
>
> btrfs insp dump-s -fa /dev/sdXY
>
> The supers should be all the same on HDD. The backup roots might be more =
reliable for attempting repair compared to SSD where I've seen recent (but =
zero ref) trees already overwritten by btrfs. That doesn't appear to be the=
 case here, seems like newer trees weren't yet committed to stable media wh=
ich is ... not good.
>
> ---
> Chris Murphy


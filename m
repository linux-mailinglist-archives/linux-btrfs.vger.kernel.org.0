Return-Path: <linux-btrfs+bounces-5588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F60901B92
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 09:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B5282E9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 07:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F4025569;
	Mon, 10 Jun 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZgypMkj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A222EE5
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003547; cv=none; b=ScKSd9JgoEVmnDjcetLpEN9iMeusZ6CasSG3rra6dEnpOxk7xl4oCedFz18qqROT8LW5kaWpN9MWzvlEmuOPkV+gfpZP5PPITYGSyG+aM13KiehlOTFN55aM1pr6dta/CBm82M734k9988zl0Tqbalb1dMAFOKlhpBx+6WgnQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003547; c=relaxed/simple;
	bh=D4d6iGiUj4fiI/3cHLEhuT7dQTIx1mbrF0lRq2eBHR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uWHVUV+Dct1Jgp/WUfYzZg4uMfluDyjyMWYyh0iyCJVPbcbZqbABSyy4KkPQGEYBPrX/5khsPCaNb43qxJ6/Pt73WAjF8iH6x6WmWAON6jlkIvzLQsTc/sFZLan4oRSl5vWIrozA/Q7hPbIpfcyIEEJrTV3Kv51GC4MaxAD1vtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZgypMkj; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-24cbb884377so2208233fac.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718003545; x=1718608345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewI9TeYZM5C1SswOPCZZC8albz8K+Zlnj/YjQ4kfdAc=;
        b=jZgypMkjQQVyTmQ0mPRcVC2HeQ71exnhJO9AUK8xpNwgs3zcGn9b7FOQPvrNKWEZaY
         /8bg9MYkc/P5Lip7/u2fEcJIPypXg/erY+FGdRA+l4YrbBA3lk8nmPwuviXKtlqTCq0Q
         CruVWrnzBVGM/TrnMSyBBmadnYq7kruWZreVzvSeJZjJ1Q3Yo/xoLFBvgP8MOAT7RpAt
         RWRAn8h5/rPhUGl1Z89OJRAkRia3NMrmpUVPmty1iVFq27pFd0H1+MTnoTEh2LU9cUx2
         Ou+58x3PGrEv2kONML0HmTxcwdbfGgSJXFSgauqgyKcRFahxERUQkqF7o9t8xkSZfo6D
         KxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718003545; x=1718608345;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewI9TeYZM5C1SswOPCZZC8albz8K+Zlnj/YjQ4kfdAc=;
        b=uXn91FxlLS+EDcqFJ0D4anlP8FjNHcSNXnEIGAz8xTAyOD7jQz8MlcVRuVU324c708
         9wzV4yf4dvAe3VwJC0jcf4wKCxaP0dk6LfLig+n1fS5QJF2mCmkepcrvoWExkT1n60b8
         5l1meduBVkqyPil8JQsjE8S0o/2GyF7d/VTAFYSXct8fh4KaoalfLGaAoHxJ9h1nCN7A
         AdN7P9OTf5jGNqEiA6jZr6+57pkXuYSR6VBWs3mmqfZrB923yQZfRPQh2qxeYcxRqRYg
         N0NW8W8rLrQAtCTP1I6GlYXwfoiweMf1ob/+KC8IK5IzDVzMMJ0hgS7H5SprIdPJbjzu
         hDCg==
X-Forwarded-Encrypted: i=1; AJvYcCWOdCnVMFCibtq2wcQwfTlkD76eRznYCz2oEOguTXOXC0hnkylkJIjJ0cYSqCx4ZqZbITivK+4OuVKg5FcB+iCDy99LIeGXvYgo72c=
X-Gm-Message-State: AOJu0Yy9WPVbCPsmfzneFsnfwFKDgta4ImZrSteA4LnpSolVvvmcHrZX
	wtidz/7p9MkwZ509jM6Cgprb36OXLd2h+rPtpD0DQXmL4T50v+qA
X-Google-Smtp-Source: AGHT+IEx63uEnQgtrl8hBV53eMV3aoJNDlkobUv8ozFcr/iiEAVSjyqnB3yi/85SNesTR2gHTAXIJg==
X-Received: by 2002:a05:6870:65a4:b0:254:bf41:de9d with SMTP id 586e51a60fabf-254bf41f028mr3079221fac.48.1718003545189;
        Mon, 10 Jun 2024 00:12:25 -0700 (PDT)
Received: from [192.168.0.92] (syn-070-123-236-219.res.spectrum.com. [70.123.236.219])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25448138e4asm2167044fac.57.2024.06.10.00.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 00:12:24 -0700 (PDT)
Message-ID: <d1770aa6-76f6-4292-ac60-1e69e1bdb016@gmail.com>
Date: Mon, 10 Jun 2024 02:12:23 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-6.9 regression tests fail
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <2f8d2b44-8958-4312-bea2-8c53c2312c7c@gmail.com>
 <53eb0a7d-3ec5-4719-b508-b5f366e3b4e5@gmx.com>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
In-Reply-To: <53eb0a7d-3ec5-4719-b508-b5f366e3b4e5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/24 19:53, Qu Wenruo wrote:
> 
> 
> 在 2024/6/10 09:23, Bruce Dubbs 写道:
>> The convert and misc tests fail pretty early for me and I can't figure
>> out why.
>> The other btrfs tests complete normally.
>>
>> The significant output for convert-tests-results.txt is:
>>
>> ====== RUN CHECK mount -t btrfs -o loop
>> /build/btrfs/btrfs-progs-v6.9/tests/test.img
>> /build/btrfs/btrfs-progs-v6.9/tests/mnt
>> mount: /build/btrfs/btrfs-progs-v6.9/tests/mnt: fsconfig system call
>> failed: No such file or directory.
>>         dmesg(1) may have more information after failed mount system call.
>> failed: mount -t btrfs -o loop
>> /build/btrfs/btrfs-progs-v6.9/tests/test.img
>> /build/btrfs/btrfs-progs-v6.9/tests/mnt
>> test failed for case 003-ext4-basic
>>
>> dmesg gives me:
>>
>> [ 3807.421836] loop0: detected capacity change from 0 to 4194304
>> [ 3807.421933] BTRFS: device fsid 4f1a8440-1a8f-45d1-9789-72080ddd9917
>> devid 1 transid 7 /dev/loop0 (7:0) scanned by mount (3326)
>> [ 3807.423458] BTRFS info (device loop0): first mount of filesystem
>> 4f1a8440-1a8f-45d1-9789-72080ddd9917
>> [ 3807.423469] BTRFS info (device loop0): using crc32c (crc32c-generic)
>> checksum algorithm
>> [ 3807.423477] BTRFS info (device loop0): using free-space-tree
>> [ 3807.423911] BTRFS warning (device loop0): failed to read root
>> (objectid=12): -2
> 
> That's objectid is for RST, which shouldn't even be enabled unless you
> have enabled experimental features for btrfs-progs.

I have not.  I used:

./configure --prefix=/usr           \
             --disable-static        \
             --disable-documentation &&
make
make fssum

cd tests
./convert-tests.sh
...

> Mind to dump the superblock of that test image?
> ($BTRFS_PROGS_SOURCE/tests/test.img)

I haven't done that before, but this is what I have:

$ btrfs inspect-internal dump-super test.img
superblock: bytenr=65536, device=test.img
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x3da36db9 [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    c90faada-13cd-4e77-bd4a-a32018ad3b93
metadata_uuid           c90faada-13cd-4e77-bd4a-a32018ad3b93
label
generation              7
root                    67416064
sys_array_size          97
chunk_root_generation   2
root_level              0
chunk_root              35852288
chunk_root_level        0
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             2147483648
bytes_used              177639424
sectorsize              4096
nodesize                4096
leafsize (deprecated)   4096
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x3
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID )
incompat_flags          0x4341
                         ( MIXED_BACKREF |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES |
                           RAID_STRIPE_TREE )
cache_generation        0
uuid_tree_generation    0
dev_item.uuid           3cb58644-ed73-46ab-be03-68ebacc4a459
dev_item.fsid           c90faada-13cd-4e77-bd4a-a32018ad3b93 [match]
dev_item.type           0
dev_item.total_bytes    2147483648
dev_item.bytes_used     441581568
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

AFAICT test.img is generated by the tests.  I really do not know what any of that 
output means.

Other info: I am building with gcc-14.1.0.

   -- Bruce




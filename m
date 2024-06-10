Return-Path: <linux-btrfs+bounces-5617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E0390297C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 21:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AEB1F22E6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DBF14D714;
	Mon, 10 Jun 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaB97q+8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD321BC39
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048726; cv=none; b=TSpHQsfDmvipZiYYDfj5LNWCenSe1GegjNCrCo69ZY5KrufMksp/fDWOb/vVE7/aANFN1SjyFGWz+hhheAVv8m0IVHQgMRKxVw3bVEeMF+MF1LfnuiffNuOszKw+ECkRj+0wr4JXfV+ii4eKU4eBw/mnaL9QMQm5UH+1NzYUCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048726; c=relaxed/simple;
	bh=VDwdmOiTZVZGTNzDMCln6O8mppmJlGnbnusci4xB7o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mFgN/bCYVzgdhm2bO0Q2NGThlWtWltEMjCv/YvsHJ+yELuGIjjI6G1hszx50ArTt2jQF4vKgaWmJ6riH/WY35ALS2OT1DlyfXUva+A1wNfN1wCuMPFiv+woDbcg+FidEtrema4H6AtqWk/fPeRji3umAZmSkCorXYceSm7We+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaB97q+8; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f9bcb57482so716826a34.3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718048724; x=1718653524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T56h2Nqw9yp6LmoAi4uPWoMBMnMdcB+0aYiOpZw5aFE=;
        b=QaB97q+8iStYEL+HKR+tM5Rt6tOkJEWZVTYRzF9G6yH4dXg2cmFDz/8kermmeKz+gT
         Tp6YMkldfxnfk57WjYFs+g6a2RHtGS7Jt9JaHOvmK/Q6Y61AbxJwYp2+g8DJnFieSWBx
         GYsM21Xw4eTO8WNujq54brbW98ZvpLUEb38pebid3Lxs9sgV7TLwDZmeY2kDemVYOT3n
         mNVndQzUXC8anGyzD2qYFFBEx/trTTBhjxDsc0LIndqaYeV5b4PubtkEZXFRq3A8KUTL
         sJkLmy1qBG4AqPqKuHmIR6LjTj1ronv/WgRcuB/BJ2+wV7Kog8oxNRrkG5ov0R8uGY/s
         zkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718048724; x=1718653524;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T56h2Nqw9yp6LmoAi4uPWoMBMnMdcB+0aYiOpZw5aFE=;
        b=ilowi8o9gup75XecLn71jYCFS5wMeBYqL2+P/t8CvfAevEnqDZwBn2o/EJNfCEPCQz
         DTb81C69nOTZptw/WR5Uc3hKrJhrkStzpb7kAd7QatZyEHqK/0d15DubHBQValvMFfy0
         mDq9K3nK1eVMC1QtTwv5ijzWOlpTKd49fQMDFbmV5UHZM0EtdSNF1LUkOBiP20Xws3eK
         gzgrFsP6GG0wTKAPTYMYS/qnO9wFH8PPGqJigGUoDgXWTxJXfrplBEUd5f+vx5g9Avho
         msmW8NZzXYTkvul4LDj9Zh8R5OA4a5rqVkkz2pWjWx1xIP0IlleLBhOhNeRRq+JfUp+o
         qD5g==
X-Forwarded-Encrypted: i=1; AJvYcCW2qQPVFmeEbleSIIYLmi9KZ7yXQtIVFfvaTvptWWrO/jPdQ/bYboRkPOqEcojWuESRW5ypPiG2PnkDVC96SZFyQeRqYoAqLpIyPDM=
X-Gm-Message-State: AOJu0Yw8h1haM0mUcHmaJmB5rHo0BbN+KQkQMdYtGfVacj4dMocUeg3x
	U4NI/l4lB0NfjCCp8gpKJ5DVJZA5nTcCE6cmA9cKX/QNS/xVZtbiW2TgWw==
X-Google-Smtp-Source: AGHT+IEGDL3GTUb1U9vE8m6iDFfREbsxCuW12ixdyCD2Y09RDwVBBPcazYgzpFJr7DujeOwh5uyJrg==
X-Received: by 2002:a05:6830:18f8:b0:6f9:859e:9123 with SMTP id 46e09a7af769-6f9859e94afmr6157409a34.38.1718048724286;
        Mon, 10 Jun 2024 12:45:24 -0700 (PDT)
Received: from [192.168.0.92] (syn-070-123-236-219.res.spectrum.com. [70.123.236.219])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f9b92ee597sm505371a34.40.2024.06.10.12.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:45:23 -0700 (PDT)
Message-ID: <c0171db9-aeae-430a-8c12-b1a60d29c37b@gmail.com>
Date: Mon, 10 Jun 2024 14:45:23 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-6.9 regression tests fail
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <2f8d2b44-8958-4312-bea2-8c53c2312c7c@gmail.com>
 <53eb0a7d-3ec5-4719-b508-b5f366e3b4e5@gmx.com>
 <d1770aa6-76f6-4292-ac60-1e69e1bdb016@gmail.com>
 <32eb378b-db76-40a7-aeeb-9d36784b548e@gmx.com>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
In-Reply-To: <32eb378b-db76-40a7-aeeb-9d36784b548e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/24 02:49, Qu Wenruo wrote:
> 
> 
> 在 2024/6/10 16:42, Bruce Dubbs 写道:
>> On 6/9/24 19:53, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/6/10 09:23, Bruce Dubbs 写道:
>>>> The convert and misc tests fail pretty early for me and I can't figure
>>>> out why.
>>>> The other btrfs tests complete normally.
>>>>
>>>> The significant output for convert-tests-results.txt is:
>>>>
>>>> ====== RUN CHECK mount -t btrfs -o loop
>>>> /build/btrfs/btrfs-progs-v6.9/tests/test.img
>>>> /build/btrfs/btrfs-progs-v6.9/tests/mnt
>>>> mount: /build/btrfs/btrfs-progs-v6.9/tests/mnt: fsconfig system call
>>>> failed: No such file or directory.
>>>>         dmesg(1) may have more information after failed mount system call.
>>>> failed: mount -t btrfs -o loop
>>>> /build/btrfs/btrfs-progs-v6.9/tests/test.img
>>>> /build/btrfs/btrfs-progs-v6.9/tests/mnt
>>>> test failed for case 003-ext4-basic
>>>>
>>>> dmesg gives me:
>>>>
>>>> [ 3807.421836] loop0: detected capacity change from 0 to 4194304
>>>> [ 3807.421933] BTRFS: device fsid 4f1a8440-1a8f-45d1-9789-72080ddd9917
>>>> devid 1 transid 7 /dev/loop0 (7:0) scanned by mount (3326)
>>>> [ 3807.423458] BTRFS info (device loop0): first mount of filesystem
>>>> 4f1a8440-1a8f-45d1-9789-72080ddd9917
>>>> [ 3807.423469] BTRFS info (device loop0): using crc32c (crc32c-generic)
>>>> checksum algorithm
>>>> [ 3807.423477] BTRFS info (device loop0): using free-space-tree
>>>> [ 3807.423911] BTRFS warning (device loop0): failed to read root
>>>> (objectid=12): -2
>>>
>>> That's objectid is for RST, which shouldn't even be enabled unless you
>>> have enabled experimental features for btrfs-progs.
>>
>> I have not.  I used:
>>
>> ./configure --prefix=/usr           \
>>              --disable-static        \
>>              --disable-documentation &&
>> make
>> make fssum
>>
>> cd tests
>> ./convert-tests.sh
>> ...
>>
>>> Mind to dump the superblock of that test image?
>>> ($BTRFS_PROGS_SOURCE/tests/test.img)
>>
>> I haven't done that before, but this is what I have:
>>
>> $ btrfs inspect-internal dump-super test.img
>> superblock: bytenr=65536, device=test.img
>> ---------------------------------------------------------
>> csum_type               0 (crc32c)
>> csum_size               4
>> csum                    0x3da36db9 [match]
>> bytenr                  65536
>> flags                   0x1
>>                          ( WRITTEN )
>> magic                   _BHRfS_M [match]
>> fsid                    c90faada-13cd-4e77-bd4a-a32018ad3b93
>> metadata_uuid           c90faada-13cd-4e77-bd4a-a32018ad3b93
>> label
>> generation              7
>> root                    67416064
>> sys_array_size          97
>> chunk_root_generation   2
>> root_level              0
>> chunk_root              35852288
>> chunk_root_level        0
>> log_root                0
>> log_root_transid (deprecated)   0
>> log_root_level          0
>> total_bytes             2147483648
>> bytes_used              177639424
>> sectorsize              4096
>> nodesize                4096
>> leafsize (deprecated)   4096
>> stripesize              4096
>> root_dir                6
>> num_devices             1
>> compat_flags            0x0
>> compat_ro_flags         0x3
>>                          ( FREE_SPACE_TREE |
>>                            FREE_SPACE_TREE_VALID )
>> incompat_flags          0x4341
>>                          ( MIXED_BACKREF |
>>                            EXTENDED_IREF |
>>                            SKINNY_METADATA |
>>                            NO_HOLES |
>>                            RAID_STRIPE_TREE )
> 
> OK, it's a fix that didn't get merged by David:
> 
> [PATCH 1/3] Revert "btrfs-progs: convert: add raid-stripe-tree to allowed features"
> 
> To David: any reason why that revert is not merged?

Just a note on kernel configuration.

On the original system above with the convert test failures the kernel had:

CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y

But on another system with configuration:

CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set

All tests convert tests pass.

   -- Bruce




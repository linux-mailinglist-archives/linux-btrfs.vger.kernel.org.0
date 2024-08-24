Return-Path: <linux-btrfs+bounces-7471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D195DD48
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 12:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7EB28314F
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE92155733;
	Sat, 24 Aug 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TVRqjVZQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928A1BDDB
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493656; cv=none; b=PMBQZ0JpYesfkNJPG4I+f6p2C+UUsnyCot5Tv9a7gRXSVCgAqMOZXO7+AJlsMePwj8m/jxAhPYVQS+T1WrifkDQCnZoKFP+jQHdcGCimnWEpwKx4KQH/961UIPyFbBevUUsEsExT1zxajw3ErghyZF7I+kyT41dwkRVTJwer8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493656; c=relaxed/simple;
	bh=1CH4tcUrCKXrc5jP0nwalRFME97xQrFvPZT77ddzJPc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=q8a1nL07PSFMb6xkLbkwNxkJTnr2IV6TL1GtSTVL7UnhoV3WpO+5XEY3Fry4tH7uB4dL2qarrJ05fB8cQGLMQf8tQFlpxMXKyf5bMEzuxT8M503Rr/RxfUfOClrofDLALmqx04rJN416YbUDMB22Ha228y5foM/029XVtEvPdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TVRqjVZQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371936541caso1256254f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2024 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724493653; x=1725098453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+czlZd58H2rKaE7aDATh27UJqgMNCH6RjOZaaY4aZos=;
        b=TVRqjVZQ770XkVQ9ZzhReHGUX2RsJH2xnL5fIIbrBsEYTo/nzAZYOXIM68z6/MALcB
         hg5hmANOHtI/ByhJMq2XJHM4WAegM8z2x+bmQ1gvJXm7LSxR8aikRmEqkHeFDMZhxDrG
         jzn0kzogfi5DZolIP+OwNQZQpgxeakro/Gqu7/eYJFZhSc/N55YEVkA/b5B5GdBdW8Y/
         JEjETQK9wTAmDRwFR52e4hf8EYI323hFM9fXtPQJYhJBoa5eVNMk3aERLLrI5h3AvjGr
         kqopCSMHyLESZG3mq7dqQfgNdVQAVs5qy6pZxOLPC7+gEvMt2AILCCzY+mSIVrDi0f6E
         V6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724493653; x=1725098453;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+czlZd58H2rKaE7aDATh27UJqgMNCH6RjOZaaY4aZos=;
        b=d/w0hd+DRTy3qRoJecE04+JJLjTHh2rBfBenuEkbRr7eHFyfsGeppZemhF7x8wmfYu
         2b4GHks5oBOk/N3lpaTMCYJvDJWEs2cg1aNrw1AQlhBF0eFgDW7HcDJGX0O1VOjwgr+j
         INmtJ4nLX6z3yKWVwOotCY4T65LxiMMaqGXsleK+fVaSZmfcM9cI1RETQiKmOFrSnTn+
         InqBblygJho+BUlfStbIxnVnH7bIy+QBbo9Y38x60B7sai/pF/FXIR2q0OJvybfMo9HH
         kuaD+cagzBwie6HC71+RL7Xdv0kho1upjWIQ61PWs8WuQa3xyNrTSOA5lmsnVgKv+Un0
         KVoQ==
X-Gm-Message-State: AOJu0YzmroaIQkf17iywW7xJbGCGgHm/IebZaROTWJ2eb2I0TezEjpFD
	hDS3V2goqVzZSeyyhHxjz6Y0vZB5x0LLGTyRV7xs1s/ZlqXfdQ6/BdBepOXo4uR7lstC7haaO1x
	c
X-Google-Smtp-Source: AGHT+IG0mLMsOriejyNxaTmwEBFD9UoRl/Y8X+oXXHfBBICHrk2i5bmPBGv0zubCq7lJJhwVT+k8Ew==
X-Received: by 2002:a5d:5681:0:b0:371:937a:3276 with SMTP id ffacd0b85a97d-373118ea24amr2690594f8f.57.1724493652141;
        Sat, 24 Aug 2024 03:00:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385bdd4a2sm39998475ad.281.2024.08.24.03.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 03:00:51 -0700 (PDT)
Message-ID: <3daa0e20-721c-4024-a5a4-733767af46ef@suse.com>
Date: Sat, 24 Aug 2024 19:30:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify a
 use-after-free bug
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240824071346.225289-1-wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <20240824071346.225289-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/24 16:43, Qu Wenruo 写道:
> [BUG]
> There is a use-after-free bug triggered very randomly by btrfs/125.
> 
> If KASAN is enabled it can be triggered on certain setup.
> Or it can lead to crash.
> 
> [CAUSE]
> The test case btrfs/125 is using RAID5 for metadata, which has a known
> RMW problem if the there is some corruption on-disk.
> 
> RMW will use the corrupted contents to generate a new parity, losing the
> final chance to rebuild the contents.
> 
> This is specific to metadata, as for data we have extra data checksum,
> but the metadata has extra problems like possible deadlock due to the
> extra metadata read/recovery needed to search the extent tree.
> 
> And we know this problem for a while but without a better solution other
> than avoid using RAID56 for metadata:
> 
>>    Metadata
>>        Do not use raid5 nor raid6 for metadata. Use raid1 or raid1c3
>>        respectively.
> 
> Combined with the above csum tree corruption, since RAID5 is stripe
> based, btrfs needs to split its read bios according to stripe boundary.
> And after a split, do a csum tree lookup for the expected csum.
> 
> But if that csum lookup failed, in the error path btrfs doesn't handle
> the split bios properly and lead to double freeing of the original bio
> (the one containing the bio vectors).
> 
> [NEW TEST CASE]
> Unlike the original btrfs/125, which is very random and picky to
> reproduce, introduce a new test case to verify the specific behavior by:
> 
> - Create a btrfs with enough csum leaves
>    To bump the csum tree level, use the minimal nodesize possible (4K).
>    Writing 32M data which needs at least 8 leaves for data checksum
> 
> - Find the last csum tree leave and corrupt it
> 
> - Read the data many times until we trigger the bug or exit gracefully
>    With an x86_64 VM (which is never able to trigger btrfs/125 failure)
>    with KASAN enabled, it can trigger the KASAN report in just 4
>    iterations (the default iteration number is 32).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> NOTE: the mentioned fix (currently v3) is not good enough, will be
> updated to v4 to fully pass the new test case.

The v4 version of the fix is submitted and can handle the test case 
properly now:
https://lore.kernel.org/linux-btrfs/f4f916352ddf3f80048567ec7d8cc64cb388dc09.1724493430.git.wqu@suse.com/T/#u

Thanks,
Qu

> ---
>   tests/btrfs/319     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/319.out |  2 +
>   2 files changed, 94 insertions(+)
>   create mode 100755 tests/btrfs/319
>   create mode 100644 tests/btrfs/319.out
> 
> diff --git a/tests/btrfs/319 b/tests/btrfs/319
> new file mode 100755
> index 00000000..b6aecb06
> --- /dev/null
> +++ b/tests/btrfs/319
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 319
> +#
> +# Make sure data csum lookup failure will not lead to double bio freeing
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }
> +
> +. ./common/rc
> +
> +_require_scratch
> +_fixed_by_kernel_commit d139ded8b9cd \
> +	"btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()"
> +
> +# The final fs on scratch device will have corrupted csum tree, which will
> +# never pass fsck.
> +_require_scratch_nocheck
> +_require_scratch_dev_pool 2
> +
> +# Use RAID0 for data to get bio splitted according to stripe boundary.
> +# This is required to trigger the bug.
> +_check_btrfs_raid_type raid0
> +
> +# This test goes 4K sectorsize and 4K nodesize, so that we easily create
> +# higher level of csum tree.
> +_require_btrfs_support_sectorsize 4096
> +
> +# The bug itself has a race window, run this many times to ensure triggering.
> +# On an x86_64 VM with KASAN enabled, it can be triggered before the 10th run.
> +runtime=32
> +
> +_scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>&1
> +# This test requires data checksum to trigger a corruption.
> +_scratch_mount -o datasum,datacow
> +
> +# For the smallest csum size CRC32C it's 4 bytes per 4K, create 32M data
> +# will need 32K data checksum, which is at least 8 leaves.
> +_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
> +sync
> +_scratch_unmount
> +
> +# Search for the last leaf of the csum tree, that will be the target to destroy.
> +$BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV >> $seqres.full
> +target_bytenr=$($BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
> +
> +if [ -z "$target_bytenr" ]; then
> +	_fail "unable to locate the last csum tree leave"
> +fi
> +
> +echo "bytenr of csum tree leave to corrupt: $target_bytenr" >> $seqres.full
> +
> +# Corrupt both copy of the target.
> +physical=$(_btrfs_get_physical "$target_bytenr" 1)
> +dev=$(_btrfs_get_device_path "$target_bytenr" 1)
> +
> +echo "physical bytenr: $physical" >> $seqres.full
> +echo "physical device: $dev" >> $seqres.full
> +
> +_pwrite_byte 0x00 "$physical" 4 "$dev" > /dev/null
> +
> +for (( i = 0; i < $runtime; i++ )); do
> +	echo "=== run $i/$runtime ===" >> $seqres.full
> +	_scratch_mount -o ro
> +	# Since the data is on RAID0, read bios will be split at the stripe
> +	# (64K sized) boundary. If csum lookup failed due to corrupted csum
> +	# tree, there is a race window that can lead to double bio freeing (triggering
> +	# KASAN at least).
> +	cat "$SCRATCH_MNT/foobar" &> /dev/null
> +	_scratch_unmount
> +
> +	# Manually check the dmesg for "BUG:", and do not call _check_dmesg()
> +	# since it will clear 'check_dmesg' file and skips the check.
> +	if _dmesg_since_test_start | grep -q "BUG:"; then
> +		_fail "Critical error(s) found in dmesg"
> +	fi
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
> new file mode 100644
> index 00000000..d40c929a
> --- /dev/null
> +++ b/tests/btrfs/319.out
> @@ -0,0 +1,2 @@
> +QA output created by 319
> +Silence is golden


Return-Path: <linux-btrfs+bounces-16477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE8EB392D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 07:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8510B4616B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 05:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154F264FBD;
	Thu, 28 Aug 2025 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K1o6p0Ps"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0B1865FA
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756358456; cv=none; b=rwk2waHWzRebMK7C7JUc0tDXHMbsjc/9H1vCMQXhT/+8msEXHbL+zTcnZIrPVspUUKWaJD2W2kLp/fPUQ1fmWfn06yG4jzTUIapXDnhf+gZeCybmTocJA532zdUzOcELrVSw9zKcoWBYz+mJ9OOW6hzBkxRa7FDsFQ1wTLq0KPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756358456; c=relaxed/simple;
	bh=fDoCpvDPZojQOzcp//d2WkCQSSobxULjBxNzT/b+hAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O7xTON4zYXfzs63HxPlfQxTY7ETxxZKzkxRwAoLzIz1MHi8Gz6oioykBaK9vBcH1Hln0HzNB1xPXV8XyHZK/C6oqi2WDCtGGQl2DjfTpAyZoJ/Ys4PCNy9tkD1nPz7tSiNWuQhOmF0TyBZHi/hdB50Hr8u/KOtCk68W9Fi4P9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K1o6p0Ps; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c7edd71bbfso360480f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756358452; x=1756963252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPgtIpQiUoc4IPKFT3WuUDUUCzhtS6hbLi26etSpiMM=;
        b=K1o6p0PsMZC66YP7xOfXQYAC9PSRODR8+052H8Lz8wwEb6Ni6dF7OIVPMb0bdT9aM/
         k0LdItVOD3vlN/mbxLx5IBS3DYry21FJuaYr6UvLqZYCgYjwGJX+B/+kZLDws6Q0mIRY
         QDRM8PFKR40qnm5NH9BDHrUDPP/oRdHEA0Nr8gb+hXDPALWHw/8kQ0OrMwDLMn1laaAc
         9zc2sNfBgb13Wp4oWOHG38bS0Vj6KmcJD/uthLszuJgvl2tmUTjLVaPjer53ICEpcP62
         zfEr1sFWSUjhYWAS5reeukmSIhSQyyGDnjXusWjfjcCLQ3NB5Fiuo5dw0s1EQaTNMYZ7
         lkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756358452; x=1756963252;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPgtIpQiUoc4IPKFT3WuUDUUCzhtS6hbLi26etSpiMM=;
        b=sTFWrGPR/INiLIzQhHwOzjJ+rIatqlrP9mxk+EDsi4s9viKKJ4w2wWe9zRIRTjRDZs
         ZLvLrXdFX/Z1F0si1d63rFIVzQYrMiXp/KxUF9A5WB7PCb9W5NBXleF/mZq3i9x07zZp
         gbmrQvR4z/jHGUgXMcRfUclTMrhHSsKhpA/VQR671/bSnt52M3nq5+gEG4r2gF6vR+7G
         Lc+GJ03Ko9BgtBrSBDH0n7kxiJRjllHf2L6BH9N2WQKAHpYu6si5jrkMR8Afc1AU1a63
         7it4Lw/pQgtmdEptZFB06lqIqXipHlzQN1U05/Sxj1+u7KhCJ5mCpSGK3CYgM7/2Zavn
         GAXA==
X-Gm-Message-State: AOJu0Yx8JE7YhPXD2/Y9k4TTy/wk9nC0zAY8dFIWbeXn/Ju1WpsksKtM
	ODZ4rEZH3VnCaObhs8t5RYXnQoxtlSZqmApAIMXm5/zJDGt4SyNFbQycHVxiY6Oe5tu9mrk78dS
	hJyUu
X-Gm-Gg: ASbGncvRw03ho/IQhlJ0mVMJq+HyzAK6tsl7bhrfpwL6ZjVElIQJjWn4MCgwvgK43yL
	sDaoTToJr9TcWPWv8OChSKIgE+hCSrijSWMAKq2GRk6C0kuw3vOSUPr5Dh5QyFCUxVNxCNw4oH9
	sInR9WXtwDNUFQ3TMkcA4BIEi+oaL3lEl6Sx/KydlozTAYCmE/75pWkq1CTerUa6yE2IdciQajo
	eM+NV2G600xo1/EwBFJuoB3nDvzOGq7VqqbRwFX0SZdoiMOOZQxzm79DwvpnKr3tzAGbdB95MIN
	MML16zf5YQpb4VjA5o1x5l2lLNMpM+1Lz+MOBa60/JJvAI11J+6YB7pMYFMYkOL2rbIIxMJQd56
	zrAXoL/1LjL9X/zDw/WuvVWFwwPlT3DsfhttavggPfzMBOTgrqS8=
X-Google-Smtp-Source: AGHT+IEQeuFbjgQ5ojyT7vRrMMK8D1lvuiBjc7JrpmJEc5CLwN9xxbLD39ys1tmcEp9IKtgjC/JQAA==
X-Received: by 2002:a05:6000:2907:b0:3c8:a4f6:c8e4 with SMTP id ffacd0b85a97d-3c8a4f6cb41mr9697104f8f.52.1756358451717;
        Wed, 27 Aug 2025 22:20:51 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248df4ba21dsm5681145ad.15.2025.08.27.22.20.49
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 22:20:51 -0700 (PDT)
Message-ID: <85049b56-6e62-438b-8087-c1a2bf18024f@suse.com>
Date: Thu, 28 Aug 2025 14:50:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: enhance primary super block writeback errors
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1756353444.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <cover.1756353444.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/28 13:46, Qu Wenruo 写道:
> Mark recently exposed a bug that btrfs can add zero sized devices into
> an fs.
> 
> Inspired by his fix, I also exposed a situation which is pretty
> concerning:
> 
>   # lsblk  /dev/loop0
>   NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
>   loop0   7:0    0  64K  0 loop
>   # mount /dev/test/scratch1  /mnt/btrfs/
>   # btrfs device add -f /dev/loop0 /mnt/btrfs/
>   Performing full device TRIM /dev/loop0 (64.00KiB) ...
>   # umount /mnt/btrfs
>   # mount /dev/test/scratch1 /mnt/btrfs
>   mount: /mnt/btrfs: fsconfig() failed: No such file or directory.
>         dmesg(1) may have more information after failed mount system call.
>   # dmesg -t | tail -n4
>   BTRFS info (device dm-3): using crc32c (crc32c-lib) checksum algorithm
>   BTRFS error (device dm-3): devid 2 uuid e449b62e-faca-4cbd-b8cb-bcfb5c549f0b is missing
>   BTRFS error (device dm-3): failed to read chunk tree: -2
>   BTRFS error (device dm-3): open_ctree failed: -2
> 
> That device is too small to even have the primary super block, thus
> btrfs just skips it, resulting the fs unable to find the new device in
> the next mount.
> (Thankfully this can be fixed by mounting degraded and remove the tiny
> device)
> 
> This exposed several problems related to the super block writeback
> behavior:
> 
> - We should always try to writeback the primary super block
>    If the device is too small, it shouldn't be added in the first place.
> 
>    And even if such device is added, we should hit an critical error
>    during the first transaction on that device.
> 
> - Primary super block write failure is ignored in write_dev_supers()
>    Unlike wait_dev_supers(), if we failed to submit the primary sb, but
>    succeeded submitting the backup ones, we still call it a aday.
> 
> - We treat super block writeback errors too loosely
>    Btrfs will not error out even if there is only one device finished the
>    super block.
> 
> Enhance the error handling by:
> 
> - Treat primary sb writeback error more seriously
>    In fact we don't care that much about backups, and wait_dev_supers()
>    is already doing that.
> 
>    So we don't need an atomic_t to track all sb writeback errors, but
>    only a single flag for the primary sb.
> 
> - Treat newly added device more seriously
>    If the super block write into the newly added device failed, it will
>    prevent the fs to be mounted, as btrfs can not find the device.
> 
>    So here we introduce a concept, critical device, that if sb writeback
>    failed for those devices, the transaction should be aborted.
> 
> - Treat sb writeback error as if the device is missing
>    And if the fs can not handle the missing device and maintain RW, we
>    should flip RO.

This makes btrfs more strict on dmerror related errors.

Previously we ignore those primary sb writes errors, thus it won't have 
long lasting effects.
But now we flips the fs RO, result btrfs/146 and btrfs/160 to fail, all 
due to the new RO behaviors.

Considering we're just being more strict, I'm not that concerned of 
those failures.
If we are determine to go this path, we can definitely enhance the test 
cases to handle those errors.

Thanks,
Qu

> 
> - Revert failed new device if btrfs_init_new_device() failed
>    This can be a problem of the new device itself.
>    We should remove the new device if the btrfs_commit_transaction() call
>    failed.
> 
> 
> All those enhancements lead to a pretty interesting error handling
> situation, where a too small device can be added to btrfs, but it will
> not commit, and the original fs can still be remounted again correctly:
> 
>   # lsblk  /dev/loop0
>   NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
>   loop0   7:0    0  64K  0 loop
>   # mount /dev/test/scratch1  /mnt/btrfs/
>   # btrfs device add -f /dev/loop0 /mnt/btrfs/
>   Performing full device TRIM /dev/loop0 (64.00KiB) ...
>   ERROR: error adding device '/dev/loop0': Input/output error
>   # umount /mnt/btrfs
>   # mount /dev/test/scratch1 /mnt/btrfs
>   ^^^ This will succeed, as the new device is not committed
> 
> Qu Wenruo (4):
>    btrfs: enhance primary super block write error detection
>    btrfs: return error if the primary super block write to a new device
>      failed
>    btrfs: treat super block write back error more seriously
>    btrfs: add extra error handling for btrfs_init_new_device()
> 
>   fs/btrfs/disk-io.c | 93 ++++++++++++++++++++++++++++++++++------------
>   fs/btrfs/volumes.c |  9 +++--
>   fs/btrfs/volumes.h |  8 +---
>   3 files changed, 78 insertions(+), 32 deletions(-)
> 



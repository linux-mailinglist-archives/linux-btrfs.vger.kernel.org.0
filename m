Return-Path: <linux-btrfs+bounces-15414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD0AFFB3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 09:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D871C83580
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90EB28983F;
	Thu, 10 Jul 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Puw8c6XD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C628B4FC
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133520; cv=none; b=moaCotBUqWvsmQ4QFNyczLaQJO3vwwB9Wcvwc8eMzhAUq2SJQWI1HuHzK9T9xbUu6Z06lwtrx8An/2i1uqrQI47Yn7+vHh5uky+tG65X9XBrQ/2nHvRrgCYbp+cDbqYopmmMVABgXe1ZiF9y9NhS+gwP6wDth/oQ9/m4AMZd4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133520; c=relaxed/simple;
	bh=sKP8WGFwnt8PNybjCSiR3tVeB6s6uGs8aRkiLmZLslI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pI7VU0+Zwk6wFCz22tz4/tkFhc48lhMMulSl8lHmVzFzFnBIwq+27MQ4Vgs6tISMUIo3ZNw37882I3yxk6GyB/oz/HcYA5DfamH75f7uTrAC+oXVkw65G9P5eqIk/215MQD6AU+CCPq6281uz3OE9jRGm/RMjy1LWJ6DFHABjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Puw8c6XD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1144641f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752133514; x=1752738314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s0xuEP6RnQUYyoxE180HmxyHoqxkk1OBG0CAimX02dI=;
        b=Puw8c6XDg1xABWZzjWvtpSAZDrE3H8tAkv1H2LlF/EdSl0G46xlxpHr4Tkk1M9gHbs
         TCWxEp5N3fFNmld1dl0heU3a0ul0nVV20j/9I0Z4Qg0LZHfCG/gvKRnLo1BWs2GRD1oB
         YMmyjvtNrSZDd55V7hsy82uzoXjk8NCmxx4XxCJ5Ch91hiefkFrX7dPowSk6qF24oWx0
         osRlNVbEIychSLABPRMrr8WS6Bl68lEh970UVLS3QaLvdNuFBMPMOpe/Pl1skS1HIEBc
         5rn4/XE8Xou6rWzF2RsxTFxHHveCd66qchB06Qjg3ZzSXY2w/75kwtHafJuvXfeuobfi
         lveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752133514; x=1752738314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0xuEP6RnQUYyoxE180HmxyHoqxkk1OBG0CAimX02dI=;
        b=r8sOaOF+v3CYV+v7CH62t+UCSvcigOnd3n7jZtgoiXpYM2SkyEEh17vAbFxidFzkFb
         4QzYpamLeAz/ouI00zRoQEctd5rqnJoOPTOOz2grf5fxjhQhQkbyzvGG/g2R943W70eW
         c4FxVJ/6sC/JkoTMaw1Ij9xfpSTKslsF6DLFtlmBorCc3Wm4W0eFGUwdrDtKHWGunvBY
         sOwphjW7soy7vBGzVXe45q3fUTtJmnK688OmgMRiWB8V0PBLRK5v0B+Z/lGAZ/HJXUSD
         F7+/akvZcTUN2h+a5AWqZl31EXwY1NPHB8Pp06pmMdPTqtOPTIetwpZj/10Zgnj1Y3S5
         m79A==
X-Forwarded-Encrypted: i=1; AJvYcCVA97Iz5J/s/Bzdc+MIptdQsBgh0UFWMZtqPO+e0rqq6JB3AVLlkUKdaB48VC71Rw116J1uBOd2GMO/iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhsVeFu1KWRaBO1JPnzUaduXdHqiUSJXlNd8ENydRX4eoLehY
	dy16WrK4yrsGDlun/aSztOntKE+vba2pfe+VYmA/K9Ju+ZR4atRQ3FQFZLUaIkJBQI4=
X-Gm-Gg: ASbGncsEd+KMWXPD0jOMzlTrCw3TFNRPQyF0v8yh9jTFlZrY+TpfuCmLBYkhaYREn5v
	ffUU3tEt+Amtp+E+PLwlbiCGg2ILAsyrfDfeubyuTp0lD7dp8xHUsm9S13h4ksB+aTeyxK/MfBZ
	NPNvPqsvVTS/yA5xmMkANEJI8UtLQVtfvI72lErDHsqN+9aD/TAnYFYhb5wL66JEjA4nn1Gyjqk
	+j2713BpRvaEGt0DbugARskMsFRW+n/Gl7UQUuYIonwMHCcY9xp/CeY4hZHYT3+IXKqWnU50bEU
	LUcnf0mGAfxA+QY1YwWf5QlZc10ls7vZaGk5tdnn5nvOOZsifD2EfDCQVzfS9gh8oDnbtbn2pPa
	JrmVtC/jL8rxFeQ==
X-Google-Smtp-Source: AGHT+IHg/eg/Had1qCBwqkdOMvK/gNTRnKVFN1TeHNe7o0bxVCC7sC1fv4TskQS8LbXsgayl2Ph6Uw==
X-Received: by 2002:a05:6000:1acf:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b5e7f0a33emr1850438f8f.5.1752133514221;
        Thu, 10 Jul 2025 00:45:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f46a67sm1202877b3a.110.2025.07.10.00.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 00:45:13 -0700 (PDT)
Message-ID: <34c3f756-9601-4b05-8c3f-50ead9e71f05@suse.com>
Date: Thu, 10 Jul 2025 17:15:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test overwriting file with mmap on a full
 filesystem
To: Zorro Lang <zlang@redhat.com>, fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/10 16:59, Zorro Lang 写道:
> On Wed, Jul 09, 2025 at 09:53:50AM +0100, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> Test that overwriting a file with mmap when the filesystem has no more
>> space available for data allocation works. The motivation here is to check
>> that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
>>
>> This currently fails with btrfs but it's fixed by a kernel patch that has
>> the subject:
>>
>>     btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>   tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/211.out |  6 +++++
>>   2 files changed, 64 insertions(+)
>>   create mode 100755 tests/generic/211
>>   create mode 100644 tests/generic/211.out
>>
>> diff --git a/tests/generic/211 b/tests/generic/211
>> new file mode 100755
>> index 00000000..c77508fe
>> --- /dev/null
>> +++ b/tests/generic/211
>> @@ -0,0 +1,58 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 211
>> +#
>> +# Test that overwriting a file with mmap when the filesystem has no more space
>> +# available for data allocation works. The motivation here is to check that
>> +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw mmap
>> +
>> +. ./common/filter
>> +
>> +_require_scratch
>> +
>> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
>> +
>> +# Use a 512M fs so that it's fast to fill it with data but not too small such
>> +# that on btrfs it results in a fs with mixed block groups - we want to have
>> +# dedicated block groups for data and metadata, so that after filling all the
>> +# data block groups we can do a NOCOW write with mmap (if we have enough free
>> +# metadata space available).
>> +fs_size=$(_small_fs_size_mb 512)
>> +_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
>> +	_fail "mkfs failed"
> 
> _scratch_mkfs_sized calls _notrun if it fails:
> 
>    _scratch_mkfs_sized()
>    {
>          _try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized failed with ($*)"
>    }
> 
> So you can let it _notrun:
> _scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1
> 
> or you'd like to _fail:
> 
> _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> 	 _fail "mkfs failed"
> 
>> +_scratch_mount
>> +
>> +touch $SCRATCH_MNT/foobar
>> +
>> +# Set the file to NOCOW mode on btrfs, which must be done while the file is
>> +# empty, otherwise it fails.
>> +if [ $FSTYP == "btrfs" ]; then
>> +	_require_chattr C
>> +	$CHATTR_PROG +C $SCRATCH_MNT/foobar
>> +fi
>> +
>> +# Add initial data to the file we will later overwrite with mmap.
>> +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
>> +
>> +# Now fill all the remaining space with data.
>> +blksz=$(_get_block_size $SCRATCH_MNT)
>> +dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1
> 
> As this's a generic test case, I'm wondering if the common/populate:_fill_fs()
> helps?

I believe that helper is a little overkilled, we don't want unnecessary 
files to take up our metadata space so it may cause false ENOSPC, at 
least for btrfs.

Just writing until ENOSPC should result the minimal amount of metadata 
space usage here.


Or do other filesystems have some extra data reservation behavior that 
requires such retry to fully exhaust the space?

Thanks,
Qu

> 
> Thanks,
> Zorro
> 
>> +
>> +# Overwrite the file with a mmap write. Should succeed.
>> +$XFS_IO_PROG -c "mmap -w 0 1M"        \
>> +	     -c "mwrite -S 0xcd 0 1M" \
>> +	     -c "munmap"              \
>> +	     $SCRATCH_MNT/foobar
>> +
>> +# Cycle mount and dump the file's content. We expect to see the new data.
>> +_scratch_cycle_mount
>> +_hexdump $SCRATCH_MNT/foobar
>> +
>> +# success, all done
>> +_exit 0
>> diff --git a/tests/generic/211.out b/tests/generic/211.out
>> new file mode 100644
>> index 00000000..71cdf0f8
>> --- /dev/null
>> +++ b/tests/generic/211.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 211
>> +wrote 1048576/1048576 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
>> +*
>> +100000
>> -- 
>> 2.47.2
>>
>>
> 
> 



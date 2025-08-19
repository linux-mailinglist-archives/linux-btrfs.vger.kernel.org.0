Return-Path: <linux-btrfs+bounces-16161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A576B2CF19
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D00B1C200AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 22:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342E353367;
	Tue, 19 Aug 2025 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GOJHHOgb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255535335D
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641358; cv=none; b=UB4DRL/bUQrg5eVVF6ybJ+YV9kP1MKd0BvDYa5aXCeRkA3aEfcIP+De3T9l7LHoRfZmH/k4N98fbHTaJ98+aTxyTqFrult0WHT/8v+d4uh/Ash/EMbiMOoczLb5xu0LkFwGZH954WgkVBsgq4rwITiYag9Tg6Olma8MG7tK+2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641358; c=relaxed/simple;
	bh=Mh7U1Ph4mesb6ZbW0KBPGaOxPXeWv9mno707B8frLKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWazbFnwPOyR+38mV6LzTswFE4M9yXSjBNkKUaAuXte+Ioky9R16R9wIk9TqNF3zNraswoJWXBjCiIFhInWE3neftNpruUVQE9tZU7SzodzEQRotwSBws3jjx7ltsu9wTiH9znghBps9TCbW4PphR9Y9HoWP8Yr3A9qA4MEdqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GOJHHOgb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a286135c8so1808315e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755641355; x=1756246155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JgxRh/c+b5nT/D/RFJsZCD6VQEXP67nFCY2sQvI8rdo=;
        b=GOJHHOgbAe/ibxhDVhQMVTAsTQfbjHnPM+VHCl0s8rFF0XIKz1ps9QYyl40WoiqfD9
         UPaXXYAHOPUcAxgHigb8/nrhjSfhle9nU0b5fJ9re3+IJIX05kWujEsx7jJqZ0HSPdmt
         Jy+sT1w2YTDwEOzqP2neEzcV6bWyuYt0ZGjM7G+6lcCVS7LNzVtQKmmr50y/8UsQ6NXI
         PuZm9sqladKZZqavsR3dVSrvLvKVYGp71K9am0JACxz8gxpBuKWWFZfF467Gbx5GT+zq
         tvkrehZ4WsLe/kjSUuBXxczLeltFX8q/uDaRKQox7l1t2YQkpC8wYn4IzpUs68i6UMCi
         60QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755641355; x=1756246155;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgxRh/c+b5nT/D/RFJsZCD6VQEXP67nFCY2sQvI8rdo=;
        b=V1xJWs9Gw4Onaq9bpCjqKZ3wC/9GIktXSWN+efB4uhW6gz24S6oqP87jMSK1Xh7Git
         Nx5Yvj6LF0ceyUKpzg50Z59hLES+Bfx0ERA355YZYv1hMBJlbTMM6ukNSLasoAcVa3Q9
         XFXMGLt4oYUd453isKznwSsBZ4De2ojRF5uTi2iQzuu9lj4D3PnCJRG+cZhcpLP37XoM
         avb8A8gP/+FXhEJuMo8KNFYpyKdggCdZnyVU4prmv8I0W+/EDGtn3E7+y6FjIQJLip5Q
         INsLKcZNTJCeK5Vkqc9jjWMZV0efPZEpEhP9o4sydhKYXu7yEPJEfn2fhhlshhHhXg9i
         Newg==
X-Gm-Message-State: AOJu0YwoBHamB0c+hUbIaL5PZ5RdMxP5lQ3wRtAPq+b12lVwh47dbn+p
	GA/5VMv2FPfm8K8H3q6j5FRTblGrUdKMAR9kv+w66GE/JBvlLkzQ3LX89XG3JqWv8iE=
X-Gm-Gg: ASbGnctKBPO0WObaiqfAlI/wLtm5kX+p1zoYyN93miBHZ4xHL9JBgOce1Tp1qRZP6CN
	CrkweQX1tqtR5A7g95dS5j4mrFnD0eBUCm/xpVndss6fRRvwTH1TRS1BWBVieXtItJPCjXJfCyJ
	iugkenCdWTcs1ScSw33byhHwOik5lr9ELfb92vfV1gFpVaZ9vDms4SGam0dB+KYUXSWnCO0Zr2Z
	r7Qll+7/ic1Brjg8tC0KGOqVf5o8fIEm6HTXSIAf+1Ie5T1yButgLu++AJ7DdA6U33v6ImQseuK
	Id0YEQ0ZGIv0HZLk1xerYc8UcTY34jM3x7Wqw//Uso7F8lU+3CgsZfPb0zuVFcY/z9xKK8wxivW
	8LVHgfxDJptYtYcE8kOks7nmrCCkmVY9V2j8/9C6TCq8+PyNHyhI=
X-Google-Smtp-Source: AGHT+IEmN3nKhF8Mrk7M5E/Z81JuZBtZeQPE3AfWildlCtiss6YpbOfwGCJDHLSQMY4sAjipouHo0w==
X-Received: by 2002:a5d:5f4c:0:b0:3b7:8ed8:1c80 with SMTP id ffacd0b85a97d-3c12a70e981mr3171593f8f.3.1755641354568;
        Tue, 19 Aug 2025 15:09:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f6ea2sm3441602b3a.62.2025.08.19.15.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 15:09:14 -0700 (PDT)
Message-ID: <0a10a9b0-a55c-4607-be0b-7f7f01c2d729@suse.com>
Date: Wed, 20 Aug 2025 07:39:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] generic/274: Make the pwrite block sizes and
 offsets to 64k
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <49bd135f95d50fd4b8db41593551b1958ed380a7.1755604735.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <49bd135f95d50fd4b8db41593551b1958ed380a7.1755604735.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
> This test was written with 4k block size in mind and it fails with
> 64k block size when tested with btrfs.
> The test first does pre-allocation, then fills up the
> filesystem. After that it tries to fragment and fill holes at offsets
> of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
> 64k block size, the test tries to fragment and fill holes within
> 1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
> and the write fails. The reason for this failure is that during
> overwrite, there is no more space available for COW.
> Fix this by changing the pwrite block size and offsets to 64k
> so that the test never tries to punch holes or overwrite within 1 fsblock
> and the test becomes compatible with all block sizes.
> 
> For non-COW filesystems/files, this test should work even if the
> underlying filesytem block size > 64k.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Overall looks good to me.

Although still a minor concern inlined below.

[...]>
>   # Fill the rest of the fs completely
>   # Note, this will show ENOSPC errors in $seqres.full, that's ok.
>   echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
>   dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M >>$seqres.full 2>&1
> -echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
> -dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=4K >>$seqres.full 2>&1
> +echo "Fill fs with 64K IOs; ENOSPC expected" >> $seqres.full
> +dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=64K >>$seqres.full 2>&1

Not sure if using 64K block size to fill the fs is the correct way.

For example on a fs with 4K block size, but at end of filling there are 
only 60K left.

This will fail the filling as we can not reserve 64K data space anymore.
But it's not 100% filling the data space either.
This may not matter that much as in the preallocated filling stage, 
every operation is still in 64K block size though.

I'd prefer to keep the old 4K as block size (as it's the minimal support 
one), or use the fs block size for filling.
This will ensure we really use up all the data space.

Thanks,
Qu

>   _scratch_sync
>   # Last effort, use O_SYNC
> -echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
> -dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K oflag=sync >>$seqres.full 2>&1
> +echo "Fill fs with 64K DIOs; ENOSPC expected" >> $seqres.full
> +dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=64K oflag=sync >>$seqres.full 2>&1
>   # Save space usage info
>   echo "Post-fill space:" >> $seqres.full
>   df $SCRATCH_MNT >>$seqres.full 2>&1
> @@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>   for i in `seq 1 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
>   done
>   _scratch_sync
> @@ -71,7 +71,7 @@ echo >> $seqres.full
>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>   for i in `seq 2 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
>   done
>   _scratch_sync



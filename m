Return-Path: <linux-btrfs+bounces-16325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FBB3362E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E0016C9FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F5927605A;
	Mon, 25 Aug 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha1VPG66"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B023CEF9;
	Mon, 25 Aug 2025 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102068; cv=none; b=VohK2K5sRPZmzNYod5IfcwidlUPcwPIyxOGbd4Rr8OaH5alMXJ7U0Pxo3CDDLu/WL34ZQ8kr63vHBT1PwHlI+pB6vFtu+mmjAhWEslKIvPG5yX4j6Hx5WiOUsB+exxBlPyRI4ndufEcnTElp79fbs42xe0Wn/0DUIHHnJdfrLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102068; c=relaxed/simple;
	bh=ys91BFxes/SDENiYN/nDoMYCRMs7Wyi/BBGfv25k/UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvX2ExFNsb9mC/rlvBxukHjKCPS+Qqa0fpdkOljRcW417KM18sAuJ+sDnj5ucO2fkSjP3PiYP6eT8+FWGj1rrNAUBLFsG4vbMXVAKSmnv0EO5yNU6uq7JolgsyeVrJ+HFt/7qmfP8+U6HY8WKJldVeebEA/S0sN5buT13P2o2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha1VPG66; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-770530175b2so768570b3a.3;
        Sun, 24 Aug 2025 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756102065; x=1756706865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQRVuSjy/8bWfhWf6RnM6k11wnfT/gUG2h4WHbqj0zE=;
        b=Ha1VPG66Jgb0pHbm/P1CQLsnLXFmREIYn37oqtHSZf0ThlDdUjo3a4dUuSIaATKhWv
         Vgx8JkWI3MrhVn0KEQ8NIUb9JEKBHPNjlV+Et6cNjzBn0blKDlGGMwaZ/nYue3Vj0rWs
         7KF1B63IUW4tY1quWeBx2f+LJbAVGUffL9D7BBb32vKGK+FNYCJ45kGySfe29SvF2hGz
         bZt1qRCqrTxkRWax2Rk5s6VkRczwmmWTJxuup/9i37DqtHcAVmTaKvGijLOFuPqg3dNT
         NtcQUNavjLnk5tyjmKgGebUjqCXa/MP/vL5v5dKtwQNdflE8NVd1yn5Dq1nv51j/UKy1
         cfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756102065; x=1756706865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQRVuSjy/8bWfhWf6RnM6k11wnfT/gUG2h4WHbqj0zE=;
        b=RyMQ+4RvBqhljd1xRh/qRhX0I7h7DW2gjcwu7kYK8LEH5zLIndFRQ+t+B4zo2TIlpT
         wW3xWEV/J3PJSc70NGPraKrnvJoSXyl5kOK8znPjyJo/99xLl3SpFnmzHEuHUayVV3E1
         SQhzrw3EfOEEAw5NyZ6pFq16sJ+915AZ+rS6xXM51ng08CRLmTEA/fLIGbvbZFhXnIUj
         SeSpxHHqf69KuJaC4MqL6N+Vo2Nh1nJ2tOnHMxHkJE0OO4rPvBoKoei7x/c1L2irRggM
         SucCXEqlFRf4lbO6Tmiriz4Dl39PRVoz3k/J4oWO23RJ4cS1hWQWoUVHI6oZD1RsUa5A
         6plw==
X-Forwarded-Encrypted: i=1; AJvYcCX5qy0tytTWgQYC/g0LGtpZSJjG8mKlITaKSI8FcRXf3cDkHxb0lKaM+EfsZu/EPacN1HWaGGVY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmu5m54T7V4/rCYf8FLODyVKBgJDNC7zpPaJkkD6KyTg+2pVy2
	Ri9DBdCdJ8p6mTqtbfaD924fHU0Gr7qhkLHPsG5XOlPunI99gyYcXMS7
X-Gm-Gg: ASbGncs9Psd4E53J3YCSV8sjKFERIrdR1E0ZRVEMbmQTH7NMp8IiiHazN/K1LxFp3Nx
	5RnSlXtBw7w8XPCl5XcTleopr1DWW4P7bklICn85PCrXZ2aEV0pkrVJndYTTfzDiwpBjvC0NO5Q
	6oIImiwdQFPW1iZ/XEbGLvTrlK0xc9VeFGGQP8+NRpZ0/CYPbxwPQ9+UX5xy8Jpa1/Yiz584tUS
	wghgMlmhaiR1DZZqmH/1DqmMXi4ENUuR8Alco4ep3UBhRfssbTxF/4GY6Xtr7Akmilz4KQvIeHo
	BoY9Ix2g/I9kfyjESz2Oxsi4H5z7kGZtTkyxc/x76Q5cA0k40FAPP7BDD6IgphxMi8iXJaGaiA8
	BtwdBoGDKeYyqaAl2aINs8rnsRlhTDi3e
X-Google-Smtp-Source: AGHT+IEHWSGuF8cdtvATpHyTKRaqDj0exA3FwAY7Xlvh83Yxur0ud2tmDZ3xciDORYR32VfEo2QcIw==
X-Received: by 2002:a05:6a00:218a:b0:76e:987b:2e3 with SMTP id d2e1a72fcca58-7702fad4905mr13738699b3a.28.1756102065349;
        Sun, 24 Aug 2025 23:07:45 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704001eb82sm6296593b3a.47.2025.08.24.23.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 23:07:44 -0700 (PDT)
Message-ID: <5daa9269-ad7a-4f6b-ad75-432fa5271ecc@gmail.com>
Date: Mon, 25 Aug 2025 11:37:40 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] generic/274: Make the pwrite block sizes and
 offsets to 64k
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <1110f20bb5d26b4bef5596a00d69c3459709ab65.1755677274.git.nirjhar.roy.lists@gmail.com>
 <ca7656e2-0b8b-42e4-8dee-c2da44cc0f11@gmail.com>
 <36395df3-bc41-44c0-861d-0f7f8c47a46d@gmx.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <36395df3-bc41-44c0-861d-0f7f8c47a46d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/25/25 10:14, Qu Wenruo wrote:
>
>
> 在 2025/8/25 14:04, Nirjhar Roy (IBM) 写道:
>>
>> On 8/20/25 13:45, Nirjhar Roy (IBM) wrote:
>>> This test was written with 4k block size in mind and it fails with
>>> 64k block size when tested with btrfs.
>>> The test first does pre-allocation, then fills up the
>>> filesystem. After that it tries to fragment and fill holes at offsets
>>> of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
>>> 64k block size, the test tries to fragment and fill holes within
>>> 1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
>>> and the write fails. The reason for this failure is that during
>>> overwrite, there is no more space available for COW.
>>> Fix this by changing the pwrite block size and offsets to 64k
>>> so that the test never tries to punch holes or overwrite within 1 
>>> fsblock
>>> and the test becomes compatible with all block sizes.
>>>
>>> For non-COW filesystems/files, this test should work even if the
>>> underlying filesytem block size > 64k.
>>
>> Hi Qu,
>>
>> Do you have any other feedback for this? I have reverted the block 
>> size to 4k during fs filling as suggested in [1]
>
> With that changed I'm totally fine. Feel free to add my tag:
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks. Added the RBs, fixed some typos and sent the final [v4].


[v4] 
https://lore.kernel.org/all/cover.1756101620.git.nirjhar.roy.lists@gmail.com/

--NR

>
> Thanks,
> Qu
>>
>> [1] https://lore.kernel.org/all/0a10a9b0-a55c-4607- 
>> be0b-7f7f01c2d729@suse.com/
>>
>> --NR
>>
>>>
>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>> ---
>>>   tests/generic/274 | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/generic/274 b/tests/generic/274
>>> index 916c7173..f6c7884e 100755
>>> --- a/tests/generic/274
>>> +++ b/tests/generic/274
>>> @@ -40,8 +40,8 @@ _scratch_unmount 2>/dev/null
>>>   _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
>>>   _scratch_mount
>>> -# Create a 4k file and Allocate 4M past EOF on that file
>>> -$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/ 
>>> test \
>>> +# Create a 64k file and Allocate 64M past EOF on that file
>>> +$XFS_IO_PROG -f -c "pwrite 0 64k" -c "falloc -k 64k 64m" 
>>> $SCRATCH_MNT/test \
>>>       >>$seqres.full 2>&1 || _fail "failed to create test file"
>>>   # Fill the rest of the fs completely
>>> @@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
>>>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>>>   for i in `seq 1 2 1023`; do
>>>       echo -n "$i " >> $seqres.full
>>> -    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 
>>> conv=notrunc \
>>> +    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 
>>> conv=notrunc \
>>>           >>$seqres.full 2>/dev/null || _fail "failed to write to 
>>> test file"
>>>   done
>>>   _scratch_sync
>>> @@ -71,7 +71,7 @@ echo >> $seqres.full
>>>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>>>   for i in `seq 2 2 1023`; do
>>>       echo -n "$i " >> $seqres.full
>>> -    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 
>>> conv=notrunc \
>>> +    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 
>>> conv=notrunc \
>>>           >>$seqres.full 2>/dev/null || _fail "failed to fill test 
>>> file"
>>>   done
>>>   _scratch_sync
>>
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore



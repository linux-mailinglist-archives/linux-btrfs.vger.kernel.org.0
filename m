Return-Path: <linux-btrfs+bounces-11952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF01A4A5D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D793BB520
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 22:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5061E32A2;
	Fri, 28 Feb 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ClMBrxRP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D71E1A2B
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781458; cv=none; b=fx7byE3le8PkTTzjyxecoLDR7cjXPPdWxEm236+4MWSkHl+BwcEBY75QY1LP1oDM4TMiXHnGsVMuSSFj6BarrXtElacPsGtdbS3Neh908LUX4ebY7tgLwUKQR0OJwUlH9xAkl1PlSwV7Xzu919lD3Z6nyeWci9OQvmEDgQ7dLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781458; c=relaxed/simple;
	bh=fFZXPfqUX3kBWUImn0tNyxbX8VNcm1P+nnp5MPAbEiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR5AnIk2aeJVpxTIAxuYcmALo67gteQRDyhJOujv0vN1nDoaafIK08EYZwf9jZFcefzWVqqpv6ZjoF0gMUdjrmyE8FheVMdbLjMhri5DZ6t4z+2K7isCaeA2vQw3mGkxAZoqBpTvkTo8l1sXFuiS22OZbkJwVMInyk3yqU9BvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ClMBrxRP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so4058303a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740781454; x=1741386254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6m8U0RGUmKIb3/Mua6UbU2JrAq7mpmKsDsjf0WjWdBo=;
        b=ClMBrxRPWZwumuEL1dFbt97QZfiIjKVSngLV1wFMiKWhJUXLiiA1d3DKs6YF3LqGwA
         Q+E7h3QPsB7v6OxLnZHbsaM0U8ASPVHL2B1wRY9B3dGP/aRDO9V0F4CSAI/xc7vBEqim
         BiT7X878qYod0xOmyNOiE++YvkM3/xdx0Dd1xLSsE9f2F/a2c9D++57wzASIA3/yvKNP
         r6pYoz6YoJCY/KowlSclR0C1LUDHDQjs56sgZ96LDnoxcA3hVy2XUi2M3khIQKWM0sB/
         tZ0LvHK1sGUmVAJ4NO7D3z+P2rpXSuShU5g2d2nIO9IkiAgi4OABD1rLpNdehUni/JkE
         WVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781454; x=1741386254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m8U0RGUmKIb3/Mua6UbU2JrAq7mpmKsDsjf0WjWdBo=;
        b=tFRZdgvCDpBkon1+O/NA8qNHZhCknX5H5oMgh2+VaxTdKFiHtY0SeSIStyYWduMFwm
         eLl7PVqG0GtYodBCTWldG7aI3deKbsROQGQwATJD4HdWKYFzg/wb1lEn01oFyh5a/ep/
         JgQFQ4N5J2OJy6Vgt2bcRS42hINnuDpbDUwauUuH750T2JFzYgDU9aKfY0w8q36qhHLq
         nziftlXPTlR5DVszVB0Hv0x9K1OCeOsQj2vTHLwVFFs+Ss0k/yxHFxCn/uB/UxBSlDST
         Kx73qrNVgP+u8ryjpscQc5zLnccxiqIwyFAA3s0PR8rJopH6/5u+xMCNiaLl6sYuKYRM
         3n0A==
X-Forwarded-Encrypted: i=1; AJvYcCUzl/78mZ6bPBGGhiJjVUXRiZwq9wnV82wXV5V09Jl9q6YWL3QEVlI9Ct6Mg1k1kV9qG1Mhh3d7fXtdYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyca0BWuErieJfig9YMdEj3edH7T1uUag32nqDKMIn7NwFxqUxe
	QYLDKI9CLTfn7Q27e5TaCHRS+08mB37BnL+EyFUnPbl3IsNqDz+QoOiV0fNZmz8=
X-Gm-Gg: ASbGnctEdI0lMUzZUujR6wJH3N038au+KafNVxP7xGxltQi7Qili5wVSJHqkz3O9IjN
	bQ+joCrkRXrlpRmzFGKLL5cHBmPXhZJZiPuQNNvNwo3U5MkH7QaE3qYGBYGy9CppTf8UyeVGlCh
	alDrpHOKRy2NCqBI+78CvE5NKIhUrhT1CzqaL7n5i7gIhDbHN889ucceYFaN/5wAm2AqlrH1hex
	HEN5GtwzIwaXxGYK7xeihAcarAJiEdRVPxYrVb8NahrOtZvZu+sgc7VAbjMiK415xPW+GSNY0mq
	pTyeCvN30WOCh0+9ATdb3kdUQJq3OA7UH6Evl+YwLZ/TnX8hkL4pvw==
X-Google-Smtp-Source: AGHT+IHis88+zLPGmYpGALMH0GhvOb9/UrmYEpnTfibMj1Ww3J534qX2HCCGpdVJ5lm9HLFrsBZ2MA==
X-Received: by 2002:a17:907:2d8a:b0:aab:9430:40e9 with SMTP id a640c23a62f3a-abf2659d531mr528610566b.32.1740781450946;
        Fri, 28 Feb 2025 14:24:10 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af16882d7d1sm866447a12.77.2025.02.28.14.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:24:10 -0800 (PST)
Message-ID: <5afb8ef2-dee9-45eb-adfb-9eb242341076@suse.com>
Date: Sat, 1 Mar 2025 08:54:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/080: fix sporadic failures starting with kernel
 6.13
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>, Glass Su <glass.su@suse.com>
References: <d48dd538e99048e73973c6b32a75a6ff340e8c47.1740759907.git.fdmanana@suse.com>
 <8cdc4be8-f1ad-4baa-beab-c22b0ca0832c@gmx.com>
 <CAL3q7H5gEcxq8DV8m6WxKnPOQuTSesBJVA_eaFAG2Ua6e5MBUg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5gEcxq8DV8m6WxKnPOQuTSesBJVA_eaFAG2Ua6e5MBUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/1 08:16, Filipe Manana 写道:
> On Fri, Feb 28, 2025 at 9:16 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2025/3/1 02:57, fdmanana@kernel.org 写道:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Since kernel 6.13, namely since commit c87c299776e4 ("btrfs: make buffered
>>> write to copy one page a time"), the test can sporadically fail with an
>>> unexpected digests for files in snapshots. This is because after that
>>> commit the pages for a buffered write are prepared and dirtied one by one,
>>> and no longer in batches up to 512 pages (on x86_64)
>>
>> Minor nitpicks, the original limit of pages is 8:
>>
>>          nrptrs = max(nrptrs, 8);
>>          pages = kmalloc_array(nrptrs, sizeof(struct page *),
>>                                 GFP_KERNEL);
> 
> No, it can be more than 8, much more. You're missing previous code
> there, as nrptrs could be greater than 8 before the max expression:
> 
> nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE), PAGE_SIZE /
> (sizeof(struct page *)));
> nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
> nrptrs = max(nrptrs, 8);
> pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
> 
> For example, for a 2M write, the first assignment to nrptrs results in 512.

My bad, it's max() not min(), thus it's indeed way larger.

And that commit indeed caused the huge behavior change ignoring the 
buffered write block size.

Thanks,
Qu

> 
> 
>>
>> I'm not sure if it's a coincident or not, but the first 32K writes
>> matches the pages limit perfectly (for x86_64).
>>
>> Meanwhile the second 32770 write is possible to be split even with the
>> older code, but it should be super rare to hit.
>>
>>> , so a snapshot that
>>> is created in the middle of a buffered write can result in a version of
>>> the file where only a part of a buffered write got caught, for example if
>>> a snapshot is created while doing the 32K write for file range [0, 32K),
>>> we can end up a file in the snapshot where only the first 8K (2 pages) of
>>> the write are visible, since the remaining 24K were not yet processed by
>>> the write task. Before that kernel commit, this didn't happen since we
>>> processed all the pages in a single batch and while holding the whole
>>> range locked in the inode's io tree.
>>
>> This means no matter the buffered io buffer size, it's the filesystems'
>> behavior determining if such a buffered write will be split.
>>
>> Maybe it's not that a huge deal, as the original behavior will also
>> break the buffered io block size, just with a larger value (8 pages
>> other than 1).
>>
>>>
>>> This is easy to observe by adding an "od -A d -t x1" call to the test
>>> before the _fail statement when we get an unexpected file digest:
>>>
>>>     $ ./check btrfs/080
>>>     FSTYP         -- btrfs
>>>     PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
>>>     MKFS_OPTIONS  -- /dev/sdc
>>>     MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>>>
>>>     btrfs/080 32s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad)
>>>         --- tests/btrfs/080.out        2020-06-10 19:29:03.814519074 +0100
>>>         +++ /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad 2025-02-27 17:12:08.410696958 +0000
>>>         @@ -1,2 +1,6 @@
>>>          QA output created by 080
>>>         -Silence is golden
>>>         +0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>         +*
>>>         +0008192
>>>         +Unexpected digest for file /home/fdmanana/btrfs-tests/scratch_1/17_11_56_146646257_snap/foobar_50
>>>         +(see /home/fdmanana/git/hub/xfstests/results//btrfs/080.full for details)
>>>         ...
>>>         (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/080.out /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad'  to see the entire diff)
>>>     Ran: btrfs/080
>>>     Failures: btrfs/080
>>>     Failed 1 of 1 tests
>>>
>>> The files are created like this while snapshots are created in parallel:
>>>
>>>       run_check $XFS_IO_PROG -f \
>>>           -c "pwrite -S 0xaa -b 32K 0 32K" \
>>>           -c "fsync" \
>>>           -c "pwrite -S 0xbb -b 32770 16K 32770" \
>>>           -c "truncate 90123" \
>>>           $SCRATCH_MNT/$name
>>>
>>> So with the kernel behaviour before 6.13 we expected the snapshot to
>>> contain any of the following versions of the file:
>>>
>>> 1) Empty file;
>>>
>>> 2) 32K file reflecting only the first buffered write;
>>>
>>> 3) A file with a size of 49154 bytes reflecting both buffered writes;
>>>
>>> 4) A file with a size of 90123 bytes, reflecting the truncate operation
>>>      and both buffered writes.
>>>
>>> So now the test can fail since kernel 6.13 due to snapshots catching
>>> partial writes.
>>>
>>> However the goal of the test when I wrote it was to verify that if the
>>> snapshot version of a file gets the truncated size, then the buffered
>>> writes are visible in the file, since they happened before the truncate
>>> operation - that is, we can't get a file with a size of 90123 bytes that
>>> doesn't have the range [0, 16K) full of bytes with a value of 0xaa and
>>> the range [16K, 49154) full of bytes with the 0xbb value.
>>>
>>> So update the test to the new kernel behaviour by verifying only that if
>>> the file has the size we truncated to, then it has all the data we wrote
>>> previously with the buffered writes.
>>>
>>> Reported-by: Glass Su <glass.su@suse.com>
>>> Link: https://lore.kernel.org/linux-btrfs/30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com/
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks for the detailed analyze and the fix.
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    tests/btrfs/080 | 42 +++++++++++++++++++++++-------------------
>>>    1 file changed, 23 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/tests/btrfs/080 b/tests/btrfs/080
>>> index ea9d09b0..aa97d3f6 100755
>>> --- a/tests/btrfs/080
>>> +++ b/tests/btrfs/080
>>> @@ -32,6 +32,8 @@ _cleanup()
>>>
>>>    _require_scratch_nocheck
>>>
>>> +truncate_offset=90123
>>> +
>>>    create_snapshot()
>>>    {
>>>        local ts=`date +'%H_%M_%S_%N'`
>>> @@ -48,7 +50,7 @@ create_file()
>>>                -c "pwrite -S 0xaa -b 32K 0 32K" \
>>>                -c "fsync" \
>>>                -c "pwrite -S 0xbb -b 32770 16K 32770" \
>>> -             -c "truncate 90123" \
>>> +             -c "truncate $truncate_offset" \
>>>                $SCRATCH_MNT/$name
>>>    }
>>>
>>> @@ -81,6 +83,12 @@ _scratch_mkfs "$mkfs_options" >>$seqres.full 2>&1
>>>
>>>    _scratch_mount
>>>
>>> +# Create a file while no snapshotting is in progress so that we get the expected
>>> +# digest for every file in a snapshot that caught the truncate operation (which
>>> +# sets the file's size to $truncate_offset).
>>> +create_file "gold_file"
>>> +expected_digest=`_md5_checksum "$SCRATCH_MNT/gold_file"`
>>> +
>>>    # Run some background load in order to make the issue easier to trigger.
>>>    # Specially needed when testing with non-debug kernels and there isn't
>>>    # any other significant load on the test machine other than this test.
>>> @@ -103,24 +111,20 @@ for ((i = 0; i < $num_procs; i++)); do
>>>    done
>>>
>>>    for f in $(find $SCRATCH_MNT -type f -name 'foobar_*'); do
>>> -     digest=`md5sum $f | cut -d ' ' -f 1`
>>> -     case $digest in
>>> -     "d41d8cd98f00b204e9800998ecf8427e")
>>> -             # ok, empty file
>>> -             ;;
>>> -     "c28418534a020122aca59fd3ff9581b5")
>>> -             # ok, only first write captured
>>> -             ;;
>>> -     "cd0032da89254cdc498fda396e6a9b54")
>>> -             # ok, only 2 first writes captured
>>> -             ;;
>>> -     "a1963f914baf4d2579d643425f4e54bc")
>>> -             # ok, the 2 writes and the truncate were captured
>>> -             ;;
>>> -     *)
>>> -             # not ok, truncate captured but not one or both writes
>>> -             _fail "Unexpected digest for file $f"
>>> -     esac
>>> +     file_size=$(stat -c%s "$f")
>>> +     # We want to verify that if the file has the size set by the truncate
>>> +     # operation, then both delalloc writes were flushed, and every version
>>> +     # of the file in each snapshot has its range [0, 16K) full of bytes with
>>> +     # a value of 0xaa and the range [16K, 49154) is full of bytes with a
>>> +     # value of 0xbb.
>>> +     if [ "$file_size" -eq "$truncate_offset" ]; then
>>> +             digest=`_md5_checksum "$f"`
>>> +             if [ "$digest" != "$expected_digest" ]; then
>>> +                     echo -e "Unexpected content for file $f:\n"
>>> +                     _hexdump "$f"
>>> +                     _fail "Bad file content"
>>> +             fi
>>> +     fi
>>>    done
>>>
>>>    # Check the filesystem for inconsistencies.
>>
>>
> 



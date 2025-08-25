Return-Path: <linux-btrfs+bounces-16352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2533B34EF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 00:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979A8482AD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4207121D018;
	Mon, 25 Aug 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G18y48eb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384DE1D5CC9
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160590; cv=none; b=rAC7THdfQGUQwoVAeEaWFZN95unXKtaf2ZXMiyZk1MDZveseB2kfTqItq4bFfOFADsP/y+9c0YnLSgH8qO5HPvS7SqEkepP5jwHfrcJ8ufjmCBG20XK2+PbgHNvkIB9IRolfRO4gWSSFy5HnxD7nmGVXfm4RTCLuHqql5vQjFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160590; c=relaxed/simple;
	bh=FjphrcKmWs+qFQgLjiUYFc378Y0zknHxdOawalo9hZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ig8ydAIxlQAmArMjHMlSGeSZfi82L+n6DbQfCCW2i5q8mWti/oO6offZXgfn2vhGgsOpmd4ydJRWEo7LFpL/pkTmeeAFx1Xt5cudJEvhwhTsw8k1LJiVJqWHswxKIbUhH7JnzIkxoWBu+zOcHRUDBS7c+WJKKX4FREc7C0m75j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G18y48eb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c79f0a606eso1320329f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756160581; x=1756765381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JV1qt9VRKtilTGxy+NFNrG8/QnPmgFh9/d4Dp0dAEp8=;
        b=G18y48ebUbVZVT8ob/rHSsYZ4fi+Cd83Nv3SGkQMuDAHVvQEpZGrq+YW3UEqawQi17
         UYi4pP4L82tDp60Ooj1yut3qSNc8XX1orCAkfQWC2vHWkGjJ4mUaDoNWfl7dyP13li/L
         K7Fps7qeZe3Blyu5EwOKfv+vRC7JyJgp4sAqLsr5UDxw0/C6vD/ggjwH8nq1Km2ZHNiU
         COvOdvV4UAElLWk5NRgRaSwBimTVlo4nsWDm+jWxY9WbOJg+aPdMZS0nxXJGo4JPh6Ht
         UXI5g++O70+dJDKzessiHoUXkt3q1/xLORjT9DyLLPZOPp+wZd5FiPap0c+novPstwno
         4BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756160581; x=1756765381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV1qt9VRKtilTGxy+NFNrG8/QnPmgFh9/d4Dp0dAEp8=;
        b=UWyTK7FWXnQLuWELYdugtYL26XJJLL+tmabvIaE9h2SGLeh2nnTn+eq+0hgF63YtPA
         06wTHkGuJrLak7gTVsISVQORz0Ic06bNIMFSNFvp74Ev9F0M567X9qTVVkNb98z+xaCy
         le42RztxyZQl6B6WwBGsS+8yqumpsu+n6yy8rsiM+1ojuzKLcUksAb5JmYAcKGV8TA8Y
         1T8Rlsa9VgAS9q6x/gDSQzo7bVL0RUjQnLAnqoHGIK9C08N7bwcX0TjW9Hc9SCGgRwNB
         mkdra0uGmnIErPlMquI5UKjwoWBxiwkIXCe1YcfV7a+W531hn1gtUBxkJOFe3Xc1RHgA
         J8eQ==
X-Gm-Message-State: AOJu0Yzr6Fei1bM8fLnNIVPklPN5hye1tvSSXNPGa5DgNE3F2k9siWUv
	KHGcOATnMYJDjR7OOhKWZpRXr8JMe/1lL+Vvm6prk9iPCyR2CckXGSAPcZpKyWfK7Yo=
X-Gm-Gg: ASbGnctTPCH3XGN3SlpSSSb11lpHivCoRQinso8DNroeWhk0rQpCwlR/VE8WpglPEn2
	J6yDlepILYUqTJie8/7HpDze5jPddzjTEXZSxi9jBQ7lNocrI7jcwqtANfFh/UKhqkdKiqHOjdQ
	SrbtA/vumxButwIAVScKIc4RT4tZiBtvvYzykhUt/udmLy0K9Ufs2GoUo9UWXoQIeEAWUZQSSYq
	NQ/fAFaSNJOqXPX7H5nogX1RE1PspZtI9+cV23NK3ktA8R8wm65G7vdJuYcEQiDqAe6F6pBmM3J
	/mZzjapmZwnr1fOFz+GRm0XVfLTJdXgsmEvl7F8FpFpuXs2L1Svo905AUjS/YZDn+T9mMfixxlt
	UOn7WzP1UehcTpfUsk1OJga1MUareSbHHvihTNUiY6W7RFlvSig98hbYcKuDSNQ==
X-Google-Smtp-Source: AGHT+IEKvYkxowtvnH8uiA3iF0PccOjIb2NXnOf8g8cHv+1S2zJgM1ppTiy3hTEu1derTQSYdScJTg==
X-Received: by 2002:a05:6000:430a:b0:3c8:2667:4e3f with SMTP id ffacd0b85a97d-3c82667573bmr5736413f8f.13.1756160581157;
        Mon, 25 Aug 2025 15:23:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7705406d213sm5818322b3a.81.2025.08.25.15.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 15:23:00 -0700 (PDT)
Message-ID: <afcd983e-9514-4cac-80b4-dd20bcf52534@suse.com>
Date: Tue, 26 Aug 2025 07:52:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do more strict compressed read merge check
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <fe1f1d9e9f2425fa25a2ff9295b4e194125392f6.1755991465.git.wqu@suse.com>
 <CAL3q7H7eZp0QG_UyiNaagC=uEk_od87jsdVrJq0YyyXfOnb-nw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7eZp0QG_UyiNaagC=uEk_od87jsdVrJq0YyyXfOnb-nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/25 20:12, Filipe Manana 写道:
> On Sun, Aug 24, 2025 at 12:27 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> When running test case generic/457, there is a chance to hit the
>> following error, with 64K page size and 4K btrfs block size, and
>> "compress=zstd" mount option:
>>
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.17.0-rc2-custom+ #129 SMP PREEMPT_DYNAMIC Wed Aug 20 18:52:51 ACST 2025
>> MKFS_OPTIONS  -- -s 4k /dev/mapper/test-scratch1
>> MOUNT_OPTIONS -- -o compress=zstd /dev/mapper/test-scratch1 /mnt/scratch
>>
>> generic/457 2s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests-dev/results//generic/457.out.bad)
>>      --- tests/generic/457.out   2024-04-25 18:13:45.160550980 +0930
>>      +++ /home/adam/xfstests-dev/results//generic/457.out.bad    2025-08-22 16:09:41.039352391 +0930
>>      @@ -1,2 +1,3 @@
>>       QA output created by 457
>>      -Silence is golden
>>      +testfile6 end md5sum mismatched
>>      +(see /home/adam/xfstests-dev/results//generic/457.full for details)
>>      ...
>>      (Run 'diff -u /home/adam/xfstests-dev/tests/generic/457.out /home/adam/xfstests-dev/results//generic/457.out.bad'  to see the entire diff)
>>
>> The root problem is, after certain fsx operations the file contents
>> change just after a mount cycle.
>>
>> There is a much smaller reproducer based on that test case, which I
>> mainly used to debug the bug:
>>
>> workload() {
>>          mkfs.btrfs -f $dev > /dev/null
>>          dmesg -C
>>          trace-cmd clear
>>          mount -o compress=zstd $dev $mnt
>>          xfs_io -f -c "pwrite -S 0xff 0 256K" -c "sync" $mnt/base > /dev/null
>>          cp --reflink=always -p -f $mnt/base $mnt/file
>>          $fsx -N 4 -d -k -S 3746842 $mnt/file
>>          if [ $? -ne 0 ]; then
>>                  echo "!!! FSX FAILURE !!!"
>>                  fail
>>          fi
>>          csum_before=$(_md5_checksum $mnt/file)
>>          stop_trace
>>          umount $mnt
>>          mount $dev $mnt
>>          csum_after=$(_md5_checksum $mnt/file)
>>          umount $mnt
>>          if [ "$csum_before" != "$csum_after" ]; then
>>                  echo "!!! CSUM MISMATCH !!!"
>>                  fail
>>          fi
>> }
>>
>> This seed value will cause 100% reproducible csum mismatch after a mount
>> cycle.
>>
>> The seed value results only 2 real operations:
>>
>>    Seed set to 3746842
>>    main: filesystem does not support fallocate mode FALLOC_FL_UNSHARE_RANGE, disabling!
>>    main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
>>    main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
>>    main: filesystem does not support exchange range, disabling!
>>    main: filesystem does not support dontcache IO, disabling!
>>    2 clone       from 0x3b000 to 0x3f000, (0x4000 bytes) at 0x1f000
>>    3 write       0x2975b thru    0x2ba20 (0x22c6 bytes)  dontcache=0
>>    All 4 operations completed A-OK!
> 
> Can you please make a test case for fstests?
> Without fsx of course, since when new operations are added or fsx is
> changed in other ways, the same seed is likely to not exercise the bug
> anymore.
> 
> Just using xfs_io (writes, cloning, etc).

Sure.

Although by the nature of page reads, on x86_64 it will mostly not 
reproduce and only trigger on bs < ps cases.

[...]
>> This means, we reads of range [124K, 140K) and [140K, 165K) should not
> 
> "we reads of range..." -> the reads of ranges...
> 
>> be merged.
>>
>> But read merge check function, btrfs_bio_is_contig(), is only checking
>> the disk_bytenr of two compressed reads, as there are not enough info
>> like the involved extent maps to do more comprehensive checks, resulting
>> the incorrect compressed read.
> 
> So this is a variant of similar problems solved in the past where for
> compressed extents we merged when we shouldn't have:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=005efedf2c7d0a270ffbe28d8997b03844f3e3e7
> http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=808f80b46790f27e145c72112189d6a3be2bc884
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e928218780e2f1cf2f5891c7575e8f0b284fcce

Exactly.

> And we have test cases btrfs/103, btrfs/106 and btrfs/183 that
> exercise those past pugs.
> 
>>
>> Unfortunately this is a long existing bug, way before subpage block size
>> support.
>>
>> But subpage block size support (and experimental large folio support)
>> makes it much easier to detect.
>>
>> If block size equals page size, regular page read will only read one
>> block each time, thus no extent map sharing nor merge.
>>
>> (This means for bs == ps cases, it's still possible to hit the bug with
>> readahead, just we don't have test coverage with content verification
>> for readahead)
>>
>> [FIX]
>> Save the last hit compressed extent map start/len into btrfs_bio_ctrl,
>> and check if the current extent map is the same as the saved one.
>>
>> Here we only save em::start/len to save memory for btrfs_bio_ctrl, as
>> it's using the stack memory, which is a very limited resource inside the
>> kernel.
>>
>> Since the compressed extent maps are never merged, their start/len are
>> unique inside the same inode, thus just checking start/len will be
>> enough to make sure they are the same extent map.
>>
>> If the extent maps do not match, force submitting the current bio, so
>> that the read will never be merged.
>>
>> CC: stable@vger.kernel.org
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> v2:
>> - Only save extent_map::start/len to save memory for btrfs_bio_ctrl
>>    It's using on-stack memory which is very limited inside the kernel.
>>
>> - Remove the commit message mentioning of clearing last saved em
>>    Since we're using em::start/len, there is no need to clear them.
>>    Either we hit the same em::start/len, meaning hitting the same extent
>>    map, or we hit a different em, which will have a different start/len.
>> ---
>>   fs/btrfs/extent_io.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 0c12fd64a1f3..418e3bf40f94 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -131,6 +131,22 @@ struct btrfs_bio_ctrl {
>>           */
>>          unsigned long submit_bitmap;
>>          struct readahead_control *ractl;
>> +
>> +       /*
>> +        * The start/len of the last hit compressed extent map.
>> +        *
>> +        * The current btrfs_bio_is_contig() only uses disk_bytenr as
>> +        * the condition to check if the read can be merged with previous
>> +        * bio, which is not correct. E.g. two file extents pointing to the
>> +        * same extent.
>> +        *
>> +        * So here we need to do extra check to merge reads that are
>> +        * covered by the same extent map.
>> +        * Just extent_map::start/len will be enough, as they are unique
>> +        * inside the same inode.
>> +        */
>> +       u64 last_compress_em_start;
>> +       u64 last_compress_em_len;
>>   };
>>
>>   /*
>> @@ -957,6 +973,32 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
>>                  readahead_expand(ractl, ra_pos, em_end - ra_pos);
>>   }
>>
>> +static void save_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
>> +                              const struct extent_map *em)
>> +{
>> +       if (btrfs_extent_map_compression(em) == BTRFS_COMPRESS_NONE)
>> +               return;
>> +       bio_ctrl->last_compress_em_start = em->start;
>> +       bio_ctrl->last_compress_em_len = em->len;
>> +}
> 
> Something so simple can be open coded instead in the single caller...
> 
>> +
>> +static bool is_same_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
>> +                                 const struct extent_map *em)
>> +{
>> +       /*
>> +        * Only if the em is completely the same as the previous one we can merge
>> +        * the current folio in the read bio.
>> +        *
>> +        * Here we only need to compare the em->start/len against saved
>> +        * last_compress_em_start/len, as start/len inside an inode are unique,
>> +        * and compressed extent maps are never merged.
>> +        */
>> +       if (em->start != bio_ctrl->last_compress_em_start ||
>> +           em->len != bio_ctrl->last_compress_em_len)
>> +               return false;
> 
> Same here. In fact we already have part of this logic in the caller, see below.
> 
> 
>> +       return true;
>> +}
>> +
>>   /*
>>    * basic readpage implementation.  Locked extent state structs are inserted
>>    * into the tree that are removed when the IO is done (by the end_io
>> @@ -1080,9 +1122,19 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>>                      *prev_em_start != em->start)
>>                          force_bio_submit = true;
>>
>> +               /*
>> +                * We must ensure we only merge compressed read when the current
>> +                * extent map matches the previous one exactly.
>> +                */
>> +               if (compress_type != BTRFS_COMPRESS_NONE) {
>> +                       if (!is_same_compressed_em(bio_ctrl, em))
>> +                               force_bio_submit = true;
>> +               }
> 
> We already do almost all of this above - we only miss the extent map
> length check.
> We have the prev_em_start which already stores the start offset of the
> last found compressed extent map, so we're duplicating code and logic
> here unnecessarily.
> 
> Further with this new logic, since last_compress_em_start and
> last_compress_em_len are initialized to zero, we always do an
> unnecessary split for the first readahead call that spans more than
> page/folio.
> We need to distinguish the first call and ignore it - that's why
> *prev_em_start is initialized to (u64)-1 and we check that special
> value above.
> 
> 
> 
>> +
>>                  if (prev_em_start)
>>                          *prev_em_start = em->start;
>>
>> +               save_compressed_em(bio_ctrl, em);
> 
> This could have been placed under the check for compress_type !=
> BTRFS_COMPRESS_NONE...
> 
> In other words, this could be simplified to this:
> 
> (also at https://pastebin.com/raw/tZHq7icd)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0c12fd64a1f3..a982277f852b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -131,6 +131,22 @@ struct btrfs_bio_ctrl {
>    */
>    unsigned long submit_bitmap;
>    struct readahead_control *ractl;
> +
> + /*
> + * The start/len of the last hit compressed extent map.
> + *
> + * The current btrfs_bio_is_contig() only uses disk_bytenr as
> + * the condition to check if the read can be merged with previous
> + * bio, which is not correct. E.g. two file extents pointing to the
> + * same extent.
> + *
> + * So here we need to do extra check to merge reads that are
> + * covered by the same extent map.
> + * Just extent_map::start/len will be enough, as they are unique
> + * inside the same inode.
> + */
> + u64 last_compress_em_start;
> + u64 last_compress_em_len;
>   };
> 
>   /*
> @@ -965,7 +981,7 @@ static void btrfs_readahead_expand(struct
> readahead_control *ractl,
>    * return 0 on success, otherwise return error
>    */
>   static int btrfs_do_readpage(struct folio *folio, struct extent_map
> **em_cached,
> -      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
> +     struct btrfs_bio_ctrl *bio_ctrl)
>   {
>    struct inode *inode = folio->mapping->host;
>    struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> @@ -1075,13 +1091,15 @@ static int btrfs_do_readpage(struct folio
> *folio, struct extent_map **em_cached,
>    * is a corner case so we prioritize correctness over
>    * non-optimal behavior (submitting 2 bios for the same extent).
>    */
> - if (compress_type != BTRFS_COMPRESS_NONE &&
> -    prev_em_start && *prev_em_start != (u64)-1 &&
> -    *prev_em_start != em->start)
> - force_bio_submit = true;
> -
> - if (prev_em_start)
> - *prev_em_start = em->start;
> + if (compress_type != BTRFS_COMPRESS_NONE) {
> + if (bio_ctrl->last_compress_em_start != U64_MAX &&

Since we have last_compress_em_len and it's initialized to 0, we can use 
that em_len instead of using U64_MAX for em_start.

Since we should never hit an em with 0 length.

> +    (em->start != bio_ctrl->last_compress_em_start ||
> +     em->len != bio_ctrl->last_compress_em_len))
> + force_bio_submit = true;
> +
> + bio_ctrl->last_compress_em_start = em->start;
> + bio_ctrl->last_compress_em_len = em->len;
> + }
> 
>    em_gen = em->generation;
>    btrfs_free_extent_map(em);
> @@ -1296,12 +1314,15 @@ int btrfs_read_folio(struct file *file, struct
> folio *folio)
>    const u64 start = folio_pos(folio);
>    const u64 end = start + folio_size(folio) - 1;
>    struct extent_state *cached_state = NULL;
> - struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
> + struct btrfs_bio_ctrl bio_ctrl = {
> + .opf = REQ_OP_READ,
> + .last_compress_em_start = U64_MAX,
> + };
>    struct extent_map *em_cached = NULL;
>    int ret;
> 
>    lock_extents_for_read(inode, start, end, &cached_state);
> - ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> + ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
>    btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
> 
>    btrfs_free_extent_map(em_cached);
> @@ -2641,7 +2662,8 @@ void btrfs_readahead(struct readahead_control *rac)
>   {
>    struct btrfs_bio_ctrl bio_ctrl = {
>    .opf = REQ_OP_READ | REQ_RAHEAD,
> - .ractl = rac
> + .ractl = rac,
> + .last_compress_em_start = U64_MAX,
>    };
>    struct folio *folio;
>    struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
> @@ -2649,12 +2671,11 @@ void btrfs_readahead(struct readahead_control *rac)
>    const u64 end = start + readahead_length(rac) - 1;
>    struct extent_state *cached_state = NULL;
>    struct extent_map *em_cached = NULL;
> - u64 prev_em_start = (u64)-1;
> 
>    lock_extents_for_read(inode, start, end, &cached_state);
> 
>    while ((folio = readahead_folio(rac)) != NULL)
> - btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
> + btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
> 
>    btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);

Thanks a lot for the simplified version, will update the patch with this 
change and a more simplified reproducer.

Thanks,
Qu

> 
> Thanks.
>>                  em_gen = em->generation;
>>                  btrfs_free_extent_map(em);
>>                  em = NULL;
>> --
>> 2.50.1
>>
>>



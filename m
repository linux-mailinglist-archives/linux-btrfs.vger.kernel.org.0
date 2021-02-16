Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4731D310
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 00:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhBPXoX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 18:44:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:33063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhBPXoX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 18:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613518954;
        bh=BF9VhfP5Mbla71qJAOUg3VLseOky5TvbxPSY0i8swMk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KAUpcNEL6cgwxCPZ/HEn2XNJBhhNVsK5y+9vReXp4qP3WLMSgf5MV+cFKe9yWsTgM
         PNtE0p8PzXMkCfY3dVA5m3zhDYnGT9tK51db/WaPmMJnNNvjIv+ovUxBlxQaMLjpgo
         lYkCPXjRW/DCxy6sDrolYml/CDN10ic6uP8kgt3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof9F-1lfBGy0oSf-00p65k; Wed, 17
 Feb 2021 00:42:33 +0100
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Ensure the data chunks size
 never exceed device size
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Jiachen YANG <farseerfc@gmail.com>
References: <20200624115527.855816-1-wqu@suse.com>
 <CAL3q7H5sgq_vXpP5rB+bBOBNqaq1+AszGLZvfdgdMLDruQZ4_w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5ba8b5d2-d76b-835d-31c0-80f700104230@gmx.com>
Date:   Wed, 17 Feb 2021 07:42:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5sgq_vXpP5rB+bBOBNqaq1+AszGLZvfdgdMLDruQZ4_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gFTxFaANx8yVgIJicRpKmk1Na+MeiN3Ev9GflehHnxse9pAwuMm
 FMfkBE+RSoaDMa0Ymq7PQfCk7a8+jMC/9XZlo42hb16j6OFOLL8q5Ts06tN2rlgGKC7SXps
 mQkY4/Ot4w9fKPfl32+hpOjgkmSbyd0VfjsSsAgv00yLIfe1jX9hjhLFNuQsNAq/5YsAI0B
 RHvQmlP0fID7kWdeRhb2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e+hmyaoT3hY=:h+XMx6I0H8JfbK6S37tCtV
 QkLaDm4oU9SRHvi4xEqHM01kUoYQoEbYnH8eCwvUaUWo/U6ZmritTRMzd/1+6TRmKRYI/s3Cp
 CQcvbzhV3SBmpGe/rn8j6uK3y2SOP4ERXZvnIGs03GUmztQXWSNhELht9YxEjqv88OQH6/Y57
 521vLT1LZWhWrJx3nZCRRlLxxozBI/Ew1mXqCDpxEAbkiOfoVa2X+6anyG1q3qzshmCRrR0Cv
 zvI819+uNbMG9QSETLa+J1QSE0tdSfAntdwnQ+58uf+WwUetKdrXF7hwo9Z2wV+kme3ZAMfum
 P0IaV4qgKn3zD4sNUEXQAbd7BsNwgvMxnSZm7fBHV1QayyfBol5F4HhMT7PvNpKkYm776cz6C
 oFgSt/N+6ab3CBNQugIjyBnjd7gqlRxQOhlhD8FrtBvGOhktaqodgzaGYCRpGHkIR6aORBwm0
 1LKyVPzDbZeZuCOn8o9uvHpNXdcugE1WqyYKK6XFnIWpNMHaNzmTGRhXDn7Tk0nf5fAsTiaFM
 JPxKB0KMpYr86cfs1SDvyzlSP2B+FpTrY51VfVECGVaxAFJ0zca+/5ZgLkf2sneIeemzavs/m
 iHFD/T1xv9iNBFRBQhl1/5V7AUDXtSLjTt0q8+sZeobFDc/wpJzsNd2buKCyp+9JMF0NqEPtx
 cXH5Bj83BpemKtOXEuH7aqcoYYZH+uUKSBcxlB40L9+HhLl24Pu7LlUPnGZW4cC3899APx245
 SAa/zwGa6GWY9SOXgsOfbBW3a+J/Noq0twBQ5HV+Ord+S/GtPAewYkih6dUO6rd51MnBn2RHc
 vvbkHD3FjNBDvYJKoMHmTSh7DOzQ3GQ36p0t3oY8vzU5eSNg7TmG8Pv52MBiuKxt+OVjcc0WN
 YMqZ5IJ/9RUkpcbWmR3w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/16 =E4=B8=8B=E5=8D=8810:45, Filipe Manana wrote:
> On Wed, Jun 24, 2020 at 10:00 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script could lead to corrupted btrfs fs after
>> btrfs-convert:
>>
>>    fallocate -l 1G test.img
>>    mkfs.ext4 test.img
>>    mount test.img $mnt
>>    fallocate -l 200m $mnt/file1
>>    fallocate -l 200m $mnt/file2
>>    fallocate -l 200m $mnt/file3
>>    fallocate -l 200m $mnt/file4
>>    fallocate -l 205m $mnt/file1
>>    fallocate -l 205m $mnt/file2
>>    fallocate -l 205m $mnt/file3
>>    fallocate -l 205m $mnt/file4
>>    umount $mnt
>>    btrfs-convert test.img
>>
>> The result btrfs will have a device extent beyond its boundary:
>>    pening filesystem to check...
>>    Checking filesystem on test.img
>>    UUID: bbcd7399-fd5b-41a7-81ae-d48bc6935e43
>>    [1/7] checking root items
>>    [2/7] checking extents
>>    ERROR: dev extent devid 1 physical offset 993198080 len 85786624 is =
beyond device boundary 1073741824
>>    ERROR: errors found in extent allocation tree or chunk allocation
>>    [3/7] checking free space cache
>>    [4/7] checking fs roots
>>    [5/7] checking only csums items (without verifying data)
>>    [6/7] checking root refs
>>    [7/7] checking quota groups skipped (not enabled on this FS)
>>    found 913960960 bytes used, error(s) found
>>    total csum bytes: 891500
>>    total tree bytes: 1064960
>>    total fs tree bytes: 49152
>>    total extent tree bytes: 16384
>>    btree space waste bytes: 144885
>>    file data blocks allocated: 2129063936
>>     referenced 1772728320
>>
>> [CAUSE]
>> Btrfs-convert first collect all used blocks in the original fs, then
>> slightly enlarge the used blocks range as new btrfs data chunks.
>>
>> However the enlarge part has a problem, that it doesn't take the device
>> boundary into consideration.
>>
>> Thus it caused device extents and data chunks to go beyond device
>> boundary.
>>
>> [FIX]
>> Just to extra check before inserting data chunks into
>> btrfs_convert_context::data_chunk.
>>
>> Reported-by: Jiachen YANG <farseerfc@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> So, having upgraded a test box from btrfs-progs v5.6.1 to v5.10.1, I
> now have btrfs/136 (fstests) failing:
>
> $ ./check btrfs/136
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian8 5.11.0-rc7-btrfs-next-81 #1 SMP
> PREEMPT Tue Feb 16 12:29:07 WET 2021
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
> btrfs/136 7s ... [failed, exit status 1]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad)
>      --- tests/btrfs/136.out 2020-06-10 19:29:03.818519162 +0100
>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad
> 2021-02-16 14:31:30.669559188 +0000
>      @@ -1,2 +1,3 @@
>       QA output created by 136
>      -Silence is golden
>      +btrfs-convert failed
>      +(see /home/fdmanana/git/hub/xfstests/results//btrfs/136.full for d=
etails)
>      ...
>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/136.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad'  to see
> the entire diff)
> Ran: btrfs/136
> Failures: btrfs/136
> Failed 1 of 1 tests
>
> A bisect pointed to this patch.
> Did you get this failure on your test box as well?

Nope.

Just tested with btrfs-progs v5.10.1, it passes:
  $ which btrfs
  /usr/bin/btrfs
  $ btrfs --version
  btrfs-progs v5.10.1
  $ sudo ./check btrfs/136
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 btrfs-desktop-vm 5.11.0-rc4-custom+ #4
SMP PREEMPT Mon Jan 25 18:35:22 CST 2021
  MKFS_OPTIONS  -- /dev/mapper/test-scratch1
  MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

  btrfs/136 6s ...  10s
  Ran: btrfs/136
  Passed all 1 tests

Would you mind to provide the 136.full to help debugging the failure?

Thanks,
Qu
>
> Thanks.
>
>> ---
>>   convert/main.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/convert/main.c b/convert/main.c
>> index c86ddd988c63..7709e9a6c085 100644
>> --- a/convert/main.c
>> +++ b/convert/main.c
>> @@ -669,6 +669,8 @@ static int calculate_available_space(struct btrfs_c=
onvert_context *cctx)
>>                          cur_off =3D cache->start;
>>                  cur_len =3D max(cache->start + cache->size - cur_off,
>>                                min_stripe_size);
>> +               /* data chunks should never exceed device boundary */
>> +               cur_len =3D min(cctx->total_bytes - cur_off, cur_len);
>>                  ret =3D add_merge_cache_extent(data_chunks, cur_off, c=
ur_len);
>>                  if (ret < 0)
>>                          goto out;
>> --
>> 2.27.0
>>
>
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8438FAB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEYGPt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 02:15:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:48741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhEYGPs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 02:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621923254;
        bh=QkhzG7yizF96xxdxHiYzVYCUUFzMdk0es+ZvqhMfIsc=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=BhXgnpUjhC+7ojGBN4+LrkrHXX/au+uKoxPMWMEnuhd3WQfmC5fFXhZfmvnqlatNj
         Sqafdt0nuzAGl5c7kMkycLxQnEsZsbwn5Pshx73W8A8On5uGsV0El0G7VQJJ+sMMR1
         dVgHPqASBFSaojsWly8bznc7ldLQNMf2r2gxyyGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY6Cb-1lvgfg0wIv-00YOZ2; Tue, 25
 May 2021 08:14:13 +0200
To:     Ritesh Harjani <riteshh@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
 <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
 <20210513163316.ypvh3ppsrmxg7dit@riteshh-domain>
 <20210513213656.2poyhssr4wzq65s4@riteshh-domain>
 <5f1d41d2-c7bc-ceb7-be4c-714d6731a296@gmx.com>
 <20210514150831.trfaihcy2ryp35uh@riteshh-domain>
 <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
 <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
 <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
Date:   Tue, 25 May 2021 14:14:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V9e1LHkwHeMDdYDKACvmVHnzNApPLB3RHvwAT3EBDsC4LsIKAsA
 FD6hDRlH9Z+JXLW67g5WXTagWI+kV4XLPx2ozfYjAKtmCj7/9mBZs5YwqnIYceQBgPTUzKx
 tTuKdrxW6DWs4GkLCcA82QPYcy2xyl8KGKAaqoO4nyJRn6DgAleFQffXzvT5aKMDpJAjfu2
 1gBtdBe0MC7kzhA0Zgjiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KmnjS2hfAVk=:UuONDRmMu1XmU6NVXVi64o
 bQFry0ANEphP3tlHD6YNSpyTgYFoTTtD5E/gjKiDFV/UyQjSoDRY0TOzaaosV0/LDfm9S4Lv2
 ySkaL3swqmp3lyu4GshTHmSlJzWJRYyNNWPbBPQT84XTZE/rZXXHhbPy6nxOTEZeMJdbT5v1L
 uQZubWMWkv8H9x12aB+v3pGR//QpeIUWjFDtDnH9zeghCL7iOR6fwbGWjMdtsfj5keDSRWO3w
 XKmyfIgr+fzIcJOqTh/RlKp0StcDWpxjQ94Z8J4heLWQnn7RPCIfvkbOvJfjSGSO4FBKuos8v
 Dc9VJ07UwYctkoRrPO8JXCA2F5cIzt0Nr3lUMjgKSvXNG1z8xvfmaAcarsviG/adw+Uxdh+OA
 SSfJpl98zHm9FH6MGtjsIMIPNxb+wW/ajoOzk9BIFeMRVsszgGnbcYZihicYWFbtiC3a5WL0z
 QuuXUkV9b3VVxPDb6Ns/hONYlBou9aqZg2ZiJYA4ejJmotTRt44YnPbjjpjjprTKLnlkc8MrB
 mi4ze6/gdJ34aptmaFG+D7lvorx4ZUFk2XL4NW4yg+FbNsCDMgVVhb5wWJaNtsbkUTnATZDqB
 KWcjJ3K4/d0kVWk/SrWrmouKm5hn01Mv4XdK6oFQBPTASWB31E8InDnyWRTR9DeBotQaIgemF
 jKdSeV0YGwp20yi3B9N9/IGhspiyBmIz4X740tWATzonOM8cs3N2Qs5evzlO+H+9ELD9u613R
 AqtYFq2ixESIVm+gglsE7wswXXNaax/8+nW04z7j77XaO5gIrIIfCdbHpfh9z3NdZB2BngsL2
 vT9s6GBCH9gHbPyPrlLO04JhW7jAo4DaCuFsnYzvx09yk1NF8qbd2vyW2smOIbUcZBXqZVsy3
 zioC/IGRsn0QMmRjMyAag4IqVJXkqpgtM5IlvBN2qcQqRg+7QsQkVRS3QUZ8W/vSMNbJz322f
 5JAC1b4QTa7GOcOI1gpTPuN2/nXGBuwWGXj9LpKXy9hfMECgsZ0wIz+PJW8t9l5Z0mAgaoppA
 Xx09oJNa3if4X2F1n1gLbk7v71I3Tocn4SFzSkMfW/SNQFm1ITtGFHBIblQB4NHa10GWQ8uWk
 MmpMzOtzp9LjkQU67cAe2zZ3R4/Gf4VHQUYwrF2vw4V6iIhfMgFSS1Ku+H6U5ztkAb7ldrbUc
 o8eJqMHLPNcoI/H1ngrTY4Q9+Z4PeOp7FB8Tvgv5Nq48L0Mf5yjboUX1ucxBmY/HhFbcaXPWD
 41Pc/OxUzk4APb6cA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/25 =E4=B8=8B=E5=8D=881:52, Qu Wenruo wrote:
>
>
> On 2021/5/25 =E4=B8=8B=E5=8D=8812:43, Ritesh Harjani wrote:
>> On 21/05/15 06:15PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/15 =E4=B8=8B=E5=8D=885:59, Ritesh Harjani wrote:
>>>> On 21/05/15 06:22AM, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>>>
>>>>>> Hi Qu,
>>>>>>
>>>>>> Thanks for pointing this out. I could see that w/o your new fix I
>>>>>> could
>>>>>> reproduce the BUG_ON() crash. But with your patch the test
>>>>>> btrfs/195 still
>>>>>> fails.=C2=A0 I guess that is expected right, since
>>>>>> "RAID5/6 is not supported yet for sectorsize 4096 with page size
>>>>>> 65536"?
>>>>>>
>>>>>> Is my understanding correct?
>>>>>
>>>>> Yep, the test is still going to fail, as we reject such convert.
>>>>>
>>>>> There are tons of other btrfs tests that fails due to the same reaso=
n.
>>>>>
>>>>> Some of them can be avoided using "BTRFS_PROFILE_CONFIGS" environmen=
t
>>>>> variant to avoid raid5/6, but not all.
>>>>>
>>>>> Thus I'm going to update those tests to use that variant to make it
>>>>> easier to rule out certain profiles.
>>>>
>>>> Hello Qu,
>>>>
>>>> Sorry to bother you again. While running your latest full patch
>>>> series, I found
>>>> below two failures, no crashes though :)
>>>> Could you please take a look at it.
>>>>
>>>> 1. btrfs/141 failure.
>>>> xfstests.global-btrfs/4k.btrfs/141
>>>> Error Details
>>>> - output mismatch (see /results/btrfs/results-4k/btrfs/141.out.bad)
>>>
>>> Strangely, it passes locally.
>>>
>>>>
>>>> Standard Output
>>>> step 1......mkfs.btrfs
>>>> step 2......corrupt file extent
>>>> Filesystem type is: 9123683e
>>>> File size of /vdc/foobar is 131072 (32 blocks of 4096 bytes)
>>>> =C2=A0=C2=A0 ext:=C2=A0=C2=A0=C2=A0=C2=A0 logical_offset:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical_offset: length:
>>>> expected: flags:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0..=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 33632=
..=C2=A0=C2=A0=C2=A0=C2=A0 33663:
>>>> 32:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 last,eof
>>>> /vdc/foobar: 1 extent found
>>>> =C2=A0=C2=A0 corrupt stripe #1, devid 2 devpath /dev/vdi physical 116=
785152
>>>> step 3......repair the bad copy
>>>>
>>>>
>>>> Standard Error
>>>> --- tests/btrfs/141.out=C2=A0=C2=A0=C2=A0 2021-04-24 07:27:39.0000000=
00 +0000
>>>> +++ /results/btrfs/results-4k/btrfs/141.out.bad=C2=A0=C2=A0=C2=A0 202=
1-05-14
>>>> 18:46:23.720000000 +0000
>>>> @@ -1,37 +1,37 @@
>>>> =C2=A0=C2=A0 QA output created by 141
>>>> =C2=A0=C2=A0 wrote 131072/131072 bytes
>>>> =C2=A0=C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/se=
c)
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>> ................
>>>> =C2=A0=C2=A0 read 512/512 bytes
>>>> =C2=A0=C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/se=
c)
>>>
>>> The output means the bad copy is not repaired, which is pretty strange=
.
>>> Since my latest work is to make the read repair work in 4K size.
>>>
>>> Mind to test the attached script? (Of coures, you need to change the
>>> $dev
>>> and $mnt according to your environment)
>>>
>>> It would do the same work as btrfs/141, but using scrub to make sure
>>> every
>>> thing is correct.
>>>
>>> Locally, I haven't yet hit a failure for btrfs/141 yet.
>>
>> Hello Qu,
>>
>> Sorry about the long delay on this one. I coudn't hit the issue with
>> your test
>> patch on my machine. Also instead of running btrfs/141 standalone when
>> we run it
>> with btrfs/140, the issue is hitting more often.
>>
>> Can you try running below to see if it hits in your case?
>>
>> ./check -I 20 btrfs/140 btrfs/141
>
> Awesome! Now I can reproduce it locally too.
>
> I'll investigate to ensure it's properly fixed.

What a relief, it's not a big problem in my patchset, but more likely to
be in the test case, especially in the how the mirror number is chosen.

When the test failed, you can find in the dmesg that, there is not any
error mssage related to csum mismatch at all.

This means, we're reading the correct copy, no wonder we won't submit
read repair.
This is mostly caused by the page size difference I guess, which makes
the pid balance read for RAID1 less perdicatable.

I don't yet have any good idea to fix the test case yet, so I'm afraid
we have to consider it as a false alert.

Thanks,
Qu
>
> Thanks again for the awesome report!
> Qu
>>
>>
>> -ritesh
>>
>>>
>>>>
>>>>
>>>> 2. btrfs/124 failure.
>>>>
>>>> I guess below could be due to small size of the device?
>>>>
>>>> xfstests.global-btrfs/4k.btrfs/124
>>>> Error Details
>>>> - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad)
>>>
>>> Again passes locally.
>>>
>>> But accroding to your fs, I notice several unbalanced disk usage:
>>>
>>> # /usr/local/bin/btrfs filesystem show
>>> Label: none=C2=A0 uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
>>> =C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 32.00KiB
>>> =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00GiB used 62=
2.38MiB path /dev/vdc
>>> =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 2.00GiB used 62=
2.38MiB path /dev/vdi
>>>
>>> Label: none=C2=A0 uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
>>> =C2=A0=C2=A0=C2=A0=C2=A0Total devices 4 FS bytes used 379.12MiB
>>> =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00GiB used 8.=
00MiB path /dev/vdb
>>> =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 3 size 20.00GiB used 2=
64.00MiB path /dev/vde
>>> =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 4 size 20.00GiB used 1=
.26GiB path /dev/vdf
>>>
>>> We had reports about btrfs doing poor work when handling unbalanced di=
sk
>>> sizes.
>>> I had a purpose to fix it, with a little better calcuation, but still
>>> not
>>> yet perfect.
>>>
>>> Thus would you mind to check if the test pass when all the disks in
>>> SCRATCH_DEV_POOL are in the same size?
>>>
>>> Of course we need to fix the problem of ENOSPC for unbalanced disks, b=
ut
>>> that's a common problem and not exacly related to subpage.
>>> I should take some time to refresh the unbalanced disk usage patches
>>> soon.
>>>
>>> Thanksm
>>> Qu
>>>
>>> [...]
>>>>
>>>> -ritesh
>>>>
>>
>>

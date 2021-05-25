Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE238FA44
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 07:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhEYFxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 01:53:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:55791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhEYFxv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 01:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621921937;
        bh=kGdzDMFinIBcLMBgjn9BceQVduH6qoGGARlMTToVOVo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SaaGI8AkpCU2FcFuysiNlD8TOgVyI/NsPkUZeUa0Arlk5kB5OVPMwMwHB+6o2oheZ
         ZcUNTq8GB3kL2Q1U3fClD7Q21/mlLa4TjwgwZz1FEuIbpQiDKXjpcgc6O9QevSALk1
         r21CV87QiDkeO9qVSwziD0YaoWfNWJf3lxXphTQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq6M-1lRYim1qKe-00tEqy; Tue, 25
 May 2021 07:52:17 +0200
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
Date:   Tue, 25 May 2021 13:52:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vnPQV/lWsQhVjFgskOiEwVdcyK3c8miQGlf9G0rptRaUQvPV8nD
 9CClZ3zERixW+l1J/rex80l6raYMoFgjQTXxDi8Tk6UmgUySl0wtvxoQUfBVaVeTBdU6tmY
 50ihthFK78X4zj+6goM2AlZLVIEMsEhNe/yJUf4ra9kEbms/NX2jIT3WkFsMRDaHDf53Ft7
 +A54To1Rbv+g/dfJx81OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:urQ9BTIQfN4=:6qX67n4lmSwnuT+p+w8v4K
 s1MNdb6TLN8r7zx1FsX8ZT9dqxcqrG/8d9ZMzxF4cXyJxVuRkkMzVZEwPbFC4EA1cLctT1KKm
 tKxJa7CWJ7DBMLogt+SGCtrJtb3pMUa8k+cL/74WC56ya31saEhXSiKmWRCbOUxENWT94P9F0
 lnAaJ/yuhw/QhtNXZRpo1hteORfda2uCLdGlCNDto/zt24Ahqusak9WxlPY1MleIKBMdbL1qL
 FcF5QasuhgwwFOoQGQ43+Ze8gv2XVM7iODxGIYo3Fhh7Js0gru0YXaJgjhOW8bBfKjNvJXpQT
 R7FC//gNe49DCRQzhArnk/LqNPOzexUjG+WvKfJ3zZC9IlCrWUBwx79UqTs86V2MQ0vNqe9gT
 3ubePZpAeE9e8VwgOWznL2NHB5Le7xA8kfoyPG/eR4QpCTwsTDjfMAAx4EZN8KmWPaiIOy7Pz
 ksXytxUGFXegBaztwGurEWkBpgf35YbbWCFdWTOrtHl+OefEsI+nmYrgoytveG6jHHNYv94wn
 UyE2++Ctp8yp9y/m6XdJek8XIIy1SBQ1PnsVc51vh1y2DHPxfJOZxmUQod0At7+t5j6VPLWLy
 uUTbXiGb4eYvHd01sx03Uq6PpcJVU5PF5qyW5i8i4gtscog22kGZz1QmOCf47IKru5vvqlbDS
 sinB/jd29Opkf0ot+nMR1EsGHWMP8/1o8Z2YTgVbDQCxoY2H/jzjFcXDhR6m9/vGIVCeHUo6e
 dMT1R7z54X+600/PFfAbtoWrMPPMntttIXmdHIuwJW1W6fghlp6j4mc+JOos3YxWdUCYJyl3p
 DhcdW7iLB5phwwbTtb9sAWU6nAURJiI8wW5df3L+ue+cFK9SDPfLHOtymQMYIVqi7+nP7+l9s
 IFtzoLeC1wpwd1YNh22fN3ZWPg9ZAPPMNjQy8XKUdVBLgd/uUCpyjsTSM3L8ak3obPBGM63L/
 3Gyz7PYd3fPZoxPiHNkknVHteIpbxyVSpC/RLR+k/xvSRMa73ApatBPbj88Gm6JvtaBm814Eq
 7lxrxyX5k9hgdhaVZwQ4mH8rvppu1pt/vgq9NcSABdImG7vOooOVLHjadlTEU23TOXSRv3pM0
 Mu7S55zuMRP843M5eOa3hHyzPs/NBMop54UJKUX5iFx8EXscjneovvOvg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/25 =E4=B8=8B=E5=8D=8812:43, Ritesh Harjani wrote:
> On 21/05/15 06:15PM, Qu Wenruo wrote:
>>
>>
>> On 2021/5/15 =E4=B8=8B=E5=8D=885:59, Ritesh Harjani wrote:
>>> On 21/05/15 06:22AM, Qu Wenruo wrote:
>>>>
>>>>
>>>>>
>>>>> Hi Qu,
>>>>>
>>>>> Thanks for pointing this out. I could see that w/o your new fix I co=
uld
>>>>> reproduce the BUG_ON() crash. But with your patch the test btrfs/195=
 still
>>>>> fails.  I guess that is expected right, since
>>>>> "RAID5/6 is not supported yet for sectorsize 4096 with page size 655=
36"?
>>>>>
>>>>> Is my understanding correct?
>>>>
>>>> Yep, the test is still going to fail, as we reject such convert.
>>>>
>>>> There are tons of other btrfs tests that fails due to the same reason=
.
>>>>
>>>> Some of them can be avoided using "BTRFS_PROFILE_CONFIGS" environment
>>>> variant to avoid raid5/6, but not all.
>>>>
>>>> Thus I'm going to update those tests to use that variant to make it
>>>> easier to rule out certain profiles.
>>>
>>> Hello Qu,
>>>
>>> Sorry to bother you again. While running your latest full patch series=
, I found
>>> below two failures, no crashes though :)
>>> Could you please take a look at it.
>>>
>>> 1. btrfs/141 failure.
>>> xfstests.global-btrfs/4k.btrfs/141
>>> Error Details
>>> - output mismatch (see /results/btrfs/results-4k/btrfs/141.out.bad)
>>
>> Strangely, it passes locally.
>>
>>>
>>> Standard Output
>>> step 1......mkfs.btrfs
>>> step 2......corrupt file extent
>>> Filesystem type is: 9123683e
>>> File size of /vdc/foobar is 131072 (32 blocks of 4096 bytes)
>>>    ext:     logical_offset:        physical_offset: length:   expected=
: flags:
>>>      0:        0..      31:      33632..     33663:     32:           =
  last,eof
>>> /vdc/foobar: 1 extent found
>>>    corrupt stripe #1, devid 2 devpath /dev/vdi physical 116785152
>>> step 3......repair the bad copy
>>>
>>>
>>> Standard Error
>>> --- tests/btrfs/141.out	2021-04-24 07:27:39.000000000 +0000
>>> +++ /results/btrfs/results-4k/btrfs/141.out.bad	2021-05-14 18:46:23.72=
0000000 +0000
>>> @@ -1,37 +1,37 @@
>>>    QA output created by 141
>>>    wrote 131072/131072 bytes
>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .........=
.......
>>>    read 512/512 bytes
>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>
>> The output means the bad copy is not repaired, which is pretty strange.
>> Since my latest work is to make the read repair work in 4K size.
>>
>> Mind to test the attached script? (Of coures, you need to change the $d=
ev
>> and $mnt according to your environment)
>>
>> It would do the same work as btrfs/141, but using scrub to make sure ev=
ery
>> thing is correct.
>>
>> Locally, I haven't yet hit a failure for btrfs/141 yet.
>
> Hello Qu,
>
> Sorry about the long delay on this one. I coudn't hit the issue with you=
r test
> patch on my machine. Also instead of running btrfs/141 standalone when w=
e run it
> with btrfs/140, the issue is hitting more often.
>
> Can you try running below to see if it hits in your case?
>
> ./check -I 20 btrfs/140 btrfs/141

Awesome! Now I can reproduce it locally too.

I'll investigate to ensure it's properly fixed.

Thanks again for the awesome report!
Qu
>
>
> -ritesh
>
>>
>>>
>>>
>>> 2. btrfs/124 failure.
>>>
>>> I guess below could be due to small size of the device?
>>>
>>> xfstests.global-btrfs/4k.btrfs/124
>>> Error Details
>>> - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad)
>>
>> Again passes locally.
>>
>> But accroding to your fs, I notice several unbalanced disk usage:
>>
>> # /usr/local/bin/btrfs filesystem show
>> Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
>> 	Total devices 2 FS bytes used 32.00KiB
>> 	devid    1 size 5.00GiB used 622.38MiB path /dev/vdc
>> 	devid    2 size 2.00GiB used 622.38MiB path /dev/vdi
>>
>> Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
>> 	Total devices 4 FS bytes used 379.12MiB
>> 	devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
>> 	devid    3 size 20.00GiB used 264.00MiB path /dev/vde
>> 	devid    4 size 20.00GiB used 1.26GiB path /dev/vdf
>>
>> We had reports about btrfs doing poor work when handling unbalanced dis=
k
>> sizes.
>> I had a purpose to fix it, with a little better calcuation, but still n=
ot
>> yet perfect.
>>
>> Thus would you mind to check if the test pass when all the disks in
>> SCRATCH_DEV_POOL are in the same size?
>>
>> Of course we need to fix the problem of ENOSPC for unbalanced disks, bu=
t
>> that's a common problem and not exacly related to subpage.
>> I should take some time to refresh the unbalanced disk usage patches so=
on.
>>
>> Thanksm
>> Qu
>>
>> [...]
>>>
>>> -ritesh
>>>
>
>

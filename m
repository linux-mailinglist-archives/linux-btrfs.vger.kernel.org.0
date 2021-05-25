Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7398038FE13
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 11:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhEYJrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 05:47:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:38297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhEYJrb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 05:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621935957;
        bh=A7AICk8Ypk6cqAQfQJ2RXDACA/KeIMNI+2n5gEzAt14=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L2rk2u34NycddPGtBM70vuMWDOWH36SlzS/JwZ4RHcrdFJRiXbjDjguAQHhHF6+4Y
         n5HKTOIE/hCEGVktk1jk4rklDZU9hqaW8/f/qk19TFM/52VHA5hDRs1ua2sZdl4/li
         4WgRf0Pdv7GFsfngh/a6xCfzuhPCDDQ40/zUB96E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1lsKBZ0lZp-00Szg0; Tue, 25
 May 2021 11:45:56 +0200
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210513213656.2poyhssr4wzq65s4@riteshh-domain>
 <5f1d41d2-c7bc-ceb7-be4c-714d6731a296@gmx.com>
 <20210514150831.trfaihcy2ryp35uh@riteshh-domain>
 <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
 <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
 <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
 <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
 <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
Date:   Tue, 25 May 2021 17:45:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wKUejMEo6lSPJ7oU7iElnTAMAghf5I8Bp/8HvHh442DsBLjwCTW
 1nKVC9Y8nx7IpxU6M6h/b3LUQuCTgTptjfJI66n++LWVh50qtxyPvCQPsiAc3Ny6f4dBL5D
 mpucK5LwMHZWAJli+daTkObX5pt7zl+5xuYgJ4auyKQzsFmGqaeevA85g8SiBmJOiLk5hD9
 fk+w8b/AD+ag/0S4Tq0lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UVsvZA2ygWU=:Qw1wCzuG61o+p/UxMAULIl
 NLU6bM7TlzpY+R1TsfBL87HRySbS/dG3Sdut4yftpmTNLDu5IGiapCFjKqYOKszxvy5UTjx8P
 YFQy0LjAklsGOaICSF85mBSAhLXg2MJzqCxOzWHtRE9b1STOomv9/bYpv/7yhJMLB84BoUeDO
 ByJP8aRiEwDJM/K1nyW4jMDDyZn0lJSMW5q/UWojYHN9GEV4snKDxCdC7/ypKFWEMM3jQ8VXC
 5+eYbqngg1ruumjbrPXhTKtC+y5aFchwmiJgvwsR8D5zldtYcmdvIHwfhmXHWn47x8xlLrYVF
 dy+GVmD9Sb2Ba9piPrfgz11l9s8jEErnCPg44K9PzJJ7W/u/GDSZ3FKf4KfT2kKDAQXMS6jmf
 iuQkExo+a6k74CxtyiIVAiKYz0TEeW9RdZjeJYJ6jedytM7r/jFcQ2V5tN07yWz8yBZgJexER
 x7RKmv6vhelbiEfbi+9tLw1fj3T5fbJHFfbMRJi6+CKWbw040lwedTiM33uI8HlX5o88uRqPj
 1Uu+KkkPHectWG/dmRQUxMwy7SUelhffVMnlqvQHB5/l74T+c+Cdi+4wdsXHy1f72onz961J+
 mh46+n/9bMAbNGSL3NY5/MGhSoWU1q67jU3X7lKsvLtrGwhyIhinKVBCno0mFfhdiKTB46wMo
 +4oC9VJhQEr7XmLI/OHjX7Jv6J0KnCQ4XvjJNfdjtpl7HLZafsQuIRPFIsuVbYzgrx37LsQxK
 Zb6n7/u3cYAirOOztN2JDgYH1v21rQSxBifAV6T8Wa5gSYBmn+Rd4NbYmG99gPQiQDIfkgfe8
 t4oHT10TsFfJnkBK17Q/SjxZ72SCURfKKbGHsB9jvMKmELvfWOxEzUxHcjcmEWEha4O72KoJn
 R42+713exzhJput10fzX6lwg0r6JK/cUg85mdC8MfO+8L6MVQDMt/elEykbql7gM8p5TDc1Kn
 XvOA56tNYWuKy9jzeIXu450yHaRGzB+UvmZCDTn9xbwZqetXqAZeDroFxmRp6F/uqfFlbMDg9
 AAQHY8wq7kLbqAqkzWJmCfh3FZnNQ1dhflI4XuTU3OK4p58ERLDga2aIoaiB0YT3S8BGTR/5u
 SYx3aoImaM1POlWj1G6UCyxvKTjs42W0riOLzvOQ5ZFAVRpMMFw+d64711V8/j6z+154Ztx6y
 ji+KZ1z6JvrCHndsm19WH/BVv/QDeIpk1o+1EIqnsSPFZrgOruJHxJ0n1ViabrfhYY6gwgG8n
 K2Vdvt7VotTPEi4Fg
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/25 =E4=B8=8B=E5=8D=885:23, Ritesh Harjani wrote:
> On 21/05/25 02:14PM, Qu Wenruo wrote:
>>
>>
>> On 2021/5/25 =E4=B8=8B=E5=8D=881:52, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/25 =E4=B8=8B=E5=8D=8812:43, Ritesh Harjani wrote:
>>>> On 21/05/15 06:15PM, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/5/15 =E4=B8=8B=E5=8D=885:59, Ritesh Harjani wrote:
>>>>>> On 21/05/15 06:22AM, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Hi Qu,
>>>>>>>>
>>>>>>>> Thanks for pointing this out. I could see that w/o your new fix I
>>>>>>>> could
>>>>>>>> reproduce the BUG_ON() crash. But with your patch the test
>>>>>>>> btrfs/195 still
>>>>>>>> fails.=C2=A0 I guess that is expected right, since
>>>>>>>> "RAID5/6 is not supported yet for sectorsize 4096 with page size
>>>>>>>> 65536"?
>>>>>>>>
>>>>>>>> Is my understanding correct?
>>>>>>>
>>>>>>> Yep, the test is still going to fail, as we reject such convert.
>>>>>>>
>>>>>>> There are tons of other btrfs tests that fails due to the same rea=
son.
>>>>>>>
>>>>>>> Some of them can be avoided using "BTRFS_PROFILE_CONFIGS" environm=
ent
>>>>>>> variant to avoid raid5/6, but not all.
>>>>>>>
>>>>>>> Thus I'm going to update those tests to use that variant to make i=
t
>>>>>>> easier to rule out certain profiles.
>>>>>>
>>>>>> Hello Qu,
>>>>>>
>>>>>> Sorry to bother you again. While running your latest full patch
>>>>>> series, I found
>>>>>> below two failures, no crashes though :)
>>>>>> Could you please take a look at it.
>>>>>>
>>>>>> 1. btrfs/141 failure.
>>>>>> xfstests.global-btrfs/4k.btrfs/141
>>>>>> Error Details
>>>>>> - output mismatch (see /results/btrfs/results-4k/btrfs/141.out.bad)
>>>>>
>>>>> Strangely, it passes locally.
>>>>>
>>>>>>
>>>>>> Standard Output
>>>>>> step 1......mkfs.btrfs
>>>>>> step 2......corrupt file extent
>>>>>> Filesystem type is: 9123683e
>>>>>> File size of /vdc/foobar is 131072 (32 blocks of 4096 bytes)
>>>>>>  =C2=A0=C2=A0 ext:=C2=A0=C2=A0=C2=A0=C2=A0 logical_offset:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical_offset: length:
>>>>>> expected: flags:
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0..=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 33=
632..=C2=A0=C2=A0=C2=A0=C2=A0 33663:
>>>>>> 32:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 last,eof
>>>>>> /vdc/foobar: 1 extent found
>>>>>>  =C2=A0=C2=A0 corrupt stripe #1, devid 2 devpath /dev/vdi physical =
116785152
>>>>>> step 3......repair the bad copy
>>>>>>
>>>>>>
>>>>>> Standard Error
>>>>>> --- tests/btrfs/141.out=C2=A0=C2=A0=C2=A0 2021-04-24 07:27:39.00000=
0000 +0000
>>>>>> +++ /results/btrfs/results-4k/btrfs/141.out.bad=C2=A0=C2=A0=C2=A0 2=
021-05-14
>>>>>> 18:46:23.720000000 +0000
>>>>>> @@ -1,37 +1,37 @@
>>>>>>  =C2=A0=C2=A0 QA output created by 141
>>>>>>  =C2=A0=C2=A0 wrote 131072/131072 bytes
>>>>>>  =C2=A0=C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops=
/sec)
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>> +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>>>> ................
>>>>>>  =C2=A0=C2=A0 read 512/512 bytes
>>>>>>  =C2=A0=C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops=
/sec)
>>>>>
>>>>> The output means the bad copy is not repaired, which is pretty stran=
ge.
>>>>> Since my latest work is to make the read repair work in 4K size.
>>>>>
>>>>> Mind to test the attached script? (Of coures, you need to change the
>>>>> $dev
>>>>> and $mnt according to your environment)
>>>>>
>>>>> It would do the same work as btrfs/141, but using scrub to make sure
>>>>> every
>>>>> thing is correct.
>>>>>
>>>>> Locally, I haven't yet hit a failure for btrfs/141 yet.
>>>>
>>>> Hello Qu,
>>>>
>>>> Sorry about the long delay on this one. I coudn't hit the issue with
>>>> your test
>>>> patch on my machine. Also instead of running btrfs/141 standalone whe=
n
>>>> we run it
>>>> with btrfs/140, the issue is hitting more often.
>>>>
>>>> Can you try running below to see if it hits in your case?
>>>>
>>>> ./check -I 20 btrfs/140 btrfs/141
>>>
>>> Awesome! Now I can reproduce it locally too.
>>>
>>> I'll investigate to ensure it's properly fixed.
>>
>> What a relief, it's not a big problem in my patchset, but more likely t=
o
>> be in the test case, especially in the how the mirror number is chosen.
>>
>> When the test failed, you can find in the dmesg that, there is not any
>> error mssage related to csum mismatch at all.
>>
>> This means, we're reading the correct copy, no wonder we won't submit
>> read repair.
>> This is mostly caused by the page size difference I guess, which makes
>> the pid balance read for RAID1 less perdicatable.
>>
>> I don't yet have any good idea to fix the test case yet, so I'm afraid
>> we have to consider it as a false alert.
>
> Ohk gr8, Thanks a lot for looking into it.
> I saw the change log of v3, though I don't think there are any changes f=
rom when
> I last tested the whole patch series, still I will give it a full run wi=
th v3
> for both 4k and 64k config, (since now mostly all issues should be fixed=
).

Just to be more clear, there are some known bugs in the base of my
subpage branch:

- 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-
   bit memory addresses")
   Will screw up at least my ARM board, which is using device tree for
   its PCIE node.
   Have to revert it.

- 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
   Will screw up compressed write with striped RAID profile.
   Fix sent to the mail list:

https://patchwork.kernel.org/project/linux-btrfs/patch/20210525055243.8516=
6-1-wqu@suse.com/

- Known btrfs mkfs bug
   Fix sent to the mail list:

https://patchwork.kernel.org/project/linux-btrfs/patch/20210517095516.1292=
87-1-wqu@suse.com/

- btrfs/215 false alert
   Fix sent to the mail list:

https://patchwork.kernel.org/project/linux-btrfs/patch/20210517092922.1197=
88-1-wqu@suse.com/

Thanks,
Qu
>
> Thanks
> -ritesh
>
>
>>
>> Thanks,
>> Qu
>>>
>>> Thanks again for the awesome report!
>>> Qu
>>>>
>>>>
>>>> -ritesh
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> 2. btrfs/124 failure.
>>>>>>
>>>>>> I guess below could be due to small size of the device?
>>>>>>
>>>>>> xfstests.global-btrfs/4k.btrfs/124
>>>>>> Error Details
>>>>>> - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad)
>>>>>
>>>>> Again passes locally.
>>>>>
>>>>> But accroding to your fs, I notice several unbalanced disk usage:
>>>>>
>>>>> # /usr/local/bin/btrfs filesystem show
>>>>> Label: none=C2=A0 uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 32.00KiB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00GiB used=
 622.38MiB path /dev/vdc
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 2.00GiB used=
 622.38MiB path /dev/vdi
>>>>>
>>>>> Label: none=C2=A0 uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 4 FS bytes used 379.12MiB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00GiB used=
 8.00MiB path /dev/vdb
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 3 size 20.00GiB use=
d 264.00MiB path /dev/vde
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 4 size 20.00GiB use=
d 1.26GiB path /dev/vdf
>>>>>
>>>>> We had reports about btrfs doing poor work when handling unbalanced =
disk
>>>>> sizes.
>>>>> I had a purpose to fix it, with a little better calcuation, but stil=
l
>>>>> not
>>>>> yet perfect.
>>>>>
>>>>> Thus would you mind to check if the test pass when all the disks in
>>>>> SCRATCH_DEV_POOL are in the same size?
>>>>>
>>>>> Of course we need to fix the problem of ENOSPC for unbalanced disks,=
 but
>>>>> that's a common problem and not exacly related to subpage.
>>>>> I should take some time to refresh the unbalanced disk usage patches
>>>>> soon.
>>>>>
>>>>> Thanksm
>>>>> Qu
>>>>>
>>>>> [...]
>>>>>>
>>>>>> -ritesh
>>>>>>
>>>>
>>>>

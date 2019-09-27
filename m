Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8BC050F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfI0MWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 08:22:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:38775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0MWN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 08:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569586926;
        bh=Zfq1Tnhs1OM9+fpmEZUKqWgknksF7kBch9UPpbF+71c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UeM3KTC1efgWAnSSEnmrCPNKouJu+29po3A83UXNjqx4GwhxGckgxgJRecogpXz4l
         udmIkLDHR1m92dC+CkLWlewpKVcevD0Rpl1dceFXmH8MzxZwXhnRzmnoj2edvMuRXH
         029RQLb4ihWMHTSJxnLuI6dXOKlBDrvM/R+xTKxI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnJlW-1hm9P730yq-00jLKl; Fri, 27
 Sep 2019 14:22:06 +0200
Subject: Re: [PATCH 2/2] btrfs: Add test for btrfs balance convert
 functionality
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20190927105233.14926-1-nborisov@suse.com>
 <20190927105233.14926-2-nborisov@suse.com>
 <471ec614-1f19-445e-bb4f-cfceca68f93f@gmx.com>
 <178f1a6a-6c91-de5b-d1eb-a05050c1d5bf@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <da92f869-47ab-4135-dd62-1f16fd6f27af@gmx.com>
Date:   Fri, 27 Sep 2019 20:22:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <178f1a6a-6c91-de5b-d1eb-a05050c1d5bf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OnOTKenxm9gq2cq912Dq6O/pJ6Aqw9fBTIzVx1/kxSdZDbfCs/d
 Q1rzK+7h86g2OmmYYzfZju4UcUCGgBesat8RF1lyqPvtqzyxdSgTHmYACJs+djTCakyPXM4
 FbbpTK4jydxZNDT4fk1BNAFJwxa+Hw9YpGb4qtvmmssH7lRyZ457b3ml8BfrHMMm0QR+DCb
 t8F5ZwfvFHKWsHy83dvAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6sfIc7MNe94=:1MEduxbS5bsGigwrBa2V4I
 IssOzMjm+jAjbgVaHfI3e22nvMdwkEe95qedy1eaJNh6u8xY/zIiyyANSZ/td63PCFJA10ANV
 1ml4VrR7I6TWaWseBspmR0WM+PHVphdID6Qvaoz6W7FKfmwoZ1CVHQj7P0kRBTotyJdK74Usi
 fxbUjY38w5opzldPLMNTHr5sqZvw/K00SbgsNfrYXBl6VjvyZxIIN/jhUpzQqZpTYT0p1SgEc
 Vloso7ojqh2Ye/s+1ZAbB7n5dE5uVbCgwU5QRa2hMRYh0QqCqXHPJyJu4BPJpsG7ZQwyZ0/hd
 BR5ljTXtP7IxoUM+3IPYhrx6Ei7Pwx4+pJMB3CcAAScFQmweVY+btbVTy6rRcy5fKLiWNlf4Y
 LhUAwYyr1R3SjMXyboE2Jg7bg1wrsnF2exJRUV2mdExpMPzGrJF6MtYt+2q9ImDU0dFvgYTEa
 FtTq46MIAVpen9TZHpx/xspyH0o4qXb0Gr7Cs9vk92DpbaTRXubycinaEcM0xoIrz6WHYxCS+
 4SJaV3oYOMZkUiTZ/it0W50qQTLnxRJlAMkSe1F5s8+GPSR7JD5AuKyNSalc1fIjdjBzLiPOl
 jjfliUYjU187lXe/+dOimqbjP60mCoN79bvGvehWOOAL81yMbUR+t5EtpaTQvmxLFqQ8B50Pn
 OppwmgivHbELBvEOiBBWAdY9k/mCfMJUgmTyiX++mM62GBwlGeWJZg82b6uLFUUXszZw4yA55
 zy3IXT+gTsep/OlfJh8LOYaBENgVb+qBE6YoqQ7KviHGgP3ElrVWm+qwOqxGSkOPoSKxueVcs
 1eSV1vpwjQKgi29CAIaXkz0kutN+wwKXjNnh5ulYHLHl650uFtI3n+hEQhr8/MPTQisO9Wfyo
 AueY7kjAwv9gzKLhyynSwbtojiEh7DglHPbdYdB/9moOvonFaodctR8JlPnJ/Lq/OmFi+9xB7
 sv8awGAL7bSl2FNprGRG1xLlefbFPl4v8dp2UleA27OjiVv90qlOlQnbCGq1xEVHb0qualagr
 5lY9czII50nBmDsax7zKbalJXdq6eaAXs1HfnZghXsvVmTIDX1+79KYeZTSwZ3iuW5tjORZMi
 e7ZiTzl2eNJ4N9hYnl/xaJ9+5XItnvVqMmACHMYyWcztXSrdgS+5k7Hu5JoD/OpXk9fhInDN5
 qcwrhni8nDDJQpMTGxhh4rKeHcNCNUCdfWjEt1j3PhpfpLKvE5VxRDm+1scrf3/ucwWZEK1ev
 2Utt+HwcfCluaDx4G5gT2rxpIuHrZQiQyIHZOdM7TI2WoQaahjYEqYrUiUkc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/27 =E4=B8=8B=E5=8D=887:50, Nikolay Borisov wrote:
>
>
> On 27.09.19 =D0=B3. 14:21 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/9/27 =E4=B8=8B=E5=8D=886:52, Nikolay Borisov wrote:
>>> This does an exhaustive testing of all possible conversion combination=
.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>
>>> This is a rather long test - it takes around 38 minutes, OTOH it exerc=
ies around
>>> 1780 combinations of source/destination test.
>>
>> Exactly the problem I'm concerning.
>>
>> However we all know that btrfs convert works by relocating old data to
>> new chunks.
>> It means the source doesn't matter that much.
>>
>> As long as the chunk read code works fine, converting from single to
>> RAID10 is not that different from converting from DUP to RAID10.
>> (ALthough there is still some difference due to different nr_disks and
>> dev extent layouts, but that's not the core problem)
>>
>> By that we can change from testing all the combinations to just testing
>> all destination profiles.
>>
>> This should only needs about 6 tests, and you can reuse all the same
>> setup to fulfill all tests.
>
> True, but thanks to the exhaustive tests I was able to catch xfstest
> special casing -mdup as source argument which resulted in patch 1 of
> this series. I will leave that here to gather some more feedback and
> will trim down the tests.
>
> And regarding the number of tests - do we want to mix the source
> profiles of data/metadata.

To me, unless we have some strong evident in how different data/metadata
profiles can cause different behavior, then using the same profile
should be OK.

> Because it's true that it takes 6 test to
> convert from
>
> SINGLE=3D>DUP, RAID1, RAID5, RAID0, RAID10, RAID6
> but we also need a 7th test e.g. DUP->SINGLE.

Ah, I forgot RAID6. Then it's indeed 7 tests.

BTW, with 7 tests, we can afford more extensive tests, like 15~30s
fsstress at the background, and after balance run a full scrub, then
umount and fsck.

Thanks,
Qu

>
>>
>> Just 4 devices, then you can go convert to SINGLE, DUP, RAID1, RAID5,
>> RAID6, RAID10.
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>>  tests/btrfs/194     | 1843 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>  tests/btrfs/194.out |    2 +
>>>  tests/btrfs/group   |    1 +
>>>  3 files changed, 1846 insertions(+)
>>>  create mode 100755 tests/btrfs/194
>>>  create mode 100644 tests/btrfs/194.out
>>>
>>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>>> new file mode 100755
>>> index 000000000000..7ba4555c12b0
>>> --- /dev/null
>>> +++ b/tests/btrfs/194
>>> @@ -0,0 +1,1843 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test 194
>>> +#
>>> +# Exercises all available combinations of btrfs balance start -d/-m c=
onvert
>>> +#
[...]
>>> +
>>> +for i in "${TEST_VECTORS[@]}"; do
>>> +	run_testcase $i
>>> +done
>>> +
>>> +echo "Silence is golden"
>>> +status=3D0
>>> +exit
>>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>>> new file mode 100644
>>> index 000000000000..7bfd50ffb5a4
>>> --- /dev/null
>>> +++ b/tests/btrfs/194.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 194
>>> +Silence is golden
>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>> index b92cb12ca66f..a2c0ad87d0f6 100644
>>> --- a/tests/btrfs/group
>>> +++ b/tests/btrfs/group
>>> @@ -196,3 +196,4 @@
>>>  191 auto quick send dedupe
>>>  192 auto replay snapshot stress
>>>  193 auto quick qgroup enospc limit
>>> +194 auto volume balance
>>>
>>

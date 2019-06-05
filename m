Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1217F35C46
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfFEMFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 08:05:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:37031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEMFc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 08:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559736324;
        bh=FmSa0fqFJQlC+3qX4C/3IDsK3wJHSoawmrt0dcuyzlE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jfLb5mdycDurnvqXkOyBmE12ZEzdCBD+Vu3xjR5n3tECW/lxS9XJqnl/Ekr8rVVnl
         gxhHJ/k5Yzo0tkzORAt4aMXefA4joQtdAq1qxq6OF2K3IBcjW//Uv8eZrbfhx94aUM
         Uf30MMuNPFTPPHlai83blPDK7GIg18dOKfCBGQco=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LaoHI-1gsW073Ngu-00kM4Z; Wed, 05
 Jun 2019 14:05:24 +0200
Subject: Re: [PATCH v2] fstests: generic/260: Make it handle btrfs more
 gracefully
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190603064009.9891-1-wqu@suse.com>
 <261bff5e-c0c1-2a38-28d9-964a6c713745@suse.com>
 <88a52f0f-da5a-0097-afe1-c1a207f9a318@gmx.com>
 <f173ae7b-08c8-8eac-f3df-a07a63e56157@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <00f12e5c-cff4-03fa-99bf-4f8b7c7a7adc@gmx.com>
Date:   Wed, 5 Jun 2019 20:05:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f173ae7b-08c8-8eac-f3df-a07a63e56157@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LQhScPCrK/etk+Y1oKSy67hLYK2ZgWl6C2Ot0BCWvHxA1Uv7RAK
 QjdDKVxS2GQ3fZDpm85YYQGFNMFMu8Xd+twMpGAdU6rTRRvMP9t/X9Nd1EbYc+ShSWmhXKM
 F9ROg1wSAv+HVCr7UZJbdSSeMa21ty/CcvdV8KvBVvfaMIIKT8rfdpZ70HLT5MQ3dGp2GmY
 5kFBssDoFVG1jssMwPVmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PzCQEQ9iKR4=:+rY2R4w+1ANmR39slUTBmA
 Q//iBGLz8eSELFmeHqpDCBLXCqLaU4ICTTM8ZaXEzDIWhronw9fwMuxgKNfI6OJPycJtL8g9Y
 HoBgk79MdQJP1aLUj2n+NIDVfumrJABgmZIlFiwqc8InMIX91+Doo34NSNC12Kfjhh3ec7YFj
 zB3/JN2tiEFvWgPHqzmYuyv9fVzYt0yWpoLtS4v8mH3aOLhZvCLjdOEL41O0v3N30D1h/t1zR
 w6YFYEH0Q3D/fnk+4newEyOE/+AVXcBN21f1wUKicJv9wa7QI5TMMyhEVeqkpiNKxFTZZdCwt
 54p1Jm9u0lCA7pgcCrSLFSTvhyc4dnXkkq3dKQPoh/1RiYve5e2U45JQK/4qf1mJoAMgCFk8Z
 nTCQpU6mLuEHym1IK0nxLtE3heko4o2nCINUd6L2GsgVMEV/4rnTHSbB/qi6T8SCpYQz14EkM
 InL/E7V0Ts7yTB/A04jtjhlReEATQQpXnyt5gp24spIooLVFz1e/X7HXYnFb3yBWfeYDPKUVa
 nGNPQuyi2ZZwYBfKwkiGag/nVP/neyVhfI0RqTOQ5Ge81BzxYZwATA6Apa1vce9xCWythZDKi
 Usmqd7wHZz0dHjB3WanVc/jaCNizGZqIniawjILN9JofDtCZSXmYRbZbbySYNDa4uC96/MCIg
 Zn4BLajyhlF+t0f3kmUB59tA3EuOPwLFTh9vhhI5KFE4Kpr51BfKsPHjvMCSnj5nlPprLNW+p
 wkLbOG2tX+VyyN+VjzFhDGvpALvM4dckXMbESgdFLZsY4Yowrx1tlKzB1rlP5guNbxU3ZtM51
 C8MGLGS2/JsEEdjHa94Sq19oRn8QLrDQWJ0C8leUeOEh2gYq55N9AmEUvzK135o12nQhTdxOM
 n/FeemFkmChPmeFnYffw5l+JTAW2AbYPAsdij2O1WgEAMF8nuJtsKt0uKnSM0KxvmYziL9oIy
 TtraXAIKZNUeEjaK2gqkV+zhGj33l9aAe49tfINdUa4Y6CIsfw2I4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/5 =E4=B8=8B=E5=8D=887:54, Nikolay Borisov wrote:
>
>
> On 5.06.19 =D0=B3. 14:53 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/6/5 =E4=B8=8B=E5=8D=887:16, Nikolay Borisov wrote:
>>>
>>>
>>> On 3.06.19 =D0=B3. 9:40 =D1=87., Qu Wenruo wrote:
>>>> If a filesystem doesn't map its logical address space (normally the
>>>> bytenr/blocknr returned by fiemap) directly to its devices(s), the
>>>> following assumptions used in the test case is no longer true:
>>>> - trim range start beyond the end of fs should fail
>>>> - trim range start beyond the end of fs with len set should fail
>>>>
>>>> Under the following example, even with just one device, btrfs can sti=
ll
>>>> trim the fs correctly while breaking above assumption:
>>>>
>>>> 0		1G		1.25G
>>>> |---------------|///////////////|-----------------| <- btrfs logical
>>>> 		   |				       address space
>>>>         ------------  mapped as SINGLE
>>>>         |
>>>> 0	V	256M
>>>> |///////////////|			<- device address space
>>>>
>>>> Thus trim range start=3D1G len=3D256M will cause btrfs to trim the 25=
6M
>>>> block group, thus return correct result.
>>>>
>>>> Furthermore, there is no cleared defined behavior for whether a fs sh=
ould
>>>> trim the unmapped space. (only for indirectly mapped fs)
>>>>
>>>> Btrfs currently will always trim the unmapped space, but the behavior
>>>> can change as large trim can be very expensive.
>>>>
>>>> Despite the change to skip certain tests for btrfs, still run the
>>>> following tests for btrfs:
>>>> - trim start=3DU64_MAX with lenght set
>>>>   This will expose a bug that btrfs doesn't check overflow of the ran=
ge.
>>>>   This bug will be fixed soon.
>>>>
>>>> - trim beyond the end of the fs
>>>>   This will expose a bug where btrfs could send trim command beyond t=
he
>>>>   end of its device.
>>>>   This bug is a regression, can be fixed by reverting c2d1b3aae336 ("=
btrfs:
>>>>   Honour FITRIM range constraints during free space trim")
>>>>
>>>> With proper fixes for btrfs, this test case should pass on btrfs, ext=
4,
>>>> xfs.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> changelog:
>>>> v2:
>>>> - Return 0/1 instead of echo "1"/"0" for _is_fs_directly_mapped
>>>>   Although it may be a little confusing, but make
>>>>   "if _is_fs_directly_mapped; then" much cleaner.
>>>> - Comment change.
>>>> ---
>>>
>>> Nope, the output is rather unhelpful. Current misc-next of btrfs fails
>>> and the output is:
>>
>> This is not the output. This is seqres.full.
>>
>> For output, using 5.2-rc2, btrfs would fail like:
>> [+] Optional trim range test (fs dependent)
>> [+] Default length (should succeed)
>> [+] Default length with start set (should succeed)
>> [+] Length beyond the end of fs (should succeed)
>> [+] Length beyond the end of fs with start set (should succeed)
>> Unexpected error happened during trim
>> Test done
>>
>> Which is already good enough to show what's wrong.
>>
>>>
>>> [+] Start =3D 2^64-1 and len is set (should fail)
>>>
>>> [+] Trim an empty fs
>>>
>>> 13554941952 trimed
>>>
>>> [+] Try to trim beyond the end of the fs
>>>
>>> [+] Try to trim the fs with large enough len
>>>
>>> 15727198208 trimed
>>
>> For this full, try it on 5.2-rc2, then you would understand why it's he=
re:
>>
>> [+] Start =3D 2^64-1 and len is set (should fail)  << It doesn't fail
>> [+] Trim an empty fs
>> 0 trimed  << It trimmed 0 bytes, isn't it already a problem?
>> [+] Try to trim beyond the end of the fs
>> fstrim: /mnt/scratch: FITRIM ioctl failed: Input/output error  << Beyon=
d
>> device end bug
>> [+] Try to trim the fs with large enough len
>> 5367267328 trimed  << The only good result here.
>>
>>>
>>> generic/260	[failed, exit status 1]
>>>
>>>
>>> There is no 260.out file which is supposed to contain some of the erro=
r
>>> strings which in turn makes the test tedious to debug...
>>
>> I'm afraid you're checking the wrong file.
>
> I don't have an .out file produced!

Then it's because the output matches.
Only status is wrong.

For latest misc branch, the only test it will fail should be that start
=3D -1 with len set one.
Since that subtest is inside the optional fs dependent test, thus it
doesn't output into stdio but completely rely on seqres.full.

In that case, the seqres.full output should be enough to show the problem.

> [+] Start =3D 2^64-1 and len is set (should fail)

Should fail but no error message? Isn't that the reason why it fails?

Thanks,
Qu

>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>> <snip>
>>>
>>

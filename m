Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E0749E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfGYJbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:31:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:53999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYJbi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564047091;
        bh=AMrfhrkMJPmaEj3O8hUI+AZWfPyZm3qE7qkZEaF5OkI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fnxpRpTouke2n1wwpAlmdfbSnC5y6BcsjBUfIngNJGEhi05COUZvQFZ//WhoIt7HW
         PTR4oOmFXUHD57oe5oD9i9ejIiFpuh0xebv0DjRwTQQZufLuokLJJuta50EEZi041t
         +UbkB6RfBVzQX7wASgcFZg/mg67H2M6TSxwMCeDc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LqV4f-1iLE0m3gvp-00e8Zf; Thu, 25
 Jul 2019 11:31:31 +0200
Subject: Re: [PATCH v2 2/5] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-3-wqu@suse.com>
 <52e2fbdf-7e6a-fab7-ad45-f569a7d7c482@suse.com>
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
Message-ID: <0d52fb9c-625b-7d77-1c3d-34cb030e238a@gmx.com>
Date:   Thu, 25 Jul 2019 17:31:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <52e2fbdf-7e6a-fab7-ad45-f569a7d7c482@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vtMpLp856Kuq3b4HgzzD94k4NEGsaqfJ/VT3y1sbot9VfzF//6P
 Z5b5x/UtqrSqHIOdI6/mpSG1Hxl17BrC7BRTCQdYwgUilvcetgE1vCysZkQzFr+V7rSL5Fw
 zBnNeIW+5iu8R6cK9ieusx5WNDrDKkDlaXLFxGQgEBb8nskKCtacqJeqhs6rglPRdhW6UQw
 nR+ZziF6hnLHfalmrsXhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+W97ocTpFuo=:fMbZ/njKqGnEHXbE5qbgVw
 ivvHdoORPJiFOq0on02TVYdwhsO/A8ZqDeS7JhA92oOD5Ab06zoP8RkVfkaTDexKfWi3cKR6q
 U9uOqcLaFABofmo94COmeunpBaK4AGkLfmB6Y92Ds11m3R+1o0KonojZvLW4AuAXgKCxaBM41
 VfDudCfA71Kzn6v0WlRZJFdfyDhbm3aWVSZ5AIkoUD4n8cw613NHLtLOXsduMFuncUzmdPrYl
 i6Vqlrty+fcXKTAckMKwY/RL4nftgEgNGznRcwFhkYiP23OnvMUjfqJcOnn8KwvjTWZVcbH1o
 EeGTyCqVc+DMtlcoXtvimr0/0Na7nssHxLC8DQZ/9tWjtyWP4Jm4crIUCxFrI/bwCUO0IhtLt
 SvjxjdjUqxwGR6xoJzSZhlHMb/6u6tabhxBQYRLXt4vQXuFrDN/C8WobUfmrk33LbQ6kkZe7b
 fa97IpeYiwgi9rTyC6dM4fl+VmfH1UhyrrM6G25yQmEwS3i5of6N6fxijmphKHSNceeVosFKh
 CruBNStdlDzcMvbxZ9UcykxdfBJn/0bpHw46ZYpUcQ2zE2fbrlhJtBbC25TJtVn2qQk4jYlh2
 og9rms30MB4Qi+yFa4IZxkC2Uj+OJHAAZREIe/jv2wMa1CMo7kvgmWyehDr0wMSGYEdu5dYLx
 VLyWwMfzAxobtiAGBe82auA6YRr/H0OxvdGAtWhZcu2Vw2+JFWwAtAJlOSDWcnaUHfZ+qg75O
 aN5fdjrAB6PgDuGbMMytDzpNPZaEtLiWcFHIZ0K+gU9P8f8nepHovrRcMrhiQsvePy8/tsk54
 Wvf9SBco2z5XQuIvyit4e6ovecbSalJ1m8PSjGmbcjGOqgIcxvny5Vrz0X9HedVCr/8IL3HS6
 4ezzUEyMaNSrD9YVAL0ugN2qG1SlR9OIsirxPTwAqsUgiJWtwG1LLh+uZ8Bu5oq/wqmXm/mue
 cGP/Vk40OejzvSJInHricWqamh1ganp4tjbojqJ1P1G4xAOQUGsgdXXIlD9LXkuMbPIPMUXoi
 6XI3ZK8Wqx83sJtVpIG7QCBkB0cp7Jqa2YjYLLHZoMjmOmIs9G78qHzkg/fuF4wcRAHXrniD1
 /go916flPK+79cOsU3BTZD1L55nTY6D0Ena
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/25 =E4=B8=8B=E5=8D=884:39, Nikolay Borisov wrote:
>
>
> On 25.07.19 =D0=B3. 9:12 =D1=87., Qu Wenruo wrote:
>> __btrfs_free_extent() is one of the best cases to show how optimization
>> could make a function hard to read.
>>
>> In fact __btrfs_free_extent() is only doing two major works:
>> 1. Reduce the refs number of an extent backref
>>    Either it's an inlined extent backref (inside EXTENT/METADATA item) =
or
>>    a keyed extent backref (SHARED_* item).
>>    We only need to locate that backref line, either reduce the number o=
r
>>    remove the backref line completely.
>>
>> 2. Update the refs count in EXTENT/METADATA_ITEM
>>
>> But in real world, we do it in a complex but somewhat efficient way.
>> During step 1), we will try to locate the EXTENT/METADATA_ITEM without
>> triggering another btrfs_search_slot() as fast path.
>>
>> Only when we failed to locate that item, we will trigger another
>> btrfs_search_slot() to get that EXTENT/METADATA_ITEM after we
>> updated/deleted the backref line.
>>
>> And we have a lot of restrict check on things like refs_to_drop against
>> extent refs and special case check for single ref extent.
>>
>> All of these results:
>> - 7 BUG_ON()s in a single function
>>   Although all these BUG_ON() are doing correct check, they're super
>>   easy to get triggered for fuzzed images.
>>   It's never a good idea to piss the end user.
>>
>> - Near 300 lines without much useful comments but a lot of hidden
>>   conditions
>>   I believe even the author needs several minutes to recall what the
>>   code is doing
>>   Not to mention a lot of BUG_ON() conditions needs to go back tens of
>>   lines to find out why.
>>
>> This patch address all these problems by:
>> - Introduce two examples to show what __btrfs_free_extent() is doing
>>   One inlined backref case and one keyed case.
>>   Should cover most cases.
>>
>> - Kill all BUG_ON()s with proper error message and optional leaf dump
>>
>> - Add comment to show the overall workflow
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D202819
>> [ The report triggers one BUG_ON() in __btrfs_free_extent() ]
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Changes look simple enough and benign, only thing I wonder is if we
> should force the system in RO mode? In any case:

For the forced RO, it's a must.
Any error here already means extent tree is corrupted, we can't ignore
such serious error.

For the timing of forced RO, it doesn't really matter whether we abort
trans in this function or not.
As in __btrfs_run_delayed_refs() we will abort transaction anyway.

Thanks,
Qu

>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>

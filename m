Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42CE61F90
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfGHNaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 09:30:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:40369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbfGHNaP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 09:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562592609;
        bh=W/nvN1QqUXq7rc1PKSQ9/fgyK3qdMAKFanryYO9/PHU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HP/KjShaQL/nPkcZjref32zNp0H0vV6qJvsQaDd4rzsoZmFXuNdZFdOXmCRXLvHyQ
         IIOSvZMkf3F+ZlxwLgv0OCxbwaIgjQLBARwfqpLtW9TsvI+poQRIkQ+ySdz5M1+dTt
         snduoH1Dn27vXfP0k1qAQ/8ICuCvWTPt8/A1nSZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMbU-1hhE3g2P7k-00ER0x; Mon, 08
 Jul 2019 15:30:09 +0200
Subject: Re: [PATCH v2 2/2] btrfs-progs: Avoid unnecessary block group item
 COW if the content hasn't changed
To:     Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190708073352.6095-1-wqu@suse.com>
 <20190708073352.6095-3-wqu@suse.com>
 <ab1626ad-ccfe-e913-91e2-47e1710cfd83@suse.com>
 <3221b824-4758-81d2-edb1-9bbc2fdc0775@gmx.com>
 <5ab3dfd9-6326-a79a-49a4-66a5aacbcb9f@suse.com>
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
Message-ID: <77bee387-5693-3cdb-cddb-130b1a118ec0@gmx.com>
Date:   Mon, 8 Jul 2019 21:30:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5ab3dfd9-6326-a79a-49a4-66a5aacbcb9f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CRDey7bivER16gisyPmGXFtH2nzxgqVnyBcNcal2YEtSVqits2v
 EGfnw/FHdhE/QdrU8wvBl5ohnw8F72s3hdnNXEzd/sKidExUmbfXyJsiLm8sGaZ79yM5XaP
 CPOqRJWtCTvFEjC43ItxfhqrWLMyKB6EppfU4+JlEoIQ4h6smhr88TagsW9t3rgxFNPq9XI
 gXiaGbZmDnqCf6BCQdSeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eF1KwwFKf8U=:FY55JXqZULd9umjNbLFMIP
 y5TW9m2vMU1E7gz01GBrj2yKCLePPLFgYJbPozuq8yQyexuvuDITyFoRpBcKmAWIfO325evlS
 xvm77xFtym0wQAaXzaAYysBuXFmUXSnyb9jq4LvigoPw+5hYzQjcofiAYZNgCg4hMt+35uwFJ
 22qLf0tn0pNlbphjpxhtwv8twFdOOedbAnOpURteUyhBo3Gw6mlSaHmFn33On6hguFfbgMY/0
 JvYwJtr94CATLOCGQXH7FsvoK/5IGlMu8FX/RnX2e0DWhhGu/uE1tRbayLGwAf0z1KJACg2j0
 wAlrAPtz2R/aU6SWUxoxYuSDADvmU58kaUpEIgufno92ZiyssZBVL5dCGaiMbM/NtQxJs2wxA
 vFax9Ug6yHmyeS/YimnJP70IYJtPPCW7varzVG4t+YySgArH+R513IdTBZacY+KEOn8xfX37X
 In5tlh8d4+1+BWg/EoLKhidm2C0jSPVPbZYG4DPh6TIEae+zyBv2Ug6VymtZ0geDQEZ34UtCR
 t5VXW8JcSU3vGPu3nIMZMpEnApHuBkIZy0CpwSItcNE2L0ZnA4TJxGk9f+Y3jKkqitlZF7KUG
 kwYl/udErecTn34RFEmqgEfQxYnL8pYYjlQc4WLOmAwRh+UktG9/7FAgdMvjFGfxHlIAOeZuF
 EGOn1/ge3PobIDnws9j+g5pCpJ7LFfh/CD4KVLwo1tJiZv6zqPp9XEbVRSirN7nK0Bs1zTm3M
 mW7mRj8RnefLneYx3h8DrHWH/uZp7MmOy/21itqhOHYFSG6sboku7bQAPtDiYWt4vrooSXmf6
 0dTUt/8bes4sXWkfmSmYTF/k5G21OyW/qveQ6LC10jO4FnHixwrmegaZo7sFI0iUHPszC8HGa
 CP7sF8YXofv0UUDQB5MzF9B09vqc4VyeXlNQaPUVc5nlZ9EmYhM60Qn5yqkdA+8fWL5drhf6b
 plqaJHUEm+CuZvipZB4C0bJ3Le8kVV/kD/pKeEh2GsXQX+w9a/cIp/pXnNcSK86wpKoKyHExo
 OjQ0B6KVRKbF3ILxCQJwCZ1YeUdPNNEUYMA3E/8xQnjQrALhWb5AdnXsWX+QT5O10OYbe8N0+
 sL/bn8iDM6oH3s897tkA6HmUc56plcjIeZx
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/8 =E4=B8=8B=E5=8D=889:07, Nikolay Borisov wrote:
>
>
> On 8.07.19 =D0=B3. 15:50 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/7/8 =E4=B8=8B=E5=8D=886:43, Nikolay Borisov wrote:
>>>
>>>
>>> On 8.07.19 =D0=B3. 10:33 =D1=87., Qu Wenruo wrote:
>>>> In write_one_cache_group() we always do COW to update BLOCK_GROUP_ITE=
M.
>>>> However under a lot of cases, the cache->item is not changed at all.
>>>>
>>>> E.g:
>>>> Transaction 123, block group [1M, 1M + 16M)
>>>>
>>>> tree block 1M + 0 get freed
>>>> tree block 1M + 16K get allocated.
>>>>
>>>> Transaction 123 get committed.
>>>>
>>>> In this case, used space of block group [1M, 1M + 16M) doesn't change=
d
>>>> at all, thus we don't need to do COW to update block group item.
>>>>
>>>> This patch will make write_one_cache_group() to do a read-only search
>>>> first, then do COW if we really need to update block group item.
>>>>
>>>> This should reduce the btrfs_write_dirty_block_groups() and
>>>> btrfs_run_delayed_refs() loop introduced in previous commit.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> I'm not sure how effective this is going to be
>>
>> The effectiveness is indeed low.
>>
>> For btrfs/013 test case, 64K page size, it reduces total number of
>> delayed refs by less than 2% (5/300+)
>>
>> And similar result for total number of dirty block groups.
>>
>>> and isn't this premature
>>> optimization, have you done any measurements?
>>
>> For the optimization part, I'd say it should be pretty safe.
>> It just really skips unnecessary CoW.
>>
>> The only downside to me is the extra tree search, thus killing the
>> "optimization" part.
>>
>
> If that's the case then I'd rather see the 2nd patch dropped. It adds
> more code for no gain.

Makes sense. I'm OK to drop it.

Thanks,
Qu
>
> <snip>
>

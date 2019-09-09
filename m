Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7BADB2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfIIO2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 10:28:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:53193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfIIO2O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 10:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568039287;
        bh=XkRPFQvUpJm3a1kPuRCeZ8RCCA88W3jZdNemVjEjmc0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QbexxEIx5xAcadgI8Fta+sn5eObEA9WadskFwky9x/m00HR+EDRDm3s8iDAz/6Awv
         VDGPJcANzFAwYy8nlpg0OyiGMGDlQrhwGT/8fyPAI4mgkRqQ0PTu+rveqgT8Fj73ur
         55LwjOLw/oJEUZ/EpPXOYE481MMPm/QO/aeFMPAQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhUK-1iSM6s0E68-00nky9; Mon, 09
 Sep 2019 16:28:07 +0200
Subject: Re: [PATCH v2 3/6] btrfs-progs: check/common: Make
 repair_imode_common() to handle inodes in subvolume trees
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-4-wqu@suse.com>
 <43ed2a81-aa0e-22ff-a3db-202b5c945d18@suse.com>
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
Message-ID: <df8efb0a-eddb-61f6-a8a7-1a05aafefea6@gmx.com>
Date:   Mon, 9 Sep 2019 22:27:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <43ed2a81-aa0e-22ff-a3db-202b5c945d18@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OuOxCU6J7HiRwc+V9srAmqGcFYF8TZDeV9iZXjjBn2WiyuegLVP
 cvDurOYKAu0vVhO7hRSI5Os46nZs2rvr1z3P6ebuYYV8UlWAJVEViVT3gAuoBDtvdYhNBx2
 w4RsY5EzvdIXp93ETpV5vq3XAZPVeGOEidDWc3MElzTTeE05GvkXXUuXOPfhTn46BhXMraa
 2kzD/u8FdcTlHBb+B0UBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kkNn8KMj4cA=:i5Fa2lwJpzVQCKy9loWeL6
 ll8jNF9ndZ0Mnlyqo3UtZosol6vJgQYux6S5yG0I/JCsnCR1D6/zLl6svfkS9Da9ZNLso7ujv
 oYsfAHIz7TdtS3l4u9GucfkiT4GuZU+FiqVvPyG/579jvJZOPpDN1jAFZYeitdYfoA8ydmwao
 PiSnuSc2EzdI/y8jk/PC7CytMmLJJDv+suY6HrTyhGRpAdasyQXtoS6oY6cdvI/8+tON9RYDh
 5T0HmMu586nJJqCoLi+Mpt7FcUslIEQVuuiS9827GpZhIAIroDT51HOO/MTiEJlASqAvFqVKU
 We2KMmFcsILZlEIL9PSF2k74E5c+wcfbQUdYC6x+xkWa/GQYIGPqoDruijzEZ9713J/fmdyjf
 gdwXU3a0cjuqso28Oyc84PDsWGepq7AcfK0q/6y6MpvTtOPFxBNRsEkaEp1dZGvoAAmrOxYsY
 sCac6oI+VLXr/7sgy2+qeiwrlsFSb5kpoaNnac+tGaS+/67dyIC3Hc4Brh66EGaWbxkhIAHg7
 CFbOGBsQgHvssmxHsw7ldMw2T9GAWhwHjDGrmyhpCLK1ex7Aj6Pa1nthC/bgmDcVMbE3vGrVv
 J1qlwu45aqzRQA9+VO79ew6LgWrOIhiOWCkirk9fF0MVvS/pE9BdVh0kO7BTLJdJsS2FrCF1h
 n5GlFCfKglUNlnpXnjBNPrdw3HNfoQSvlL1NpX8X4XjCBX5XT3pLRn8q+8RTr0iYuoKgNqNHX
 T6vSwl3gnc1/NWxfgsDLHkCStbFIS+69jXHxJKV0SNrqdKz8N0i188MYFyVtMZRwScoEsFMQ7
 8weNIigEyaKQy93P3RAGTbPg5hXEWH2mKdwELuN0S834bH93Q/P1VBcsH0bMYGikWtUucxLo6
 ErgIpDnpLaMKHI6U2tp4YhCRzSJBjA7GE1SU31MHit2n449AAjFkcxfU1ODEhiWsouqHeghSR
 cCAolWR9lVJS7HYB/P15BA7qK/SAScxrIibqarWRzQKnMqFtfXwnVBOE0IxGouvNrnkHdvv7n
 tixnodPJhQIFLawA8yB1BYf7Uoko3q3ETbwo3KRux1+A37TUEnPapBSmp4cy2zjm7xKC9AcPw
 O9Xi/jclYXGT7FyWV455L7kDTTWrJKXuhiY3pFx7VVBoD74Pr/TeiqYTI0QRVG0IX7jR16o5g
 R80zViLXCwA9vy25WJ8zsZaIU5L4r7oy4DlmcOQCVTkj88w2pVC+SkWzgZqeBlba3W7IRud+3
 ENEIwZiUBB1LdgVcC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/9 =E4=B8=8B=E5=8D=8810:17, Nikolay Borisov wrote:
>
>
> On 5.09.19 =D0=B3. 10:57 =D1=87., Qu Wenruo wrote:
>> Before this patch, repair_imode_common() can only handle two types of
>> inodes:
>> - Free space cache inodes
>> - ROOT DIR inodes
>>
>> For inodes in subvolume trees, the core complexity is how to determine =
the
>> correct imode, thus it was not implemented.
>>
>> However there are more reports of incorrect imode in subvolume trees, w=
e
>> need to support such fix.
>>
>> So this patch adds a new function, detect_imode(), to detect imode for
>> inodes in subvolume trees.
>>
>> That function will determine imode by:
>> - Search for INODE_REF
>>   If we have INODE_REF, we will then try to find DIR_ITEM/DIR_INDEX.
>>   As long as one valid DIR_ITEM or DIR_INDEX can be found, we convert
>>   the BTRFS_FT_* to imode, then call it a day.
>>   This should be the most accurate way.
>>
>> - Search for DIR_INDEX/DIR_ITEM
>>   If above search fails, we falls back to locate the DIR_INDEX/DIR_ITEM
>>   just after the INODE_ITEM.
>>   If any can be found, it's definitely a directory.
>>
>> - Search for EXTENT_DATA
>>   If EXTENT_DATA can be found, it's either REG or LNK.
>>   For this case, we default to REG, as user can inspect the file to
>>   determine if it's a file or just a path.
>>
>> - Use rdev to detect BLK/CHR
>>   If all above fails, but INODE_ITEM has non-zero rdev, then it's eithe=
r
>>   a BLK or CHR file. Then we default to BLK.
>>
>> - Fail out if none of above methods succeeded
>>   No educated guess to make things worse.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/mode-common.c | 130 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 117 insertions(+), 13 deletions(-)
>>
>> diff --git a/check/mode-common.c b/check/mode-common.c
>> index c0ddc50a1dd0..abea2ceda4c4 100644
>> --- a/check/mode-common.c
>> +++ b/check/mode-common.c
>> @@ -935,6 +935,113 @@ out:
>>  	return ret;
>>  }
>>
>> +static int detect_imode(struct btrfs_root *root, struct btrfs_path *pa=
th,
>> +			u32 *imode_ret)
>
> I think the imode is less than u32 so it should be possible to return it
> directly from the function as a positive number and error as negative?

It still doesn't look good enough to me.
Combining data value from error number is not a good idea to me, even
even the range doesn't overlap.

>
>> +{
>> +	struct btrfs_key key;
>> +	struct btrfs_inode_item iitem;
>> +	const u32 priv =3D 0700;
>
> Having this in a variable doesn't bring more clarity, just use 0700
> directly at the end of the function.

I'm OK with that.

Thanks,
Qu

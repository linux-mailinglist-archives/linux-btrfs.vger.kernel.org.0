Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C86CE3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 14:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfGRMsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 08:48:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:48735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRMsy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 08:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563454126;
        bh=IMc5Lt0ObUDNy8fkGC07v0nDDfSnMHQ803KCxFdd1Qo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SJtV2ny1ZNLyCHKs77eP7mq6YFxHTUc9akgOG6uIAxWp7RCR+PLA5sJZKntLncWYh
         GnO42VEAHaeS7T5OfaFOVNpc+wN2Ppn39O7UondM4tJ0ctLUeSGOSiVEGqy1ZNZT6B
         VSSkvw211K7wrUKIItp0YJ6IhzBkd8lTRRdVPuZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6DWi-1hltyw068G-006eCi; Thu, 18
 Jul 2019 14:48:46 +0200
Subject: Re: [PATCH] btrfs: Remove the duplicated and sometimes too cautious
 btrfs_can_relocate()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190718054857.8970-1-wqu@suse.com>
 <68da954b-98d0-68e2-51ff-75aade830d2c@suse.com>
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
Message-ID: <32ca441e-eb2c-7168-26a6-2bf9dcde249d@gmx.com>
Date:   Thu, 18 Jul 2019 20:48:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <68da954b-98d0-68e2-51ff-75aade830d2c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i2XYKq32n82AcClzyJJM/buw0pTd/71pcsLg3WZU4j+2CfaGQ8n
 q3pRCkmB6bMjuRcQ1iIT1DcEzE0bBU5maauDXgGMGnfaTYbEWSNMnWkl84NVz4nzkJiiwvB
 WS38oztRDb3nrh9+Kq3ZKCxjJnPeifS+7YCacsW34Gpv2QjvmYYB+ci/LDnpw/N1Mzk2hoO
 qpOlVSFADzfNaaVM2aZtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QqIiwkABG3Y=:yoasa9H3XdkVxU5ywxfKsm
 ZER+9mEYCXTtm0QCruo/E4ZQTESh0wOrLElfxLylhk+6i3rt4qr4h2FYQtTnCAqqkETArV57c
 Yw5M5JYIdf6Y5oxVf4/Ysu3938eqTDiKY/j7cgt1ixj4+otaXdpvW7DxJn72MrZlhmU1eiYr3
 2YtzrNtBsgppFOGqDj3sArO2G1GPrAm5xwwi0MwzDqwQCWPcMcfr2I3lnB4lWcVx9Hc6VjGOR
 q9FR0iE4MtWrx7YK6cdx/O5tnOWd/cNY/9V8mKPB4QhnJBh4NvttENs+3ZCJA1W8ir/DOzGyy
 xCg0cyzdqmu9RGoCV8TfVTpdQk0Kyx8G/rnXwj/w7rSWgjz/5wH1/DifdixdtVDsXzD3wSjep
 /QFpB2xk0G+X7qcaUgvddTVec3jNzIAG/smT6dDq4WtnjpBcuWVMN1y5Q/Xc0sBSHUccdjMlF
 AbUcdy0Y8012ddZedAs4a8XZyltfTXu/Qr7BfEHJIENJq0/2UzdGSnpEwv2+EHMWxCYOG4OVs
 I1Ro24Efhz6cUnPCljJqCg4YM8VCGqCiMlITv2/BxZu2+T0QgI18Q5Wow7xJKBmcajxZRegVI
 Y4YoEZxU1oX1DKu/0/bcEawqiAx3kXJwLrGqNulso0Sj3dXXuvCXDtox0X2iiualin0hJOAyZ
 E0BYckBFKKRrNuI59pStx9Wo/XM7qoeORJPcAlApkX4ZMw2oqF0acozBaxOZKvBgQzNQDtMwc
 SW85v1gfuP9sF6dgI8SY7mTN0SGc/KR3WzQJLR/m7ypPNkmCR375f3rPIFZVkrkHkg5Tb7APZ
 uZa6PhldaDO99HJuYuqizj0RLVMtupjykGDb80eJ6varY0RAU+4UmrIOJ3Hi3nLhO7wqlrSVZ
 +NCqY4ZPlf8AkMg/HJ9RPuEnqVvVur4+emLK+dXTYpulpMiOhJhmcG9OS5xRtdLNGmD69VJ4t
 Ij53tWtXqW8/U1Bb0dMz3Llte3xWiJ5rO02z8PCnKU/wBb6jLix73RnxxT50MHNlgwGIEp8G3
 C14DliI2q5zA/bvHZp+6qSDLZKwnzD8Am14uDikbB+H07ppBi3PhJrH39Ps+NxKsoMKNxRdJr
 WvK89B3ymD2u7UHC5JUxYSfn5SnSg6F0GGe
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/18 =E4=B8=8B=E5=8D=887:18, Nikolay Borisov wrote:
>
>
> On 18.07.19 =D0=B3. 8:48 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> The following script can easily cause unexpected ENOSPC:
>>   umount $dev &> /dev/null
>>   umount $mnt &> /dev/null
>>
>>   mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null
>>
>>   mount $dev $mnt -o enospc_debug
>>
>>   for i in $(seq -w 0 511); do
>>   	xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
>>   done
>>   sync
>>
>>   btrfs balance start --full $mnt || return 1
>>   sync
>>
>>   # This will report -ENOSPC
>>   btrfs balance start --full $mnt || return 1
>>   umount $mnt
>>
>> Also, btrfs/156 can also fail due to ENOSPC.
>>
>> [CAUSE]
>> The ENOSPC is reported by btrfs_can_relocate().
>>
>> In btrfs_can_relocate(), it does the following check:
>> - If the block group is empty
>>   If empty, definitely we can relocate this block group.
>> - If we are not the only block group and we have enough space
>>   Then we can relocate this block group.
>>
>> Above two checks are completely OK, although I could argue they doesn't
>> make much sense, but the following check is vague and even sometimes
>> too cautious to cause ENOSPC:
>> - If we can allocate a new block group as large as current one.
>>   If we failed previous two checks, we must pass this to relocate this
>>   block group.
>
> btrfs_can_relocate chunk requires min_free to be allocatable.
> min_free is defined as the used space in the  block group being
> relocated, which I think is correct.

Yep, you and Filipe are completely right here.

I mischecked the @min_free.

But compared to the check in inc_block_group_ro(), it doesn't account
values like block group reserved (which is allocated for delayed ref,
but not committed to extent tree), pinned (commit tree blocks which is
not used in current trans) and super bytes (used by super block).

So the check is still not comprehensive.

> Also I find the logic which
> adjusts min_free and dev_min to also be correct. Finally the function
> checks whether the device's freespace is fragmented by trying to find a
> device chunk with the appropriate size. The question is - can we really
> have a device that has enough free space, yet is fragmented such that
> find_free_dev_extent fails which results in failing the allocation? I
> think the answer is no since we allocate in chunk granularity. What am I=
 missing?

In fact, I have already hidden one more problem here.

At the timing of find_free_dev_extents() in btrfs_can_relocate(),
find_free_dev_extents() is not working properly as it always search
*commit* root of dev tree.

With extra dump tree, I found that commit root of dev tree at that
timing has an extra dev extent in commit tree but not in current root.
This is the root cause of the false ENOSPC.

I should explain the root cause and why at that timing calling
btrfs_can_relocate() is not reliable.

Anyway, for the removal part, it still makes sense.

>
>
> OTOH, in btrfs_inc_block_group_ro we only allocate a chunk if:
>
> a) we are changing raid profiles
> b) if inc_block_group_ro fails for our block group.
>
> And for b) I'm a bit puzzled as to what the code is supposed to mean. We=
 have:
>
> num_bytes =3D cache->key.offset - cache->reserved - cache->pinned -
>                       cache->bytes_super - btrfs_block_group_used(&cache=
->item);
>           sinfo_used =3D btrfs_space_info_used(sinfo, true);
>
>           if (sinfo_used + num_bytes + min_allocable_bytes <=3D
>               sinfo->total_bytes) {
> //set ro
>
> }
>
> This means if the free space in the block group + the used space in the
> space info is smaller than the total space in
> the space info - make this block group RO. What's the rationale behind t=
hat?

Oh, this should be a similar check in btrfs_can_relocate(), but I was
confused by the complex check and even considered it correct after
several strange calculations.

What we really want is:

Available space in other block groups >=3D used/pinned/resved space in
this block_group + some buff

In code it should be
sinfo->avail - bg->available >=3D bg->used + buff

Then adds bg->available, we get
sinfo->avail >=3D bg->used + bg->available + buff

And bg->used + bg->available =3D bg->total and sinfo->avail =3D sinfo->tot=
al
- sinfo->used, we should get something like:

sinfo->total >=3D sinfo->used + bg->total + buff.
Compared to current one:
sinfo->total >=3D sinfo->used + bg->avail + buff.

In fact the current one is much easier to meet than the correct one.

I need to double check the calculation.

Thanks for pointing this out,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF22B10E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfILOQk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 10:16:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:44479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732520AbfILOQk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568297789;
        bh=f0vD5EmDaSZUC0wIoyHlVU2Ok8r1enl+mbJ+VtxbNrw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SEjGx+GDHd5XJjJ32Izn69sFFXWzBUb9I8ZfhqkZTHntMsEwUD+AGZ+I8158hdN04
         h7F9D3itavBehfeMULOWdD3J2I0I1LI/oAPwouZWLGAHXfO8jm/LY1KDk9YDiU5Ba4
         ES+dhg4x3WnMfG8jyCqYyDWfC3KQWNtD+uSZr594=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MD9q8-1hu9Ch48gG-00GcNR; Thu, 12
 Sep 2019 16:16:29 +0200
Subject: Re: Mount/df/PAM login hangs during rsync to btrfs subvolume, or
 maybe doing btrfs subvolume snapshot
To:     Nikolay Borisov <nborisov@suse.com>,
        David Newall <btrfs@davidnewall.com>,
        linux-btrfs@vger.kernel.org
References: <933c8585-c0f9-b9d8-c805-caca0eaddae0@gmx.com>
 <b4994446-b352-e78d-b2d3-805276b28623@davidnewall.com>
 <6bc47a9a-8028-abf5-c2fe-09f41ceb323f@suse.com>
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
Message-ID: <fdec389d-fe3e-4aa9-f4d1-67c52f581177@gmx.com>
Date:   Thu, 12 Sep 2019 22:16:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <6bc47a9a-8028-abf5-c2fe-09f41ceb323f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LYj2B72EpKJCBI3XldnrgskeDcLj6JnLESc0+alf/ePPWRWtx/s
 pp/ckmYIReR4T+rSXPs5x9W6P2VhFCglEtEZ8eDqT88l/VKp4p2Ad1tBFkp+ph6W+13okl1
 o9i9orNGOkv1p48sAOxKMh7WWBV3SK1xoY1PHcYrghwFsatLqTW4iBTEeYnVsweGFMgKZjI
 gJZdkDz5mCEkBBPmTD2xw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o/gBb7NAKPw=:aDHwwvy0ynC4LvHy1jSZQV
 gZQQdxqIqfcP6XKk8+0hraydx1aKBulZbIcBFa5INk7LUuurpr0h9ibQmynl7LZj9X5MKMlwM
 ipiuqFH0NXU8MzFV+x+4W6bXO48lhKLK7tg9/eb6nVVaAp7SF8mXaRSb+Ve+rsBpuvfpdsEim
 ZbJGBlXcDdC/AsEiqQ37tBNI3Ybv/HLSQEUCHEmqrtrUChO2Pq1FM9mqBfwPSbLX/pAvSGaCj
 r5AYYfjZQi2d50/cHVLrttl7FSU2Jz6vmvTKsEkZFsVzIrOv8yWQkVVWR+JeDUzKIPtD5B8sj
 fJvVws4Ll5rg1Gaoma1wbLRlUvA7ww1rBmSPaxWGKfBsX2UbKKE/VAV5Tw8vYy6WSdgf66fKW
 VYJ9vV7AG4oMV7/B27JLyqIuopMdU6kNA6BmjqjHXim0/X7cDgqJyybOESt8YDfW+yebwa88r
 Aak/WfyxxysHGYXId5StwDUoTvTDQv53Qu7CNwk7iiwQcyQNb80hGmmA790SP4diZAh81qPB/
 piCxnp9Ifkc7gYMOhvJ0WAz0VtvMyNXrqwAAHXbCNU8Rq/vs/myCVzZ3HIxZ0FypOT01afdbn
 +rUrW9OwCGDBBEY4IHVYbNu2+zkmUsilABJ9gknl4gvDd6X0yp942lnFyhu1hIVlDExSKpu8h
 6pDPeYkmwUpA1vH+EVEWEBSQhoNDSpYMx5MIWywaCHZN2EleEQAX++rdwFsO2+MSS6jDXthnp
 lhE6Jdw1iIsOL6uj4sqkA5sCBqwNJ6TNNHP5ZTlxWZMOKY2ufV7sreFFTSPWzdDb7VShi/gdy
 cClgHG797cM9f9aUGJ6CjK6oqscYjcgRNs6B5ezKJsLQ5YMqxMqmaiej43U7DPLoxhegncN8M
 +GNiWrE5fuWW332mAtaxjDAch8RXTCObxj87RFz20Qk2pK/5m8K6o+yvcLjB5CrCU9g3L5sxr
 h7Wz59tXZ4mHukaO2nklVl7WDyvwYwOsw5lnEuZJNdNEt7tbIDTbwon7aqUo1HKnCR1NWOrHV
 jbbQn0zigoeDP1M/2B3rLrLbJ+HFcvwQQtLu8Z6Ouu1bjb7a81s4XJh2UumR11jPdArJQRwSX
 idkp64T3iFMLp73cbbcYNc9i5vRFHCcZiz0QnA7t+mo+ana3cWyPyePOGpzOTVzigyl3fIkxC
 KmQfZ4nhY/PCYHCJNmU4fCb9f/Ll8BUcuhiRsNXvoP0/ngbZ3A9vfP8sm4FaNgqdxRYfPEoao
 wQtDckv+YwFMI37aRJt69grE0OPuj7P+pmG1TIR151uTp/qEbsnYFul+OLgU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/12 =E4=B8=8B=E5=8D=8810:12, Nikolay Borisov wrote:
>
>
> On 12.09.19 =D0=B3. 17:03 =D1=87., David Newall wrote:
>> Hello Qu,
>>
>> Thank you very much for helping me with this.
>>
>> On 12/9/19 4:35 pm, Qu Wenruo wrote:
>>> Would you please check how fast (or how slow in this particular case)
>>> the related disks are?
>>> To me, it really looks like just too slow devices.
>>
>> I discover that you are correct about the underlying storage being
>> slow.=C2=A0 Nikolay suggested that, too.
>>
>> Although I mentioned that the filesystem is encrypted with luks on the
>> VM, I didn't say that the underlying storage is connected via multipath
>> iSCSI (with two paths) on the host server, and provided to the VM via
>> KVM as Virtio disk, which should be fine, but, using dd (bs=3D1024k
>> count=3D15) on the VM, I'm seeing a woeful 255KB/s read speed through t=
he
>> encryption layer, and 274KB/s from the raw disk.=C2=A0 :-(
>>
>> On the host, I'm seeing 2MB/s via one path and 846KB/s via the other, s=
o
>> I think that's where I need to turn my attention.=C2=A0 (Time to benchm=
ark,
>> turn off one path, and speak to the DC management.)
>>
>>> I see all dumps are waiting for write_all_supers.
>>>
>>> Would you please provide the code context of
>>> write_all_supers.isra.43+0x977?
>>>
>>> I guess it's wait_dev_flush(), which is just really waiting for disk
>>> writes.
>>
>> Sorry, I don't understand what you mean by "code context".=C2=A0 Maybe =
the
>> question is now moot.
>>
>> Although it's now apparent that I've got a really slow disk, I still
>> wonder if btrfs is holding a lock for an unnecessarily long time
>> (assuming that it is btrfs holding the lock.)=C2=A0 I feel that having =
to
>> wait tens of minutes to find the device names of mounted devices could
>> never be intended, so there might be something that needs tweaking.
>>
>
> With the kernel you are using that's how things were structured for
> various reasons. Recent kernel versions do not take device_list_mutex
> when printing the device name. So if you update your kernel to one which
> contains :
>
> 88c14590cdd6 ("btrfs: use RCU in btrfs_show_devname for device list
> traversal")

Oh, we have already addressed that in a better way than rw_semaphore...

I must have lived under a rock for a while...

Thanks,
Qu
>
> this particular problem would be gone. Looking at the history of that
> commit this means kernel 4.17 at least.
>
> <snip>
>
>>

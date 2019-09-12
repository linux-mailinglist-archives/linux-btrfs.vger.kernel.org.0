Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9927DB0923
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfILHFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 03:05:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:56149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfILHFr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 03:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568271933;
        bh=9HEYxiQf8dtqK64+AYpM4qCdjP1XLCVjnNM0bZxcxVg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Mh8HAaX892mNkKVpieiJ22KLDZHY/n6+K47IpyH07JlbpPtW6yd7ltr0V4CbAJ6U1
         4KF7h6KJ5Q2+xg0jWoRK29kjh1szWoVh3+R+saPVBAIT9w12l4eq/kM9XTkWGIp2vu
         Wa7uD9qDmuVbAViCfj1kZI74LHVpHGPS0pFbDxWE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Ma2Lr-1hpnmN3xd9-00Lnsh; Thu, 12
 Sep 2019 09:05:33 +0200
Subject: Re: Mount/df/PAM login hangs during rsync to btrfs subvolume, or
 maybe doing btrfs subvolume snapshot
To:     Nikolay Borisov <nborisov@suse.com>,
        David Newall <btrfs@davidnewall.com>,
        linux-btrfs@vger.kernel.org
References: <c00dfaf7-81a4-5e79-6279-b4af53f7f928@davidnewall.com>
 <1a651f17-ba40-2f17-403e-69999e927b2d@suse.com>
 <cfc872b2-ea1e-57b4-f548-48679daad069@davidnewall.com>
 <133d5657-a045-ad53-31f0-75714d983255@suse.com>
 <d83709b8-7c0f-d3dd-7d6e-3bdbe08e144a@davidnewall.com>
 <4491d00e-a97f-232b-284c-b462a7846949@suse.com>
 <40e4c599-9e15-f59d-5035-5d7231c67ab6@suse.com>
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
Message-ID: <933c8585-c0f9-b9d8-c805-caca0eaddae0@gmx.com>
Date:   Thu, 12 Sep 2019 15:05:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <40e4c599-9e15-f59d-5035-5d7231c67ab6@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aj87RiXTm3WdMC/A5QciabzK5P5EHbRQ5HIliePM64CHcEVlXy9
 WLeyhsjNDwqPWaocDFCauJyCAjkSVnMsp8qGY8JxKlSCW14O86KvR9j41cSIjIxm+Q4NgoF
 nQ4Ep5bunePMLyiD+LqeEtn2N/VCOqz9PV4BWwxtuRRK7mO0GSDwzqL6mJC/M2l8PmzLpnl
 Yk6S22WqMvXPemlaSpXBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OJX8lElel+c=:trKxv1sETUS+3fbyeEKakQ
 TPE6SJS87mteyePBs31HCiKEmOngO72Suzoo3na9Y4muq/1d4e7GKZZAJ1Aka8edkKUbIhG6c
 Zg0U30eoLzl1f3ynk8KFtO0RttVvjX5VUBLgFObAnozfNuQ5hWe6H4Y2EfcMGUve4IXXZR5cZ
 RZOdDdwON+HcYK+KxFWeB8zKf4OjnTfWhJvexeVGiM/ZGr9KUadLkS4tJFLQQuzCMZ7MzA5bK
 Hhy5U1PR/cBThj9F1tYoHzsY6Zqmq/gwRJDYPb7nh0plPSzaQ0sSuLfhNPWlwPwmuDgExw64M
 UfFas9s0XsKG+/OUYTNj5C1qyIvNRFTktVoLnxY9Dw5/Nvj+Gscrzq2ccrD3GtUoAmiN0UJmG
 Rsn2gjl3hEwaklAWC6ddItNqWa150IDvc4XYtTH9XjeGKQk4O3HFGA+9mmV63DP0lBdE3d1am
 ggYpOnu3MSrt7pnPszxoxbcPkwz7Fljb6TLp/4GwtzBQKh3vGzR7YJ0K7RYIZV0e6uUc4POXw
 7l09VQl+r36slFhV1ul4OmfzZ1l2yONBC+2M2auwnDwXQ5A3SFtOAtngbdP6LvLuRimKj8jCl
 05wmKfjmqz2sFggix1xhqjdE0IfX5ZWZccvbG12BU4FSEOdBh6AX/gOyHYTnl8QfQLHSplkYo
 yH414OKUecO+OslYePSzeo8XjMFhIf2ecNhk5yUIabLYSl8JVgbMI4Ocws+vdHWHisasJ2RKO
 Ly9HTfBIJoPjg/gzvMCUlJeCUSw3PVSPIIunYK5W74ZZ3WESjRz/WcReoBf6wW1mCXg2Be+8y
 S3wscHCtMVNzeyhyL8qYrZU0Rt4R7g+NCmrzWq7RhfnXSDwMiWrksKgKdbyoWnZPWn+hf7ehQ
 qZQDoMELZDu1zc/0MB2ZvYpFshccH4ba5wu5btA5m/i5PGWcQhXKObYYO5sILHz2c5aju1o4r
 0L9QUbDEI5CTBNBYYtH3vQhoibuUBX5fcdwRmjsbAbI1U/yW/HnMH7djQiNDcYQEUqcSv02yz
 5kVlvt2bB55MWIPw9bqNFFoYga80BCDvStzPYdLdCiSy/xF8wbxkfVE7DSxDZunOI+9nRQ/Zw
 rC8o94rzOiiV3oxmcw8UnV6PjozBJmRO9vNb4gibJ+9ZHFDiDUISMe0CuJlWCYvCIvRTmnPHU
 4mpbliZ9b8D26reeNMUdF6Dg4eGKau6doa5do1Hiad6Jzr05/RAkX2ur4KgHczhanGEfejNew
 vYIch5PY/tfS3rJJI
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/12 =E4=B8=8B=E5=8D=882:28, Nikolay Borisov wrote:
>
>
> On 12.09.19 =D0=B3. 9:11 =D1=87., Nikolay Borisov wrote:
>>
>>
>> On 12.09.19 =D0=B3. 7:38 =D1=87., David Newall wrote:
>>> On 11/9/19 8:22 pm, Nikolay Borisov wrote:
>>>>> I saved it tohttps://davidnewall.com/kern.1
>>>> Nothing useful in that log, everything seems normal.
>>>
>>> Thank you, again, for your help.=C2=A0 I am grateful.
>>>
>>> If I understand the output, both df and mount are waiting for
>>> show_mountinfo which is waiting for btrfs_show_devname which is waitin=
g
>>> to get a lock.=C2=A0 They have to wait to find the devname for ten min=
utes.=C2=A0
>>> Is that really normal?
>>
>> It's normal for them to wait for the lock, it's not normal for the lock
>> to be taken for 10 minutes.
>>
>>>
>>> I'm not saying that btrfs is behind it, but it does seem like somethin=
g
>>> is not right.
>>
>> From my POV what's wrong is the fact that btrfs transaction commit is
>> taking a long time. Is it possible that the underlying storage is
>> exhibiting problems e.g. a dying disk/ssd?
>
> Actually when the issue occurs again can you sample the output of echo w
>> /proc/sysrq-trigger. Because right now you have provided 3 samples in
> the course of I don't know how many minutes. So they just give a
> momentarily glimpse into what's happening. E.g. just because we saw
> btrfs transaction/btrfs_show_devname doesn't necessarily mean that's
> what's happening (Though having the same consistent state in the 3 logs
> kind of suggests otherwise).

I see all dumps are waiting for write_all_supers.

Would you please provide the code context of write_all_supers.isra.43+0x97=
7?

I guess it's wait_dev_flush(), which is just really waiting for disk write=
s.

Would you please check how fast (or how slow in this particular case)
the related disks are?
To me, it really looks like just too slow devices.

Thanks,
Qu

>
>>
>>>
>>> I notice that there's a waiting btrfs-transation, too.=C2=A0 I don't k=
now
>>> what the transaction would be, and no doubt it's completely appropriat=
e,
>>> even though the use of btrfs at that point is merely one mount (and on=
e
>>> mount of ext2 over a sub-directory, probably no involvement by btrfs.)
>>>
>>> I see, too, that systemd is waiting for btrfs_show_devname.=C2=A0 It's=
 a
>>> pattern.
>>>
>>> I take your point about the kernel being somewhat old and accept that
>>> I'm unlikely to get far without confirming the problem on a recent ker=
nel.
>>>
>>>
>>

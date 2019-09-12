Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D6DB10CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfILOPN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 10:15:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:59425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732403AbfILOPM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 10:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568297700;
        bh=PWVm6+IxXZN+TaybumCidR/6sYIgSYgkiE40M1VW2Fo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UWF4VAurQ7R4SqrDO4G8EbVwi9HzOgvXc9Di7aC4qOxyA4/lWG4z0O8XLHIae/N9H
         TmftNbX+BmOO+G6hC7LO6x8XHC5Gznf2UNyCQssbHjN+l3DgtuHc4/PGBbLWQKjYHP
         nUmXFF4Enkm2fwa5j+PKBwM/bZ4aU6oGtix66CY0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MZCQ8-1hpf4R0A8q-00KyXy; Thu, 12
 Sep 2019 16:15:00 +0200
Subject: Re: Mount/df/PAM login hangs during rsync to btrfs subvolume, or
 maybe doing btrfs subvolume snapshot
To:     David Newall <btrfs@davidnewall.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <933c8585-c0f9-b9d8-c805-caca0eaddae0@gmx.com>
 <b4994446-b352-e78d-b2d3-805276b28623@davidnewall.com>
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
Message-ID: <71c37529-f654-e273-3869-9fe7dd390327@gmx.com>
Date:   Thu, 12 Sep 2019 22:14:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <b4994446-b352-e78d-b2d3-805276b28623@davidnewall.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TgVqHUbcTYxvG4e34ScQc/+tTn4ZJraUbajocCUjURJ4Q8LpzR4
 Nt5LCgIQxyTNALKVei9Et1d31+TQSDw4gIHVBy8bIgk9EdPurBDaWx6/U5EHULXOrPQ1GiN
 VWnkve06ZwFmAXLNHBGK24CSITqGhjy5hvTiz9N6gFviBuTUn+VnTyixhh9MvAVCRkQBlRO
 rzrPogJ2nE5CVAt71t1jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wj+IZer480c=:58Phlc3JoU0e3xZVFIFeiA
 rxpll7g5HutWL4V/p47LWzIX48woDi/xHultm7hfHN4lcq8tTj3UCW4vkvZ3bkVboN9rMXkHh
 ISh/ojso0hh4O657J8VbUj67XzmHS3SkkT16nGwq+cyI+bN4WyblWpO2CKUVzSei83nuBu1Uz
 3BMGlODiFHnjtuo3PbHUKVtbBxQ30WYMQLV9TLwad0u9ipQif4ALqVEh2ZOlj83NFcpBs0+QF
 rbnKRnEKdzz5pNDIdhPlcaNzJhv1KgaRpOtiuvR1E+V4QY/U1wOQ2yF6a6bDvS64qjgG4+LNF
 SWkSB3eksql/ImJvaodl2dZ+rRA960JYMhT6wm+Uo06JbRdggIZJ+hEA8/fYkSgVw91j+8lKb
 tv5iB7oivTphxIOxgOezDqETyHEUhGLt7hr09sKrzdtQXAS5SnGBPu7ODcRyDur1GzzZLYC+J
 CMDPa0QWtU2PlZkZfR84sHj/bBI9X8S44S0Ux0a5sl4lsJgigwp0iclty1Us9Obfmt0jS+cAz
 n7uCqUI9egZ2BXEh2AObAMccW1n92M8QppWtUbUwOl4eXEdGOrzlBs6tiukDn1Hi+o3VMudQN
 7CzBk8y/L2uBfwx8f0lm/MLFHfR//vdwKQWlER8nL/YoO3dqiTHTqc07a5jm8GLu145Ci3eQz
 EZ3zO7L0Ntv82Muy3U/H/d+Ula1yfYF7Jooydp8RTWLLiPFTEVfuu4V6M+QJrI1tcxPy3Q1vN
 w9HmaDl77uDOZDRWc/+RhB8AiTr6tN+sWzirk4kzMwqFW25f8lNwKS+sQgRSRbBqOQR9vDm/1
 TRP66XMED5Qe2hl0f736BFBw1nSiu+mm8RfDdYU5wjprFe9LSgjhkhftgME7Sh+HL6pvvR3SJ
 /GoNzYflJd8eAYE47TzK6Kvzq8H5saYfV7PKo+jG5f2pyN1vJAIhyPnSqnkg8NGfbtov0TXlq
 1rH2WAlDqey30ROl75qEqPHXOhLgSPgH7+vZmKEMLNkc0oXfy7irNCylpQSt2ZooT18M3RDXt
 d8r/XuEQ3QcYzeA9swWyeMRNxWFqIsKpcrJ3C8FPjGbFln7zv5IcCYFAOqbrN+mkg8ppDhN4+
 9vyHg/ZMIQmPTrwrG9JJMiXWWOu1MrAQEfLOPbnuFHU3LPC2XDVNTo9IdKZ8hLxXk1PS33FCH
 rgarMx7ENaldreqr3bMCqV1dvz8dUYY2LG1kdhsWmMXi2f0mL8N5UgX47i+CoKdg30qo9eKQT
 o5fKQccW3OKhhfy/7MK5PvUfEhw72hF3cdwlZ9QqS/ez5e5GPtUmlVzdUyGk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/12 =E4=B8=8B=E5=8D=8810:03, David Newall wrote:
> Hello Qu,
>
> Thank you very much for helping me with this.
>
> On 12/9/19 4:35 pm, Qu Wenruo wrote:
>> Would you please check how fast (or how slow in this particular case)
>> the related disks are?
>> To me, it really looks like just too slow devices.
>
> I discover that you are correct about the underlying storage being
> slow.=C2=A0 Nikolay suggested that, too.
>
> Although I mentioned that the filesystem is encrypted with luks on the
> VM, I didn't say that the underlying storage is connected via multipath
> iSCSI (with two paths) on the host server, and provided to the VM via
> KVM as Virtio disk, which should be fine, but, using dd (bs=3D1024k
> count=3D15) on the VM, I'm seeing a woeful 255KB/s read speed through th=
e
> encryption layer, and 274KB/s from the raw disk.=C2=A0 :-(
>
> On the host, I'm seeing 2MB/s via one path and 846KB/s via the other, so
> I think that's where I need to turn my attention.=C2=A0 (Time to benchma=
rk,
> turn off one path, and speak to the DC management.)

Glad we found the root cause.

>
>> I see all dumps are waiting for write_all_supers.
>>
>> Would you please provide the code context of
>> write_all_supers.isra.43+0x977?
>>
>> I guess it's wait_dev_flush(), which is just really waiting for disk
>> writes.
>
> Sorry, I don't understand what you mean by "code context".=C2=A0 Maybe t=
he
> question is now moot.
>
> Although it's now apparent that I've got a really slow disk, I still
> wonder if btrfs is holding a lock for an unnecessarily long time
> (assuming that it is btrfs holding the lock.)=C2=A0 I feel that having t=
o
> wait tens of minutes to find the device names of mounted devices could
> never be intended, so there might be something that needs tweaking.

It's not completely unnecessary, but you're right, we can enhance it.

It's the device mutex. At the context of committing a transaction, we
definitely don't want a random new device joining in while we're
iterating devices to flush each device.

However you're still right, since the flush can be slow, we shouldn't
block other dev list read operations, thus it may be a good idea to make
fs_devices->device_list_mutex a rw_semaphore.
So that we only block device add/remove while still allow other device
list read-only operations to kick in.

We may need to take a look into, but please also take in mind that, the
benefit may only be obvious for such slow device, so it's up to the
developers.

Thanks,
Qu

>
> On 12/9/19 3:58 pm, Nikolay Borisov wrote:
>> Actually when the issue occurs again can you sample the output of
>> echo w > /proc/sysrq-trigger.=C2=A0 Because right now you have provided
>> 3 samples in the course of I don't know how many minutes. So they just
>> give
>> a momentarily glimpse into what's happening. E.g. just because we saw
>> btrfs transaction/btrfs_show_devname doesn't necessarily mean that's
>> what's happening (Though having the same consistent state in the 3 logs
>> kind of suggests otherwise).
>
> Again, it's probably all moot, now, but I did take samples at about
> 20-second intervals during 20-minutes of the "hang" period while rsync
> was running.=C2=A0 See https://davidnewall.com/kern.5 through kern.62.
>
> Thanks to all for your help.
>
> Regards,
>
> David
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C44357D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 02:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJUAjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 20:39:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:53777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUAjr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 20:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634776649;
        bh=ozzXSyaEZEMYn4oIkO4991+e2L8HY+hVU9q5WVjmOVs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=W1pSG29ZXR25CvM6RsglUXO85F2UW1W9qj/WGwP4/L0SV3bDxqpXk4fhWx4Co83LR
         Wry0fxF+EgDyyoejo+TgMBaxNdMVfY7kkKw2Pwr+sVkRiKFgMGocv/BpZKdr07H6Bw
         jkbjPlz6CmduUisP+0fX0D4Q2rmtt2belohtJSfU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOREc-1mLGAo2jqY-00PvjN; Thu, 21
 Oct 2021 02:37:29 +0200
Message-ID: <cd1d20c1-e025-9fe8-a3c8-09955f7b2499@gmx.com>
Date:   Thu, 21 Oct 2021 08:37:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Content-Language: en-US
To:     Su Yue <l@damenly.su>, Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su>
 <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
 <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
 <y26ngqqg.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <y26ngqqg.fsf@damenly.su>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:myLainzvoWzxZbbK3D4MY0zeZeZA1jyn48SojUQLM6e25XTzk4M
 sjkVXuyYGVUKd0LXGIBkA1FUWCMaY8sfJwcNm/cDVZFbstdOIN1hWSXImvpZ4jKUvWyc5fh
 V6CnZqu0ydMcBBDkoDdEsp1xOIYHLi52jIXUD+Da9qo7fZTQLI1NJM9VbpQeJ0Fp37kwCnT
 P5vntWkKqAhPhy7IRTgrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Ntu5SgVyx0=:adLuFZ4t/866CRhbRiIkFL
 CakzsW4pwMGuVcp+JP694J+CB86NE3NWGD6TUrdUA1Fbdu7h82+6suGuKblvCrt6Yz9N8nrve
 BrK26Ycj1f73UjCik1H+cqls6vZ7ZmyUCdlIpfljJ5i77wVdNz08llUvx/oaIyOjvnCY7HFuL
 mHBH1gtxarElM34UPHdxzMn05ojtLFen6cVcSn4xjiQignrr5OPKMvxKtua98y7zO+Gcerciq
 piHYn1y6Q11ds7ldKyAdDWPre/PK79EFJgehjIiWXK3KmmNrn0eYWtzZM11Y5u3cgKDA9zn5t
 +MwY6FseO5h7uBSR703VN+EKPz3d792Z9cgZ0xPHtuTZC+LhAET6gPzu012kkO6VnKHGncGaQ
 dMtsGmbkW/AxnEqdVnpzBd31uqq6gQ3MkUMA7tDA9hZAXvacHvOTFw2HPVfANz59iTo+7346I
 9mriAkiwYV54BzuIReh6DqiXTJC/Ya2Pc3GvuaUee9aS54qdq5a7iJvuWvpHuSDa4y8OuqsfF
 XcIBPlc1Pc56FzvEVBwyWY51OXd2UiHF9t5OcTXU89pSU2/5VnXSU6sXCwyC4bs39iV8Utf2H
 Fb7TucFHt5UpSahgkIjAEAo/qBYXe6zHjRVdcX9ujMOL1U8Z0q3D+wxOEOw07mvQin6CnfMn3
 v+ENV+vxlYA8yP438UvDse+JdD6GqX2ITk04OWYd0pgYKpfmd/lE/n6Y3xxOOELoVIIom/0yz
 OmGejEMvDvgXlJUqWfvaycGMSEhFWZSpytrncF6J3gngmXK78nE9tyDH/4Y4s0m079gERHc1L
 IlglnLJ5ljTjn/ZrF/VjRDMuBUGc7ju2NCNtAV4BMeoYK8kWpd1qodRpEbINrDJjZauukwQi+
 vaRj6Yf8oZacyengRUdvqrhSZY1VpL+/GZZwGQ14aQdYngKrfJqJnG2QDhPAD3ibN0IFk7GXz
 VKqCILaMXvLBAf2ssujeTEUaxGCztj/ZwAO3oGhx1M5DM5g5NEO+BrLjqXXd1qU6WqxmuAN4F
 A6gWq35q8/tP12BZxVYiZ/gGq3LczsD9x06keMq+xuGDumbFmFBni/DW0y11U/Cx9guhYo0aE
 Zr7qcBu0mGW+Cs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/21 08:29, Su Yue wrote:
>
> On Wed 20 Oct 2021 at 19:55, Chris Murphy <lists@colorremedies.com> wrot=
e:
>
>> On Tue, Oct 19, 2021 at 9:10 PM Su Yue <l@damenly.su> wrote:
>>>
>>> Dump file and vmlinu[zx] kernel file are needed.
>>
>> So we get a splat but kdump doesn't create a vmcore. Do we need to
>> issue sysrq+c at the time of the hang and splat to create it?
>>
> Yes, please.
>
> BTW, I ran xfstests with 5.14.10-300.fc35.aarch64 and
> 5.14.12-200.fc34.aarch64 in several rounds. No panic/hang found,
> so I think we can exclude the possibility of the toolchain.

Or this can also mean, fstests is not enough to trigger it?

Thanks,
Qu

>
> --
> Su
>
>> Fedora Linux 35 (Cloud Edition)
>> Kernel 5.14.10-300.fc35.aarch64 on an aarch64 (ttyAMA0)
>>
>> eth0: 199.204.45.141 2604:e100:1:0:f816:3eff:fe72:c876
>> dusty-35 login: [=C2=A0 286.982605] Unable to handle kernel paging requ=
est
>> at virtual address fffffffffffffdd0
>> [=C2=A0 286.988338] Mem abort info:
>> [=C2=A0 286.990307]=C2=A0=C2=A0 ESR =3D 0x96000004
>> [=C2=A0 286.992596]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =3D =
32 bits
>> [=C2=A0 286.996316]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
>> [=C2=A0 286.998454]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
>> [=C2=A0 287.000791]=C2=A0=C2=A0 FSC =3D 0x04: level 0 translation fault
>> [=C2=A0 287.004472] Data abort info:
>> [=C2=A0 287.006540]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000004
>> [=C2=A0 287.009239]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0
>> [=C2=A0 287.011344] swapper pgtable: 4k pages, 48-bit VAs,
>> pgdp=3D0000000054181000
>> [=C2=A0 287.018245] [fffffffffffffdd0] pgd=3D0000000000000000,
>> p4d=3D0000000000000000
>> [=C2=A0 287.024209] Internal error: Oops: 96000004 [#1] SMP
>> [=C2=A0 287.027615] Modules linked in: virtio_gpu virtio_dma_buf
>> drm_kms_helper cec joydev fb_sys_fops syscopyarea virtio_net
>> sysfillrect sysimgblt net_failover virtio_balloon failover vfat fat
>> drm fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
>> virtio_mmio aes_neon_bs
>> [=C2=A0 287.047659] CPU: 0 PID: 3558 Comm: kworker/u8:7 Kdump: loaded N=
ot
>> tainted 5.14.10-300.fc35.aarch64 #1
>> [=C2=A0 287.055269] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
>> 02/06/2015
>> [=C2=A0 287.060932] Workqueue: btrfs-delalloc btrfs_work_helper
>> [=C2=A0 287.065353] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=3D=
--)
>> [=C2=A0 287.070568] pc : submit_compressed_extents+0x38/0x3d0
>> [=C2=A0 287.074825] lr : async_cow_submit+0x50/0xd0
>> [=C2=A0 287.078217] sp : ffff800015d4bc20
>> [=C2=A0 287.081008] x29: ffff800015d4bc30 x28: 0000000000000000 x27:
>> ffffb8a2fa941000
>> [=C2=A0 287.087022] x26: fffffffffffffdd0 x25: dead000000000100 x24:
>> ffff000115873608
>> [=C2=A0 287.092822] x23: 0000000000000000 x22: 0000000000000001 x21:
>> ffff0000c6f25800
>> [=C2=A0 287.098591] x20: ffff0000c0596000 x19: 0000000000000001 x18:
>> ffff0000c2100bd4
>> [=C2=A0 287.104387] x17: ffff000115875ff8 x16: 0000000000000006 x15:
>> 50006a3d10a961cd
>> [=C2=A0 287.110159] x14: f0668b836620caa1 x13: 0000000000000020 x12:
>> ffff0001fefa68c0
>> [=C2=A0 287.116170] x11: ffffb8a2fa95b500 x10: 0000000000000000 x9 :
>> ffffb8a2f9131c40
>> [=C2=A0 287.122120] x8 : ffff475f045bb000 x7 : ffff800015d4bbe0 x6 :
>> ffffb8a2fae8ad40
>> [=C2=A0 287.128086] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
>> ffff0000c6f25820
>> [=C2=A0 287.133953] x2 : 0000000000000000 x1 : ffff000115873630 x0 :
>> ffff000115873630
>> [=C2=A0 287.139760] Call trace:
>> [=C2=A0 287.141784]=C2=A0 submit_compressed_extents+0x38/0x3d0
>> [=C2=A0 287.145620]=C2=A0 async_cow_submit+0x50/0xd0
>> [=C2=A0 287.148801]=C2=A0 run_ordered_work+0xc8/0x280
>> [=C2=A0 287.152005]=C2=A0 btrfs_work_helper+0x98/0x250
>> [=C2=A0 287.155450]=C2=A0 process_one_work+0x1f0/0x4ac
>> [=C2=A0 287.161577]=C2=A0 worker_thread+0x188/0x504
>> [=C2=A0 287.167461]=C2=A0 kthread+0x110/0x114
>> [=C2=A0 287.172872]=C2=A0 ret_from_fork+0x10/0x18
>> [=C2=A0 287.178558] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356=
)
>> [=C2=A0 287.186268] ---[ end trace 41ec405ced3786b6 ]---

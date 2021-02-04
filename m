Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC530EBC7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 06:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhBDFPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 00:15:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:50851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhBDFPC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 00:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612415603;
        bh=wArzhVsWaqMu78fKxpAjcOfFnXnZTiL73fUpMuKbp60=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YQtE7Naxty2yaTfDm3uCBLfynwTLM9DZPMvp+fuDIJKatnZpINOgkQSCiOBL/4b/1
         siqU2WpDhhVrFK+O8xyqV5OZYi5bQ0UET8+Ha7pRc1qiZwGe+zJjiTc+g9J6VTiVqQ
         SaY0H3zVmf7M3u499HIMotTHX0nMQ15VxXGvn6Uk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzQg6-1ltsNW3bcW-00vMAj; Thu, 04
 Feb 2021 06:13:23 +0100
Subject: Re: [bug report] Unable to handle kernel paging request
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <5afbf08b-a93d-5633-8212-0e540625594a@oracle.com>
 <d55afd47-189f-e0a6-5577-0e89dab9e37d@gmx.com>
 <913e7523-5700-27ad-4045-200d83e37deb@oracle.com>
 <91e2bcba-c326-4b5d-6242-e537b38ff455@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <61d23f81-dd3e-6bb6-9423-81b3dadb519c@gmx.com>
Date:   Thu, 4 Feb 2021 13:13:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <91e2bcba-c326-4b5d-6242-e537b38ff455@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IuDINrk7aczyrte87fufQ/khnYgKv34kyAlAlpuF9rBn/s6zNkv
 2ccW9IVZi8x76B2a7hGjm/BRO2FdwK29mKylJLlPb3xOzy3NVELYeNimIMyJvJ/XkH++Wbz
 bUC4PxkBau8SlzfvJmgtFDu68c+sQf/AhnFXtwrOUc/+w8hHMIxGqHwS1vPbV/e01dsb1J8
 zS6vg+Fa0/F4BznmY5P+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1015erw8IFs=:W89S6ioaxP/eIBuf+oRkTh
 zLTKs0B2JgKA5xaMLcs8VyOmoMBuLvJzdqr3erok99cweuM5zvykkyNx7vYKyADWHjPICXJFm
 McsM027qPcgRheyO2zPDaetJ3o4ogdJvii2eRd7uvGBHPSM7dbp3oGKiQ8vs9opCD0fvCFw/E
 fWZT1lFgodZbVVU1A1/+29qAza1AOTUDZ6hDzzuHLcEveARdOO4Mz+78l7T8g8ksN8nnDSaUg
 YqlocvXieD8nSu7CqlGb9IOyKBjKcQsbjmk0GCDZH9hfadYbO5IOUZAz9+tLtXYArvHRaEGYE
 lfiDcOUBI5y5aleB5zdfiaQYgb3LGRBs8P+sDJ8owqF9eoYnZ1kzsP5OHSrP3MEcGiY85ShRu
 +Z1O/WmO7u6AmxfDAr+IQIiTffq10oH7H4mtjXf4EsELmJlFLL4ynaeGBQFsDoyPf5DS/La6y
 JQ7QDV5wWstaN5vKrp9GSGHr7F8D9OxQcfgQOlQbjOb8CJOiNtZlSwUNHSOAk+TIA/6nMOvzN
 /VkmOFV92+pLg9HaR9YDMHebbRFgSsb+MTbYTVZw9OnwV5rruzsPdD5Cs2mpYbljJzCvNXEwC
 wM5M6Q7rwa3WWMGXlushZ7kRg3tVlFP+CNqKEwRFpucjivj/4ZBF7ok16ZaKcEXO9TWixpgmW
 WrnU/I5MApLVfaVylFwexFDy7aXQUEtaUE3Vu0MlxlaTt6H7Ueai4sgT7p45WG/t9zRAcoyks
 aim2c6dV0aap6KHmnAU4MK9i+TbGTlRhEZ8cE8pPwYnOXICwp+Cn5KezXA9DzGBiJ1yhqUNqH
 oYidBpE90hBAXHzLkoPeNbH7udAE3QU2q+ncO2f9FIBq4NsFOhbhpD456jH9YrYzBLzOULBvt
 vRJ2vLY/OW7nXuGvXliw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/2 =E4=B8=8B=E5=8D=889:37, Anand Jain wrote:
>
>
> It is much simpler to reproduce. I am using two systems with different
> pagesizes to test the subpage readonly support.
>
> On a host with pagesize =3D 4k.
>  =C2=A0 truncate -s 3g 3g.img
>  =C2=A0 mkfs.btrfs ./3g.img
>  =C2=A0 mount -o loop,compress=3Dzstd ./3g.img /btrfs
>  =C2=A0 xfs_io -f -c "pwrite -S 0xab 0 128k" /btrfs/foo
>  =C2=A0 umount /btrfs
>
> Copy the file 3g.img to another host with pagesize =3D 64k.
>  =C2=A0 mount -o ro,loop ./3g.img /btrfs
>  =C2=A0 sha256sum /btrfs/foo
>
>  =C2=A0 leads to Unable to handle kernel NULL pointer dereference

Thanks for the report.

Although in my case, I can't reproduce the crash, but only csum data
mismatch with "csum hole found for disk bytenr range" error message.

Anyway, it should be fixed for compressed read.

I'll investigate the case.

Thanks,
Qu
> ----------------
> [=C2=A0 +0.001387] BTRFS warning (device loop0): csum hole found for dis=
k
> bytenr range [13672448, 13676544)
> [=C2=A0 +0.001514] BTRFS warning (device loop0): csum failed root 5 ino =
257
> off 13697024 csum 0xbcd798f5 expected csum 0xf11c5ebf mirror 1
> [=C2=A0 +0.002301] BTRFS error (device loop0): bdev /dev/loop0 errs: wr =
0, rd
> 0, flush 0, corrupt 1, gen 0
> [=C2=A0 +0.001647] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [=C2=A0 +0.001670] Mem abort info:
> [=C2=A0 +0.000506]=C2=A0=C2=A0 ESR =3D 0x96000005
> [=C2=A0 +0.000471]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32=
 bits
> [=C2=A0 +0.000783]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
> [=C2=A0 +0.000450]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
> [=C2=A0 +0.000462] Data abort info:
> [=C2=A0 +0.000530]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000005
> [=C2=A0 +0.000755]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0
> [=C2=A0 +0.000466] user pgtable: 64k pages, 48-bit VAs, pgdp=3D000000010=
717ce00
> [=C2=A0 +0.001027] [0000000000000000] pgd=3D0000000000000000,
> p4d=3D0000000000000000, pud=3D0000000000000000
> [=C2=A0 +0.001402] Internal error: Oops: 96000005 [#1] PREEMPT SMP
>
> Message from syslogd@aa3 at Feb=C2=A0 2 08:18:05 ...
>  =C2=A0kernel:Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [=C2=A0 +0.000958] Modules linked in: btrfs blake2b_generic xor xor_neon
> zstd_compress raid6_pq crct10dif_ce ip_tables x_tables ipv6
> [=C2=A0 +0.001779] CPU: 25 PID: 5754 Comm: kworker/u64:1 Not tainted
> 5.11.0-rc5+ #10
> [=C2=A0 +0.001122] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [=C2=A0 +0.001286] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> [=C2=A0 +0.001139] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--=
)
> [=C2=A0 +0.001110] pc : __crc32c_le+0x84/0xe8
> [=C2=A0 +0.000726] lr : chksum_digest+0x24/0x40
> [=C2=A0 +0.000731] sp : ffff800017def8f0
> [=C2=A0 +0.000624] x29: ffff800017def8f0 x28: ffff0000c84dca00
> [=C2=A0 +0.000994] x27: ffff0000c44f5400 x26: ffff0000e3a008b0
> [=C2=A0 +0.000985] x25: ffff800011df3948 x24: 0000004000000000
> [=C2=A0 +0.001006] x23: ffff000000000000 x22: ffff800017defa00
> [=C2=A0 +0.000993] x21: 0000000000000004 x20: ffff0000c84dca50
> [=C2=A0 +0.000983] x19: ffff800017defc88 x18: 0000000000000010
> [=C2=A0 +0.000995] x17: 0000000000000000 x16: ffff800009352a98
> [=C2=A0 +0.001008] x15: 000009a9d48628c0 x14: 0000000000000209
> [=C2=A0 +0.000999] x13: 00000000000003d1 x12: 0000000000000001
> [=C2=A0 +0.000986] x11: 0000000000000001 x10: 00000000000009d0
> [=C2=A0 +0.000982] x9 : ffff0000c5418064 x8 : 0000000000000000
> [=C2=A0 +0.001008] x7 : 0000000000000000 x6 : ffff800011f23980
> [=C2=A0 +0.001025] x5 : 00000000006f6964 x4 : ffff8000105dd7a8
> [=C2=A0 +0.000997] x3 : ffff800017defc88 x2 : 0000000000010000
> [=C2=A0 +0.000986] x1 : 0000000000000000 x0 : 00000000ffffffff
> [=C2=A0 +0.001011] Call trace:
> [=C2=A0 +0.000459]=C2=A0 __crc32c_le+0x84/0xe8
> [=C2=A0 +0.000649]=C2=A0 crypto_shash_digest+0x34/0x58
> [=C2=A0 +0.000766]=C2=A0 check_compressed_csum+0xd0/0x2b0 [btrfs]
> [=C2=A0 +0.001011]=C2=A0 end_compressed_bio_read+0xb8/0x308 [btrfs]
> [=C2=A0 +0.001060]=C2=A0 bio_endio+0x12c/0x1d8
> [=C2=A0 +0.000651]=C2=A0 end_workqueue_fn+0x3c/0x60 [btrfs]
> [=C2=A0 +0.000916]=C2=A0 btrfs_work_helper+0xf4/0x5a8 [btrfs]
> [=C2=A0 +0.000934]=C2=A0 process_one_work+0x1ec/0x4c0
> [=C2=A0 +0.000751]=C2=A0 worker_thread+0x48/0x478
> [=C2=A0 +0.000701]=C2=A0 kthread+0x158/0x160
> [=C2=A0 +0.000618]=C2=A0 ret_from_fork+0x10/0x34
> [=C2=A0 +0.000697] Code: 9ac55c08 9ac65d08 1a880000 b4000122 (a8c21023)
> [=C2=A0 +0.001075] ---[ end trace d4f31b4f11a947b7 ]---
> [ +14.775765] note: kworker/u64:1[5754] exited with preempt_count 1
> ------------------------
>
>
> Thanks, Anand
>
>
>
> On 2/2/2021 7:28 PM, Anand Jain wrote:
>>
>>
>> On 2/2/2021 6:23 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/2/2 =E4=B8=8B=E5=8D=885:21, Anand Jain wrote:
>>>>
>>>> Qu,
>>>>
>>>> =C2=A0=C2=A0fstests ran fine on an aarch64 kvm with this patch set.
>>>
>>> Do you mean subpage patchset?
>>>
>>> With 4K sector size?
>>> No way it can run fine...
>>
>> =C2=A0=C2=A0No . fstests ran with sectorsize =3D=3D pagesize =3D=3D 64k=
. These aren't
>> =C2=A0=C2=A0subpage though. I mean just regression checks.
>>
>>> Long enough fsstress can crash the kernel with btrfs_csum_one_bio()
>>> unable to locate the corresponding ordered extent.
>>>
>>>> =C2=A0=C2=A0Further, I was running few hand tests as below, and it fa=
ils
>>>> =C2=A0=C2=A0with - Unable to handle kernel paging.
>>>>
>>>> =C2=A0=C2=A0Test case looks something like..
>>>>
>>>> =C2=A0=C2=A0On x86_64 create btrfs on a file 11g
>>>> =C2=A0=C2=A0copy /usr into /test-mnt stops at enospc
>>>> =C2=A0=C2=A0set compression property on the root sunvol
>>>> =C2=A0=C2=A0run defrag with -czstd
>>>
>>> I don't even consider compression a supported feature for subpage.
>>
>> =C2=A0=C2=A0It should fail the ro mount, which it didn't. Similar test =
case
>> =C2=A0=C2=A0without compression is fine.
>>
>>> Are you really talking about the subpage patchset with 4K sector size,
>>> on 64K page size AArch64?
>>
>> =C2=A0=C2=A0yes readonly mount test case as above.
>>
>> Thanks, Anand
>>
>>
>>> If really so, I appreciate your effort on testing very much, it means
>>> the patchset is doing way better than it is.
>>> But I don't really believe it's even true to pass fstests....
>>
>>
>>
>>> Thanks,
>>> Qu
>>>
>>>> =C2=A0=C2=A0truncate a large file 4gb
>>>> =C2=A0=C2=A0punch holes on it
>>>> =C2=A0=C2=A0truncate couple of smaller files
>>>> =C2=A0=C2=A0unmount
>>>> =C2=A0=C2=A0send file to an aarch64 (64k pagesize) kvm
>>>> =C2=A0=C2=A0mount -o ro
>>>> =C2=A0=C2=A0run sha256sum on all the files
>>>>
>>>> ---------------------
>>>> [37012.027764] BTRFS warning (device loop0): csum failed root 5 ino 6=
11
>>>> off 228659200 csum 0x1dcefc2d expected csum 0x69412d2a mirror 1
>>>> [37012.030971] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0=
,
>>>> rd 0, flush 0, corrupt 9, gen 0
>>>> [37012.036223] BTRFS warning (device loop0): csum failed root 5 ino 6=
16
>>>> off 228724736 csum 0x73f63661 expected csum 0xaf922a6f mirror 1
>>>> [37012.036250] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0=
,
>>>> rd 0, flush 0, corrupt 10, gen 0
>>>> [37012.123917] Unable to handle kernel paging request at virtual
>>>> address
>>>> 0061d1f66c080000
>>>> [37012.126104] Mem abort info:
>>>> [37012.126951]=C2=A0=C2=A0 ESR =3D 0x96000004
>>>> [37012.127791]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32 =
bits
>>>> [37012.129207]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
>>>> [37012.130043]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
>>>> [37012.131269] Data abort info:
>>>> [37012.132165]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000004
>>>> [37012.133211]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0
>>>> [37012.134014] [0061d1f66c080000] address between user and kernel
>>>> address ranges
>>>> [37012.136050] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>>> [37012.137567] Modules linked in: btrfs blake2b_generic xor xor_neon
>>>> zstd_compress raid6_pq crct10dif_ce ip_tables x_tables ipv6
>>>> [37012.140742] CPU: 0 PID: 289001 Comm: kworker/u64:3 Not tainted
>>>> 5.11.0-rc5+ #10
>>>> [37012.142839] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
>>>> 02/06/2015
>>>> [37012.144787] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
>>>> [37012.146474] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--)
>>>> [37012.148175] pc : __crc32c_le+0x84/0xe8
>>>> [37012.149266] lr : chksum_digest+0x24/0x40
>>>> [37012.150420] sp : ffff80001638f8f0
>>>> [37012.151491] x29: ffff80001638f8f0 x28: ffff0000c7bb0000
>>>> [37012.152982] x27: ffff0000d1a27000 x26: ffff0002f21b56e0
>>>> [37012.154565] x25: ffff800011df3948 x24: 0000004000000000
>>>> [37012.156063] x23: ffff000000000000 x22: ffff80001638fa00
>>>> [37012.157570] x21: 0000000000000004 x20: ffff0000c7bb0050
>>>> [37012.159145] x19: ffff80001638fc88 x18: 0000000000000000
>>>> [37012.160684] x17: 0000000000000000 x16: 0000000000000000
>>>> [37012.162190] x15: 0000051d5454c764 x14: 000000000000017a
>>>> [37012.163774] x13: 0000000000000145 x12: 0000000000000001
>>>> [37012.165282] x11: 0000000000000000 x10: 00000000000009d0
>>>> [37012.166849] x9 : ffff0000ca305564 x8 : 0000000000000000
>>>> [37012.168395] x7 : 0000000000000000 x6 : ffff800011f23980
>>>> [37012.169883] x5 : 00000000006f6964 x4 : ffff8000105dd7a8
>>>> [37012.171476] x3 : ffff80001638fc88 x2 : 0000000000010000
>>>> [37012.172997] x1 : bc61d1f66c080000 x0 : 00000000ffffffff
>>>> [37012.174642] Call trace:
>>>> [37012.175427]=C2=A0 __crc32c_le+0x84/0xe8
>>>> [37012.176419]=C2=A0 crypto_shash_digest+0x34/0x58
>>>> [37012.177616]=C2=A0 check_compressed_csum+0xd0/0x2b0 [btrfs]
>>>> [37012.179160]=C2=A0 end_compressed_bio_read+0xb8/0x308 [btrfs]
>>>> [37012.180731]=C2=A0 bio_endio+0x12c/0x1d8
>>>> [37012.181712]=C2=A0 end_workqueue_fn+0x3c/0x60 [btrfs]
>>>> [37012.183161]=C2=A0 btrfs_work_helper+0xf4/0x5a8 [btrfs]
>>>> [37012.184570]=C2=A0 process_one_work+0x1ec/0x4c0
>>>> [37012.185727]=C2=A0 worker_thread+0x48/0x478
>>>> [37012.186823]=C2=A0 kthread+0x158/0x160
>>>> [37012.187768]=C2=A0 ret_from_fork+0x10/0x34
>>>> [37012.188791] Code: 9ac55c08 9ac65d08 1a880000 b4000122 (a8c21023)
>>>> [37012.190486] ---[ end trace 4f73e813d058b84c ]---
>>>> [37019.180684] note: kworker/u64:3[289001] exited with preempt_count =
1
>>>> ---------------
>>>>
>>>> =C2=A0=C2=A0Could you please take a look?
>>>>
>>>> Thanks, Anand
>

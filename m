Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9C3B8BCE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 03:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhGABoi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 21:44:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:48235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237836AbhGABoh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 21:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625103652;
        bh=Cxk8KNcL/qgXExsLULTR9VaLFCFHRntBwV7V+qG353s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AcynJLP4Dux8bXQztsCAHb67a+3WB8pt13emToJ50ZqMjpGnitgJsCK/R/yS6V7ZZ
         U8+uxzOJQBDOMUKZGvvQSirGnFQLcqYfFUv1Ho66GDrTsNTDCpFUFXWOflhSlbSJZ7
         1ZOzRZXSB2xLj2Z6x5waoVn9D6ys30Lrq4mW4WTg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDEm-1lYXgJ10F6-00iD6j; Thu, 01
 Jul 2021 03:40:51 +0200
Subject: Re: IO failure without other (device) error
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4e6c3598-92b4-30d6-3df8-6b70badbd893@gmx.com>
Date:   Thu, 1 Jul 2021 09:40:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pLYPYBlNbAJeqQG224mQ/6x9uhMQnDr4zKrihPJeXGzxJY0KqhX
 TaAt+7GHVE9uuW1HdEAO6piGiY2PSIo7WsJfCqksZphQ523jiFBblvbMmcS9V2fFT+p4hwD
 4NEoVCyXTPHOI/UWQaNDW1IPFW5NZ5DbfCZRQyB1/ibxr5fh8RbZqPh7Hxh1XlEUC96ZGbf
 LXyl1IZLXDbaC4xvcFFqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rqUA4eQNsRw=:ZZRluABZ/niwffeV2NBsNY
 qmSYojtSzhoXACZyztyoOxWYCnJwzfFwb6Pb2PQNLD4GdpgHNbTBoyogW45a1TX0HJ4LjNER0
 GZJnRRwXTR7yv/2extsV8MdnO6N9N81U5m4pScjyksT96godzIJjgb6qCoHqmLUxcB7Z2iVtx
 1GuI4b1O8Qxin3wnDKXyFa+CuYKLEvbjyAW4+QZ6nrl4Ta+E3+fnDYJi/cAaQSk7N+rTTiZ1n
 CRwJoEJ86O6RgTTMKO8hBuNwxHzeSk1wlixPbYS67tEf1aXQuVHbH2b7dYJrYTcXvWD87m1TJ
 9xskDhcMf0GBcug+sVnAGlLXY298skhaSN8VMrbBC1Eq5u4xWRCjn9rCoVV5ZRMLzz+6e6aw7
 DkVLTSoSKhZcT046lq7bMZYyRLjsvo33OYEia00VZE9cpi3soXkGdD4q7gy9dED9Gmd7TCywo
 ZpRGsTpjN+ZyGt9i0aR3SsI+xjgmzmrA4wkK4RHQOfaKl2afEx889or3/wF/WsvJ6Pp2G0oC4
 R+BqIYGBsKL0WWzQuJ0EO/Tr9xgmg6/sj043spLKyQS/VLDkm4u+vaJmp6AZixEcQXwM3zEiw
 yOH8/36khCOrUDAY7FnUnfs/TBZJNBRf7ZY+zFGMH88xaoUc+TL1OVeahO4ocyzWZDOm1kX0v
 eZzkyfFfBUXt7JA5ovsValW1J6/EbU+b08BDfc+2IQSH+/Zke+fGZn4ouRhBJg/o4uY1604kJ
 DfpoyMU2miNvMk/uWr0d1rVJKkl/HH/pO3lg92m+V3HJu8Po1fT45nt9NMUPzamCvxFcR/avu
 aKehKTIMxc3tQLKfx8SmXbjw/xVAspCJH5YMpo+eMkxPGy83PDURxlk2Ws14VmjDsv7L0mPuU
 /5gOTZ/jmiTq0MYOscUYfESI3fnCV7WZnY1GXFcOfdDOBC2RQ5Hochjs+Z9Am+EaqizhRmOcd
 KkUs0IJM8cMmojhWYyQr2hxyIfdtFZd28ipAzkfB/swTM001s9ICVDT8VNI0EVtkVilMA1XCe
 QAu0oUPP91XZE4tqecRzOV4PGT6AST80mec2/zwtn593Eb/Hr5hlMgnWRxR0Ef/8O4Bgz8DIY
 jisWwrgo6ONlLatJjyBfeoUSwJYG1T6dDmTFZE+cZDcl04L7hmGMFmKXA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/1 =E4=B8=8A=E5=8D=882:40, Martin Raiber wrote:
> On 18.06.2021 18:18 Martin Raiber wrote:
>> On 10.05.2021 00:14 Martin Raiber wrote:
>>> I get this (rare) issue where btrfs reports an IO error in run_delayed=
_refs or finish_ordered_io with no underlying device errors being reported=
. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix or =
work-arounds for btrfs ENOSPC issues:
>>>
>>> [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc/i=
nit.d/exim4' lacks a native systemd unit file. Automatically generating a =
unit file for compatibility. Please update package to include a native sys=
temd unit file, in order to make it more safe and robust.
>>> [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_io=
:2736: errno=3D-5 IO failure
>>> [2260628.156980] BTRFS info (device dm-0): forced readonly
>>>
>>> This issue occured on two different machines now (on one twice). Both =
with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (wh=
ere dm-0 is a ceph volume).
>> Just got it again (5.10.43). So I guess the question is how can I trace=
 where this error comes from... The error message points at btrfs_csum_fil=
e_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at each l=
ocation?
>>
> Added the WARN_ON -EIOs. And hit it. It points at read_extent_buffer_pag=
es (this time), this part before unlock_exit:

Well, this is quite different from your initial report.

Your initial report is EIO in btrfs_finish_ordered_io(), which happens
after all data is written back to disk.

But in this particular case, it happens before we submit the data to disk.

In this case, we search csum tree first, to find the csum for the range
we want to read, before submit the read bio.

Thus they are at completely different path.

>
>  =C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++) {
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 page =3D eb->pages[i];
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 wait_on_page_locked(page);
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!PageUptodate(page))
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 -->ret =3D -EI=
O;
>  =C2=A0=C2=A0=C2=A0 }
>
> Complete dmesg output. In this instance it seems to not be able to read =
a csum. It doesn't go read only in this case... Maybe it should?
>
> [Wed Jun 30 10:31:11 2021] systemd[1]: Started Journal Service.
> [Wed Jun 30 10:43:22 2021] ------------[ cut here ]------------
> [Wed Jun 30 10:43:22 2021] WARNING: CPU: 13 PID: 3965190 at fs/btrfs/ext=
ent_io.c:5597 read_extent_buffer_pages+0x346/0x360
> [Wed Jun 30 10:43:22 2021] Modules linked in: zram bcache crc64 loop dm_=
crypt bfq xfs dm_mod st sr_mod cdrom bridge stp llc intel_powerclamp coret=
emp kvm_intel snd_pcm mgag200 snd_timer kvm snd drm_kms_helper iTCO_wdt so=
undcore dcdbas irqbypass serio_raw pcspkr joydev iTCO_vendor_support evdev=
 i2c_algo_bit i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi acpi=
_power_meter button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi=
_tcp libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables autofs4=
 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx=
 raid0 multipath linear raid1 md_mod ses enclosure sd_mod hid_generic usbh=
id hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesn=
i_intel crypto_simd ahci cryptd glue_helper libahci uhci_hcd ehci_pci psmo=
use mpt3sas ehci_hcd raid_class lpc_ich libata nvme scsi_transport_sas mfd=
_core nvme_core usbcore t10_pi scsi_mod bnx2
> [Wed Jun 30 10:43:22 2021] CPU: 13 PID: 3965190 Comm: io_wqe_worker-0 Ta=
inted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.10.44 #1
> [Wed Jun 30 10:43:22 2021] Hardware name: Dell Inc. PowerEdge R510/0DPRK=
F, BIOS 1.13.0 03/02/2018
> [Wed Jun 30 10:43:22 2021] RIP: 0010:read_extent_buffer_pages+0x346/0x36=
0
> [Wed Jun 30 10:43:22 2021] Code: 48 8b 43 08 a8 01 48 8d 78 ff 48 0f 44 =
fb 31 f6 e8 8f d5 db ff 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da 48 8b 03=
 a8 04 75 ab <0f> 0b 41 be fb ff ff ff eb a1 e8 5b a2 56 00 66 66 2e 0f 1f=
 84 00
> [Wed Jun 30 10:43:22 2021] RSP: 0018:ffffc900215ab5f0 EFLAGS: 00010246
> [Wed Jun 30 10:43:22 2021] RAX: 06ffff80000020a3 RBX: ffffea0008a1b680 R=
CX: 0000000000000000
> [Wed Jun 30 10:43:22 2021] RDX: dead0000000000ff RSI: ffffc900215ab588 R=
DI: ffffffff82208780
> [Wed Jun 30 10:43:22 2021] RBP: ffff88844c924d68 R08: 000000000000000d R=
09: 00000000000003bb
> [Wed Jun 30 10:43:22 2021] R10: 0000000000000001 R11: 0000000000000000 R=
12: ffff88844c924e10
> [Wed Jun 30 10:43:22 2021] R13: ffffea00091094c0 R14: 0000000000000000 R=
15: ffff88844c924e10
> [Wed Jun 30 10:43:22 2021] FS:=C2=A0 0000000000000000(0000) GS:ffff88871=
3b80000(0000) knlGS:0000000000000000
> [Wed Jun 30 10:43:22 2021] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
> [Wed Jun 30 10:43:22 2021] CR2: 00007f4c7a7fb00a CR3: 000000012f1ba003 C=
R4: 00000000000206e0
> [Wed Jun 30 10:43:22 2021] Call Trace:
> [Wed Jun 30 10:43:22 2021]=C2=A0 btree_read_extent_buffer_pages+0x9f/0x1=
10
> [Wed Jun 30 10:43:22 2021]=C2=A0 read_tree_block+0x36/0x60
> [Wed Jun 30 10:43:22 2021]=C2=A0 read_block_for_search.isra.0+0x1ab/0x36=
0
> [Wed Jun 30 10:43:22 2021]=C2=A0 btrfs_search_slot+0x232/0x970
> [Wed Jun 30 10:43:22 2021]=C2=A0 btrfs_lookup_csum+0x75/0x170
> [Wed Jun 30 10:43:22 2021]=C2=A0 btrfs_lookup_bio_sums+0x23a/0x620
> [Wed Jun 30 10:43:22 2021]=C2=A0 btrfs_submit_compressed_read+0x44f/0x4e=
0
> [Wed Jun 30 10:43:22 2021]=C2=A0 btrfs_submit_data_bio+0x170/0x180
> [Wed Jun 30 10:43:22 2021]=C2=A0 submit_one_bio+0x44/0x70
> [Wed Jun 30 10:43:22 2021]=C2=A0 extent_readahead+0x374/0x3a0
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? xas_load+0x5/0x70
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? xa_get_order+0x93/0xd0
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? __mod_memcg_lruvec_state+0x21/0xe0
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? __add_to_page_cache_locked+0x19d/0x3f=
0
> [Wed Jun 30 10:43:22 2021]=C2=A0 read_pages+0x83/0x1e0
> [Wed Jun 30 10:43:22 2021]=C2=A0 page_cache_ra_unbounded+0x1aa/0x1f0
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? find_get_entry+0xd5/0x140
> [Wed Jun 30 10:43:22 2021]=C2=A0 force_page_cache_ra+0xdc/0x140
> [Wed Jun 30 10:43:22 2021]=C2=A0 generic_file_buffered_read+0x5d9/0x8e0
> [Wed Jun 30 10:43:22 2021]=C2=A0 btrfs_file_read_iter+0x38/0xc0
> [Wed Jun 30 10:43:22 2021]=C2=A0 generic_file_splice_read+0xfc/0x1b0
> [Wed Jun 30 10:43:22 2021]=C2=A0 do_splice+0x670/0x720
> [Wed Jun 30 10:43:22 2021]=C2=A0 io_issue_sqe+0xde7/0xfa0
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? pick_next_task_fair+0x32/0x380
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? __switch_to+0x7b/0x3d0
> [Wed Jun 30 10:43:22 2021]=C2=A0 io_wq_submit_work+0x50/0x1a0
> [Wed Jun 30 10:43:22 2021]=C2=A0 io_worker_handle_work+0x1a1/0x570
> [Wed Jun 30 10:43:22 2021]=C2=A0 io_wqe_worker+0x2c1/0x360
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? io_worker_handle_work+0x570/0x570
> [Wed Jun 30 10:43:22 2021]=C2=A0 kthread+0x11b/0x140
> [Wed Jun 30 10:43:22 2021]=C2=A0 ? __kthread_bind_mask+0x60/0x60
> [Wed Jun 30 10:43:22 2021]=C2=A0 ret_from_fork+0x1f/0x30
> [Wed Jun 30 10:43:22 2021] ---[ end trace 32a38f7d02f704b2 ]---
> [Wed Jun 30 10:43:22 2021] BTRFS info (device dm-0): no csum found for i=
node 23468615 start 10428416
> [Wed Jun 30 10:43:22 2021] BTRFS warning (device dm-0): csum failed root=
 1571 ino 23468615 off 586692173824 csum 0xc0a0c537 expected csum 0x000000=
00 mirror 1

For this particular case, btrfs first can't find the csum for the range
of read, and just left the csum as all zeros and continue.

Then the data read from disk will definitely cause a csum mismatch.

This normally means a csum tree corruption.

Can you run btrfs-check on that fs?

Thanks,
Qu
> [Wed Jun 30 10:43:22 2021] BTRFS error (device dm-0): bdev /dev/mapper/L=
UKS-RC-75aba4438f084377be2fc6d7d1f8eba0 errs: wr 0, rd 0, flush 0, corrupt=
 2, gen 0
>

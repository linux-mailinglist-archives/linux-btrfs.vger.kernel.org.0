Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B505D3F93F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 07:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhH0FF4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 01:05:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:49337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhH0FF4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 01:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630040700;
        bh=jjt+WkYhqc4wuSLPwB2pnnl8DOhbMtlHwqSBnNJAoNs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ha5fi8sb1ucrd1RBOhFi4Ee5IVTmFXHnAetujLuXzNgYdQ6wPgOpoNyJHv9cMy7EC
         wZdCoE3boUOyC6BGY96R+12vxax6ifP4fWf+Z9Td0l3bVrHdVDgsH9I7x9SP6jDmdD
         D9PWJtehiPST0PSyCipC9rYLYwC4NXYlTeYqvAlI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDywo-1mBko31ZAq-009tvS; Fri, 27
 Aug 2021 07:05:00 +0200
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we
 don't have enough pages"
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210825054142.11579-1-wqu@suse.com>
 <20210827114153.19CB.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <025d8f85-a86c-63be-14be-a3f1e2170107@gmx.com>
Date:   Fri, 27 Aug 2021 13:04:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827114153.19CB.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dp/Z45Ph7pZFSFhbrL1kcFoCuRCE1xiuev+gdi7aazgqXybSE6b
 WfvPIAZmRPpLDAAV5ERCI+dEZa52ieJsCjyyDFbk+Z2zWofLG0CUmvDNSeAUlrq6EHq9bi3
 VOKE/+nSzbW+NrCCgmi2H3DouXWAslTuKKaDpvja+N+LltL+kAuw/UvlRKHEwClnMdcPGDo
 KgI+X+IvZxQB0RdCOdSCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1D5CO38S5os=:Lxsidn1gyiqPT9alAFX6rA
 9yYqJ1xTjobYDpkHM/B3Ow2bGddS2GYWJzg8SZ4N2PIsS6rP1qEgS+YfI35S9KowBmC/T5kob
 Pv8C5iah43XgRjTy2as469EJewY+n4UbadI/4fcFtNmvZppjz/nHshrQzigIlaEOTZSpkqJvT
 y9bekXC6ret/cUQ2tUEmYC5EmrRxzqLatojCZt1y5ifxMZ7swe+QX027Le6oZVR0060j8d7yG
 v3EuaPn1kOOwx2J4sO2lFe19cQvvruLan4KVgdNv5eSgat51gbj8itdKhW1+aKtVmtoSYrI5m
 Bkrs1kuoc/ocgZPJ7rLnrC9WQXpzN7vhIFhrktf1GQdGSbvfMCygp5i4wXIjVZIvm1PjmHuHJ
 rYl/CEbUNmhHYuhoxcyK55MAYdU//FFUKV4UIwxxjOW9sL5iREtPmhXyRcFBUAMAUrZCw6ii9
 tDB7fMvpG5b9MyEflaS+AuXmsIS6CjvqqW93mxQZHMBLmsaZ4KHCM3Hx+ZLEMMkv8nSfiKouJ
 zrxUUToCx88JLPKpmUD7UJGNTfAcHhcMzDZK3spU41IVAknG7HK8veiR5QpvnKCB02K5pIup3
 tV8fxCtrADLPNBnwUezrtzsxfrP9KfRvgX4nZ2DrN0q8wJTOKFPU4bbCvc41+/pIB8EedbcTi
 xfsQ9ffGrmH0Rp62XPuUyOrUpxlGMu2btqskeD9fEMAUGjSfX2xMEPu0qKtMUcTc5ar33alzq
 WN2FtatUBWMD7pGBOp/glFslzntZVrVLh9DlqfkB7VHiJufYFK1q8iR9x6hYypGOveEReVqgH
 /0ZekjDqZ9feV9a+ydW5iaMradVN6v8c9f3m1PPRTbNcJO44MYjSURJ0mrxkRG+5n5uHdgx2k
 smGRW2nGAoUU9I0vvLPRJaYznLj8kWBzQ0eJ5jc7Qbyx5J9BX9hiQwRnpdJdorVH1papt0VJz
 qCM38vtoo3iV+SQifOEQMGWNbmi9uTBxngcX3QO4U13/uu5Ta/Ta3ObrDoeK61pfUWk2oFnEs
 kK0bkiJXQg3T4gQpek8abOQTod2oThSccz6TSf3cv9wkW/Jor/QUjgrp67sLJT4mp3kSCmI3A
 DwlKG8N0D4qDRH1D+zfC7WtjxnZCUVJx/xcaXtXnWatLN8A4cW1nRdUzQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/27 =E4=B8=8A=E5=8D=8811:41, Wang Yugui wrote:
> Hi,
>
> With this patch, kernel panic when xfstest btrfs/244

It's completely unrelated.

The fix for btrfs/244 is beadb3347de2 ("btrfs: fix NULL pointer
dereference when deleting device by invalid id").

Thanks,
Qu
>
> #btrfs version: 5.13.x (with some patches from 5.14), although shown as =
5.10.61.
>
> [  131.802619] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [  131.810837] #PF: supervisor read access in kernel mode
> [  131.817026] #PF: error_code(0x0000) - not-present page
> [  131.823240] PGD 0 P4D 0
> [  131.826521] Oops: 0000 [#1] SMP NOPTI
> [  131.831029] CPU: 37 PID: 4434 Comm: btrfs Not tainted 5.10.61-1.el7.x=
86_64 #1
> [  131.839478] Hardware name: Dell Inc. PowerEdge T620/02CD1V, BIOS 2.9.=
0 12/06/2019
> [  131.848315] RIP: 0010:btrfs_rm_device+0x248/0x4f0 [btrfs]
> [  131.854805] Code: 8b 45 30 48 89 df 48 83 40 48 01 e8 92 cb 14 ea e9 =
e2 fe ff ff b9 08 00 00 00 48 c7 c7 f7
>   9a a4 c0 4c 89 e6 41 bf 06 00 00 00 <f3> a6 0f 97 c0 1c 00 84 c0 0f 84=
 be fe ff ff e9 b6 fe ff ff 48 89
> [  131.876730] RSP: 0018:ffff9ff54e01fd80 EFLAGS: 00010246
> [  131.883000] RAX: fffffffffffffffe RBX: ffff8c0b0a8cd000 RCX: 00000000=
00000008
> [  131.891463] RDX: fffffffffffffffe RSI: 0000000000000000 RDI: ffffffff=
c0a49af7
> [  131.899854] RBP: fffffffffffffffe R08: ffff8c0d4872f400 R09: 00000000=
00001000
> [  131.908262] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
> [  131.916686] R13: 0000000000000003 R14: ffff8c0d4872f400 R15: 00000000=
00000006
> [  131.925070] FS:  00007ffa0f6029c0(0000) GS:ffff8c1abfc80000(0000) knl=
GS:0000000000000000
> [  131.934608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  131.941449] CR2: 0000000000000000 CR3: 0000002179c4e001 CR4: 00000000=
001706e0
> [  131.949883] Call Trace:
> [  131.953090]  ? __check_object_size+0x162/0x180
> [  131.958593]  btrfs_ioctl+0x1870/0x2fd0 [btrfs]
> [  131.963997]  ? do_fault+0x22e/0x490
> [  131.968370]  ? __handle_mm_fault+0x5e8/0x7c0
> [  131.973582]  ? __x64_sys_ioctl+0x84/0xc0
> [  131.978370]  __x64_sys_ioctl+0x84/0xc0
> [  131.982999]  do_syscall_64+0x33/0x40
> [  131.987445]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  131.993511] RIP: 0033:0x7ffa0e16762b
> [  131.997925] Code: 0f 1e fa 48 8b 05 5d b8 2c 00 64 c7 00 26 00 00 00 =
48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00
>   00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b=
 0d 2d b8 2c 00 f7 d8 64 89 01 48
> [  132.019844] RSP: 002b:00007ffe18adeeb8 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000010
> [  132.028777] RAX: ffffffffffffffda RBX: 00007ffe18ae1070 RCX: 00007ffa=
0e16762b
> [  132.037222] RDX: 00007ffe18adfee0 RSI: 000000005000943a RDI: 00000000=
00000003
> [  132.045715] RBP: 00007ffe18adfee0 R08: 00007ffe18ae3221 R09: 00000000=
00000000
> [  132.054134] R10: 00007ffa0e1e51e0 R11: 0000000000000246 R12: 00000000=
00000001
> [  132.062617] R13: 0000000000000000 R14: 0000000000000003 R15: 00007ffe=
18ae1078
> [  132.071037] Modules linked in: dm_flakey rpcsec_gss_krb5 nfsv4 dns_re=
solver nfs fscache rfkill iTCO_wdt int
> el_pmc_bxt intel_rapl_msr iTCO_vendor_support dcdbas intel_rapl_common s=
b_edac x86_pkg_temp_thermal intel_powe
> rclamp coretemp ipmi_ssif kvm_intel kvm irqbypass rapl intel_cstate ipmi=
_si mei_me ipmi_devintf intel_uncore j
> oydev ipmi_msghandler mei lpc_ich acpi_power_meter nvme_rdma nvme_fabric=
s rdma_cm iw_cm ib_cm rdmavt nfsd rdma
> _rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core auth_rpcgss nfs_acl loc=
kd grace nfs_ssc ip_tables xfs mgag200
>   drm_kms_helper btrfs cec crct10dif_pclmul crc32_pclmul crc32c_intel xo=
r raid6_pq drm bnx2x nvme mpt3sas ghash
> _clmulni_intel igb pcspkr mdio megaraid_sas nvme_core raid_class dca i2c=
_algo_bit scsi_transport_sas wmi dm_mu
> ltipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sunrpc i2c_dev
> [  132.155588] CR2: 0000000000000000
> [  132.159878] ---[ end trace 5ad61f759e33fdff ]---
> [  132.169659] RIP: 0010:btrfs_rm_device+0x248/0x4f0 [btrfs]
> [  132.176237] Code: 8b 45 30 48 89 df 48 83 40 48 01 e8 92 cb 14 ea e9 =
e2 fe ff ff b9 08 00 00 00 48 c7 c7 f7
>   9a a4 c0 4c 89 e6 41 bf 06 00 00 00 <f3> a6 0f 97 c0 1c 00 84 c0 0f 84=
 be fe ff ff e9 b6 fe ff ff 48 89
> [  132.198409] RSP: 0018:ffff9ff54e01fd80 EFLAGS: 00010246
> [  132.204856] RAX: fffffffffffffffe RBX: ffff8c0b0a8cd000 RCX: 00000000=
00000008
> [  132.213467] RDX: fffffffffffffffe RSI: 0000000000000000 RDI: ffffffff=
c0a49af7
> [  132.222039] RBP: fffffffffffffffe R08: ffff8c0d4872f400 R09: 00000000=
00001000
> [  132.230657] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
> [  132.239222] R13: 0000000000000003 R14: ffff8c0d4872f400 R15: 00000000=
00000006
> [  132.247813] FS:  00007ffa0f6029c0(0000) GS:ffff8c1abfc80000(0000) knl=
GS:0000000000000000
> [  132.257461] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  132.264459] CR2: 0000000000000000 CR3: 0000002179c4e001 CR4: 00000000=
001706e0
> [  132.273009] Kernel panic - not syncing: Fatal exception
> [  132.447157] Kernel Offset: 0x29000000 from 0xffffffff81000000 (reloca=
tion range: 0xffffffff80000000-0xfffff
> fffbfffffff)
> [  132.462761] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/08/27
>
>> This reverts commit f2165627319ffd33a6217275e5690b1ab5c45763.
>>
>> [BUG]
>> It's no longer possible to create compressed inline extent after commit
>> f2165627319f ("btrfs: compression: don't try to compress if we don't
>> have enough pages").
>>
>> [CAUSE]
>> For compression code, there are several possible reasons we have a rang=
e
>> that needs to be compressed while it's no more than one page.
>>
>> - Compressed inline write
>>    The data is always smaller than one sector.
>>
>> - Compressed subpage write
>>    For the incoming subpage compressed write support, we require page
>>    alignment of the delalloc range.
>>    And for 64K page size, we can compress just one page into smaller
>>    sectors.
>>
>> For those reasons, the requirement for the data to be more than one pag=
e
>> is not correct, and is already causing regression for compressed inline
>> data writeback.
>>
>> [FIX]
>> Fix it by reverting the offending commit.
>>
>> Fixes: f2165627319f ("btrfs: compression: don't try to compress if we d=
on't have enough pages")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 2aa9646bce56..2b7fe98adec2 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -632,7 +632,7 @@ static noinline int compress_file_range(struct asyn=
c_chunk *async_chunk)
>>   	 * inode has not been flagged as nocompress.  This flag can
>>   	 * change at any time if we discover bad compression ratios.
>>   	 */
>> -	if (nr_pages > 1 && inode_need_compress(BTRFS_I(inode), start, end)) =
{
>> +	if (inode_need_compress(BTRFS_I(inode), start, end)) {
>>   		WARN_ON(pages);
>>   		pages =3D kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
>>   		if (!pages) {
>> --
>> 2.32.0
>
>

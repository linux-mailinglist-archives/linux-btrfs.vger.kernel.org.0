Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B573BB479
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 02:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGEAPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 20:15:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:36431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhGEAPS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 20:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625443958;
        bh=4ui9OYI6z8yk+NYKF1PU62ZAK/PLQqpRsnn1RBYj7R8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FxGU2bA9eyitqKmMPUSMilHCatzh6QkrIyO0viBLPxBeydROWG0PijxebgHiG7AJN
         e7ZyZilr8/BJmI3xvHlwQWYcc0wDk5SiOu48GMUnvtowI0HDLLiZoskgOEMefqcf/O
         5WxLOIa7AdFVaI6QcrK2eaLsHG2Ud3JyEawPch30=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtfNl-1lCTms2csp-00v5OB; Mon, 05
 Jul 2021 02:12:38 +0200
Subject: Re: [PATCH] btrfs: check for missing device in btrfs_trim_fs
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9786b027-e380-6286-4ec9-e28d7c6d46f1@gmx.com>
Date:   Mon, 5 Jul 2021 08:12:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qRB5fjenzgpZM7SS2sm7fmAi1A1yaAgAc1P2cMOHwFLzmOElzsm
 TLvLOktJiRRrt3vmr3w3wE/lPsj5mfzwAmfpuXlwk89SvrGxDT3T/Um51WVwAfLgvNKqs5Y
 uVoh4Xq3oXMpBXPaXRXZqf4//NQvGKfZzFsSQCjhfjPUPyxednEC/4y3nYJEu+IOajqi/Ip
 7na6AczgwLoOAjbl53Igg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OnWpqo1UbYY=:/XCUTfaHw8IKAHtvuIghWZ
 xp3sw7us7UDANBSB7dnf0xHzqSzk0ZSy1X47KTUudMw1d6/S2wHsefRT7pm5X6SHn7jqfwPZa
 CrIlSCfkPvJGHutgWzbFwn0L+HYjHLoxwvt+hM2lxSc0kNVdZ+zcmLFSIWgbpX2RFH8iG01U1
 SuHFsFi++UJ6dsuyfECNM6rW0XOUf+f6KnGolouuK1Tvqj4u9nttX27PE7t6UqdqD1kGi5EmH
 UqiWtDrs/PcgD5nSYZDzJLIBo7gOV7YcAmqsYrccPTk5gbrAg5eDJoTndzoTHAsIb0oSuNMhk
 kT1IOorqfUna31tYvpCkm4vjO2ECPp4NTwh/Ag4MCa6U17P0fw2D2Hb3AMWfHOKy5pmhTo3Pl
 GL6kzxyfMHEfSgCMBzDrjvwC89sbU3sUYjGBE3j2sGI9zoSgqtjwMTqYHF3drw8lpzHtH4kAT
 HTRJPIstoOU3uMoS1JEd9/QlZF444fze9S3Rwgp0xN9FwCQztzAxN7g6SdbeJCXaUXD4dNyif
 gGzWhVU8V6n9hFR2tz4KJHVxQOsUccwn8LOFMdgDwkyvU/R0ggV0NssTP4FBnDkzLQ8+fcV6F
 iB9Z3oX7UbpB6flqFD36MGW1aawpo0NiGIQw5BSleWOqMM0MFe6+Jb0tQtGaQPMWp9Ysh3EY/
 u50SJFN0/jedmhMJHF8xqduWawzEDZzHwUrALIQn3tpJuUQhsfyrkYG9Fe7u4CokyzkEepAHa
 kW96ZCbH8A1uNyZ7zi7ps9UwzMmZx8/lyFQ+Z7dADQdFSd2WQFuWDhbI1Co9Uvjomx+B6CY0Y
 slc6NQk3vcQrUUpWdeCes3E/TxtS2PUVnHiruet+BG+o+ITLYJJMd9CK4UyVvDA2kgKpSPHPO
 L0aXi8+56DuQwz/9i969TM5PdTIxM88pLfqKFgk2sU6Ne5UtpNpWMQqsxKFolBImGvVLIV5zq
 WmoMwG/3QwekVt1mDd6BI+T6O+cqeOofDHLGz3MH0nITYPR5umUFyPeHbDFVjoiBvvY2wstZZ
 IDkzggGHyNAWgGndESJ42Xs8Wt5nSxKMJBgT2UwTvZD4zdLAdJhIEQG2aEAponklsqv7YYiRm
 n7I9CfK8g9VRxDBNFrK1hdzAhIOyIRMxFHDlVeUQdsRh3mA9BktehtYNQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/4 =E4=B8=8B=E5=8D=887:14, Anand Jain wrote:
> A fstrim on a degraded raid1 can trigger the following null pointer
> dereference:
>
> BTRFS info (device loop0): allowing degraded mounts
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS info (device loop0): has skinny extents
> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489=
b424adb is missing
> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489=
b424adb is missing
> BTRFS info (device loop0): enabling ssd optimizations
> BUG: kernel NULL pointer dereference, address: 0000000000000620
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 0 PID: 4574 Comm: fstrim Not tainted 5.13.0-rc7+ #31
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01=
/2006
> RIP: 0010:btrfs_trim_fs+0x199/0x4a0 [btrfs]
> Code: 24 10 65 4c 8b 34 25 00 70 01 00 48 c7 44 24 38 00 00 10 00 48 8b =
45 50 48 c7 44 24 40 00 00 00 00 48 c7 44 24 30 00 00 00 00 <48> 8b 80 20 =
06 00 00 48 8b 80 90 00 00 00 48 8b 40 68 f6 c4 01 0f
> RSP: 0018:ffff959541797d28 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff946f84eca508 RCX: a7a67937adff8608
> RDX: ffff946e8122d000 RSI: 0000000000000000 RDI: ffffffffc02fdbf0
> RBP: ffff946ea4615000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: ffff946e8122d960 R12: 0000000000000000
> R13: ffff959541797db8 R14: ffff946e8122d000 R15: ffff959541797db8
> FS:  00007f55917a5080(0000) GS:ffff946f9bc00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000620 CR3: 000000002d2c8001 CR4: 00000000000706f0
> Call Trace:
> btrfs_ioctl_fitrim+0x167/0x260 [btrfs]
> btrfs_ioctl+0x1c00/0x2fe0 [btrfs]
> ? selinux_file_ioctl+0x140/0x240
> ? syscall_trace_enter.constprop.0+0x188/0x240
> ? __x64_sys_ioctl+0x83/0xb0
> __x64_sys_ioctl+0x83/0xb0
> do_syscall_64+0x40/0x80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Reproducer:
>
>    Create raid1 btrfs:
> 	mkfs.btrfs -fq -draid1 -mraid1 /dev/loop0 /dev/loop1
> 	mount /dev/loop0 /btrfs
>
>    Create some data:
> 	_sysbench prepare /btrfs 10 2g 6
>
>    Mount with one the device missing:
> 	umount /btrfs
> 	btrfs dev scan --forget
> 	mount -o degraded /dev/loop0 /btrfs
>
>    Run fstrim:
> 	fstrim /btrfs
>
> The reason is we call btrfs_trim_free_extents() for the missing device,
> which uses device->bdev (NULL for missing device) to find if the device
> supports discard.
>
> Fix is to check if the device is missing before calling
> btrfs_trim_free_extents().
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/extent-tree.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d296483d148f..268ce58d4569 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6019,6 +6019,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, s=
truct fstrim_range *range)
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>   	devices =3D &fs_info->fs_devices->devices;
>   	list_for_each_entry(device, devices, dev_list) {
> +		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
> +			continue;
> +
>   		ret =3D btrfs_trim_free_extents(device, &group_trimmed);
>   		if (ret) {
>   			dev_failed++;
>
Won't it be better to put the check in to btrfs_trim_free_extents()?

And maybe it's better to also check device->bdev, just in case we got
some strange de-sync between DEV_STATE_MISSING and NULL device->bdev
pointer.

Thanks,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3498D43B21D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhJZMSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJZMSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 08:18:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9AFC061745
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 05:16:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso2897509wmd.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=n/Fk5ZBbrjaFIDSR5C2+s/QB38aBBc+pAAs2HrkwLvs=;
        b=DdpTMI7lv/EoaP6n5wBqqFTJoN9V+XHAp22Axj32YUCz/cC52wt5JDyblP3NWx9a2q
         FGR40JiSj/BAYoDko4z3d5vq1nLkrD86nrvzjz55NKnFDz1GWTNwRhdtoVgNzhy3rsiW
         1fBizGr2S5r+Nlv4ZYxlu+NdyQBfpNI4zqhT1Wq4GTW6gauwZalsMFaWMcBsXf8OmMLK
         m5QI2weuX/Bc1eOC3EhSLe/gcugG9lUzRDsQrFVScRyKzgV5KA2tOfnUvibl+RP6LlK5
         /9gqolzvNXD2jHc6E3VbBW8t8zMOrIRRZCUhgfsq4A9P6MrxGddbxY64SenPr6NXFMt1
         ht8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=n/Fk5ZBbrjaFIDSR5C2+s/QB38aBBc+pAAs2HrkwLvs=;
        b=6PmFH0XaqX4RuJMOrygLrfsse6f1nDJN5k4XFP9HA19B5PKeaWpMFShQUeT6wN/RP0
         mIa4B5eRKGof4j21mxkWTgkodnq0V4+BMSa5fhtURic+eNThBMYiFEu8XCUb4cRKwTjv
         yO9PqgUJGiksnqhqK3Nvv0+vrQebmklTJLfeUMZ8fTblIRehZKwmWOUkig0lZK4xU0Ca
         OZXpYX7KwuQx1weOYNoQAVjes/S3zHmKLUFJALTFfK4f2pYuMKGEKM3drEddfn3RAdhV
         ztV61v0+qsav/K6nnBGI+U4aSfSBgMyy/LuWw8fopixL77z9z3XUlsP9xuHz0l3fNBKW
         Sc0w==
X-Gm-Message-State: AOAM532Lweuj1e71cTX/WY5PpaQF3KZZUTSH93hW266MPTX8MbEd91zI
        OIwIxm10eE43Iac1KMN+liWrRWNWOuk=
X-Google-Smtp-Source: ABdhPJwWo7zCL1XHg3fHTdLJt6VaPrG8jnVm4ligdgp3QTuliq/iUCAzRySzCfdP65fMBa2jxbJmiQ==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr27191926wmj.83.1635250572805;
        Tue, 26 Oct 2021 05:16:12 -0700 (PDT)
Received: from [127.0.0.1] (p4fd0b7e4.dip0.t-ipconnect.de. [79.208.183.228])
        by smtp.gmail.com with ESMTPSA id n9sm508007wmq.6.2021.10.26.05.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 05:16:12 -0700 (PDT)
Date:   Tue, 26 Oct 2021 12:16:14 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <f6ab2cd3-54a6-4f78-97eb-47f912d3694b@gmail.com>
In-Reply-To: <c237d0ab-c223-eeb9-ce3f-21a27b8b88a8@gmx.com>
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com> <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com> <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com> <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com> <64e5b8aa-bc49-4596-b4ff-8cc780a6513d@gmail.com> <5d8df74b-6094-de7d-1b47-885126cf4bc6@gmx.com> <0e218606-5e07-4d7d-b81f-519895af2dfa@gmail.com> <c237d0ab-c223-eeb9-ce3f-21a27b8b88a8@gmx.com>
Subject: Re: Errors after successful disk replace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <f6ab2cd3-54a6-4f78-97eb-47f912d3694b@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After reapplying the thermal paste and adding a fan to my storage controlle=
r (LSI SAS2008) I haven't encountered any abnormal behavior of my drives. S=
crub is running (disk by disk) and everything looks fine so far.

I only got one task blocked message in dmesg, is that anything I should wor=
ry about?


Sun Oct 24 18:22:11 2021] BTRFS info (device sdg1): scrub: started on devid=
 5
[Mon Oct 25 15:31:23 2021] BTRFS info (device sdg1): scrub: finished on dev=
id 5 with status: 0
[Mon Oct 25 15:31:26 2021] BTRFS info (device sdg1): scrub: started on devi=
d 3
[Mon Oct 25 21:12:34 2021] perf: interrupt took too long (2501 > 2500), low=
ering kernel.perf_event_max_sample_rate to 79800
[Mon Oct 25 23:01:43 2021] hrtimer: interrupt took 13811 ns
[Tue Oct 26 02:58:17 2021] BTRFS info (device sdg1): scrub: finished on dev=
id 3 with status: 0
[Tue Oct 26 02:58:21 2021] BTRFS info (device sdg1): scrub: started on devi=
d 6
[Tue Oct 26 12:23:36 2021] INFO: task btrfs:341674 blocked for more than 12=
2 seconds.
[Tue Oct 26 12:23:36 2021]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tainted: G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=A0=
=C2=A0=C2=A0 5.14.14-arch1-1 #1
[Tue Oct 26 12:23:36 2021] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Tue Oct 26 12:23:36 2021] task:btrfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 state:D stack:=C2=A0=C2=A0=C2=A0 0 pid:341674 ppid=
:341658 flags:0x00004000
[Tue Oct 26 12:23:36 2021] Call Trace:
[Tue Oct 26 12:23:36 2021]=C2=A0 __schedule+0x333/0x1530
[Tue Oct 26 12:23:36 2021]=C2=A0 ? psi_task_switch+0xc2/0x1f0
[Tue Oct 26 12:23:36 2021]=C2=A0 ? autoremove_wake_function+0x2c/0x50
[Tue Oct 26 12:23:36 2021]=C2=A0 schedule+0x59/0xc0
[Tue Oct 26 12:23:36 2021]=C2=A0 __scrub_blocked_if_needed+0xa0/0xf0 [btrfs=
 796168a0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
[Tue Oct 26 12:23:36 2021]=C2=A0 scrub_pause_off+0x21/0x50 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 scrub_stripe+0x452/0x1580 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
[Tue Oct 26 12:23:36 2021]=C2=A0 ? __btrfs_end_transaction+0xf6/0x210 [btrf=
s 796168a0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 ? scrub_chunk+0xcd/0x130 [btrfs 796168a0fe=
fcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 scrub_chunk+0xcd/0x130 [btrfs 796168a0fefc=
fb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 scrub_enumerate_chunks+0x354/0x790 [btrfs =
796168a0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
[Tue Oct 26 12:23:36 2021]=C2=A0 btrfs_scrub_dev+0x23d/0x570 [btrfs 796168a=
0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 btrfs_ioctl+0x1410/0x2df0 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:23:36 2021]=C2=A0 ? __x64_sys_ioctl+0x82/0xb0
[Tue Oct 26 12:23:36 2021]=C2=A0 __x64_sys_ioctl+0x82/0xb0
[Tue Oct 26 12:23:36 2021]=C2=A0 do_syscall_64+0x5c/0x80
[Tue Oct 26 12:23:36 2021]=C2=A0 ? create_task_io_context+0xc7/0x110
[Tue Oct 26 12:23:36 2021]=C2=A0 ? get_task_io_context+0x48/0x80
[Tue Oct 26 12:23:36 2021]=C2=A0 ? set_task_ioprio+0x97/0xa0
[Tue Oct 26 12:23:36 2021]=C2=A0 ? __do_sys_ioprio_set+0x5e/0x300
[Tue Oct 26 12:23:36 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
[Tue Oct 26 12:23:36 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
[Tue Oct 26 12:23:36 2021]=C2=A0 ? do_syscall_64+0x69/0x80
[Tue Oct 26 12:23:36 2021]=C2=A0 ? exit_to_user_mode_prepare+0x77/0x170
[Tue Oct 26 12:23:36 2021]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xae
[Tue Oct 26 12:23:36 2021] RIP: 0033:0x7fba22e2559b
[Tue Oct 26 12:23:36 2021] RSP: 002b:00007fba22cf7c98 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000010
[Tue Oct 26 12:23:36 2021] RAX: ffffffffffffffda RBX: 000056511ecc6bc0 RCX:=
 00007fba22e2559b
[Tue Oct 26 12:23:36 2021] RDX: 000056511ecc6bc0 RSI: 00000000c400941b RDI:=
 0000000000000003
[Tue Oct 26 12:23:36 2021] RBP: 0000000000000000 R08: 00007fba22cf8640 R09:=
 0000000000000000
[Tue Oct 26 12:23:36 2021] R10: 00007fba22cf8640 R11: 0000000000000246 R12:=
 00007ffec33d061e
[Tue Oct 26 12:23:36 2021] R13: 00007ffec33d061f R14: 0000000000000000 R15:=
 00007fba22cf8640
[Tue Oct 26 12:27:42 2021] INFO: task btrfs:341674 blocked for more than 12=
2 seconds.
[Tue Oct 26 12:27:42 2021]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tainted: G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=A0=
=C2=A0=C2=A0 5.14.14-arch1-1 #1
[Tue Oct 26 12:27:42 2021] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Tue Oct 26 12:27:42 2021] task:btrfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 state:D stack:=C2=A0=C2=A0=C2=A0 0 pid:341674 ppid=
:341658 flags:0x00004000
[Tue Oct 26 12:27:42 2021] Call Trace:
[Tue Oct 26 12:27:42 2021]=C2=A0 __schedule+0x333/0x1530
[Tue Oct 26 12:27:42 2021]=C2=A0 ? autoremove_wake_function+0x2c/0x50
[Tue Oct 26 12:27:42 2021]=C2=A0 schedule+0x59/0xc0
[Tue Oct 26 12:27:42 2021]=C2=A0 __scrub_blocked_if_needed+0xa0/0xf0 [btrfs=
 796168a0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
[Tue Oct 26 12:27:42 2021]=C2=A0 scrub_pause_off+0x21/0x50 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 scrub_stripe+0x452/0x1580 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 ? __update_load_avg_cfs_rq+0x27d/0x2e0
[Tue Oct 26 12:27:42 2021]=C2=A0 ? __btrfs_end_transaction+0xf6/0x210 [btrf=
s 796168a0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 ? kmem_cache_free+0x107/0x410
[Tue Oct 26 12:27:42 2021]=C2=A0 ? scrub_chunk+0xcd/0x130 [btrfs 796168a0fe=
fcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 scrub_chunk+0xcd/0x130 [btrfs 796168a0fefc=
fb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 scrub_enumerate_chunks+0x354/0x790 [btrfs =
796168a0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
[Tue Oct 26 12:27:42 2021]=C2=A0 btrfs_scrub_dev+0x23d/0x570 [btrfs 796168a=
0fefcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 btrfs_ioctl+0x1410/0x2df0 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
[Tue Oct 26 12:27:42 2021]=C2=A0 ? __x64_sys_ioctl+0x82/0xb0
[Tue Oct 26 12:27:42 2021]=C2=A0 __x64_sys_ioctl+0x82/0xb0
[Tue Oct 26 12:27:42 2021]=C2=A0 do_syscall_64+0x5c/0x80
[Tue Oct 26 12:27:42 2021]=C2=A0 ? create_task_io_context+0xc7/0x110
[Tue Oct 26 12:27:42 2021]=C2=A0 ? get_task_io_context+0x48/0x80
[Tue Oct 26 12:27:42 2021]=C2=A0 ? set_task_ioprio+0x97/0xa0
[Tue Oct 26 12:27:42 2021]=C2=A0 ? __do_sys_ioprio_set+0x5e/0x300
[Tue Oct 26 12:27:42 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
[Tue Oct 26 12:27:42 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
[Tue Oct 26 12:27:42 2021]=C2=A0 ? do_syscall_64+0x69/0x80
[Tue Oct 26 12:27:42 2021]=C2=A0 ? exit_to_user_mode_prepare+0x77/0x170
[Tue Oct 26 12:27:42 2021]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xae
[Tue Oct 26 12:27:42 2021] RIP: 0033:0x7fba22e2559b
[Tue Oct 26 12:27:42 2021] RSP: 002b:00007fba22cf7c98 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000010
[Tue Oct 26 12:27:42 2021] RAX: ffffffffffffffda RBX: 000056511ecc6bc0 RCX:=
 00007fba22e2559b
[Tue Oct 26 12:27:42 2021] RDX: 000056511ecc6bc0 RSI: 00000000c400941b RDI:=
 0000000000000003
[Tue Oct 26 12:27:42 2021] RBP: 0000000000000000 R08: 00007fba22cf8640 R09:=
 0000000000000000
[Tue Oct 26 12:27:42 2021] R10: 00007fba22cf8640 R11: 0000000000000246 R12:=
 00007ffec33d061e
[Tue Oct 26 12:27:42 2021] R13: 00007ffec33d061f R14: 0000000000000000 R15:=
 00007fba22cf8640

Thanks,
Emil

Oct 19, 2021 14:46:46 Qu Wenruo <quwenruo.btrfs@gmx.com>:

>=20
>=20
> On 2021/10/19 20:38, Emil Heimpel wrote:
>> So it finished after 2 minutes?
>>=20
>> [Tue Oct 19 14:13:51 2021] BTRFS info (device sde1): continuing dev_repl=
ace from <missing disk> (devid 1) to target /dev/sde1 @74%
>> [Tue Oct 19 14:15:39 2021] BTRFS info (device sde1): dev_replace from <m=
issing disk> (devid 1) to /dev/sde1 finished
>=20
> Then this means it previously only have the dev replace status not
> cleaned up.
>=20
> Thus it ends pretty quick.
>>=20
>>=20
>> Now I at least have an expected filesystem show:
>>=20
>> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes used=
 20.96TiB
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 siz=
e 7.28TiB used 5.46TiB path /dev/sde1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 siz=
e 7.28TiB used 5.46TiB path /dev/sdb1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 siz=
e 2.73TiB used 2.73TiB path /dev/sdg1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 siz=
e 2.73TiB used 2.73TiB path /dev/sdd1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 siz=
e 7.28TiB used 4.81TiB path /dev/sdf1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 siz=
e 7.28TiB used 5.33TiB path /dev/sdc1
>>=20
>> And a nondegraded remount worked too.
>=20
> And it's time for a full fs scrub to find out how consistent the fs is.
>=20
> For btrfs RAID56, every time a unexpected shutdown is hit, a scrub is
> strongly recommended.
>=20
> And even routine scrub would be a plus for btrfs RAID56.
>=20
> Thanks,
> Qu
>=20
>>=20
>> Thanks,
>> Emil
>>=20
>> Oct 19, 2021 14:20:21 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>=20
>>>=20
>>>=20
>>> On 2021/10/19 20:16, Emil Heimpel wrote:
>>>> Color me suprised:
>>>>=20
>>>>=20
>>>> [74713.072745] BTRFS info (device sde1): flagging fs with big metadata=
 feature
>>>> [74713.072755] BTRFS info (device sde1): allowing degraded mounts
>>>> [74713.072758] BTRFS info (device sde1): using free space tree
>>>> [74713.072760] BTRFS info (device sde1): has skinny extents
>>>> [74713.104297] BTRFS warning (device sde1): devid 1 uuid 51645efd-bf95=
-458d-b5ae-b31623533abb is missing
>>>> [74714.675001] BTRFS info (device sde1): bdev (efault) errs: wr 52950,=
 rd 8161, flush 0, corrupt 1221, gen 0
>>>> [74714.675015] BTRFS info (device sde1): bdev /dev/sdb1 errs: wr 0, rd=
 0, flush 0, corrupt 228, gen 0
>>>> [74714.675025] BTRFS info (device sde1): bdev /dev/sdc1 errs: wr 0, rd=
 0, flush 0, corrupt 140, gen 0
>>>> [74751.033383] BTRFS info (device sde1): continuing dev_replace from <=
missing disk> (devid 1) to target /dev/sde1 @74%
>>>> [bluemond@BlueQ ~]$ sudo btrfs replace status=C2=A0 -1 /mnt/btrfsrepai=
r/
>>>> 74.9% done, 0 write errs, 0 uncorr. read errs
>>>>=20
>>>> I guess I just wait?
>>>=20
>>> Yep, wait and stay alert, better to also keep an eye on the dmesg.
>>>=20
>>> But this also means, previous replace didn't really finish, which may
>>> mean the replace ioctl is not reporting the proper status, and can be a
>>> possible bug.
>>>=20
>>> Thanks,
>>> Qu
>>>=20
>>>>=20
>>>> Oct 19, 2021 13:37:09 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 2021/10/19 18:49, Emil Heimpel wrote:
>>>>>> =E2=80=A6
>>>>>=20
>>>>> *failed*...
>>>>>=20
>>>>>> =E2=80=A6
>>>>>=20
>>>>> And ATA commands failure.
>>>>>=20
>>>>> I don't believe the replace finished without problem, and the involve=
d
>>>>> device is /dev/sdd.
>>>>>=20
>>>>>> =E2=80=A6
>>>>>=20
>>>>> You won't want to see this message at all.
>>>>>=20
>>>>> This means, you're running RAID56, as btrfs has write-hole problem,
>>>>> which will degrade the robust of RAID56 byte by byte for each unclean
>>>>> shutdown.
>>>>>=20
>>>>> I guess the write hole problem has already make the repair failed for
>>>>> the replace.
>>>>>=20
>>>>> Thus after a successful mount, scrub and manually file checking is
>>>>> almost a must.
>>>>>=20
>>>>>> =E2=80=A6
>>>>>=20
>>>>> This doesn't sound correct.
>>>>>=20
>>>>> If a device is properly replaced, it should have the same devid numbe=
r.
>>>>>=20
>>>>> I guess you have tried to add a new device before, and then tried to
>>>>> replace the missing device, right?
>>>>>=20
>>>>>=20
>>>>> Anyway, have you tried to mount it degraded and then remove the missi=
ng
>>>>> device?
>>>>>=20
>>>>> Since you're using RAID56, I guess degrade mount should work.
>>>>>=20
>>>>> Thanks,
>>>>> Qu
>>>>>=20
>>>>>> =E2=80=A6

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E63562230
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiF3Sim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiF3Sik (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 14:38:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB861EAFC
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 11:38:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a2so35286028lfg.5
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xvgP3KH4I1HNW+GOhKWI2M/Mc5QwzUvceTlw+Q+tR1Q=;
        b=rmnW7LJp530DylARXJh+5dfbGeYgWbh0IXlGzVGwpVbzZVD02AK01tjZ4ykiV+VPce
         p4WkPYVp0VP40S6SzVOozx2gPkiFy/f9gEop4eu8Y35HqJvASEiLZx2Qgnx1s8lG9XWp
         2AwyR3mxpJ4vP9j4ipTcGLn64fgBBH1laAX/xQzX+b4vxfnB8AuSOm1slSnrQycEnloo
         os5szP/uncAsbRWOY5bec+UrO6S7QbanJrlaKiePpAAKvFdsjeTX0yrgQP8SfaQDC0ja
         kVIN8uSvjZth47HmAGA7vawMYquG+WeI/7YJOOoHnjVYeBMxdzIcqgF26IyO0a+7COin
         yJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xvgP3KH4I1HNW+GOhKWI2M/Mc5QwzUvceTlw+Q+tR1Q=;
        b=ivEXLZVKpiNCfjTT9TbOHTE0kLlHukZkuawZXUh3vltNlOAbDJUhSFiTYCNij32BTh
         PkYrJF7MByfzL3gJx+nVa3TcaX8idgJGq2TnHS/Au3SkEUllCvd5rQ5qZPuPd+vDyUuz
         A9zV7tRpdIAebea7oL6fSWQbmBOz1++P2V41AXi6lh3hIIcC8jYy4/trAgFtTj4HkgqF
         HJDZ4iMe9bUJ6PIko2xkDR40pGGkOl9Z1HuS/oYlRZx8Gi+7iP9XLuXofIm8EEPI9m3S
         GFEANz4mn7uTHMjIVm+3U4b9KkeWsB35Pb7sl5FiCYjUcC6N9/cBbL4oB59dEXdShCDA
         o4oQ==
X-Gm-Message-State: AJIora/4k0A7hx9mkW15sPbngxqpP9O1UrRm/6uXCCBSJtNtIjD8Y69b
        6SJzsQmv7jGK0aGE0raxULcjqzNBgYlYqa+mV121Mf7xucH7ciDa
X-Google-Smtp-Source: AGRyM1sWtidJxPveeWx/B3pEyfsna9B6Grk0UeC92OhpddynOqBhC3zHzhtR7Sj+c8iIfoAZeohhUC19OGP1iAs1mf8=
X-Received: by 2002:a05:6512:33c9:b0:481:414d:ef28 with SMTP id
 d9-20020a05651233c900b00481414def28mr6447030lfg.357.1656614317111; Thu, 30
 Jun 2022 11:38:37 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Jun 2022 14:38:20 -0400
Message-ID: <CAJCQCtSu_OGAgHtPXW4pHN8+Yuu25diOym4F0FbO=8+vhcHfzA@mail.gmail.com>
Subject: btrfs shrink failure, systemd-homed
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_commit_transaction: WARNING: CPU: 11 PID: 81628 at
fs/btrfs/extent-tree.c:2159 btrfs_run_delayed_refs+0x196/0x1e0
https://bugzilla.redhat.com/show_bug.cgi?id=3D2082022

kernel-5.18.6
btrfs-progs-5.18

See also bug:
bogus min size estimates by 'btrfs inspect min'
https://github.com/kdave/btrfs-progs/issues/271


[24754.364371] systemd-homework[139605]: Ready to resize image size
885.3G =E2=86=92 173.9G, partition size 885.3G =E2=86=92 173.9G, file syste=
m size
885.3G =E2=86=92 173.9G.
...
[24755.980565] systemd-homework[139605]: Failed to resize file system:
Read-only file system


The gist is, it seems to me the shrink request is too aggressive, and
we're failing during bg relocation. But how is systemd supposed to
know this? I guess systemd could iterate and try again with a larger
shrink size target? But how many attempts is reasonable? I speculate
in the bug whether it's practical for the kernel to do a "best effort"
but then there'd need to be an interface that reports back to the
requesting process what size actually succeeded, because it'll need to
know that in order to avoid truncating the file system with a
subsequent block device resize.

The full dmesg+journal is attached to the above bug report, this is
the call trace

[24755.774780] kernel: ------------[ cut here ]------------
[24755.774782] kernel: BTRFS: Transaction aborted (error -28)
[24755.774787] kernel: WARNING: CPU: 18 PID: 139605 at
fs/btrfs/extent-tree.c:2151 btrfs_run_delayed_refs+0x196/0x1e0
[24755.774791] kernel: Modules linked in: [[snipped]]
[24755.774825] kernel: CPU: 18 PID: 139605 Comm: systemd-homewor Not
tainted 5.18.6-200.fc36.x86_64 #1
[24755.774826] kernel: Hardware name: CSL-Computer GmbH & Co. KG
5946/B550 AORUS ELITE V2, BIOS F14e 10/13/2021
[24755.774827] kernel: RIP: 0010:btrfs_run_delayed_refs+0x196/0x1e0
[24755.774828] kernel: Code: 48 8d 91 50 0a 00 00 f0 48 0f ba 2a 03 72
20 83 f8 fb 74 39 83 f8 e2 74 34 89 c6 48 c7 c7 98 9c 65 a3 89 04 24
e8 25 4b 7d 00 <0f> 0b 8b 04 24 89 c1 ba 67 08 00 00 48 89 df 89 04 24
48 c7 c6 80
[24755.774829] kernel: RSP: 0018:ffffae3f118bbb88 EFLAGS: 00010292
[24755.774830] kernel: RAX: 0000000000000026 RBX: ffff93460a8ad0d0
RCX: 0000000000000000
[24755.774831] kernel: RDX: 0000000000000001 RSI: ffffffffa366ec04
RDI: 00000000ffffffff
[24755.774832] kernel: RBP: ffff934b017c5978 R08: 0000000000000000
R09: ffffae3f118bb9c0
[24755.774832] kernel: R10: 0000000000000003 R11: ffffffffa3f453e8
R12: ffff934b017c5800
[24755.774833] kernel: R13: ffff934600c92000 R14: ffff934600c92000
R15: ffff934b017c5800
[24755.774833] kernel: FS:  00007f4ceaff7b80(0000)
GS:ffff9354fc080000(0000) knlGS:0000000000000000
[24755.774834] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24755.774834] kernel: CR2: 00007f4ceb12010b CR3: 00000001af126000
CR4: 0000000000750ee0
[24755.774835] kernel: PKRU: 55555554
[24755.774835] kernel: Call Trace:
[24755.774836] kernel:  <TASK>
[24755.774838] kernel:  btrfs_commit_transaction+0x52/0xbc0
[24755.774840] kernel:  ? start_transaction+0xc3/0x5e0
[24755.774841] kernel:  relocate_block_group+0x179/0x4c0
[24755.774844] kernel:  btrfs_relocate_block_group+0x22e/0x3f0
[24755.774845] kernel:  ? preempt_count_add+0x64/0x90
[24755.774848] kernel:  btrfs_relocate_chunk+0x3b/0xf0
[24755.774849] kernel:  btrfs_shrink_device+0x255/0x570
[24755.774850] kernel:  btrfs_ioctl_resize+0x2ed/0x400
[24755.774852] kernel:  ? _copy_to_user+0x21/0x30
[24755.774854] kernel:  btrfs_ioctl+0xd34/0x2850
[24755.774855] kernel:  ? fd_statfs+0x1b/0x70
[24755.774857] kernel:  ? security_file_ioctl+0x3c/0x60
[24755.774858] kernel:  __x64_sys_ioctl+0x8d/0xc0
[24755.774860] kernel:  do_syscall_64+0x5b/0x80
[24755.774863] kernel:  ? exc_page_fault+0x70/0x170
[24755.774864] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
[24755.774866] kernel: RIP: 0033:0x7f4ceb67576f
[24755.774879] kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7
04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10
00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04
25 28 00 00
[24755.774880] kernel: RSP: 002b:00007fff921eebc0 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
[24755.774881] kernel: RAX: ffffffffffffffda RBX: 0000002b7d037000
RCX: 00007f4ceb67576f
[24755.774881] kernel: RDX: 00007fff921eecb0 RSI: 0000000050009403
RDI: 0000000000000004
[24755.774882] kernel: RBP: 0000000000000004 R08: 0000000000000000
R09: 0000000000000075
[24755.774882] kernel: R10: 00007fff921ee95c R11: 0000000000000246
R12: 00007fff921eecb0
[24755.774883] kernel: R13: 0000000000000000 R14: 000000000000005d
R15: 000055ed54784bb0
[24755.774884] kernel:  </TASK>
[24755.774884] kernel: ---[ end trace 0000000000000000 ]---


--=20
Chris Murphy

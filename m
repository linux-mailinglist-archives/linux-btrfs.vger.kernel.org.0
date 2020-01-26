Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 063C1149BFF
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2020 18:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAZRKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 12:10:35 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:33927 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgAZRKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 12:10:34 -0500
Date:   Sun, 26 Jan 2020 17:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580058631;
        bh=Fr9mMS+6jNmm+Cs4Timq1zbSyB17n0jFtJC8PGcMmJs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Rr7dOoi3V1THiIQgQg0i7L3uDe/nYXitFkyrW+QLA9vx0cCqfApR5Hm5iyljXOkmP
         xYGuo3ft53RArOSXcyLKzkf4lsACcQpV02TYTfMQyNf5sOlPOyYsRH5ejp/UYlVRrS
         bGiTLrSDKf5bZk0X1dGHAZ1qDegF1lzG+aKjqwVU=
To:     Nikolay Borisov <nborisov@suse.com>
From:   Raviu <raviu@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Raviu <raviu@protonmail.com>
Subject: Re: fstrim segmentation fault and btrfs crash on vanilla 5.4.14
Message-ID: <hNqW0cNKaqya5Nvb99uUaI7KRF7zyl2urKDMfG6CkwEvLdLq6HlWnBLFrgtNCpleC2dfm8HLOHUdlQYPa1zi9zxfBaY1wwXli1mTAM-4qTQ=@protonmail.com>
In-Reply-To: <1a8462a7-c77b-ecc9-681f-3cecb6a51576@suse.com>
References: <izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com>
 <7tcxgXvMR83f-yW7IN3dKq8NWJETNoAMGo_0GShBJMjR_p_N4vE3nDMPkECoqBiOFDCEFsBM4IZ08Lkk0yT5-H81FkHAV-xEThPkbey0Z40=@protonmail.com>
 <1a8462a7-c77b-ecc9-681f-3cecb6a51576@suse.com>
Feedback-ID: s2UDJFOuCQB5skd1w8rqWlDOlD5NAbNnTyErhCdMqDC7lQ_PsWqTjpdH2pOmUWgBaEipj53UTbJWo1jzNMb12A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_05,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is the output of different btrfs filesystem subcommands:

`btrfs filesystem show /home`
Label: none  uuid: 9c32ec4c-e918-4a79-92cf-c85faf3724e4
        Total devices 2 FS bytes used 404.99GiB
        devid    1 size 687.36GiB used 425.10GiB path /dev/mapper/cr_nvme0n=
1p4
        devid    2 size 100.00GiB used 1.03GiB path /dev/mapper/cr_nvme0n1p=
1

`btrfs filesystem df /home`
Data, single: total=3D420.01GiB, used=3D403.48GiB
System, RAID1: total=3D32.00MiB, used=3D48.00KiB
System, DUP: total=3D32.00MiB, used=3D16.00KiB
Metadata, RAID1: total=3D1.00GiB, used=3D48.47MiB
Metadata, DUP: total=3D2.00GiB, used=3D1.46GiB
GlobalReserve, single: total=3D477.95MiB, used=3D0.00B

`btrfs filesystem usage /home`
Overall:
    Device size:                 787.36GiB
    Device allocated:            426.13GiB
    Device unallocated:          361.23GiB
    Device missing:                  0.00B
    Used:                        406.50GiB
    Free (estimated):            377.75GiB      (min: 197.14GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              477.95MiB      (used: 0.00B)

Data,single: Size:420.01GiB, Used:403.48GiB (96.07%)
   /dev/mapper/cr_nvme0n1p4      420.01GiB

Metadata,RAID1: Size:1.00GiB, Used:48.47MiB (4.73%)
   /dev/mapper/cr_nvme0n1p4        1.00GiB
   /dev/mapper/cr_nvme0n1p1        1.00GiB

Metadata,DUP: Size:2.00GiB, Used:1.46GiB (73.12%)
   /dev/mapper/cr_nvme0n1p4        4.00GiB

System,RAID1: Size:32.00MiB, Used:48.00KiB (0.15%)
   /dev/mapper/cr_nvme0n1p4       32.00MiB
   /dev/mapper/cr_nvme0n1p1       32.00MiB

System,DUP: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/mapper/cr_nvme0n1p4       64.00MiB

Unallocated:
   /dev/mapper/cr_nvme0n1p4      262.26GiB
   /dev/mapper/cr_nvme0n1p1       98.97GiB




=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday, January 26, 2020 6:54 PM, Nikolay Borisov <nborisov@suse.com> wr=
ote:

&gt; On 26.01.20 =D0=B3. 18:09 =D1=87., Raviu wrote:
&gt;
&gt; &gt; Here is dmesg output:
&gt; &gt; [ 237.525947] assertion failed: prev, in ../fs/btrfs/extent_io.c:=
1595
&gt; &gt; [ 237.525984] ------------[ cut here ]------------
&gt; &gt; [ 237.525985] kernel BUG at ../fs/btrfs/ctree.h:3117!
&gt; &gt; [ 237.525992] invalid opcode: 0000 [#1] SMP PTI
&gt; &gt; [ 237.525998] CPU: 4 PID: 4423 Comm: fstrim Tainted: G U OE 5.4.1=
4-8-vanilla #1
&gt; &gt; [ 237.526001] Hardware name: ASUSTeK COMPUTER INC.
&gt; &gt; [ 237.526044] RIP: 0010:assfail.constprop.58+0x18/0x1a [btrfs]
&gt; &gt; [ 237.526048] Code: 0b 0f 1f 44 00 00 48 8b 3d 15 9e 07 00 e9 70 =
20 ce e2 89 f1 48 c7 c2 ae 27 77 c0 48 89 fe 48 c7 c7 20 87 77 c0 e8 56 c5 =
ba e2 &lt;0f&gt; 0b 0f 1f 44 00 00 e8 9c 1b bc e2 48 8b 3d 7d 9f 07 00 e8 4=
0 20
&gt; &gt; [ 237.526053] RSP: 0018:ffffae2cc2befc20 EFLAGS: 00010282
&gt; &gt; [ 237.526056] RAX: 0000000000000037 RBX: 0000000000000021 RCX: 00=
00000000000000
&gt; &gt; [ 237.526059] RDX: 0000000000000000 RSI: ffff94221eb19a18 RDI: ff=
ff94221eb19a18
&gt; &gt; [ 237.526062] RBP: ffff942216ce6e00 R08: 0000000000000403 R09: 00=
00000000000001
&gt; &gt; [ 237.526064] R10: ffffae2cc2befc38 R11: 0000000000000001 R12: ff=
ffae2cc2befca0
&gt; &gt; [ 237.526067] R13: ffff942216ce6e24 R14: ffffae2cc2befc98 R15: 00=
00000000100000
&gt; &gt; [ 237.526071] FS: 00007fa1b8087fc0(0000) GS:ffff94221eb00000(0000=
) knlGS:0000000000000000
&gt; &gt; [ 237.526074] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
&gt; &gt; [ 237.526076] CR2: 000032eed3b5a000 CR3: 00000007c33bc002 CR4: 00=
000000003606e0
&gt; &gt; [ 237.526079] Call Trace:
&gt; &gt; [ 237.526120] find_first_clear_extent_bit+0x13d/0x150 [btrfs]
&gt;
&gt; So you are hitting the ASSERT(prev) in find_first_clear_extent_bit. Th=
e
&gt; good news is this is just an in-memory state and it's used to optimize
&gt; fstrim so that only non-trimmed regions are being trimmed. This state =
is
&gt; cleared on unmount so if you mount/remount then you shouldn't be hitti=
ng
&gt; it.
&gt;
&gt; But then again, the ASSERT is there to catch an impossible case. To he=
lp
&gt; me debug this could you provide the output of:
&gt;
&gt; btrfs fi show /home
&gt;
&gt; And then the output of btrfs inspect-internal dump-tree -t3 /dev/XXX
&gt;
&gt; where XXX should be the block device that contains the fs mounted on /=
home .

</nborisov@suse.com>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA716937A5
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 14:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBLN5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 08:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBLN5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 08:57:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA8B13D72;
        Sun, 12 Feb 2023 05:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676210224; bh=cZiWBRLqs20zFmC1DhNCa0PRvekrI5MLnxTxZnxW59c=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=skAtyRAKWlyKA25BzihOC5MPGaSZr3kfdYGzdgjvZcKbwJPIHxkyoaLwyAI45lARu
         J66KCLoeCF0aKm6IgiBdYY6uN0s0uORjM5JMUHDCY0pPNajC4elRdEgnrNBI+E4sDK
         mc1gdM7+5I9LZmw8PGVFJeEY8cMhUX52GEOUc7G0vro7qmzLXj2kCGnggWJShqFtFc
         +gbyHX0yedd1ibVe8cjzqdEIwXeNXpKBeNLwGwEw9pKBgDlo10biwN1aPP84Iksmd1
         1YpXKu2InBnQG6TlVM2qZUIOOIUgB8n4GMPnjHx9N4WLgH/YgG1NLBIOtnXP2B3Sa5
         +FS57+MhDpMmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.31] ([77.3.181.196]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1p0hln3hqq-00QSM2; Sun, 12
 Feb 2023 14:57:03 +0100
Message-ID: <550e4190-c487-51db-6213-838d32183cbf@gmx.de>
Date:   Sun, 12 Feb 2023 14:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: RIP in btrfs with kernel 6.1.4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hyAPJCv0AYKmgkcKy/xV4y0RHufx54SKQtmxYpOKSY1DG3EiEAx
 KboUbPXgJf9S43GxWPCgyp0xEapVB3rfv7sB46cvyOMSY3jXbS0sBCgTezAPzzOqGDN5kMf
 fqVfJ6NsbLgnxgsTBTcgnIuj76t1k2bsv8giC/t/YI3pTSoPah5t+SV6sWANl/v+Q6LaV1S
 AsL58RnKu/lCE5XXUPIOg==
UI-OutboundReport: notjunk:1;M01:P0:lGuOBhbdohA=;NnyglTH1fyAtmKwBoGuIdpzQWsi
 p6PEEHUdJawWjyAs/qg8hlv2HOM/y1QPceizGiQnu58niipe93fvPH6EVV3OYCwrvQAeG954s
 TR2qU8BLLEp+I73RUeWLBLsz/EwVTPqUeBc/PE9oM8ej+Vx8Jc2ggVhZesgjUSmEvu5UT9XQ4
 rX1TAs8v7jAH+z4a1lhKq7PmLNzWbYsToOyQi+hvpwZt8ktrbMXA3kUCE4VFrRMpPOUV/GU+E
 7Pqi8GlXnweLiD8ovFsINGov29Gtj3RwFKmuibPr+MHuqw94NMWiLThJjm8dYzTzjxPkkjOUG
 JrD4QdA/MigbQG59QD96LJyE3fmIHXs21eq26vWr1WioyoWfPkSdBR+BE2Aqr1CaMx2qdZr4F
 xsO1BZ5elhg3tz9SxBizTXMX0jwkNpJYP025XDKkzBUbNC8yoJWLxbhCRenCeUf40cA54aV9U
 6t17PtDwdqhg370JdxT/9viojrf43KEPrNLe4020RQvAXaEE8JdGBZee2L3v3/bCNp7eNN1Ex
 JL54c/355EaBRgEiwxt7+Omm/olf/iM7S27MEtKPNEM6nnMOGzgmvb4QR8C4XmCktWZ3T4GfE
 ZkNc4+1wxFsDxbd2OO3jLOwXitwfls4e17rMiZTo/BlpyAKyqiHxzvzu5Vj6X0txUMngHfruJ
 yUPHvkyH3TWt7pqQVEjk13kSBM6KkYQMQVGjM9AAF6DJ6Vm7OuWFNhJfukUTyhdokmCUJj9t3
 vi7S86cZ853fyy8TBeggKmAZD6vZyIZQDb4XGNzxxPWDYQ8onJ9IVTtJAAu2r/wS0xTQod/0H
 NMJuxwvUL8EJXZnrSU4/hNMNY5gIDhHm1BZUI3t2NN06tBXq+xFEuLIoNG4KuRe9i43Y5fskK
 3NP6YxHH/88eHm9i/UV0zoXZRrh90UT1aBkgzfu79zPKmdBnC0GCozU/Empizhef+t8qMKPp0
 0R7zPQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



At a stable hardened Gentoo Linux server I got a month ago the RIP seen
below.


Just FWIW few hours before that RIP the BTRFS at my desktop (same OS,
but older stable kernel v5.15.86 IIRC) got big problems (100% full
despite that just about the half of 250 GB was used) - and I made the
mistake of the months and trusts the btrfs repair tool - after that the
fs could not even be found/mounted by the kernel.


The server is an SMP PREEMPT_DYNAMIC Thu Feb  9 17:45:03 UTC 2023 x86_64
AMD Ryzen 9 5950X 16-Core Processor AuthenticAMD GNU/Linux
The client was an ThinkPad T440s with an i5


Here is the RIP:

Jan 12 09:52:07 mr-fox kernel: BTRFS warning (device nvme0n1p4): bad eb
member end: ptr 0x3fe9 start 5994348707840 member offset 16382 size 8
Jan 12 09:52:07 mr-fox kernel: general protection fault, probably for
non-canonical address 0x142f000000000: 0000 [#1] PREEMPT SMP NOPTI
Jan 12 09:52:07 mr-fox kernel: CPU: 19 PID: 6458 Comm: tar Tainted: G
             T  6.1.4 #10
Jan 12 09:52:07 mr-fox kernel: Hardware name: ASUS System Product
Name/Pro WS 565-ACE, BIOS 0502 01/15/2021
Jan 12 09:52:07 mr-fox kernel: RIP: 0010:btrfs_get_64+0x11e/0x170
Jan 12 09:52:07 mr-fox kernel: Code: 4a 8b 44 e5 70 48 2b 05 f0 cd c9 00
48 c1 f8 06 48 c1 e0 0c 48 03 05 f1 cd c9 00 81 eb f8 0f 00 00 74 13 31
d2 89 d6 83 c2 01 <0f> b6 3c 30 40 88 3c 31 39 da 72 ef 48 8b 44 24 08
e9 5b ff ff ff
Jan 12 09:52:07 mr-fox kernel: RSP: 0018:ffff95c160b1fd48 EFLAGS: 00010202
Jan 12 09:52:07 mr-fox kernel: RAX: 000142f000000000 RBX:
0000000000000006 RCX: ffff95c160b1fd52
Jan 12 09:52:07 mr-fox kernel: RDX: 0000000000000001 RSI:
0000000000000000 RDI: 000000000000000a
Jan 12 09:52:07 mr-fox kernel: RBP: ffff95c13d2c6a00 R08:
0000000000000000 R09: 0000000000000000
Jan 12 09:52:07 mr-fox kernel: R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000004
Jan 12 09:52:07 mr-fox kernel: R13: 0000000000000002 R14:
00000573ab068000 R15: 0000000000003fe9
Jan 12 09:52:07 mr-fox kernel: FS:  00007fe568d167c0(0000)
GS:ffff95dfaecc0000(0000) knlGS:0000000000000000
Jan 12 09:52:07 mr-fox kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 12 09:52:07 mr-fox kernel: CR2: 000055d1eacc94a8 CR3:
00000001347a4000 CR4: 0000000000750ee0
Jan 12 09:52:07 mr-fox kernel: PKRU: 55555554
Jan 12 09:52:07 mr-fox kernel: Call Trace:
Jan 12 09:52:07 mr-fox kernel:  <TASK>
Jan 12 09:52:07 mr-fox kernel:  btrfs_file_llseek+0x25d/0x670
Jan 12 09:52:07 mr-fox kernel:  ksys_lseek+0x73/0xc0
Jan 12 09:52:07 mr-fox kernel:  do_syscall_64+0x68/0xa0
Jan 12 09:52:07 mr-fox kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Jan 12 09:52:07 mr-fox kernel: RIP: 0033:0x7fe56940a1f7
Jan 12 09:52:07 mr-fox kernel: Code: 00 00 90 89 c3 48 8b 05 27 5c 0d 00
f7 db 64 89 18 48 c7 c0 ff ff ff ff eb b1 66 0f 1f 84 00 00 00 00 00 b8
08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 f9 5b 0d 00 f7
d8 64 89 02 48
Jan 12 09:52:07 mr-fox kernel: RSP: 002b:00007fffef1a8348 EFLAGS:
00000202 ORIG_RAX: 0000000000000008
Jan 12 09:52:07 mr-fox kernel: RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007fe56940a1f7
Jan 12 09:52:07 mr-fox kernel: RDX: 0000000000000003 RSI:
0000000000000000 RDI: 000000000000000b
Jan 12 09:52:07 mr-fox kernel: RBP: 0000000000000000 R08:
000000000000000b R09: 000055d1eacc7c00
Jan 12 09:52:07 mr-fox kernel: R10: 0ddfa64af0d29e4e R11:
0000000000000202 R12: 0000000000000000
Jan 12 09:52:07 mr-fox kernel: R13: 000055d1eacad020 R14:
000055d1eacac030 R15: 0000000000000002
Jan 12 09:52:07 mr-fox kernel:  </TASK>
Jan 12 09:52:07 mr-fox kernel: ---[ end trace 0000000000000000 ]---
Jan 12 09:52:07 mr-fox kernel: RIP: 0010:btrfs_get_64+0x11e/0x170
Jan 12 09:52:07 mr-fox kernel: Code: 4a 8b 44 e5 70 48 2b 05 f0 cd c9 00
48 c1 f8 06 48 c1 e0 0c 48 03 05 f1 cd c9 00 81 eb f8 0f 00 00 74 13 31
d2 89 d6 83 c2 01 <0f> b6 3c 30 40 88 3c 31 39 da 72 ef 48 8b 44 24 08
e9 5b ff ff ff
Jan 12 09:52:07 mr-fox kernel: RSP: 0018:ffff95c160b1fd48 EFLAGS: 00010202
Jan 12 09:52:07 mr-fox kernel: RAX: 000142f000000000 RBX:
0000000000000006 RCX: ffff95c160b1fd52
Jan 12 09:52:07 mr-fox kernel: RDX: 0000000000000001 RSI:
0000000000000000 RDI: 000000000000000a
Jan 12 09:52:07 mr-fox kernel: RBP: ffff95c13d2c6a00 R08:
0000000000000000 R09: 0000000000000000
Jan 12 09:52:07 mr-fox kernel: R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000004
Jan 12 09:52:07 mr-fox kernel: R13: 0000000000000002 R14:
00000573ab068000 R15: 0000000000003fe9
Jan 12 09:52:07 mr-fox kernel: FS:  00007fe568d167c0(0000)
GS:ffff95dfaecc0000(0000) knlGS:0000000000000000
Jan 12 09:52:07 mr-fox kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 12 09:52:07 mr-fox kernel: CR2: 000055d1eacc94a8 CR3:
00000001347a4000 CR4: 0000000000750ee0
Jan 12 09:52:07 mr-fox kernel: PKRU: 55555554

=2D-
Toralf

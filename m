Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACA774DDA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGJS44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGJS4z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 14:56:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8377106
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1689015412; x=1689620212; i=jimis@gmx.net;
 bh=pXIIxshiP85hNG9RDMDbD2hmwxBIzjlraSF1qi7XOB4=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=jdvNr9KBb14a6EtI35aHWUFF7ONcj/Fr0pubLl6FmUpZswDgpJE4cXQYZtgRN5SHl7e62zw
 /3YguAz3LNTf7QEpWCGUyIgp1Sqf3HGq30T5MVuyiA8cG+9N5IBg7y+tkWpCn+lzwdB592j4q
 uKbOc2xN63Maws+/hlSmXLBjJI/kTUot5XgAMeZLZg0Nitzs4SLrfwbv9XIDzt9P3YiulVTPt
 XTylHcj6bfyca7EyxmvFJo2zQMxnUyRQEgmfF/73WDIrK62gCpfnKaCr2qFpndF6UzDNBgdOB
 4fRQryYHfsT2DEvJVAj0g3cOd3lnvN+8GnqDH9Q2znNV/dHAhQTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.65] ([185.55.107.82]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1pkhhw3OoV-00aFb2 for
 <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 20:56:51 +0200
Date:   Mon, 10 Jul 2023 20:56:51 +0200 (CEST)
From:   Dimitrios Apostolou <jimis@gmx.net>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs sequential 8K read()s from compressed files are not merging
Message-ID: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Provags-ID: V03:K1:jJzQlhb4UudJx1r22wlnh+Kyiw48b1bR3gPNXRXTY8Zn2mWNKIs
 LLQuGp23G3TA5pSPznt1fmU8kJuD53Di9y04beyQy5rjcRNGw9VuouAQelLnNAIz5v1IkYv
 VENUDU5qsou/TVNGGHNaDrZ2nRgrlInvprunQUzOygWAkwxAx7IPfregIs6yF9ilEO+rFyU
 86+5SDf+njA2IQL2F+RyA==
UI-OutboundReport: notjunk:1;M01:P0:I373rpmVy/M=;XuRx+gsI/9SRowabC0nTGL6kFv+
 EUhlGWyJ0uhbeXuSRyGgr20yDQM0lTqvfm7FVniT7RIiKh064aO3hayo9+S07+e1ymfozINSn
 lbiXE+ZGSNsDazdTCeXwFpg+H2tu3cgm8n+Wzj2r16YTaEr9fWlbKwstKmtiwSMQfxFZZEx1Z
 SscW8Am9oSOyjCoP+aGH5RIcV920tFse7UFTFDSAbT6xp7zu9mrSmpeGz7eoyCn8+XX8oIi+T
 vWrnJOUuPhY02advECYFaCdh1mC5UxQVx4C6N+6LQpAMyxV03L1Pjx46gJKdMcM/3HE6Qjrey
 sh/sc76yjQcw//IvAAGuNdur6N8LJGVFN0X3G1WizI2P2togGDiVuME9c1Gfz334SGcW2dXOW
 xjcmJGQf8TzNQ/1tqnFX6lODAg5sXI55bjtAiZSTMnk2xWcgSiN+LzuylasyZwrhvKCiuwhwO
 93VozzApZLSl04aApWAvXXdWu1+IVpX9+FAesORAr+5jaZZMae7AT7ngwSqdxoDAWVQgg95ZL
 jTYDCqrFOjHTOG60PJwOvWXojehEF879rBQoWSoMSY8ygkFs8vbZBCyVqhVMgVY0tH2+rEp5f
 K6z3SOHbEjVMkZOEYyokJyEb/8w/1BD5fcp/iuklOhFUE+v2XdlyvSLNjjFKJ9D0diUzAlw6H
 +g/O/M3Q7MuhgYT8rsm9aCZj73CujgdMtL5/18/9H6YFN5k+jVhm8DnzZ2JnvN7puSoclgeLq
 sLYW0b4pVRFG45ZiPc7LRZ6P7AItQh3nIh297XBX00B3gneE3CgKv2PoGnGJ0QEJmcR7sVu55
 zcVHP8hW/5Y22fptHZXqmNz+lfzo0MML5EU1J+7xx152ALWm7bwa2l2aWCueacCCKLbrh35kx
 AYvKGNGz81szwGj6UsQ68z2eWrOAyNTlqGKcEebP4RERvcUuzPUjOybaA
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello list,

I discovered this issue because of very slow sequential read speed in
Postgresql, which performs all reads using blocking pread() calls of 8192
size (postgres' default page size). I verified reads are similarly slow
when I read files using dd bs=3D8k. Here are my measurements:

Reading a 1GB postgres file using dd (which uses read() internally) in 8K
and 32K chunks:

     # dd if=3D4156889.4 of=3D/dev/null bs=3D8k
     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 6.18829 s, 174 MB/s

     # dd if=3D4156889.4 of=3D/dev/null bs=3D8k    # 2nd run, data is cach=
ed
     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.287623 s, 3.7 GB/s

     # dd if=3D4156889.8 of=3D/dev/null bs=3D32k
     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.02688 s, 1.0 GB/s

     # dd if=3D4156889.8 of=3D/dev/null bs=3D32k    # 2nd run, data is cac=
hed
     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.264049 s, 4.1 GB/s

Notice that the read rate (after transparent decompression) with bs=3D8k i=
s
174MB/s (I see ~20MB/s on the device), slow and similar to what Postgresql
does. With bs=3D32k the rate increases to 1GB/s (I see ~80MB/s on the
device, but the time is very short to register properly). The device limit
is 1GB/s, of course I'm not expecting to reach this while decompressing.
The cached reads are fast in both cases, I'm guessing the kernel
buffercache contains the decompressed blocks.

The above results have been verified with multiple runs. The kernel is
5.15 Ubuntu LTS and the block device is an LVM logical volume on a high
performance DAS system, but I verified the same behaviour on a separate
system with kernel 6.3.9 and btrfs directly on a local spinning disk.
Btrfs filesystem is mounted with compress=3Dzstd:3 and the files have been
defragmented prior to running the commands.

Focusing on the cold cache cases, iostat gives interesting insight: For
both postgres doing sequential scan and for dd with bs=3D8k, the kernel
block layer does not appear to merge the I/O requests. `iostat -x` shows
16 (sectors?) average read request size, 0 merged requests, and very high
reads/s IOPS number.

The dd commands with bs=3D32k block size show fewer IOPS on `iostat -x`,
higher speed, larger average block size and high number of merged
requests.  To me it appears as btrfs is doing read-ahead only when the
read block is large.

Example output for some random second out of dd bs=3D8k:

     Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz
     sdc           1313.00     20.93     2.00   0.15    0.53    16.32

with dd bs=3D32k:

     Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz
     sdc            290.00     76.44  4528.00  93.98    1.71   269.92

*On the same filesystem, doing dd bs=3D8k reads from a file that has not
been compressed by the filesystem I get 1GB/s throughput, which is the
limit of my device. This is what makes me believe it's an issue with btrfs
compression.*

Is this a bug or known behaviour?

Thanks in advance,
Dimitris


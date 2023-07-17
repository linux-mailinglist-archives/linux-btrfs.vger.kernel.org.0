Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6357565E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGQOLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjGQOLO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 10:11:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D67115
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1689603071; x=1690207871; i=jimis@gmx.net;
 bh=wb86mtF40gyEVm9x+St9HhZWEsk0sGCSC+xXLmfI8ds=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=oZc9i/WkLM+leIsfLMkVxoWu8eKT3iTjEDcU/zzt2WsH9mweoZyujXE5NA9w6ocNiDyuq21
 JaID/duwQLtDi9OAXSpbPNSyPqJYhA8aW9mMKcIoQU2hScPPttDiKSuJslJIFx1jsTTqJpIAr
 1ZfhBfNESD6nDV2w5a69YhLAYqOU7i7y/10jCVS3sV7R2cx9kyC3Gl+RDtmHaDGBylxP7x5Nm
 yBt85BwLYIFt9t8qew51AMbzE9/w5/yTFxFzIJdbHAlWw5gfDRWnrzxqUcImMCP7BNDvlRqgA
 1hYcuGG1MzvPrNu4TsRK25LbgjWnkLzAiaUpAL2zKHwjogUfx+Dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.65] ([185.55.107.82]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1ps5dR3cER-018IiF for
 <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 16:11:10 +0200
Date:   Mon, 17 Jul 2023 16:11:09 +0200 (CEST)
From:   Dimitrios Apostolou <jimis@gmx.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs sequential 8K read()s from compressed files are not
 merging
In-Reply-To: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net>
Message-ID: <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net>
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:u79H/dPMdMoab5Ea3n3wYLrCt3yhXuwn/TIBjBGmJKE78OFqE3P
 bUGmyjX3KELwIm6P8A1ZB/Sd443jMPuSUfGVAu3+Fbk+Lav/9Hx3mU6MN4kdEUIZS70Dfec
 OeCF132HeBY5Q6OpueEUefx+Fjm77YL5ChMYHoz7Qp+M+KMCow2DIQD0XIxJoIjxFP/13Lg
 1tFj/ustpiEIpo0pwTRzg==
UI-OutboundReport: notjunk:1;M01:P0:XrhZBzXHAfw=;hvIidXK+CXKU46pId71MuRUzoZR
 Y8amitqrOiqQYTZMEgE/ZIRepaqF/MwrPSt45QV8Cs4u+hP82IRofUKz2Ogw2HkSIalDj4iV2
 Ytm9BkoXCFADlnfn2kwihqfCx1Y0HEj3GFeMxD+0DnuDt4+kLJqswfZThil7+Cjj94YXsnasw
 wNIV42sGxDRBwwB5S6yJHHArFVPKT0aBeputvLbefISARY2vurq4ITfXrxlzxeC/tym2zR+5k
 RixOYuBrqnUViKKydnPMJBru348YetxrHkehTR4YpWRo9YhAHUrkK2gpqirdcOiZ0k3vbqIX3
 D2bL7mY+WXNlLGX+AQUXWneqL3KJse945nqlZOMGCNrZmKoFL72uZsKZerSDQ+9O0CxyrdIcE
 mj+SMcX2v6Dwaf0FhI64xnX/cyZF7aArMJxsBrk5n3X3phqlx5le6AmoARQRBRCPhnA4zgEyq
 roZQV3PsbyL6UqRQ8y/WWzIV0emvYR7zTTzwspLqkkweG4TZa+VPiAPl0J4tPd1SqKxVESTWw
 bNw2ZREJVQJ9lLdEWIKQZlfPDjjTcoNQA3Q8BjWEG6kxEldjzdXblSEe3VUb4i9S0IuaePqdm
 WA29mTiKZjDINZ8sr+lAHSKYF491lq/4SciJMlB2frg9ihYaVHs0ch2Yp96vWUIq/hnE8WrCC
 eObc0Igs4M9YVm5ieS/eUNHRfZb6yf3Yc4uWg/DNHP/JWcmXypVq8Ve9t2KNPGOkmCNXre4td
 LwgLfoI9QU4HkPURMMlalJ4ZBVxpuSw7bAToo6XhlI+ZFTQqkL+g3oN3Eh7gOGkQzJ07AiA4A
 IxgTL+AulGJ4kAKmnzL/zTlwUWASn3mEMLjUjhe+6kJfnuGOP99bLmX8N1lCexXOKE4CS2zR0
 XGita6eyxsDvdHyVUCumdPLpEdsVVvmfkN9xOmZZr9dIp1xNPxqyAnitQ
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping, any feedback on this issue?

Sorry if I was not clear, the problem here is that the filesystem is very
slow (10-20 MB/s on the device) in sequential reads from compressed
files, when the block size is 8K.

It looks like a bug to me (read requests are not merging, i.e. no
read-ahead is happening). Any opinions?


On Mon, 10 Jul 2023, Dimitrios Apostolou wrote:

> Hello list,
>
> I discovered this issue because of very slow sequential read speed in
> Postgresql, which performs all reads using blocking pread() calls of 819=
2
> size (postgres' default page size). I verified reads are similarly slow =
when
> I read files using dd bs=3D8k. Here are my measurements:
>
> Reading a 1GB postgres file using dd (which uses read() internally) in 8=
K and
> 32K chunks:
>
>     # dd if=3D4156889.4 of=3D/dev/null bs=3D8k
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 6.18829 s, 174 MB/s
>
>     # dd if=3D4156889.4 of=3D/dev/null bs=3D8k    # 2nd run, data is cac=
hed
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.287623 s, 3.7 GB/s
>
>     # dd if=3D4156889.8 of=3D/dev/null bs=3D32k
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.02688 s, 1.0 GB/s
>
>     # dd if=3D4156889.8 of=3D/dev/null bs=3D32k    # 2nd run, data is ca=
ched
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.264049 s, 4.1 GB/s
>
> Notice that the read rate (after transparent decompression) with bs=3D8k=
 is
> 174MB/s (I see ~20MB/s on the device), slow and similar to what Postgres=
ql
> does. With bs=3D32k the rate increases to 1GB/s (I see ~80MB/s on the de=
vice,
> but the time is very short to register properly). The device limit is 1G=
B/s,
> of course I'm not expecting to reach this while decompressing. The cache=
d
> reads are fast in both cases, I'm guessing the kernel buffercache contai=
ns
> the decompressed blocks.
>
> The above results have been verified with multiple runs. The kernel is 5=
.15
> Ubuntu LTS and the block device is an LVM logical volume on a high
> performance DAS system, but I verified the same behaviour on a separate
> system with kernel 6.3.9 and btrfs directly on a local spinning disk. Bt=
rfs
> filesystem is mounted with compress=3Dzstd:3 and the files have been
> defragmented prior to running the commands.
>
> Focusing on the cold cache cases, iostat gives interesting insight: For =
both
> postgres doing sequential scan and for dd with bs=3D8k, the kernel block=
 layer
> does not appear to merge the I/O requests. `iostat -x` shows 16 (sectors=
?)
> average read request size, 0 merged requests, and very high reads/s IOPS
> number.
>
> The dd commands with bs=3D32k block size show fewer IOPS on `iostat -x`,=
 higher
> speed, larger average block size and high number of merged requests.  To=
 me
> it appears as btrfs is doing read-ahead only when the read block is larg=
e.
>
> Example output for some random second out of dd bs=3D8k:
>
>     Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz
>     sdc           1313.00     20.93     2.00   0.15    0.53    16.32
>
> with dd bs=3D32k:
>
>     Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz
>     sdc            290.00     76.44  4528.00  93.98    1.71   269.92
>
> *On the same filesystem, doing dd bs=3D8k reads from a file that has not=
 been
> compressed by the filesystem I get 1GB/s throughput, which is the limit =
of my
> device. This is what makes me believe it's an issue with btrfs compressi=
on.*
>
> Is this a bug or known behaviour?
>
> Thanks in advance,
> Dimitris
>
>
>

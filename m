Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABC76346C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjGZK7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 06:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjGZK7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 06:59:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5616212F
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 03:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690369190; x=1690973990; i=jimis@gmx.net;
 bh=62Anb4gsd+Sj56iapUtjPZpgI5XxQ6BJyADg/SlldoM=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=UTX7xe8rjRrkxfE7idkWCDYe5k4FRm9/cXFrhP1aEwawC1IjF1ssgShfPSfy1Xc5Z/BnZ8v
 n6769HficmTRahEmHbZTdkCXqaHPUUV1SxVg6x4xYJ6MvmRTenGxudQBBPmQ3e+gGh6pUy1WS
 ND6foY1csha2G4FzMruePH2UZROC7HKuHirjCcCKE5NfQj7Pqn2JOrtu2ZhyrkRJl8zCQ+mPr
 hsZkFjv6xi87DfYqKEgDhSHqWIXQ8sI5hOz7EH6+Xcqphn7kC1EPnz0/vY9541HmVi088NSKx
 mYCnuwPxvCTvqOyQarmSagFxbcVMp6/JYlTdUysdIul1p/KDKZDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.65] ([185.55.107.82]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1qK60z30dM-00Usai for
 <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 12:59:49 +0200
Date:   Wed, 26 Jul 2023 12:59:48 +0200 (CEST)
From:   Dimitrios Apostolou <jimis@gmx.net>
To:     linux-btrfs@vger.kernel.org
Subject: (PING) btrfs sequential 8K read()s from compressed files are not
 merging
In-Reply-To: <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net>
Message-ID: <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net>
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net> <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:IeNkvDltnD/w945WpwCWjgm+s0FOQgr3F/PVPlPQMvtQLkkMsXT
 euzylndcXyUPEOv7Nq0uay1VFgXUZkMVw+1/RY1sSL9uygA7N+ncoktVjT9n518Z3omq71/
 spnHhnDGk4r70mlsBry71EfDXncvbogb9Zd9EEqGT+23fFSO7MbE8E1HRHGd8AtjTf+OlNb
 uj+rG2lQaJo7X8KADWprQ==
UI-OutboundReport: notjunk:1;M01:P0:paBkxXfXHgg=;U78efFrX8Efw+BVustuM9jx1iHH
 8SSJGNEUdijQ+klt4nEenm0YiOwfvcJQEX/phPFkBRgbSa0SXYPpCnFbzc+MdBLwaISQdSysD
 oqkEn6B6aDyr/n4qlxc1/ax+fQ5H2sLhgDrYhItsk8AeChH4NdZdIg/uNtBCuFL6J125cp4qT
 mRdBff8cvLhRjVtWb05DGk3IokxLlrnpr6LlnKAmnH0WyDwXuaxq/BePE26FXyx77lTEsbQIb
 4IhZyR+yyT9f5UzvO8Qn9cUGaIEIWN2vXSLRu77MNlYnwkrLzHpajzENrUPAwKYAIlkDvnBx+
 VCNLY7ck32ZzeqxmrBCe6T8DZpYF5uARmeGBKueHOic42tcfi9ikd7unIlqcngPmL13YS7Lf4
 u6+Gy5Kd0FP2qxxhNZSdaPyphZ2cryWP0hSXSP9SOFpWkPL+V7OtDDeffrEFxlQJilCQrj7fY
 TkKHG/UhAQH1GwaFb9xuZS8N69a4r/zQU73vf+Bfs4BcOHflwia2GvJ1r2SEWD3ADG+j2kqSQ
 i/4MrBi+omCFJXJqJ6U2NaSW2upKTuj7vYGepuSg7j5EChWRzoA/OWzZZUeIk8W1ehmGuLi27
 xUZat+Z90diuQRwtQMDyvPG2FGPGyeYO5F7ZJ0TGtByI2BPZSCJky0KezvDB7jLHVKnc+MIMv
 srxgp4tMTFm5GEA/PQ9479aLzdLUujpMNMukpFdkkQ6/2NbTv1J+SKiXhpQkrd/tKMpEmv0S9
 Qcq/5IRg97vw+qjf3IocY8MX/wMY49ZB1asC4pP8AHHsNHQsd9uCYpUDlB9AGCAwzN4CWyHCD
 64Y5MiSnhj1UHcHzhsJjYzLfC8ffnBUmeAsG/na6vtM7IaFKubTQbMr1CiCwmW8ZqvDX/SNLt
 efPBLuADOpZIeGvZ8RGcb+GJlchnr+ZBv/2s5gWcV0Ii6l3dNMKaVpWSN
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any feedback? Is this a bug? I verified that others see the same slow read
speads from compressed files when the block size is small.

P.S. Is there a bugtracker to report btrfs bugs? My understanding is that
      neither kernel's bugzilla nor github issues are endorsed.

On Mon, 17 Jul 2023, Dimitrios Apostolou wrote:

> Ping, any feedback on this issue?
>
> Sorry if I was not clear, the problem here is that the filesystem is ver=
y
> slow (10-20 MB/s on the device) in sequential reads from compressed file=
s,
> when the block size is 8K.
>
> It looks like a bug to me (read requests are not merging, i.e. no read-a=
head
> is happening). Any opinions?
>
>
> On Mon, 10 Jul 2023, Dimitrios Apostolou wrote:
>
>>  Hello list,
>>
>>  I discovered this issue because of very slow sequential read speed in
>>  Postgresql, which performs all reads using blocking pread() calls of 8=
192
>>  size (postgres' default page size). I verified reads are similarly slo=
w
>>  when I read files using dd bs=3D8k. Here are my measurements:
>>
>>  Reading a 1GB postgres file using dd (which uses read() internally) in=
 8K
>>  and 32K chunks:
>>
>>      # dd if=3D4156889.4 of=3D/dev/null bs=3D8k
>>      1073741824 bytes (1.1 GB, 1.0 GiB) copied, 6.18829 s, 174 MB/s
>>
>>      # dd if=3D4156889.4 of=3D/dev/null bs=3D8k    # 2nd run, data is c=
ached
>>      1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.287623 s, 3.7 GB/s
>>
>>      # dd if=3D4156889.8 of=3D/dev/null bs=3D32k
>>      1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.02688 s, 1.0 GB/s
>>
>>      # dd if=3D4156889.8 of=3D/dev/null bs=3D32k    # 2nd run, data is =
cached
>>      1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.264049 s, 4.1 GB/s
>>
>>  Notice that the read rate (after transparent decompression) with bs=3D=
8k is
>>  174MB/s (I see ~20MB/s on the device), slow and similar to what Postgr=
esql
>>  does. With bs=3D32k the rate increases to 1GB/s (I see ~80MB/s on the
>>  device, but the time is very short to register properly). The device l=
imit
>>  is 1GB/s, of course I'm not expecting to reach this while decompressin=
g.
>>  The cached reads are fast in both cases, I'm guessing the kernel
>>  buffercache contains the decompressed blocks.
>>
>>  The above results have been verified with multiple runs. The kernel is
>>  5.15 Ubuntu LTS and the block device is an LVM logical volume on a hig=
h
>>  performance DAS system, but I verified the same behaviour on a separat=
e
>>  system with kernel 6.3.9 and btrfs directly on a local spinning disk.
>>  Btrfs filesystem is mounted with compress=3Dzstd:3 and the files have =
been
>>  defragmented prior to running the commands.
>>
>>  Focusing on the cold cache cases, iostat gives interesting insight: Fo=
r
>>  both postgres doing sequential scan and for dd with bs=3D8k, the kerne=
l
>>  block layer does not appear to merge the I/O requests. `iostat -x` sho=
ws
>>  16 (sectors?) average read request size, 0 merged requests, and very h=
igh
>>  reads/s IOPS number.
>>
>>  The dd commands with bs=3D32k block size show fewer IOPS on `iostat -x=
`,
>>  higher speed, larger average block size and high number of merged
>>  requests.  To me it appears as btrfs is doing read-ahead only when the
>>  read block is large.
>>
>>  Example output for some random second out of dd bs=3D8k:
>>
>>      Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz
>>      sdc           1313.00     20.93     2.00   0.15    0.53    16.32
>>
>>  with dd bs=3D32k:
>>
>>      Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz
>>      sdc            290.00     76.44  4528.00  93.98    1.71   269.92
>>
>>  *On the same filesystem, doing dd bs=3D8k reads from a file that has n=
ot
>>  been compressed by the filesystem I get 1GB/s throughput, which is the
>>  limit of my device. This is what makes me believe it's an issue with b=
trfs
>>  compression.*
>>
>>  Is this a bug or known behaviour?
>>
>>  Thanks in advance,
>>  Dimitris
>>
>>
>>
>
>

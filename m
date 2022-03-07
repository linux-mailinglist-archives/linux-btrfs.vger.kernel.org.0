Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2394CEF06
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 01:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiCGAtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 19:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiCGAtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 19:49:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD51AD9C
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646614098;
        bh=M5qFkzqz8KeSOvOq5RXu/HcLUjJ3HhStDrfr2IvAUsU=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=h3IZeaubdFW1XT0mE8o5YWtjTDoI/9Mm0NLC1XQg+o/oo3eNYlLuxD02z/kbNXW6m
         xB0HULelLevCjpf+yPEfKuFU3bA8UPuOxjfjANKWMMkPoBCTTc+vzVk2zb9ppr2UEU
         Z/hWoCcvX9Sj2rulBVkKXnAz0+NE1VybFI4nyMwI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJmKh-1nkULA2zYf-00K8mB; Mon, 07
 Mar 2022 01:48:18 +0100
Message-ID: <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
Date:   Mon, 7 Mar 2022 08:48:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
In-Reply-To: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2OxEo8FmuJFvh6JtyfZq/1usKJb3sQiuPliI2hFgkwLQuwxq+hP
 JWQNAaXIcDVp3weEBLp+bguCbW3xjVGl+xDcIg+S2GOM3HnKLBykPeA6+yl1ZTAPnTdXF6+
 KP3kD7M3lgnFRaU5XDALZPtvmv302+1xu8/Fk2l1Eo1CD4rDHQP7wQx47Kn80VIN2D775ss
 a15HV5nPdP8ekBK278ePg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BqYWiu4rViM=:R7HrlbxGoSff+AcG/ifQ31
 jGTi9NEgyJT/lEsqm4NdVbRllUAYSTjmuKYba/CMCq4v/c7sxrHt3eDhol/r9mY4MK9E+7eOv
 j4rVqVs+aHIhuIKW0+Lb36C2O153StIxhMuMxTvpDwu+bNXRKuyFxEdOoGyRCiJ7K9gNjKSC5
 EjJxO0hhYwkysZWPiRouDHDGJVuiwOwIRJcI49KvlVwX3GKwYFo7sPKlTf1Tqx85LcYMz7oWw
 QEt3nUGwpxl3oo/dTV6+4lW1j4NoItKWcRuISRpR3+MBEkpCF7Cdvo4alSoHfN49VrIGGR8RS
 uQ0DT4T6PD6y9fHS2x4iiFHXR1e80BrY9vAg8eviCU7wxc4sn6BLshznXbA2GMXHvdcHWHRZr
 mKTWY0IXsIH2ZPklKsDvmWfSI5AZqkZEPTZZZAfZt85HiaVy19qMl0LSS4FTqiTRoGJ6bhuXW
 u9/4HlKdGArAvpfvIvt+BdEx3uCm1sYGl8yAVCBSwHPWN5fQcy3EGsvo5DcyBavBR2pXuBuX7
 oMqqIqZt90/NDzWbKNMy44rdzHaQIWd54JCMTWVevan12k6D7E0+5j7vuff/dx4XLsrmkLANh
 NUxu5qPcn72U0rayeqXsCbcE91xQS6y5yvL6zNJgZGeG2Q1ELrtVbDXUr3zdhUbBjgFAd//gd
 DOTDOoTwUumBOdwfdB+CDT30fJn+66Mfue0Q7yyuBLl3TDMnGZGboRCza6KsyFjwEPehAIynd
 5alHAqmCLHummo2Og9gaDN5LhWVF0zgRcmNthGizEEOMSYbWQ6lsDynvjljPxMVEGVucuvPDN
 S4vkFspLhV9e2ASbWNm7mmZNpU4niMagbVaKCTkMlX1bYpQiAhRC4ZrpGCRt/BcSLrXme+prv
 qp+W3x1MfaTZLZd5umfsF5sR3s4GCJRzR73Ccr7owvr7l4J3JmbEj0zNNIVoUnpUvpHF/ELFn
 5ZMZ5isOGqcAapP3ekTRDpbr4CDhquvQYfC+HJQaGaN9g28R1bX8ISaAjQk0PlxSVkiO2uq/n
 mpJ5TnkTC/lozR6OEc7rDI9YL/9R2XiFlBXTZjahur/EL+ZKg9k1hDshxU6OC+0DEm2hUoLPD
 9COnlb6KKvXX1c=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/6 23:59, Jan Ziak wrote:
> I would like to report that btrfs in Linux kernel 5.16.12 mounted with
> the autodefrag option wrote 5TB in a single day to a 1TB SSD that is
> about 50% full.
>
> Defragmenting 0.5TB on a drive that is 50% full should write far less th=
an 5TB.

If using defrag ioctl, that's a good and solid expectation.

>
> Benefits to the fragmentation of the most written files over the
> course of the one day (sqlite database files) are nil. Please see the
> data below. Also note that the sqlite file is using up to 10 GB more
> than it should due to fragmentation.

Autodefrag will mark any file which got smaller writes (<64K) for scan.
For smaller extents than 64K, they will be re-dirtied for writeback.

So in theory, if the cleaner is triggered very frequently to do
autodefrag, it can indeed easily amplify the writes.

Are you using commit=3D mount option? Which would reduce the commit
interval thus trigger autodefrag more frequently.

>
> CPU utilization on an otherwise idle machine is approximately 600% all
> the time: btrfs-cleaner 100%, kworkers...btrfs 500%.

The problem is why the CPU usage is at 100% for cleaner.

Would you please apply this patch on your kernel?
https://patchwork.kernel.org/project/linux-btrfs/patch/bf2635d213e0c85251c=
4cd0391d8fbf274d7d637.1645705266.git.wqu@suse.com/

Then enable the following trace events:

  btrfs:defrag_one_locked_range
  btrfs:defrag_add_target
  btrfs:defrag_file_start
  btrfs:defrag_file_end

Those trace events would show why we're doing the same re-dirty again
and again, and mostly why the CPU usage is so high.

Thanks,
Qu

>
> I am not just asking you to fix this issue - I am asking you how is it
> possible for an algorithm that is significantly worse than O(N*log(N))
> to be merged into the Linux kernel in the first place!?
>
> Please try to avoid discussing no-CoW (chattr +C) in your response,
> because it is beside the point. Thanks.
>
> ----
>
> A day before:
>
> $ smartctl -a /dev/nvme0n1 | grep Units
> Data Units Read:                    449,265,485 [230 TB]
> Data Units Written:                 406,386,721 [208 TB]
>
> $ compsize file.sqlite
> Processed 1 file, 1757129 regular extents (2934077 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       46G          46G          37G
> none       100%       46G          46G          37G
>
> ----
>
> A day after:
>
> $ smartctl -a /dev/nvme0n1 | grep Units
> Data Units Read:                    473,211,419 [242 TB]
> Data Units Written:                 417,249,915 [213 TB]
>
> $ compsize file.sqlite
> Processed 1 file, 1834778 regular extents (3050838 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       47G          47G          37G
> none       100%       47G          47G          37G
>
> $ filefrag file.sqlite
> (Ctrl-C after waiting more than 10 minutes, consuming 100% CPU)
>
> ----
>
> Manual defragmentation decreased the file's size by 7 GB:
>
> $ btrfs-defrag file.sqlite
> $ sync
> $ compsize file.sqlite
> Processed 6 files, 13074 regular extents (20260 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       40G          40G          37G
> none       100%       40G          40G          37G
>
> ----
>
> Sincerely
> Jan

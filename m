Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF03549B5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 02:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhDFAc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 20:32:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:36243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235787AbhDFAc0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Apr 2021 20:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617669137;
        bh=DqaJhd/qRPKPU09Bf2IE30ju3XiNSvc4k6lgOh4fhd8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AphWwW0b8ytiAuNJx5YUr2ZJN1xDJFHvRkyC886IKiqRsdLq7mssF/z9a6lexuxnE
         s855doAAOFXY6lQFtD7uzMw0M/Q3fkPtEh1tm1vsY90r4YH++Rcl5V9UcqJzQ4yiTQ
         zst2d242rHmKFvdUPRkEYyHm9YrkhRFIccJLpMy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My32L-1lnaSl0CqN-00zURo; Tue, 06
 Apr 2021 02:32:16 +0200
Subject: Re: Device missing with RAID1 on boot - observations
To:     Steven Davies <btrfs-list@steev.me.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b9c77dc7-8c72-7c64-9ce8-bcb4555de0c0@steev.me.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b2a00975-4bde-11ba-d0e4-1e15ec3afb4c@gmx.com>
Date:   Tue, 6 Apr 2021 08:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <b9c77dc7-8c72-7c64-9ce8-bcb4555de0c0@steev.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:js3vvgKDKBgMzZYBZqMveOShAPpxL19dsXLclPypdY1SC3XiSp1
 nBxONaMThNls62/iZRDLwvHHcPJCUWWCtkDH7uDj1AP9zzb8w7gYjLUU7SQiCozyuFde+Uo
 0xxRTa7utnmHxEaKOw9JplkuMaewB+mg+pzawWOvsqxPlrrei7pUO72l1jXnddVVoudUNtx
 W/MaYFlWM9setbwLvqzIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aiu4wijszPo=:p6Ap4SRuTbsAJOdb3zygej
 YHBSZyZhUk79oMZ7aoRZalAPb8F6T7M9tWYovkTj9ht6M/x78upVYjXPtXqOZntUsMx52/EEs
 i8Vm5fHCRNw4H95tPZ9sPC9NE7hI56Fa+TTFO7byRXIwmSAZ/RPyZ+rmzbdfE4gj9I2kUFE2D
 sdWU2JXHfDyJNimgueWS4QnVpyB69iMlDrWcdFhEv6SFATjGWeiVlHC0Xdlm9K1eKp+Mpe/oA
 IM/8gJBeiARHs/n8LCcv0EHMFjAeGFp568tThwI1Jh2JzwYxWT2n1Zpd26oNdRfo2ArW0DMpp
 bRN6TLQC/F/wtPqkdFlzhvlOTHHvUNh5mq/ilVEC2dqfrcsCQfZ9u12EgQPUknNllce83zzAV
 yx2QGZiVBIziXjTagGQnbgAizwGrMSSluKPBTlw0EaQLWQ6jFXLrhEqKOqZWPaSP0JwJQSqoD
 t/5yI7CJakMfLrIsS/G+cCKYMCYO/j6h0mqCRojELe5pRy3Ni9fnHKmLy30nrkt1bECpgG+8S
 vd/IIjKYamRdj4D8+INh2mLxzlPaPauLg6gVxu/3Nt2fqopnZvNGTojc241P+ppP1L07q4Qr2
 hO3R+Pcn/fYYRJUUVJbPpwED/o3t0fXVcLmxu/6bYzoQWQDJmNd2cQVP72LxP3/ZNc+ByJA5I
 43BiYWWbGqlgjA0CIc557V4b65Lx/lferay5K+tEwe3yWWRJK+qw+1i1QmnaEnHrBWDFPAd1o
 w+2aPaXv3XA1H4GlspXHWfUR0lpG4CHINExRpZp/fWBDQb88ymMQP8nuKp9R+pzmCZbEwp/XB
 R9DRaHF6ecgWgoCrMwA1z7Lh/wRNHqD2VW4c/dqmeoFEJ1x83oQfEdLbNbekr9h5O9vdf8RAm
 77b95eVlGOM/ew3NgXRk3eidanYZoPiirqxRiHuXAG/CD+415iWTDrddlwJsTkBtgSP/tiYIC
 fY/JkZsYDNQbd+azKbVR5L8qZp0617hs1q3yaaeF0i7UCdlS3MQHZkFOVCRxWjHF2CfaGBoXv
 QHGTleoh1HCKPcf3c8+G5r3ptpJ1751RF8BvtwMNlcPrbkiJuuTqnIBWVZX+JhoXPllKiZT8L
 QLHEN2n2vxztd+oAMOTiENFzjaEHHMfLc/2TF/b9oDW21nQpnvooFG86NQYHlCBrYnxXOMCpu
 LbZb4anag2IekVIY33ebqNuo+mklSEKe0WcqVKon681qLezSqPY7MhJSh0NCDaALvzGZdfbz1
 3cjLb6I6O3giKxwwD
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/5 =E4=B8=8B=E5=8D=8811:18, Steven Davies wrote:
> Kernel: 5.11.8 vanilla, btrfs-progs 5.11.1
>
> I booted a box with a root btrfs raid1 across two devices,
> /dev/nvme0n1p2 (devid 2) and /dev/sda2 (devid 3). For whatever reason
> during the initrd stage, btrfs device scan was unable to see the NVMe
> device and mounted the rootfs degraded after multiple retries as I had
> designed in the init script.

It looks more like a problem in your initramfs environment.

The more possible cause is, your initramfs only has driver for SATA
disks, but no NVME modules.

You may try to include nvme module in your initramfs to see if that
solves the problem.

Thanks,
Qu

>
> Once booted apparently the kernel was able to see nvme0n1p2 again (with
> no intervention from me) and btrfs device usage / btrfs filesystem show
> did not report any missing devices. btrfs scrub reported that devid 2
> was unwriteable but the scrub completed successfully on devid 3 with no
> errors. New block groups for data and metadata were being created as
> single on devid 3.
>
> I balanced with -dconvert=3Dsingle -mconvert=3Ddup which moved all block
> groups to devid 3 and completed successfully; there was nothing
> remaining on devid 2 so I removed the device from the filesystem and
> re-added it as devid 4. Once I'd balanced the filesystem back to
> -dconvert=3Draid1 -mconvert=3Draid1 everything was back to normal.
>
> My main observation was that it was very hard to notice that there was
> an issue. Yes, I'd purposefully mounted as degraded, but there was no
> indication from the btrfs tools as to why new block groups were only
> being created as single on one device: nothing was marked as missing or
> unwriteable. Is this behavour expected? How can a device be unwriteable
> but not marked as missing?
>
> Was my course of action to correct the issue correct - is there a better
> way to re-sync a raid1 device which has temporarily been removed?
>
> (Afterwards I realised what caused the issue - missing libraries in the
> initrd - and I can reproduce it if necessary.)
>

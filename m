Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19E5734B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiGMKyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiGMKyt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:54:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3DFF582
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657709683;
        bh=071PoNvaSIyQtoGGrJSadLaE5joiorhPrebMd+NYWpY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=lUfeXPLp2Sl0mP7NBET7HkXBDb3RfLMcbp4i6k1Z14jcs8f3LDnePgNfvVat5r02d
         YqmjkliBL61rZ3RjurjsmJFmAlxFMk14+thGHClpu+NK5D47iLL/ShVzEHw62AdeJ7
         PujjeuEBz8E8NO8aJe+XJxFucrCGG41Cvoc4X8zc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY6Cl-1o4DCJ38Un-00YSeI; Wed, 13
 Jul 2022 12:54:43 +0200
Message-ID: <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
Date:   Wed, 13 Jul 2022 18:54:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+QdTGd1nY97Lo8c/N/cyT5lGWL3OC+g/kXjoORuiq6+m3cSZUCl
 MmdwmZG/JEhiuBX/qLEBp+i2ohPMLAag7T6Zxx18sx0AW+ahf6SetERBJYA/OKe14T79yHs
 j9Mjh2CXNVAgOikDiYlQnx3Cb/eOqJeSgB9jN07OvGtdaM3fPI1ErpU4ijHqrNqg29vyNxG
 uwCQ3QaDr5ayhlbRcmkbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2N3q2Al1icI=:SQyKF8SNya3OHxRdTfO0/5
 f/jGN7p03iqfyKgerhplu1InZ97/zzl1hcoBDkaJ2Qk51WgG7+C4KCZTCrE2c90GXoSn/NJLE
 aoD+dvkdr21AV+WZFbVTOqTipHmkr6FE9z12aMs/cVl+5WDJBKorhVi0Vt2ujNuewR8DAxDeV
 w6XenwjVoORwBFeLVsGsgwgMURKWSyKrsoqytlrsp3GzMxL894mW/qWSuZGtD3wgWwBPDIRV/
 Kbe8buyKe9+WIiL8DRF6pooxoDSBz0y/08LUxDtlUKrYGp8dyqnRWZfTnzkplMLq/wm4merj8
 Fay5qxm+YOmSyWtyNpaELld98Xm4edpKGA1TOPiiwbKIPkeKuJGqMFnmEX6fvRygg54VJ7gsL
 z5T+0xNsSYaOONDD/ICk66ZsK/rsgJ9QNT4ZcNSb3KEDukbwDYmyXDKD5yCSv5akzk4nEcgMZ
 kLMkP+lcNCCvGhmtQ8vlNOT40KqUIxREFsyQmm+fCwHjCzXxu9Ig8ZOTbWagLkckeI9BCHt+y
 NB+0eJ2jzi0Npa28GUjla4I70XqK/f37lArGmMxpu9pJ7tLmDAAbSLnxl6oH9QmubltAKdvRv
 UTvnwadfppsHDlpGIlANcVqtcj79QcAALtuaH43cClzgML6uhMuhsRMsaW5o/71PbVLCRSXWL
 D7e1KJ2BwJW43YMfRMorNM6m5q0L3ASDbUQy/lSVYB3FaeBQEltvuX86GmVpyH3CrZMZQn3ms
 4Y9mM1pSMcc8ZRN0sP6RmjY3H8DIDCuahdHa7K8uhWnupRV+x7ftukW5NmvZ0BRDMTyoSGtI7
 YyMzE6bFWs7qMQoJXjfGg83VITy8d0ven7XLNrVdjv4gxXCKfOeYSAVo66yYchMsxT+QZCXpU
 V/5d4jK0wKoL2YnqKvvZFhV8ebE+iFOlRagiLbEodFmrqzd90/b8ILcQYolbc4CWhCg59Yeap
 ViyiY1WO5lKz2pCUfmS9iQVxMszIIEYI/vcMep/0rxS+1AYN9K+amSDG9tpdhYDIWEZuUUlzA
 B6KImT7Wf2kB4PMn5p48VadHnWlvCJSfx/q5YOjfNraHwZ4hygssDv6/xrdqOxhzmpdV39MrZ
 nsmS5TskJlvTl2bly2wF0Zv3bPz/8AnzdcgpLhSepqGgThE2fGzv5lGFQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/16 22:31, Johannes Thumshirn wrote:
> Introduce a raid-stripe-tree to record writes in a RAID environment.
>
> In essence this adds another address translation layer between the logic=
al
> and the physical addresses in btrfs and is designed to close two gaps. T=
he
> first is the ominous RAID-write-hole we suffer from with RAID5/6 and the
> second one is the inability of doing RAID with zoned block devices due t=
o the
> constraints we have with REQ_OP_ZONE_APPEND writes.

Here I want to discuss about something related to RAID56 and RST.

One of my long existing concern is, P/Q stripes have a higher update
frequency, thus with certain transaction commit/data writeback timing,
wouldn't it cause the device storing P/Q stripes go out of space before
the data stripe devices?

One example is like this, we have 3 disks RAID5, with RST and zoned
allocator (allocated logical bytenr can only go forward):

	0		32K		64K
Disk 1	|                               | (data stripe)
Disk 2	|                               | (data stripe)
Disk 3	|                               | (parity stripe)

And initially, all the zones in those disks are empty, and their write
pointer are all at the beginning of the zone. (all data)

Then we write 0~4K in the range, and write back happens immediate (can
be DIO or sync).

We need to write the 0~4K back to disk 1, and update P for that vertical
stripe, right? So we got:

	0		32K		64K
Disk 1	|X                              | (data stripe)
Disk 2	|                               | (data stripe)
Disk 3	|X                              | (parity stripe)

Then we write into 4~8K range, and sync immedately.

If we go C0W for the P (we have to anyway), so what we got is:

	0		32K		64K
Disk 1	|X                              | (data stripe)
Disk 2	|X                              | (data stripe)
Disk 3	|XX                             | (parity stripe)

So now, you can see disk3 (the zone handling parity) has its writer
pointer moved 8K forward, but both data stripe zone only has its writer
pointer moved 4K forward.

If we go forward like this, always 4K write and sync, we will hit the
following case eventually:

	0		32K		64K
Disk 1	|XXXXXXXXXXXXXXX                | (data stripe)
Disk 2	|XXXXXXXXXXXXXXX                | (data stripe)
Disk 3	|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| (parity stripe)

The extent allocator should still think we have 64K free space to write,
as we only really have written 64K.

But the zone for parity stripe is already exhausted.

How could we handle such case?
As RAID0/1 shouldn't have such problem at all, the imbalance is purely
caused by the fact that CoWing P/Q will cause higher write frequency.

Thanks,
Qu

>
> Thsi is an RFC/PoC only which just shows how the code will look like for=
 a
> zoned RAID1. Its sole purpose is to facilitate design reviews and is not
> intended to be merged yet. Or if merged to be used on an actual file-sys=
tem.
>
> Johannes Thumshirn (8):
>    btrfs: add raid stripe tree definitions
>    btrfs: move btrfs_io_context to volumes.h
>    btrfs: read raid-stripe-tree from disk
>    btrfs: add boilerplate code to insert raid extent
>    btrfs: add code to delete raid extent
>    btrfs: add code to read raid extent
>    btrfs: zoned: allow zoned RAID1
>    btrfs: add raid stripe tree pretty printer
>
>   fs/btrfs/Makefile               |   2 +-
>   fs/btrfs/ctree.c                |   1 +
>   fs/btrfs/ctree.h                |  29 ++++
>   fs/btrfs/disk-io.c              |  12 ++
>   fs/btrfs/extent-tree.c          |   9 ++
>   fs/btrfs/file.c                 |   1 -
>   fs/btrfs/print-tree.c           |  21 +++
>   fs/btrfs/raid-stripe-tree.c     | 251 ++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h     |  39 +++++
>   fs/btrfs/volumes.c              |  44 +++++-
>   fs/btrfs/volumes.h              |  93 ++++++------
>   fs/btrfs/zoned.c                |  39 +++++
>   include/uapi/linux/btrfs.h      |   1 +
>   include/uapi/linux/btrfs_tree.h |  17 +++
>   14 files changed, 509 insertions(+), 50 deletions(-)
>   create mode 100644 fs/btrfs/raid-stripe-tree.c
>   create mode 100644 fs/btrfs/raid-stripe-tree.h
>

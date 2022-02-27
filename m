Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6D4C5FE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 00:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiB0X1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 18:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0X1K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 18:27:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A306C1E8
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646004390;
        bh=xSlXO/6CoBkks3fu4+unf0mI6rVW1+wnEOv7RDFl3RY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=R/yfhr3uFrCsY1nT+mLX+Gz/rGHHWf4tcO2ww/NNLAspZcgEV3lM+NsNpDgDQ5QTu
         Zi3k6tDCd9Rnzqc4CE7jg+1OgOyE1nSy7mOnX/Wq8qfkw2A90KjelYdLR34FRU53Dl
         QsEcB6pl9EhXpS3FSnblkR/cymD5w2Mb/U1s1Yps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1o0ay70n86-00pLIy; Mon, 28
 Feb 2022 00:26:29 +0100
Message-ID: <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
Date:   Mon, 28 Feb 2022 07:26:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dVjCQc8ksB1lBYwXaSfzPFk/GpbD/Aid0jwEK4kDgkZXbKqsMn+
 rueaSlD+xoIFgSpqV17HPDFjp4KSfDo5dc+pqczeZqMvr+bgd4nTl1EIwC+HVcrX4e99xo+
 LRDJPnUEHRI17hPnjVPAsHzaABN4DzR6EEKzVaVGysjc5zP6p4CmfhmHj0tid0Zfkbh+gd5
 UmK3wSoYUi6rcQX9l4oUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBWWejWue6s=:P7/JI20kWXHGbJLboxYhMW
 0rvqCd9UgnwOfWMOWeJkgoQhzRUZ+NDWArsCUd3LF2MmOteCzaENOlprrjYTvASLkcosAqiKU
 9W1jXoGvt/XcOlSwaYNGY5LPkt/enPR5LOpqeRPqiEIiVaLG3oY3AoYBRvIAApdOr7UI8Xn6l
 ElGDda5i4vjL2A8WVrzf4ehBuBKTbN78r5wIcv8lGGzEu14zZES+3B284uskWSnrwuIoN5fAY
 +WnZp72wiHhKfEtwHK4k2W3e2nPNBw1U2ufwHMy076m5V2IgWgsNL0c0LeN8qv3zMROYkHMVk
 c8Ah5bopcoKx7g8zlEP5asrKod1+Rw+OGBn6hcQWaI7EMfAa+sgwHUVez9Qs7Pf6UenoZ5IIb
 Zw2FVcmT5DpsZGHM8zsrIf/8PCaXZdtK2HsAJDWRt3LNz0qFhum5bnRVjBiovwpIKR+uwc5UC
 OGSgINHNDmmUe06dox/bGzMOYBCa2PpV5gtqwUSSOfh5FIU0eaCZGKKwrT8u7BhiBXNmOyLXv
 QW7GOId0yKPt3AnkchJzr5eXDhUJBVnHN/O3GNkZLJ22UyJfiYaJMeXaLwdQPrp7bKiUx4K+k
 jKgtukYgV4cgexTBkgz79iTt+b5vvk+Jef/js1OFBtVhcaks+Nfl0n19lc5Lc7rNsSdnJSR+E
 V3YJpYhb43JaXIwOynurtSf18NgGzBECYCW520pGEX5sKh9R+OD42XtT6UqLF+8X34jLhJ2sK
 rGl/GrRSvhj/6qPl+tw0iJbinwAiY28VrYQ+68L6CpKRuwQsUHuJCOdCQNWDM6UTVRbxsu09I
 v+ZYDznknCSC89jOoM15qzSdft7fVj85tuD/J1hc0aQOfSbMpVElOlQdTPJrlS1FJF297mngS
 PswwR/B60X+E3msXs8G7DSH/2xxWzbDiXw1nY30ajD07OHUqS5uW1SsQaTMaNGVjIwhiylHJZ
 nkb3aJ4uquNajxNZwxGIi3dxFzbwfZxJtQSJcZiKVjD7nQISw0xPQhx7NFK/8axIdyETN8Mno
 crBf2o7Vspam4qXPvL4asLufQTL/NjM2tYCjdGa6Hkn/WOBmNGRy/AL0HUWy0BEXmXCKHtol8
 h5FbgcCHXPcbSM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 01:45, Christoph Anton Mitterer wrote:
> Hey.
>
> This is on 5.16.11, Debian sid.
>
> This filesystem has existed since quite long (is the one from my main
> working notebook).
>
> Today I was doing a full backup onto another btrfs, with:
>    tar --selinux --xattrs "--xattrs-include=3D*" --acls --numeric-owner =
-cf backup.tar /mnt/snapshots/2022-02-27
> in which /mnt/snapshots/2022-02-27 is a snapshot from the filesystem
> with the issues.
>
> While tar was (or actually it still is) running I got these in the
> kernel log:
> Feb 27 18:35:10 heisenberg kernel: BTRFS info (device dm-1): disk space =
caching is enabled
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22

I checked the transid:

hex(262166) =3D 0x40016
hex(22)     =3D 0x00016

So definitely a bitflip.

Please run memtest on the machine.


For the btrfs part, unfortunately tree-checker itself doesn't yet has
the ability to verify the transid of a tree write.

I may put something like check against last_trans_committed, but that
definitely needs extra check before doing it.

Thanks,
Qu

> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511299584, 64511303680)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511303680, 64511307776)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511307776, 64511311872)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511311872, 64511315968)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511315968, 64511320064)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511320064, 64511324160)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511324160, 64511328256)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511328256, 64511332352)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511332352, 64511336448)
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hol=
e found for disk bytenr range [64511336448, 64511340544)
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601640960 csum 0x62c2c721 expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601645056 csum 0xff51e027 expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601649152 csum 0x681a44cd expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601653248 csum 0xbbfad1b7 expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601657344 csum 0x09ae86f1 expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601661440 csum 0x09ee43ad expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601665536 csum 0xaae8fc18 expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601669632 csum 0xe6d04b46 expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601673728 csum 0x3e49bf9d expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
> Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum fai=
led root 1583 ino 1354893 off 601677824 csum 0x08695db5 expected csum 0x00=
000000 mirror 1
> Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/=
mapper/system errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>
> And this in tar:
> tar: 2022-02-25_1/home/calestyo/cpu-tests/test-vid-high-res.mkv: File sh=
rank by 334726574 bytes; padding with zeros
>
>
> 1) Any ideas what caused this respectively what it means?
>
> 2) Can I check whether this is actually the file that caused that
> issue?
>
> 3) Can I check whether other files are affected?
>
> 4) Is it recommended to recreate the filesystem on dm-0?
>
> I would have a number of generations of snaphsots of that filesystem,
> also sent/received onto another btrfs, if that would help anything for
> debugging.
>
>
> Thanks,
> Chris

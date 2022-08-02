Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92EE587709
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 08:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiHBGSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 02:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 02:18:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A8F5A0
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 23:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659421078;
        bh=L+XV5MrwRJh7BBVV9DLOKbRXX4fr0DRkP6ufcOKdVRM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AZgKy2agGNBeGZJHbjBHTThSJcir5rHj31AluG2/pR4moVVOBjhe0T0/l/2NSE3sa
         Y24DGUchfy7PrBmCxMVetNt2mZG7BzJHqt9f7DjnIXiJLmTSWEAqJ8/ddi169V21yk
         EHRKxRVXxQj3uBLRtIj73Zc6yymnhu8A8D14a+cU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1nKeId46rO-011UC1; Tue, 02
 Aug 2022 08:17:58 +0200
Message-ID: <75e18a61-b868-764a-50e5-c6df7ade326a@gmx.com>
Date:   Tue, 2 Aug 2022 14:17:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: mkfs.btrfs failure on zoned block devices with DUP metadata
 profile
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220802060323.khfjqwhwwbpjbegb@shindev>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220802060323.khfjqwhwwbpjbegb@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b3a3P16b6XkM7sGqHntFMXUieTlXLTWgB9oZHRCUeAL0r93q/2J
 CZrH3u0fhYMvwl/+HD9lPM6D6re5F/70SZUYhJWAvXv9wef8v8Ovd3XpH+SkV8YkM6qtMza
 57EzkOoxPw+BPis6YmLBUZQJueC3obw/CEpgpsGR/fY0hd+yCBLGndJNMX8F1qd0+ChgTLW
 8sCJMsXr1jjezghSSVatQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMKYzoZr5r0=:GarUEKRBf5aTzYGMO5wgMJ
 KxjR5cKT+JIOT0YOpOCgP3iZsV33h1wlXzjoUiAVAmApG0S2AtWB6sFJdc7fpqV9kWEE60FV5
 yD9GDpTToMHXzsJHuqcQIDb6KHwZTa+9tV5UfroAbS7BkC8RMuThq9qkO9qfJWe3NfF8DtLAr
 54At/YmhE46IcnUUrPZhCCk63pOZlVOiFeOgiYA2Cg6gs3JBGTlZpC565fpmcGhsrnWUFsJp9
 vCEE+JFF6MAxhlMNkSebUvAtgas2qtMAgHEhtGTleEVX7YUPQIJrpuEDRqDGNo4k5nVfOkq8w
 WiYXFjJQOrrb2KOSF94Jp02MUHd1I17KaUfvqKWk+2QFYHl2SsGT9RqJsxJcZKBdNjPC+Bckt
 wa8IBdzhoiUj+Drl7a1dQ8IqwUUtzx1LNVt63rCRrLmocXZxk/N7KKtqKIpQc8eMRXVkX0ELO
 gWGRhNicV5A/BMBsLxlsi7IeGAwgogBEWM3daQ7oHoROmnIHgW41r9Wej3ocqdcfN+buyCP/n
 82dBOvKBqUyXa4aebZSEwk6gpK9ZHDe0Gm9HI2jeXbNUSTNV6+HNflUoH7uINnPCanRSVjRoj
 18EP1k5exQ9n31HPBxycVcmzeTE1TwaHQGI14KEtvqryErJW6vuBp3LiJ3F1QGz4PgcyD8quh
 DAIXIj5HghcWM0ZzAh205hqmffFpMvpM+ICznN1aOlplBdQZynduUkE8gR+iV3acTDhuGiZkT
 YM+lwvyTbO3oSh1QmJCVu01S9YVft3anBRKEgAl2J1dXqs2ZFl/QUlZW1CC0SbEasnhsPQ4is
 +R6tb0BkNd6/StNdqnxOWHML8twP7dllWNTjgIiVzmAA+Fi8gtic2EPt7uUdq8AIDQWU1DjMd
 HoXLSY/jxmr/I7InDXI618sI4n0yd52axKRiTtBePzSQKkhAisg7CE8Giqxtdlk7HxV4G8Z78
 DzJJnBfHS0dXW9qJCqVOiIxfftUaPTfAorw0UdfJxRZG0rtvZWkjMVPMsULCM/yRxP/2Utt+H
 pbDARPV/FJ9R3IxVlSBiPvDAiw69Y6fn77yq9eGD9KTJ5Bf6K9MSWJac0mbrXs0nn77Rmc80d
 nef4hOclL34Llen3WMgqav/bJtu6M0mghZFQg/nczcO68lDE19sA1/wmg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/2 14:03, Shinichiro Kawasaki wrote:
> Hello Qu,
>
> I found that the latest version of mkfs.btrfs fails on zoned block devic=
e when
> DUP profile is specified for metadata. The failure depends on btrfs-prog=
s
> version and the trigger commit is 2a93728391a1 ("btrfs-progs: use
> write_data_to_disk() to replace write_extent_to_disk()"). After some
> investigation, it looks for me that this is a common problem for zoned a=
nd non-
> zoned block devices. Here I describe findings below. Your comments will =
be
> appreciated.
>
> On the failure, mkfs.btrfs reports "Error writing" to the device [1]. At=
 this
> time, kernel reports an I/O error, which indicates "Unaligned write comm=
and
> error" to sequential write required zones. With strace, I observed that =
the mkfs
> writes data to same sector twice. This repeated writes were observed reg=
ardless
> whether the device is zoned or non-zoned. It does not cause an error for=
 non-
> zoned devices, but it causes the I/O error for zoned devices.
>
> Using strace, I compared the write to a non-zoned disk image file before=
 and
> after the commit 2a93728391a1. It shows that the commit introduced the r=
epeated
> writes to same sectors [2]. Is the repeated write expected after the com=
mit?
> If not, common fix is needed for zoned and non-zoned devices.

Thanks for the detailed report.

To me, the repeated write is definitely not an expected behavior.

Although a quick glance doesn't show me much hint, I'll definitely look
into the case.

My initial guess is write_data_to_disk() has something wrong related to
the mirror iteration, but no concrete conclusion yet.

I'll definitely keep you updated since this incorrect behavior is now
affecting zoned device now, and it will be treated as an emergency.

Thanks,
Qu
>
>
> [1]
>
> (/dev/nullb0 is a zoned block device with no conventional zone)
> $ sudo ./mkfs.btrfs /dev/nullb0
> btrfs-progs v5.18.1
> See http://btrfs.wiki.kernel.org for more information.
>
> Zoned: /dev/nullb0: host-managed device detected, setting zoned feature
> Resetting device zones /dev/nullb0 (64 zones) ...
> NOTE: several default settings have changed in version 5.15, please make=
 sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
>
> Error writing to device 5
> kernel-shared/transaction.c:156: __commit_transaction: BUG_ON `ret` trig=
gered, value 5
> ./mkfs.btrfs(__commit_transaction+0x197)[0x4382a6]
> ./mkfs.btrfs(btrfs_commit_transaction+0x13b)[0x43840a]
> ./mkfs.btrfs(main+0x171c)[0x40d64e]
> /lib64/libc.so.6(+0x29550)[0x7f5108629550]
> /lib64/libc.so.6(__libc_start_main+0x89)[0x7f5108629609]
> ./mkfs.btrfs(_start+0x25)[0x40b965]
> Aborted
>
>
> [2]
>
> $ truncate -s 1G /tmp/btrfs.img
> $ git reset --hard 2a937283~; make -j
> $ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/=
btrfs.img |& grep btrfs.img > /tmp/pre.log
> $ git reset --hard 2a937283; make -j
> $ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/=
btrfs.img |& grep btrfs.img > /tmp/post.log
> $ diff -u /tmp/pre.log /tmp/post.log
> --- /tmp/pre.log        2022-08-02 14:12:19.670688371 +0900
> +++ /tmp/post.log       2022-08-02 14:12:47.019382686 +0900
> @@ -32,36 +32,66 @@
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 5357568) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 4096, 65536) =3D 4096
>   pwrite64(5</tmp/btrfs.img>, ""..., 4096, 67108864) =3D 4096
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
>   ....
>

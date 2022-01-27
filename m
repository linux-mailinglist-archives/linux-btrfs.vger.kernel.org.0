Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EBA49EE3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 23:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiA0WpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 17:45:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:48187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236300AbiA0WpU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 17:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643323517;
        bh=k4GGCIwIIpkCK0rzkN6RCjtNIpD1sv2uniyOacGPD0Y=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=dfOENkR0i+TyDCtpX6rNbfqk6GDncKRuf5lTQLIr45SPjjiN/3Vm2oapQv4kltfGh
         pNKceM3r0YTRSnDKbMQRc3lrjiFVddq9Zzhv9Q7QVrsaJMzLCAfqnm0MLYEqe9YFcr
         wIX0reojVnKgNc0sw/BEhMQMoHCpw8wwd3XgToqs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1mInhj0mwA-00x4RT; Thu, 27
 Jan 2022 23:45:17 +0100
Message-ID: <b3179989-c5b4-ea36-e624-6826ac1abc09@gmx.com>
Date:   Fri, 28 Jan 2022 06:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     piorunz <piorunz@gmx.com>, linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
In-Reply-To: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gFT/30afBwO+DK5HCCqj0Tw/mAoPWdNiUvErXqL4fdPznuiMmsE
 +GmurKIHvmE7ESlUnINEjHvwGdS0nxm/4Dh0Ywpx45n0iol3iadpBLYuU98xdLN2bAJm1vR
 Y+UULpkIsfFUAC6BA3Ox1WNGjwyIFYpEMOTvQ9IFkUDlVvGQvD515EVuWl4AIoxmIo3AN17
 N1AFY8KzCOFz2iDhdkpSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zc0pHlWf1o8=:yzVVNxqDS5W4AcOdnE6E3j
 STXnUpqezMsQmWH2qgZz/W6WayB6kA4MLRFYtrnky/QVyMIeG9/rrgAhGrOJJ0UmKVAYVWU1/
 kEno0GRXVyA997ZdWZNt+HSNIXurIPa4VPHjiWojkdGqDJ/SbtNnmQefSwnSpS4qbyxyFkvuv
 LsP+ljsyl3s80p7IHLEJ/+ltso5bpmx1DRaVffOmOA3ySiWJQ43qnNGl3pt7w4BZJMcEemE/m
 un6BnLKS1VJUxa1Rip5yNdL25ngddoQWcDBELdsCkr2QBDe4cIi6vJH2VIGdtA/l1KZ6D3vc/
 Frfc5qQrARkGjcrDShzvA1PRkfSffEDBhjBUK5YWa8OTB+AVqhWqCUUIyP4UEYAl/ZGzIji05
 KHgrtBRftjiz2pugEdQ3znSUYwBk6vcG2Y29EJUgGxgp++LqV3Dh6bqpgPZxLeRUCOFd8e4aA
 Xgzhs6vOl4JukYybQxFljS9R/I8fDIGr0NUSlW80VdTiPj7V+HYFTm5gnmDJm8nGyZh1/1aVE
 Sq3kKG5T4MYxtkoSFnS8vwTM1aPLqLnNbixAisOpe+8qFofhcCx/bLPDUHTJHHfTx9Lz0ATWN
 zdvLJGxVLguaFg/HJy5QROuhsgdTOTrltzZGFkvLXaK7NxGmY3HDMy/A4CARxoZxjdaQUbqhm
 PQOuqA8GCHZwSjCJFkOmXg7+cUJJCnQF0IVXhsOend91dh7aLG8FwLKY3AeoGRDilvmrTnYH4
 Fuvo0xhdtpuAvo1PqLAvz/ursZo6tZAPD7B3Z0M9MASdLj/OMDoVIGBbwfp+H3GgT+JhaYjWo
 5DhZBa1zqq6zY2f+BZtRFtRbfSWacfdXgQQVZtn3H5ifques+sm1cyaD7MyuwFbJlGVb2N5lu
 3w6cd59fc0tF9rncN9PKDqfSnLciuR6ox+LNBQ2XId9hnP8ZrIHJxS0TgF/mV0S0RGlKg/nb4
 bQZDVZh1WCoukTG+V+9DQzYzLiAReaDTY7oZ6od1xjXofPN17aLRZt9YgdWsKy1gkw6EvTsA+
 WzXQuMwoI6t8Ov3p54KzJ3LUrFoXYzdPFgN6B5X+XkgChXVNUJS4QNnI+h/3s7Ao4cIgP86mL
 BE02b3o8g3Fd6Y=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/27 23:25, piorunz wrote:
> Hi all,
>
> Is it safe & recommended to run autodefrag mount option in fstab?
> I am considering two machines here, normal desktop which has Btrfs as
> /home, and server with VM and other databases also btrfs /home. Both
> Btrfs RAID10 types. Both are heavily fragmented. I never defragmented
> them, in fact. I run Debian 11 on server (kernel 5.10) and Debian
> Testing (kernel 5.15) on desktop.

It's very embarrassing to admit, that defrag behavior in btrfs has some
bugs, no only in the latest rework in v5.16, but also in older kernels.

>
> Running manual defrag on server machine, like:
> sudo btrfs filesystem defrag -v -t4G -r /home

-t4G is too large. The max extent size in btrfs is only 128M.

Thus it means all extents will be re-written unconditionally.

> takes ages and can cause 120 second timeout kernel error in dmesg due to
> service timeouts. I prefer to autodefrag gradually, overtime, mount
> option seems to be good for that.

The 120s timeout is a bug we need to address. I checked the current code
and v5.15 code, unfortunately it seems we didn't call cond_resched(),
which causes the 120s timeout.

Now let's talk about autodefrag.

In v5.15 (and stable v5.10), there is a hidden bug in autodefrag only
branch, that it will not defrag a lot of extents.

Thus autodefrag may not help, while only manual defrag would do the best
for now.

>
> My current fstab mounting:
>
> noatime,space_cache=3Dv2,compress-force=3Dzstd:3 0 2
>
> Will autodefrag break COW files? Like I copy paste a file and I save
> space, but defrag with destroy this space saving?

As mentioned in the man page, defrag (no matter auto or not) will break
reflink and snapshot, thus increase the space usage.

> Also, will autodefrag compress files automatically, as mount option
> enforces (compress-force=3Dzstd:3)?

If you're using compression, then the max extent size is only 128K.
(Which is another cause of fragments)

Defrag can handle it, but you may want to modify the extent size even
smaller for defrag subcommand.

Thanks,
Qu

>
> Any suggestions welcome.
>
>
> --
> With kindest regards, Piotr.
>
> =E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
> =E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Debian -=
 The universal operating system
> =E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 https://=
www.debian.org/
> =E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80

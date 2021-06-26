Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C433B4B84
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 02:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFZAaX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 20:30:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:46671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhFZAaW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 20:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624667278;
        bh=NCGhkYdVIPHc6BhjtiBX2kS26RsrJR4Ton9//CI6MUQ=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=CK5AdzPf8t+HmWGcMFW7Udjp9O0pZ4jfJDMWkg4BHF3ayALlPRSYTzjuE51vWVHjO
         vJy4c01OMcY9+1RAqp9m2SXzKeG5AfbWw9W1PGhgYX/MeF6HVLOrNNvQDv90oA/waR
         dgNsoU/ZgWC3sQuaJHG1SgQSzcGXEV41E/08MWio=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1ljLY6351v-00Vjgy; Sat, 26
 Jun 2021 02:27:58 +0200
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <41661070.mPYKQbcTYQ@ananda>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search
 Baloo
Message-ID: <fe83dadc-bbcf-2f85-6664-bad3fcd83553@gmx.com>
Date:   Sat, 26 Jun 2021 08:27:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <41661070.mPYKQbcTYQ@ananda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wqh4yPMcfZZCUfFPNwx1Qq5a6ZmIifYIna//ksz+Hv+5vrECNii
 BdTjbA5f7dttjrpMze3lDIToAfgpySyDLLZfmZufaN30PjppGRMx2aub+pS0e330evRnMqs
 pw83fgxnW6QS9NuQLuTZwEQyD8mmFIyZndRZDsjvWpskdoMl0Vj5eUGd/cNavYHmzvQ6chi
 qJTsE4Nz/jkeRjPK7ifpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M4TzBlnbcAA=:qMZZW6+jiXon7sK5nd2xIl
 rBhtqA9iHe9NS7a93ytkHOJ57PRZsEXsCjkNT7km0tvzxQ2zdpYT8oYXE6r+gSVst6rqZKbF4
 TXhICSKgnE9IiQUPo8EJsBi0XyVp0Te6MN4KCVdzY2NFf+DBsPLtEJD/a2CZGirVPUz4276Rm
 r4Omf5XLUK3fxuh8s+JU7ywEnQQMRV3kes9Jeg1IEwZX59pV/p6xjK+4mWSXfubKqKl1yoWQL
 2JA1NayJGrtPovDFt7P8z3o1bIdDinQHNWmNVLLhlzQVCSHtyQE5W4m0wA/C9qj3SInRZPT3Q
 0upsxSHT7ZCGWoZ/JlkGkMFMkRlEDpgAzpPmCTcWLVJkC59GrP1FCtnUEG7QPFm6GkH2fCGZW
 pfvhAoBpvu2t7DfH4qRzQixGiKiB8DPgciu9EKtDu1SCqpN+sGFyliVET7/9KKd8przgEfmq1
 1ajhfr/U0pBk28o9XV3MJlKqK8tQmByQsRaoNBvgSkjsvhq1s1TTaLKIwD8o9xXuWgSSZevBH
 LZNdVeb1Y1aACQb768WvryyeElIY5bveJamGGIiy7uLKm8QQRMeSQwZzeRPNyU71zuyddvA+O
 lnsXN8ZkKjWY0WKfs0q0V1RT1yC9fQbZbQdNJH53YnHeuQpMdxbKQSsSaTtRLtp1UifSqmnkd
 8CBlOTghXcW+meABZ9+mjfGSUHDbOUOBt4zoJ5brygNKoOOrc9CCxqqT81sTYJkMNSLrFAuRl
 TNxuiq1DuFM4vLGeuzzl69HEkbF+Gga+hPLw0o93PjO2LGj8Wgn8RUUYOppjJwakKXs57Yywv
 /EhWfEvuNJo+BWRXwXThJrt3f8sS6TvNTCt65o3ouWdr3jdm7sHZNaMmf1jeFucr5WLevZHPe
 o6zdPk4euUx6xQPUfZM8e3C4X8Yk0M445GIjIGFgNAA889SxLH1B2TZHhKu39jqKGQmt1ivCg
 l86dSIXaXGfXBT87mVBX3ztavakVDK3qrOO8yldzCmu/nyPGcytZ2AkBxAtyWM1LTIr8Yt0mD
 eqx9zpzgsQyyXFxHGjAwVfUK9CWvGUfIFFLqmCpHFeNEkYGh0fS6lB4Ab1Id1HcUqpIS1Amnt
 R6kDu6VwYk7Wb5ZW7+jCKXkjq5yWXbZfQlpBlm4AKyyfvx/qgeV1VHmmg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/26 =E4=B8=8A=E5=8D=883:06, Martin Steigerwald wrote:
> Hi!
>
> I found repeatedly that Baloo indexes the same files twice or even more
> often after a while.
>
> I reported this upstream in:
>
> Bug 438434 - Baloo appears to be indexing twice the number of files than
> are actually in my home directory
>
> https://bugs.kde.org/show_bug.cgi?id=3D438434
>
> And got back that if the device number changes, Baloo will think it has
> new files even tough the path is still the same. And found over time tha=
t
> the device number for the single BTRFS filesystem on a NVMe SSD in a
> ThinkPad T14 Gen1 AMD can change. It is not (maybe yet) RAID 1. I do
> have BTRFS RAID 1 in another laptop and there I also had this issue
> already.

Since btrfs has multi-device support by default, it reports anonymous
device number, just as if you use a filesystem over LVM.

The problem is why the anonymous device number change.

If the fs is always mounted at a fixed sequence with fixed
snapshots/subvolume mount, it should not get a new anonymous device number=
.

But if snapshots or new subvolumes are involved, or just
mounting/reading subvolumes in different order, then the device number
for each subvolume will change.

>
> I argued that a desktop application has no business to rely on a device
> number and got back that search/indexing is in the middle between an
> application and system software. And that Baloo needs an "invariant" for
> a file. See comment #11 of that bug report:
>
> https://bugs.kde.org/show_bug.cgi?id=3D438434#c11

Well, a lot of tools relies on device number to distinguish filesystem
boundary, like find.
Thus it's a little hard to argue.

But on the other hand, it also means baloo can't handle regular fs over
LVM cases well neither.

>
> I got the suggestion to try to find a way to tell the kernel to use a
> fixed device number.

I don't think it's possible for btrfs, as each subvolume get its
anonymous device number assigned when it gets first read.

Thus it's really hard to make it fixed, as the reason for anonymous
device number is to avoid conflicts.

>
> I still think, an application or an infrastructure service for a desktop
> environment or even anything else in user space should not rely on a
> device number to be fixed and never change upon reboots.

Well, LVM/device mapper is doing the same thing, a lot of behavior
change is never a good idea for the kernel.

Thus for use cases where we really need a proper mapping, we use hashes,
not just device number, like what we did in dupremover.

>
> But maybe you have a different idea about that and it is okay for an
> userspace component to do that. I would like to hear your idea about
> that.
>
> Another question would be whether I could somehow make sure that the
> device number does not change, even if just as a work-around.

If you really just want a fixed device number, you can ensure that by:

- Make sure all users of anonymous devices get fixed sequence
   Things like device mapper/LVM, btrfs should get loaded/initialized
   in a fixed order.

- Make sure the subvolume you care always get mounted/read before any
   other subvolumes
   So that the target subvolume always get the first device number in the
   pool.

   But this also means, all later subvolumes not in the fixed mount/read
   sequence can not get a fixed number.

Thanks,
Qu

> I know for
> NFS there is a fsid=3D mount option, but it does not appear to be
> something generic, at least the mount man page seems to have nothing
> related to fsid.
>
>
> Best,
>

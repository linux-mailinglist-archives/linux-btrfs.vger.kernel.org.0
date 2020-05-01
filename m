Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2906E1C0DF8
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEAGFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:05:22 -0400
Received: from zeus.leadhosts.com ([86.105.231.130]:41220 "EHLO
        zeus.leadhosts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAGFW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 02:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dordea.net;
         s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=D7kwv9RjoWSJg5P86nEY+eMkk5a6HqOSkU7SsQhghOo=; b=a2Cch0cMDyH0y1Z7LxJCcK22sI
        ZnAK3Kpcw/H0cjqlqj4jKsj/TUNHPNLXsryn+YH2Ij2Dv16S5INLHVBw/SzuNYEHZaHlreqXqWOyq
        HkSHEeflK9muXvA8PctObt0dBM3XqFRaf3iX8UVDbXEGwP0rPdYSvP8vc1wc3/7mP11PWPFFvpYn3
        rn9SoEOZ6XNmTLRzsJ2akbbQu0P0c2SVMDEJK5nHgPELD9Xj+x7sO7XanjrM21GXIGcL7nCvp2GLe
        kSkG5BQHiV81754jc9DjoQGhVlBhpJBoe5DQ0KM3I0ssSGYtdLfGEhEPMSu41aNSGOAWa4E60KBGt
        w10yCidQ==;
Received: from [86.105.231.110]
        by zeus.leadhosts.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <alex@dordea.net>)
        id 1jUOnV-0078MK-3h; Fri, 01 May 2020 09:05:17 +0300
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Extremely slow device removals
From:   Alexandru Dordea <alex@dordea.net>
In-Reply-To: <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net>
Date:   Fri, 1 May 2020 09:05:15 +0300
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
 <20200501024753.GE10769@hungrycats.org>
 <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net>
To:     Phil Karn <karn@ka9q.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Authenticated-Id: alex@dordea.net
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Don=E2=80=99t get me wrong, the single 100% CPU is only during balance =
process.
By running "btrfs device delete missing /storage=E2=80=9Dthere is no =
impact on CPU/RAM. I do have 64GB DDR4 ECC but there is no more of 3GB =
ram usage.

I can see that @Chris Murphy mention that disabling the cache will =
impact performance. Did you tried that?=20
On my devices I do have cache enabled and till now this is the only =
thing that I didn't tried :)

# hdparm -W /dev/sdc
/dev/sdc:
 write-caching =3D  1 (on)


> On May 1, 2020, at 07:48, Phil Karn <karn@ka9q.net> wrote:
>=20
> On 4/30/20 19:47, Zygo Blaxell wrote:
>>=20
>> If it keeps repeating "found 1115 extents" over and over (say 5 or
>> more times) then you're hitting the balance looping bug in kernel 5.1
>> and later.  Every N block groups (N seems to vary by user, I've heard
>> reports from 3 to over 6000) the kernel will get stuck in a loop and
>> will need to reboot to recover.  Even if you cancel the balance, it =
will
>> just loop again until rebooted, and there's no cancel for device =
delete
>> so if you start looping there you can just skip directly to the =
reboot.
>> For a non-trivial filesystem the probability of successfully deleting
>> or resizing a device is more or less zero.
>=20
> This does not seem to be happening. Each message is for a different
> block group with a different number of clusters. The device remove =
*is*
> making progress, just very very slowly. I'm almost down to just 2TB
> left. Woot!
>=20
> If I ever have to do this again, I'll insert bcache and a big SSD
> between btrfs and my devices. The slowness here has to be due to the
> (spinning) disk I/O being highly fragmented and random. I've checked,
> and none of my drives (despite their large sizes) are shingled, so
> that's not it. The 6 TB units have 128 MB caches and the 16 TB have =
256
> MB caches.
>=20
> I've never understood *exactly* what a hard drive internal cache does. =
I
> see little sense in a LRU cache just like the host's own buffer cache
> since the host has far more RAM. I do know they're used to reorder
> operations to reduce seek latency, though this can be limited by the
> need to fence writes to protect against a crash. I've wondered if
> they're also used on reads to reduce rotational latency by =
prospectively
> grabbing data as soon as the heads land on a cylinder. How big is a
> "cylinder'' anyway? The inner workings of hard drives have become
> steadily more opaque over the years, which makes it difficult to
> optimize their use. Kinda like CPUs, actually. Last time I really =
tuned
> up some tight code, I found that using vector instructions and =
avoiding
> branch mispredictions made a big difference but nothing else seemed to
> matter at all.
>=20
>>=20
>> There is no fix for that regression yet.  Kernel 4.19 doesn't have =
the
>> regression and does have other relevant bug fixes for balance, so it
>> can be used as a workaround.
>=20
> I'm running 4.19.0-8-rt-amd64, the current real-time kernel in Debian
> 'stable'.
>=20
> Phil
>=20
>=20
>=20


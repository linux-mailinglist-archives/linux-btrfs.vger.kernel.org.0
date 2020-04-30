Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652541C07E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgD3U1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 16:27:35 -0400
Received: from zeus.leadhosts.com ([86.105.231.130]:57264 "EHLO
        zeus.leadhosts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD3U1f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 16:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dordea.net;
         s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=sURgg9MQMHD7wc0LO9DTuTtYCRSk1kFcmuQY9O0FggE=; b=NS048ATqVlITokySPD9kFsBHWo
        P1hcJhYPr0wXTrq9BvPq1mpB5bI4mz9KGVQ5shA8Oi1k/FZfZWugCcK6Zkcu1QMnjz1Gxg+J/sx5c
        NM2uktJUqGRqnj/B9LAPfhBVhkeEXEc9ktysj38y52Dx+Vvi/2ZvAR44tI6LFgyPgm7UYbAljP26Z
        rkcfYCSzS+xO3ZCbh2Td2OFeVyXYD/eZC2jd22Wk99/pP2+SjTffeURDLyb71+Pi+zmEOhIJI+WT8
        DWgwY0brxRResjA2iBT879+9GVoptETHlZncLV3axKAqgPpUB88sqB53XMdj9TW1NM1GhUJ0+O8Nw
        qDpZOmMQ==;
Received: from [86.105.231.110]
        by zeus.leadhosts.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <alex@dordea.net>)
        id 1jUFmN-0066wX-1Y; Thu, 30 Apr 2020 23:27:31 +0300
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Extremely slow device removals
From:   Alexandru Dordea <alex@dordea.net>
In-Reply-To: <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
Date:   Thu, 30 Apr 2020 23:27:26 +0300
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <848D59AB-5B64-4C32-BE21-7BC8A8B9821E@dordea.net>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
To:     Phil Karn <karn@ka9q.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Authenticated-Id: alex@dordea.net
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I=E2=80=99m encountering the same issue with Raid6 for months :)
I have a BTRFS raid6 with 15x8TB HDD=E2=80=99s and 5 x 14TB. One of the =
15 x 8TB crashed. I have removed the faulty drive and if I=E2=80=99m =
running the delete missing command the sys-load is increasing and to =
recover 6.66TB will take few months. After 5 days of running the missing =
data decreased to -6.10.
During this period the drivers are almost 100% and the R/W performance =
is degraded with more than 95%.

The R/W performance is not impacted if the process of delete/balance is =
not running. (Don=E2=80=99t know if running balance on a single CPU =
without multithread is a feature or a bug but it's a shame that the =
process is keeping only one CPU out of 48 at 100%).
No errors, partition is clean.
Mounted with space_cache=3Dv2, no improvement.
Using kernel 5.6.6 with btrfsprogs 5.6 (latest opensuse tumbleweed).

        Total devices 20 FS bytes used 134.22TiB
        devid    1 size 7.28TiB used 7.10TiB path /dev/sdg
        devid    2 size 7.28TiB used 7.10TiB path /dev/sdh
        devid    3 size 7.28TiB used 7.10TiB path /dev/sdt
        devid    5 size 7.28TiB used 7.10TiB path /dev/sds
        devid    6 size 7.28TiB used 7.10TiB path /dev/sdr
        devid    7 size 7.28TiB used 7.10TiB path /dev/sdq
        devid    8 size 7.28TiB used 7.10TiB path /dev/sdp
        devid    9 size 7.28TiB used 7.10TiB path /dev/sdo
        devid   10 size 7.28TiB used 7.10TiB path /dev/sdn
        devid   11 size 7.28TiB used 7.10TiB path /dev/sdm
        devid   12 size 7.28TiB used 7.10TiB path /dev/sdl
        devid   13 size 7.28TiB used 7.10TiB path /dev/sdk
        devid   14 size 7.28TiB used 7.10TiB path /dev/sdj
        devid   15 size 7.28TiB used 7.10TiB path /dev/sdi
        devid   16 size 12.73TiB used 11.86TiB path /dev/sdc
        devid   17 size 12.73TiB used 11.86TiB path /dev/sdf
        devid   18 size 12.73TiB used 11.86TiB path /dev/sde
        devid   19 size 12.73TiB used 11.86TiB path /dev/sdb
        devid   20 size 12.73TiB used 11.86TiB path /dev/sdd
        *** Some devices missing

After spending months troubleshooting and tried to recover without =
heaving my server unavailable for months I=E2=80=99m about to give up :)


> On Apr 30, 2020, at 22:59, Phil Karn <karn@ka9q.net> wrote:
>=20
> On 4/30/20 11:40, Chris Murphy wrote:
>> It could be any number of things. Each drive has at least 3
>> partitions so what else is on these drives? Are those other =
partitions
>> active with other things going on at the same time? How are the =
drives
>> connected to the computer? Direct SATA/SAS connection? Via USB
>> enclosures? How many snapshots? Are quotas enabled? There's nothing =
in
>> dmesg for 5 days? Anything for the most recent hour? i.e. journalctl
>> -k --since=3D-1h
>=20
> Nothing else is going on with these drives. Those other partitions
> include things like EFI, manual backups of the root file system on my
> SSD, and swap (which is barely used, verified with iostat and swapon =
-s).
>=20
> The drives are connected internally with SATA at 3.0 Gb/s (this is an
> old motherboard). Still, this is 375 MB/s, much faster than the =
drives'
> sustained read/write speeds.
>=20
> I did get rid of a lot of read-only snapshots while this was running =
in
> hopes this might speed things up. I'm down to 8, and willing to go
> lower. No obvious improvement. Would I expect this to help right away,
> or does it take time for btrfs to reclaim the space and realize it
> doesn't have to be copied?
>=20
> I've never used quotas; I'm the only user.
>=20
> There are plenty of messages in dmesg of the form
>=20
> [482089.101264] BTRFS info (device sdd3): relocating block group
> 9016340119552 flags data|raid1
> [482118.545044] BTRFS info (device sdd3): found 1115 extents
> [482297.404024] BTRFS info (device sdd3): found 1115 extents
>=20
> These appear to be routinely generated by the copy operation. I know
> what extents are, but these messages don't really tell me much.
>=20
> The copy operation appears to be proceeding normally, it's just
> extremely, painfully slow. And it's doing an awful lot of writing to =
the
> drive I'm removing, which doesn't seem to make sense. Looking at
> 'iostat', those writes are almost always done in parallel with another
> drive, a pattern I often see (and expect) with raid-1.
>=20
>>=20
>> It's an old kernel by this list's standards. Mostly this list is
>> active development on mainline and stable kernels, not LTS kernels
>> which - you might have found a bug. But there's thousands of changes
>> throughout the storage stack in the kernel since then, thousands just
>> in Btrfs between 4.19 and 5.7 and 5.8 being worked on now. It's a 20+
>> month development difference.
>>=20
>> It's pretty much just luck if an upstream Btrfs developer sees this
>> and happens to know why it's slow and that it was fixed in X kernel
>> version or maybe it's a really old bug that just hasn't yet gotten a
>> good enough bug report still, and hasn't been fixed. That's why it's
>> common advice to "try with a newer kernel" because the problem might
>> not happen, and if it does, then chances are it's a bug.
> I used to routinely build and install the latest kernels but I got =
tired
> of that. But I could easily do so here if you think it would make a
> difference. It would force me to reboot, of course. As long as I'm not
> likely to corrupt my file system, I'm willing to do that.
>>=20
>>> I started the operation 5 days ago, and of right now I still have =
2.18
>>> TB to move off the drive I'm trying to replace. I think it started
>>> around 3.5 TB.
>> Issue sysrq+t and post the output from 'journalctl -k --since=3D-10m'
>> in something like pastebin or in a text file on nextcloud/dropbox =
etc.
>> It's probably too big to email and usually the formatting gets munged
>> anyway and is hard to read.
>>=20
>> Someone might have an idea why it's slow from sysrq+t but it's a long =
shot.
>=20
> I'm operating headless at the moment, but here's journalctl:
>=20
> -- Logs begin at Fri 2020-04-24 21:49:22 PDT, end at Thu 2020-04-30
> 12:07:12 PDT. --
> Apr 30 12:04:26 homer.ka9q.net kernel: BTRFS info (device sdd3): found
> 1997 extents
> Apr 30 12:04:33 homer.ka9q.net kernel: BTRFS info (device sdd3):
> relocating block group 9019561345024 flags data|raid1
> Apr 30 12:05:21 homer.ka9q.net kernel: BTRFS info (device sdd3): found
> 6242 extents
>=20
>> If there's anything important on this file system, you should make a
>> copy now. Update backups. You should be prepared to lose the whole
>> thing before proceeding further.
> Already done. Kinda goes without saying...
>> KB
>> Next, disable the write cache on all the drives. This can be done =
with
>> hdparm -W (cap W, lowercase w is dangerous, see man page). This =
should
>> improve the chance of the file system on all drives being consistent
>> if you have to force reboot - i.e. the reboot might hang so you =
should
>> be prepared to issue sysrq+s followed by sysrq+b. Better than power
>> reset.
> I did try disabling the write caches. Interestingly there was no =
obvious
> change in write speeds. I turned them back on, but I'll remember to =
turn
> them off before rebooting. Good suggestion.
>> Boot, leave all drives connected, make sure the write caches are
>> disabled, then make sure there's no SCT ERC mismatch, i.e.
>> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
>=20
> All drives support SCT. The timeouts *are* different: 10 sec for the =
new
> 16TB drives, 7 sec for the older 6 TB drives.
>=20
> But this shouldn't matter because I'm quite sure all my drives are
> healthy. I regularly run both short and long smart tests, and they've
> always passed. No drive I/O errors in dmesg, no evidence of any =
retries
> or timeouts. Just lots of small apparently random reads and writes =
that
> execute very slowly. By "small" I mean the ratio of KB_read/s to tps =
in
> 'iostat' is small, usually less than 10 KB and often just 4KB.
>=20
> Yes, my partitions are properly aligned on 8-LBA (4KB) boundaries.
>=20
>>=20
>> And then do a scrub with all the drives attached. And then assess the
>> next step only after that completes. It'll either fix something or
>> not. You can do this same thing with kernel 4.19. It should work. But
>> until the health of the file system is known, I can't recommend doing
>> any device replacements or removals. It must be completely healthy
>> first.
> I run manual scrubs every month or so. They've always passed with zero
> errors. I don't run them automatically because they take a day and
> there's a very noticeable hit on performance. Btrfs (at least the
> version I'm running) doesn't seem to know how to run stuff like this =
at
> low priority (yes, I know that's much harder with I/O than with CPU).
>>=20
>> I personally would only do the device removal (either remove while
>> still connected or remove while missing) with 5.6.8 or 5.7rc3 because
>> if I have a problem, I'm reporting it on this list as a bug. With =
4.19
>> it's just too old I think for this list, it's pure luck if anyone
>> knows for sure what's going on.
>=20
> I can always try the latest kernel (5.6.8 is on kernel.org) as long as
> I'm not likely to lose data by rebooting. I do have backups but I'd =
like
> to avoid the lengthy hassle of rebuilding everything from scratch.
>=20
> Thanks for the suggestions!
>=20
> Phil
>=20
>=20
>=20


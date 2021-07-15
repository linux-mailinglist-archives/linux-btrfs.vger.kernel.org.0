Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6A3CA4D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 20:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhGOSC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 14:02:58 -0400
Received: from mail.mailmag.net ([5.135.159.181]:60056 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236602AbhGOSC6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 14:02:58 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2021 14:02:57 EDT
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id EADEAEC0377
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 09:51:08 -0800 (AKDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1626371469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDc2RN8u0RVhBRPpM75T7nIJlmBfFNl+iXE799jobHU=;
        b=xrsjO273J4ox7oWAmgh8+ITjmxpbvDt+G2xVEcjw6PMSeQl4v71HIqAig6XrFOGsMkVR/H
        gEiNEziAnVCnGeOh1Tt6yku5nFR0Icmy1NNDieD3SoIoiHAXbg25koMjk0yfsOkTgQsThF
        WHP/CXa0iUFFhq6rriZzHJasRJXGapw=
MIME-Version: 1.0
Date:   Thu, 15 Jul 2021 17:51:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Joshua" <joshua@mailmag.net>
Message-ID: <0b4cf70fc883e28c97d893a3b2f81b11@mailmag.net>
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
References: <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
 <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
 <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1626371469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDc2RN8u0RVhBRPpM75T7nIJlmBfFNl+iXE799jobHU=;
        b=kPLYOTArn0oO0sMO7MnBCyE7e8WysEizcomtV8uH2frDAQh0xPVyQZvVLxGl57ZoZu49nX
        6O6fVYqdeXdnmgyQToRVmD02fl4rs2wkK/9+J8MPI9rB33g36deDlSSpkL1Z32kfJ96WLR
        TSrmeu3eXbcfZHzMxU+wFVubmxIuyOM=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1626371469; a=rsa-sha256; cv=none;
        b=sTB4BWZ0ddJnlqCJYWBH7G4CU6hTKmiADp1m9G1oWThw+goA9yxHrjoShUeX6bFEN59QgC
        FypjMt3nbMqRq7Eoc6NYvvwtpughPdmQHI3dg8l/XdBn0Nzars63zvg/PASAd+YVT+kS58
        eXAUAV87qaevreEUWcKCAcL94K7Eysk=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just as a point of data, I have a 96 TB array with RAID1 data, and RAID1C=
3 metadata.

I made the switch to space_cache=3Dv2 some time ago, and I remember it ma=
de a huge difference when I did so!
(It was RAID1 metadata at the time, as RAID1C3 was not available at the t=
ime.)


However, I also tried a check with '--clear-space-cache v1' at the time, =
and after waiting a literal whole day without it completing, I gave up, c=
anceled it, and put it back into production.  Is a --clear-space-cache v1=
 operation expected to take so long on such a large file system?

Thanks!
--Joshua Villwock



July 15, 2021 9:40 AM, "DanglingPointer" <danglingpointerexception@gmail.=
com> wrote:

> Hi Qu,
>=20
>=20Just updating here that setting the mount option "space_cache=3Dv2" a=
nd "noatime" completely SOLVED
> the performance problem!
> Basically like night and day!
>=20
>=20These are my full fstab mount options...
>=20
>=20btrfs defaults,autodefrag,space_cache=3Dv2,noatime 0 2
>=20
>=20Perhaps defaulting the space_cache=3Dv2 should be considered?  Why de=
fault to v1, what's the value of
> v1?
>=20
>=20So for conclusion, for large multi-terrabyte arrays (in my case RAID5=
s), setting space_cache=3Dv2 and
> noatime massively increases performance and eliminates the large long p=
auses in frequent intervals
> by "btrfs-transacti" blocking all IO.
>=20
>=20Thanks Qu for your help!
>=20
>=20On 14/7/21 5:45 pm, Qu Wenruo wrote:
>=20
>>=20On 2021/7/14 =E4=B8=8B=E5=8D=883:18, DanglingPointer wrote:
>>> a) "echo l > /proc/sysrq-trigger"
>>>=20
>>>=20The backup finished today already unfortunately and we are unlikely=
 to
>>> run it again until we get an outage to remount the array with the
>>> space_cache=3Dv2 and noatime mount options.
>>> Thanks for the command, we'll definitely use it if/when it happens ag=
ain
>>> on the next large migration of data.
>>=20
>>=20Just to avoid confusion, after that command, "dmesg" output is still
>> needed, as that's where sysrq put its output.
>>> b) "sudo btrfs qgroup show -prce" ........
>>>=20
>>>=20$ ERROR: can't list qgroups: quotas not enabled
>>>=20
>>>=20So looks like it isn't enabled.
>>=20
>>=20One less thing to bother.
>>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes (Duplica=
cy
>>> backup defaults)
>>=20
>>=20Between 1~16MiB, thus tons of small files.
>>=20
>>=20Btrfs is not really good at handling tons of small files, as they
>> generate a lot of metadata.
>>=20
>>=20That may contribute to the hang.
>>=20
>>>=20What classifies as a transaction?
>>=20
>>=20It's a little complex.
>>=20
>>=20Technically it's a check point where before the checkpoint, all you =
see
>> is old data, after the checkpoint, all you see is new data.
>>=20
>>=20To end users, any data and metadata write will be included into one
>> transaction (with proper dependency handled).
>>=20
>>=20One way to finish (or commit) current transaction is to sync the fs,
>> using "sync" command (sync all filesystems).
>>=20
>>>=20Any/All writes done in a 30sec
>>> interval?
>>=20
>>=20This the default commit interval. Almost all fses will try to commit=
 its
>> data/metadata to disk after a configurable interval.
>>=20
>>=20The default one is 30s. That's also one way to commit current > tran=
saction.
>>=20
>>>=20If 100 unique files were written in 30secs, is that 1
>>> transaction or 100 transactions?
>>=20
>>=20It depends. As things like syncfs() and subvolume/snapshot creation =
may
>> try to commit transaction.
>>=20
>>=20But without those special operations, just writing 100 unique files
>> using buffered write, it would only start one transaction, and when th=
e
>> 30s interval get hit, the transaction will be committed to disk.
>>=20
>>>=20Millions of files of the size range
>>> above were backed up.
>>=20
>>=20The amount of files may not force a transaction commit, if it doesn'=
t
>> trigger enough memory pressure, or free space pressure.
>>=20
>>=20Anyway, the "echo l" sysrq would help us to locate what's taking so =
long
>> time.
>>=20
>>>=20c) "Just mount with "space_cache=3Dv2""
>>>=20
>>>=20Ok so no need to "clear_cache" the v1 cache, right?
>>=20
>>=20Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>>=20
>>=20Thus it doesn't help much.
>>=20
>>=20The only way to fully clear v1 cache is by using "btrfs check
>> --clear-space-cache v1" on a *unmounted* btrfs.
>>=20
>>>=20I wrote this in the fstab but hadn't remounted yet until I can get =
an
>>> outage....
>>=20
>>=20IMHO if you really want to test if v2 would help, you can just remou=
nt,
>> no need to wait for a break.
>>=20
>>=20Thanks,
>> Qu
>>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=3Dv2,noatime  0=
  2 >
>>> Thanks again for your help Qu!
>>>=20
>>>=20On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>=20
>>=20On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>> We're currently considering switching to "space_cache=3Dv2" with noati=
me
>> mount options for my lab server-workstations running RAID5.
>>=20
>>=20Btrfs RAID5 is unsafe due to its write-hole problem.
>>=20
>>=20* One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>> totalling 26TB.
>> * Another has about 12TB data/metadata in uniformly sized 6TB disks
>> totalling 24TB.
>> * Both of the arrays are on individually luks encrypted disks with
>> btrfs on top of the luks.
>> * Both have "defaults,autodefrag" turned on in fstab.
>>=20
>>=20We're starting to see large pauses during constant backups of millio=
ns
>> of chunk files (using duplicacy backup) in the 24TB array.
>>=20
>>=20Pauses sometimes take up to 20+ seconds in frequencies after every
>> ~30secs of the end of the last pause.  "btrfs-transacti" process
>> consistently shows up as the blocking process/thread locking up
>> filesystem IO.  IO gets into the RAID5 array via nfsd. There are no >>=
>> disk
>> or btrfs errors recorded.  scrub last finished yesterday successfully.
>>=20
>>=20Please provide the "echo l > /proc/sysrq-trigger" output when such >=
>> pause
>> happens.
>>=20
>>=20If you're using qgroup (may be enabled by things like snapper), it m=
ay
>> be the cause, as qgroup does its accounting when committing >>> transa=
ction.
>>=20
>>=20If one transaction is super large, it can cause such problem.
>>=20
>>=20You can test if qgroup is enabled by:
>>=20
>>=20# btrfs qgroup show -prce <mnt>
>>=20
>>=20After doing some research around the internet, we've come to the
>> consideration above as described.  Unfortunately the official
>> documentation isn't clear on the following.
>>=20
>>=20Official documentation URL -
>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>=20
>>=201. How to migrate from default space_cache=3Dv1 to space_cache=3Dv2?=
 It
>> talks about the reverse, from v2 to v1!
>>=20
>>=20Just mount with "space_cache=3Dv2".
>>=20
>>=202. If we use space_cache=3Dv2, is it indeed still the case that the
>> "btrfs" command will NOT work with the filesystem?
>>=20
>>=20Why would you think "btrfs" won't work on a btrfs?
>>=20
>> Thanks,
>> Qu
>>=20
>>=20So will our
>> "btrfs scrub start /mount/point/..." cron jobs FAIL? I'm guessing
>> the btrfs command comes from btrfs-progs which is currently >>>> v5.4.=
1-2
>> amd64, is that correct?
>> 3. Any other ideas on how we can get rid of those annoying pauses with
>> large backups into the array?
>>=20
>>=20Thanks in advance!
>>=20
>>=20DP

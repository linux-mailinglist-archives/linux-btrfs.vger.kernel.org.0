Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9665C3FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 17:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjACQek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 11:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjACQei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 11:34:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B342C9
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 08:34:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c17so44515240edj.13
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Jan 2023 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tesseract-nl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :references:in-reply-to:message-id:date:cc:subject:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ndoSXz++PZcUwUHvUNTITnQJc34yoQJbDY23HZ6ZzI=;
        b=eQAhp9i+m71N/brFIm67g0chYnEfhQLgh5IXC/IV5/K7Hsp4kdiCItDFm1KoP9/Hfm
         1zm5G7ksyhXVFINaxoIOnVOFqKHdl+CwndY/lqogwPAwGZyFgCF18B628TN1cnCAMBQ5
         TSbTiSMHmknmfRtyOpuuzDXN25xVFLCDLPSG4fCq2JNoqN6i8EWlA8ykWzf2exxaQJmY
         PBk14qIJ0TvNHou36XVI6RWPQmcV2jmW2xxl9CNpkJC5G7WdEOo7ESySRIGjptK7kQl8
         ql6ogLCo6nliRrnJXR0VOqphocKXb9wEKBkKx7x/rQKEXUYVgZJ7uj1uQ3Z4X00FVmYc
         QmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :references:in-reply-to:message-id:date:cc:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ndoSXz++PZcUwUHvUNTITnQJc34yoQJbDY23HZ6ZzI=;
        b=EsrZ05yM6rViSg7pWm60JWN2Aw8yTsqcna2gYqexdgXg9O5mQe8ibdBumhknsOFA8t
         M7/wyds2LJdOdyCQl43liS/c+L7xorczYZGx14QHowOf0jlSlUcot83DzGLDAYivtlo0
         L4IdxE1VEmBHSENgPlg5lNtaUBnoxQ1lJ7ZaVmDKjwn6Fq3E0cQ5Z3DdxGU8GCP8ag8V
         gn9Mh0zo6BJ8cfuhbVIgdAeuZoiHezgIENiMAdR6l7IyeZeyrTMubACpoRKxIl6s5gyz
         B16Ut2P8gQL8U55wzuPw07qZ14n6xwPBsnodgYm5w0HCdYVxaibeziO6G87MLp5I9PA6
         zcNA==
X-Gm-Message-State: AFqh2kqqAS1+6AANJDhgb4kHgs3L8hzFG63d7GtGgJedvgXFR7TT9nZJ
        6s+tfeivVcC/0kybDijOJwXSsUnbiC0RKsU5RgrV
X-Google-Smtp-Source: AMrXdXuEXfACNgybROxoqRj/xymbKqWYUil6seyZkZ2y1byDVEdBsu2B+JFQd8WdsYzd1vzKBTUJ3Q==
X-Received: by 2002:a05:6402:2936:b0:48a:269c:9dc8 with SMTP id ee54-20020a056402293600b0048a269c9dc8mr14980144edb.10.1672763674736;
        Tue, 03 Jan 2023 08:34:34 -0800 (PST)
Received: from [100.108.116.149] ([195.181.172.153])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm977415edc.21.2023.01.03.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 08:34:34 -0800 (PST)
From:   "Gerard Boor" <gerard@tesseract.nl>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Subject: Re[3]: Recurring CSUM errors in root -9 when balancing and various files on
 scrub
Cc:     linux-btrfs@vger.kernel.org
Date:   Tue, 03 Jan 2023 16:34:32 +0000
Message-Id: <em6f036077-a4eb-4026-a719-267710b6651b@6c16a6da.com>
In-Reply-To: <em4f1a61b0-cc7e-4836-b4a8-b511331a63b9@2febebd9.com>
References: <em070178a7-5d53-4e5e-a8ae-0356b942932b@1f91cd2f.com>
 <Y54mt9WQlIVrsGnj@hungrycats.org>
 <em4f1a61b0-cc7e-4836-b4a8-b511331a63b9@2febebd9.com>
Reply-To: "Gerard Boor" <gerard@tesseract.nl>
User-Agent: eM_Client/9.2.1222.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>
>>On Tue, Dec 13, 2022 at 09:12:49AM +0000, Gerard Boor wrote:
>>>  Hello all,
>>>
>>>  I have a btrfs array consisting of 4 disks, using RAID-1 for data and
>>>  RAID-1c4 for metadata and system. I have added disks over time and thi=
s has
>>>  generally worked fine. The first 3 disks are all 8 TB and the newest o=
ne
>>>  (less than a week old) is 16TB.
>>>
>>>  After adding the latest disk, I ran a btrfs rebalance to move the data
>>>  around more sensibly. The rebalance for metadata worked (also from 1c3 =
to
>>>  1c4), but the rebalance for data keeps failing with errors like;
>>>
>>>  [152366.756416] BTRFS error (device sde): bdev /dev/sde errs: wr 0, rd =
0,
>>>  flush 0, corrupt 262, gen 0
>>>  [152366.757415] BTRFS warning (device sde): csum failed root -9 ino 17=
20 off
>>>  4055040 csum 0x19b6bbe6 expected csum 0x9bd067fb mirror 2
>>>
>>>  I was told that root -9 means these errors occur in the relocation tre=
e and
>>>  not actually in the data itself. I managed to balance the array for ma=
ybe
>>>  2/3rds by simply rebooting and rerunning the balance over and over, bu=
t now
>>>  it's at a point where it fails almost instantly when I try to run it.
>>
>>To find the offending file for balance failures, take the block group
>>number from the last "relocating block group NNNNNN" message, add the
>>'off NNNNNN' number from the "csum failed root -9" message, and pass the
>>result to 'btrfs ins log -o NNNNNN /filesystem/path'.  This should give
>>you a list of files that have read errors.  Remove them and the balance
>>should be able to proceed.
>>
>>Do the other stuff below first, as root -9 failures indicate _ongoing_
>>uncorrectable filesystem corruption, and you'll want to solve that before
>>doing any large amount of IO, especially balance.
>>
>>>  For reference, the command I'm using is  btrfs balance start -d /mount=
point
>>>
>>>  When this problem first started, I ran a scrub to see what was wrong,=
 but
>>>  the scrub returned clean.
>>>
>>>  Scrubbing is also where problem #2 comes in; whenever I run a scrub,
>>>  sometimes after leaving the whole thing turned off for days, there's a
>>>  50%-ish chance it returns with some corrupted CSUM error. In most of t=
hese
>>>  cases it's about 2 or 3 files max and the files seem entirely random;
>>>  sometimes brand new files, but often files that have been on the array =
for
>>>  years without being touched. In most of these CSUM error cases, it als=
o
>>>  affects BOTH copies of the file and the file cannot be fixed or recove=
red. I
>>>  find it hard to believe that a file that's been sitting there for year=
s
>>>  without issue is suddenly corrupted on both disks it resides on and I=
 think
>>>  it may be related to the CSUM error I face when rebalancing.
>>>
>>>  Things I have considered are; bad memory (though how would that corrup=
t BOTH
>>>  copies of a file that has been dormant for years?), or maybe a messed=
 up
>>>  SATA controller resulting in frequent read errors that btrfs sees as C=
SUM
>>>  errors? The CSUM errors also affect all 4 disks, including the brand n=
ew
>>>  one.
>>
>>Bad memory could, in theory, cause csum failures, even on old data.
>>The data is read into memory, the memory fails, the csum is calculated
>>based on the contents of memory (now corrupt), and compared to the stored
>>csum on disk.  These are now different due to the memory failure.
>>
>>For writes, the order of operations is different, and leads to persistent
>>data loss: the data starts in memory, a csum is calculated based on the
>>contents of memory, the memory fails, the data (now corrupt) is written
>>to disk (both mirrors), and the csum is written to disk soon after.
>>Later reads will never have the csum and data agree.
>>
>>On the other hand, for bad memory to cause this kind of problem, the
>>RAM failure frequency would have to be so high that the system would be
>>barely functional.  The filesystem's metadata would already have been
>>destroyed by this point.  There should also be other symptoms if RAM is
>>failing:  frequent crashes, unusual kernel messages, security software
>>complaining about potential hacking, etc.  and you haven't reported any
>>symptoms like these.
>>
>>It doesn't seem likely that these problems are caused by memory failure
>>(which includes components that support memory, like cooling and power
>>supply).  You could run memtest86 for a few days to make sure the host
>>RAM is healthy, but I would not expect that you'll find a problem there.
>>
>>SATA controller failure would cause csum failures on all incoming data,
>>regardless of age.  SATA controller failure would be consistent with
>>these symptoms, especially the corruptions that appear in the relocation
>>tree during balance; however, this has the same impact on metadata as
>>RAM failure--at this rate, it would likely have destroyed the filesystem
>>by this point.
>>
>>That leaves kernel bugs, and 5.10 (and 5.15) has a few known ones,
>>especially for read error correction and raid1c3 and raid1c4.  Some of
>>the worst of these problems are fixed in 6.0, so I'd try upgrading to
>>6.0 and see what problems remain.  (Don't bother with 5.19--that kernel
>>only has some of the fixes, and introduces new bugs of its own)
>>
>>If you're using any applications that use O_DIRECT writes incorrectly,
>>there's a small but non-zero chance they will write pages with bad csums.
>>This doesn't seem likely because you've mentioned failures being detected
>>after some days of downtime.
>>
>>>  Some system data;
>>>
>>>  # uname -a
>>>  Linux nasseract 5.10.0-18-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02)=
 x86_64
>>>  GNU/Linux
>>>  # btrfs --version
>>>  btrfs-progs v5.10.1
>>>  # btrfs fi show
>>>  Label: 'NassierDomer'  uuid: 99d9748a-2afa-421f-b56d-970c68dac58a
>>>          Total devices 4 FS bytes used 10.76TiB
>>>          devid    1 size 7.28TiB used 4.88TiB path /dev/sdb1
>>>          devid    2 size 7.28TiB used 4.88TiB path /dev/sdd
>>>          devid    3 size 7.28TiB used 5.96TiB path /dev/sdc
>>>          devid    4 size 14.55TiB used 5.89TiB path /dev/sde
>>>  # btrfs fi df /srv/dev-disk-by-label-NassierDomer/
>>>  Data, RAID1: total=3D10.78TiB, used=3D10.75TiB
>>>  System, RAID1C4: total=3D32.00MiB, used=3D1.53MiB
>>>  Metadata, RAID1C4: total=3D12.00GiB, used=3D11.53GiB
>>>  GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>
>>>  Relevant dmesg entries after boot;
>>>
>>>  [    7.998580] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0, rd =
0,
>>>  flush 0, corrupt 308, gen 0
>>>  [    7.998587] BTRFS info (device sdb1): bdev /dev/sdd errs: wr 0, rd=
 0,
>>>  flush 0, corrupt 300, gen 0
>>>  [    7.998590] BTRFS info (device sdb1): bdev /dev/sdc errs: wr 0, rd=
 0,
>>>  flush 0, corrupt 177, gen 0
>>>  [    7.998593] BTRFS info (device sdb1): bdev /dev/sde errs: wr 0, rd=
 0,
>>>  flush 0, corrupt 53, gen 0
>>>
>>>  Note that /dev/sde is less than a week old.
>>>
>>>  I'm tempted to gut this entire machine and replace everything except t=
he
>>>  drives, but maybe someone has some better (cheaper) ideas to fix what=
 is
>>>  going on here?
>>
>>If you are able to confirm that it is a RAM or SATA controller issue,
>>stop using that hardware immediately.  Failures in these subsystems will
>>steadily corrupt everything the host touches, until a critical page of
>>metadata is corrupted, then the filesystem is damaged beyond the reach
>>of current tools to repair.
>>
>>There are two main scenarios consistent with the reported symptoms:  1)
>>kernel bugs + hardware failure inside the disks, and 2) hardware failure
>>outside of the disks without kernel bugs.
>>
>>In scenario 1, some drive or SATA controller is failing, and seeding the
>>filesystem with a few random corruption errors.  Later, a kernel bug
>>fails to handle or repair those errors, causing some more failures in
>>downstream processing.  Most of these failures will not be persistent,
>>i.e. most will be cleared by a umount/mount, and only the few that are
>>actually caused by disks will remain.
>>
>>In scenario 2, the RAM or SATA controller is failing intermittently,
>>causing all of the above symptoms, but it was initially OK (so the earlie=
r
>>metadata balance succeeded) and is now getting progressively worse--and
>>so far, you've been lucky, and metadata hasn't been hit yet.
>>
>>The scary scenario is #2, because if that's the true scenario, then
>>everything you do with this hardware will bring the filesystem closer to
>>destruction.  If the hardware is getting progressively worse, catastrophi=
c
>>failure will happen even sooner.
>>
>>I'd recommend ruling out scenario 2 first.  Take the system offline
>>and do some basic memory and SATA controller tests.  e.g. boot from
>>external media and run 'sha1sum /dev/sd?' a few times, see if the
>>results change.  Or 'head -c 100G /dev/sda | sha1sum' to read just a few
>>hundred GB from each disk, and repeat several times to see if the results
>>change.  A bad SATA controller will never return the same data twice.
>>Run memtest86 for a few days.
>>
>Ok, so I ran memtest86 and it raked up over 200 errors in the first hour.
>I have no idea how this machine was even alive and running to begin with.
>
>I've now replaced all the insides; new mainboard, new CPU, new RAM.
>It seems to be running a lot better, but it also started showing serious
>disk errors during bootup on the oldest 2 disks. Along these lines;
>
>[ 1164.480056] ata2.00: failed command: READ FPDMA QUEUED
>[ 1174.480251] ata2: softreset failed (1st FIS failed)
>[ 1189.996062] ata2.00: link online but device misclassified
>
>
>I already suspected something was off there, but the previous system
>never reported anything for whatever reason.
>
>I am now 10% into running a btrfs replace -r on the most broken of the
>2 old disks and so far so good.
>
>I guess a lot of the hardware was actually old and broken, but it didn't
>show until I replaced the guts of the machine. Very peculiar.
>
>
>>
>>Once you're sure you're not in scenario 2 (or if you have good backups an=
d
>>are willing to rebuild if it turns out scenario 2 was the right one), the=
n
>>try doing what you're already doing, but on kernel 6.0.  I'd expect eithe=
r
>>the problems to stop completely, or be reduced to specific drives that ar=
e
>>failing (and should be replaced).
>>
>>
>Disk replacement in progress...
>The kernel did not change, though, but perhaps the new controller reports
>more information that was previously just not there? I don't know...
>
>I will report back with the final status and whether or not the balance wo=
rked
>after both disks are replaced and I'm no longer facing disk-level errors.
>
Disk replacement done. Still 1 error on the balance, but I was able to=20
find and remove
the affected file. After that balance and scrub are fine.

Bottom line: a combination of various really faulty hardwares that all=20
needed replacing.

It's a miracle this thing is still alive.... thanks for the help!

>

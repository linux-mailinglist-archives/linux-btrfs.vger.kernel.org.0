Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F4BC90C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfIXNmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 09:42:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37253 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfIXNmX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 09:42:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so1907863edy.4
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=sIyl1m5MMxGn6hNH6vccIpWMOYqw2egRafMe8TMHrgo=;
        b=haF+QGfveQot/0t6GOte7MoWXjCoDrRWRAhBqGuNznaSmDiRB881SidRhn1OavjGXF
         tl62QPuX64korVfc8YNG2SOSbuORposDSjXHLT7JYBEUOhmUPGrx9RY57pcw2uhSjQQi
         KYuSyLnziyU7AcZARxVNP4TbnUNkllnByJNJTvpJQ4xfNNkdszBFsQS06+DlqkG/IXFN
         KjpQE3l+bCTVbfnHLG282iazsMd9CCP2GuRwWvksJu0sS78NR+6LrzP7EqlI/MqjRd/4
         0yYSIkpptkEY7PCMZRNB5Vi4aWspvnDAEEdbe97IJmswKZDc6tGCWhWTUoaVBu3OeKxE
         7W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=sIyl1m5MMxGn6hNH6vccIpWMOYqw2egRafMe8TMHrgo=;
        b=FK2d3sa8ExDZ5K+OEz6y6mephttkVbAW0ZSg0IQaIa4HeLS3Oti3TMHppgeN8soGer
         JaoxFZrlZSCHxIxaLR6Dl9gj8DKf7X2gUo/FT5llCqZLjVA8szXJ630ljJTRgmGTyrMJ
         YV8cxgbBuQ6AQQuXrwGcAcJxuQK9OJoB6wneLTmf+hMZHk2ctGkHPKs1uFp1uIxoFqE4
         hR76PaQMRNrp1E84TqTYFih+rogEWsKvH8hdpQhY1WTqB/oMRanmtiQMQ9CW98BbKxVW
         hNS8ParU1lzFZHQVjLbeWJJFRZuMkQqKyno/1EOvOBNQ+sjZXuuI2fDHzabZVrTNUcN9
         khtg==
X-Gm-Message-State: APjAAAVj2gkw5A/YOqWr5JTYZp6QvhiWH4iadGRpxP58qDoOZKk10Yeo
        hs5b8aECSz1q3minPCijeg/Egt1SNeA=
X-Google-Smtp-Source: APXvYqzEY/j5KmYTO4UYdknW9EBsGylJIU2hXBXB5p8BUpDHZQnhL5wfue8iyDHIXd6fVNSiQxxTDg==
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr2528497ejb.16.1569332541327;
        Tue, 24 Sep 2019 06:42:21 -0700 (PDT)
Received: from MHPlaptop ([86.48.99.210])
        by smtp.gmail.com with ESMTPSA id l7sm369702edv.84.2019.09.24.06.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:42:20 -0700 (PDT)
From:   <hoegge@gmail.com>
To:     "'Chris Murphy'" <lists@colorremedies.com>
Cc:     "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com> <003f01d5724c$f1adae30$d5090a90$@gmail.com> <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
In-Reply-To: <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
Subject: RE: BTRFS checksum mismatch - false positives
Date:   Tue, 24 Sep 2019 15:42:19 +0200
Message-ID: <005301d572dd$e378c7a0$aa6a56e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDC/7g4S9J6FUg0YRCQl8sHX15RDgIzZwHmAUBixXoBtxE1ZKk2YUkA
Content-Language: en-us
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry forgot root when issuing commands:

ash-4.3# btrfs fi show                                                   =
                                                  =20
Label: '2016.05.06-09:13:52 v7321'  uuid: =
63121c18-2bed-4c81-a514-77be2fba7ab8
Total devices 1 FS bytes used 4.31TiB
devid    1 size 9.97TiB used 4.55TiB path /dev/mapper/vg1-volume_1

ash-4.3# btrfs device stats /volume1/                                    =
                                                  =20
[/dev/mapper/vg1-volume_1].write_io_errs   0
[/dev/mapper/vg1-volume_1].read_io_errs    0
[/dev/mapper/vg1-volume_1].flush_io_errs   0
[/dev/mapper/vg1-volume_1].corruption_errs 1014
[/dev/mapper/vg1-volume_1].generation_errs 0

ash-4.3# btrfs fi df /volume1/                                           =
                                                  =20
Data, single: total=3D4.38TiB, used=3D4.30TiB
System, DUP: total=3D8.00MiB, used=3D96.00KiB
System, single: total=3D4.00MiB, used=3D0.00B
Metadata, DUP: total=3D89.50GiB, used=3D6.63GiB
Metadata, single: total=3D8.00MiB, used=3D0.00B
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

Synology indicates that BTRFS can do self healing of data using RAID =
information? Is that really the case if it is not a "BTRFS raid" but a =
MD or SHR raid?





-----Original Message-----
From: Chris Murphy <lists@colorremedies.com>=20
Sent: 2019-09-23 22:59
To: hoegge@gmail.com
Cc: Chris Murphy <lists@colorremedies.com>; Btrfs BTRFS =
<linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS checksum mismatch - false positives

On Mon, Sep 23, 2019 at 2:24 PM <hoegge@gmail.com> wrote:
>
> Hi Chris
>
> uname:
> Linux MHPNAS 3.10.105 #24922 SMP Wed Jul 3 16:37:24 CST 2019 x86_64=20
> GNU/Linux synology_avoton_1815+
>
> btrfs --version
> btrfs-progs v4.0
>
> ash-4.3# btrfs device stats .
> [/dev/mapper/vg1-volume_1].write_io_errs   0
> [/dev/mapper/vg1-volume_1].read_io_errs    0
> [/dev/mapper/vg1-volume_1].flush_io_errs   0
> [/dev/mapper/vg1-volume_1].corruption_errs 1014=20
> [/dev/mapper/vg1-volume_1].generation_errs 0

I'm pretty sure these values are per 4KiB block on x86. If that's =
correct, this is ~4MiB of corruption.


> Concerning self healing? Synology run BTRFS on top of their SHR - =
which means, this where there is redundancy (like RAID5 / RAID6). I =
don't think they use any BTRFS RAID  (likely due to the RAID5/6 issues =
with BTRFS). Does that then mean, there is no redundancy / self-healing =
available for data?

That's correct. What do you get for

# btrfs fi show
# btrfs fi df <mountpoint>

mountpoint is for the btrfs volume - any location it's mounted on will =
do



> How would you like the log files - in private mail. I assume it is the =
kern.log. To make them useful, I suppose I should also pinpoint which =
files seem to be intact?

You could do a firefox send which will encrypt it locally and allow you =
to put a limit on the number of times it can be downloaded if you want =
to avoid bots from seeing it. *shrug*

>
> I gather it is the "BTRFS: (null) at logical ... " line that indicate =
mismatch errors ? Not sure why the state "(null"). Like:
>
> 2019-09-22T16:52:09+02:00 MHPNAS kernel: [1208505.999676] BTRFS:=20
> (null) at logical 1123177283584 on dev /dev/vg1/volume_1, sector=20
> 2246150816, root 259, inode 305979, offset 1316306944, length 4096,=20
> links 1 (path: Backup/Virtual Machines/Kan slettes/Smaller Clone of=20
> Windows 7 x64 for win 10 upgrade.vmwarevm/Windows 7 x64-cl1.vmdk)

If they're all like this one, this is strictly a data corruption issue. =
You can resolve it by replacing it with a known good copy. Or you can =
unmount the Btrfs file system and use 'btrfs restore' to scrape out the =
"bad" copy. Whenever there's a checksum error like this on Btrfs, it =
will EIO to user space, it will not let you copy out this file if it =
thinks it's corrupt. Whereas 'btrfs restore' will let you do it. That =
particular version you have, I'm not sure if it'll complain, but if so, =
there's a flag to make it ignore errors so you can still get that file =
out. Then remount, and copy that file right on top of itself. Of course =
this isn't fixing corruption if it's real, it just makes the checksum =
warnings go away.

I'm gonna guess Synology has a way to do a scrub and check the results =
but I don't know how it works, whether it does a Btrfs only scrub or =
also an md scrub. You'd need to ask them or infer it from how this whole =
stack is assembled and what processes get used. But you can do an md =
scrub on your own. From 'man 4 md'

 "      md arrays can be scrubbed by writing either check or repair to
the file md/sync_action in the sysfs directory for the device."

You'd probably want to do a check. If you write repair, then md assumes =
data chunks are good, and merely rewrites all new parity chunks. The =
check will compare data chunks to parity chunks and report any mismatch =
in

"       A count of mismatches is recorded in the sysfs file
md/mismatch_cnt.  This is set to zero when a scrub starts and is =
incremented whenever a  sector "

That should be 0.

If that is not a 0 then there's a chance there's been some form of =
silent data corruption since that file was originally copied to the NAS. =
But offhand I can't account for why they trigger checksum mismatches on =
Btrfs and yet md5 matches the original files elsewhere.

Are you sharing the vmdk over the network to a VM? Or is it static and =
totally unused while on the NAS?



Chris Murphy


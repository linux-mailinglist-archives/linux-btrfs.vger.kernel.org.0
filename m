Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB2BC4D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504204AbfIXJ3c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 05:29:32 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36578 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504186AbfIXJ3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:29:32 -0400
Received: by mail-lj1-f174.google.com with SMTP id v24so1152834ljj.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ijPkrpIz1VZeCuM6JMRGi8KaPrk48cdPCWW1x/wy/Bc=;
        b=BpYuu8yBsAKICB96LE4XZ6Utzl7jS/LMMcnj2RZW6JUytn2+K8JvXptMfwOj5dzC4H
         GruHDFuh1YtIER5n43xS4EUjoVHu9XSzQ/nVRfdfj53KgjWK7gE7GjeKDQYsRabpAQ5g
         QYsQhIJC7qjOstx1dZSM9FtQg+MEdwprgHjbT2+B6qDmoo7U/U6G/ViUF6Ropejhwfzg
         A7AboW1mSjRilLq4FI34T8qqQUflpE4noN7WVplHKzYbza58OE8l+WVtS+iJcGPP0fnf
         ogCnkeL6939ydkogzkWbfKyNyTeavPQDqCxDhOar7hvg4RaWsX73UXSOQnmcN/tSTP+A
         qOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ijPkrpIz1VZeCuM6JMRGi8KaPrk48cdPCWW1x/wy/Bc=;
        b=St+a+pK4zK+yB/AG1taYlnT5kgG+7IDwczntLbAdfRhO3EgKHTCHDNeHf3cH0rz7nx
         vARQMeN76WLBcQdV0ia8+upzoDQBtxYmeX2BI3S4cwnaea1JxooYqCxA8Bt5qwUFos56
         i/knrg6Hn2aFG10Pur5rtNgs3MjkmaXMGy3ggxVs1BfRvD3GqV1eHiByVLmyjgq0APuR
         hbja56vJG0Fuq3ONNmEARIVXLB1dgCtJpBp0crNq6Oj699ek0TndAjg+XCTkjXwOfppn
         rlkLffrHY7Z5NUTnlsu+rFGiVIxR9zbvtFSCW03bFHwTdDu818pzcnkh1+slfbAvxal0
         4Hhg==
X-Gm-Message-State: APjAAAWWSBCcD2tZZ2PU6cvsJ4Q19tqmgsrTEXfW0yfJK7rI02IN6/ZO
        PGroMXoJBBhyOLypCjkjlu91AqqcBRo=
X-Google-Smtp-Source: APXvYqxVc1RvaSyFmGMuMStPPh9Evctay1yyVPlKLnQupRCSiNh9leEvEoAUYrezxR83bwbS9H0N7Q==
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr1292145ljc.210.1569317368994;
        Tue, 24 Sep 2019 02:29:28 -0700 (PDT)
Received: from MHPlaptop ([86.48.99.210])
        by smtp.gmail.com with ESMTPSA id x6sm348302ljh.99.2019.09.24.02.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 02:29:28 -0700 (PDT)
From:   <hoegge@gmail.com>
To:     "'Chris Murphy'" <lists@colorremedies.com>
Cc:     "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com> <003f01d5724c$f1adae30$d5090a90$@gmail.com> <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
In-Reply-To: <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
Subject: RE: BTRFS checksum mismatch - false positives
Date:   Tue, 24 Sep 2019 11:29:28 +0200
Message-ID: <001601d572ba$90591b60$b10b5220$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDC/7g4S9J6FUg0YRCQl8sHX15RDgIzZwHmAUBixXoBtxE1ZKk2GkpQ
Content-Language: en-us
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

# btrfs fi show
gives no result - not when adding path either

# btrfs fi df /volume1
Data, single: total=3D4.38TiB, used=3D4.30TiB
System, DUP: total=3D8.00MiB, used=3D96.00KiB
System, single: total=3D4.00MiB, used=3D0.00B
Metadata, DUP: total=3D89.50GiB, used=3D6.63GiB
Metadata, single: total=3D8.00MiB, used=3D0.00B
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

Here is the log:
https://send.firefox.com/download/5a19aee66a42c04e/#PTt0UkT53Wrxe9EjCQfrW=
A (password in separate e-mail)
I have removed a few mac-addresses and things before a certain data =
(that contained all other kinds of info). Let me know if it is too =
little.

Concerning restoring files - I should have all originals backed up, so =
assume I can just delete the bad ones and restore the originals. That =
would take care also of all the checksums, right? But BTRFS does not do =
anything to prevent the bad blocks from being used again, right?
I'll ask Synology about their stack.

I can't find sysfs on the system - should it be mounted uner /sys ? This =
is what I have:
morten@MHPNAS:/$ cd sys
morten@MHPNAS:/sys$ ls
block  bus  class  dev  devices  firmware  fs  kernel  module  power
morten@MHPNAS:/sys$ cd fs
morten@MHPNAS:/sys/fs$ ls
btrfs  cgroup  ecryptfs  ext4  fuse  pstore
morten@MHPNAS:/sys/fs$


With respect to the vmdk, I only store it on the NAS for backup.=20

Thanks a lot

Best=20
Hoegge

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


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709881C1B10
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgEARCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 13:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728975AbgEARCa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 13:02:30 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0BC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 10:02:30 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c83so850878oob.6
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yYl7Dsez+0Y3rKqMBM3c7JN7PneKl+lk3kgpLpwIJp0=;
        b=DXwkS7jakeFZR2CkGhgmW14yLT2WQZajocmA4n3ReHnzOGC/sSoJp5KU58ETVVIKwf
         7KW/q6kElr6/hu2SksDWo90gfPPKiRoSQgwVTlq1kRzNcv57piiLjcbrltuf1IIBuHiR
         xZFTeYGBUs6RGvZxtJvPOQRWN5GK88PkCcQAUve5sBcpazUl7EILgUJuewI5VlC8+l/p
         aOiiQUQ9RXK1FZSmUPXkpUm+Skav9OC4LH4A5IeCUzScuV8Z/7F9sc9ZTGjz8FPdFgCb
         p9+05XAFzT9OUq2tJJMv6VQ1aUEGvqsDUtKrMhMhflS/ni6Phi/hZ1I8qP38svEDbcYa
         EWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yYl7Dsez+0Y3rKqMBM3c7JN7PneKl+lk3kgpLpwIJp0=;
        b=ewQWf7vWg5BqQEHpxLxLCIFQOReK7BZNNlNPxOc5rSjf25YpQYlURECPBwHXM8lofx
         oo5sw3i12CAziEcBBbh0enxBVx0cAau9RdfjTJyVl6VjNrn4Oy6K/0x5aWUCfTHeEuAy
         EjvLmzAJ8oMjTsIcUKfTYolX8lu1TF9YnZd4DrmoGfOOxIwlC6IQh1HFcwc25WweHCIg
         AvPMJsIxApsyzEkEGetfAJHezPAWdgGv+36FL/I0VCGATlZxOp9sKUB8Tnp7a75oneyk
         sn9UP7FfHW3eYc7ga/PD8hy2cAhXNoCBPFEFJAH2V/mt/kKjKlNmY9JdFiI4V7GUzBGr
         F/5A==
X-Gm-Message-State: AGi0PuYhXq13He8y4UEp0vaahNDphXx5b7lKDFEX2/n0fYQzJePiBi5r
        eNryb5ta1j138Km3Bx3QDhdc3HwjdsCkEUaogMJSgI/c1R4=
X-Google-Smtp-Source: APiQypIVNbZwnYqqJ2Hbv/xGmvFHVMb746eLN6A2Z2Eixd3RWO6nWHKBNp9UF84lQlGAbQ3X7tPqDV+53yNWbZivcJo=
X-Received: by 2002:a4a:ca14:: with SMTP id w20mr4589247ooq.42.1588352549367;
 Fri, 01 May 2020 10:02:29 -0700 (PDT)
MIME-Version: 1.0
From:   Rollo ro <rollodroid@gmail.com>
Date:   Fri, 1 May 2020 19:01:53 +0200
Message-ID: <CAAhjAp1zghNnRpbA2WypBU9+Azeui8kTQiTj+DfbK-iX-z71WQ@mail.gmail.com>
Subject: Can't repair raid 1 array after drive failure
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again,
I'm still running into problems with btrfs. For testing purposes, I
created a raid 1 filesystem yesterday and let the computer copy a ton
of data on it over night:

Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
        Total devices 3 FS bytes used 1.15TiB
        devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
        devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
        devid    4 size 1.82TiB used 1.15TiB path /dev/sde

Today I started scrub and looked at the status some hours later, which
gave thousands of errors on drive 4:

root@OMV:/var# btrfs scrub status /srv/dev-disk-by-label-BTRFS1/
scrub status for 61e5aba9-6811-46ae-9396-35a72d3b1117
        scrub started at Fri May  1 11:37:36 2020, running for 04:37:48
        total bytes scrubbed: 1.58TiB with 75751000 errors
        error details: read=75751000
        corrected errors: 0, uncorrectable errors: 75750996,
unverified errors: 0

(Not shown here that it was drive 4, but it was)

Then found that the drive is missing:

Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
        Total devices 3 FS bytes used 1.15TiB
        devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
        devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
        *** Some devices missing

Canceled scrub:
root@OMV:/var# btrfs scrub cancel /srv/dev-disk-by-label-BTRFS1/
scrub cancelled

Stats showing lots of error on sde, which is the missing drive:
root@OMV:/var# btrfs device stats /srv/dev-disk-by-label-BTRFS1/
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0
[/dev/sdf].write_io_errs    0
[/dev/sdf].read_io_errs     0
[/dev/sdf].flush_io_errs    0
[/dev/sdf].corruption_errs  0
[/dev/sdf].generation_errs  0
[/dev/sde].write_io_errs    154997860
[/dev/sde].read_io_errs     77170574
[/dev/sde].flush_io_errs    310
[/dev/sde].corruption_errs  0
[/dev/sde].generation_errs  0


I tried to replace
root@OMV:/var# btrfs replace start 2 /dev/sdb /srv/dev-disk-by-label-BTRFS1/ &
[1] 1809
root@OMV:/var# ERROR: '2' is not a valid devid for filesystem
'/srv/dev-disk-by-label-BTRFS1/'

--> That's inconsistent with the device remove syntax, as it allows to
use a non-existing number? I try again using the /dev/sdx syntax, but
as sde is gone, I rescan and now it's sdi!

root@OMV:/var# btrfs replace start /dev/sdi /dev/sdb
/srv/dev-disk-by-label-BTRFS1/
root@OMV:/var# ERROR: target device smaller than source device
(required 2000398934016 bytes)

--> OK, there is a rerstriction in drive size. Not sure if this is
relly necessary because the size is sufficient to hold all data in
raid 1 profile, but ok, if it's implemented like that. I have no
larger drive available. So I try to replace by adding another drive
and removing the failed drive

root@OMV:/var# btrfs dev add /dev/sdb /srv/dev-disk-by-label-BTRFS1/
root@OMV:/var# btrfs fi show

Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
        Total devices 4 FS bytes used 1.15TiB
        devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
        devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
        devid    5 size 931.51GiB used 0.00B path /dev/sdb
        *** Some devices missing

root@OMV:/var# btrfs device remove missing /srv/dev-disk-by-label-BTRFS1/
ERROR: error removing device 'missing': no missing devices found to remove

--> But fi show tells there is are devices missing??

root@OMV:/var# btrfs device remove 2 /srv/dev-disk-by-label-BTRFS1/
Killed

--> What does "Killed" tell?

Try again with a non-existent number:
root@OMV:/var# btrfs device remove 8 /srv/dev-disk-by-label-BTRFS1/
ERROR: error removing devid 8: add/delete/balance/replace/resize
operation in progress

--> Seems like there is some operation going on, but fi show doesn't
show any progress:

root@OMV:/var# btrfs fi show
Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
        Total devices 4 FS bytes used 1.15TiB
        devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
        devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
        devid    5 size 931.51GiB used 0.00B path /dev/sdb
        *** Some devices missing

--> The used space on drive 5 should be increasing, but isn't. Also no
hdd activity LED flashing.

Try to start balance, but balance status reporting that no balance found:

root@OMV:/var# btrfs balance start --bg /srv/dev-disk-by-label-BTRFS1/
root@OMV:/var# btrfs balance status /srv/dev-disk-by-label-BTRFS1/
No balance found on '/srv/dev-disk-by-label-BTRFS1/'

I think that the data is still OK. There are messages like

May  1 14:05:44 OMV kernel: [235034.853573] BTRFS warning (device
sdc1): i/o error at logical 774427533312 on dev /dev/sde, physical
656521453568, root 471, inode 458, offset 64360448, length 4096, links
1 (path: Filme/Meine erfundene Frau.mkv)

I calculated sha256 on the file (which is a crappy movie) and compared
with the original. The file is read correct. I have not checked all
files, but guess they are readable. But how to return to a healthy and
redundant filesystem now? I'd try next if a reboot does help, but
wanted to ask for further steps before. And, are there any log files
or other information that will be useful for the developers?

Note: The 2TB drive is not the bad drive that I mentioned in my other
mail, but a drive that has worked without showing problems and has
been removed from my old NAS to increase capacity a couple of years
ago. It's possible that there are some hardware issues with the
mainboard, SATA cables or drives, though. It's all old hardware.

Version info:
btrfs-progs v4.20.1
Kernel 5.4.0-0.bpo.4-amd64

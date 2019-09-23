Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F97BBCC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfIWUYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 16:24:51 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:32782 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfIWUYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 16:24:51 -0400
Received: by mail-ed1-f43.google.com with SMTP id c4so14236411edl.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=kxJ6CIprqqDd5dNr3Nagpw3CWuwHYOW9tiFFcoLB9As=;
        b=LErxDdkqZoQXZ9ALLz0EVWIf3uwZ6bFOw/MnpilJop4hxCz4XATTMvJ1a14uWaPtqn
         k21r6uHc5/TO/LB0e+vnmWhj3qYX0ez0DW2OgFsJ9n3SfrLeEairtS4+4KlJ2/brnQ/q
         DZs0gjbD24JBvR5B0l3zfdAYUjJrCx2yiQPtzOGslo+tAsW/8tak4JTXiKa/ge7MTar5
         jyDc9DLCObni65u+xxlGkydABCSeSt56IBWsx09eCM9XdTF0TUwC/7DQcHx6zqIzCwsF
         ZhSug3UgKrwNz1ZkiPTY9rLla762p1sUyhuabpFtrbuB6SgweWj9bV2WeH/VoE8RDFhz
         7nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=kxJ6CIprqqDd5dNr3Nagpw3CWuwHYOW9tiFFcoLB9As=;
        b=U+3+Ymkl36GSq1Qq0nkgOs8nbMWvkDuhdUsOMsZwREsNSrA7EGXMKegOUrkoaEhDbL
         w+ydNxK7OW0ZbSD6ipfhRNX9KvlKI7Iy4LgFjCCo16TaEewokp7PJjMpkTNCrMZnwBge
         M92xAmbuozF+KYRMQXyNsWHKr1b5n9VIZUlp+1GY0DPUZ6BCmlHpxNmLypolSndAkRKy
         W5gQMX7lolHYDHgvuftvvtBno/qJrjDkLRrvo+pBDaj8FgrgIFoCLMUz2Z3lLisUINyn
         O+Rey6DXZl59WyfQ/virhdX09tgM0Hn5EsmkMYsnHBj9SKLUkVl6AMSprulLwzn8ph4u
         cbPA==
X-Gm-Message-State: APjAAAX4u+wSODqqR+h0bT/oXV6TcrCK2ZDpTG7Ml88krsrzjGvItfC8
        ojokMp6XI4ZPAbbilhbiv+9U0PEO600=
X-Google-Smtp-Source: APXvYqydsP354E14Mwn6cEQZk22R7U4LSNoKJhDN3M0+qVsWpaL/CXDENaR/hh97SbYumRvqjqfw9g==
X-Received: by 2002:a17:906:c738:: with SMTP id fj24mr1449830ejb.255.1569270288668;
        Mon, 23 Sep 2019 13:24:48 -0700 (PDT)
Received: from MHPlaptop (xd520f268.cust.hiper.dk. [213.32.242.104])
        by smtp.gmail.com with ESMTPSA id n12sm2579793edi.1.2019.09.23.13.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:24:47 -0700 (PDT)
From:   <hoegge@gmail.com>
To:     "'Chris Murphy'" <lists@colorremedies.com>
Cc:     "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com>
In-Reply-To: <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com>
Subject: RE: BTRFS checksum mismatch - false positives
Date:   Mon, 23 Sep 2019 22:24:46 +0200
Message-ID: <003f01d5724c$f1adae30$d5090a90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDC/7g4S9J6FUg0YRCQl8sHX15RDgIzZwHmqUzwYnA=
Content-Language: en-us
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris

uname:
Linux MHPNAS 3.10.105 #24922 SMP Wed Jul 3 16:37:24 CST 2019 x86_64 =
GNU/Linux synology_avoton_1815+

btrfs --version                                                          =
                                 =20
btrfs-progs v4.0

ash-4.3# btrfs device stats .                                            =
                                                                         =
                                                                         =
                =20
[/dev/mapper/vg1-volume_1].write_io_errs   0
[/dev/mapper/vg1-volume_1].read_io_errs    0
[/dev/mapper/vg1-volume_1].flush_io_errs   0
[/dev/mapper/vg1-volume_1].corruption_errs 1014
[/dev/mapper/vg1-volume_1].generation_errs 0

Concerning self healing? Synology run BTRFS on top of their SHR - which =
means, this where there is redundancy (like RAID5 / RAID6). I don't =
think they use any BTRFS RAID  (likely due to the RAID5/6 issues with =
BTRFS). Does that then mean, there is no redundancy / self-healing =
available for data?=20

How would you like the log files - in private mail. I assume it is the =
kern.log. To make them useful, I suppose I should also pinpoint which =
files seem to be intact?

I gather it is the "BTRFS: (null) at logical ... " line that indicate =
mismatch errors ? Not sure why the state "(null"). Like:

2019-09-22T16:52:09+02:00 MHPNAS kernel: [1208505.999676] BTRFS: (null) =
at logical 1123177283584 on dev /dev/vg1/volume_1, sector 2246150816, =
root 259, inode 305979, offset 1316306944, length 4096, links 1 (path: =
Backup/Virtual Machines/Kan slettes/Smaller Clone of Windows 7 x64 for =
win 10 upgrade.vmwarevm/Windows 7 x64-cl1.vmdk)

Best
Hoegge

-----Original Message-----
From: Chris Murphy <lists@colorremedies.com>=20
Sent: 2019-09-23 21:12
To: hoegge@gmail.com
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS checksum mismatch - false positives

On Mon, Sep 23, 2019 at 12:19 PM <hoegge@gmail.com> wrote:
>
> Dear BTRFS mailing list,
>
> I'm running BTRFS on my Synology Diskstation and they have referred me =

> to the BTRFS developers.

If it's a generic question that's fine, but all the development =
happening on this list is very recent kernels and btrfs-progs, which is =
not typically the case with distribution specific products.

>
> For a while I have had quite a few (tens - not hundreds) checksum=20
> mismatch errors on my device (around 6 TB data). It runs BTRFS on SHR=20
> (Synology Hybrid Raid). Most of these checksum mismatches, though, do =
not seem "real".
> Most of the files are identical to the original files (checked by=20
> binary comparison and by recalculated MD5 hashes).
>
> What can explain that problem? I thought BTRFS only reported checksum=20
> mismatch errors, when it cannot self-heal the files?

It'll report them in any case, and also report if they're fixed. There =
are different checksum errors depending on whether metadata or data are =
affected (both are checksummed). Btrfs can only self-heal with redundant =
copies available. By default metadata is duplicated and should be able =
to self-heal, but data is not redundant by default. So it'd depend on =
how the storage stack layout is created.

We need logs though. It's better to have more than less, if you can go =
back ~5 minutes from the first report of checksum mismatch error, that's =
better than too aggressive log trimming. Also possibly useful:

# uname -a
# btrfs --version


--
Chris Murphy


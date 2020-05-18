Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1361D8BC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 01:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgERXp2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 19:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXp1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 19:45:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65764C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 16:45:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m12so1200057wmc.0
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NI4QH+VlzZV2i2gRNkvk49R1S9p9J6ybZTfZ18ic3KQ=;
        b=GLcPGC4DqMwohuXlKUCXcuKpIhUviWgjLNm47dj7SvIK2gr/JLqVZ++bvbtsiaJp4e
         9Ct9hoq8Mvwt5C46Ox5suD2uz4pfNsI0CAH9VsFhsJ2UZbz8++urgK54rILLxdx4AwBF
         HreOlzlsV7NzIegd+xWIkWK3pjzoNothUANfhWrX4yNZ9uAQwLEWmG8gL49I8yPC2QgU
         5bHNmsLEpeD1ww2xLAYi/d+UqLKjvdl+fBL0ogRp8RRxWLmHbxFp6OYv4kw3bh9KfR01
         GPz7hGQ0kcAqiARDMKY4+wVJzS84AG8LccWnwdsxCQyvo57rtT5mh8XxuLCMwBCWbCd3
         7P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NI4QH+VlzZV2i2gRNkvk49R1S9p9J6ybZTfZ18ic3KQ=;
        b=mRrQOt6oQ2asGpSTCBxuU9EplTWiMLjlOfweJi6php9EIfvxk50LGy1TYs2TJn+ccr
         PVwG5SYMN3YQAcpnkH7UROLaMbSC4QBnT7i42wiNzkygXxZuWwSnZsB1w4N9gx55T0NW
         DcLOMA5znqH1LQ3skHtZyP4U4uEpvq3Y2ro8yak/PaeA58wwdIZWxcm1IQ+Ww0jkTORX
         ssPgrUJ0a1s20+rxhDJ8e9IQxmTIp4i+6ChGwemDK+9752uKZK5GtPbLezJPd86tXrvo
         F7a02POhbqOzn+NPKJSl9HEPf/PJDVNV7LnLz4dEDHMr35T0QrrYpkByMtVg0wQf//lp
         1uJg==
X-Gm-Message-State: AOAM5315liYC8yTIj2Id8pUdtiLIhHk455S4DDI0cHRYgl8ROHBdcDKh
        qaDq7w5YKGsOJ8nwE6WwwZYJ8Dir7f1OVsqPTn6aRB4OoB4=
X-Google-Smtp-Source: ABdhPJzY0Ouv0qiXT6wMAkGLCLNpdJ64XEzIo/iLDbJ0AFRElV9Dp08RP+j8hHq2DN1BR6l8UYzAwpJIIaiuKKZUCRs=
X-Received: by 2002:a1c:2348:: with SMTP id j69mr1983174wmj.11.1589845526108;
 Mon, 18 May 2020 16:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
In-Reply-To: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 May 2020 17:45:09 -0600
Message-ID: <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com>
Subject: Re: I can't mount image
To:     =?UTF-8?B?SmnFmcOtIExpc2lja8O9?= <jiri_lisicky@seznam.cz>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 17, 2020 at 1:54 PM Ji=C5=99=C3=AD Lisick=C3=BD <jiri_lisicky@s=
eznam.cz> wrote:
>
> Hi, I have Jolla 1 Phone, which use btrfs. With bad battery, phone x time=
s suddenly turned off. Now is bricked. I go into recovery mode
> and copy image to my PC with Fedora Live 31 with kernel 5.6.6.
>
> ~ # losetup --find --show /home/jirka/tmp/jolla.img
> /dev/loop0
>
> ~ # btrfs fi show
> Label: 'sailfish'  uuid: 86180ca0-d351-4551-b262-22b49e1adf47
>  Total devices 1 FS bytes used 4.73GiB
>   devid    1 size 13.75GiB used 13.75GiB path /dev/loop0
>
> ~ # mount -t btrfs /dev/loop0 ~/mnt
> mount: /dev/loop0: can't read superblock
>
> ~ # mount -t btrfs -o usebackuproot /dev/loop0 ~/mnt
> mount: /dev/loop0: can't read superblock
>
> ~ # btrfs rescue super-recover /dev/loop0
> All supers are valid, no need to recover

Weird. How does it not read the superblock, but all superblocks are
valid? What do you get for

btrfs insp dump-s -fa /dev/loop0


> ~ # LC_ALL=3DC btrfs rescue zero-log /dev/loop0
> Clearing log on /dev/loop0, previous log_root 0, level 0

This is not advised except in specific cases which the man page gives
examples of.


> ~ # btrfs fi df ~/mnt
> Data, single: total=3D13.08GiB, used=3D4.51GiB
> System, DUP: total=3D8.00MiB, used=3D4.00KiB
> System, single: total=3D4.00MiB, used=3D0.00B
> Metadata, DUP: total=3D330.00MiB, used=3D224.30MiB
> Metadata, single: total=3D8.00MiB, used=3D0.00B
> GlobalReserve, single: total=3D512.00MiB, used=3D406.37MiB
>
> ~ # truncate --size=3D2GB ~/tmp/space
> ~ # losetup --find --show ~/tmp/space
> /dev/loop1
>
> ~ # btrfs device add /dev/loop1 ~/mnt/
> Performing full device TRIM /dev/loop1 (1.86GiB) ...
> ERROR: error adding device '/dev/loop1': Read-only file system
>
> When I mount, in syslog appears:
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS info (device loop0): creating UUID tree
> BTRFS warning (device loop0): block group 144703488 has wrong amount of f=
ree space
> BTRFS warning (device loop0): failed to load free space cache for block g=
roup 144703488, rebuilding it now
> BTRFS warning (device loop0): failed to create the UUID tree: -28
> BTRFS: open_ctree failed
>
> So now I can mount readonly, but is there any way to repair this filesyst=
em?

Definitely get things off of it now while you can.

Fedora 31 has btrfs-progs 5.6 current. I suggest posting the output from

# btrfs check --readonly /dev/



--=20
Chris Murphy

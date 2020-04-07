Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA91A16B3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgDGUWT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 16:22:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51377 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgDGUWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Apr 2020 16:22:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id z7so3038254wmk.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Apr 2020 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJvPG5q3gbLA+O3YART3ws4m5W530NIoPorMVAAWQxQ=;
        b=lw7ova9D6zOQxha/mbKfZ6KoKt6dWunhETZH3iu0ZzjYx68OrAZZxbpmhO0sl+mGei
         q8qn1Lir4ErNVvEsK3MHxaA6MtcdfpU6/Qel3HHzQb9jmXzvgMtdKUzOpThfj02jTz2q
         S9kS+XfdUIt8GgpB+JXOO6q8bP/zfAtpX/I3mrc1fbgK9sd5MVjfnVONKXMTj4T0gIQg
         jhg/6rrZ+zGN/oA22ns6C8VtctE6NYCzOhfXiIfHXcEX0NS7sUPBR2PnzfnAJH0XPNwe
         EFwhzS0U+JllMJq5iql6XOiivf8FOV/LKr0RrbNBAZ+cHDFtcH1IJo3KAR8MFmXyadqB
         IuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJvPG5q3gbLA+O3YART3ws4m5W530NIoPorMVAAWQxQ=;
        b=qJdZ0LO/Wx1emmmuBpT9lXBgEXt6WFikkCXciP9dB5qak/j27ScjQchWt+D/NJeD2b
         uqgqZJ0fOQs3OiroRtj/qHh8Vf9KciVXAEg4IFHoYMidvZATV0BvvTXl8UvD1hInT9Sj
         64LM9OzDSOQBg6A7uv5D14RYr1IAP10bmNqgqqsxmYiNsFYTBjoLCTWTP5P3/nd5CNsD
         jc01SZrbyeKqY1atnTMPdmn4YEDQZAsQ0f+kxQiKl8Isl6Dypxq1sB/Gm7AdHFC52qA7
         ddET4KM3SQ3WTwtlEGGbHViNvcyO5uk+k5hqLfak8V4PYeFwSsF1/MJ//Zf3r9yZmZd/
         F5aw==
X-Gm-Message-State: AGi0PuY+m/dYzdwAg2PjKLwbMv1mpFS7357ZL7ioXzlxf89UGEcIsMv7
        7Rdr9tD0dgY19lfiX27oSKSgqjnulH1Ou26E3cBJ8w==
X-Google-Smtp-Source: APiQypLDeNbZTXI0PHFRy/tvHxq3j4l9WhfkNK4Eob1UFnxhXis2vvdPPJcKT5LqU6pVMAyJ8DmBgDv2gq4qjyi6BI4=
X-Received: by 2002:a1c:2d41:: with SMTP id t62mr1024189wmt.128.1586290936226;
 Tue, 07 Apr 2020 13:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com> <CAJCQCtRcTzL9LQZppvCj4zg2NpvGUri0QS58wY3E_PG+o0Jchg@mail.gmail.com>
In-Reply-To: <CAJCQCtRcTzL9LQZppvCj4zg2NpvGUri0QS58wY3E_PG+o0Jchg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Apr 2020 14:22:00 -0600
Message-ID: <CAJCQCtQ6C4kvBQaKMaoPBo8jbj-abNEYh_63-d-EkHVgWq6iPg@mail.gmail.com>
Subject: Re: btrfs freezing on writes
To:     Chris Murphy <lists@colorremedies.com>
Cc:     kjansen387 <kjansen387@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 7, 2020 at 2:11 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Tue, Apr 7, 2020 at 1:46 PM kjansen387 <kjansen387@gmail.com> wrote:
> >
> > Hello,
> >
> > I'm using btrfs on fedora 31 running 5.5.10-200.fc31.x86_64 .
> >
> > I've moved my workload from md raid5 to btrfs raid1.
> > # btrfs filesystem show
> > Label: none  uuid: 8ce9e167-57ea-4cf8-8678-3049ba028c12
> >          Total devices 5 FS bytes used 3.73TiB
> >          devid    1 size 3.64TiB used 2.53TiB path /dev/sde
> >          devid    2 size 3.64TiB used 2.53TiB path /dev/sdf
> >          devid    3 size 1.82TiB used 902.00GiB path /dev/sdb
> >          devid    4 size 1.82TiB used 902.03GiB path /dev/sdc
> >          devid    5 size 1.82TiB used 904.03GiB path /dev/sdd
> >
> > # btrfs fi df /export
> > Data, RAID1: total=3.85TiB, used=3.72TiB
> > System, RAID1: total=32.00MiB, used=608.00KiB
> > Metadata, RAID1: total=6.00GiB, used=5.16GiB
> > GlobalReserve, single: total=512.00MiB, used=0.00B
> >
> > After moving to btrfs, I'm seeing freezes of ~10 seconds very, very
> > often (multiple times per minute). Mariadb, vim, influxdb, etc.
> >
> > See attachment for a stacktrace of vim, and the dmesg output of 'echo w
> >  > /proc/sysrq-trigger' also including other hanging processes.
> >
> > What's going on.. ? Hope someone can help.
>
> How busy are the databases? What are the mount options for this volume?
>
> I think there is some kind of write contention possible if there's
> heavy fsync writes, since the tree log is per subvolume? (Maybe a
> developer can describe this correctly if I haven't.) A possible work
> around is putting each database in its own subvolume.

You could, of course, start with just the busiest database and see if
it makes any difference. By default on Fedora, only /home and / are on
separate subvolumes. The general idea would be to use a subvolume
instead of a directory, e.g.

##shutdown the database
mv /var/lib/mysql /var/lib/mysqlold
btrfs sub create /var/lib/mysql
restorecon -Rv /var/lib/mysql
cp -r --reflink /var/lib/mysqlold/* /var/lib/mysql/
##resume database operation, and clean up mysqlold whenever

Another thing that might help, depending on the workload, is
space_cache=v2. You can safely switch to v2 via:

mount -o remount,clear_cache,space_cache=v2 /

This is a one time command. It will set a feature flag for space cache
v2, and it'll be used automatically on subsequent mounts. It may be
busy for a minute or so while the cache is rebuilt.

You might test these separately so you have an idea of their relative
effects on the workload.


-- 
Chris Murphy

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBA1A1693
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgDGUL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 16:11:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40210 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDGUL5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Apr 2020 16:11:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so3176405wmf.5
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Apr 2020 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCSEmBnYJivs3S6Z9ByKmrSBHVpRP7Y9AwLfKrvUeu0=;
        b=luwYX2TreIKW79K10Itw7xmnAGkbzrARLL3MjHtHnrF6blI/p92tpbqnlf8zt3i554
         R2oVOLA0ojrpr35FXnHZGlZjTiWeHygw/aszYB6CX9gGTrgo34Pw+r4IIdDycTa1RERQ
         3ZIefRfg2TAqGMZWf8vTDyFbHt2j+IEFJhWx+HL/4qXHTYbiN9FWdREKXgDgorgwJGUK
         X6VRMu/ROc6u9m3KQ8qPADQ0B+yI5SeLMylwNu72najnifKNUklC8Mq4dITu+U3SASrc
         4MZTxNh4SqqoUFcxzy91SjiHsz4fFa8+y3dlL/KZTclhuV8JBTZ6e4brhVpyT067XKlY
         cBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCSEmBnYJivs3S6Z9ByKmrSBHVpRP7Y9AwLfKrvUeu0=;
        b=EKr9RhtOpYdJQrIiuMnn2VswOAMMpfQMWR1HgKVYjcQT0EC+1raCNDMeqhgMdOXX6I
         f7k8WeKxqKy/9O65Pg0XmpXJxgNGkKCiOTa3SFdHp555B01JUgzqsyD6cpgl8aZIbg+3
         tSEhqT2oBhoIxKNyWJ7tNDqN4+bBVmYmfUKj29gGsYrPJSO+QekB7M3p0+Bg2v4mOeWr
         umOI0mfjebpb6Srs5QH/T5FcjJInqopC5WKTz8J/uOigli7gnKUvKNAliRTN2fSx9uj2
         qdaqZzvm8aLm4QrVSnjgXBQl/dXr3pCACiaxdz2PODuGJPSA/Kpjk3WI4OxYZ9C7mtWE
         +PgA==
X-Gm-Message-State: AGi0PuYPEZCrSDyv/hI3s6rv7G9608GGKhCLhogoSCnaFxP14q7uXAok
        KZy8KGx6l0ystPvNxJGH2ChPSe7vDk6DoCCxyruHNj/o
X-Google-Smtp-Source: APiQypJqM2bEDgO9I/FABJcfK7VBmsLtphISrqfeUVe63irxEJiyEpmpp32rucV8kCnkpT95B1K6D5wtpVuruwvhQ88=
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr1014195wmc.11.1586290315438;
 Tue, 07 Apr 2020 13:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
In-Reply-To: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Apr 2020 14:11:39 -0600
Message-ID: <CAJCQCtRcTzL9LQZppvCj4zg2NpvGUri0QS58wY3E_PG+o0Jchg@mail.gmail.com>
Subject: Re: btrfs freezing on writes
To:     kjansen387 <kjansen387@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 7, 2020 at 1:46 PM kjansen387 <kjansen387@gmail.com> wrote:
>
> Hello,
>
> I'm using btrfs on fedora 31 running 5.5.10-200.fc31.x86_64 .
>
> I've moved my workload from md raid5 to btrfs raid1.
> # btrfs filesystem show
> Label: none  uuid: 8ce9e167-57ea-4cf8-8678-3049ba028c12
>          Total devices 5 FS bytes used 3.73TiB
>          devid    1 size 3.64TiB used 2.53TiB path /dev/sde
>          devid    2 size 3.64TiB used 2.53TiB path /dev/sdf
>          devid    3 size 1.82TiB used 902.00GiB path /dev/sdb
>          devid    4 size 1.82TiB used 902.03GiB path /dev/sdc
>          devid    5 size 1.82TiB used 904.03GiB path /dev/sdd
>
> # btrfs fi df /export
> Data, RAID1: total=3.85TiB, used=3.72TiB
> System, RAID1: total=32.00MiB, used=608.00KiB
> Metadata, RAID1: total=6.00GiB, used=5.16GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
> After moving to btrfs, I'm seeing freezes of ~10 seconds very, very
> often (multiple times per minute). Mariadb, vim, influxdb, etc.
>
> See attachment for a stacktrace of vim, and the dmesg output of 'echo w
>  > /proc/sysrq-trigger' also including other hanging processes.
>
> What's going on.. ? Hope someone can help.

How busy are the databases? What are the mount options for this volume?

I think there is some kind of write contention possible if there's
heavy fsync writes, since the tree log is per subvolume? (Maybe a
developer can describe this correctly if I haven't.) A possible work
around is putting each database in its own subvolume.


-- 
Chris Murphy

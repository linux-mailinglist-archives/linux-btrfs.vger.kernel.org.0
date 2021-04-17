Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627F9362D0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 05:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDQDEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 23:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQDEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 23:04:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623AFC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 20:03:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z13so30690092lfd.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hypertriangle-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=FTvgS8M4t6XkOUoS5DaTHk2OQ8VXB3eox+huVwMLyB0=;
        b=dYS+LoyizSCOSUKW3dae7pSbn3qgofBPHLBxyBKplkwIlbBydXBRBN1ZPdQAvb2q74
         MkZwYxi0CsRXrsAn250wwP819zuYzuZIn6126eraZu3yy+caXDqhcBC1WBNQrfKpUqKY
         d8wuRCPhw0E3YtNOU5os9jX79dMu065etWiBrK5QBCNzgjNL9vC2TtiUqZH4NKaCLS5f
         TA8p1Sea0Bc2sGct+deQ7jMBf9wBU4Lti3gPZrBA8iyizc8m7KcVVh4tFauVkfe0p/9J
         p94Ohyc2sMhocc1gAcYPaxJ0ZYdCEqamUQCD2ncVe9Jv7Qc7ylElh1KWTaRrzFa627Kv
         Lw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FTvgS8M4t6XkOUoS5DaTHk2OQ8VXB3eox+huVwMLyB0=;
        b=kvOyS2v1dsLu321xcrZWA8+fpL9J5fGprMb4kkFGhrBM+UxUGFp3Jt4gqdvCDIKgY/
         O2DOFq18s7gfFXNCdyJmJ65iI6N4JW8XY2PVz8uL8UbanBAcOV8TRJmAvlsWfHCKXzzu
         NiJk9lgtJgniVvRQJNwa9UgWeTjmoAPr5IkuHTjFNZD4e+g0obroAyliuLKu8WnsJL0B
         oNiHYPcbI3zLdGwPtGV98e2o0t8WuAPMwtZEoa4tIz5YqApFP0k6+JI+6l6H6sF6Loaz
         OsrmeI3R9L3Z/Isd/Yjvcbb9b7pYMl+E4Y/qKnK2lQl4QLxwP4cD7eAZY3blStKrHUKE
         hFEA==
X-Gm-Message-State: AOAM530ZTMsojoKogVxzvjTVItSEd5Wx3/nG9wJgR3POZ8P/fuWCwLA+
        6UWOkZDpXILcA7NjRSo/1IrkZw8F7RyBOH0fSK8ljfUWKIuLjn4q
X-Google-Smtp-Source: ABdhPJyASzamyKJm/1ScN2ZFt/XA8X4xXAEx8TQGP3ecHXqbPIQ4Vqx+/66AZJCEPLAigrwCTm3DKxpsubF5EH2LLPk=
X-Received: by 2002:a05:6512:38aa:: with SMTP id o10mr4984491lft.261.1618628615363;
 Fri, 16 Apr 2021 20:03:35 -0700 (PDT)
MIME-Version: 1.0
From:   Alexandru Stan <alex@hypertriangle.com>
Date:   Fri, 16 Apr 2021 20:02:58 -0700
Message-ID: <CAE9tQ0dr1+TTrALYUGfgx7tViU1tVU00OyAxkP1qsUUkyVsXPQ@mail.gmail.com>
Subject: Design strangeness of incremental btrfs send/recieve
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a system that btrfs sends daily its rootfs to another system
far away. Incrementally (this is important to saving bandwidth since
we're talking about half a TB).

For a while my first system's hardware was out of commission, so I
spun it up (systemd-nspawn) on the second system since I had all the
files there. Now it's time to get back my services on the first
system, so i want to merge my changes I made on the second system.
Turns out to do this incrementally is a bit of a problem.

From what I understand this might be impossible since the received
UUID will never match. I just wanted to send this out just in case I'm
missing anything, and perhaps express my frustration that maybe this
should work (what would it take to fix it?).

Here's a boiled down example of what i'm trying to do (assume ssdfs
and bigfs are my first and second systems respectively):

# create a subvolume (in ssdfs) and a few test files
    alex@alex-desktop:/mnt% sudo btrfs subvolume create ssdfs/myvolume-0
    Create subvolume 'ssdfs/myvolume-0'
    alex@alex-desktop:/mnt% sudo touch ssdfs/myvolume-0/file-0

# create a RO snapshot so we can send it somewhere else (bigfs)
    alex@alex-desktop:/mnt% sudo btrfs subvolume snapshot
ssdfs/myvolume-0 -r ssdfs/myvolume-1
    Create a readonly snapshot of 'ssdfs/myvolume-0' in 'ssdfs/myvolume-1'
    alex@alex-desktop:/mnt% sudo btrfs send ssdfs/myvolume-1|sudo
btrfs receive bigfs/
    At subvol ssdfs/myvolume-1

# make an rw snashot at the destination and start modifying it
    alex@alex-desktop:/mnt% sudo btrfs subvolume snapshot
bigfs/myvolume-1 bigfs/myvolume-2
    Create a snapshot of 'bigfs/myvolume-1' in 'bigfs/myvolume-2'
    alex@alex-desktop:/mnt% ls bigfs/myvolume-2/
    file-0
    alex@alex-desktop:/mnt% sudo touch bigfs/myvolume-2/file-1

# create an RO snapshot in preparation to send it back to ssdfs
    alex@alex-desktop:/mnt% sudo btrfs subvolume snapshot
bigfs/myvolume-2 -r bigfs/myvolume-3
    Create a readonly snapshot of 'bigfs/myvolume-2' in 'bigfs/myvolume-3'

# sending back incrementally (eg: without sending back file-0) fails
    alex@alex-desktop:/mnt% sudo btrfs send bigfs/myvolume-1 -p
bigfs/myvolume-3|sudo btrfs receive ssdfs/
    At subvol bigfs/myvolume-1
    At snapshot myvolume-1
    ERROR: cannot find parent subvolume
#### Cry

# some debug info
    alex@alex-desktop:/mnt% ls *fs/myvolume*
    ssdfs/myvolume-0:
    file-0

    ssdfs/myvolume-1: # ro
    file-0

    bigfs/myvolume-1: # ro
    file-0

    bigfs/myvolume-2:
    file-0  file-1

    bigfs/myvolume-3: # ro
    file-0  file-1

    alex@alex-desktop:/mnt% sudo btrfs subvolume show ssdfs/myvolume-1
    myvolume-1
        Name:                   myvolume-1
        UUID:                   1fcff3a8-c53f-1543-9b61-8108e486eecc
        Parent UUID:            1b0a6fac-4139-1840-b654-f21833b6cd12
        Received UUID:          -
        Creation time:          2021-04-16 19:32:46 -0700
        Subvolume ID:           1650
        Generation:             2198818
        Gen at creation:        2198818
        Parent ID:              5
        Top level ID:           5
        Flags:                  readonly
        Snapshot(s):

    alex@alex-desktop:/mnt% sudo btrfs subvolume show bigfs/myvolume-1
    myvolume-1
        Name:                   myvolume-1
        UUID:                   25301f81-10d5-e34e-8283-51656137ffc8
        Parent UUID:            -
        Received UUID:          1fcff3a8-c53f-1543-9b61-8108e486eecc
        Creation time:          2021-04-16 19:33:22 -0700
        Subvolume ID:           6344
        Generation:             63939
        Gen at creation:        63935
        Parent ID:              5
        Top level ID:           5
        Flags:                  readonly
        Snapshot(s):
                                myvolume-2

    alex@alex-desktop:/mnt% sudo btrfs subvolume show bigfs/myvolume-2
    myvolume-2
        Name:                   myvolume-2
        UUID:                   a437c7cf-5f14-9d4d-adb6-3c35ed9d0546
        Parent UUID:            25301f81-10d5-e34e-8283-51656137ffc8
        Received UUID:          -
        Creation time:          2021-04-16 19:34:13 -0700
        Subvolume ID:           6345
        Generation:             63945
        Gen at creation:        63939
        Parent ID:              5
        Top level ID:           5
        Flags:                  -
        Snapshot(s):
                                myvolume-3

Alexandru Stan

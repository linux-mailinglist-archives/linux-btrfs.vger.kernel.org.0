Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC834BC51
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 14:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhC1M2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhC1M2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 08:28:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2955FC061762
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 05:28:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x13so10072162wrs.9
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tD+wWasoNB0pBdZkY2C0CdJuUz3ulavXVKxkI7fWD1U=;
        b=spTuwxkk7NVKTNTdTEeuvKy/PJazyTR8hfJtxkETa3lO5XgnpxGb07cSgbFqmHI8Vf
         Lj07PYIFVX3KyEf48UngrJHe8pIpg89jz92rXRyXSKDFhSULScsUZwbu3BwD2aKc4TMl
         zqFTye3dOMz0f4u2GXWsSzU6DC2Nxa4OPmeHBjki5Z416irPhzm96/ZJsOMjetP7Dh3s
         d9XP67T4Jlu656gnBfQTnx1Hhn+6wEzR7zkSG7QTfJr6scsp9mNi7eMjkeONdGRLQaSv
         sqW4CwpQWmLO6qL0y3VQUmoFGlgp24lJWplQoo+QC7GkOKBN/dvSCASMWKIZWEBfnWcI
         92og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tD+wWasoNB0pBdZkY2C0CdJuUz3ulavXVKxkI7fWD1U=;
        b=CYoUX15JKuGpZv5LOaGZd+Ut/Ieu5jXBClbq/LilCRmzAhp9gjV4Wm45NgkNqDNBg2
         dVJRliV+y0B/VUPJBGZrGq3Gt0W3oT4XVw+5jtZKDz4GIU3+TGeh9zEOFfMKbbSi4a1Y
         8ZLMeItTsAKIjmM4PVhHPaJEDai2kRBlu1AO8Ef4KP7q4MkXWpdwC87EE4tVQqTiIuJp
         g3Idr/D/31/aT1M2fRoD8U1SJEg3pwdwvbRWRLUdTae9kf0OGOuALRmlqQfgru5FigfS
         rB9DTrGA5RIPfDD1dchB3I4Ca03AKO1ds2FnfrAc9Dw5Zs3/m1MgtlldMj5lVLRwEVam
         7HRA==
X-Gm-Message-State: AOAM530zKWAoK0fEUBm+iJmksi5u3PFJWUldVlty4ohFlOncRh+vF6CM
        0CyYxoOcLOsw8ovRxjEWpsWz0gc61iAfVUoZXJJeJ+4t8Phu6g==
X-Google-Smtp-Source: ABdhPJzXQigjMBRd4Fq4bn5YRzMHUt9nE7NGUbPJ1LiJrk4tFETW4kzdzUBIuhJ3dud4GtFw3JLfmEgto2vUpXvlPJQ=
X-Received: by 2002:a05:6000:221:: with SMTP id l1mr23660294wrz.370.1616934521650;
 Sun, 28 Mar 2021 05:28:41 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Zolt=C3=A1n?= <zoltan1980@gmail.com>
Date:   Sun, 28 Mar 2021 14:28:05 +0200
Message-ID: <CAGtRCvfHfjFFZZQCEHR+ff-JfNCCOMq=B0PxaCc-_+a6XKEg+A@mail.gmail.com>
Subject: Disk usage difference in the output of `btrfs fi show` vs. `btrfs fi du`
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have read a lot of caveats about interpreting the free space
reported for btrfs volumes, but could not find anything about the
perceived inconsistency in the disk usage reporting described below.

I have a btrfs volume with about 135GiB used for data, as reported by
`df`, `btrfs fi show` and `btrfs fi usage` alike:

# btrfs filesystem show /volumes/main/
Label: 'main'  uuid: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        Total devices 1 FS bytes used 134.12GiB
        devid    1 size 193.43GiB used 165.01GiB path /dev/sda2

However, `btrfs fi du` reports ~17GiB exclusive usage and ~80GiB
shared usage, which adds up to only 97GiB (compared to the 135GiB I
would expect):

# btrfs filesystem du -s /volumes/main/
     Total   Exclusive  Set shared  Filename
   1.73TiB    17.20GiB    80.13GiB  /volumes/main/

(The reported total usage exceeding the disk capacity by an order of
magnitude is expected as the volume contains many snapshots.)

The mount point corresponds to the root subvolume, thus all subvolumes
should be accounted for by `btrfs fi du` (according to its
documentation):

# mount | grep /volumes/main
/dev/sda2 on /volumes/main type btrfs
(rw,noatime,ssd,space_cache,autodefrag,subvolid=5,subvol=/)

Do I misunderstand the meaning of exclusive and shared usage or is
there some other issue causing this behaviour? I would expect the disk
usage reported by `df`, `btrfs fi show` and `btrfs fi usage` to be the
sum of the exclusive and shared usage reported by `btrfs fi du`.

The output of `btrfs fi usage`, for completeness's sake:

# btrfs filesystem usage /volumes/main/
Overall:
    Device size:                 193.43GiB
    Device allocated:            165.01GiB
    Device unallocated:           28.41GiB
    Device missing:                  0.00B
    Used:                        134.12GiB
    Free (estimated):             57.00GiB      (min: 57.00GiB)
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              194.72MiB      (used: 0.00B)

Data,single: Size:162.00GiB, Used:133.41GiB (82.35%)
   /dev/sda2                     162.00GiB

Metadata,single: Size:3.01GiB, Used:720.88MiB (23.41%)
   /dev/sda2                       3.01GiB

System,single: Size:4.00MiB, Used:48.00KiB (1.17%)
   /dev/sda2                       4.00MiB

Unallocated:
   /dev/sda2                      28.41GiB

Thanks,

Zoltan

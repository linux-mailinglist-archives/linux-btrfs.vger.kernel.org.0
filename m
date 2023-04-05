Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C336D76BF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjDEIWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 04:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbjDEIWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 04:22:48 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91091BEA
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 01:22:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h187so13797791iof.7
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680682967; x=1683274967;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hrj2looXj5ckx2Gu353v2cAsNwFPsE1cz+X3lj3Cec=;
        b=M5uiodiTJqeNVPh4wlb1M0bS7uxwmQf/MSVPuzBX14seqcn+oQJ1DH806hL1qwsw8g
         TvXJ3shkG8yRnRRJlxJj/YmHSrUQCnBdu6RxX55o0hAjub564ovA5q5NLAHLaFrxMuCQ
         rIrcTdUu9iWnC6/kulfEVXOoQcoph4P0GQFy1QLrobnt9rtPMXCBQed97E4LI0nyu1mr
         rviCmBCsXAB/dZnfiMzPR7zzeLvk2GFF9N+in2WGaAP3Rejbqt0z3Uwf0TQY0j607x7E
         Y2WdyuWJS8e/yweBvArJcZCoELXP5NmAIqRg//3HyDLIWKYT5ET5Wq0ugb3WKsShYMm4
         2AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682967; x=1683274967;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hrj2looXj5ckx2Gu353v2cAsNwFPsE1cz+X3lj3Cec=;
        b=Zqs3Kbmu99gcGotQk3eI7ZOU6EI4o1b6SO02qN2vg6gnAa05cAddN4/3zEXhzEnURy
         2ZVE5g+YywkcP0is8r30lavEG+5pGgOlBuDHzMAw9UaZHLwR/oG0GopEsG2wvA3nE1H3
         OHfxsdTn+qC7Z7fB0pDareLIVvZaNounA65/q8vPzlASTY7ABvtsxVLqkciE0jgo1FlU
         Qlaf377MVJG2v7uByD0FuyiWE6cnK5RoyciNtx4C/wk4T3L6cs3veiA6aSkO3A1Fnw7h
         5aYXJQE58nRuogLtr6r73TK+m0ernb9zufeY+18qhWCtApSFhaEWb2xDO+2BP4M/SQmM
         JDgA==
X-Gm-Message-State: AAQBX9cpPKdzYnji6VQBcFRAn3gz4JYeFA4rZL8DB89iE2ncbEvuOPHw
        e2ihwOAsuyD5N6MgtkF3Rnsto4noVBDzUd5SjN10M4HWAAY=
X-Google-Smtp-Source: AKy350bYF5E1Z8frAxytWD4S+IAxKAseMw/1hhtXqdWMeVnGIaiGDRwwdvbt0l9VP8X4cDWBecdqE1bg57sBeAmwbyk=
X-Received: by 2002:a02:84a2:0:b0:406:6686:2e0c with SMTP id
 f31-20020a0284a2000000b0040666862e0cmr1155072jai.3.1680682966931; Wed, 05 Apr
 2023 01:22:46 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?VHXhuqVuIEFuaCBQaOG6oW0=?= <anhpt.fm@gmail.com>
Date:   Wed, 5 Apr 2023 15:22:36 +0700
Message-ID: <CAGNht4BjaO0Rkci3UO9YRGZO9Lin1VFHj-9d=qydMGUNykxSTg@mail.gmail.com>
Subject: Request to remove constraint on mount rw,degraded when missing data chunks
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
my system infos:

# uname -a
Linux logstore1v 5.10.0-0.deb10.16-amd64 #1 SMP Debian
5.10.127-2~bpo10+1 (2022-07-28) x86_64 GNU/Linux
# btrfs --version
btrfs-progs v5.10.1
# btrfs fi show
    Total devices 16 FS bytes used 21.91TiB
        devid    1 size 1.82TiB used 1.39TiB path /dev/sdn
        devid    2 size 1.82TiB used 1.39TiB path /dev/sdo
        devid    4 size 1.82TiB used 1.39TiB path /dev/sdq
        devid    5 size 1.82TiB used 1.39TiB path /dev/sds
        devid    6 size 1.82TiB used 1.39TiB path /dev/sdt
        devid    7 size 1.82TiB used 1.39TiB path /dev/sdu
        devid    8 size 1.82TiB used 1.39TiB path /dev/sdv
        devid    9 size 1.82TiB used 1.39TiB path /dev/sdw
        devid   10 size 1.82TiB used 1.39TiB path /dev/sdx
        devid   11 size 1.82TiB used 1.39TiB path /dev/sdy
        devid   12 size 1.82TiB used 1.39TiB path /dev/sdz
        devid   13 size 1.82TiB used 1.39TiB path /dev/sdaa
        devid   14 size 1.82TiB used 1.39TiB path /dev/sdab
        devid   15 size 1.82TiB used 1.39TiB path /dev/sdm
        devid   16 size 3.64TiB used 3.21TiB path /dev/sdaf
        *** Some devices missing
# btrfs fi usage -T /mnt/gfsbr/
Overall:
    Device size:                  30.93TiB
    Device allocated:             22.66TiB
    Device unallocated:            8.27TiB
    Device missing:                1.82TiB
    Used:                         22.07TiB
    Free (estimated):              8.85TiB      (min: 2.65TiB)
    Free (statfs, df):             7.04TiB
    Data ratio:                       1.00
    Metadata ratio:                   4.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

             Data     Metadata System
Id Path      single   RAID1C4  RAID1C4  Unallocated
-- --------- -------- -------- -------- -----------
 1 /dev/sdn   1.38TiB 14.00GiB        -   441.02GiB
 2 /dev/sdo   1.39TiB        -        -   441.02GiB
 3 /dev/sdp  10.00GiB        -        -   -10.00GiB
 4 /dev/sdq   1.38TiB 14.00GiB        -   441.02GiB
 5 /dev/sds   1.38TiB  9.00GiB        -   441.02GiB
 6 /dev/sdt   1.36TiB 34.00GiB 32.00MiB   440.99GiB
 7 /dev/sdu   1.37TiB 17.00GiB        -   441.02GiB
 8 /dev/sdv   1.38TiB 10.00GiB        -   440.02GiB
 9 /dev/sdw   1.38TiB 10.00GiB        -   441.02GiB
10 /dev/sdx   1.38TiB  9.00GiB        -   441.02GiB
11 /dev/sdy   1.36TiB 29.00GiB 32.00MiB   440.99GiB
12 /dev/sdz   1.38TiB  5.00GiB        -   441.02GiB
13 /dev/sdaa  1.37TiB 15.00GiB 32.00MiB   440.99GiB
14 /dev/sdab  1.39TiB        -        -   441.02GiB
15 /dev/sdm   1.38TiB  7.00GiB        -   440.02GiB
16 /dev/sdaf  3.15TiB 55.00GiB 32.00MiB   440.99GiB
-- --------- -------- -------- -------- -----------
   Total     22.44TiB 57.00GiB 32.00MiB     6.45TiB
   Used      21.85TiB 56.28GiB  3.03MiB

Related dmesg when I tried to mount the FS rw:
[2171517.125811] BTRFS warning (device sdn): chunk 4543283200 missing
1 devices, max tolerance is 0 for writable mount
[2171517.127148] BTRFS warning (device sdn): writable mount is not
allowed due to too many missing devices
[2171517.213606] BTRFS error (device sdn): open_ctree failed
[2171559.696984] BTRFS info (device sdn): flagging fs with big metadata feature
[2171559.696988] BTRFS info (device sdn): allowing degraded mounts
[2171559.696990] BTRFS info (device sdn): using free space tree
[2171559.696991] BTRFS info (device sdn): has skinny extents

----
I built my glusterfs cluster on top of btrfs. As gluster provides
redundancy, I use data single and metadata raid1c4 profile. I thought
that even if 1 or 2 disks missing, it won't affect my cluster as gfs
will correct it. However, I did not know about the constraint of
chunks put on both data and metadata. Therefore, missing 1 disk means
that I could not mount the FS as rw, and my gluster could not repair
it.
I agree that a constraint should be put on metadata profile, but in
some cases, like mine - when the application could handle missing data
blocks, putting the constraint on it restrains the application's
self-healing feature. Like my gluster brick, missing only 10GB of data
puts my cluster resync 21TB is quite overkilled.
I think that a mount option of degraded,rw in case of missing data
chunks is reasonable, a warning message when trying to do that is
still needed, though.
---
P/S: I also had trouble when trying to remove a bad disk from pool:
ERROR: error removing device '/dev/sdv': Input/output error
An option like btrfs device replace -r to ignore read errors would be
nice, though.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF345E2CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 22:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbhKYWCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 17:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhKYWAa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 17:00:30 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FCFC06173E
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Nov 2021 13:56:37 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id k21so9155728ioh.4
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Nov 2021 13:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WTTljflqCCKGI0sUpXRHNGZawg2nOpEa0L7IANnepKQ=;
        b=YkBxVIQw2gzMbk4YUmbuHqYf74m1usjbj864uUrEshxgOItyIv753Kg0B5WnD2Ht8D
         oFw1JVWiIHhBTjeXGPgE29Dg7m1z0CBe+bCYmFXOGyYqc5BTd9xQOSO8v43L4OKr1vrF
         8AYxTC8w5/epDp+FZD1qs+59XD1NOziNk8IsKYMVl0W30DF1Z61iu9CdLroztTH8FUi0
         C9AP/T42ybXv/njZSHFH9yAcyTROAN7BbW8nACZy5YyUYepzknOtN4VRyc7kdyjcTv7D
         Gqjt7/Bqg1vjlFoWLKYkzWzFXCqaTOou9PvTEwJYFd38wJvuCPtcAfNLfCMP6lltyZKo
         snXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WTTljflqCCKGI0sUpXRHNGZawg2nOpEa0L7IANnepKQ=;
        b=AbzEEkgyu3e6J6qbgbCUPoF5+qJ3TFr7+e78klNUdaO/Z+xtaffFELp+HqUwIBeCYc
         aGK1xXsvZEkEqPSdrvqSdHSIT/u2VdjAec+cLPcuvVJFx8DdtVVjCIKtS2Rw5FlpgUot
         zAQsWgf7yu0Ru1a6Pwykl2oOex5nyZSKnHq6KWp+Kvwxy0oL5FtZDMdhqMaFe18iVYkB
         SKwZRmhGYtwPUIyJBad+jWF/01vUfvmU1dHwKWmeL8aaoDf/KAeOGCQGYW+OAPLj7yv6
         n4N9WrHUFPfqQDb66+OA+22qWH9A0bHKMbV2trhbS9cKv8xCw92P7Myv5Jm7Atmbatpi
         HFzQ==
X-Gm-Message-State: AOAM533PjdVccz3+3gURLlK2ffFSMHQ5+5mHWtuLsvGSupbh23klJS/2
        vvJV6lMtYWR9pw3WMQTbY0LF3hfFXWa9oc7pMcc6wZ+F
X-Google-Smtp-Source: ABdhPJwNsv933SwvJgR3RJISkuSPS++joI7bnz/SYmQOpPHimeRjGi3lo6XvWdbCwZ2zMW0HQFbtkzAfZLyPiMBdSWg=
X-Received: by 2002:a6b:d904:: with SMTP id r4mr28502251ioc.52.1637877396700;
 Thu, 25 Nov 2021 13:56:36 -0800 (PST)
MIME-Version: 1.0
From:   Andrey Melnikov <temnota.am@gmail.com>
Date:   Fri, 26 Nov 2021 00:56:25 +0300
Message-ID: <CA+PODjrE4V9hL1bXEEghU6NAFgPgfUu4f75FCQn+0vKUaeu1zg@mail.gmail.com>
Subject: btrfs with huge numbers of hardlinks is extremely slow
To:     linux-btrfs@vger.kernel.org, Andrey Melnikov <temnota.am@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Every night a new backup is stored on this fs with 'rsync
--link-dest=$yestoday/ $today/' - 1402700 hardlinks and 23000
directories are created, 50-100 normal files transferred.
Now, FS contains 351 copies of backup data with 486086495 hardlinks
and ANY operations on this FS take significant time. For example -
simple count hardlinks with
"time find . -type f -links +1 | wc -l" take:
real    28567m33.611s
user    31m33.395s
sys     506m28.576s

19 days 20 hours 10 mins with constant reads from storage 2-4Mb/s.

- BTRFS not suitable for this workload?
- using reflinks helps speedup FS operations?
- readed metadata not cached at all? What BTRFS read 19 days from disks???

Hardware: dell r300 with 2 WD Purple 1Tb disk on LSISAS1068E RAID 1
(without cache).
Linux nlxc 5.14-51412-generic #0~lch11 SMP Wed Oct 13 15:57:07 UTC
2021 x86_64 GNU/Linux
btrfs-progs v5.14.1

# btrfs fi show
Label: none  uuid: a840a2ca-bf05-4074-8895-60d993cb5bdd
        Total devices 1 FS bytes used 474.26GiB
        devid    1 size 931.00GiB used 502.23GiB path /dev/sdb1

# btrfs fi df /srv
Data, single: total=367.19GiB, used=343.92GiB
System, single: total=32.00MiB, used=128.00KiB
Metadata, single: total=135.00GiB, used=130.34GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# btrfs fi us /srv
Overall:
    Device size:                 931.00GiB
    Device allocated:            502.23GiB
    Device unallocated:          428.77GiB
    Device missing:                  0.00B
    Used:                        474.26GiB
    Free (estimated):            452.04GiB      (min: 452.04GiB)
    Free (statfs, df):           452.04GiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:367.19GiB, Used:343.92GiB (93.66%)
   /dev/sdb1     367.19GiB

Metadata,single: Size:135.00GiB, Used:130.34GiB (96.55%)
   /dev/sdb1     135.00GiB

System,single: Size:32.00MiB, Used:128.00KiB (0.39%)
   /dev/sdb1      32.00MiB

Unallocated:
   /dev/sdb1     428.77GiB

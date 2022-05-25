Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E25346E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 01:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbiEYXF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 19:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiEYXF0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 19:05:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412BA55367
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653519921;
        bh=S8kHC6VD33+jUUx+ww4WvCkVTwDV2m+R34zUgU4cSaU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jfQ6cQXmzIpDsDv2B9IlZHcimmYDGyau3dvxwK6NfewSHgnYSKx1E9uJ4MZlNTBvF
         RedbkBjVJTKQ46WdnAMnJTeB36wSVUe43sWQDtZnO1ikoL4tDBUdVcsKy/9I9ozCpP
         WL4RaSiWAwwQ2SDZ83WKfEvcijsX4yFjVL7K2HWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRMi-1oH8aC14pA-00TiyH; Thu, 26
 May 2022 01:05:20 +0200
Message-ID: <da228a64-9015-fef2-e8eb-439d53fd5524@gmx.com>
Date:   Thu, 26 May 2022 07:05:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Quota consistently brings machine to a crawl
Content-Language: en-US
To:     Nathan Henrie <n8henrie@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAOMt5FCSFC8d-cioM39wZ3jME9+5=C4P8omZOfmQz34P9a8MdA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAOMt5FCSFC8d-cioM39wZ3jME9+5=C4P8omZOfmQz34P9a8MdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QELzfYEVKUVA6HVCkhHpwKR9bwdR6UlhWqa6Yb7I5wObISdldZl
 sGTo2c/dP78c72UyBWldashiLuygbhTdwqYTX5gif6KiksdbA56jP0QCSFCqs6QeIjtw+6Z
 ur047C+GBqk+UF8LU3FWGFx+w9npsLrfcDPVA3BXNAhuTgsKjNtiqGSlNWhlykgR5FtYHeO
 OJQ6oXAVy8KWhQfsWh92A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K1O7dlDuSCQ=:btNvjtgDVHA2YgIdn8UOlC
 JGzEseIMoGfPElSd6AX81q/XyQDTXYSmc/mrXAMnVDRoo9KqSpADpkh1PXWdzuuChF1Y23n8b
 PPtiT0boq/DXDKknsLk4rmftfttksR1DgwQZJD4aCMHi9k50S6SlImFvgAIn7qGFaforFh6d9
 6q+leP9nw4nGiiS1vuFbsZnf5h0vtAlHOrBGvJwsFxcvLNK1R1Dqh8n2YVvxaBow6PoBtaKRo
 tM3V4vEkT+ahvp7JSnAYJMD6ZUFpliafp8qFn4j2lAkFKQCu5mfstOjxiwGDa7bRX5mUSFntI
 8uvzOcEllTgnCiaETDbjP/1l1Q711NVFMkEJv8fZYYSwXylucovCjjDS1fgkZKX5CXjSw+V2w
 vsse0lexVgFPjN9xm+PN/Aiy1tfYvGs20ISch6v5F9vs3CWypvIs5/6aCQMt4VjQNUQqZGwRt
 Y748gRxQ3SYYzSFxJKIlt6EJcSfX8WPuNSvalyn9xKcDYFr2UkgxBoSJzUWMXtSMZs7HuLqkF
 vSiF8Gof4gJoyCyDRPMT9izo0VOrt4QF3NPy0QtmX8IBLnADYZYWphKPT9jrAOhvSVxQgzBd1
 WPuIUP/4Sz116yfgZUWDBMcVxtcEXMLv4Bc+v7+ltsDqtNSrQZtmkaViipdkKM6Sfhv79Nbkh
 bsr7fxEz2K0ObmpWeptPyzmao9nk7Tinb5Lx1tdIq12Z+P54mFVgNBjqPZK0afXg8g9ki4VQX
 /ugSCEueDGGqV3WhVcvcxiYdTMJwmZrbea9HMJJt7P0RHtQQGQUgPy7XNmfbjDnaOAr758ipq
 If0Ck6X9ZsecMmaeS+nWpcig3d2MFb8cEdt0eYZhxfZ036QWfvDTqbqd5QUfefMkO1y/ohBB3
 VI0tvJjr9tMKnYbyZOnpQGq6yeFGa0Pl9Dhl65X63zSN0cC/haQsm8Adc8jYs+VFP052xUbzh
 H+vUVJbIgCAZYaLti1ivRkbBZ/TXKFz9LfDh/v2e+cIqKf800C/id8VJAzjF7jcArNlIj+RGZ
 MOqhxHkB0ztDYRp1XsPd/QrRWVIPX4Cj1fXTJjU4AU3GiupdsENfjTASZu0tI15/YpiES14fO
 SyI/BEEhXtmqBeaVs1cGb5fFyScH2bcSx1gpyiyHy7A30gj5ilByGTrnQ==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 04:14, Nathan Henrie wrote:
> Hello,
>
> I've been using BTRFS root (BTRFS RAID1) on a reasonably powerful
> Linux machine for a couple of years now, and I've generally been very
> happy with it. The only persistent issue that I can't seem to resolve
> is that the entire system consistently slows to a complete crawl
> (several minutes to register keystrokes) if I enable quota.
>
> I use snapper for automated snapshots, and thinking that the number of
> snapshots may be the issue, I've increased the cleanup frequency to
> hourly and reduced the total number to <100 at all times.

Currently, the quota should only has a problem related to subvolume
dropping.

So would you mind to test this patch?
https://patchwork.kernel.org/project/linux-btrfs/cover/20211207011655.2157=
9-1-wqu@suse.com/

This patchset allow btrfs to just the expensive qgroup accounting for
snapshot drop.

After applying the patchset, you still need to set the value to
something like 2 or 3 in
/sys/fs/btrfs/<uuid>/qgroups/drop_subtree_threshold

Although this means, each time btrfs see a large subvolume needs to be
dropped, it will mark qgroup inconsistent, and need a rescan.

Thanks,
Qu
>
> ```
> $ sudo btrfs subvol list -s / | wc -l
> 89
> ```
>
> However, the issue persists. A little conversation on number of
> snapshots: https://www.reddit.com/r/btrfs/comments/tiqkh2/how_many_snaps=
hots_are_too_many_with_quotas/
>
> My mount options are:
> `noatime,discard=3Dasync,autodefrag,compress-force=3Dzstd:1,subvol=3D@`
>
> My machine is a Ryzen threadripper with 128G RAM, across 3 NVME drives
> as BTRFS RAID1.
>
> ```
> $ uname -a
> Linux n8machine 5.17.7-arch1-2 #1 SMP PREEMPT Sun, 15 May 2022
> 05:00:14 +0000 x86_64 GNU/Linux
> $ btrfs --version
> btrfs-progs v5.17
> $ sudo btrfs fi show
> Label: 'Arch Linux' uuid: 0507d652-8d7a-4897-a843-2fb170634055
>             Total devices 3 FS bytes used 612.94GiB
>             devid 1 size 931.01GiB used 582.00GiB path /dev/nvme0n1p1
>             devid 3 size 418.00GiB used 69.03GiB path /dev/nvme2n1p1
>             devid 4 size 931.51GiB used 583.03GiB path /dev/nvme1n1
> $ sudo btrfs fi df /
> Data, RAID1: total=3D573.00GiB, used=3D570.19GiB
> System, RAID1: total=3D32.00MiB, used=3D128.00KiB
> Metadata, RAID1: total=3D44.00GiB, used=3D42.75GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> $ sudo dmesg | grep -i btrfs
> [649854.872742] audit: type=3D1130 audit(1653481410.602:7814): pid=3D1
> uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
> terminal=3D? res=3Dsuccess' [649854.872749] audit: type=3D1131
> audit(1653481410.602:7815): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [652048.645431] audit:
> type=3D1130 audit(1653483604.377:7830): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [652048.645438] audit: type=3D1131
> audit(1653483604.377:7831): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [653331.753733] BTRFS:
> device label NIXOS_SD devid 1 transid 7 /dev/loop1p3 scanned by mount
> (3237081) [653331.760159] BTRFS info (device loop1p3): flagging fs
> with big metadata feature [653331.760166] BTRFS info (device loop1p3):
> enabling ssd optimizations [653331.760168] BTRFS info (device
> loop1p3): using spread ssd allocation scheme [653331.760172] BTRFS
> info (device loop1p3): enabling free space tree [653331.760174] BTRFS
> info (device loop1p3): using free space tree [653331.760175] BTRFS
> info (device loop1p3): has skinny extents [653331.768221] BTRFS info
> (device loop1p3): creating free space tree [653331.771396] BTRFS info
> (device loop1p3): setting compat-ro feature flag for FREE_SPACE_TREE
> (0x1) [653331.771400] BTRFS info (device loop1p3): setting compat-ro
> feature flag for FREE_SPACE_TREE_VALID (0x2) [653331.902916] BTRFS
> info (device loop1p3): cleaning free space cache v1 [653331.980709]
> BTRFS info (device loop1p3): checking UUID tree [653332.061223] BTRFS
> info (device loop1p3): resize device /dev/loop1p3 (devid 1) from
> 3352297472 to 4426039296 [653343.373112] BTRFS warning: duplicate
> device /dev/sde3 devid 1 generation 154 scanned by systemd-udevd
> (3237098) [653344.276810] BTRFS info (device loop1p3): flagging fs
> with big metadata feature [653344.276817] BTRFS info (device loop1p3):
> enabling ssd optimizations [653344.276819] BTRFS info (device
> loop1p3): using spread ssd allocation scheme [653344.276822] BTRFS
> info (device loop1p3): using free space tree [653344.276823] BTRFS
> info (device loop1p3): has skinny extents [653455.859628] audit:
> type=3D1130 audit(1653485011.610:7859): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [653455.859640] audit: type=3D1131
> audit(1653485011.610:7860): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [655648.680024] audit:
> type=3D1130 audit(1653487204.432:7877): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [655648.680032] audit: type=3D1131
> audit(1653487204.432:7878): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [655661.645800] BTRFS:
> device label NIXOS_SD devid 1 transid 7 /dev/loop1p3 scanned by mount
> (3296995) [655661.652011] BTRFS info (device loop1p3): flagging fs
> with big metadata feature [655661.652017] BTRFS info (device loop1p3):
> enabling ssd optimizations [655661.652020] BTRFS info (device
> loop1p3): using spread ssd allocation scheme [655661.652023] BTRFS
> info (device loop1p3): enabling free space tree [655661.652026] BTRFS
> info (device loop1p3): using free space tree [655661.652027] BTRFS
> info (device loop1p3): has skinny extents [655661.659897] BTRFS info
> (device loop1p3): creating free space tree [655661.662665] BTRFS info
> (device loop1p3): setting compat-ro feature flag for FREE_SPACE_TREE
> (0x1) [655661.662670] BTRFS info (device loop1p3): setting compat-ro
> feature flag for FREE_SPACE_TREE_VALID (0x2) [655661.977751] BTRFS
> info (device loop1p3): cleaning free space cache v1 [655662.148361]
> BTRFS info (device loop1p3): checking UUID tree [655662.321729] BTRFS
> info (device loop1p3): resize device /dev/loop1p3 (devid 1) from
> 3352297472 to 4426039296 [655675.379516] BTRFS info (device loop1p3):
> flagging fs with big metadata feature [655675.379524] BTRFS info
> (device loop1p3): enabling ssd optimizations [655675.379526] BTRFS
> info (device loop1p3): using spread ssd allocation scheme
> [655675.379530] BTRFS info (device loop1p3): using free space tree
> [655675.379532] BTRFS info (device loop1p3): has skinny extents
> [655798.563024] BTRFS: device label NIXOS_SD devid 1 transid 7
> /dev/loop1p3 scanned by mount (3300821) [655798.569517] BTRFS info
> (device loop1p3): flagging fs with big metadata feature
> [655798.569525] BTRFS info (device loop1p3): enabling ssd
> optimizations [655798.569527] BTRFS info (device loop1p3): using
> spread ssd allocation scheme [655798.569532] BTRFS info (device
> loop1p3): enabling free space tree [655798.569534] BTRFS info (device
> loop1p3): using free space tree [655798.569536] BTRFS info (device
> loop1p3): has skinny extents [655798.578555] BTRFS info (device
> loop1p3): creating free space tree [655798.581715] BTRFS info (device
> loop1p3): setting compat-ro feature flag for FREE_SPACE_TREE (0x1)
> [655798.581719] BTRFS info (device loop1p3): setting compat-ro feature
> flag for FREE_SPACE_TREE_VALID (0x2) [655798.737827] BTRFS info
> (device loop1p3): cleaning free space cache v1 [655798.764508] BTRFS
> info (device loop1p3): checking UUID tree [655798.794795] BTRFS info
> (device loop1p3): resize device /dev/loop1p3 (devid 1) from 3352297472
> to 4426039296 [655809.880095] BTRFS info (device loop1p3): flagging fs
> with big metadata feature [655809.880104] BTRFS info (device loop1p3):
> enabling ssd optimizations [655809.880106] BTRFS info (device
> loop1p3): using spread ssd allocation scheme [655809.880110] BTRFS
> info (device loop1p3): using free space tree [655809.880111] BTRFS
> info (device loop1p3): has skinny extents [657063.131573] audit:
> type=3D1130 audit(1653488618.896:7945): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [657063.131583] audit: type=3D1131
> audit(1653488618.899:7946): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [659255.485198] audit:
> type=3D1130 audit(1653490811.280:7961): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [659255.485205] audit: type=3D1131
> audit(1653490811.280:7962): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [660665.821187] audit:
> type=3D1130 audit(1653492221.609:7980): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [660665.821200] audit: type=3D1131
> audit(1653492221.609:7981): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [662860.351399] audit:
> type=3D1130 audit(1653494416.155:7996): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [662860.351407] audit: type=3D1131
> audit(1653494416.155:7997): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [664268.696715] audit:
> type=3D1130 audit(1653495824.532:8015): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [664268.696728] audit: type=3D1131
> audit(1653495824.532:8016): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [666455.434235] audit:
> type=3D1130 audit(1653498011.262:8031): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [666455.434242] audit: type=3D1131
> audit(1653498011.262:8032): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [667871.982919] audit:
> type=3D1130 audit(1653499427.830:8050): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [667871.982926] audit: type=3D1131
> audit(1653499427.830:8051): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [670052.877326] audit:
> type=3D1130 audit(1653501608.743:8065): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [670052.877335] audit: type=3D1131
> audit(1653501608.743:8066): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [671474.908959] audit:
> type=3D1130 audit(1653503030.786:8111): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [671474.908968] audit: type=3D1131
> audit(1653503030.786:8112): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [673667.158937] audit:
> type=3D1130 audit(1653505223.038:8126): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [673667.158950] audit: type=3D1131
> audit(1653505223.038:8127): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [675077.960417] audit:
> type=3D1130 audit(1653506633.852:8146): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [675077.960427] audit: type=3D1131
> audit(1653506633.852:8147): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess' [677264.824892] audit:
> type=3D1130 audit(1653508820.737:8173): pid=3D1 uid=3D0 auid=3D429496729=
5
> ses=3D4294967295 msg=3D'unit=3Dgrub-btrfs comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
> res=3Dsuccess' [677264.824903] audit: type=3D1131
> audit(1653508820.737:8174): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dgrub-btrfs comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> ```
>
> (The messages about the loop devices have to do with a separate issue,
> having trouble booting (u-boot) a NixOS-based Raspberry Pi from a
> compressed subvolume:
> https://lists.denx.de/pipermail/u-boot/2022-May/484855.html )
>
> The machine has no issues with a `balance --full-blance`, and `btrfs
> check` and `scrub` all complete without errors.
> If I disable quotas, it runs perfectly.
>
> When I enable quotas, it runs for a few days until it starts locking
> up and lagging, with `btrfs-transacti` taking up 100% CPU.
>
> I've enabled and subsequently disabled quota support at least a dozen
> times now, hoping I can get it working reliably (especially in order
> to leverage snapper's quota-based cleanup algorithms to help avoid
> unanticipated out-of-space issues). Is there anything obvious in my
> setup or configuration that seems problematic? For example, I've
> specifically wondered about whether `autodefrag` could be breaking COW
> and causing the snapper cleanups to be more resource-intensive, but
> removing `autodefrag` didn't seem to noticeably change things a few
> months ago.
>
> Many thanks in advance for your attention and any suggestions.
>
> Nate

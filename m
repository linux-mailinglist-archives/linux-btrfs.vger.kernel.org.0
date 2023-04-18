Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E58B6E5F2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjDRKuZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDRKuT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 06:50:19 -0400
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25F86BB
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 03:50:02 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 7ABB35F824;
        Tue, 18 Apr 2023 12:50:00 +0200 (CEST)
Date:   Tue, 18 Apr 2023 12:50:00 +0200 (CEST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs-transaction stalls
In-Reply-To: <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com>
Message-ID: <1a1a6ccf-25f9-d362-d890-8a609ff743f2@nerdbynature.de>
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de> <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de> <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 18 Apr 2023, Qu Wenruo wrote:
> Disable qgroup, or don't delete large shared subvolumes, or use the latest
> /sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold file to make qgroup to
> automatically skip such large snapshot drop.

I don't have Quota Groups enabled anywhere on the system, and snapshots 
are disabled too, see below. There's no qgroups subdirectory on this 
machine, only:

$ grep . /sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/*
grep: /sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/allocation: Is a directory
grep: /sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/bdi: Is a directory
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/bg_reclaim_threshold:75
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/checksum:crc32c (crc32c-intel)
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/clone_alignment:4096
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/commit_stats:commits 2106
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/commit_stats:last_commit_ms 2805
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/commit_stats:max_commit_ms 371767
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/commit_stats:total_commit_ms 6460389
grep: /sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/devices: Is a directory
grep: /sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/devinfo: Is a directory
grep: /sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/discard: Is a directory
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/exclusive_operation:none
grep: /sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/features: Is a directory
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/generation:636168
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/metadata_uuid:f1093dd0-ba7e-47c7-98de-e0ac85a34972
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/nodesize:16384
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/quota_override:0
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/read_policy:[pid]
/sys/fs/btrfs/f1093dd0-ba7e-47c7-98de-e0ac85a34972/sectorsize:4096


$ mount | grep btrfs
/dev/mapper/luks-root on / type btrfs (rw,relatime,seclabel,compress=zstd:3,ssd,discard,space_cache=v2,subvolid=5,subvol=/)

$ btrfs qgroup show /
ERROR: can't list qgroups: quotas not enabled

$ btrfs subvolume list /
ID 262 gen 636159 top level 5 path var/lib/machines
ID 263 gen 634062 top level 5 path srv

$ rpm -qf /var/lib/machines /srv
systemd-container-251.14-2.fc37.x86_64
filesystem-3.18-2.fc37.x86_64

The subvolumes must have been added by the distribution, but are not 
actively used (both directories are empty).


Thanks,
Christian.

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Christian.
> > 
> > 
> > > The system load applet is still working and shows very high I/O wait
> > > times, and I wait ~60 seconds and the system recovers and works again.
> > > And while all this happened rarely in the past, I notice it more often
> > > lately.
> > > 
> > > Some specs: Thinkpad T470, with a single Crucial NVMe 1 TB disk installed.
> > > I opted for full-disk-encryption and so the rootfs is (compressed) Btrfs
> > > on-top a LUKS2 dm-crypt device. I'm not using snapshots.
> > > 
> > > I ran a full btrfs-balance some time ago, but I can't say it helped much.
> > > If recommended, I can run another one of course.
> > > 
> > > Whenever these stalls happen, and I manage to fire up iotop-c, I can see
> > > "btrfs-transaction" at the very top, utilizing 100% of the disk's IO, but
> > > not generating _that_ much of I/O traffic (the encrypted disk can do ~250
> > > MB/s read). With even more luck I manage to run "perf record" during these
> > > stalls ("cd /tmp" before, so it can record to tmpfs, because of the
> > > stall), and while I can see "btrfs-transaction" in there, I don't see it
> > > in the top-10. Or maybe I'm to stupid to use perf report:
> > > 
> > >    https://nerdbynature.de/bits/6.1.14-200/perf_1.data.xz
> > > 
> > > This all can even be reproduced somewhat reliably: I was writing above how
> > > fast the disk is, and wanted to test _write_ speed as well:
> > > 
> > >   $ pv < /dev/zero > /foo
> > >   [wait....1.7GB/s.., cool...ok, let's stop after 9GB or so...]
> > >   ^C
> > >   $ rm -f /foo
> > > 
> > > And all that comes back instantly. But then running "/bin/sync" afterwards
> > > took 8 minutes (!) until the command came back, and I can see the I/O wait
> > > again in the system load applet in my window manager. This time I could
> > > no longer start iotop-c, but "perf record" recorded something, if you want
> > > to have a look:
> > > 
> > >   https://nerdbynature.de/bits/6.1.14-200/perf_2.data.xz
> > > 
> > > Some Btrfs infos below. Does anybody have an idea what's going on? Or how
> > > to debug this? Disable compression? Run another btrfs-balance? fsck?
> > > 
> > > Thank you,
> > > Christian.
> > > 
> > > $ mount | grep btrfs
> > > /dev/mapper/luks-root on / type btrfs
> > > (rw,relatime,seclabel,compress=zstd:3,ssd,discard,space_cache=v2,subvolid=5,subvol=/)
> > > 
> > > $ df -h /
> > > Filesystem             Size  Used Avail Use% Mounted on
> > > /dev/mapper/luks-root  250G  162G   88G  66% /
> > > 
> > > $ btrfs filesystem df /
> > > Data, single: total=164.00GiB, used=159.79GiB
> > > System, single: total=32.00MiB, used=48.00KiB
> > > Metadata, single: total=3.00GiB, used=1.73GiB
> > > GlobalReserve, single: total=329.44MiB, used=0.00B
> > > 
> > > $ sudo btrfs filesystem usage -T /
> > > Overall:
> > >      Device size:                 249.98GiB
> > >      Device allocated:            167.03GiB
> > >      Device unallocated:           82.95GiB
> > >      Device missing:                  0.00B
> > >      Device slack:                    0.00B
> > >      Used:                        161.53GiB
> > >      Free (estimated):             87.16GiB      (min: 87.16GiB)
> > >      Free (statfs, df):            87.16GiB
> > >      Data ratio:                       1.00
> > >      Metadata ratio:                   1.00
> > >      Global reserve:              329.44MiB      (used: 0.00B)
> > >      Multiple profiles:                  no
> > > 
> > >                           Data      Metadata System
> > > Id Path                  single    single   single   Unallocated Total
> > > Slack
> > > -- --------------------- --------- -------- -------- -----------
> > > --------- ----
> > >   1 /dev/mapper/luks-root 164.00GiB  3.00GiB 32.00MiB    82.95GiB
> > > 249.98GiB -
> > > -- --------------------- --------- -------- -------- -----------
> > > --------- ----
> > >     Total                 164.00GiB  3.00GiB 32.00MiB    82.95GiB
> > > 249.98GiB 0.00B
> > >     Used                  159.79GiB  1.73GiB 48.00KiB
> > > 
> > > 
> > > $ sudo compsize -x /
> > > Processed 1263684 files, 1173537 regular extents (1252947 refs), 612785
> > > inline.
> > > Type       Perc     Disk Usage   Uncompressed Referenced
> > > TOTAL       82%      160G         193G         199G
> > > none       100%      144G         144G         145G
> > > zlib        33%       14K          43K          43K
> > > zstd        32%       15G          48G          53G
> > > prealloc   100%       66M          66M          72M
> > > 
> > > -- 
> > > BOFH excuse #227:
> > > 
> > > Fatal error right in front of screen
> > > 
> > 
> 

-- 
BOFH excuse #99:

SIMM crosstalk.

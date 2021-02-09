Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8297D3158A5
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhBIV2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:28:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234160AbhBIUyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 15:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4AC2B23E;
        Tue,  9 Feb 2021 20:31:17 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH RFC 0/6] Add roundrobin raid1 read policy
Date:   Tue,  9 Feb 2021 21:30:34 +0100
Message-Id: <20210209203041.21493-1-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

This patch series adds a new raid1 read policy - roundrobin. For each
request, it selects the mirror which has lower load than queue depth.
Load is defined  as the number of inflight requests + a penalty value
(if the scheduled request is not local to the last processed request for
a rotational disk).

The series consists of preparational changes which add necessary
information to the btrfs_device struct and the change with the policy.

This policy was tested with fio and compared with the default `pid`
policy.

The singlethreaded test has the following parameters:

  [global]
  name=btrfs-raid1-seqread
  filename=btrfs-raid1-seqread
  rw=read
  bs=64k
  direct=0
  numjobs=1
  time_based=0

  [file1]
  size=10G
  ioengine=libaio

and shows the following results:

- raid1c3 with 3 HDDs:
  3 x Segate Barracuda ST2000DM008 (2TB)
  * pid policy
    READ: bw=217MiB/s (228MB/s), 217MiB/s-217MiB/s (228MB/s-228MB/s),
    io=10.0GiB (10.7GB), run=47082-47082msec
  * roundrobin policy
    READ: bw=409MiB/s (429MB/s), 409MiB/s-409MiB/s (429MB/s-429MB/s),
    io=10.0GiB (10.7GB), run=25028-25028mse
- raid1c3 with 2 HDDs and 1 SSD:
  2 x Segate Barracuda ST2000DM008 (2TB)
  1 x Crucial CT256M550SSD1 (256GB)
  * pid policy (the worst case when only HDDs were chosen)
    READ: bw=220MiB/s (231MB/s), 220MiB/s-220MiB/s (231MB/s-231MB/s),
    io=10.0GiB (10.7GB), run=46577-46577mse
  * pid policy (the best case when SSD was used as well)
    READ: bw=513MiB/s (538MB/s), 513MiB/s-513MiB/s (538MB/s-538MB/s),
    io=10.0GiB (10.7GB), run=19954-19954msec
  * roundrobin (there are no noticeable differences when testing multiple
    times)
    READ: bw=541MiB/s (567MB/s), 541MiB/s-541MiB/s (567MB/s-567MB/s),
    io=10.0GiB (10.7GB), run=18933-18933msec

The multithreaded test has the following parameters:

  [global]
  name=btrfs-raid1-seqread
  filename=btrfs-raid1-seqread
  rw=read
  bs=64k
  direct=0
  numjobs=8
  time_based=0

  [file1]
  size=10G
  ioengine=libaio

and shows the following results:

- raid1c3 with 3 HDDs: 3 x Segate Barracuda ST2000DM008 (2TB)
  3 x Segate Barracuda ST2000DM008 (2TB)
  * pid policy
    READ: bw=1569MiB/s (1645MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s),
    io=80.0GiB (85.9GB), run=52210-52211msec
  * roundrobin
    READ: bw=1733MiB/s (1817MB/s), 217MiB/s-217MiB/s (227MB/s-227MB/s),
    io=80.0GiB (85.9GB), run=47269-47271msec
- raid1c3 with 2 HDDs and 1 SSD:
  2 x Segate Barracuda ST2000DM008 (2TB)
  1 x Crucial CT256M550SSD1 (256GB)
  * pid policy
    READ: bw=1843MiB/s (1932MB/s), 230MiB/s-230MiB/s (242MB/s-242MB/s),
    io=80.0GiB (85.9GB), run=44449-44450msec
  * roundrobin
    READ: bw=2485MiB/s (2605MB/s), 311MiB/s-311MiB/s (326MB/s-326MB/s),
    io=80.0GiB (85.9GB), run=32969-32970msec

To measure the performance of each policy and find optimal penalty
values, I created scripts which are available here:

https://gitlab.com/vadorovsky/btrfs-perf
https://github.com/mrostecki/btrfs-perf

Michal Rostecki (6):
  btrfs: Add inflight BIO request counter
  btrfs: Store the last device I/O offset
  btrfs: Add stripe_physical function
  btrfs: Check if the filesystem is has mixed type of devices
  btrfs: sysfs: Add directory for read policies
  btrfs: Add roundrobin raid1 read policy

 fs/btrfs/ctree.h   |   3 +
 fs/btrfs/disk-io.c |   3 +
 fs/btrfs/sysfs.c   | 144 ++++++++++++++++++++++++++----
 fs/btrfs/volumes.c | 218 +++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h |  22 +++++
 5 files changed, 366 insertions(+), 24 deletions(-)

-- 
2.30.0


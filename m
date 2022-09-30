Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCF5F1401
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiI3Upx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 16:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiI3Up0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 16:45:26 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A553FED8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:20 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m18so3515709qvo.12
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=tNX4AFqAT+hHNoZGSqflPWvDHGy4pY+bfi0+B6neGy0=;
        b=n5Pu2cGZLmptWjlbmdwVCQe/exqTaUf5RrYw+4SYlJ22JFAMt/vLGr9LfhiG3sqs7P
         5uC+Lrd41eW1hSB+IW4vmyEfEQVOSTJ9ElbDe6Trbi1Wo64Po+CV2pzx2K4sK0o1/6M6
         xdPKHaAwp46DYghLAc/p6Uq+TcuAy5C1IJP481KtH6M57Rw5S+b2/ncb9R2KKvYNm4wD
         0uZ6ecxGkGV3k+q5W4ALtH8vap6y3C7e4JddVQUeKe3IfuInJajgvjLExins3YViNDWe
         j1sUlc8CfRYsCHQpdKyfJw54UHwLVQUamiR5Ugl+WMhn92AVeuP8K4D+qcv1DZdKAfq4
         XzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=tNX4AFqAT+hHNoZGSqflPWvDHGy4pY+bfi0+B6neGy0=;
        b=TijzHXFeIIs9OsXKavXEB8zcb9+VtJYcJ0S5ns5WkpEn8KCyk1EWdj2OaQZDtt4qir
         zxkrbNHSUNw1VZ0a1wZ9wgfVDwWJO2QuGh5iYSI0hUOo44vELBUNNh5w1ZjdS74LIA6k
         cUgxkVx41kFEl3xuj624qg//7EpJ8/ytihgsuE5dd1zWjs6sDuPkM6yHyj7XL8FhojYU
         yT6VXehUyh11tE/uRHL6uHaQyb8v24d8Jyg1b6Ge1GEF6uwxjk+AqRQ9SonQaIAAPxZs
         IYdAWjFax/P+tjx4p/qGg+Zm1uqeRJAX10Rb8ONtNHfMdpXmtDujeCTy/YhwkBB9kgWQ
         bXPQ==
X-Gm-Message-State: ACrzQf3NZm+hLL02JccRWbMrmHWSxsILGiboZkDNMgmHJtVMf0GezIDU
        ZNqZTU3A0hxHeMyp0AkbFpkT5c3JXn5Ssw==
X-Google-Smtp-Source: AMsMyM6ELvLEM5DSF6LVeYJlBD7bVOl3h2RLGwXHjajEu8AP484rq10H2ohhItDwAUERtz/E5H5Axg==
X-Received: by 2002:ad4:596c:0:b0:4ad:7901:fc8 with SMTP id eq12-20020ad4596c000000b004ad79010fc8mr8544157qvb.102.1664570719163;
        Fri, 30 Sep 2022 13:45:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006cebda00630sm2867387qkp.60.2022.09.30.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:45:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/6] Deadlock fix and cleanups
Date:   Fri, 30 Sep 2022 16:45:07 -0400
Message-Id: <cover.1664570261.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

There's a problem with how we do our extent locking, namely that if we encounter
any contention in the range we're trying to lock we'll leave any area we were
able to lock locked.  This creates dependency issues when the contended area is
blocked on some other thing that depends on an operation that would need the
range lock for the area that was successfully locked.  The exact scenario we
encountered is described in patch 1.  We need to change this behavior to simply
wait on the contended area and then attempt to re-lock our entire range,
clearing anything that was locked before we encountered contention.

The followup patches are optimizations and cleanups around caching the extent
state in more places.  Additionally I've added caching of the extent state of
the contended area to hopefully reduce the pain of needing to unlock and then
wait on the contended area.

The first patch needs to be backported to stable because of the extent-io-tree.c
move.  Once it lands in Linus I'll manually backport the patch and send it back
to the stable branches.

I've run this through a sanity test on xfstests, and I ran it through 2 tests on
fsperf that I felt would hammer on the extent locking code the most and be most
likely to run into lock contention.  I used the new function profiling stuff to
grab latency numbers for lock_extent(), but of course there's a lot of variance
here.  The only thing that fell outside of the standard deviation were some of
the maximum latency numbers, but generally everything was within the standard
deviation.  Again these are mostly just for information, deadlock fixing comes
before performance.  Thanks,

Josef

bufferedrandwrite16g results
      metric           baseline       current        stdev            diff
================================================================================
avg_commit_ms            10090.03       8453.23       3505.07   -16.22%
bg_count                    20.80         20.80          0.45     0.00%
commits                      6.20             6          1.10    -3.23%
elapsed                    140.60        139.60         18.06    -0.71%
end_state_mount_ns    42066858.80   45104291.80    6317588.83     7.22%
end_state_umount_ns      6.26e+09      6.23e+09      1.76e+08    -0.39%
lock_extent_calls     10795318.60   10713477.60     233933.51    -0.76%
lock_extent_ns_max     3945976.80       7027641    1676910.27    78.10%
lock_extent_ns_mean       2258.36       2187.89        212.76    -3.12%
lock_extent_ns_min         503.60        500.80          7.44    -0.56%
lock_extent_ns_p50        1964.80       1953.60        190.31    -0.57%
lock_extent_ns_p95        4257.40       4153.20        409.06    -2.45%
lock_extent_ns_p99        6967.20       6429.20       1166.93    -7.72%
max_commit_ms            24686.20         25927       5930.26     5.03%
sys_cpu                     46.68         45.52          6.83    -2.48%
write_bw_bytes           1.25e+08      1.24e+08   15352552.51    -0.61%
write_clat_ns_mean       23568.91      21840.81       4061.83    -7.33%
write_clat_ns_p50        13734.40      13683.20       1268.43    -0.37%
write_clat_ns_p99           33152      30873.60       4236.59    -6.87%
write_io_kbytes          16777216      16777216             0     0.00%
write_iops               30413.83      30228.55       3748.18    -0.61%
write_lat_ns_max         1.72e+10      1.77e+10      9.25e+09     2.64%
write_lat_ns_mean        23645.69      21934.65       4057.93    -7.24%
write_lat_ns_min          6049.40       5877.60         80.29    -2.84%

randwrite2xram results
      metric           baseline       current        stdev            diff
================================================================================
avg_commit_ms            21196.15      32607.37       2286.20    53.84%
bg_count                    43.80         39.80          6.46    -9.13%
commits                     11.20          9.80          1.10   -12.50%
elapsed                    329.20           350          4.97     6.32%
end_state_mount_ns    61846504.40   57392390.60    7914609.45    -7.20%
end_state_umount_ns      1.74e+10      1.80e+10      2.35e+09     3.44%
lock_extent_calls     26193512.60      24046630    4169768.34    -8.20%
lock_extent_ns_max    23699711.60   17524496.80   13253697.58   -26.06%
lock_extent_ns_mean       1871.04       1866.95         26.60    -0.22%
lock_extent_ns_min         495.60           501          5.41     1.09%
lock_extent_ns_p50        1681.80       1675.40         22.13    -0.38%
lock_extent_ns_p95        3487.60          3492         45.35     0.13%
lock_extent_ns_p99        4416.60       4431.80         44.77     0.34%
max_commit_ms               53482     116910.40       8707.34   118.60%
sys_cpu                      9.88          8.32          1.75   -15.85%
write_bw_bytes           1.05e+08   89841897.40   20713472.34   -14.84%
write_clat_ns_mean      158731.16     234418.93      30030.49    47.68%
write_clat_ns_p50        14732.80      14873.60        448.91     0.96%
write_clat_ns_p99        75622.40      82892.80      12865.88     9.61%
write_io_kbytes       31930975.20   28774377.60    5985362.29    -9.89%
write_iops               25756.55      21934.06       5057.00   -14.84%
write_lat_ns_max         3.49e+10      5.87e+10      6.68e+09    68.41%
write_lat_ns_mean       158828.62     234533.46      30028.84    47.66%
write_lat_ns_min             7809       7923.40        371.87     1.46%

Josef Bacik (6):
  btrfs: unlock locked extent area if we have contention
  btrfs: add a cached_state to try_lock_extent
  btrfs: use cached_state for btrfs_check_nocow_lock
  btrfs: use a cached_state everywhere in relocation
  btrfs: cache the failed state when locking extents
  btrfs: add cached_state to read_extent_buffer_subpage

 fs/btrfs/extent-io-tree.c | 68 +++++++++++++++++++++++++++------------
 fs/btrfs/extent-io-tree.h |  6 ++--
 fs/btrfs/extent_io.c      | 17 +++++++---
 fs/btrfs/file.c           | 12 ++++---
 fs/btrfs/inode.c          |  3 +-
 fs/btrfs/ordered-data.c   |  7 ++--
 fs/btrfs/ordered-data.h   |  3 +-
 fs/btrfs/relocation.c     | 40 +++++++++++++++--------
 8 files changed, 106 insertions(+), 50 deletions(-)

-- 
2.26.3


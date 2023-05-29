Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223B714CD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjE2PRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2PRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4C6D2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0D1B615AF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2AEC4339B
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373436;
        bh=yGb8OjbPUpDhSLmvBc5AXMP8rXaZkr71y2VjNte5kPw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PsukSgwnn9B8Tya8zkGimsjjxdqLilMoMdVZXs7SPhhC2OLpGmVK6q4yaWpGwaQfF
         sxQdl+V7dMAo39q6ELW8prpXLi5eNaJnZSywNx5s7pEU0mVS6etiVzt3ryCb+D3d7A
         EMRbavVvGtpxrBGAjtlFTPffJwW5SatJYXZj6Jsj5++/qNIEmBl0KV7ifQMMta645X
         0da4BZWUzcwcnALk50hzFioV0xKWWyn4eij5ew0rXdFgXMfOjt3xveKYuJKnu/1+UW
         OsB6itkUolOWjmK+wXAbnedg8dCkE8m7TECfM/cwGISAlbK+A7odd1dRfKy498CoDy
         /lhIetjUvtQrg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: reorder some members of struct btrfs_delayed_ref_head
Date:   Mon, 29 May 2023 16:16:57 +0100
Message-Id: <5c8b43665ff7b486b68ff35616b53f8357876245.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
References: <cover.1685363099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently struct delayed_ref_head has its 'bytenr' and 'href_node' members
in different cache lines (even on a release, non-debug, kernel). This is
not optimal because when iterating the red black tree of delayed ref heads
for inserting a new delayed ref head (htree_insert()) we have to pull in 2
cache lines of delayed ref heads we find in a patch, one for the tree node
(struct rb_node) and another one for the 'bytenr' field. The same applies
when searching for an existing delayed ref head (find_ref_head()).
On a release (non-debug) kernel, the structure also has two 4 bytes holes,
which makes it 8 bytes longer than necessary. Its current layout is the
following:

  struct btrfs_delayed_ref_head {
          u64                        bytenr;               /*     0     8 */
          u64                        num_bytes;            /*     8     8 */
          refcount_t                 refs;                 /*    16     4 */

          /* XXX 4 bytes hole, try to pack */

          struct mutex               mutex;                /*    24    32 */
          spinlock_t                 lock;                 /*    56     4 */

          /* XXX 4 bytes hole, try to pack */

          /* --- cacheline 1 boundary (64 bytes) --- */
          struct rb_root_cached      ref_tree;             /*    64    16 */
          struct list_head           ref_add_list;         /*    80    16 */
          struct rb_node             href_node __attribute__((__aligned__(8))); /*    96    24 */
          struct btrfs_delayed_extent_op * extent_op;      /*   120     8 */
          /* --- cacheline 2 boundary (128 bytes) --- */
          int                        total_ref_mod;        /*   128     4 */
          int                        ref_mod;              /*   132     4 */
          unsigned int               must_insert_reserved:1; /*   136: 0  4 */
          unsigned int               is_data:1;            /*   136: 1  4 */
          unsigned int               is_system:1;          /*   136: 2  4 */
          unsigned int               processing:1;         /*   136: 3  4 */

          /* size: 144, cachelines: 3, members: 15 */
          /* sum members: 128, holes: 2, sum holes: 8 */
          /* sum bitfield members: 4 bits (0 bytes) */
          /* padding: 4 */
          /* bit_padding: 28 bits */
          /* forced alignments: 1 */
          /* last cacheline: 16 bytes */
  } __attribute__((__aligned__(8)));

This change reorders the 'href_node' and 'refs' members so that we have
the 'href_node' in the same cache line as the 'bytenr' field, while also
eliminating the two holes and reducing the structure size from 144 bytes
down to 136 bytes, so we can now have 30 ref heads per 4K page (on x86_64)
instead of 28. The new structure layout after this change is now:

  struct btrfs_delayed_ref_head {
          u64                        bytenr;               /*     0     8 */
          u64                        num_bytes;            /*     8     8 */
          struct rb_node             href_node __attribute__((__aligned__(8))); /*    16    24 */
          struct mutex               mutex;                /*    40    32 */
          /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
          refcount_t                 refs;                 /*    72     4 */
          spinlock_t                 lock;                 /*    76     4 */
          struct rb_root_cached      ref_tree;             /*    80    16 */
          struct list_head           ref_add_list;         /*    96    16 */
          struct btrfs_delayed_extent_op * extent_op;      /*   112     8 */
          int                        total_ref_mod;        /*   120     4 */
          int                        ref_mod;              /*   124     4 */
          /* --- cacheline 2 boundary (128 bytes) --- */
          unsigned int               must_insert_reserved:1; /*   128: 0  4 */
          unsigned int               is_data:1;            /*   128: 1  4 */
          unsigned int               is_system:1;          /*   128: 2  4 */
          unsigned int               processing:1;         /*   128: 3  4 */

          /* size: 136, cachelines: 3, members: 15 */
          /* padding: 4 */
          /* bit_padding: 28 bits */
          /* forced alignments: 1 */
          /* last cacheline: 8 bytes */
  } __attribute__((__aligned__(8)));

Running the following fs_mark test shows some significant improvment.

  $ cat test.sh
  #!/bin/bash

  # 15G null block device
  DEV=/dev/nullb0
  MNT=/mnt/nullb0
  FILES=100000
  THREADS=$(nproc --all)
  FILE_SIZE=0

  echo "performance" | \
      tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  mkfs.btrfs -f $DEV
  mount -o ssd $DEV $MNT

  OPTS="-S 0 -L 5 -n $FILES -s $FILE_SIZE -t $THREADS -k"
  for ((i = 1; i <= $THREADS; i++)); do
      OPTS="$OPTS -d $MNT/d$i"
  done

  fs_mark $OPTS

  umount $MNT

Before this change:

FSUse%        Count         Size    Files/sec     App Overhead
    10      1200000            0     112631.3         11928055
    16      2400000            0     189943.8         12140777
    23      3600000            0     150719.2         13178480
    50      4800000            0      99137.3         12504293
    53      6000000            0     111733.9         12670836

                    Total files/sec: 664165.5

After this change:

FSUse%        Count         Size    Files/sec     App Overhead
    10      1200000            0     148589.5         11565889
    16      2400000            0     227743.8         11561596
    23      3600000            0     191590.5         12550755
    30      4800000            0     179812.3         12629610
    53      6000000            0      92471.4         12352383

                    Total files/sec: 840207.5

Measuring the execution times of htree_insert(), in nanoseconds, during
those fs_mark runs:

Before this change:

  Range:  0.000 - 940647.000; Mean: 619.733; Median: 548.000; Stddev: 1834.231
  Percentiles:  90th: 980.000; 95th: 1208.000; 99th: 2090.000
     0.000 -    6.384:       257 |
     6.384 -   26.259:       977 |
    26.259 -   99.635:      4963 |
    99.635 -  370.526:    136800 #############
   370.526 - 1370.603:    566110 #####################################################
  1370.603 - 5062.704:     24945 ##
  5062.704 - 18693.248:      944 |
  18693.248 - 69014.670:     211 |
  69014.670 - 254791.959:     30 |
  254791.959 - 940647.000:     4 |

After this change:

  Range:  0.000 - 299200.000; Mean: 587.754; Median: 542.000; Stddev: 1030.422
  Percentiles:  90th: 918.000; 95th: 1113.000; 99th: 1987.000
     0.000 -    5.585:      163 |
     5.585 -   20.678:      452 |
    20.678 -   70.369:     1806 |
    70.369 -  233.965:    26268 ####
   233.965 -  772.564:   333519 #####################################################
   772.564 - 2545.771:    91820 ###############
  2545.771 - 8383.615:     2238 |
  8383.615 - 27603.280:     170 |
  27603.280 - 90879.297:     68 |
  90879.297 - 299200.000:    12 |

Mean, percentiles, maximum times are all better, as well as a lower
standard deviation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b54261fe509b..9b28e800a604 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -70,20 +70,26 @@ struct btrfs_delayed_extent_op {
 struct btrfs_delayed_ref_head {
 	u64 bytenr;
 	u64 num_bytes;
-	refcount_t refs;
+	/*
+	 * For insertion into struct btrfs_delayed_ref_root::href_root.
+	 * Keep it in the same cache line as 'bytenr' for more efficient
+	 * searches in the rbtree.
+	 */
+	struct rb_node href_node;
 	/*
 	 * the mutex is held while running the refs, and it is also
 	 * held when checking the sum of reference modifications.
 	 */
 	struct mutex mutex;
 
+	refcount_t refs;
+
+	/* Protects 'ref_tree' and 'ref_add_list'. */
 	spinlock_t lock;
 	struct rb_root_cached ref_tree;
 	/* accumulate add BTRFS_ADD_DELAYED_REF nodes to this ref_add_list. */
 	struct list_head ref_add_list;
 
-	struct rb_node href_node;
-
 	struct btrfs_delayed_extent_op *extent_op;
 
 	/*
-- 
2.34.1


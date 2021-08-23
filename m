Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E438E3F5133
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhHWTYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhHWTX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:23:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957E7C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 14so20437839qkc.4
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/MsBSiH/AWr0qlDQJyr/AaTPFUu7tbbjlSf8YpYDAI=;
        b=d5NXuqDndcWuTRuc3OPdealKPdCfZ/a2M3JxZ/igOj80F+eb4jgxEwUm176hzA8tOx
         v3qoRuFZupV+fvAW5ONrIxm6X/U1hG+ODlFPrwJWCHlW9LzNVmPZARIdPQcjwuk5mOPk
         triQwQMDCbHeLiIVpGbsXZvRrdnYVX6LtJ+/yIHyTTz94Q3wl9s8s9xoWkSgDjUXFWu1
         65ApKoW0mb7LdpM6rqAxkVR8Tor/N9CqlEEb8cTU4/tjYx0s1WiiyeWq4rGAAwkOj0AG
         UjUWhzcZs3ApYICv9VAVwLoKk9k/mCgrUjzTaGhRHYQP2De7+BnbJGqPKOOyFa6WXfmz
         LV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/MsBSiH/AWr0qlDQJyr/AaTPFUu7tbbjlSf8YpYDAI=;
        b=jMAK6rhiUt9U7/M/kIspHry5oGEKYSraoy5f92NjIVKpZvqH9u5/okTumUc32t4qEW
         N6ect0ZAJJKUrj8IPk7EQlYjmjM9F9XTxwKMpOzUJ3Nu4XiorXcmuQCc5LHroRGU1RjY
         85DO6fJI318mxMNe0ZLBt2NLamg5Y4BPBi2ym+UAndM9BFTXxcipjzoPpmG88/Fhfp25
         l6IyvBnaQD6uuXgtrGKfQwQlfykPgU0DvHm+UIxbb7OSWN+3umOBbaI+DVA7xf0b9KuF
         qezQiTVRsKpAyUIGr4w+xgGWZUiFHwWIWJzWenabPy7X2sD5R9oBWKFVfi0hsVVY9Lj9
         /wpw==
X-Gm-Message-State: AOAM531UqqEND1TdYORUi0bWKD7c3Qbu1DSrTmwFOvK0eZV2wU9Q0qih
        206K1kogVsKXzY04vuQqDwUisiWNbpH0uA==
X-Google-Smtp-Source: ABdhPJyZ6mDwFFVggXpzbQSSWo5A45qU+q4QOLNdx5lcLBlxiq0EP1z6eyxUY01MvRstolpCPTVIlQ==
X-Received: by 2002:a37:a405:: with SMTP id n5mr23044726qke.218.1629746595426;
        Mon, 23 Aug 2021 12:23:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v128sm9399724qkh.27.2021.08.23.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/9] btrfs-progs: make check handle invalid bg items
Date:   Mon, 23 Aug 2021 15:23:04 -0400
Message-Id: <cover.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Rebased onto devel.
- Fixed the lowmem checks to work with Qu's test for subpage.
- Adjust the titles to indicate the area where the patch is for.
- Make btrfs_next_leaf() return an error instead of doing check_block in lowmem.
- Drop the corrupt-block patche for super blocks.

v1->v2:
- Discovered that we also don't check bytes_super in the superblock, add that
  checking and repair ability since it's coupled with the block group used
  repair.
- Discovered that we haven't actually been setting --mode=lowmem for the initial
  image check if we do make test-check-lowmem, we only do it after the repair.
  Fixed this.
- Now that we're properly testing error detection in all of the test cases, I
  found 3 problems with the --mode=lowmem mode, one infinite loop and two places
  we weren't properly propagating the error code up to the user.
- My super repair thing tripped a case where we wouldn't clean up properly for
  unaligned extent records, fixed this as well.
- Add another test image for the corrupted super bytes.
- Realize that you need a special .lowmem_repairable file in order for the
  lowmem repair code to run against images, so did that for both testcases.

--- Original email ---
Hello,

While writing code for extent tree v2 I noticed that I was generating a fs with
an invalid block group ->used value.  However fsck wasn't catching this, because
we don't actuall check the used value of the block group items in normal mode.
lowmem mode does this properly thankfully, so this only needs to be added to the
normal fsck mode.

I've added code to btrfs-corrupt-block to generate the corrupt image I need for
the test case.  Then of course the actual patch to detect and fix the problem.
Thanks,

Josef

Josef Bacik (9):
  btrfs-progs: tests: fix running lowmem checks
  btrfs-progs: check blocks in btrfs_next_sibling_block
  btrfs-progs: check: propagate fs root errors in lowmem mode
  btrfs-progs: check: propagate extent item errors in lowmem mode
  btrfs-progs: do not double add unaligned extent records
  btrfs-progs: check: detect and fix problems with super_bytes_used
  btrfs-progs: check: detect issues with btrfs_super_used in lowmem
    check
  btrfs-progs: test: add a test image with a corrupt block group item
  btrfs-progs: tests: add a test image with an invalid super bytes_used

 check/main.c                                  |  35 ++++++++++++++++++
 check/mode-lowmem.c                           |  16 +++++++-
 check/mode-lowmem.h                           |   1 +
 kernel-shared/ctree.c                         |   7 ++++
 tests/common                                  |   6 +--
 .../.lowmem_repairable                        |   0
 .../.lowmem_repairable                        |   0
 .../default.img.xz                            | Bin 0 -> 1060 bytes
 8 files changed, 59 insertions(+), 6 deletions(-)
 create mode 100644 tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable
 create mode 100644 tests/fsck-tests/051-invalid-super-bytes-used/.lowmem_repairable
 create mode 100644 tests/fsck-tests/051-invalid-super-bytes-used/default.img.xz

-- 
2.26.3


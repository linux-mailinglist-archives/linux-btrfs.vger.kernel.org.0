Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C24C0485
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiBVWZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiBVWY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:24:59 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2090B10AA
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:24:33 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q4so1798500qki.11
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBHtpDPyeliGSu3ayMZfe4bPpYAFkUGUBX1k7vqJz2Q=;
        b=t+dx/B0AHGWGmzPLYRkg4ygqnSeXiS5f+DyNJSO+Ne+TxdE9K6aFlDewDPU+y50kW/
         8aeaSb5WDn3TLghoyL4JkeQ6RALjQ4lwGPZcRNoUgmO+wvv7CKiAiCt3rWIf51tWGcJQ
         zdXWi9q5WNaDPfImKD8kIaxvDybbW7L3F+uBrhX/jmHd21kzVZg9jmwW0JODna0nxaUm
         9vpYtCCr6dwHGsQ6uZRm0U5bkMSie0O7IV5alImd2pIVh3lCXz/EJTwwE5S1W4OQuEhS
         GFLxOgKWY9ICJR+YbcGQFV+LwBDOscjzMfUQPu7bD4cMit9e8LK0ZGZXzoaPXkAu+1MJ
         YMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBHtpDPyeliGSu3ayMZfe4bPpYAFkUGUBX1k7vqJz2Q=;
        b=ws4rdUjdd91wH2Tnc9nzunZOLuoXFuFFUjU9iZTlPpT0zXTJRwZfKyNiH1YwKaNkvt
         qzgX8gkgcAdZ7wxXVbdJItNrbQoIN3MIutTxNT6iLrLs1E4kcllMpL6vQ9MHDQnmR6bb
         X3HXwtczQ5yX5G6DZIdHhKrdSU/sxmvMRwcWa/mqoG34QrBrrHyVtrET7LtwBRMsEB3c
         LmPxsoVO5XxeKSSl6ObPVg+glqujJUgqQ5tJoociKk55CW0z6axznNCqOF/RmOCp/lPt
         43KVnhfVGCCOa7rUbJ15mGPJwr5WcEZ4N7MJzVfPPSrNzJ2P/X6YuERN4RCC+MxZjp0O
         mgmg==
X-Gm-Message-State: AOAM531Bo+oba3LJIN/s9SaxoC5ZmVXxhbsnaNWhfGpbm90LddNjvfgA
        BlKz4lHq52iJsYiSt2MtjirP/mtrfP2+Aonv
X-Google-Smtp-Source: ABdhPJyLH7ZSRwa0gl8Xhmnknma9bdeypclpp/uOTCc5tdn6yZoW1B67/2jTLJePhQKwU/GF/CjMBg==
X-Received: by 2002:a05:620a:1a1d:b0:648:af1f:90d7 with SMTP id bk29-20020a05620a1a1d00b00648af1f90d7mr10646518qkb.340.1645568672809;
        Tue, 22 Feb 2022 14:24:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w2sm602000qts.29.2022.02.22.14.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:24:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2][RESEND] btrfs-progs: handle orphan directories properly
Date:   Tue, 22 Feb 2022 17:24:29 -0500
Message-Id: <cover.1645568638.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- use "is_orphan" not "has_orphan_item" in the mode-lowmem code.  Somehow the
  compiler didn't warn me of this until I switched to a different branch.

--- Original email ---
Hello,

While implementing the garbage collection tree I started getting btrfsck errors
when a test would do rm -rf DIRECTORY and then immediately unmount.  This is
because we stop processing GC items during umount, and thus we left the
directory with an nlink == 0 and all of its children in the fs tree.

However this isn't a problem with just the GC tree, we can have this happen if
we fail to do the eviction work at evict time, and we leave the orphan entry in
place on disk.  btrfsck properly ignores problems with inodes that have orphan
items, except for directory inodes.

Fix this by making sure we don't add any backrefs we find from directory inodes
that we've find the inode item for and have an nlink == 0.

I generated a test image for this by simply skipping the
btrfs_truncate_inode_items() work in evict in a kernel and rm -rf'ing a
directory on a test file system.

With this patch both make test-check and make test-check-lowmem pass all the
tests, including the new testcase.  Thanks,

Josef

Josef Bacik (2):
  btrfs-progs: handle orphan directories properly
  btrfs-progs: add a test to check orphaned directories

 check/main.c                                  |  15 ++++++++++++-
 check/mode-lowmem.c                           |   6 ++++--
 .../052-orphan-directory/default.img.xz       | Bin 0 -> 1432 bytes
 tests/fsck-tests/052-orphan-directory/test.sh |  20 ++++++++++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 tests/fsck-tests/052-orphan-directory/default.img.xz
 create mode 100755 tests/fsck-tests/052-orphan-directory/test.sh

-- 
2.26.3


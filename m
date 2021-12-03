Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77364467FC6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383374AbhLCWVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbhLCWVr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:47 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344CC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:22 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id jo22so4113830qvb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+blJBDvdQyfP3EbZA1tDiOV9awEnh/D1bliY1nP2JE=;
        b=xP4tQ0Ys43ycZIcb+UABgxLKfHPhh0FRJvRCjfOTlTTf+jjIsF/Qj3wHCzM5xYGtA9
         UgMxUnR2OAG8S/vIXwCZxdiKeOCK40AlcDZAL0kkHhdCcqilr4cDm+574Br9TE1+XjHe
         LOAjqIj2adB+/HN5zBXu3nK7xXVCM/PkMvaDBSgb1PWajOIxdSAwYC/e2vUK69Ut+Mhl
         AKY9CCfKfGvy+pPpP83fpkXulp2ZnwDW0VWhfb54NEl0XMGltLfu73XC3rGOS28/bA+s
         6Ir6sjAgrXPhGIHHJh+BSXnfU92e5rdYu9ZezSqwZNoOqSqTeSGpjVcXZjXKFRWzxOdD
         Hc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+blJBDvdQyfP3EbZA1tDiOV9awEnh/D1bliY1nP2JE=;
        b=jzZzdCAdnuSl6a/arzSB09Bi2TN+uX6SN0LUAeceUolkyN+o9V/1P7++hR97FUElY7
         UX4KQ4tzkpdND0irBeskRrCgZhL45XbegnzU4MeGypVmqArjHXKXm0zxOjyM0EhgUFho
         Bf61lziIJROdghiU5+9i1PFOzwehZrmwslhDmRkBZm1ruLTkViTcHyR3em4lEujGHrth
         2IFq1wnpnPopw+eiygCL2cOr85vzuOD5cQHoIu1B+LHSpfDKP16dEfjhAn9o5g+s9r+Y
         rbC6ZeBR1NX144WsyvvCHFlcYEE6hbP1GChI66K9HAq1qNn5JwglEHiNu9Nk63SIn3jY
         X88Q==
X-Gm-Message-State: AOAM531PF3+03r0HVXSvz55DLh6dpaiig0ZbCdrILddbkx3M46DDybGH
        vMMeUeqgq5/STz0jNM8HKpx91z1iL0e83Q==
X-Google-Smtp-Source: ABdhPJyZlRrgG/3DncLzS3ju6DumIN6gSFfw+VYkpDWIegQ5CW60tzSLs/KG1NKreARKhKZsllSIXg==
X-Received: by 2002:ad4:4d05:: with SMTP id l5mr22649162qvl.54.1638569901225;
        Fri, 03 Dec 2021 14:18:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s20sm3378961qtc.75.2021.12.03.14.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/18] Truncate cleanups and preparation work
Date:   Fri,  3 Dec 2021 17:18:02 -0500
Message-Id: <cover.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

The first thing I'm implementing with the garbage collection tree is
btrfs_truncate_inode_items() on evicted inodes.  However
btrfs_truncate_inode_items() has a lot of oddities that it's grown over the
years, and requires having a valid btrfs_inode to use.  We don't really want to
have to look up the old inode to do the truncate, we just want to do the tree
operaitons to delete all of the objects and extents.

Enter this patch series, I've cleaned up btrfs_truncate_inode_items(), moved as
much of the inode operations out to the respective callers, and cleaned up the
argument passing and such to make it a little cleaner.

We still have to pass in the inode for the ^NO_HOLES case for the normal
truncate path, but other than that I've stripped it down so that we can pass in
a NULL inode and get all the work done.

This has the nice side-effect of cleaning up a lot of our

if (root == LOG_ROOT)
	// do something else

checks in this helper, and hopefully makes it more straightforward to
understand.  Thanks,

Josef

Josef Bacik (18):
  btrfs: add an inode-item.h
  btrfs: move btrfs_truncate_inode_items to inode-item.c
  btrfs: move extent locking outside of btrfs_truncate_inode_items
  btrfs: remove free space cache inode check in
    btrfs_truncate_inode_items
  btrfs: move btrfs_kill_delayed_inode_items into evict
  btrfs: remove found_extent from btrfs_truncate_inode_items
  btrfs: add btrfs_truncate_control struct
  btrfs: only update i_size in truncate paths that care
  btrfs: only call inode_sub_bytes in truncate paths that care
  btrfs: control extent reference updates with a control flag for
    truncate
  btrfs: use a flag to control when to clear the file extent range
  btrfs: pass the ino via btrfs_truncate_control
  btrfs: add inode to btrfs_truncate_control
  btrfs: convert BUG_ON() in btrfs_truncate_inode_items to ASSERT
  btrfs: convert BUG() for pending_del_nr into an ASSERT
  btrfs: combine extra if statements in btrfs_truncate_inode_items
  btrfs: make should_throttle loop local in btrfs_truncate_inode_items
  btrfs: do not check -EAGAIN when truncating inodes in the log root

 fs/btrfs/ctree.h            |  34 ---
 fs/btrfs/delayed-inode.c    |   1 +
 fs/btrfs/free-space-cache.c |  31 ++-
 fs/btrfs/inode-item.c       | 334 ++++++++++++++++++++++++++
 fs/btrfs/inode-item.h       |  86 +++++++
 fs/btrfs/inode.c            | 452 +++++-------------------------------
 fs/btrfs/relocation.c       |   1 +
 fs/btrfs/tree-log.c         |  15 +-
 8 files changed, 511 insertions(+), 443 deletions(-)
 create mode 100644 fs/btrfs/inode-item.h

-- 
2.26.3


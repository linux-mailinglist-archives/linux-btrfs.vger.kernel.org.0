Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6EF2F6A68
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 20:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbhANTDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 14:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbhANTD3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 14:03:29 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD79C061575
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:49 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v3so2035680qtw.4
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMlKBWDGaK6hVgzzTfqtHF/i/X7RXhrSgQEPX+Xqg4E=;
        b=StncTXoKK1QKzTuRBvnL8rFpZ++PNpRrLr9ZD+GxzqOb+spbB1HE3+o+gN+rXvbYBb
         ACif/T/wom0H1yU19PeVZ91vIYhMBWQE3ATMla42ajt0tpk4myZ0WQkYMe53jQTs5bbE
         K916SlauF0uR+3udTB/ULLIWnALvzr8lI5GkdlXztu/C6bRuOiWwOGjAKGwCHKxohHGH
         fjoEdwcNfi53GXSqS2ghCpB8YqYwcr4yQmq5CWdBnIAHZp2GN5ApoGndzMFBwIvjtuEK
         mNtdpLG5HffZDx8/Vu7IviMXKcDzZJGaPfD1f039VO6mIf4j6gjO1H3ulTSqkEbIyCB6
         Lp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMlKBWDGaK6hVgzzTfqtHF/i/X7RXhrSgQEPX+Xqg4E=;
        b=V8TJxGkJJ3xliHCBtiiwKBbVyQHGaEgkkh+3InZDOn7bKU8AGXKGH/fkxsovY6LNnf
         EoALis6ZPSkIlogYELReX/IzcQAwb9GhbjB25i3xppWxdOn0cnaWfdP6p+LiQ6FSalyj
         /YhbtFyAg/afaC1B315/hWzNcQ9O2YTvPYn1KKMZ5jRRHM42sQxjcZ64X2uj21Jp/nn8
         DQD3nhJ2UV8M+MnetDjPWtqsGUUKVL3ZD/9oNwvEiPmF4F1TR/EW5/90aBjccgPylyC0
         pNOuU1RHnqCoCiWEVwlLsiESvqB0OAP+jIplbuRM1lcsv3gfP6BrSx2+FcowIiVPxslA
         qVXg==
X-Gm-Message-State: AOAM530yzEYDSXz7GX2QGYLxO+URFKz5wuBKDcXvqS06GpLxsRy9m104
        NY4CtJvrECR1duy95ZgRWicPc7DKpcEUSArt
X-Google-Smtp-Source: ABdhPJw6ihb8GTyozJAljS0utLiL0PpDcf9tP3q8l8Gl0cKzDn13JiAuaLb/3wqyHnjMHfpb6UxcgA==
X-Received: by 2002:aed:2ba5:: with SMTP id e34mr8699664qtd.146.1610650968125;
        Thu, 14 Jan 2021 11:02:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v196sm3630395qkb.84.2021.01.14.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:02:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/5] Serious fixes for different error paths
Date:   Thu, 14 Jan 2021 14:02:41 -0500
Message-Id: <cover.1610650736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rebased onto misc-next, dropping everything that's been merged so far.
- Fixed "btrfs: splice remaining dirty_bg's onto the transaction dirty bg list"
  to handle the btrfs_alloc_path() failure and cleaned up the error handling as
  a result of that change.
- dropped "btrfs: don't clear ret in btrfs_start_dirty_block_groups" as I fixed
  it differently in "btrfs: splice remaining dirty_bg's onto the transaction
  dirty bg list"
- Added a link to Zygo's original report in "btrfs: add asserts for deleting
  backref cache nodes".
- Clarified the error condition that lead to the WARN_ON() in the changelog for
  "btrfs: do not WARN_ON() if we can't find the reloc root".
- Added the stack trace that the error injection triggered in order to get the
  error that happened in "btrfs: abort the transaction if we fail to inc ref in
  btrfs_copy_root".

--- Original email ---
Hello,

A lot of these were in previous versions of the relocation error handling
patches.  I added a few since the last go around.  All of these do not rely on
the error handling patches, and some of them are quite important otherwise we
get corruption if we get errors in certain spots.  There's also a few lockdep
fixes and such.  These really need to go in ASAP, regardless of when the
relocation error handling patches are merged.  They're mostly small and self
contained, the only "big" one being the one that tracks the root owner for
relocation reads, which is to resolve the remaining class of lockdep errors we
get because of an improper lockdep class set on the extent buffer.  Thanks,

Josef

Josef Bacik (5):
  btrfs: fix reloc root leak with 0 ref reloc roots on recovery
  btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
  btrfs: do not WARN_ON() if we can't find the reloc root
  btrfs: add asserts for deleting backref cache nodes
  btrfs: abort the transaction if we fail to inc ref in btrfs_copy_root

 fs/btrfs/backref.c     |  2 +-
 fs/btrfs/backref.h     |  9 ++++++---
 fs/btrfs/block-group.c | 19 ++++++++++++-------
 fs/btrfs/ctree.c       |  5 +++--
 fs/btrfs/relocation.c  |  4 +---
 5 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.26.2


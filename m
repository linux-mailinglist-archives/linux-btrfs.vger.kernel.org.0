Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7384F2F87E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbhAOVtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 16:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbhAOVtj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 16:49:39 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B6C061757
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:48:59 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id n142so13228090qkn.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UO+E42G065uPmcbDSA2LGRWeff5X0UJUo0nNweBTWyM=;
        b=AxKKVIcCN561RN8X8M70pAU8vZFtYb7fsGTF5v5avbAofPGCfJPE3CJxZsab0OasMI
         3pOUwgW8TmEO677URrXrOpWXG4mep/+IOCxo/WKmXbGp9/EOA3dqSFDJwFgrav2ndzr7
         5FWw5bZ7UT1oItwEbGoU2J72onNgL8R6kA8GEpheUVPHtJZb2byobpxyFWg3ywofEaZt
         S3V6iHviQyMMzry+65kvGVPQjynD+IxQo3o9HvRDKp0NpUUi6SlfEmDxwg0qpBKXrDjD
         GSx3R9BREvOzmNBcgbup2BQvne/niMUwlzv3AhtQ7rBKKQjfkOyhN0kC8r0R05Yoxh6/
         pD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UO+E42G065uPmcbDSA2LGRWeff5X0UJUo0nNweBTWyM=;
        b=oFmn7g/+2iehro3CYhrgYXZKxudvi0aRb15nvO26pZpe2A5n5a+KnqOcYz4ejbeQdN
         WkO3CpvLu6OtiUDvx+m3hZezUdxJQc7ycaHEaYr+BwtbvN/zQpmbXkjlAM6j5coTyRn8
         pSvvmGw0G6GCnwEj1r+T/T1agn8WXwV1+3gj6XV+imjZplVQ4D56ZNcT/0g6u5leelLU
         3BN3k3cLG+VE8cwreZL6X8l+Y20z0GqYDb4lifPwruUaZVbo5mJ4Y0DDcKkJPeS4bszI
         ZEVmjXw1QKJP322x0erSMPlTAtwFCGwPctPE8suf2MaX70ItAuDbqjeikoe+vB88xHST
         KMiA==
X-Gm-Message-State: AOAM530EQLGfhyLasEYo4S+7D0/O6T+7pDS4XVDlLstoQVBaM6xE+d/G
        Q7YmV+ADTY2DboBwoV5KBo6utdP9IudetRnQ
X-Google-Smtp-Source: ABdhPJwA8sgPhCCyPnmvWttCQBxfFUYafeYZBtORSxNY61yc6HCom2W+GWJLpXcIgGz6aHKev9DN1Q==
X-Received: by 2002:a05:620a:11ba:: with SMTP id c26mr15063114qkk.140.1610747338319;
        Fri, 15 Jan 2021 13:48:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z20sm5729784qkz.37.2021.01.15.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:48:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/2] ->total_bytes_pinned fixes for early ENOSPC issues
Date:   Fri, 15 Jan 2021 16:48:54 -0500
Message-Id: <cover.1610747242.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Updated the changelog in patch 2 to refer to the patchset that inspired the
  change.
- Added Nik's reviewed-by for patch 2.
v1->v2:
- Rebase onto latest misc-next.
- Added Nikolay's reviewed-by for the first patch.

--- Original email ---
Hello,

Nikolay discovered a regression with generic/371 with my delayed refs patches
applied.  This isn't actually a regression caused by those patches, but rather
those patches uncovered a problem that has existed forever, we just have papered
over it with our aggressive delayed ref flushing.  Enter these two patches.

The first patch is more of a refactoring and a simplification.  We've been
passing in a &old_refs and a &new_refs into the delayed ref code, and
duplicating the

if (old_refs >= 0 && new_refs < 0)
	->total_bytes_pinned += bytes;
else if (old_refs < 0 && new_refs >= 0)
	->total_bytes_pinned -= bytes;

logic for data and metadata.  This was made even more confusing by the fact that
we clean up this accounting when we drop the delayed ref, but also include it
when we actually pin the extents down properly.  It took me quite a while to
realize that we weren't mis-counting ->total_bytes_pinned because of how weirdly
complicated the accounting was.

I've refactored this code to make the handling distinct.  We modify it in the
delayed refs code itself, which allows us to clean up a bunch of function
arguments and duplicated code.  It also unifies how we handle the delayed ref
side of the ->total_bytes_pinned modification.  Now it's a little easier to see
who is responsible for the modification and where.

The second patch is the actual fix for the problem.  Previously we had simply
been assuming that ->total_ref_mod < 0 meant that we were freeing stuff.
However if we allocate and free in the same transaction, ->total_ref_mod == 0
also means we're freeing.  Adding that case is what fixes the problem Nikolay
was seeing.  Thanks,

Josef

Josef Bacik (2):
  btrfs: handle ->total_bytes_pinned inside the delayed ref itself
  btrfs: account for new extents being deleted in total_bytes_pinned

 fs/btrfs/block-group.c |  11 ++--
 fs/btrfs/delayed-ref.c |  60 ++++++++++++-------
 fs/btrfs/delayed-ref.h |  16 +++--
 fs/btrfs/extent-tree.c | 129 ++++++++++-------------------------------
 fs/btrfs/space-info.h  |  17 ++++++
 5 files changed, 103 insertions(+), 130 deletions(-)

-- 
2.26.2


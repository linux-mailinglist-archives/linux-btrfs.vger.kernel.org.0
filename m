Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4869D44B019
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhKIPO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhKIPO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:14:56 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB68C061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:10 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id bm28so18990178qkb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbyBoZfoVnA9tY+C92ZadXUw7XuJ2MaaOhHCiKfqAig=;
        b=SgWh/+Yel9Kbp965CSVOvJ4G2rZ0Vdo9j+f4fwP/H6QI8O++0VUoIBltLDN9PEIE6J
         DhVYoFLo0f+QDPUAgd/5rkI1nsqbi0PxSNJPlDhpKv3wOQA0AkrDBCwji+ehT5yIaFlm
         fpQuIrxuZwelc7HdqMk8fyjQXjiMoe5yYp8Lhs6wKLcKJ4IjZsnzyjtXU98J4nMZQZI8
         JsrFJdBubQaxnP9QeTBAfmZTD+UkaF0ZSC8ytM/2KhZ8n9UY96+MKZ8gU9fQjeJMoXrH
         oDYiqmFdam3IPSY1ZmO/7pz8mr//fIi96CXjnoRYP0CR41aozXzWQfRd8eZ45ox0I+//
         YXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbyBoZfoVnA9tY+C92ZadXUw7XuJ2MaaOhHCiKfqAig=;
        b=HwXqUhhKvqepPsAw1P6AwGXYV0ERv/ud+9oHZZPjZMOo4/HzrPxS/E6DGAMR+0RUBo
         Erxleg4or1weQnGVxSyfQttnezkGrUi45Ud2PUDEabdomh89wDVcfW/dzsWgrV8qs3Kz
         t2L7u4LYndv3xgWaJvJWkmOZAC57t2gVcc0IUVpCdb/KgFO5945L25sfMGe6ZyIqblZP
         vm/U+oO/elBgA2qokBgOwXqtxHpzcbgX/48mkgVgDDGJEWOk/cM69rvmiLgZ+0WPtAsP
         VBiX48tCSJSwULkNTRQQJNBoPmKqs8Z5isWCq5WvqfcdF1LoDzbEhWPd7vyrLwyCwddA
         LT0g==
X-Gm-Message-State: AOAM532F1FGpO3QoXJ0rGpN98vzX0avw2KJR8sFQFChutCEnbuITf7DX
        35C7SNyZeXV0TxyWVWetKaNToOWVJ4h33Q==
X-Google-Smtp-Source: ABdhPJwae3dCdLbP4mnfxF3j4HBOCXhu6RsRWHg63Oo9rIUqoKt/8BV6Q6XpX86+0322QrhgawlSQA==
X-Received: by 2002:a37:40c3:: with SMTP id n186mr6322833qka.520.1636470728903;
        Tue, 09 Nov 2021 07:12:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y9sm11961867qko.74.2021.11.09.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/7] Use global rsv stealing for evict and clean things up
Date:   Tue,  9 Nov 2021 10:12:00 -0500
Message-Id: <cover.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Nikolay suggested an additional cleanup, which lead to multiple other cleanups
  and small fixes.

v1->v2:
- Reworked the stealing logic to be inside of the priority metadata loop, since
  that's the part we care about.
- Renamed the helper to see if we can steal to can_steal.
- Added Nikolay's reviewed-by's.

--- Original email ---

Hello,

While trying to remove direct access of fs_info->extent_root I noticed we were
passing root into btrfs_reserve_metadata_bytes() for the sole purpose of
stealing from the global reserve if we were doing orphan cleanup.  This isn't
really necessary anymore, but I needed to clean up a few things

1) We have global reserve stealing logic in the flushing code now that does the
   proper ordering already.  We just hadn't converted evict to this yet, so I've
   done that.
2) Since we already do the global reserve stealing as a part of the reservation
   process we don't need the extra check to steal from the global reserve if we
   fail to make our reservation during orphan cleanup.
3) Since we no longer need this logic we don't need the orphan_cleanup_state bit
   in the root so we can remove that.
4) Finally with all of this removed we don't have a need for root in
   btrfs_reserve_metadata_bytes(), so change it to fs_info and change it's main
   callers as well.

With that we've got more consistent global reserve stealing handling in evict,
and I've cleaned up the reservation path so I no longer have to worry about a
couple of places where we were doing
btrfs_reserve_metadata_bytes(root->extent_root).  Thanks,

Josef Bacik (7):
  btrfs: handle priority ticket failures in their respective helpers
  btrfs: check for priority ticket granting before flushing
  btrfs: check ticket->steal in steal_from_global_block_rsv
  btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
  btrfs: remove global rsv stealing logic for orphan cleanup
  btrfs: get rid of root->orphan_cleanup_state
  btrfs: change root to fs_info for btrfs_reserve_metadata_bytes

 fs/btrfs/block-group.c    |  2 +-
 fs/btrfs/block-rsv.c      | 12 +++---
 fs/btrfs/block-rsv.h      |  4 +-
 fs/btrfs/ctree.h          |  9 +----
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/delayed-inode.c  |  2 +-
 fs/btrfs/delayed-ref.c    |  4 +-
 fs/btrfs/disk-io.c        |  1 -
 fs/btrfs/inode.c          | 21 ++++------
 fs/btrfs/props.c          |  5 ++-
 fs/btrfs/relocation.c     | 17 ++++----
 fs/btrfs/root-tree.c      |  2 +-
 fs/btrfs/space-info.c     | 84 +++++++++++++++++++++------------------
 fs/btrfs/space-info.h     |  2 +-
 fs/btrfs/transaction.c    |  4 +-
 15 files changed, 86 insertions(+), 85 deletions(-)

-- 
2.26.3


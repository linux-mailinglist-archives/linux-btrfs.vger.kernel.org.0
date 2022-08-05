Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C6558AC39
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiHEOPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbiHEOPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:06 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49A457274
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:03 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i7so1817190qvr.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RB7G5/gdHCpZYSj0BO99uVgmNv2oW6Votw4CmrzwrI=;
        b=7w7mTbiHhDOWB4AOJ5hys/42V6EfrbDhH/jslPNAmPCCpFK2LGqkmrOwP1cv2Zhj6J
         4N3RIyuGz75MiVdYiU9DuqPE6b4s71SGnQZcmaE7ROmCrypHbSSRY1QVUlXp+X9hLf11
         DVU/zwEZ/E4v5V1jKhzyKRS55UUdk92A/uJGUabWnOui3YZjFZcc3ew/vFI/Tk6NCdNk
         demeK3es1ylU2FZwzvGF2hPSjxEVGAI6YuMMwyJHArYvHCg8U4hNm2pBKbf0GweO8zye
         pgRnaCdob31KGvzn9MJfr2C3Qm7RHD9FUH5/ID1WW3OJ0h3XykmYycGxAKHBK4lCTDhy
         +HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RB7G5/gdHCpZYSj0BO99uVgmNv2oW6Votw4CmrzwrI=;
        b=jhCUeWkBHdU83mSK5wEyNRyc+FoGDjPptnrUZ8egxuLKNVWi36e3Kr0hk4wf9ZPgi3
         plfwhq7HfUAC8iZEkBok1T4ANzYk8WDVLNM1VAFCTqtf71YnF+NPT+IdBI9XP7XUsjx+
         0D3zEc76tzzGuKTrlOcCDchK//bMo0u1zCWU6MLX0rVb+pJIe5E0LsieMDr1A5xr2Hsd
         KAL4BNZC+pA5m2RLjBcmmDfNGLCby+JlWkUtdGdEUwsi5G8LlNMa8deAJSGaus+CIW3K
         QsqWwc+Lhuo8PbNiO/q/xZiz2ZVzKO0BaTVECqt/U75Xe9jEOIXjK9uGydaBdAkqBzZZ
         7jNw==
X-Gm-Message-State: ACgBeo2pf8mgp+QyP81mceTl8AxnnwLMZshydSdOS77yVyyxwfl2UZK2
        Cio1WDqZtDwg4xmWc2yUe3QO8aGhN12nXQ==
X-Google-Smtp-Source: AA6agR4pJLVxgecW1aH/OgIhMyfEg29c2weZZjKEl/XsRLyhzad+xo4JUQklRGqiqsQTFt7lDWdsJA==
X-Received: by 2002:a05:6214:268c:b0:474:8351:5803 with SMTP id gm12-20020a056214268c00b0047483515803mr5846730qvb.23.1659708902156;
        Fri, 05 Aug 2022 07:15:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11-20020a05622a1a8b00b0031d283f4c4dsm2975825qtc.60.2022.08.05.07.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/9] btrfs: block group cleanups
Date:   Fri,  5 Aug 2022 10:14:51 -0400
Message-Id: <cover.1659708822.git.josef@toxicpanda.com>
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

v2->v3:
- I removed a check for FS_OPEN in the first patch which was incorrect.

v1->v2:
- I'm an idiot and didn't rebase properly, so adding the two other cleanups I
  had that I didn't send.
- Rebased onto a recent misc-next and fixed the compile errors.
- Realized that with the new zoned patches that caused the compile error that
  btrfs_update_space_info needed to be cleaned up, so added patches for that.

--- Original email ---

I'm reworking our relocation and delete unused block group workqueues which
require some cleanups of how we deal with flags on the block group.  We've had a
bit field for various flags on the block group for a while, but there's a subtle
gotcha with this bitfield in that you have to protect every modification with
bg->lock in order to not mess with the values, and there were a few places that
we weren't holding the lock.

Rework these to be normal flags, and then go behind this conversion and cleanup
some of the usage of the different flags.  Additionally there's a cleanup around
when to break out of the background workers.  Thanks,

Josef

Josef Bacik (9):
  btrfs: use btrfs_fs_closing for background bg work
  btrfs: simplify btrfs_update_space_info
  btrfs: handle space_info setting of bg in btrfs_add_bg_to_space_info
  btrfs: convert block group bit field to use bit helpers
  btrfs: remove block_group->lock protection for TO_COPY
  btrfs: simplify btrfs_put_block_group_cache
  btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL
  btrfs: remove bg->lock protection for relocation repair flag
  btrfs: delete btrfs_wait_space_cache_v1_finished

 fs/btrfs/block-group.c      | 158 ++++++++++++++----------------------
 fs/btrfs/block-group.h      |  21 ++---
 fs/btrfs/dev-replace.c      |  11 +--
 fs/btrfs/extent-tree.c      |   7 +-
 fs/btrfs/free-space-cache.c |  18 ++--
 fs/btrfs/scrub.c            |  16 ++--
 fs/btrfs/space-info.c       |  38 +++++----
 fs/btrfs/space-info.h       |   6 +-
 fs/btrfs/volumes.c          |  16 ++--
 fs/btrfs/zoned.c            |  34 +++++---
 10 files changed, 148 insertions(+), 177 deletions(-)

-- 
2.26.3


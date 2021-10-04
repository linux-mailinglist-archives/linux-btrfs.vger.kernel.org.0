Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8308F42150E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhJDRVP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhJDRVP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:21:15 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E48EC061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:19:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f130so17203552qke.6
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8UE8UuoR2irrI3azByRoj5mWOMi90q/brOPP6SD9aY=;
        b=55RDKgNdTMuETns9qSHjC4oZFI/nic1i8Fwb8hGcFTgwxkQ5Ap9k5GoFG6yN2qLatO
         t9cVz/Ue+yKdsh6SmO6D91mRSCbTF4EyF2WrekectyMYOr2R0rZ3saKSvpqToo1rvUMV
         KMEiTEHrLuGKUrnt0q2AHNqfnw2ttRWxXu063U54ddhiw2mWnkrgCDd/BAbzaudKxzNm
         5UkOl/Va2TU/gqSVMChQb00ATuzJQh/6ia3J8XdbRhbAReTSzxVqEjh6wcQEYOEeo94a
         OzkzjV0jRq4ASrTJD/6VABnD6kyDrbMhy4tNHVkWC2Vr0bDBCA1hb0TTghU4ziStfWJy
         UgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8UE8UuoR2irrI3azByRoj5mWOMi90q/brOPP6SD9aY=;
        b=kVL2qvKgMO3NYB1TZc9B59Wt5esF6OeNEVPUWqBNKQSQOAWZHrFrOUB7kNGvfZBYWI
         vJ1SW0JaUGeqfiw7XOgyXDLJDYzn7SFufy8/WQclfM3Z1vfIIw3a9a4GeyFqA8TbVrgC
         prxaGBzZ+FcBePG+PAm7iFV+O7EMV1IJoc3yra8OIeuLGpgRdXQgzTyHLfOSHk1gHUAK
         HQZUSU6aw1AB33dL6F6wX1+JctGUOBjQnsbOfbjcRnAWRuNc8s+xtKLFsO4vU7QZej0a
         IPvFEPXjHrmDv0yEENnofmwBnpHiVVrVsilr55y12kP7qX/odhDF6XMzR9TYlYJMpdu1
         InhQ==
X-Gm-Message-State: AOAM532yLQ9x4s2tyidF7+WBohxY+cEG2J7eqJafJUxr9osdT4BdQuxn
        jvrj1cQSyBFeLHf0//9KqM7hWND6GlP00g==
X-Google-Smtp-Source: ABdhPJwbS5PwQmeHS1ElPKM5CfXCiePpsM4WbH6KEsGW5/z46iSE78+a1Z1SywxCX7is97ywvMOSVQ==
X-Received: by 2002:a37:901:: with SMTP id 1mr10954881qkj.342.1633367964774;
        Mon, 04 Oct 2021 10:19:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h2sm8010983qkk.10.2021.10.04.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:19:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/6] Fix lockdep issues around device removal
Date:   Mon,  4 Oct 2021 13:19:16 -0400
Message-Id: <cover.1633367810.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Dropped the patches that kdave already merged.
- Added some prep patches that Anand had that I need for my fixes.
- Reworked device lookup to take an args struct since we were getting a
  complicated mixture of function arguments.
- Reworked device removal to generate this args struct so we can pass it into
  device_remove in order to find the correct device to remove.

v1->v2:
- Rework the first patch as it was wrong because we need it for seed devices.
- Fix another lockdep splat I uncovered while testing against seed devices to
  make sure I hadn't broken anything.

--- Original email ---

Hello,

The commit 87579e9b7d8d ("loop: use worker per cgroup instead of kworker")
enabled the use of workqueues for loopback devices, which brought with it
lockdep annotations for the workqueues for loopback devices.  This uncovered a
cascade of lockdep warnings because of how we mess with the block_device while
under the sb writers lock while doing the device removal.

The first patch seems innocuous but we have a lockdep_assert_held(&uuid_mutex)
in one of the helpers, which is why I have it first.  The code should never be
called which is why it is removed, but I'm removing it specifically to remove
confusion about the role of the uuid_mutex here.

The next 4 patches are to resolve the lockdep messages as they occur.  There are
several issues and I address them one at a time until we're no longer getting
lockdep warnings.

The final patch doesn't necessarily have to go in right away, it's just a
cleanup as I noticed we have a lot of duplicated code between the v1 and v2
device removal handling.  Thanks,

Josef

Anand Jain (2):
  btrfs: use num_device to check for the last surviving seed device
  btrfs: add comments for device counts in struct btrfs_fs_devices

Josef Bacik (4):
  btrfs: do not call close_fs_devices in btrfs_rm_device
  btrfs: handle device lookup with btrfs_dev_lookup_args
  btrfs: add a btrfs_get_dev_args_from_path helper
  btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls

 fs/btrfs/dev-replace.c |  18 ++--
 fs/btrfs/ioctl.c       |  80 ++++++++-------
 fs/btrfs/scrub.c       |   6 +-
 fs/btrfs/volumes.c     | 215 +++++++++++++++++++++++++++--------------
 fs/btrfs/volumes.h     |  40 +++++++-
 5 files changed, 238 insertions(+), 121 deletions(-)

-- 
2.26.3


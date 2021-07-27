Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E43D8062
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhG0VDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhG0VDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:44 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC309C08EACC
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 129so144991qkg.4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyDBLt+kfCY7tDDWtQkDU64nWIAKmy2il1nHpBYXvfI=;
        b=p2tBtqLRMatCVtqktAG4QfjHc8u2HyUlb/CDzxlTnI83ATTwMeMeNyx8Yt1m7PGeLm
         Z1kiywsIkVqrKL4V83QMmxwKNCA0c7WHvlXzqn7gTuhFFKBdbBxZ0E0dOZC6cSMmErUI
         D/GH5HBFn9g1ffSWgrfs1q+VfX6Cc0KNZOnTUoJc0u/iTojRrDnzeGzGSywxGK0SSJcG
         NNZhkQIf2VdNP8r/Zl8/SM+c4iqoQHxxUapOYaZB2EIfYR9LxYTGZm24eTWscHY7zJ6W
         ARB3mwmSVGl/zf9VZps7sAdksPTTJA2QFtfKec6aOrtlGR4v/R/WK/uEQQr9hvDnvDhb
         4tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyDBLt+kfCY7tDDWtQkDU64nWIAKmy2il1nHpBYXvfI=;
        b=AzU8AvV/aIhW90itH8TtIHapg1Ok2kN0ENU/qwbYDSv0wa7dTleUJmGEnaa4hvcWk/
         rbWqHFEtOTtgfaZanpeQdsX23K3Cd6Oze7xrHdoogiOKxWJZwTkPdVV0rzObwVhAdJPC
         mklDaciWls6mQ+10Hs9kPjjLwh1nQnRYsl5jLPa3leQp/qOTJNazLRL2gbc36V65jNwk
         jb4z63owwfk1+ZcBEmov0Hn/pbHjb3GCdnx2QRcTVBnMF6NJe94Jw5B+K379AqBuGKUL
         LnlWdQFd42MObmZ5tm9nuQb7NxP/sr9/3HubmwnhREa13UqL66PyDstlgpPrHoq2TKvN
         VGmg==
X-Gm-Message-State: AOAM532vF5UmAyhyeDOv8fkA9G1YAwTZGL+fkSu8vokIxsNID3vJyeaL
        pRBRPlFsWDd0YWCl47rPuqC+p18s/EDA1JHZ
X-Google-Smtp-Source: ABdhPJzV5drb31Dy1htrVHELpMUGJZwfv8ehGwMHDxoBp2vUd1/gZBt2dY7ctVHlZusroZMNzrw99A==
X-Received: by 2002:a37:9f8d:: with SMTP id i135mr23926132qke.296.1627419680740;
        Tue, 27 Jul 2021 14:01:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 197sm2270410qkn.64.2021.07.27.14.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:01:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/7] 
Date:   Tue, 27 Jul 2021 17:01:12 -0400
Message-Id: <cover.1627419595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (7):
  btrfs: do not call close_fs_devices in btrfs_rm_device
  btrfs: do not take the uuid_mutex in btrfs_rm_device
  btrfs: do not read super look for a device path
  btrfs: update the bdev time directly when closing
  btrfs: delay blkdev_put until after the device remove
  btrfs: unify common code for the v1 and v2 versions of device remove
  btrfs: do not take the device_list_mutex in clone_fs_devices

 fs/btrfs/ioctl.c   |  92 +++++++++++++++--------------------
 fs/btrfs/volumes.c | 118 ++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h |   3 +-
 3 files changed, 101 insertions(+), 112 deletions(-)

-- 
2.26.3


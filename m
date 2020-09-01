Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4FB25A0E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgIAVkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgIAVkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 17:40:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6550EC061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 14:40:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so3733qkj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yn+FxErRkQ0R6VazRGSOGKN7WBX+1VS0bHq+ek+Y2Y=;
        b=OgUMlyAF6TMnYLeTNls7cajG4D1mByd+JNUg74hKsrKgT5L/ivsY8NZi1lCyloaTpG
         5PfHXVkXQvPomn6TTyj1RVRpUHHKzHCrdZ79PmbRWM+zPCiobAm42MoOu6tBXq5KZTAV
         7Zf9edSPLRGNDzzVlghl/Z/EZ7hDkpsr9xz61JKDwCVrXuLjAax2zR5Xaiad5N5b4v/J
         nhCYhgpxMyHTN/+5QWfoXnurUk7CGSMMpfv1ciPPwdQ5gwb0LpFSt3tymQAwYD2UASPi
         gy2xrqDRdw8asBPD3XNW8TX36g7uyMu+Q6XQA4hy7QntcrNV6dtHfuML343d9G0ViKEi
         n/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yn+FxErRkQ0R6VazRGSOGKN7WBX+1VS0bHq+ek+Y2Y=;
        b=MwcG8yYph8H6BFwefVlIs69vYyGRkWVobxOt4znIS7tjR/fxzQzsuRZZVe1yZNommG
         rfVD0cUu9DOQGeQ63kZazxFf/9pTQTQMmSoHnm4OejE3qqD7oW0awx5KYwIUr4wheouw
         wvBO9QACZMuEFNpNoYJahb4i00XUdF/UB3fxtw/Te6hxfDp91HH6hyf5XVruwS+APcVq
         6EHHj1b2m2aHfvh6uNDSeJDace85z43zN+4jIhE78NN9V7/aEROet8tkIpZpLIMnPlmw
         mNKXP3EnKWv1EuL6bBiyq7/EuECL+FEtfqUISBjQiZbufo8+tOTc5YP7WKEah47SOmZm
         W4iA==
X-Gm-Message-State: AOAM532D+bKt1dxuGi5bZtzudYYu1DLx0Cf9hKIHQgK7z84X+j0Q3my8
        XiojvuCQvY2ZEoFvoSkrZU2ubfZUxsdP0IWs
X-Google-Smtp-Source: ABdhPJzUw5oHyOWL6mBznVKyXMobHt6fl9tBD6veQSE/VdY17LOFMnkw6T3D97USizb6sg344DROLw==
X-Received: by 2002:a37:9f48:: with SMTP id i69mr3841373qke.267.1598996439830;
        Tue, 01 Sep 2020 14:40:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18sm2826724qtu.69.2020.09.01.14.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:40:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4][v2] Lockdep fixes
Date:   Tue,  1 Sep 2020 17:40:34 -0400
Message-Id: <cover.1598996236.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Included the add_missing_dev patch in the series.
- Added a patch to kill the rcu protection for fs_info->space_info.
- Fixed the raid sysfs init stuff to be completely out of link_block_group, as
  it causes a lockdep splat with the rwsem conversion.

Hello,

These are the last two lockdep splats I'm able to see in my testing.  We have
like 4 variations of the same lockdep splat that's addressed by 

btrfs: do not create raid sysfs entries under chunk_mutex

Basically this particular dependency pulls in the kernfs_mutex under the
chunk_mutex, and so we have like 4 issues in github with slightly different
splats, but are all fixed by that fix.  With these two patches (and the one I
sent the other day for add_missing_dev) I haven't hit any lockdep splats in 6
runs of xfstests on 3 different VMs in the last 12 hours.  That means it should
take Dave at least 2 runs before he hits a new one.  Thanks,

Josef Bacik (4):
  btrfs: fix lockdep splat in add_missing_dev
  btrfs: init sysfs for devices outside of the chunk_mutex
  btrfs: kill the rcu protection for fs_info->space_info
  btrfs: do not create raid sysfs entries under any locks

 fs/btrfs/block-group.c | 47 ++++++++++++++++++++++++------------------
 fs/btrfs/ioctl.c       | 10 ++-------
 fs/btrfs/space-info.c  | 14 ++++---------
 fs/btrfs/super.c       |  5 +----
 fs/btrfs/sysfs.c       | 25 ++++++++++++++++++++--
 fs/btrfs/volumes.c     | 17 ++++++++++++---
 6 files changed, 71 insertions(+), 47 deletions(-)

-- 
2.26.2


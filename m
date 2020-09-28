Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B727B489
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1SfB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1SfA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:35:00 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402AC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j10so961789qvk.11
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P71gv4zMbnuYsjyEHPDm8yd9/pzRKapfXwyNh//Ac1A=;
        b=QEjAR58qL4ylbwjBOuaVUCF5m8sz+DFe4hSQM+oqXDdBcuyb/39cjxE7KWxQKu0UY0
         OizYVVCxcPI3YI49ZN5Q2Lr9v524BrTmAq5mjnYFkhzpD++j/bW66w/PfgHFFIvriIqy
         s5vKvGLKr3rjrID1nBEcbNlbf6bb0LJblFgVtsHLLZ+1AO9BejmotjaN396NySU6X/Bw
         JBe75vA/2z8+UVBeJA8WfFuMFJP1HZprcoM+HS/YktrFHVj40p51AD15qchJJQZFuX1f
         SPP/qoBEde/k83oLCyfXRNfBxDqgsVcBZidVDP53KZ4k2FcdH9Wovonse6Zip0ds1Shq
         CgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P71gv4zMbnuYsjyEHPDm8yd9/pzRKapfXwyNh//Ac1A=;
        b=ransQwF7MDqKQ0h4nJXVA58pQ6VPfDjyaB3XyzUnpcgcZbW8HU/n9LcY5GxG7hDnv+
         M0iQMJqM3zTJXvUyA3AeCGivRyEL6UYzPQE/0Ts+v8cTMclwMnW8jJrjzz26/OPh7Kj2
         nvwXiakpX5QpsXThlY1w/Nbt4etw/mC2EB4GTn0vzES7cv8wfT7eQuKtlFNwcMzqKY7L
         hxK/mUOGHO2Eav+py6oHru5qzxF45+jSJxlatQnG839853nmso6da+LXdKDe8vO46Xr+
         BZX9o2IGm3HtKMeeqacpP32F/d5kOEQc/kmz4nGVlBVNS5Gp4Fmv0SWv0F87nAIbYq+w
         QUPw==
X-Gm-Message-State: AOAM5301GyKNtoqf+EE5VLyRbqEFHJofHUM7jlpiLyunRvNM/axEYFGE
        jqpVh3I1Xzp0kHWt1juSBqRiEm09S7nddvm5
X-Google-Smtp-Source: ABdhPJz0h3PkoOXKL8PIf/8r4MrM+f4CnZ4J265gEGJrFjpZKok7F+2Ugrhswbmejc0ZrMvAO7U9vw==
X-Received: by 2002:a0c:aee0:: with SMTP id n32mr871921qvd.7.1601318099576;
        Mon, 28 Sep 2020 11:34:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k26sm2320722qtf.35.2020.09.28.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:34:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/5] New rescue mount options
Date:   Mon, 28 Sep 2020 14:34:52 -0400
Message-Id: <cover.1601318001.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Add Qu's reviewed-bys.
- Addressed the comment about dev extent verification for ignorebadroots.

Hello,

This is the next version of my rescue=all patches, this time broken up in to a
few discrete patches, with some cleanups as well.  I have a PR for the xfstest
that exercises these options, it can be found here

  https://github.com/btrfs/fstests/pull/35

This is the same idea as the previous versions, except I've made a mechanical
change.  Instead we have rescue=ignorebadroots, which ignores any global roots
that we may not be able to read.  We will still fail to mount if thinks like the
chunk root or the tree root are corrupt, but this will allow us to mount read
only if the extent root or csum root are completely hosed.

I've added a new patch this go around, rescue=ignoredatacsums.  Somebody had
indicated that they would prefer that the original rescue=all allowed us to
continue to read csums if the root was still intact.  In order to handle that
usecase that's what you get with rescue=ignorebadroots, however if your csum
tree is corrupt in the middle of the tree you could still end up with problems.
Thus we have rescue=ignoredatacsums which will completely disable the csum tree
as well.

And finally we have rescue=all, which simply enables ignoredatacsums,
ignorebadroots, and notreelogreplay.  We need an easy catch-all option for
distros to fallback on to get users the highest probability of being able to
recover their data, so we will use rescue=all to turn on all the fanciest rescue
options that we have, and then use the discrete options for more fine grained
recovery.  Thanks,

Josef

Josef Bacik (5):
  btrfs: unify the ro checking for mount options
  btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
  btrfs: introduce rescue=ignorebadroots
  btrfs: introduce rescue=ignoredatacsums
  btrfs: introduce rescue=all

 fs/btrfs/block-group.c | 48 +++++++++++++++++++++++++++
 fs/btrfs/block-rsv.c   |  8 +++++
 fs/btrfs/compression.c | 17 ++++------
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     | 74 +++++++++++++++++++++++++++---------------
 fs/btrfs/file-item.c   |  4 +++
 fs/btrfs/inode.c       | 18 +++++++---
 fs/btrfs/super.c       | 49 ++++++++++++++++++++++++----
 fs/btrfs/volumes.c     | 13 ++++++++
 9 files changed, 185 insertions(+), 48 deletions(-)

-- 
2.26.2


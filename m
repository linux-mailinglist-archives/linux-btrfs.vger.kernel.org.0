Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F974289925
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgJIUJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391223AbgJIUIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:24 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1166C0613E5
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id b19so5355594qvm.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+M3+ROHRz9CKEUDJ5h8a7fwXqKecN9ftIY2W3KiD8U=;
        b=NEAyJAYcmFGJ9TmsUW99B4wyr5c3JevI/PzlJbF+x3b58EwZRWcRQv8AgKKX0uB+a0
         xBUomj4B1FxbjUvi09ilGXEisdHOcpdeGHB9Kms1lNtsNEUlKGacmt7Fo9dBGzbfHGeL
         Gxn95x4xJas+V8iI5IL5m8a0f2Q+Eiv6bL54M1zeFcil5Xr02+U4fKEeCuHFlFjJmRbF
         CYUeaBk8Y2qTkg70AYIYRK1cpZVtcqQ8PqvD3Ckmr8vmL0cCWNwoqSUKubIcXAZ360sM
         xYDWYt1BI7v5YjNiqp1bQ+gdJkMNogOH25JhN31kB5pmN08CN7LxhCdjD4QtsqivkaNx
         onEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+M3+ROHRz9CKEUDJ5h8a7fwXqKecN9ftIY2W3KiD8U=;
        b=PyYKlbsoKEmM1ELgjr4h5ZKumoMjIfHaI6ltEDCed77Dd6yIWgzQLm/JRyRCY3p1wW
         AyLOu8YwQYjskfNTKUln+1whpW4XPo/+8k2d2TCbMTRmRbd6OqO+jU4L7bTiQWUM25vA
         ltE7Sbs5EECM73nxZLDZEGNzGrJAGKpN5Su4vHyIdnHDth/Ci9mO4KJJp1YytjZUyMkS
         +rDJHDGcxdfkpxZpJp+7mlplOjnztVZD3mMHlwBIghijC8rJPGJuUw2EgvfOr+edvt5i
         JlZl6mQj6zk8p3sWawZIbFD9ub7mHIxjkVCfcYEaSr42KINFIrB+am8UO+pDDPKsIkHD
         Q44w==
X-Gm-Message-State: AOAM531OLLIKBCk3pltw6W+9qhH4jXah9/sCAvwmTwhEocUsaoEP3Vxl
        YpoE7DmQUmK/Z2adoa+tX5OobVCQb6bqFbaK
X-Google-Smtp-Source: ABdhPJzWGtSquA1/0CaVWmOMlJc/asKiS6G9JQ1fMPi93cF2N7kU5fVMhNxl+Un32Ms7UOCvMqtbuQ==
X-Received: by 2002:a0c:9d03:: with SMTP id m3mr14317368qvf.54.1602274042486;
        Fri, 09 Oct 2020 13:07:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s22sm6974559qtq.78.2020.10.09.13.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/8] New rescue mount options
Date:   Fri,  9 Oct 2020 16:07:12 -0400
Message-Id: <cover.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Re-worked the showmount format for rescue= options, so it's in the format of
  rescue=option1:option2:option3.
- Added aliases for ignore* with just a i<opt>.
- Added a sysfs file to spit out supported rescue options.
- Fixed where we weren't spitting out rescue=usebackuproot in showmount.
- The only thing I didn't do was the no/^ options, since that's trickier and
  puts us in a murky place for some things (nonologreplay).

v1->v2:
- Add Qu's reviewed-bys.
- Addressed the comment about dev extent verification for ignorebadroots.

--- Original email ---
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

Josef Bacik (8):
  btrfs: unify the ro checking for mount options
  btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
  btrfs: add a supported_rescue_options file to sysfs
  btrfs: add a helper to print out rescue= options
  btrfs: show rescue=usebackuproot in /proc/mounts
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
 fs/btrfs/super.c       | 65 ++++++++++++++++++++++++++++++++-----
 fs/btrfs/sysfs.c       | 25 ++++++++++++++
 fs/btrfs/volumes.c     | 13 ++++++++
 10 files changed, 224 insertions(+), 50 deletions(-)

-- 
2.26.2


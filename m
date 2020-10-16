Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA2290856
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408066AbgJPP3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407581AbgJPP3X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E4C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:23 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 188so2195433qkk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4B0L+nE2DMaro3z7WuOIWBAsQ/OwbBzBO9NH/3Sx3E=;
        b=bbHkqD26+g143soGV4uc7YZ1+HFtZI9qfEfdpbFY72YTz31f63HIq/W0lRGSVzCGOS
         7cW2bXWKgrPVLxY5WbJT59Gwdo2vwbBT4WOMA1CGW9M/gmJfwv4UGqLI7tc4Wkwzh9fa
         TL9dDSZyKGMToKmMtAd4dcRmH64HFxf2dDaAdY6tXfQUtZ7Kex3zBOHi6Wj/w3FbBo8C
         QbgnAXCegeHKiWskONm8W098GbSwf08s8xzFq6llU7C5I6pfWkeM9XE+ecO+evZCVrsw
         3F1IpWHxBP6Pet0PVRkb9WNkAyIL91FRoBRgbHpt71Sq0mpKnGnaHXnk2oJvFpFrtFek
         kLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4B0L+nE2DMaro3z7WuOIWBAsQ/OwbBzBO9NH/3Sx3E=;
        b=e88e0woJqY/sVQfaUBlk5miOvu6L8xCa6XQb7Xnf3gsDuzBZ03iOaCO+nGRNA6X9Re
         mWwkebOQHFZ/n3nbnQURYEEEAKOo6Vr09DSRfQTItjbqbD7uU56Yne4mL4Tt9meFEYtD
         YTyeBmhAK2pRKnzw17T4r+CnAFRLs5k/Nbl3wYi8NCT6BUD2wPS9iIYhy8MQeZOF4ST4
         iUrdmPzcUSRJKdG+M3IS0YUIxJBaJy2cZnApwD/oPL2E4KJbE3/t22iNHRpceYBTzpdL
         N8g3PV+wkS/VK0sNJOaOggK7/RSAr0eViuuGNjAmw3gmFJt3nvtfAevr3Oy9r20ULJgZ
         m6AQ==
X-Gm-Message-State: AOAM532PFI30esXnFQ2tLct3v/+7pZzE3aOJqRPJ1k1BsPYFybbHw/3C
        OOYoz7S/zdJ3GwOSjk3JApaXsffW7BBDyrck
X-Google-Smtp-Source: ABdhPJxFNLSmsCLTeTsSgNnsiQKL/hEYxX1kO4DTeXqbU/4y90aZi5e+DM2mUPa06Jo4GuHUF12cag==
X-Received: by 2002:a05:620a:2156:: with SMTP id m22mr4234249qkm.54.1602862161847;
        Fri, 16 Oct 2020 08:29:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q65sm1018493qkd.18.2020.10.16.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/8] New rescue mount options
Date:   Fri, 16 Oct 2020 11:29:12 -0400
Message-Id: <cover.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- Add more reviewed-bys.
- Addressed Johannes's comment about the helper for spitting out the rescue
  options in showmount.

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
 fs/btrfs/super.c       | 68 +++++++++++++++++++++++++++++++++-----
 fs/btrfs/sysfs.c       | 25 ++++++++++++++
 fs/btrfs/volumes.c     | 13 ++++++++
 10 files changed, 228 insertions(+), 49 deletions(-)

-- 
2.26.2


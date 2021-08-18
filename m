Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502B63F0D5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhHRVeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHRVeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47735C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d9so2767217qty.12
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORj1Sq2X2gYxJZ5KLbc/QIfatK18DHd+rRZ57wJURPI=;
        b=DQ9ac1Lpz2Okn16wjbIzzw2X3iOsm0dBtqCmaANKbZ+n47DHdvkCUz3W/W2bY/x/bx
         uLsZUAjw7Tk3jswZlhvLaK4bI2X9GN9cucvxcZli4OCd7ivcSjZ1UJErAc9S/Tc01vWL
         nJP/W86ffCPqd0Hi5AlhwyoDjmU0hZw1JFKbxctcC4uzwIdwzZAfSw4pQSdeIjjrC8Of
         P41IUmiaqwSxUbXQgfeDrNvq9qqyyXw5eJSBns4zSQSvq6n5mcaSU0QCluGGRpvOBFh8
         FQdPtqzqxNVQ4RLVnZTjiGNnJNQKip7gRewxgSl1lTyJ6U+G2g0NpYIntRXhKWdskgun
         nOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORj1Sq2X2gYxJZ5KLbc/QIfatK18DHd+rRZ57wJURPI=;
        b=HLCIHW7Wt5RsUEF0LAuVf2BUNLsWkbi3dTZBWSJfdPuPrYLwzGe1CinlCMPnnWis1k
         l8iR9Mavj1iS6tJ1jNePmwrCqavPGCABzqPdHGDEYuR+NzdMTFgyCqbhqrL4a03ICQln
         52Wa0vJfVmIbUZENRNY4qpkWuIp1ceDCKvvUnTcRMlX4TubnX66v/TVkGOc/gIKHOax5
         mUVgIe6CEHwDy2qHzY/y8WnA/TJalkLuiTBFF65lc4keOOqOQKHNuCsvDe8kcUFGs67G
         xTZr41y1Rf56AKXfr3HTC+SLwG21tsr/51PqGBsYkBNjv+N/uFonEMFRKrS0X+t5LSUZ
         g4FA==
X-Gm-Message-State: AOAM5306XDUQOGKwdQgPfEXWGRob3i4pnfY/iosKwTUoQQE7CK3VOQzE
        aj4r4yiEqoUkDBhU9fbi3WY+/RsUnmIztg==
X-Google-Smtp-Source: ABdhPJxbdnsHaKTbKsbizFIf+WqxkqhJQQZU0CZoNIcDHrg8a50WzP4AArBpqJLzGt6un+eyVif6Ag==
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr9649011qtx.110.1629322406816;
        Wed, 18 Aug 2021 14:33:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x29sm488010qtv.74.2021.08.18.14.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/12] btrfs-progs: make check handle invalid bg items
Date:   Wed, 18 Aug 2021 17:33:12 -0400
Message-Id: <cover.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Discovered that we also don't check bytes_super in the superblock, add that
  checking and repair ability since it's coupled with the block group used
  repair.
- Discovered that we haven't actually been setting --mode=lowmem for the initial
  image check if we do make test-check-lowmem, we only do it after the repair.
  Fixed this.
- Now that we're properly testing error detection in all of the test cases, I
  found 3 problems with the --mode=lowmem mode, one infinite loop and two places
  we weren't properly propagating the error code up to the user.
- My super repair thing tripped a case where we wouldn't clean up properly for
  unaligned extent records, fixed this as well.
- Add another test image for the corrupted super bytes.
- Realize that you need a special .lowmem_repairable file in order for the
  lowmem repair code to run against images, so did that for both testcases.

--- Original email ---
Hello,

While writing code for extent tree v2 I noticed that I was generating a fs with
an invalid block group ->used value.  However fsck wasn't catching this, because
we don't actuall check the used value of the block group items in normal mode.
lowmem mode does this properly thankfully, so this only needs to be added to the
normal fsck mode.

I've added code to btrfs-corrupt-block to generate the corrupt image I need for
the test case.  Then of course the actual patch to detect and fix the problem.
Thanks,

Josef

Josef Bacik (12):
  btrfs-progs: fix running lowmem check tests
  btrfs-progs: do not infinite loop on corrupt keys with lowmem mode
  btrfs-progs: propagate fs root errors in lowmem mode
  btrfs-progs: propagate extent item errors in lowmem mode
  btrfs-progs: do not double add unaligned extent records
  btrfs-progs: add the ability to corrupt block group items
  btrfs-progs: add the ability to corrupt fields of the super block
  btrfs-progs: make check detect and fix invalid used for block groups
  btrfs-progs: make check detect and fix problems with super_bytes_used
  btrfs-progs: check btrfs_super_used in lowmem check
  btrfs-progs: add a test image with a corrupt block group item
  btrfs-progs: add a test image with an invalid super bytes_used

 btrfs-corrupt-block.c                         | 172 +++++++++++++++++-
 check/common.h                                |   5 +
 check/main.c                                  | 124 ++++++++++++-
 check/mode-lowmem.c                           |  25 ++-
 check/mode-lowmem.h                           |   1 +
 tests/common                                  |   5 +-
 .../.lowmem_repairable                        |   0
 .../default.img.xz                            | Bin 0 -> 1036 bytes
 .../.lowmem_repairable                        |   0
 .../default.img.xz                            | Bin 0 -> 1060 bytes
 10 files changed, 322 insertions(+), 10 deletions(-)
 create mode 100644 tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable
 create mode 100644 tests/fsck-tests/050-invalid-block-group-used/default.img.xz
 create mode 100644 tests/fsck-tests/051-invalid-super-bytes-used/.lowmem_repairable
 create mode 100644 tests/fsck-tests/051-invalid-super-bytes-used/default.img.xz

-- 
2.26.3


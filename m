Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AA84736B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhLMVrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 16:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhLMVrQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 16:47:16 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B2CC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:47:16 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z9so16655977qtj.9
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBHtpDPyeliGSu3ayMZfe4bPpYAFkUGUBX1k7vqJz2Q=;
        b=xJae8RTwNWVAebyv7w4ubFSmxvIhIg3QB0LmJeV2W6fXCnvPil04V8BorAdAsWDVxm
         JS6LU2zUKNYzxSYTKz8GlwgSfv2+f05MaQ6HRKmuPBUSZHYDbtBwBLIi/nyUC0Y+TZBr
         lajvgachAZTwlgxqp93OkSvRxbiitN8ggxVdzj7jIvLm1g6Jy1w5D34Wbwm0VxX2P3yX
         KQ1nzbiIDUBrzdfTq6YM2x7omTfxS1nNOKGOk71lpMCBxNEbPiJ+NRRKtYBDLc9ilMoR
         +dbaj4dl+bd1SmPrBkT4ju18cZEmTaFcIvAqfewCsI7i/Lpmpdk4wNOGqZjYU4PNLUCq
         sQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBHtpDPyeliGSu3ayMZfe4bPpYAFkUGUBX1k7vqJz2Q=;
        b=KmggWx/9uhyFi4nno7U9cfk/w1D+nbceKB5hQBI8AWwzGtChPYCN+rwccnuC6M34FI
         ypKRx+vywKavYw0iRd8Q8PU3LfjwG5Dh1fEJ5nnV0tKI8o0yYpcszzPPTX0p3eNBLZPx
         BkRdEtUjFahKmCRL0QWdiH98nUmQvYZRRotWNDImSf37pvMNoNBWFEut7O4Ypp4JXSt+
         aKdCIrzBAFOMufUaQc2JUlTI8XBcoPNH2Yl4AZEpuX2ND4gj2JHYMZU4J5Y7omlddBfR
         5Ehfi7PEPeXmwf0/uvhUvGcH4nRWyCklNuaBwPXGSYojsJgMY7cD43k0ZzsSlz0bc8oX
         F30w==
X-Gm-Message-State: AOAM533KRilHlxMlCJ0Vj6AvTSa8d3cHdz37XECvNl7XCqnJQFsgGHb/
        /yr6PZHB3h5rn+iBAwu6HDEfwSbmnGq/GA==
X-Google-Smtp-Source: ABdhPJxL8j98lX9K9D6ibsaQNn/b+r21Vu5ZOtlR1jCEDCZP3d9wFGBeTGn2wE4dts1XPveFp0lTvQ==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr1209874qta.437.1639432034784;
        Mon, 13 Dec 2021 13:47:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r16sm6810433qkp.42.2021.12.13.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:47:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs-progs: handle orphan directories properly
Date:   Mon, 13 Dec 2021 16:47:10 -0500
Message-Id: <cover.1639431951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- use "is_orphan" not "has_orphan_item" in the mode-lowmem code.  Somehow the
  compiler didn't warn me of this until I switched to a different branch.

--- Original email ---
Hello,

While implementing the garbage collection tree I started getting btrfsck errors
when a test would do rm -rf DIRECTORY and then immediately unmount.  This is
because we stop processing GC items during umount, and thus we left the
directory with an nlink == 0 and all of its children in the fs tree.

However this isn't a problem with just the GC tree, we can have this happen if
we fail to do the eviction work at evict time, and we leave the orphan entry in
place on disk.  btrfsck properly ignores problems with inodes that have orphan
items, except for directory inodes.

Fix this by making sure we don't add any backrefs we find from directory inodes
that we've find the inode item for and have an nlink == 0.

I generated a test image for this by simply skipping the
btrfs_truncate_inode_items() work in evict in a kernel and rm -rf'ing a
directory on a test file system.

With this patch both make test-check and make test-check-lowmem pass all the
tests, including the new testcase.  Thanks,

Josef

Josef Bacik (2):
  btrfs-progs: handle orphan directories properly
  btrfs-progs: add a test to check orphaned directories

 check/main.c                                  |  15 ++++++++++++-
 check/mode-lowmem.c                           |   6 ++++--
 .../052-orphan-directory/default.img.xz       | Bin 0 -> 1432 bytes
 tests/fsck-tests/052-orphan-directory/test.sh |  20 ++++++++++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 tests/fsck-tests/052-orphan-directory/default.img.xz
 create mode 100755 tests/fsck-tests/052-orphan-directory/test.sh

-- 
2.26.3


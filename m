Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43540461FDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355017AbhK2TI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 14:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355395AbhK2TG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 14:06:56 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F519C05290B
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 07:28:01 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id p4so23226953qkm.7
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 07:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DbWHmbmXarrs2Ia4ISlBVbevzQ+pduAziZH1U8rQ2M=;
        b=mUw9buCXdia1Mf+2eQU+eB6c63QyiYKhcX7wJJTL7QGOytxvJLiDpgb76Xt9gOSbJo
         /SiEPNcf6cY52QPChwM8pYkYyAdlov6vpXqIID1qFN0UDuMoy2x8tL6xLzln3uuIb1Ta
         1EUTEGfSXCVzSRHUafh478gnSJ4Oa+yvzNAejJFnkjiRs0EQ4nWM+52YSpgxLsTqrl94
         caiuDnRlMwKf5tRpR7H3HO+4olM+yRvuc7GF/hFPx+o5buV/gL5hOiDX9gSB9hDTmi0/
         CAOdkpfz1QU6bKjZ8HwXrZ3z2MO7uKSadS435M21/WVYOBgEG7oS/uNucAfphZYy52on
         f6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DbWHmbmXarrs2Ia4ISlBVbevzQ+pduAziZH1U8rQ2M=;
        b=Ekkpl5slcf3JWCuMRt7W6PlBL59DkzROZHfQm18PueyNg3gEpmpj2OdRxNtKzvO7kk
         Krwy8men0z/e3yG5YMzh+/0rHl+j7rm436RMIyX2DZH6guSeCGptzAsdQ4ORiOISp+pm
         gF+BoAjczq4A5JYYBXoyNQdQrYV9Z/ZEeFAy7/zyBn/Sv7opO1aOVcH7WSftVM1G3Fl9
         4oyDhPuZ7QBbdZNVxsF05uCftuGpHjIkDSBfhqPdSgJ8KhKquI0zVqav0Hamy69WlJQB
         602YLO3KShVeDZUd3h28P2QpbzsRA0q4Ik8xPLS5ut7e6kcbtxkDefF0v8Zx7XqMZ40s
         6A3Q==
X-Gm-Message-State: AOAM530o0shfNdAobdeFSqJlR79+NVQeOcYNn0VI+pFznPeyCg3tQdMt
        Lt4i5MSdu2oM1wn381bkCs33Su0kvhkjrA==
X-Google-Smtp-Source: ABdhPJw2YdjJMv2dvvfuW1C9IDs7zxPSZzZ6lPzxrr28RHM6dmZ6FXVraNifuIi0YN/ABK4JMx0P1Q==
X-Received: by 2002:a37:6295:: with SMTP id w143mr38936397qkb.161.1638199679989;
        Mon, 29 Nov 2021 07:27:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b2sm8543345qtg.88.2021.11.29.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:27:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/156: require no compress
Date:   Mon, 29 Nov 2021 10:27:58 -0500
Message-Id: <f4ac86cbf2dafc8f39bfc221201cc349cb430844.1638199667.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test fails on my overnight tests that use zlib, because the data
usage doesn't get high enough for the fstrim math to work out.

We are testing that fstrim properly trims the while file system when the
block groups are relocated to > total_bytes.  However it tries to
validate this by making sure that we trim > total_bytes / 2, which we
won't with compression on because we won't actually allocate total_bytes
/ 2.  The free extents that are trimmed in the first go around don't get
trimmed the second time.  With some compression algorithms we move the
free extents around enough that they'll get re-trimmed and thus pass,
but others it won't work out properly.  Simply require that we don't
have compression enabled so that the results are consistent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/156 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/btrfs/156 b/tests/btrfs/156
index 11bf4638..4f323f37 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -27,6 +27,13 @@ _supported_fs btrfs
 _require_scratch
 _require_fstrim
 
+# We need the allocated space to actually use that amount so the trim amount
+# comes out correctly.  Because we mark free extents as TRIMMED we won't trim
+# the free extents on the second fstrim and thus we'll get a trimmed bytes at <
+# half of the device if we have compression enabled, even though fs trim did the
+# correct thing.
+_require_no_compress
+
 # 1024fs size
 fs_size=$((1024 * 1024 * 1024))
 
-- 
2.26.3


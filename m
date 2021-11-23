Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB445A65C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 16:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhKWPRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 10:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhKWPRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 10:17:34 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE6C061714
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 07:14:26 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v22so20104296qtx.8
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfmuL2rY+y7qUOGLyu4QCPd8HSrEHOjpKavwAQDrGfo=;
        b=FA9122zacvuVvKLT6YPTlqWKUllXFigCcfkgePv0mjq5EFu26Khi4ggNXN5herShsT
         m9/RF6pv4LDbeppg/5d2TnGk0xpAIzF7FrB5yEp4o/7UynYkI1m8Fz9DIvjFSrvdUj2U
         qtm1DZnhRqncvkX2hvftV0qiHdLj2IbY1/FDuMcIN2gzJ5zQPemzHvqa5zpCO1h35C9K
         doOolBub7U0yNBer1jbhlroCRUr31f6fEMHA/1PnFmTKmDKYOVheFsGHfvLo95SV3hPH
         Kqi4hiaHS5lenCu8Zw7xE4ms6sCtcEBO+L5Km2Mr4/mhy8nx8hiOdzAe2h73++809jLH
         DSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfmuL2rY+y7qUOGLyu4QCPd8HSrEHOjpKavwAQDrGfo=;
        b=cNPtB9+qf3qG8unvjRQP4x/5rNsr1MeNsO5h/C0GO3gUE/OowxpuGjCVT0gapi+y4L
         d08wcpU3mkpNRLErhWZ2L/S4YBewzSYdea6rNYG4nkfRIWHNql/qWL6lwmieZeVFcGFI
         Li8qMYw2j8W3IisNRxSrW++C40jXAN+LaKnrVQlWgADgqbG58fMTGf5NMDgOLRbwhf38
         Br4+LJSt1aGsIf9DT0qI9nEOBN69BZDSO4k7SSv1WLsbQDYqYqAvrG1xh3Xtd44WNk5y
         d3bFzpfrEPdzCkVyzTyQgwOH0MqycgiSfehj4k/oxu8Ipq1fXZvg5yn7heArD1bL9ZKo
         T1Sg==
X-Gm-Message-State: AOAM533BVDQgxzp9pMvSvQGpbFr+rPZPS+lLyuHRsrs0g98fM12wQNZm
        yiYc8R3BKBssqsKRbtRI50ZhnPye/U1bgg==
X-Google-Smtp-Source: ABdhPJwFQK9BCy1k1os3P4TWfGHAMQC4fNUehv0q65/H3i2FTOjN2+upRPkMZ0nj8sydZOfDg0dO9A==
X-Received: by 2002:ac8:58d0:: with SMTP id u16mr7252710qta.150.1637680465594;
        Tue, 23 Nov 2021 07:14:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z10sm6295325qtw.71.2021.11.23.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:14:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/274: require no compress
Date:   Tue, 23 Nov 2021 10:14:23 -0500
Message-Id: <4360f78499ffdb15a1dfff9b9647c144842995b3.1637680452.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We hit spurious errors with generic/274 with compression on because we
attempt to fill up the disk with small writes, and these writes end up
taking up metadata space instead of data space.  Thus when we go to
write into the preallocated area we get an ENOSPC, but from the metadata
side and not the data side.  Simply skip this test if we have
compression enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/274 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/274 b/tests/generic/274
index 43fc2d3e..8c0e420e 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -30,6 +30,10 @@ _supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 
+# Compression can exhaust metadata space here for btrfs and cause spurious
+# failurs because we hit a metadata ENOSPC, skip if we have compression enabled
+_require_no_compress
+
 echo "------------------------------"
 echo "preallocation test"
 echo "------------------------------"
-- 
2.26.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5609E8F353
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfHOS1D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 14:27:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40973 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfHOS1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 14:27:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so3313064qtj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOubM/Y9XONiB9v1608aZPxTWneDeIuizdk2L2LgSg8=;
        b=XJynwpJJbsJvejMe0VyFcGZZxPTzmhNv9Df14BcjQaN3aPkLQIwwDO5OC3Z0DvzBlH
         yKc1tfDapx7i+BN7Sbwv0ODqfUIcRk1G0NUQdTnfka3+SZl/31Mb+SNGhYJSM5TUKMOx
         j/DvlQl8I1eZlKFgLL6F8+Nco/aheJD0xvq4IjGE+EM5fb3eGm/FR86QgrixeFlSO0GX
         pgVRvNzWDReXybwneoZQ9/AKEBPHZfyzgeh66rfeEY1ORk7Ru5PPvgDcy1qhtX4cZl3U
         5R3F4rZ1kuYq8QMB/FdfH9qWtX3JpvOTprAFVrDcDD17r0+I/k0ESOQ4PnCrKgoqnbZa
         2eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOubM/Y9XONiB9v1608aZPxTWneDeIuizdk2L2LgSg8=;
        b=IUE3pHvy5czE5SbLDNmDqB8I1F+byPfLKsaTRv8Vv2HFlPaNY2kTD4Gnos/lhJLvT7
         bY3Oh/5e5cQ8nFqgEkhtj4UxUhQVcswgLReqwQG7c/O9pw3xpf79vD8x6fLHyVUXk/RE
         bxNxPB3SY8NmY5e45mJgCnJNicuWk1zZjLUK93WoyTQPbydROYU/t0Yh+K4LQHcP/xNU
         mlWgcUgno2Rp1/RoRXUurCmsXRh04CapkwVNPqiw+M5EoIJFrSrZTCmStzN5eslBk83v
         CgLXPLF0oJoTjspuy/qAtUu/4cgKMFpuniF5JUKXU9wT2FoykH9Nw5jLGWqapbLtX7ql
         KA/Q==
X-Gm-Message-State: APjAAAX8W+CEQUWlrAJTIF/ZmzRW8lGrUJjYv98OjKa8u68fdJPRNorH
        8FWZB6B5U/8Li352vECk2RyahRHqLRCisg==
X-Google-Smtp-Source: APXvYqyx1qWSuxMCsU1PG4NrJOguKooTyh9oFhBHXAdPIRxLyKlmYAuB7DCo/KYTO7FNTX9Fhr7MSg==
X-Received: by 2002:ac8:2646:: with SMTP id v6mr5174548qtv.205.1565893621734;
        Thu, 15 Aug 2019 11:27:01 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d9sm1802775qke.136.2019.08.15.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 11:27:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: generic/500 doesn't work for btrfs
Date:   Thu, 15 Aug 2019 14:26:59 -0400
Message-Id: <20190815182659.27875-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs does COW, so when we unlink the file we need to update metadata
and write it to a new location, which we can't do because the thinp is
full.  This results in an EIO during a metadata write, which makes us
flip read only, thus making it impossible to fstrim the fs.  Just make
it so we skip this test for btrfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/500 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/generic/500 b/tests/generic/500
index 201d8b9f..5cd7126f 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -49,6 +49,12 @@ _supported_os Linux
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
+# The unlink below will result in new metadata blocks for btrfs because of CoW,
+# and since we've filled the thinp device it'll return EIO, which will make
+# btrfs flip read only, making it fail this test when it just won't work right
+# for us in the first place.
+test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"
+
 # Require underlying device support discard
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-- 
2.21.0


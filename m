Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B99459091
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhKVOyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 09:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbhKVOyc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 09:54:32 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F8C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 06:51:25 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id g28so18326935qkk.9
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zm88oZ31Ju1jvLGPudw+hes7xMfRixZjvb4QymHeM04=;
        b=6UsxRfdza79YOHvC9KH7bGmGS+uVbCZBIFLDHPOAapSQJi1K/w+7E0aFBUq1v4zNCt
         CDw/ENsB0KHSnEw+p/xjc9zx9gLctk8ovgzMTZL4bCToFYi0ccrs69zyFsusQQp/vg3/
         LrEA2yhxutrw+gQkQM2niabRsS4N98zmYq/Q3PwmymgyJzvicg3CqsFv5Egh/3Y7Tdv9
         r7QeMi3oWKHiz39q8pfwqFdSUA1Lpcs0YB8cGVGVoYspU/HWPt+Cjx4Sb3EUhZ+DL1SA
         cDXTRgb6YzSuq3ybfhw6GDmUDO6Z+M47vW30CBh5SAKZEePSj7KMJohf1E3FG6HKdKft
         91ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zm88oZ31Ju1jvLGPudw+hes7xMfRixZjvb4QymHeM04=;
        b=e6UQATq2CTCADcVAg9y3JRoEtWt+9hMUUQMagDjcR2oqnRPjoH9gNMbva6ElT0aWTP
         Qr9RTbo7BhNZSZ9rWuXB6tVTMO7+OAgoMaZKA04y1zazbtvKC6rR/qZvugECipATa6om
         pW3VXCUUpBke79708g5QnybGE//Qczh/UXmEFVol2Qp/YeuqpkxvTOoATbnzqhKiVVwk
         1VfKyP23urQR271sKsfl0NEoVDdMszdMsnT+A5cVXRHpkMlB1Zoxj10RG0+b9mNo9lGz
         r9Z0aG1tMFZ6/pRjpO5nzjZcbxNDSk/FZbOrN5c1b+6XxYaN85Nc8K+jeguLz2FfFiR2
         Wa3Q==
X-Gm-Message-State: AOAM531zAdn1RW5SIL6UJigEUKkUW9aZPsu7oOPk8GWHhemMNGhRbYq6
        bOzpVZ3DQbjbpdu3YWDHPEvdafw0CXkwUA==
X-Google-Smtp-Source: ABdhPJxO8lkju3AcV14foUdQK0Ey/Mf1gw32Vr/jLnOS7noCnYThxtQ8w4LOvFkv7HVe5xCOPJPdZA==
X-Received: by 2002:a05:620a:254c:: with SMTP id s12mr49143373qko.36.1637592684666;
        Mon, 22 Nov 2021 06:51:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u18sm4792767qki.69.2021.11.22.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:51:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: redirect device replace output to $seqres.full
Date:   Mon, 22 Nov 2021 09:51:23 -0500
Message-Id: <46ea4af6536a155eb9658c24fd9394590ecd1ffa.1637592664.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs utils are printing a status message about TRIM'ing device on
replace and this is throwing off the golden output, redirect stdout from
'device replace start' to $seqres.full so we don't get false negatives.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/176 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 9a833575..4cd510b6 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -53,10 +53,12 @@ swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 # Again, we know the swap file is on device 1.
 $BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev3" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
 # Replacing device 2 should still work.
-$BTRFS_UTIL_PROG replace start -fB "$scratch_dev2" "$scratch_dev3" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG replace start -fB "$scratch_dev2" "$scratch_dev3" "$SCRATCH_MNT" \
+	>> $seqres.full
 swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
 # Replacing device 1 should work again after swapoff.
-$BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT" \
+	>> $seqres.full
 _scratch_unmount
 _check_scratch_fs "$scratch_dev2"
 
-- 
2.26.3


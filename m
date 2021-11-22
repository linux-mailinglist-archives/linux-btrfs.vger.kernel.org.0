Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9392E459723
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 23:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhKVWLU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 17:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhKVWLU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 17:11:20 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5B5C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 14:08:13 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id m25so17971568qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9rZNuDq+dHvDicprv1NyKqx8G2mf6YGPZRjLyH0Qxc=;
        b=6qJ3oPs9Sx1kvHfWsatFq8AwtN//7B8bux6dEWvP91VlnyZrTzhTiSP9FaufGEhbAZ
         nNlRl0pKfshbHhQ9o7RZv3FZcQBCwCtnIINofviP9wXIWRHdh0yKMWWNhTa1OXp0JXYK
         8wdmYbLRbCujRU8gFWfpnVqGt6LxWliBdnF/OruBa1YquCj6PUDMlwkqsSPdj9XjUiAl
         EJiGMDO0zldg1j8opU04TyLqv46+70dqNXt1AiP61V95kZp4d+w5WAl+4y2WgfrJIChd
         MBh/fGJE3tedKNCzNBxu2EyXwCI0t31SSxj9vXks1Ly3uiYo4AHqj4jQRLqX1nimOxt4
         U4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9rZNuDq+dHvDicprv1NyKqx8G2mf6YGPZRjLyH0Qxc=;
        b=4Pr49o3ksyrgZa3LdDpSVhMfxqogE0mGFdcGaLQXgPI0ItqEiRO+0vcGMyzsxso7JO
         VpHItOkrknOD93ucZ0eDawpOJUOWrULAewzaihfDLpJa5wRXscq9ZwczyOFf2FO701fw
         1WPtgyHPaQANLoY74fUaU9UU6IB1NU03mw/m5L1SzcVYALI2pLZEMtNwsIgGhZK+qAHt
         EIMmkvKhsFChctVwQ22MbLqA0isCa4YS4nz+80O2UGzYoFmll/IYFuYd0BZuWWlm+j9Z
         s5Nzd5ZrUo6+qgmG0d9byDWZGi4OsqZrI9Dan8h5zBmhrvAVyeC6991nd85fvcieFDak
         dhMw==
X-Gm-Message-State: AOAM531/hFe2YqeNFCEzu5Ujp1TU8DroSkIHUepk+ETxdDLZONd4eben
        qnQEh24mOyp1TL2AmQHNG/Z+7IVETQA5LQ==
X-Google-Smtp-Source: ABdhPJy31P0VpL0uuo/4ZrvlP1yLFKWQxexZsI4LpaiKf1qdOT8OffWxIM+pN3LJiM4ecIpdI6iINg==
X-Received: by 2002:a05:622a:148e:: with SMTP id t14mr671812qtx.266.1637618892316;
        Mon, 22 Nov 2021 14:08:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g5sm5176239qko.12.2021.11.22.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:08:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: generic/260: don't fail for certain fstrim ops on btrfs
Date:   Mon, 22 Nov 2021 17:08:10 -0500
Message-Id: <175b1ef92bbd2a48e2efb80d0064ca91aab1402e.1637618880.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have always failed generic/260, because it tests to see if the file
system will reject a trim range that is above the reported fs size.
However for btrfs we will happily remap logical byte offsets within the
file system, so you can end up with bye offsets past the end of the
reported end of the file system.  Thus we do not fail these weird
ranges.  We also don't have the concept of allocation groups, so the
other test that tries to catch overflow doesn't apply to us either.  Fix
this by simply using an offset that will fail (once a related kernel
path is applied) for btrfs.  This will allow us to test the different
overflow cases that do apply to btrfs, and not muddy up test results by
giving us a false negative for the cases that do not apply to btrfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/260 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/generic/260 b/tests/generic/260
index b15b4e57..b4d72e0f 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -31,6 +31,7 @@ fssize=$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"  | awk '{print
 
 beyond_eofs=$(_math "$fssize*2048")
 max_64bit=$(_math "2^64 - 1")
+[ $FSTYP == "btrfs" ] && beyond_eofs=$max_64bit
 
 # All these tests should return EINVAL
 # since the start is beyond the end of
@@ -128,6 +129,12 @@ case $FSTYP in
 		len=$start
 		export MKFS_OPTIONS="-f -d agsize=$(_math "$agsize*$bsize") -b size=$bsize"
 		;;
+	btrfs)
+		# Btrfs doesn't care about any of this, just test max_64bit
+		# since it'll fail
+		start=$max_64bit
+		len=$(_math "$start / 2")
+		;;
 	*)
 		# (2^32-1) * 4096 * 65536 == 32bit max size * block size * ag size
 		start=$(_math "(2^32 - 1) * 4096 * 65536")
-- 
2.26.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4445964A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhKVUxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 15:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbhKVUxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 15:53:39 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67487C06173E
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 12:50:32 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l8so17825666qtk.6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 12:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ef/Y5apmReHOewB/FWhS9DSkitKMi+v0EJqD2hghleM=;
        b=AX+TKNu/IPsLGbNnO4Y2F/1VyywHoCODRcX0lYwXcNU7K/xYxz2IR5QfVZ9abD/VQz
         yNEmogk3sbZSHOYio2tBSjzMXOCeaTgKEjLlnhtBEFNuY4i6ajUf8I6T5C0Xsjixdbn/
         Hlw71Ki1AZE4um/DDnDWtfOHWjNLRGsxhwkH0hKEvNvb666VBoN1ftFlpRIYVpOQEagn
         2K7Uf7fZ6X1N1dQRC2ObQPCOIEneVUlmwSzQA3reGrCs4JCwZMTjgbwd9+zQcxNOV+wm
         TZmdXGlJRZLfujl03euQSDdogPtvVDZNzlnVCyI1MlV4XzaNDWhf1so5IYQyPaLIg5yF
         0rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ef/Y5apmReHOewB/FWhS9DSkitKMi+v0EJqD2hghleM=;
        b=EOb34oRRB4BaQSXywHuCtKaQ6gnEq/oi8foIVn0sDfE6y+mg+IpYqPhhN/0GgTqKUu
         fXxGuDH+Xjj/zTr1Ypg6ANxWL4XIbk2SL6v40bjT0PWqsJMmFBZILauKqlTihcGs3NVO
         +0tl3kdDBQQc1lHnU/ELNzyAR6aF1aKMlwDpaR5gd0IJU13V3ljPk17vQiO5dJwud8iX
         FSSTcfN9vkHVB5fSliy99Qd30CfMkehiLgv4AYotpa9jxi3dOK38io34ARiH1RNr4qwH
         GiwAPmlgeo94sm5gWqRklqt/CY7GQiwxyC2RX+T8yhl3U+KT/7HCWWg5t2maHaBc6xgU
         lZGA==
X-Gm-Message-State: AOAM533thmgCgA4Bozz4iAcGLfKkP3knlYaJuK8jV9XmvqXB/giKMCNp
        2VSOCYFylauMtMgFI/3MdSZiVfpiwamsRw==
X-Google-Smtp-Source: ABdhPJwfJZrqjSMWU65/Y2dfiuwPxUkHvwCSS0dBx4SK0658u7cZ1fZmD0q7RptdXQDmh4JzAcRJYw==
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr5543qtk.351.1637614230933;
        Mon, 22 Nov 2021 12:50:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m15sm5070042qkp.76.2021.11.22.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:50:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/099: use the qgroupid for qgroup limit
Date:   Mon, 22 Nov 2021 15:50:29 -0500
Message-Id: <595829c06353ab12280513ab880bb742a2389bbe.1637614211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A change to btrfs-progs uncovered a problem with btrfs/099, we weren't
specifying the qgroupid with the subvol id.  This technically worked
before but only by accident, and all other tests properly specify the
qgroupid for qgroup limit commands.  Fix this test to specify the
qgroupid, which will work with older versions of btrfs-progs and newer
ones as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/099 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/099 b/tests/btrfs/099
index 375cc2b9..f3a2002a 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -29,7 +29,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT $(($FILESIZE * 2 / 1024))
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog qgroup limit $FILESIZE 5 $SCRATCH_MNT
+_run_btrfs_util_prog qgroup limit $FILESIZE 0/5 $SCRATCH_MNT
 
 # loop 5 times without sync to ensure reserved space leak will happen
 for i in `seq 1 5`; do
-- 
2.26.3


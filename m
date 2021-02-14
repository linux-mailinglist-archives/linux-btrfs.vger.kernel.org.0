Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8DA31B182
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Feb 2021 18:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhBNRS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Feb 2021 12:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhBNRS2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Feb 2021 12:18:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD459C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 09:17:47 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a4so1334279pgc.11
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OTDUH2DePQvdquK/8WT+5kp6hCAqlJhwjpyhBdCqCaA=;
        b=E0PVX/1jF77/uTqkWXzIj5vIQ7IOq1JuFwLtFNes5T/JKfEZ7ePS1NxuEstuAWOfV5
         Y9wdC5Zo2KHPwwD9yQFcMXjbGLb3dM2wJWYD9+WtgQnJAgVfGzaI/FTIPRHdYiXqmn+Z
         LdTUa7zFgshRWbDbp6IqbiC7lIrAHnoxeGtPvF5W7e4Bf5aE3P1tlm406f6BPq4uWyHt
         VI8Lz2uEKe4SRZ04Mxx45SnPnaQp4ynxUdiokmVJ/nOgMIPjSbY8mtfl+w5ek+SMNW17
         Ztxn+1gk0xHL/aaG9+35zKryZ7UhmVq/Ou6IStVBZ1rzi4UdtSXObkMlx2dJaBuI5Zyj
         t9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OTDUH2DePQvdquK/8WT+5kp6hCAqlJhwjpyhBdCqCaA=;
        b=krKGECY/54zRY6V4dFQhZnG3reoqSeYyY8lk6uzxL6/jr+TU6DGTJvO096KtLj3cmj
         5ZSaPWwAMUTUsy7B2QZfSPeHMJl6oUOe01DnQukUJ1uXUWf+cxns7l8f5mjIbSuGoYhc
         EA5nOKf3SRfPIEhb5vC/FLkbY1mPzl3H5VuG+Q5P34WMmxAHdIJBl9aGhuAOTkL5ZseC
         qE6Gk18aAgJ6pYnTfOYUio8GEa2YpylwV3mHi8MhIMU8PE5uSM75AdhzAo2Ekkrh8dZl
         ccB0Odnxfqh1qsl/q8gC/a2uYGT6WirOdDLxf7qt0St63RKjMNXnvhhSSv1uzOwcDZi1
         t3jA==
X-Gm-Message-State: AOAM532YMNHpv/3++KZUc4xFKt7SmVoljs02GxCQheOzS4UgA/VPrBXp
        9CT9Tuk0oswJcixNE4z7QU5HCXDlguq02g==
X-Google-Smtp-Source: ABdhPJziif3Bya0Wr9IVE+IoADkwsGiDccHv7nQ6nY8zV6LaiASu8+NJaTDawx22zegIhD9r8BqEoQ==
X-Received: by 2002:aa7:9a8d:0:b029:1da:f808:a422 with SMTP id w13-20020aa79a8d0000b02901daf808a422mr11689956pfi.66.1613323067178;
        Sun, 14 Feb 2021 09:17:47 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id r5sm15346242pfh.13.2021.02.14.09.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 09:17:46 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: docs: add seeding device section for btrfs-man5
Date:   Sun, 14 Feb 2021 17:17:38 +0000
Message-Id: <20210214171738.23919-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds a section about seeding device for btrfs-man5.
Description and examples are from btrfs-wiki page.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 Documentation/btrfs-man5.asciidoc | 74 +++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index e5edbe53..db2b5f1f 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -995,6 +995,80 @@ that report space usage: 'filesystem df', 'device usage'. The command
 ---------------
 
 
+SEEDING DEVICE
+--------------
+
+The original filesystem and devices are included as a readonly starting point to
+the new FS. All modifications go onto different devices and the COW machinery
+makes sure the original is unchanged.
+
+--------------------
+# dd if=/dev/zero of=/mnt/gentoo/btrfs-test-1 count=2 bs=1G
+# dd if=/dev/zero of=/mnt/gentoo/btrfs-test-2 count=2 bs=1G
+--------------------
+
+--------------------
+# losetup /dev/loop0 /mnt/gentoo/btrfs-test-1
+# losetup /dev/loop1 /mnt/gentoo/btrfs-test-2
+--------------------
+
+--------------------
+# mkfs.btrfs /dev/loop0
+--------------------
+
+--------------------
+# mount /dev/loop0 /mnt/test/
+# echo a > /mnt/test/a
+# echo b > /mnt/test/b
+--------------------
+
+--------------------
+# umount /mnt/test
+--------------------
+
+Now we will use this filesystem as a seed device:
+--------------------
+# btrfstune -S 1 /dev/loop0
+--------------------
+For more details, see `btrfstune`(8).
+
+--------------------
+# mount /dev/loop0 /mnt/test
+mount: block device /dev/loop0 is write-protected, mounting read-only
+# btrfs device add /dev/loop1 /mnt/test
+# ls /mnt/test
+a  b
+# echo c > /mnt/test/c
+bash: c: Read-only file system
+--------------------
+
+--------------------
+# mount -o remount,rw /mnt/test
+OR
+# umount /mnt/test
+# mount /dev/loop1 /mnt/test
+--------------------
+
+--------------------
+# echo c > /mnt/test/c
+# echo d > /mnt/test/d
+# umount /mnt/test
+--------------------
+
+--------------------
+# mount /dev/loop0 /mnt/test
+mount: block device /dev/loop0 is write-protected, mounting read-only
+# ls /mnt/test
+a  b
+# umount /mnt/test
+# mount /dev/loop1 /mnt/test
+# ls /mnt/test
+a  b  c  d
+# cat /mnt/test/c
+c
+--------------------
+
+
 SEE ALSO
 --------
 `acl`(5),
-- 
2.25.1


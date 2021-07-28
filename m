Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195843D95D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhG1TFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhG1TFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 15:05:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B229C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 12:05:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so5546533pjh.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gK4Fced/RfBZD5s7bvmATXMtEvRzNJxn8uuztamemLQ=;
        b=ORk63HACh2UX9gsZ1NsHtapSw2KN6xytbww+7J7br9BpoOtfXrpWGZEOcDAbfj+d7i
         XgseP42a7bmCTmltQ0kT87wPWMHZQlnwqS2axF2dagaXS9CMYeMh9OiiDhbCjx5shWMe
         BnkbxX5WtUPyied+vMDAiMq4WL83VPADKqf99+zuxOvKOnNNMhtMp8Gs4co2DUt3CKVB
         spJlCp5MwRSq8Oa4nboeg/PhYIF5ghWINQRyiFhab5sdGXTJ6OeGfYAjx/3Xa4dZjcaD
         oV6LP1TU/AxeIdAaWzscMsFES74RiCkpebgLAvVo4FWQOYCdA/83ftTyIJC52/2Sy+9y
         1qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gK4Fced/RfBZD5s7bvmATXMtEvRzNJxn8uuztamemLQ=;
        b=BueUHfTqcw3eJwmUo4+NuBchq+WHXg4D5SuH2PuoiSaxoadFpeU/tZjXQIrtlANMau
         lsPO7QIrGjTTsEMcOoNILb3Vkm7X/dJi38CCG7ZgUQt2YuFjr3Vh/Vn7zkBUZw0DZmDY
         /E3FlwAWvK0ReLaVRfBNBKEn1Tn5AkRxtkB+PSmul+GaWxO72z1RLRQf9qv4Yh33uFJK
         tDhIkfTfNgl3oaVY1qEloPqV9uBziVGeeXCsrAt3ACbErpbv9Dxg8PbfxezWBOmUxqzk
         z5lrtwppLDG65+afPv3YiAPc6+QvnWDJ35IAwnKAR/CaNUFFp599YgaMNIQOdv3SaMUc
         9IlA==
X-Gm-Message-State: AOAM532VyL75lGnHiSmKTi9r1b90jP7FgvMlyjw9i9P7KTTUHZB9Wppy
        m3BiQFblEnNeixK7FILl/FAOfgk7+gUTiw==
X-Google-Smtp-Source: ABdhPJxrji+9U6pniQlzuUjyAD1ShB9lIhkoNs1DnVX94EquplM3MelJoflcaFepVClhknhNylbbpw==
X-Received: by 2002:a17:90b:385:: with SMTP id ga5mr7873379pjb.183.1627499099183;
        Wed, 28 Jul 2021 12:04:59 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:86fd])
        by smtp.gmail.com with ESMTPSA id w11sm458671pjr.44.2021.07.28.12.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:04:56 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2] libbtrfsutil: fix race between subvolume iterator and deletion
Date:   Wed, 28 Jul 2021 12:04:45 -0700
Message-Id: <0f344e692b14ffbec90cb9f32e0d177c30326c37.1627498953.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Subvolume iteration has a window between when we get a root ref (with
BTRFS_IOC_TREE_SEARCH or BTRFS_IOC_GET_SUBVOL_ROOTREF) and when we look
up the path of the parent directory (with BTRFS_IOC_INO_LOOKUP{,_USER}).
If the subvolume is moved or deleted and its old parent directory is
deleted during that window, then BTRFS_IOC_INO_LOOKUP{,_USER} will fail
with ENOENT. The iteration will then fail with ENOENT as well.

We originally encountered this bug with an application that called
`btrfs subvolume show` (which iterates subvolumes to find snapshots) in
parallel with other threads creating and deleting subvolumes. It can be
reproduced almost instantly with the included test cases.

Subvolume iteration should be robust against concurrent modifications to
subvolumes. So, if a subvolume's parent directory no longer exists, just
skip the subvolume, as it must have been deleted or moved elsewhere.

Reviewed-by: Neal Gompa <ngompa13@gmail.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Changes from v1 -> v2:

- Added Neal's reviewed-by.
- Added test cases.

Let me know if you'd prefer the test cases as a separate patch instead.

 libbtrfsutil/python/tests/__init__.py       | 11 +++-
 libbtrfsutil/python/tests/test_subvolume.py | 73 +++++++++++++++++++--
 libbtrfsutil/subvolume.c                    | 18 ++++-
 3 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/libbtrfsutil/python/tests/__init__.py b/libbtrfsutil/python/tests/__init__.py
index 9fd6f6de..a1ea740e 100644
--- a/libbtrfsutil/python/tests/__init__.py
+++ b/libbtrfsutil/python/tests/__init__.py
@@ -77,7 +77,16 @@ class BtrfsTestCase(unittest.TestCase):
             mkfs = 'mkfs.btrfs'
         try:
             subprocess.check_call([mkfs, '-q', image])
-            subprocess.check_call(['mount', '-o', 'loop', '--', image, mountpoint])
+            subprocess.check_call(
+                [
+                    'mount',
+                    '-o',
+                    'loop,user_subvol_rm_allowed',
+                    '--',
+                    image,
+                    mountpoint,
+                ]
+            )
         except Exception as e:
             os.rmdir(mountpoint)
             os.remove(image)
diff --git a/libbtrfsutil/python/tests/test_subvolume.py b/libbtrfsutil/python/tests/test_subvolume.py
index 61055f53..2620b5c5 100644
--- a/libbtrfsutil/python/tests/test_subvolume.py
+++ b/libbtrfsutil/python/tests/test_subvolume.py
@@ -17,6 +17,7 @@
 
 import fcntl
 import errno
+import multiprocessing
 import os
 import os.path
 from pathlib import PurePath
@@ -493,20 +494,78 @@ class TestSubvolume(BtrfsTestCase):
         finally:
             os.chdir(pwd)
 
+    def _skip_unless_have_unprivileged_subvolume_iterator(self, path):
+        with drop_privs():
+            try:
+                for _ in btrfsutil.SubvolumeIterator(path):
+                    break
+            except OSError as e:
+                if e.errno == errno.ENOTTY:
+                    self.skipTest('BTRFS_IOC_GET_SUBVOL_ROOTREF is not available')
+                else:
+                    raise
+
     @skipUnlessHaveNobody
     def test_subvolume_iterator_unprivileged(self):
         os.chown(self.mountpoint, NOBODY_UID, -1)
         pwd = os.getcwd()
         try:
             os.chdir(self.mountpoint)
+            self._skip_unless_have_unprivileged_subvolume_iterator('.')
             with drop_privs():
-                try:
-                    list(btrfsutil.SubvolumeIterator('.'))
-                except OSError as e:
-                    if e.errno == errno.ENOTTY:
-                        self.skipTest('BTRFS_IOC_GET_SUBVOL_ROOTREF is not available')
-                    else:
-                        raise
                 self._test_subvolume_iterator()
         finally:
             os.chdir(pwd)
+
+    @staticmethod
+    def _create_and_delete_subvolume(i):
+        dir_name = f'dir{i}'
+        subvol_name = dir_name + '/subvol'
+        while True:
+            os.mkdir(dir_name)
+            btrfsutil.create_subvolume(subvol_name)
+            btrfsutil.delete_subvolume(subvol_name)
+            os.rmdir(dir_name)
+
+    def _test_subvolume_iterator_race(self):
+        procs = []
+        fd = os.open('.', os.O_RDONLY | os.O_DIRECTORY)
+        try:
+            for i in range(10):
+                procs.append(
+                    multiprocessing.Process(
+                        target=self._create_and_delete_subvolume,
+                        args=(i,),
+                        daemon=True,
+                    )
+                )
+            for proc in procs:
+                proc.start()
+            for i in range(1000):
+                with btrfsutil.SubvolumeIterator(fd) as it:
+                    for _ in it:
+                        pass
+        finally:
+            for proc in procs:
+                proc.terminate()
+                proc.join()
+            os.close(fd)
+
+    def test_subvolume_iterator_race(self):
+        pwd = os.getcwd()
+        try:
+            os.chdir(self.mountpoint)
+            self._test_subvolume_iterator_race()
+        finally:
+            os.chdir(pwd)
+
+    def test_subvolume_iterator_race_unprivileged(self):
+        os.chown(self.mountpoint, NOBODY_UID, -1)
+        pwd = os.getcwd()
+        try:
+            os.chdir(self.mountpoint)
+            self._skip_unless_have_unprivileged_subvolume_iterator('.')
+            with drop_privs():
+                self._test_subvolume_iterator_race()
+        finally:
+            os.chdir(pwd)
diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index e30956b1..32086b7f 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -1469,8 +1469,16 @@ static enum btrfs_util_error subvolume_iterator_next_tree_search(struct btrfs_ut
 		name = (const char *)(ref + 1);
 		err = build_subvol_path_privileged(iter, header, ref, name,
 						   &path_len);
-		if (err)
+		if (err) {
+			/*
+			 * If the subvolume's parent directory doesn't exist,
+			 * then the subvolume was either moved or deleted. Skip
+			 * it.
+			 */
+			if (errno == ENOENT)
+				continue;
 			return err;
+		}
 
 		err = append_to_search_stack(iter,
 				btrfs_search_header_offset(header), path_len);
@@ -1539,8 +1547,12 @@ static enum btrfs_util_error subvolume_iterator_next_unprivileged(struct btrfs_u
 		err = build_subvol_path_unprivileged(iter, treeid, dirid,
 						     &path_len);
 		if (err) {
-			/* Skip the subvolume if we can't access it. */
-			if (errno == EACCES)
+			/*
+			 * If the subvolume's parent directory doesn't exist,
+			 * then the subvolume was either moved or deleted. Skip
+			 * it. Also skip it if we can't access it.
+			 */
+			if (errno == ENOENT || errno == EACCES)
 				continue;
 			return err;
 		}
-- 
2.32.0


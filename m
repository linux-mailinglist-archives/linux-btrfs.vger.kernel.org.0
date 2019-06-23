Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E254FB31
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfFWKxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 06:53:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41230 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWKxh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 06:53:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so5226179pls.8
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2019 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YklhVY+NOlJpNj9FU/TL1Ndw2lhizodmD+Sm3Hih9k=;
        b=UfugQgKQtwB6X05oWGGZ2l8/Ub5O5gJdaGpfw07f7mQOVbSrNUGjIkMSS6nEAjiod6
         6GBGNp2aG3Kg/2AkMvnfN5SRqGwkCTB0zjDWSU/a129PMqVyacY/71EYcEORhRY+i1UQ
         lSgUqb07JAMysg7WqvMHYXT/ieMFP+hVw68LmzhYuwlw9EzpdJnRqoRoFhd3ij9sfjXn
         jfolpJ2WgFvy4AwpIrq8q0OTPmg2DxHc8kZbeAt2ye1MDE6cB32kPFB22QXNWMht91Eb
         tG/BR0Xaa4PeqrydRgXxIAKhiqDUR01kxDpC2Z0+6HJCQHmtBSdQKM4c5ZIdwigqjU6M
         lB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YklhVY+NOlJpNj9FU/TL1Ndw2lhizodmD+Sm3Hih9k=;
        b=dUkUQryOrKjK+sKMu8NURy0zRNxLW6Zd/LdrPqVXwMyB3gQpKyi7EMe+HnHD5FLu68
         e3PZoCz2W6kWvAs/oWca3JBCBO4Sw+5isfgqyGU4+KBGl4EDpfCVm7H/Iq9VphYcogLq
         vjBD07wottcY8K64MRrtmMQy5byYbEcHh5nGSbYEDdjcYrQL80UHcnqMJcDT3mIzX5Pz
         k+u962G4r9bjZ0eA5wrTjWFk7ybHm+8K/vkraQqLAIDjimNhxywBOtUF2IOoVRCRX/Ui
         8n/C1kxy6R+WMTdspeFTHsNnup8mRaUiMEbCytVKDvz8825iErMWztb8iQA9szPW9jaF
         xGlg==
X-Gm-Message-State: APjAAAV4Capzi9DSeKAP0veJxL0/DFFTE8nbzWmqYpTy0VyuENmPztli
        rnQT00+j1R5fDxfblKgX8HWSNSZf
X-Google-Smtp-Source: APXvYqx3e9ca8juKl3STHrM4Ikq0RA0xlLFaF2HqL76tzxZBYSE+nIuKXm3tBfiYaZeC883hEWRATw==
X-Received: by 2002:a17:902:341:: with SMTP id 59mr88037425pld.20.1561287216752;
        Sun, 23 Jun 2019 03:53:36 -0700 (PDT)
Received: from cat-arch.lan (155.239.201.35.bc.googleusercontent.com. [35.201.239.155])
        by smtp.gmail.com with ESMTPSA id u2sm7939976pjv.30.2019.06.23.03.53.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 03:53:36 -0700 (PDT)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH] btrfs-progs: misc-tests/029: exit manually after run_mayfail()
Date:   Sun, 23 Jun 2019 18:53:24 +0800
Message-Id: <20190623105324.12466-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Since the commmit 8dd3e5dc2df5
("btrfs-progs: tests: fix misc-tests/029 to run on NFS") added the
compatibility of NFS, it called run_mayfail() in the last of the test.

However, run_mayfail() always return the original code. If the test
case is not running on NFS, the last `run_mayfail rmdir "$SUBVOL_MNT"`
will fail with return value 1 then the test fails:
================================================================
====== RUN MAYFAIL rmdir btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
rmdir: failed to remove 'btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt': No such file or director
failed (ignored, ret=1): rmdir btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
test failed for case 029-send-p-different-mountpoints
=================================================================

Every instrument in this script handles its error well, so do exit 0
manually in the last.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202645
Fixes: 8dd3e5dc2df5 ("btrfs-progs: tests: fix misc-tests/029 to run on NFS")
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 tests/misc-tests/029-send-p-different-mountpoints/test.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/misc-tests/029-send-p-different-mountpoints/test.sh b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
index e092f8bba31e..d2b5e693f2d7 100755
--- a/tests/misc-tests/029-send-p-different-mountpoints/test.sh
+++ b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
@@ -49,3 +49,6 @@ run_check_umount_test_dev "$TEST_MNT"
 
 run_mayfail $SUDO_HELPER rmdir "$SUBVOL_MNT"
 run_mayfail rmdir "$SUBVOL_MNT"
+# run_mayfail() may fail with nonzero value returned which causes failure
+# of this case. Do exit manually.
+exit 0
-- 
2.22.0


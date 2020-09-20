Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A489271304
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Sep 2020 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgITI6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Sep 2020 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgITI6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Sep 2020 04:58:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2DCC061755;
        Sun, 20 Sep 2020 01:58:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q12so5313874plr.12;
        Sun, 20 Sep 2020 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkzfTh7DhmBVBq+EkhqaG5Kztu1aiM+Ht4R++Xy4/Lo=;
        b=Plgt9bgLdAa144i6kugLh5Dv3Y9bI111u4BMC7luZpMJIZfmigP3g8mfv9PlczYvRj
         GB5sK2lUMTlmU8tvt0VfVSNjgWBtGQjaFNUevhxAFzDDP+9xOt97L/HqOm0ruJxN/TBZ
         TJoMGhSN7rldCQ61YBJ9IVoMV6CULaN4QBdGdT9xLm04c8WagG0Z+QzqKJbQbdqb6ZTW
         WMAyP833EuCC5p/OegHZR16TN6SjOxLFZrNwdzCiwZ3KZkUGEGprkzLKnbldiMSdU+4B
         zCWmup7SWZ/hrRE20yFbn+OIaxu/uC8KgDijkAxzhtTXPuwjWqcdHSAQIxLUhd6F5lHa
         9mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkzfTh7DhmBVBq+EkhqaG5Kztu1aiM+Ht4R++Xy4/Lo=;
        b=tMMPSW1hOESV5A049n/R5q0mFlmEOEEzSN4efWhVKRKK97ZdaMB1B22S3Sva9c31+T
         yA24vgPDnJoh8L1h7YzqnvVWtm200QHDdsibnOrjg1lUbmUh8LABNlEI7yv4IwOQmBo+
         s2JYMvHVSSrS5hCcLpU/PHCkTnkdoXiAia0Ur3QS1M9lXIiSKKKVfQnPR/FzaUk7LAYY
         uJav5V6U4pZZfBmllW3tQLBL8jppHCu4jlFLIZoe1m8h/QL0cBCy7Gr87BCEirItA9A6
         6IW+SpFqhCYtsRFnunK6+GWFMuTIphopEKbgdtqqKrL4GH2RXIhlWR8Nm+os2iAg7+u5
         +Nug==
X-Gm-Message-State: AOAM530SFWMdHlbKS2XIWodY8gBMalW7jKebfmNUiHbgkextP2NfIch+
        gBgnVOlKMv5hZC6Yd3r7RFpAj1MsH/U=
X-Google-Smtp-Source: ABdhPJyULjqwhaTK21TWzzku566YHfYL70kLseQ/7Wzlu6Hx6lucPg0NBjHCr/TtOmZDM9MDSm/kXw==
X-Received: by 2002:a17:902:522:b029:d1:9bc8:15df with SMTP id 31-20020a1709020522b02900d19bc815dfmr41117711plf.25.1600592324039;
        Sun, 20 Sep 2020 01:58:44 -0700 (PDT)
Received: from localhost.localdomain ([112.216.230.34])
        by smtp.googlemail.com with ESMTPSA id 99sm7433863pjo.40.2020.09.20.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 01:58:43 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs/022: Add qgroup assign test
Date:   Sun, 20 Sep 2020 08:57:53 +0000
Message-Id: <20200920085753.277590-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs/022 test is basic test about qgroup. but it doesn't have
test with qgroup assign function. This patch adds parent assign
test. parent assign test make two subvolumes and a qgroup for assign.
Assign two subvolumes with a qgroup and check that quota of group
has same value with sum of two subvolumes.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 tests/btrfs/022 | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/btrfs/022 b/tests/btrfs/022
index aaa27aaa..cafaa8b2 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -110,6 +110,40 @@ _limit_test_noexceed()
 	[ $? -eq 0 ] || _fail "should have been allowed to write"
 }
 
+#basic assign testing
+_parent_assign_test()
+{
+	echo "=== parent assign test ===" >> $seqres.full
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	subvolid_a=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	subvolid_b=$(_btrfs_get_subvolid $SCRATCH_MNT b)
+
+	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
+
+	_run_btrfs_util_prog qgroup assign 0/$subvolid_a 1/100 $SCRATCH_MNT
+	_run_btrfs_util_prog qgroup assign 0/$subvolid_b 1/100 $SCRATCH_MNT
+
+	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
+	_ddt of=$SCRATCH_MNT/b/file bs=4M count=1 >> $seqres.full 2>&1
+	sync
+
+	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_a")
+	a_shared=$(echo $a_shared | awk '{ print $2 }' | tr -dc '0-9')
+
+	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_b")
+	b_shared=$(echo $b_shared | awk '{ print $2 }' | tr -dc '0-9')
+	sum=$(expr $b_shared  + $a_shared)
+
+	q_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "1/100")
+	q_shared=$(echo $q_shared | awk '{ print $2 }' | tr -dc '0-9')
+
+	[ $sum -eq $q_shared ] || _fail "shared values don't match"
+}
+
 units=`_btrfs_qgroup_units`
 
 _scratch_mkfs > /dev/null 2>&1
@@ -133,6 +167,12 @@ _check_scratch_fs
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _limit_test_noexceed
+_scratch_unmount
+_check_scratch_fs
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+_parent_assign_test
 
 # success, all done
 echo "Silence is golden"
-- 
2.25.1


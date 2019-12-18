Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C9123C50
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLRBRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:17:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36510 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfLRBRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:17:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so114887wma.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 17:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqrHfJYI1UshmbeFbH2UWVsXQrT05MkXHcO/S13u6u8=;
        b=hOREvpoyLmmqB6iQlZ7RliUAYpRs4b0LD8MC8+yuUWi7DpG/VyaNQqkWGxX+pgYhMr
         gNzFjv99GFs75mYsRKj+QI3ovyizcYGRLfIZO0yUg4cwiL79fiDXpeAje6eaEiem62tg
         Put7yDSci/PNWjQN7haN1HG7wsq31WjO0C09HCj1lBzjgvMZDmjiqT961lE7rkloQIrQ
         B90AbMNgSHxuB7sdtTrkO172M7loNzfoc+o2mIK7ZGwL9bb5MCgg4EYBHyHu3P+UPQhP
         5jUKtHDcmnWhZ/46BCX4AAY5o9+G1ONo8KKXn+88IT38bWx7OAyRdq5G+GOVqTYR+38L
         3rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqrHfJYI1UshmbeFbH2UWVsXQrT05MkXHcO/S13u6u8=;
        b=c8K+egvttV52ufZZSHzcxyTcCn9zUP+chZ5XM3a268lfgUQFhFZfldNfGUGg6kYLe4
         L2EGuss8SrzgtMqakNaMLNEzHaDPSo9bDkxebIaTwbvMQiPTdyMuDORP2/R99lX+YY8B
         S2OYFBbjgbRqysyYDe8XKSDbhNHwaaSzlE4KgeKu8tq9xUyyrzZdMEHr2XoxE2UDbOHY
         HAIb+XYSGCv3tK16cWbACSwgVasylaP7de6tIDKlVkv15H3usy8AnRXjoXEi9pPhaJ23
         a/64Yb7eFx/9pqFtI+/fStI4+lukOY1VwQOc+7w7Kr8qnfHkhrDFzbKER0fnacHa3F8v
         K0DQ==
X-Gm-Message-State: APjAAAXnAKtl64xPpj72MM2Uevyi6/4ZtiInksKNosHZ8cpwwVGAegIW
        +6tl+IMMgyW0xfox9B/xfZM=
X-Google-Smtp-Source: APXvYqy4hfKUAAft1NXtiOluMwEeeZW28wiZPv9VL8zR+WE+GHRrbCUbMw8SJMcxd0zADE6pzg79bg==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr35265wmj.75.1576631837633;
        Tue, 17 Dec 2019 17:17:17 -0800 (PST)
Received: from hephaestus.suse.de ([179.185.209.78])
        by smtp.gmail.com with ESMTPSA id g25sm4782854wmh.3.2019.12.17.17.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 17:17:16 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCHv2 4/4] tests: Do not fail is dmsetup is missing
Date:   Tue, 17 Dec 2019 22:19:25 -0300
Message-Id: <20191218011925.19428-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218011925.19428-1-marcos.souza.org@gmail.com>
References: <20191218011925.19428-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Move the check of dmsetup to check_dm_target_support, and adapt the only
two places checking if dmsetup is present in the system. Now we skip the
test if dmsetup isn't available, instead of marking the test as failed.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/common                                             | 9 +++++++--
 tests/mkfs-tests/005-long-device-name-for-ssd/test.sh    | 1 -
 .../017-small-backing-size-thin-provision-device/test.sh | 1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/common b/tests/common
index 20ad7fd9..5814ae6f 100644
--- a/tests/common
+++ b/tests/common
@@ -322,10 +322,15 @@ check_global_prereq()
 	fi
 }
 
-# check if the targets passed as arguments are available, and if not just skip
-# the test
+# check if dmsetup and targets passed as arguments are available, and skip the
+# test if they aren't.
 check_dm_target_support()
 {
+	which dmsetup &> /dev/null
+	if [ $? -ne 0 ]; then
+		_not_run "This test requires dmsetup tool.";
+	fi
+
 	for target in "$@"; do
 		modprobe dm-$target >/dev/null 2>&1
 		dmsetup targets 2>&1 | grep -q ^$target
diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
index 329deaf2..2df88db4 100755
--- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
+++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
@@ -4,7 +4,6 @@
 source "$TEST_TOP/common"
 
 check_prereq mkfs.btrfs
-check_global_prereq dmsetup
 check_dm_target_support linear
 
 setup_root_helper
diff --git a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
index 91851945..83f34ecc 100755
--- a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
+++ b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
@@ -6,7 +6,6 @@ source "$TEST_TOP/common"
 
 check_prereq mkfs.btrfs
 check_global_prereq udevadm
-check_global_prereq dmsetup
 check_dm_target_support linear thin
 
 setup_root_helper
-- 
2.23.0


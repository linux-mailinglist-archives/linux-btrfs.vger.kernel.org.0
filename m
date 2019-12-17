Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5043123756
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 21:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfLQUaS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 15:30:18 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46939 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfLQUaR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 15:30:17 -0500
Received: by mail-wr1-f43.google.com with SMTP id z7so12707704wrl.13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 12:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9i34ap6atfXCMNUeYLPcXX0+LCQyl6EDDG5Dg3n1xcc=;
        b=QaokeOuhWfmejelFrHNegzLLi9HJlfXsiu8J0BY9iSejS/xhuhMJEbOxwCk4ln60bn
         LL4gbkMsrOdl/21QIdmFO2OXwsaShZ0aTX42nA5q+M36yHoPzzTurSTGBWUcR1/F6tDz
         948Ew0OQlG4BeOFPoGSZ+Cia4JwglFBnYbyU9dHdHndfcxa+yblXHIYrtNWyWZOi5ze+
         h3RzgrxDMDKnmaKZNakMgww0NS29ik87K1XMchvaewOidKJLFXreJX25SNakqID6ui3C
         Cm6O/8bSNkKa3UYDvXMP05RyqAVIlCvbAMP6khFJxtHULaMNHHdkki0/JHP9hvXFW5qb
         wU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9i34ap6atfXCMNUeYLPcXX0+LCQyl6EDDG5Dg3n1xcc=;
        b=qaBp4fHdFgnVai309fRQszct5wkUB8h1cj64N3YbQj9lhfIq2ArWFNrULz8NProNwT
         zkeXCktplkfNpzjM+UP2w0ToMfMYYpTogp33qpTw/YxOpexGJWqb7oB/PLxyt6C70knN
         OGG69fj5R2PGaruQQ4z47kw1JJPMEaANspYVHTsHCJ4rS89UWiLes1STP8hCuKPrjpNv
         AgEJ0G8ZPk2Q0qoNbi80O0EDHvZASbY6d9/s57cx/i4UmbPVKUsXTMx+j/zWL7e8tokc
         7eN6g+R9L58oYdJksnuGD+3j7xDFrwMfBgBRFhidklr8AkzCAOZ4t2QI3Mi4WeXAw3dr
         SO+Q==
X-Gm-Message-State: APjAAAWDTXtJJQ+suVlN2AwD1VfUtpLy3M8bPyaX0aR+h4kE0BPQBkl2
        Sa56q0/54BP9Bn1zpv33E/STZtCZ
X-Google-Smtp-Source: APXvYqwiOUcFe5y3tPGCbPwgL6fVpGD5dWsqUp0xiZxpmvLWYuJcqKTx1tIxoyHoz5H/NJOwijC2DQ==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr40551399wrq.348.1576614615821;
        Tue, 17 Dec 2019 12:30:15 -0800 (PST)
Received: from hephaestus.suse.de ([179.185.209.78])
        by smtp.gmail.com with ESMTPSA id h17sm27910619wrs.18.2019.12.17.12.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:30:15 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCH 4/4] tests: Do not fail is dmsetup is missing
Date:   Tue, 17 Dec 2019 17:31:55 -0300
Message-Id: <20191217203155.24206-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217203155.24206-1-marcos.souza.org@gmail.com>
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
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

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/common                                             | 9 +++++++--
 tests/mkfs-tests/005-long-device-name-for-ssd/test.sh    | 1 -
 .../017-small-backing-size-thin-provision-device/test.sh | 1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/common b/tests/common
index f138b17e..dc2d084e 100644
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
 		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
 		$SUDO_HELPER dmsetup targets 2>&1 | grep -q ^$target
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


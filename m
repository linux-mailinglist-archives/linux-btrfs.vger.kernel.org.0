Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76911CBBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfLLLCP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36304 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so580080pfb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iploGeyQw0n2X+UztIXgwkw6IT4Eye3P4U1NgSFdGHQ=;
        b=hKLjfovpphuCMNEDbgmT/W1gJJUOq/Ef+ChVUWIyFnsbggF20SV70bGNsmd7Jg0JA5
         ikaopSs6TGaCB4Zi6pFiYQXx6iLIhq50MC0ZzEEKbVKcGQou5iXnS4N2tSRrMYjMUJ+6
         lppvlyLD9aIbYSLe44aoODu74cOLwx5xkGjmVv8GBAF+qr/9anCthSYTfSUGJ5jgtxxB
         ZgrJH0N34Fg1Sw7b/zKvLqvLkYmWLCVNsbeYGELvqX6WViM5AHeATHbvfNck2B5eEAx4
         QdgdxZQt0ACrDs2kiY/HLXpRwrtduvgruDaFNArnGA+BBK3TvhNSqRaP7KJY2qWDlbl7
         Xtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iploGeyQw0n2X+UztIXgwkw6IT4Eye3P4U1NgSFdGHQ=;
        b=fj7+1b3yxB6iqJR+0SrYaFKsaYx4ixBYh1WUOq9+GDCWBmMoTBA3f6Wq+8YorE6u+F
         grm0bgeSdA86AT9l5lNPDxpHGPyXpUbgHtFIT+Vwb3NgiN28vQCTEPSq7TeOp1C9+a9D
         JXz9Uow1k/CJN57gtN300tBesrMjE1B/WwE9TwS6tCnlqEVs1Qthg5qhWm8z/JB8fnKD
         hh3KRcjGbDBnjZWt4VWN457jL9rVDO5/jjoEvfxR1hVDb1c8gUXspC0R+3CqXX/eHeth
         QSfvoKj0PLHf4RL98ckcyyZrc/jVe7ne0AHqPp9/bw7eJQpnE8+hu8TP/YrEN0W7k4zf
         1/8Q==
X-Gm-Message-State: APjAAAVZ/eDAvl82OWnkqMklxHsoMzn3L8OWSVjOKqlSJQot9qMtv07w
        Z000imG+HYDMM1RA9uUjJiKdybcnO9c=
X-Google-Smtp-Source: APXvYqxM4vWmLIRHeG+D+uxk06L0hMmodDnb+H/X6++zxv+/4dMdwjOkIVzs8jRECnBRr8lmKq9z4A==
X-Received: by 2002:a62:ac03:: with SMTP id v3mr8972010pfe.17.1576148534458;
        Thu, 12 Dec 2019 03:02:14 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:14 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 02/11] btrfs-progs: misc-tests/034: mount the second device if first device mount failed
Date:   Thu, 12 Dec 2019 19:01:55 +0800
Message-Id: <20191212110204.11128-3-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191212110204.11128-1-Damenly_Su@gmx.com>
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The 034 test may fail to mount, and dmesg says open_ctree() failed due
to device missing.

The partly work flow is
step1 loop1 = losetup image1
step2 loop2 = losetup image2
setp3 mount loop1

The dmesg says the loop2 device is missing.
It's possible and known that while step3 is in open_ctree() and
fs_devices->opened is nonzero, loop2 device has not been added into the
fs_devces. Then read_one_chunk() reports that loop2 is missing.

The solution for this test is try to mount loop2 if loop mount failed.

Fixes: 0de2e22ad226 ("btrfs-progs: tests: Add tests for changing fsid feature")
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index ff51bf22fadf..5fe553705fcf 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -173,7 +173,9 @@ failure_recovery() {
 	loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
 
 	# Mount and unmount, on trans commit all disks should be consistent
-	run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
+	run_mayfail $SUDO_HELPER mount "$loop1" "$TEST_MNT"
+	[ $? -ne 0 ] && run_check $SUDO_HELPER mount "$loop2" "$TEST_MNT"
+
 	run_check $SUDO_HELPER umount "$TEST_MNT"
 
 	# perform any specific check
-- 
2.21.0 (Apple Git-122.2)


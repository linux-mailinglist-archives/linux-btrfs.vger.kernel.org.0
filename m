Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFE1143B2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfLEPep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 10:34:45 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:44592 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLEPep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 10:34:45 -0500
Received: by mail-pg1-f175.google.com with SMTP id x7so1757863pgl.11
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 07:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQ18rXQIri8Wyt4fLVNfERoR5nBubv7v02vFmodtdiA=;
        b=ZVCP7mxXF7qo7Gu0nvjl0G0N8DKd9iuFl1F/320k4feVi3PmZG7zJ3izmnm/8MkqQn
         agjKYWVoRuM19sr4lL1iMjks4xUpqNbDYA6SDOIaBnduQtLA5oW/hXxgnMTCRKPVXKG2
         t/EgfG2kROXzX4oyjEiZu06t95gz2KwmGJuOL90xc6m9x3KHSNWHHcUGcL56sJKIGhkC
         YlevtywxGNurcb9ku/G1LgYJH6GEtB191N7IMWF2Vm82ot/8hn20MaKVRvc5Ebr2ReNl
         SL2fschGHy+9BZNWctU/Sff9Nvrf5hsJprAkHSzv3MMep96wDVc0PpK9Ya8VaUXbQisg
         VpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQ18rXQIri8Wyt4fLVNfERoR5nBubv7v02vFmodtdiA=;
        b=uBov3JYltfjYpwaxL0jklXf+PJ/A67l7I//jXHcAe5x7TWLM/8HoFKHPiR0CNVmDjy
         SOD0FWpEYBdIPwL9pbIf0+6+3JRX3IMibMwd4rHt8ZJdzZ7S9MGSD4IA2H/urKG0CrZC
         xWxqA//RS67jy9m4j6hhadoPzFxGL9TdNCmQSI4XqjW6pw884jZwuJqCGE2rg4ZNgU7Q
         Vt2Qv8JATMm34o9RXipT41yP+X9DvNgQFO/Ux46x+pBnewNE7HZ/B6LOlW9yRHgm3SWT
         z4zyzefEpmPLGXhs8SC1xmLrk8Amp0Gx3z2SNs8Mtby2jKBjqHKXwlRjJMa5JDNzyuGj
         8uoQ==
X-Gm-Message-State: APjAAAXgmpwq3pimVk4DIdsktJx05QGM3PHj/DoTC4s+l7+7Mib1ete1
        2PoGTdb4Q/iGGSWuJ04aMe9wXvZ6
X-Google-Smtp-Source: APXvYqx+W/W4Kr2mMu9jpdPxiaSi4WtSobh2YcCGoYFV6lD5eHNn9am4cnD37MCBs7sm0FIGmfPUHw==
X-Received: by 2002:a63:2783:: with SMTP id n125mr9960055pgn.431.1575560084252;
        Thu, 05 Dec 2019 07:34:44 -0800 (PST)
Received: from hephaestus.prv.suse.net ([179.185.217.252])
        by smtp.gmail.com with ESMTPSA id z130sm12286914pgz.6.2019.12.05.07.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:34:43 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/2] btrfs-progs: mkfs-tests: Change $dev1 to TEST_DEV
Date:   Thu,  5 Dec 2019 12:36:47 -0300
Message-Id: <20191205153647.31961-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205153647.31961-1-marcos.souza.org@gmail.com>
References: <20191205153647.31961-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

It seems to be a typo, since $dev1 was not set, and we are dealing with
TEST_DEV and not with loop devices.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/020-basic-checksums-mount/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/mkfs-tests/020-basic-checksums-mount/test.sh b/tests/mkfs-tests/020-basic-checksums-mount/test.sh
index b7252786..42bf5fab 100755
--- a/tests/mkfs-tests/020-basic-checksums-mount/test.sh
+++ b/tests/mkfs-tests/020-basic-checksums-mount/test.sh
@@ -17,7 +17,7 @@ test_mkfs_mount_checksum()
 	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$TEST_DEV"
 	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
 
-	run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
+	run_check $SUDO_HELPER mount "$TEST_DEV" "$TEST_MNT"
 	run_check "$TOP/btrfs" filesystem df "$TEST_MNT"
 	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
 	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
-- 
2.23.0


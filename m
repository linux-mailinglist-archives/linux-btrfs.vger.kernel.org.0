Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00D11CBBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfLLLCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45944 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so563071pfg.12
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fktl9a826M71BPZIK+iiAqg6eAaRJhlG243Z84C4xoc=;
        b=DUksATwbwuOFMaPs5Bo7ckD6bwY85Ev+3JD5rUUKo7t83+yTRYO9/mHHT8ANCr6bdR
         nFs9yr9GdXlFbddHY5Ng56dX7YVCsqSNAx56LDxHKCuuxEkLPxH3A3yySC3qcBM0FbQT
         umUf8L5Z8Qb1VItdniBDlc3h1PeaHRrb223+46kcR4Za81ifWb9EkUCJcg4p/LawkMlX
         t4tm10uXNCzDTcc9YBxJqBrfnU/tyngIdTaeCh1U3oNirspsYJ6qjnj2Wc9TLtKCBV7f
         a2t+nXD3haCSbIpplLw2F9isMRMXBrRfYgmTnOIgJEvTvtoLMgN7HcK7pZBRxisk8goi
         rVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fktl9a826M71BPZIK+iiAqg6eAaRJhlG243Z84C4xoc=;
        b=H9guqZDhlZP+XhhMuODLiJUjxDMr81hyVRZDuruY4wsjHEZ9rUif+eo+30o2xolBf2
         ugryU6ok4hfFUz4rACQPG4noFimlo0d24f72st8Tof6tiW87R27mGMk3MaIj8lAxSHo6
         ziKW5/K3l+SG6JUOotvVAE4ZrB9BX+Xj8QIL8vznOwQkiRmf7XIDNjQgGq5WRWoYBiWm
         rBbcbWX3HK70Y92JY4hab7mdYJe2JjAq51wkLdBbYDm0vhRVWAINLOhJ5/pKThy03M7R
         i9vy9LMUDggA9LAgZGe1IDzgE6ItEEh2Z4UEGTtyEjWk5F3wVOlaIdMxETo0o1GWuqyB
         lOrg==
X-Gm-Message-State: APjAAAX0ZxJI7jdMYZpjd/5t8D4yiduBVU5BpbfLDMLLYIiSiCL+SUkP
        GvbUh9jz1hziSK/YeC0VcfqtP3Y6gzs=
X-Google-Smtp-Source: APXvYqwJGLJSiaS9gH10+RUThOtsGHATjBDw/uAf+MUIplTI1tiOqKfZMJ3pYmviTKQZSAHkgl/7GQ==
X-Received: by 2002:a62:f842:: with SMTP id c2mr9131517pfm.104.1576148532749;
        Thu, 12 Dec 2019 03:02:12 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:12 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 01/11] btrfs-progs: misc-tests/034: reload btrfs module before running failure_recovery
Date:   Thu, 12 Dec 2019 19:01:54 +0800
Message-Id: <20191212110204.11128-2-Damenly_Su@gmx.com>
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

One reload_btrfs is lost, add it.

Fixes: 0de2e22ad226 ("btrfs-progs: tests: Add tests for changing fsid feature")
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 6ac55b1cacfa..ff51bf22fadf 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -211,11 +211,10 @@ failure_recovery "./disk1.raw.xz" "./disk2.raw.xz" check_inprogress_flag
 reload_btrfs
 failure_recovery "./disk2.raw.xz" "./disk1.raw.xz" check_inprogress_flag
 
-reload_btrfs
-
 # disk4 contains an image in with the in-progress flag set and disk 3 is part
 # of the same filesystem but has both METADATA_UUID incompat and a new
 # metadata uuid set. So disk 3 must always take precedence
+reload_btrfs
 failure_recovery "./disk3.raw.xz" "./disk4.raw.xz" check_completed
 reload_btrfs
 failure_recovery "./disk4.raw.xz" "./disk3.raw.xz" check_completed
@@ -224,6 +223,7 @@ failure_recovery "./disk4.raw.xz" "./disk3.raw.xz" check_completed
 # than once, disk6 on the other hand is member of the same filesystem but
 # hasn't completed its last change. Thus it has both the FSID_CHANGING flag set
 # and METADATA_UUID flag set.
+reload_btrfs
 failure_recovery "./disk5.raw.xz" "./disk6.raw.xz" check_multi_fsid_change
 reload_btrfs
 failure_recovery "./disk6.raw.xz" "./disk5.raw.xz" check_multi_fsid_change
-- 
2.21.0 (Apple Git-122.2)


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AC1123753
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 21:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfLQUaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 15:30:10 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55908 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfLQUaK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 15:30:10 -0500
Received: by mail-wm1-f53.google.com with SMTP id q9so4236092wmj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 12:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWEax0cJ/5QdKoZg4ND4QhLlJADXvRMyN6jxYB/TJoo=;
        b=YPZXClOoDMZS8WFQdQLh+ZJLrD/uefLz/HQZIGOLGHWLRajoxAv1ar1Zy6bI67uYui
         0IC+a4ZzL/yGAjreM4zzhYpBaoBjtkVyivYbDAx1v85V+qxx4f7GljZK2BPr1zVQIRfY
         Tc+xm7B/KSJ92KQzEGExGGlG4lxMjMOXQ7TlP0RV2O67j1iCB4W/GsiOgeBnPWthZ3qs
         NIC802/j5hpU5PlHi68Dy/ieHyHXNATlDr4P/FU17QX+Cpco6jBESMtoNi3SHnIWN1Zx
         TR2d1ZauzliDjenfUcs0sh6o8uajZqLi8pRp+E1aIfPEdrrj18XXKycf0AO/DDlKJE9f
         /nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWEax0cJ/5QdKoZg4ND4QhLlJADXvRMyN6jxYB/TJoo=;
        b=XFJjx/JLUlGLNIZSw2GohwFYAM8ux808RNxKQlZv15X5zlOVEepFeke8VQft+6/mMO
         MXUlXkekx0Q+LsvXfsUHfH0n0QovDHgS3Q7Q4wis9SlXrEZbibPkUYEHlAWhiWaPeppW
         I9p1jTjo5nMM5z+8DX8SFli6sq9bpqQkqvrPeRk37tp/tFKqRl8bBqnhedQao9I6y4aV
         8agEw6MjDPYlY9bDHAQ8ics6W4tn2dazNhtE1IZdyyN98Tdf6AbSBdyELo7R9zSYBKlI
         cxwAzAi/PFGxnFLk2eulQ/TrWE+6Tai2rfEWJLy81trzT7tSo1BlQgHSi/BajS+YRoUZ
         G+3A==
X-Gm-Message-State: APjAAAUP3k8BV9N7p2+Jld/D6yvT0YkvutgUJpSrOJ6GNPTGAzAtV5sM
        bi8PVe82fcfk61V1LD+pZHMKChfN
X-Google-Smtp-Source: APXvYqzxFUmBkkocFx9pirEFZPaicaQRpgFwbNs3G2yj58m/igxknfnXuse7FLlYl72aSASFeEHsIw==
X-Received: by 2002:a05:600c:2254:: with SMTP id a20mr7626460wmm.97.1576614608183;
        Tue, 17 Dec 2019 12:30:08 -0800 (PST)
Received: from hephaestus.suse.de ([179.185.209.78])
        by smtp.gmail.com with ESMTPSA id h17sm27910619wrs.18.2019.12.17.12.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:30:07 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCH 1/4] tests: common: Add check_dm_target_support helper
Date:   Tue, 17 Dec 2019 17:31:52 -0300
Message-Id: <20191217203155.24206-2-marcos.souza.org@gmail.com>
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

This function will be used later to test if dm-thin is supported.
Inspired by fstests.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/common | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/common b/tests/common
index ca098444..f138b17e 100644
--- a/tests/common
+++ b/tests/common
@@ -322,6 +322,19 @@ check_global_prereq()
 	fi
 }
 
+# check if the targets passed as arguments are available, and if not just skip
+# the test
+check_dm_target_support()
+{
+	for target in "$@"; do
+		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
+		$SUDO_HELPER dmsetup targets 2>&1 | grep -q ^$target
+		if [ $? -ne 0 ]; then
+			_not_run "This test requires dm $target support."
+		fi
+	done
+}
+
 check_image()
 {
 	local image
-- 
2.23.0


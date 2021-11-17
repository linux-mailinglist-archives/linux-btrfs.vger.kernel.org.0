Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86BB454E6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbhKQUXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbhKQUXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:12 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D72C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:13 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id a11so3864147qkh.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSd9FSAHvwRStKfG5eBvhbiT9acKh6fdEyQqg0VRLcU=;
        b=vzuaJNx8HlHEgIWVqBIgPcRxmkatk4PupbaLzlPs9ZdJX0inwPYn22x9nFKmtzZNsD
         y/V7MBJ3mDSgGlMrGUUYe9N8TH+w2eBMEhl9l38J4xIqeEUdDq0fFv7nMOhCrjnl/vg0
         vox7WTYL88mUPEtqeKgDe2CXJeCj76BcEyTWiDyI4COlgvTbsXRdm9f5OHMiS2IwfV4w
         Z9T93bwlQ8McRwo7CwkxSOCJp+XB0F9z5NBx8Kl6R1ubs54viO47L7cTHu3c/G5tjyAO
         rskK5JZTy6V2SqTHjBFsyKmCmPW9/H26e8e2jBW/ttyXCcN9CtZkfKLZ2a9sOIKj/pD/
         I0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSd9FSAHvwRStKfG5eBvhbiT9acKh6fdEyQqg0VRLcU=;
        b=zEo9Byiurc9I5wqzF6f0KTQAO8OjktTaoLotvgS1WnyQYLyazSfCW/nexi9maK5CjV
         4vdkKL9qTO2kOghZU9224YXwXuyipww+r3WLSaUqFrc5JlcHnMk9FjOwRDt0GY48cwmg
         4WFi8INNvrvmCj1I4YogUEPmUTNRkyNOHrppnf2p2SMGqEvBCx0DADmRLAGZRuFlvQYW
         xm67BZOmpySpSjr4bUTPShUIbf594vYj1Hgh+yoQ8cxtKnVSonHeATv5XcfezA+bhyqW
         O6qfwvcRO3GThqNtn2qFnQxwiNDxLXFfyuZJyMFFXl5MikOBEfyOWpRj3mWgqYRGQwXS
         RbCg==
X-Gm-Message-State: AOAM533B9NAdfu9pFdBF2M2Us9gxzSTsCf6wwZ+qJ5yC5CHZxWCyzkzN
        nxzJ5IHpJz+8iQNIrFiEPCJ8ORI/H85QcA==
X-Google-Smtp-Source: ABdhPJzGuH1CjkgxwLeG5C9AvF4iZGpeo3U5jIVbiVJVGhqr9CPkxwxVovj5nYcmI0qGHhX7Lq5KdA==
X-Received: by 2002:a05:620a:d58:: with SMTP id o24mr15180250qkl.517.1637180412238;
        Wed, 17 Nov 2021 12:20:12 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:11 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 12/17] btrfs: send: fix maximum command numbering
Date:   Wed, 17 Nov 2021 12:19:22 -0800
Message-Id: <bc324fbf99e8a792719da7bb96f5dcf4964904de.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
_BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
version plus 1, but as written this creates gaps in the number space.
The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
23 and 24 are valid commands.

Instead, let's explicitly set BTRFS_SEND_C_MAX_V* to the maximum command
number. This requires repeating the command name, but it has a clearer
meaning and avoids gaps. It also doesn't require updating
__BTRFS_SEND_C_MAX for every new version.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 4 ++--
 fs/btrfs/send.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 500b866ede43..450c873684e8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -316,8 +316,8 @@ __maybe_unused
 static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
 {
 	switch (sctx->proto) {
-	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
-	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
+	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
+	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
 	default: return false;
 	}
 }
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 23bcefc84e49..59a4be3b09cd 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -77,10 +77,10 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
-	__BTRFS_SEND_C_MAX_V1,
+	BTRFS_SEND_C_MAX_V1 = BTRFS_SEND_C_UPDATE_EXTENT,
 
 	/* Version 2 */
-	__BTRFS_SEND_C_MAX_V2,
+	BTRFS_SEND_C_MAX_V2 = BTRFS_SEND_C_MAX_V1,
 
 	/* End */
 	__BTRFS_SEND_C_MAX,
-- 
2.34.0


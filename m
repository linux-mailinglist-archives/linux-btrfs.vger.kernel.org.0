Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78C2B0FFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKLVTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgKLVTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:42 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0906C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:34 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id v11so5186447qtq.12
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZdzVbKXKTWCSSVuCIA5ezzqnUHUYDXMVoPocjX+P3kQ=;
        b=0/SsQo6uojVoQLFYu/ExGZ8GIU3hgjjI2/HozOtW+k+ecp/fjK5yx5dOfHU79oVKK3
         evaPuz411FLV/AEHjHTXkfmmWItF9Ge7xxgGHetowCMtHMXisF+DMuvfCs1cwU2VxZ+O
         1rOJ7V5g+FoBKbs85FRSofg43CiVONIqMLCzShQTWrsrc+urdIn392bI+jMANfQIlnOR
         2Kqrm3Mn9IVtvAFAX/aCk/I9UWdDc0d1cQ1V3ZTrodoXGtQv/ixaZ6R9fUhxUfleXKTr
         gYKRnGQFPpE1UMPsWMG2FJjg/Aosb30Gw357KT9v88yYrqmS0KxYVZgWg200Pn1qn27m
         Qpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdzVbKXKTWCSSVuCIA5ezzqnUHUYDXMVoPocjX+P3kQ=;
        b=IUe3P3pEU524oRc3im1fjtpd7DbXPLjmFLKiHiGCMbkiVj8w6or4KjzrJoUReoMa2L
         Q5lfQdn4Oxi04myxKRej5iqPVzzANoqHu1HRfIG5z96mY/XkVtBWfYQ1UNAQTZ758oU5
         On6WCTeZ8kXqwpNO5yCAfJMbP9/kDGz7IBPOeQZ112g6iiYTLCBcpsBo8PaQdLN+UyS+
         dLSt8v4A/yHXLdDHqrPRVwmRVXCiGlrcGNJgZdpHiGtAMXDh7EEhbkKVxsGDAH1a5RLT
         w/cmnP5jm7x9dXoCO+9yPaFY0W9QtX/ed3g0o0T7XU8Iq3fZGn5Ghuq2JKmHDUl8ao1a
         EQkQ==
X-Gm-Message-State: AOAM531OwomQPVe4psgR1+KaOYi/vhCscAk9yC7Wo74I31k4CNMAqDWx
        +PLeir0sPyoUxNyIesviX8U4SurtG0G4hQ==
X-Google-Smtp-Source: ABdhPJyORB6znxwM3hh217tZrErCbR9IBVm7a+LTf3rdUKhHOIWVl2EnWzzCV7WFbPyk95J4ypIUsA==
X-Received: by 2002:ac8:5411:: with SMTP id b17mr1205799qtq.281.1605215973331;
        Thu, 12 Nov 2020 13:19:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s68sm5680249qkc.43.2020.11.12.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Thu, 12 Nov 2020 16:18:38 -0500
Message-Id: <130ed227ab9287f3ea5f3cf78e9c0f33ee524ea0.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4eea3b4d9b56..ab7743c8bbd4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9066,8 +9066,11 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	ret = btrfs_set_inode_index(BTRFS_I(new_dir), &index);
 	if (ret)
-- 
2.26.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003C92B0FF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgKLVTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgKLVTc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:32 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133AC0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:32 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id t191so6911002qka.4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pEYF2BZ8vcrC+PAl3RKz2k4IMZqae5yph4xowc86t0A=;
        b=yxKlO1OjqgphAsYF+FaaFLOiWjC5piIbERGLduEEFWYqICme3Zr8oGAmYE7Ow8qp8y
         VcHD9APcR/wdnJoSuD+AYbNqUU7oq/7Jblx0rwg4GVq27Ntvv1mV/LcUMcaLmIJHf335
         oaRB1qS9yAmbUcgXH+4IpzVau0sbeEgWyLllEA2cVlkciYkpGxSFTc5AVIQR1aELPv1t
         aR39Yjxj9fyUVixPTHxiIuJ7CVpQO49FZnIBjY1U+YoC+5eKcwn6VKs57cv+3twhqwR6
         cm5yhKMPmr0TwcEf6SHzR4k9wO0lLfyf/jr5Ptls1MwVjMQF+rPbSvDhEq/OrtRpl3Be
         P5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pEYF2BZ8vcrC+PAl3RKz2k4IMZqae5yph4xowc86t0A=;
        b=P5ZaNRE+/hhAfmyxDG9DWjfTzt1mxO1ZWyBtgyWjSpzN0+zbWNiQw+eGOokxahH88w
         3/4wDgr7eNoSIrV1mBRJOYt08j8Rg+6wnbnHK3nDCIUD51lIxuWhGPOv9M5mRpmy0GSe
         PIDJxEwWgtkwO3bmhb/5PNgOi9PUuWcy3RseNqQ39lIbqC7+kBbCise2mG+m4O+HfwJV
         T/BZWMVRVb4GqF9Wp0WL9SnMn8tBkoBt0e8bN9cv5LzDlW8jUerl9bYf1uCWm9ah6CYC
         kuJ7R0YlEikwtUSxAi29Q/gv5ciyUBmvRWXc+hE93Bmm01KtTXAl8Obuan3F3zVquP5b
         ypkQ==
X-Gm-Message-State: AOAM530jUZuCPq1KYZILnoFitvOtFHqdOSWi8AxMrQOwISyOiwskrw4f
        3+Gq+SQ0qgYygiWk/ge0xzSASKYW9DH9Iw==
X-Google-Smtp-Source: ABdhPJwPW8dRC29uPYvmufh02+gbgSRnXixJX4FN9Ss6ZEiicDa1twH23jIyuiGBZUs363UnV3G0vg==
X-Received: by 2002:a05:620a:7e8:: with SMTP id k8mr1780774qkk.273.1605215971342;
        Thu, 12 Nov 2020 13:19:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o9sm5484355qko.53.2020.11.12.13.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Thu, 12 Nov 2020 16:18:37 -0500
Message-Id: <e5bc7db53d02593914f3e759013f840e1719b604.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 272ee4c8295e..4eea3b4d9b56 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8758,8 +8758,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	/*
 	 * We need to find a free sequence number both in the source and
-- 
2.26.2


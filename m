Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9549B2D2F8E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgLHQ0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgLHQ0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:07 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C898FC0611D0
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:43 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z11so7251754qkj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=41DzNviF+cXvKLLpMN146LL13hp9ctwVOiWwtInzkqY=;
        b=1rRiP1y/QDNjajD6y0jp4HNnBEmYLfuV0j0ubNRj5S4fpJkO+a2Jai6s/xViZx8aRR
         KDBHaXnHSV7/oOiKZIu9dAAUGfm+R9R6Hk49iQa4gkr8gOLxm2/mND8WJtexKESKy6CV
         HfTUvkmU/s2zpaDw43bc84zf8Vgur4cHyvnoy9wPAfC6602BU9C4N/iARQrWN90VZaW/
         we5H7SyERu8PmpB2aHWU7l3Hv0HLYP11rHkxAgNr+gQiwb1l/CuLlZUbP6TLXqXi82Vz
         1K6Nsx8Jg5vWE800GMbB2pUObxTBylUr+CESMGth8bx5tIxD6xFf3nMDtgARFbdCMF7k
         ZLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41DzNviF+cXvKLLpMN146LL13hp9ctwVOiWwtInzkqY=;
        b=FQcm45E6Lsw45W5yIi6LvnM1JLsRcz5jzWgipJ81WjpVFc7dOBPcx67kz8eM8zcDW+
         A0C2QN+jr6GKuQ8OIrRJqYjIwH7uguXZM19nwTAzilS3PWSU3qGl9cmiYCHqi0qhpQkB
         6Lg2YuZ1UViCTCjB+3Cbfe4//GIW8aYcIPSSFNOGNoviKA/Q1dBLG0PslRpLszfkPSuO
         Pg+hoibQIIWo7mVxMW6KHzrAbzMZgXHqzhALALFYDQuUSjv4SyXWAl8RMB14ZsNakNM0
         lYlztCGcMlrfvKMuOgm0nANTXbchu0dxI+k1gGDCE45V3nMVSbq/mKQBYlbuM+Jo+y7j
         rvWA==
X-Gm-Message-State: AOAM531mRfRrHwlh6ecUPfGmo7t0E3daPubQpnNascZWLePEJc899mcg
        lNlYFbL9Je/CC1fwbP56RJO3cApwWLuEdJDO
X-Google-Smtp-Source: ABdhPJzy6x/2wFwrkH2B2fU83+nOiDVMOTlGBZCeK2+kDzAJUM+8iGtkdT5++8RuxexrYtz2KTiIeQ==
X-Received: by 2002:a37:e109:: with SMTP id c9mr8965109qkm.370.1607444682767;
        Tue, 08 Dec 2020 08:24:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm13128075qty.30.2020.12.08.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 18/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Tue,  8 Dec 2020 11:23:25 -0500
Message-Id: <11b5534d1b697cd69bb322f8a7b863bbdcf9170c.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index 2f8bb8405ac6..bcbae8b460c0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9205,8 +9205,11 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
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


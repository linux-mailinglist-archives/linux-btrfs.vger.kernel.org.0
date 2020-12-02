Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC142CC718
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbgLBTxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389620AbgLBTxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:00 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5971C061A55
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:50 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id d5so1999588qtn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=noZ1Kc+J4nyrHrABZzAFflvlzcB1Er5gQQbDg7VGrHo=;
        b=z2KrJqVZHrOEyG6QGYwqluaGsCnNfxCQy7JUuTqhBAx0cMmf1P335Vv3FTpBONyrCQ
         XKmn5MeTQbbp1VA7VuTBqu5HgvQFPYm4Z53FD1EYGi29vWFQWVAWMEuCFgwoObZryvGV
         N0sSESpJp0zTvraExPC2h45KzAtdzwTfBmiZ6bRGqvx9/oESD+ER8dI46tfPGQ14vFPH
         de0em8ueO8e+y6aS9teulEcNbHk9Pxv5pKjNTgtyTRvoX8ZjaBC1yUb1WEqvuv+fqb9/
         b2rUjr2yXgcWFVijQsex4y1RlyzGsvwBXqvCDZriv9wo5heMLdaFRRODT4I0W+LohNuk
         yjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noZ1Kc+J4nyrHrABZzAFflvlzcB1Er5gQQbDg7VGrHo=;
        b=WaApWxS6ow8qvSaUHeMO9zT1PijwI3zTWuK2SGxeGLbJ6pdScXfdPxdRshnSGqN4nE
         dJ0aNOrQt2t6erv8SE62sxc6pZdVrq/NsAlwNl1AXZRMkhb4TsjQZdV7xHTFJoV+VAif
         9DE5rnZyzegPhYuGakKCpvmZ8mTM7qLpypDY6oan5QWdm2obPO60p2caK/OXR5WYHB1L
         N51tgD6MpSFsVnRmnmWhxGzziZmABPd4SzmycJnFDRFdGfmJLJNKFHT/XIrIatm8MEZN
         6JzcPN6h33QQ+9xrPLgIHuUnMegyAv79kprtUduVKh5Sar+EJ3anYrqDnRiL56FYMldk
         Yiyg==
X-Gm-Message-State: AOAM530pRRn4kCofoLQIfilHSeIyfKvzuhUupsBOqlt+yVjzf4kBUCpM
        g5talmFVtxKwM9zDqvlfyxnYjKgu7eAaNg==
X-Google-Smtp-Source: ABdhPJwVEUOwFLV3YQNaEjAVlhr/SGvDAPcuaORxjLOGGwzF/dRoW0uLq4sTsKDh4BVLxRsT7oUqkA==
X-Received: by 2002:ac8:7306:: with SMTP id x6mr4370882qto.272.1606938709573;
        Wed, 02 Dec 2020 11:51:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d82sm2800409qkc.14.2020.12.02.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 19/54] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Wed,  2 Dec 2020 14:50:37 -0500
Message-Id: <348d8accd247be56cbc57597aadaa46c85f0a5b8.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_delete_subvolume.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40601a0ff4f2..1f9fa63ef194 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4157,7 +4157,11 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		goto out_end_trans;
 	}
 
-	btrfs_record_root_in_trans(trans, dest);
+	ret = btrfs_record_root_in_trans(trans, dest);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-- 
2.26.2


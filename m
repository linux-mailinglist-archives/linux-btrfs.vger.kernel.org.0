Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0FA123ECB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLRFTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35395 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLRFTF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so323374pjc.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gXax7JZNE33dSeSAAj9Q3yDAJEhxjFi3NVywG/ZE27U=;
        b=HVY0YjTscWSU1U7smpamoqsrCMad9RtOsLTa6hdJjKb6LlEXNhmIWhaeNuf9WZW5WU
         GaT6L21nUSX4wpwoOt7lKRs3jDCRiGdq+X6DFB9v76OJmcrAT/M3h3LP1PC2fCaDH6ap
         OXJwNGSgA18Aa2+xybZW7GwZlaXSiQIb4vTcyrMD4vo9y+OgRgmlCf8mf5952CHLwh04
         mWfoDbP4LbQXt53dn3ZjE5kRD8FabAK4Yh8fopc5t3mxzzxhWaS+n2s/XjO694maYk6P
         xu1YzQeuWGA9Qd1JzLLGuM/Xp2QJMDpwQe/lPJ/ET8N5QxDDhl87WxIp+prGCURXkhHu
         qzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXax7JZNE33dSeSAAj9Q3yDAJEhxjFi3NVywG/ZE27U=;
        b=WU+p1ypuroo/xdwR9FS2vZCrywn6TOd/87KeYXk1cPUi7dpl9vsq0BowspFLyD7UiW
         kWnilaB/Fkl27X6OQzZm4SHPe/Z3iwUn+a1rnv5T8B+/8TP++BW6IiD2F34EhqSw/LPK
         KnlpQecP6qbLzTxC/e07QiBw6A6vC2JN0oOu+3T8KCdC3FLw4Jp0KZAk/iVzvRYs96er
         mT2LUgW5geXvKYZUYjocsH5siaLhRohi10dO7kQ8UfE6HeO7mPyKeuRYcrr3W7oB5HEy
         hYgKB3scT5eCWxPlQbx1qh85tSKYUghtdvx77ppaYr5DXYWGOFi8ct+XdtNOtBSHPmwc
         YoHg==
X-Gm-Message-State: APjAAAUjQySSmGhOgdUIEVElKJ86IgnrxT+CudvRU0TCve/FEhNAFbUf
        TswEt5QBMkzm/CfA79Wa0xmY2kbUv/w=
X-Google-Smtp-Source: APXvYqwRcJKAaeDQf1/efGG7hCDM127E6szCHWrnGNZjIkks6FvgChTXChajk0FBN+V3d37uSH7CSg==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr587615pjb.46.1576646344647;
        Tue, 17 Dec 2019 21:19:04 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:19:04 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH V2 05/10] btrfs-progs: adjust ported block group lookup functions in kernel version
Date:   Wed, 18 Dec 2019 13:18:44 +0800
Message-Id: <20191218051849.2587-6-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The are different behavior of btrfs_lookup_first_block_group() and
btrfs_lookup_first_block_group_kernel().
There are many palaces calling the lookup function include extent
allocation part. It's too complicated to check and change those.
It will influence many functionalities in progs.

So here, just make kernel version lookup functions run likely in
progs behavior.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index fdfa29a2409f..3f7b82dc88a2 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -238,12 +238,13 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 }
 
 /*
- * Return the block group that starts at or after bytenr
+ * Return the block group that contains @bytenr, otherwise return the next one
+ * that starts after @bytenr
  */
 struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
-	return block_group_cache_tree_search(info, bytenr, 0);
+	return block_group_cache_tree_search(info, bytenr, 1);
 }
 
 /*
@@ -252,7 +253,7 @@ struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
 struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
-	return block_group_cache_tree_search(info, bytenr, 1);
+	return block_group_cache_tree_search(info, bytenr, 0);
 }
 
 /*
-- 
2.21.0 (Apple Git-122.2)


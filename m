Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E852CDD6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbgLCSYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLCSYz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:55 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E09C09424D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:44 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so1434287qvb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mlb9YVtmht+31htgKs19UPJsESfebdEWDybZUIVc2fU=;
        b=YGpRlX/nLuP5rSJ7fiPEMPA+O48T7pN0sVLdmsvwrkqfwX/k+RPFA+zcJkZcXSOXxY
         OYWrC3WO6D+e3y1vcm+B+c3/VKhgNrbAOVlgCBYs9ClfkP2HrR7id2OO5WgnAj83mYov
         8Af2VnG6J5CLUWGD+DUyDUXP/aOHbjjJm0HhKsRFdg3pqi+cR4C82NayUCTNcQ/y4Jb8
         GBHgGt5MQVjfiE21/heBTBypCZeNbAMzuZv4ToKauKPoL8prNoL4THhVh5+SiIze3yeu
         Ko10MIAF6t3t1dQpY0/CsD1BmKpa7BZKOYkphn9QkZspyMrFM3AWUEjkfP7ymy0c+IrL
         835g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mlb9YVtmht+31htgKs19UPJsESfebdEWDybZUIVc2fU=;
        b=D/MGVN4g6CUGlzMsAGOtlpMWElCVWghTOwn5iDlxpDSE3FHCqHIWUSKiX1ctOVSe81
         S8mwjv2p1g3vGt7OkxonER3MDtA29bli58WYBZ0ksdDWDAcEpiIhYzMDdHZdJQdFTytY
         v72Bq8iiO9neBsFkieHTpdkukYsarVfBrrtsNfP8+4HFFLZVvszC3AsYs8V/2ZIwJzgO
         X2qXMerTYI62fUbIRUbzT/VWM2matebIDZhyRZxmqHupi6C+ESNFlabNOo4AzHezzQPp
         yYyrFWZRIi0pDNGzi87v9YZjQdFQxPKh3zdO3VYzfixF3s78O9S9po4n9dR3YCqBm2nU
         BLkw==
X-Gm-Message-State: AOAM531PSg3uHfzHgLrR9UoLa8inqhml6aNE6XfGmpu+aC8e/cY3vZpu
        SsdCNPABxwSmVHZXLolB8UcT3rmQLssUD1Sy
X-Google-Smtp-Source: ABdhPJwBwlzU57XcFteuRCdN04ta6yR8udvSjsM15brkWwZvVpb6OijcTzcJs0M4KDCXMyqjG3L19Q==
X-Received: by 2002:a05:6214:126:: with SMTP id w6mr282001qvs.35.1607019823369;
        Thu, 03 Dec 2020 10:23:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w192sm2260617qka.68.2020.12.03.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 24/53] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Thu,  3 Dec 2020 13:22:30 -0500
Message-Id: <c436f5c33eb8eb5ec86a662137b048606e60f66e.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in start_transaction.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 28e7a7464b60..c17ab5194f5a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -734,7 +734,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * Thus it need to be called after current->journal_info initialized,
 	 * or we can deadlock.
 	 */
-	btrfs_record_root_in_trans(h, root);
+	ret = btrfs_record_root_in_trans(h, root);
+	if (ret) {
+		btrfs_end_transaction(h);
+		return ERR_PTR(ret);
+	}
 
 	return h;
 
-- 
2.26.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39B14D409
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgA2Xuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:51 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44752 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgA2Xuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:51 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so598522qvg.11
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QizXhC/fwotbo7jleNlXYSv1MhdI0Sq60SA8fQaF688=;
        b=JcOOiwtMtnJ6nflbHNrqq6xavGCKQfsa7UGy7p1/X/kbtIhIfhooGuXazwjtzmZ0CR
         G3JccWxTcWh0yWfCvG1D57gM4BJyJ4os0vHfTGTAmGgECypUWSTZ63r7zIFDLkgcBY1j
         tRbQf5oTb0MbjnoViAL+YwGM88bOtIZB24VIP0JNGXlZQQXziiSNYXw18V4YXOmpoKG6
         /FAXUmuIUPGZ/irN3+7JwJvPxQgFPaM9R1KW8ymHshp0ghCsQdJ8f245GdkrJafZ0BoZ
         RsgSuUOfDEgG9AO7cbVsRzIrTrDB7c7petOIUdtID/dWxL8HuMBkbzeAh/RoSFyUso4O
         QPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QizXhC/fwotbo7jleNlXYSv1MhdI0Sq60SA8fQaF688=;
        b=tB5xUpXSyeQOuv8ztKsuF575Xtzv/TmPUnxkcNgrXdrpBODtVKvkvReNa6DU45eLq0
         eczK54aqe2IbBMMmFO9G0oZfD+EEeEcVDJNSpUNntgkKCCZeQcO5uCqUgD0QS8ydECRV
         gHq5pJLwnAg96spueh72uev/WWVxjHvH1Gz36x45tFBbnCgH36PY6lZFEmqHnYm539FG
         jKdefuX1Zz1Au9Fc/+Js3RU5gG8Q97HqExy7CS98Skov+JkuSxukQXR1lROQX9FKb0bD
         dHRrq49FCC/lg29+ejnO/VUVvZTxeWJ0wlMXzohQdjFGKaH3Nvi9ONOAiM2nSI6bXbGc
         Fcuw==
X-Gm-Message-State: APjAAAWUSYdxPfXPOPCUKhRGbBQjrPl9CazaHCL/uim2KhLCyW1PN473
        Ygb+zo5QUMY9nxYxw7142s6WiirfAijtGQ==
X-Google-Smtp-Source: APXvYqwQtoC5FEAo+y4KRTa/XomcEmhStpFqPflXiDwTz2944uhH39Ef6ti/eK0sHlyq4KvzVG8xfg==
X-Received: by 2002:a0c:c389:: with SMTP id o9mr1850226qvi.232.1580341849601;
        Wed, 29 Jan 2020 15:50:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s48sm1972035qtc.96.2020.01.29.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/20] btrfs: run delayed iputs before committing the transaction for data
Date:   Wed, 29 Jan 2020 18:50:17 -0500
Message-Id: <20200129235024.24774-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before we were waiting on iputs after we committed the transaction, but
this doesn't really make much sense.  We want to reclaim any space we
may have in order to be more likely to commit the transaction, due to
pinned space being added by running the delayed iputs.  Fix this by
making delayed iputs run before committing the transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b4c43af7b499..03e8c45365ea 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -857,8 +857,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 static const enum btrfs_flush_state data_flush_states[] = {
 	ALLOC_CHUNK_FORCE,
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static const enum btrfs_flush_state free_space_inode_flush_states[] = {
-- 
2.24.1


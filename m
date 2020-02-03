Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3137C15115F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgBCUuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:32 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45233 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgBCUub (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so15671973qkl.12
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vqpKuRQE6Hr0QtsgBEGRCqdqnkEeEYCYq9IV7B/vDV8=;
        b=Zi50bDUTINgtwocVatqxy+QXM30ll8w9Oj3slvhvYH8dPrvf+ipnRq6uhoXT6nrnuy
         cchzHn+5MXBLTDXlFlvqiqR+noAXx42U8+xzOnbmr1kTEoWbZKnQg3oG0KFxILaFtcIg
         BB8dmH7sRnNuexMjKZUQagy5HYxqkF4V8jpuW8nT8UU1baDlM8YNrSaS2gie3cTU+7R3
         jE5yYNy0tox5RD3n3ktHL6x3knzoLsZa2agedvWWaVlgdMkHRFV1upFLUelpoR9Nk43/
         Ib5gGlvJZ6GQeqnX3JWncQFsJ3rKCSW0osHls8mnHg0L00KNWxjftJC/ubVFLB4f/WgG
         AXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqpKuRQE6Hr0QtsgBEGRCqdqnkEeEYCYq9IV7B/vDV8=;
        b=bBKEdzE5Amipm1WeY0waGfvEQYh+nBPG6lNT5Qhy8ZJVfHepxljEytL81uWvHNN90v
         wOFQw0YZ9D44Ud4aedqQPjjKvGtGzz3cYUdlbCzGjOa2muumycLarFyTx4IawjRsXYO+
         ad46nFSdLUYLtXWehNP6i6phicyt56aY5Ffl1gfTRe7b4iUpEQncZ8BuuPbkvIp5rz2r
         0zbM1J5DpsidM7yiq/vkNW2xtZKqvR2oRmhk7/XLosj96lkg/4a+y1yRqmorJT0LER69
         94EqhbBu7AWJaN9/9TWA/DZM4wAdltp1bD/ePuiUg9vQAu4sZ+DGCUFwgiELv4WdPESC
         jrTg==
X-Gm-Message-State: APjAAAVhMbAcN+hHwgmnMCD3GPiMW/Cazy6eEgcyVjB/W8zCGWnmCrda
        NK2pcZG3lxEK7FNRpsWF2eTNa4LUEvVquA==
X-Google-Smtp-Source: APXvYqyLPIpVXH6KZe0cyLZc7Q7e/WTCdvGHWLyKLF3A44ICyaOwjGHlo20Z82gJB/7i1x1cHzscvw==
X-Received: by 2002:a37:4755:: with SMTP id u82mr24979131qka.43.1580763028927;
        Mon, 03 Feb 2020 12:50:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w41sm10752312qtj.49.2020.02.03.12.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/24] btrfs: run delayed iputs before committing the transaction for data
Date:   Mon,  3 Feb 2020 15:49:48 -0500
Message-Id: <20200203204951.517751-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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
index abd6f35d8fd0..d9085322bacd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -804,8 +804,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1


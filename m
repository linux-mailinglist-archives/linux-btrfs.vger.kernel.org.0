Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74473B405A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390434AbfIPSbQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 14:31:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40529 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390430AbfIPSbQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 14:31:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so273084pll.7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahLFaBldd/nMB/3GN3R6lV9DQ6MSCztrdhKZYlPPXNY=;
        b=Pf2C5Wvnsz6+Nslbfg3HiegcyX/rlWikczpocIIaMnE0ztlJI54nCu4kCW6fHUSJjD
         DfC5Ak10xBYUoO5rhFUMEBErpd1kNlToNUqxtBIHZ0Na3eUgukKFrVepyh32aZN4E2Sv
         XytoBr+5RsN5hCBkkJdx+T0cjj0k4A+ZYBt+xHWX8HzORHCDpGetctStLHnuKMgMb9ST
         0sjydxozxtz27pKFRhy4j7OD/63qy7NSckAC+pUGKH7G70Zhf4+JTeqEwTp0FGm0c9U0
         RFwlBvXBts9Y/2cvxprHxsfH4mxC+BXhZ6LPQSrfqWETPpckX2JTgMZ/pjRs0QVp3FLi
         I13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahLFaBldd/nMB/3GN3R6lV9DQ6MSCztrdhKZYlPPXNY=;
        b=gPR4T2Ahz/gRFLONl7WDgKSQATGK3lYa2kOUSGf3DCCvebGfHrAK4ED83gQIT6ThDS
         yTGI8waUdVBZmZXZvqY/yJVu9KpMnG0DZPDTnL5qfxUCjmqPyNogWrmFDyFI1qHuoxrx
         GEo+XLDg189OlZ1UhcRWMrRo1QkxRZLuvjOeq/DZQJKTuiXKYfE2vhj1jxdPOc5R+51n
         E87SEqQIVkFscDRiIudfl19BhShtrWUh9Q8UKyxTGc6huVwrZYDAR9sLUije/6z1cGo4
         04Lpf0Yl/PUjRA1mn/su5Qix3Qlsft3468UUFid4gumXZeRuFTBm1G+qLOTOfFSqPbzl
         34+w==
X-Gm-Message-State: APjAAAVBBnFdQSu11csMQUfOUcYS2SvosK44xjE6RrGSAkWrILG3IdJU
        JXDhdvf9oyQR3S8TVogeeU/xqZzBKgc=
X-Google-Smtp-Source: APXvYqzsLtTBwL2lTO8cTtLxOqxeJnfbemEWed/V1CQUPEgZ1exFg/ySQYr/mVY4h83LPDQXHe6PIg==
X-Received: by 2002:a17:902:aa06:: with SMTP id be6mr1187784plb.94.1568658675314;
        Mon, 16 Sep 2019 11:31:15 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:d0da])
        by smtp.gmail.com with ESMTPSA id i7sm24231385pfd.126.2019.09.16.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:31:14 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 5/7] btrfs: don't prematurely free work in scrub_missing_raid56_worker()
Date:   Mon, 16 Sep 2019 11:30:56 -0700
Message-Id: <469b0ce8c1abc7d86cf59228d81e300695fa0217.1568658527.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568658527.git.osandov@fb.com>
References: <cover.1568658527.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, scrub_missing_raid56_worker() puts and potentially frees
sblock (which embeds the work item) and then submits a bio through
scrub_wr_submit(). This is another potential instance of the bug in
"btrfs: don't prematurely free work in run_ordered_work()". Fix it by
dropping the reference after we submit the bio.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/scrub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7d4e03f4c5d..a0770a6aee00 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2149,14 +2149,13 @@ static void scrub_missing_raid56_worker(struct btrfs_work *work)
 		scrub_write_block_to_dev_replace(sblock);
 	}
 
-	scrub_block_put(sblock);
-
 	if (sctx->is_dev_replace && sctx->flush_all_writes) {
 		mutex_lock(&sctx->wr_lock);
 		scrub_wr_submit(sctx);
 		mutex_unlock(&sctx->wr_lock);
 	}
 
+	scrub_block_put(sblock);
 	scrub_pending_bio_dec(sctx);
 }
 
-- 
2.23.0


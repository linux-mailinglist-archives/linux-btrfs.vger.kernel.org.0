Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75F51850AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCMVMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:12:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40987 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgCMVMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:12:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id s11so3809047qks.8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eDEzxvDmITVd2vHk6pg1qrWvm+se1t2pDxfSOckeLV0=;
        b=CM/5VZYqerCOF2Q3xn2H2zDotyFd0YRM+3TSDm5zOHJ3UruHSw046+RT4YYI1rQgtl
         mQR9iMYbptg1QsYYmdRWKx6ALEiQYOfMsW9kxtPliQ4UdHnRklDxvnoALJLyCqDQIW/B
         nZpzAgtgDz3n18tfKt2oPkWP2Yh2TQyT7ayC/5ea1yqz1qWFrk03beBscFHkinQmtOsG
         6KNq0j8jnnACBRC1mPycIGNg/zS8LpH4nHRiwu667tN6VMc4Irl3bgieJ05pZgAtvDFR
         g4LLSuKNGPICKLUSB/egQTD6pHEAOTRaWbXkHYQDQllJhyGHssBrXEQGZm/XZ2G/1cjd
         YFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDEzxvDmITVd2vHk6pg1qrWvm+se1t2pDxfSOckeLV0=;
        b=ssMYrwAmztFXGR1ZfA2AxQlihEGy+P3yEVYFdJwdi4k85rbaFnz4Q3E49aRf/9Ea2A
         u3ItCpqDhbeXQbeumbH/nLke4fchdeskrIuCIhpquC+hEGhL3tsOnQ6AGCICsfCToRCw
         gKQ9bj9/VLhOOsaqmCe0ci7D8itow5OeMT/5NhfgCwkL1aOJUYYTiAWqp9t9diBvkoBi
         Q+Gxn/3iJTKXYia5XWlcuND98B+RC/T4+GMgJZ1MyUpK/k2h2wSJhpkmJEFDvmCACLZK
         /6eKRD0rXEUudxCaXOQdG5dcwTte7+irbkDeMcOBwIHiX3Q64Vr8EHcBBtvu6Ee3KOg2
         jMag==
X-Gm-Message-State: ANhLgQ157jDlZMGkIR0fNpoNGV6mR/IcnPRfwrVMU5yuTzeFrxpk2I1J
        05WygXUmJ9N1q+slEsyVMOBUoxHNhU5JdA==
X-Google-Smtp-Source: ADFU+vtWP/cpbdUBBa58Q97VHGapsa3Vl5bLjyzVrUC8vLjODv78XLid9Gia7zGAcd6RIwkhbuuG1w==
X-Received: by 2002:a37:2794:: with SMTP id n142mr14871625qkn.336.1584133946955;
        Fri, 13 Mar 2020 14:12:26 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q75sm1291676qke.12.2020.03.13.14.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:12:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: delayed refs pre-flushing should only run the heads we have
Date:   Fri, 13 Mar 2020 17:12:17 -0400
Message-Id: <20200313211220.148772-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211220.148772-1-josef@toxicpanda.com>
References: <20200313211220.148772-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously our delayed ref running used the total number of items as the
items to run.  However we changed that to number of heads to run with
the delayed_refs_rsv, as generally we want to run all of the operations
for one bytenr.

But with btrfs_run_delayed_refs(trans, 0) we set our count to 2x the
number of items that we have.  This is generally fine, but if we have
some operation generation loads of delayed refs while we're doing this
pre-flushing in the transaction commit, we'll just spin forever doing
delayed refs.

Fix this to simply pick the number of delayed refs we currently have,
that way we do not end up doing a lot of extra work that's being
generated in other threads.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8e5b49baad98..2925b3ad77a1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2196,7 +2196,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	if (count == 0)
-		count = atomic_read(&delayed_refs->num_entries) * 2;
+		count = delayed_refs->num_heads_ready;
 
 again:
 #ifdef SCRAMBLE_DELAYED_REFS
-- 
2.24.1


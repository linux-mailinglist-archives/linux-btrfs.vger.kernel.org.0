Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9492908E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410442AbgJPPwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410437AbgJPPwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC51C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c5so1895682qtw.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4EgaWystIlF90x35w9qnfr8J1eR6g4H9snf0FYgXNM=;
        b=TMBbf39boZXeTeFbH3pdmCFucKkJdqPThYxgxdsVdg0ABDwKQqjQjmm2OdJKZeKVYf
         sClW2tkdWTUU7QtDqZZ+mvPAqW7SYis3f5357bxVT3l3EA3fGrbX8M6cby+2XlHz5Tv/
         1aKSXWsQPNc/vSGGbA+rCOubDxTamGT/MDja2wGGv0YamB5Vue9wQ/RMavNZHfhlpse/
         7vuKB8A5++KaitOYEf3RDRcNtGB9wRXVZ5iA+x2tNBxnQqPUYtJxAFse0qluwZmYAWZw
         ra2pNeYNLx0k4WDh4d2NFv6Ry8QSDENhYobRrpkCg/8Ko9P72H3wHhjD1wfkJsZFNsmW
         Rx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4EgaWystIlF90x35w9qnfr8J1eR6g4H9snf0FYgXNM=;
        b=aBJkt+qVdTTW6s2s8mn1se/YQcSK39Ic5k9JYPbgz+0Zh20KcFUru14hZXuwkW9S3l
         PTBInERlRsWC8CzYCqC8kaBC6TZiRYCwS2VLwOiuYhcLmRotsemb5kgqyLZi933ywFyx
         SNlGA+1YWcqxDxNE28CF5TkJF7kbBpg3Msy3YadfiEmuIdRLq8nVO623Bhy/WZaHAXEU
         WJQWgcbCiUnUjeQYgw3ZeHjlI/+6s6zv/g18ZqLx8TWzm0qBB4zN5/dq6dU2QD1PRZqJ
         hMR0lByg/sxi0BNRB2+S1j/dP/KxzQIvInpK6fa2Dowp0T8HZdUyEYEHJEZlTGGL4ZOn
         YG4Q==
X-Gm-Message-State: AOAM532YIBRdYzWK7ngubO5fxJCQqAMH3VVYN+h6BxEkByF+2+Xovr6b
        fjkrj+dat20jjxqpRQjt9adD4/S+DL6U61EC
X-Google-Smtp-Source: ABdhPJylf5bHQ8y6ON6c6qafhotOPizNWrK8OHy5Lh6GEOXE6syzTWfOFHgISeaqCppbYVMklG/OXQ==
X-Received: by 2002:a05:622a:9:: with SMTP id x9mr4016696qtw.43.1602863562642;
        Fri, 16 Oct 2020 08:52:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p5sm1160575qte.95.2020.10.16.08.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:52:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 3/6] btrfs: delayed refs pre-flushing should only run the heads we have
Date:   Fri, 16 Oct 2020 11:52:32 -0400
Message-Id: <4ff8bc928e3770828b2e272e817bc649bf98ab6d.1602863482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602863482.git.josef@toxicpanda.com>
References: <cover.1602863482.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5fd60b13f4f8..a7f0a1480cd9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2180,7 +2180,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	if (count == 0)
-		count = atomic_read(&delayed_refs->num_entries) * 2;
+		count = delayed_refs->num_heads_ready;
 
 again:
 #ifdef SCRAMBLE_DELAYED_REFS
-- 
2.24.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78C28F878
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbgJOS0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733092AbgJOS0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 14:26:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973BC061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s14so3081897qkg.11
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4EgaWystIlF90x35w9qnfr8J1eR6g4H9snf0FYgXNM=;
        b=0qLqNG4eSfjCmFL/nHpba4eiTcGdwNtcAeAnb56P3lilk107CwUmc14ywLAD9ioSbg
         GkexLAN60nHsoDIX+lDx3/hgpfTUWJjXOVShsCLk2k9gOk2xSPjYwmHqNkBa8dfi1vPh
         Qs90YMh6bOAvrQDUs4hnGEnHq/pswchqa/K6sLU844IvVQ9h+aZWn27MRqeBy1O18QUh
         r1sIsDSLLMZpfEwHPRK70FyxM9I4/2RmqnBmbW5sQik56c7VM8IxIKJXgZErSd4Hg3vA
         QrUSJUORDum7LVyXVcAFDlD0TM2gIr8IUcQtk3D1HBffSeLY4UNoWqBbkfNhlHzwjM1s
         2k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4EgaWystIlF90x35w9qnfr8J1eR6g4H9snf0FYgXNM=;
        b=AhccSYAEOgAP00Eyiye3NiYYyI0tRSw8uJWhtUFWGplYen7HNSllk9f1TGecGhfhjy
         acxMvCfSP1Ppjuxpw9J6FyWH8yw7qmysTsKGh/s52GA6/IG+uNM4MijpOFeRiDu9Ux36
         y6hgMxLW/3RQqSud7PY8auyGCCVkY6Jl36xOblRt4y0MqNJB4rQHrYLZj3Ot+NhM2EOA
         yhdAA9GA73Fxhp5QUNib97YzdW2zocHJMBds0HatlHtMVJjlPkyO3eTFZ6CC5Hs5IWz7
         NaLdLsbQffPoXkkcBjg0QLJt/+Uxy0i9QC/mBmfH36yMq26JDKTfXkG6KP6qY2oBAYQT
         HIPw==
X-Gm-Message-State: AOAM532fk/c9t/Auxq54QSt8eVTlqGzIuzezVVY/2BRQG+LlbhdZnWn7
        0kw2BiPJZpnipf5yz5DySzXgrz5Q9vv8WAcW
X-Google-Smtp-Source: ABdhPJyRhu42bhUVTsMPv1vBllg3dLo8JF5ipBLBnEVMHMBL+lEo36viJct+s3goLpT7yhnAcy6WOw==
X-Received: by 2002:a37:7286:: with SMTP id n128mr48332qkc.389.1602786370061;
        Thu, 15 Oct 2020 11:26:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s73sm1466338qke.71.2020.10.15.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:26:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/6] btrfs: delayed refs pre-flushing should only run the heads we have
Date:   Thu, 15 Oct 2020 14:25:59 -0400
Message-Id: <3c46409986c30e2c0486963108948fa8b341fcc0.1602786206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602786206.git.josef@toxicpanda.com>
References: <cover.1602786206.git.josef@toxicpanda.com>
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


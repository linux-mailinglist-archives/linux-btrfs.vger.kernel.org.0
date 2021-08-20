Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146A33F2426
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 02:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhHTAlr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 20:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbhHTAlp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 20:41:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0912C061575
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 17:41:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s11so7526667pgr.11
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 17:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOHt7rn+jU+pE7g1S0ZUcZUWlWBn5nYBvbpYs4VDIwA=;
        b=AJx8wGd8Nf/s+KV4n/lSj+YkhXBRoQ3bjI0IvqvuvSse+z14VG93Df1hGdDPNXRs6N
         jeYdbRlCMeKWot68zgQS4G2o1uFZRToYIZA4UBvJnn/Xjr27ZAQcijRegv/zDPKpnOje
         jjjqD/o4YkDSjfqVU62LP4poGm1C1o0uhL1vcipFkXH8JhCYAxJ3JcBbqQIb24EcMhq0
         7eRfrYMtKJVPGitTXUlsjdSrpFjeB6hCEZtqM7sTBGNEsFjjgnLClQP4NUFdKRuda8Ff
         7DaL1MQe0oYwNBadBUXgib7bSlJnQyttRl0k7t4P5TPCF9faj1ejVSrdpGVVWIMgJxKu
         JA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOHt7rn+jU+pE7g1S0ZUcZUWlWBn5nYBvbpYs4VDIwA=;
        b=TmIsKjkJrh1utoBx106ceCTX3HksnVYjxLJlaoNFIZKwUApTgSNJxcGy4JPuNg2ASz
         4smXOl5S2hOh3SgGXPBzAPJttJ+XGxauU8JRHWcrdIFqIUjUbspir1rfhDegf2r990Id
         fjHkY37REAOYOVpPS1T759/FS4BxO2NlEdoRx7HX/9STHFFvhIpQOKZQVjwKW8eMIUI9
         5tvSXK8TO0nVC1B9Ny37oSzjRlVODBmq7r5SI4pjz5h8aFbjcpPO9GdamXJV8Zb3m8HI
         CwTGnODwcLnxK2OO4F7+bybk5Xn1afNKKFof3eTc42fbaqdBxfAvWWaaCmaFpwWKk1xn
         Qvkg==
X-Gm-Message-State: AOAM530rJAeJVvajQaEQ9O+Hrt1NGD6zTgMfNpWNCHkLwnNfkWolmQNT
        ZY2nU/Oq9y47eBFDhaACJfnqTeZgHezq2w==
X-Google-Smtp-Source: ABdhPJy1KRn+nQfcZnHVRcsntmzkv8+Zoq6upCGC1GPD1Jz/9fCO/NEdOEIry6ELjLzmVq/hqmsJ2w==
X-Received: by 2002:a05:6a00:1808:b0:3e1:f8c5:3436 with SMTP id y8-20020a056a00180800b003e1f8c53436mr17124669pfa.3.1629420068114;
        Thu, 19 Aug 2021 17:41:08 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n18sm4860028pfu.3.2021.08.19.17.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:41:07 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs: reflink: Initialize return value in btrfs_extent_same()
Date:   Fri, 20 Aug 2021 00:41:00 +0000
Message-Id: <20210820004100.35823-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_extent_same() cannot be called with zero length. This patch add
code that initialize ret as -EINVAL to make it safe.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - Removed assert and added initializing ret
---
 fs/btrfs/reflink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9b0814318e72..864f42198c5c 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -653,6 +653,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 	u64 i, tail_len, chunk_count;
 	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
 
+	ret = -EINVAL;
 	spin_lock(&root_dst->root_item_lock);
 	if (root_dst->send_in_progress) {
 		btrfs_warn_rl(root_dst->fs_info,
-- 
2.25.1


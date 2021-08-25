Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688563F6F7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhHYG2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 02:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhHYG2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 02:28:11 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7487C061757;
        Tue, 24 Aug 2021 23:27:25 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 22so25970145qkg.2;
        Tue, 24 Aug 2021 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyR/CYBwCSq/eASUQ7zPxYfp2tq9E82LCICgQ+jT9OU=;
        b=ddMOA86mIVJbs76Im8lYIB6JkibxFKwy5fUR6alDJYtvXr9PnOh8xBKTPBF7eJeohY
         2kLDC0VqgMuXTcPGqq6eQCO6cpcZJ408UBN5l6qd3A7OiI9Mzf5H/jnPu7HDYfUJokpK
         0TjCCpvRWUfjbB/c0F4jA+GZqxebDXJPobZgmO0ySjKNSHIpxjbDaATFi1K6ZhYad2jo
         YmEBpsswOyjl8XN8V8bnG8rT7aiLhE8LhtLCw3ngd4LDbgulX9f8yBaEs0/+LrzQt8aB
         iKY3XY9vY/g54JGI73CNOamD89Blmra8Qg6c3lLIj4rZzXdU68sRtXCGN2/CTd9PEdMs
         1/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyR/CYBwCSq/eASUQ7zPxYfp2tq9E82LCICgQ+jT9OU=;
        b=XlOnXgHSsARGEaq1LaiQiiHuSj3/6fAkhOHJRHYrYA1GsuQvhXvKuyxNMhNCCKHuo5
         nIO0MSnFMZ4k6y6uop8NYdLkY9fmMDAJSH+dpIfHiPfGmyK0kWQGpoWwHOuvmPhbGbZw
         IZ9HUmsr7A9IrAI4Shq7Oe86LSsFMJ9r3Y+to4GdhXwEfn1qj9x2LpMzAvbNH+0sH9DY
         TAGA8rK1+BFBmXXjP6a+Zg2hcqA13Hn72jb9fiP9ZHDl+jC3sE3v+tWc5Mim9EC1nV/w
         OyQXDgjrL3Dw2jPTspZ8dvQcMTf3waJaXvwGZ0rqsToM5DZ+M0O3Ae+4k4GLg6ePXOwJ
         /4ug==
X-Gm-Message-State: AOAM531hDbUq/dfziQqjZwFKIdBLIDyrOLKy5VDJvaWv8htN/hl/ZK3J
        UUutoa+qPJpnuwVSBhrVuRU/ZJJAP0k=
X-Google-Smtp-Source: ABdhPJyntecO96KhAS8GRvVfQB9FqlptG468oiKnISwSYDYmV+noNPEKiYbVsmR+mQiDBj3dIxTnMw==
X-Received: by 2002:ae9:e502:: with SMTP id w2mr18743218qkf.200.1629872845187;
        Tue, 24 Aug 2021 23:27:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z6sm8351002qtq.78.2021.08.24.23.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:27:24 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] fs:disk-io: emove unneeded variable
Date:   Tue, 24 Aug 2021 23:27:17 -0700
Message-Id: <20210825062717.70060-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Eliminate the following coccicheck warning:
./fs/btrfs/disk-io.c:4630: 5-8:
 Unneeded variable  "ret". Return "0" on line 4638

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a66e2cb..e531c4c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4627,7 +4627,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4635,7 +4634,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return 0;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4698,7 +4697,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 
 	spin_unlock(&delayed_refs->lock);
 
-	return ret;
+	return 0;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
1.8.3.1



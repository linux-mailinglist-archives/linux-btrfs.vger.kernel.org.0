Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2264140B78
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAQNsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:45 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43841 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:44 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so10696825qvo.10
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yNz1KaVY5W35P8l2RWD6RPsvPZy6AWNRXhC4pBcRTvU=;
        b=VGL1uatP/DcD5/TvjzxVWqQOLyWUneUX8NtHcJ93N93bBoHSB68goOsrojkP+b5aVs
         oFrQCwtln+ZbUjZnGkkXmLpMutaRuUOfueX7vGS09c6c0aVQP4hsX57fHdCQIXN30KLC
         5FLihtuR/oQ+77DEeGEIGl2ylUolITubU8/m9aEY4WsqFohOvxnzozjEYDI8Ug6Eda1b
         6BbZYiASJgqn7fYHD5W+uQ5njitGxubbJpcDHx4NL4doc2H0DlF5creODPnY8p3xIrGE
         aallCLeQ6ndTLs+YR7t0FMmML5Mcc7DKVKnl068Uy+rD8fMFwj54VQ0h9sy/PVYZSeHp
         uDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNz1KaVY5W35P8l2RWD6RPsvPZy6AWNRXhC4pBcRTvU=;
        b=sGssLi0t2+9SvMS1YENHdil7SdxenCOJ4oF3QHmga56lmYcJ9LatAsqduCTWlbd2ih
         0JapuQVM6JiLVllO4ebANiVARgTYNloF4OMNGvdL4ARDtj0WiDTN1Y8Pnz3HOfMYe6EY
         HwkLAUSWd0z3jn1ntwBO7YqlueqknalTYHQaiVdjOsQgDQACgB/xjA39M/xgolsdMS6n
         lFABSzBzI5sGJF3n67KqOQ/mW2ZwI583IO/f2s8SFCfbKX70qUqFp3xk85E6Wo9Na9HW
         nHmPrUE+9I3b8TGD/79mp1c0oTRxrUc4ZwWXSwmBe9LXk86nt6lA/aFExU4oRe7dL8zz
         ApWg==
X-Gm-Message-State: APjAAAWlzk9djnevHy/Qmvmb0Air8PrTdMbUyq0nfm703z41ifNKu/L/
        5h8/sZ5JZ1LOfikeEXew8JqH/n2EvmJP9g==
X-Google-Smtp-Source: APXvYqxiLTLI2BSD6vH/oKjWWPX7E4B7ouj8jhlmHvAbw1fVRL0cv3C74arQNez+bmEj7+JXTWVS3A==
X-Received: by 2002:ad4:5304:: with SMTP id y4mr7790080qvr.56.1579268923423;
        Fri, 17 Jan 2020 05:48:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d71sm11845072qkg.4.2020.01.17.05.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/43] btrfs: hold a ref on the root in find_data_references
Date:   Fri, 17 Jan 2020 08:47:40 -0500
Message-Id: <20200117134758.41494-26-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up the data references for the bytenr in a root, we need
to hold a ref on that root while we're doing that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 04d7892093bf..eaf945d515a7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3708,7 +3708,11 @@ static int find_data_references(struct reloc_control *rc,
 	root = read_fs_root(fs_info, ref_root);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-		goto out;
+		goto out_free;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		err = -ENOENT;
+		goto out_free;
 	}
 
 	key.objectid = ref_objectid;
@@ -3821,6 +3825,8 @@ static int find_data_references(struct reloc_control *rc,
 
 	}
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	btrfs_free_path(path);
 	return err;
 }
-- 
2.24.1


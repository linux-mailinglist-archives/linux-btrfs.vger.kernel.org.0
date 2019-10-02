Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46434C8A6C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJBODj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 10:03:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44749 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfJBODj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 10:03:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so15058093qkk.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9MpkCPqDG7yiVcy+P9d3xxew52g2Cm9Gv+hrv6u0rs=;
        b=tNfP4EGuNHWWiD3odMA1eW40bkoXXluZ0gSV1nr19XIy9fgAPX+tYbyyMskK3B7Rj0
         +zSIHwoquqjDHI/xGs5QhPQ1gBjIh+1iSbk2WMb37zlXCkR46n7Iu/YqqmKnYimYYTn5
         MfR5+RFoT8Why2HARvk0wR+CMjdGuf1tYdUW5d3A75vHmD3z717FC+84Pmq+cBBh29ir
         3K/1k8K7uveGLYArRqv7CQfe9XvET/s1POMQxo7nHQqfQYXviUNq+ZPvkkmbxqfLNO7D
         ZJ0YBg3g/A7r8E6s6QNoKrZ+utqIufh4YTb4zOhFUpwUvZ/cLJ3ve1IVK4kxzgzlY+m2
         zSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9MpkCPqDG7yiVcy+P9d3xxew52g2Cm9Gv+hrv6u0rs=;
        b=LsDszgmapFCBUY8V3BYWVrbznnlcGTjeaJBT3d5zFiGpjqgVCeQxn0AVxeg4lbiy0J
         WwhelOguusF4XYKbGjwW33mReNXRk/k+8S2hfKA1/lOuYagaqF41NscHouJzuRpZYABC
         IGBastwuY292bGNmthB8Yb8+i1sZ5Kx4C9evUjR85KbELQNEyoO7/lB83uK6ePXIgUpf
         DV2NgUKtfFAYeGbj9XVh5o/8UbqNMuNyJg5ej8NXS0s1TZLAJHir6nZr1qPJ3kKP1yKT
         DpJAGnO4/iw9WM/BiuJgnmC3yeJZVAtomMCh8hE/r+xraREeGjrLC3xu6mMAHm1tIGNm
         uWlg==
X-Gm-Message-State: APjAAAW+GrWEk8u9I7HJQ9stYYJ2qHGuzZp/m2mG7t/TLatdonGEEWp3
        90B/QRuAZAcLw/pOtCG3lruZA1mSRdi+fg==
X-Google-Smtp-Source: APXvYqxw/JO+ZDKPKF9g3WjgCA2zhlmTglJNNxeduZVNj/ZozhCBVL6XZUkQQ9x3k/rcWbD66FlhlA==
X-Received: by 2002:a37:b8f:: with SMTP id 137mr3662456qkl.466.1570025018185;
        Wed, 02 Oct 2019 07:03:38 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v94sm11130672qtd.43.2019.10.02.07.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:03:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] btrfs: fix uninitialized ret in ref-verify
Date:   Wed,  2 Oct 2019 10:03:36 -0400
Message-Id: <20191002140336.2338-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Coverity caught a case where we could return with a uninitialized value
in ret in process_leaf.  This is actually pretty likely because we could
very easily run into a block group item key and have a garbage value in
ret and think there was an errror.  Fix this by initializing ret to 0.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ref-verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index e87cbdad02a3..b57f3618e58e 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -500,7 +500,7 @@ static int process_leaf(struct btrfs_root *root,
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
 	u32 count;
-	int i = 0, tree_block_level = 0, ret;
+	int i = 0, tree_block_level = 0, ret = 0;
 	struct btrfs_key key;
 	int nritems = btrfs_header_nritems(leaf);
 
-- 
2.21.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64CC1412F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAQV1Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:16 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44261 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgAQV05 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id w8so8492777qts.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ckTN1AcxkeHORRhsqXj7YNF2NgUrl9S+/nMmxj1pRCE=;
        b=UJO99R+YUUzUKe90nVlRJmnRYMLsFbiMKGUWxWchpqj+k0typ/B1V++sYTc6SBXtcd
         AV7uzraPBILNUvUG09uHaVU20G5nLR3QSSDzvm9E87xR1r/L/Tuvz9m2+Sjr2wL0kqy7
         6+i+O7b6jZIwXpJ5zao6s2Cz7XG8ClUryxzW4NqwZut8a4jiPeoEOna9HplarTwxIeZM
         SfN9GjWgXJj1o+nS2rbZzf/3ZGD5tYZpSbQMacvcED6t8xwdCN4jG7d7N52X2/PgWAir
         5ZlkFrZKV/oPJ9MITIQ3AMmbCi6lfVNZ3y6KTgwFHc6/bDGEwxysrxjNvaSkLo9VMrHJ
         Po+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckTN1AcxkeHORRhsqXj7YNF2NgUrl9S+/nMmxj1pRCE=;
        b=KH/XdN6qM0Ho6p7hcs3szOZeufetAU8XgLKJ3GmoGO1jZRWc8EO4N4wykg0yhCVZsQ
         eLjZfRRYhTQx1HHs2nuo5ZViH8/DZ2/3iDn2tm00dFoG9J5a4HtzQRLzWKpCMqZnX1x1
         /fZsO6dydw1+YwML7+TufDjDGFis2+yVcxfE9yB1mwKtG7QFC9bnzgxrLyi8b9WpehbG
         LV/Rdon3+V3jgFNbyTCc48yV9v0PkuHjYvsHbqC8YijfgSzMQu9/qWW8FYd6YyB2pVnk
         JEIxr+BFRcUg7CqG9aPDbEkWbGLJ/tiZ1kF3GwWx+IF/fvtHZJXceyQYtapdNxeqzIZb
         swtQ==
X-Gm-Message-State: APjAAAVizj36SQnioxYtqO+No0yhG0akXwcYUppndkL+B6S9W+TmOyzo
        JPTqvYoH38/VEopkJmYaAZJebN8Zcnh6KQ==
X-Google-Smtp-Source: APXvYqxkUIDSTGWSlo90b+Euc7tQiRt1TmuVjWSRR8kXyIEY/PcYcNYtYArV6uDxaj1touLRoYEsQQ==
X-Received: by 2002:ac8:66c5:: with SMTP id m5mr9375678qtp.356.1579296416587;
        Fri, 17 Jan 2020 13:26:56 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 206sm12353209qkf.132.2020.01.17.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 29/43] btrfs: hold a ref for the root in btrfs_find_orphan_roots
Date:   Fri, 17 Jan 2020 16:25:48 -0500
Message-Id: <20200117212602.6737-30-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup roots for every orphan item we have, we need to hold a ref on
the root while we're doing this work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/root-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 094a71c54fa1..25842527fd42 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,6 +257,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
+		if (!err && !btrfs_grab_fs_root(root))
+			err = -ENOENT;
 		if (err && err != -ENOENT) {
 			break;
 		} else if (err == -ENOENT) {
@@ -288,6 +290,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
 		}
+		btrfs_put_fs_root(root);
 	}
 
 	btrfs_free_path(path);
-- 
2.24.1


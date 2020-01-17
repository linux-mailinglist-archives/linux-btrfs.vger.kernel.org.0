Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602791412D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgAQV0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:25 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43454 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:25 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so11357780qvo.10
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yVe7M85mDPSaRnTaTez6+sgZrvbrxmWfQjAWN+qlcaE=;
        b=RZfkQCOsBdDjMpxRPCA4ax0nN77LkrHmXmHgzU8uPYC4Ph2I+LWeRkcKllzxEGn4H7
         lFfOjauI3Sk1dx680Z9oMi8nGj/rlO0VcP/ltqhExsyUfH63QuapbOZYP7Of57dQ6Aws
         RO+YuhCzzMqh8yTDFwRIZMkSpcmbp97conlW0Mearc6cF3FzBY/aulDeVb9o7TrFxYUM
         yIX+EQVLRW1m1ZvxP0tuHvJDyzZ+/7EpRA/mHEITo0oEOHJGOllkAMYC2IRiuTYGk/J9
         dUA0lTZCeXP2oTLSx0Ep2ixgEZBRDtekX7PTL+71UrD/4prC1/MzcckicUK36RY646N7
         Hz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVe7M85mDPSaRnTaTez6+sgZrvbrxmWfQjAWN+qlcaE=;
        b=bqd4BPGIqAEmD7bCmmS6bCmhHQ6yclpd+l9e21KgZv90ab6eyMrhu0MIweqPgw//hn
         aHFRgmfP5SkDE6lIZYTNCHviW4jZF1qEuPZMYk3eKqLjoufwrp7kZxHm4k/DkylH/Vf3
         YazKxvnxTaHVA2QjMHAMbKC0o5IgGGNLzczSqlSot1iBrCNVybqqQnzCXBF8mLBm0f5l
         dFTBB5l3U/OaWX2JqOgDivGnweGai6BroXF30Qx2LBywigcKtSM5x4ovNP3cgEv13Y7r
         SV8QrPgcCHs98RqPw6Z0gzkcDjW8ZrrXTo4dDrDyGdPW3zybL/cybZ3K6stQEhi9dF90
         zt4g==
X-Gm-Message-State: APjAAAV/F1LremexvJDvLHbr0F/sMf4lgrlYhFjJblVHACXyXz6WxZc8
        D3bA68ikv4ryGSFi1caRZ3CRIQquzW7Onw==
X-Google-Smtp-Source: APXvYqyelFCCl3hTo1BZvrp69rzx/ci+FHYyAZ4b/BWal0dhU2x1Ye9V9Q0ZHOxUH3KF2d9gvsRH5A==
X-Received: by 2002:ad4:49cc:: with SMTP id j12mr9724340qvy.188.1579296382113;
        Fri, 17 Jan 2020 13:26:22 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p126sm12370407qke.108.2020.01.17.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/43] btrfs: handle NULL roots in btrfs_put/btrfs_grab_fs_root
Date:   Fri, 17 Jan 2020 16:25:28 -0500
Message-Id: <20200117212602.6737-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to use this for dropping all roots, and in some error cases we
may not have a root, so handle this to make the cleanup code easier.
Make btrfs_grab_fs_root the same so we can use it in cases where the
root may not exist (like the quota root).

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 7aa1c7a3a115..8add2e14aab1 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -88,6 +88,8 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
  */
 static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return NULL;
 	if (refcount_inc_not_zero(&root->refs))
 		return root;
 	return NULL;
@@ -95,6 +97,8 @@ static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 
 static inline void btrfs_put_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return;
 	if (refcount_dec_and_test(&root->refs))
 		kfree(root);
 }
-- 
2.24.1


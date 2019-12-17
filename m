Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF3123096
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfLQPho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36567 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id q20so4363497qtp.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O7zBvaSKAyD6OCWpsvhd1OfmsSFvdhkYskFZqQuyvWU=;
        b=gNeBcArB1B4rgSueZS0HoVyMhc0xS459fc18gEJge8nCrQZZVO5OOtwfiEl3Zf53KX
         Xwe7v7abZ8rV/dow2abJOioxd/90rmb5m636624Y95r1ZbopW85eKjJLMcwMEXwmuQnC
         ZvtNFhyEcQlmku833rJaiGR5SAOqVaXLnZpLDJ9J3A7l/bS29E5k6sQzoibQuoSK7mJ9
         zac0wgRgomjX75bIbi/ygqBYzEpyzpBkjX8GfTY7Ob2vNlHQtkMSnFAw3I2QrdOZEgtr
         DvUulMEvcuA7VUmhiKG0kd3PxvxTZrEncs2Jtj4uQOYgtLNC/OfaBZt9MW6x+46/YrfC
         bMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7zBvaSKAyD6OCWpsvhd1OfmsSFvdhkYskFZqQuyvWU=;
        b=BEL5VXbEwOAz1ki5qyH4L3HMBSsbnf6HCwTN0i6lf2TeTfuaWVkDEgJvxySnJdMKPK
         6fEZ1LlWOC7v8J592UWtmIdu449syAzzjZTqS8RF0B38KhHeJipZUGnkg9qMDJDm5ZaY
         m0dBGn+53hx1yfRKb9zb+Ls1SuJDRbyOW1fqo6qqzeuuWaEeE3oxRm0W1nC4hd4cfRou
         xk8iSgAeWCVunJapWwcmOvfN8eiL3T16F9podoqvntEPoEnzpy5LXgSTXUKpamGH8MjM
         4XeT0U1jL8BU5AKZCjvxwvZXbN/mzm3nOtL5jeVahMV+LDATa7QBT7VER9tyt2zP7njB
         iMbA==
X-Gm-Message-State: APjAAAW02M7nrZCjOmXg9vNoR2sVNgTS8UiM97ozoobhxL+KV3ltbYdT
        3+yg0xpmSWAw2zSc1ahdpLYmAjMCxk1omQ==
X-Google-Smtp-Source: APXvYqwv9PdzQpZjxRpUwmh6l6wyf3GlluKp9epgArafXj92zg2F4SRj+Iifv88uaRU2wkvHIfrK/Q==
X-Received: by 2002:ac8:7501:: with SMTP id u1mr5102696qtq.149.1576597063192;
        Tue, 17 Dec 2019 07:37:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g81sm7178700qkb.70.2019.12.17.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 36/45] btrfs: hold a ref on the root in btrfs_recover_log_trees
Date:   Tue, 17 Dec 2019 10:36:26 -0500
Message-Id: <20191217153635.44733-37-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We replay the log into arbitrary fs roots, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a4321bdcbf3e..07e7fd508213 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6292,6 +6292,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.offset = (u64)-1;
 
 		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
+		if (!IS_ERR(wc.replay_dest)) {
+			if (!btrfs_grab_fs_root(wc.replay_dest))
+				wc.replay_dest = ERR_PTR(-ENOENT);
+		}
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
@@ -6348,6 +6352,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = NULL;
+		btrfs_put_fs_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
 		kfree(log);
-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7227914F4D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgAaWgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41632 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgAaWgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id u19so553712qku.8
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EHvMaa3HgJQBaukxZ/rw4Q8tIRtNIO6L/belh7SMG74=;
        b=Zn57qzmON1nszVjm2/meCW3nlQs16PincdPQRm/xSxkGCjxJA+U2L3Dw13u6XvxUBH
         G6vO12QlNCQSEXl9jCGy23cXp1EGyS983h2zk62CMWWu03V6twI3JhzOR2k0YAVwICbv
         k3yVGz4P0gI4Qj5etIqxFxeiSmIQe2wiYFF7raKJNMJHWeB7LbrFWACxzyr3avLhhTJU
         QyPL36MK/yGdZeM+9r5JVYCM3uk97YnKHb5v6U586bnvxo+ECbK91tvI2g4OrZBYoSkH
         L8i0pHUlyY4eQxXkUSzLcyBaxG8BkENPDzHhJqYpuiYQF2+TQqAm3BextY92RsswkdED
         xqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHvMaa3HgJQBaukxZ/rw4Q8tIRtNIO6L/belh7SMG74=;
        b=d93zF4iNO2NxqkLV3DFT2IHc7zo7H4llKAjMTNeABs9A3ExLxw6HqFl9aLP5y+5A7r
         6dgatgTZWeuBubDBZQKtyOzxzfxsfkfn8uQGfufmHrYe8jsr0hKpBkXXiGP7e451YmhZ
         0uJcycCSm7FVqgooX5vBiM8Gg82Z54mMsf/IQvV6HnalidWFDd2Qx2ka51exWHkJ1/9b
         +AKt077qcSiV7SjHlp0U33vQE6+aWzC6SExabiGLmZLGFbNlZiLMlE9stzYFl/YvsuIl
         G/S0/ZmWpHfD3Ya4yxiItpKDv07qHCz1QyA2HpFrlQEhNwjHA1ZBkuWgu0T26FrGSpgG
         //pA==
X-Gm-Message-State: APjAAAVgKu1JgXC6GDx2/iJkRUFG8mlIqt0MrqZiIzaCmqH65gAxxyzd
        6iUOG9KnKC4W/QFlIfDCaApbZMqCkqvGgQ==
X-Google-Smtp-Source: APXvYqyy9FZCT8aSim75r3kPCH++vRcU2sWi0cMPkLWfyk/eGmy5OEqtMsuXBAFQT1J1UKiSSyKLyA==
X-Received: by 2002:a37:a881:: with SMTP id r123mr13427460qke.275.1580510198916;
        Fri, 31 Jan 2020 14:36:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b30sm5189205qka.48.2020.01.31.14.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/23] btrfs: add flushing states for handling data reservations
Date:   Fri, 31 Jan 2020 17:36:03 -0500
Message-Id: <20200131223613.490779-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the way we do data reservations is by seeing if we have enough
space in our space_info.  If we do not and we're a normal inode we'll

1) Attempt to force a chunk allocation until we can't anymore.
2) If that fails we'll flush delalloc, then commit the transaction, then
   run the delayed iputs.

If we are a free space inode we're only allowed to force a chunk
allocation.  In order to use the normal flushing mechanism we need to
encode this into a flush state array for normal inodes.  Since both will
start with allocating chunks until the space info is full there is no
need to add this as a flush state, this will be handled specially.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 2 ++
 fs/btrfs/space-info.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6afa0885a9bb..865b24a1759e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2526,6 +2526,8 @@ enum btrfs_reserve_flush_enum {
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
 	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
 };
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9f8ef2a09ad9..ad203717269c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -816,6 +816,12 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
+static const enum btrfs_flush_state data_flush_states[] = {
+	FLUSH_DELALLOC_WAIT,
+	COMMIT_TRANS,
+	RUN_DELAYED_IPUTS,
+};
+
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
-- 
2.24.1


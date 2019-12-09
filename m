Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2C117628
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLITq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfLITq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so7758553pfo.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EZWLYFvOu5bkp8WfSicicLL9EpWL+yOHxU20GbXIJwE=;
        b=pjRNHdxZtWhMFxfEmGyll3uXOT3JfCqbheCoySrQZfgRL1epbVC3EYaXpifKaKdJnU
         Ev9oUG+SI6dUQkd8J0Rvm5ym+M/5vN6v1IjgeBlQrrjtGOGwCO1r4vft72ROlhwJliwf
         almqbenn28Wa14E4tgxBqbHSfyc0FUIM7O3nkLGiJ1AqfJWV51zwPR6oNwM45G3qx1ny
         H67hCgmwL0NB/KpPECCMwQiHk4rghos0kao8pLIK8o/pgIBwP6jYZtAek+1Bw52Qom8S
         JX6047Ju1d7qjENcUWyg0kjlMgA05m2atC/XuzhRyHz2QOGK/PGRFzZ6PrRSOi/SWWbI
         vFrw==
X-Gm-Message-State: APjAAAVjlvKSSZjb42vBcv1CkyjDIge47I4oUjYpAjV+Pq87Bi2ORlkv
        cpB2nrQlXlPkO/eMR50RS1c=
X-Google-Smtp-Source: APXvYqw6Tz61uBHSEgXGCq3huqFr65AtQUpcqMICZkP/qerNIbP0K+vHifq+x9ucOTHD8MbjovQFdA==
X-Received: by 2002:a63:f910:: with SMTP id h16mr20829805pgi.148.1575920787031;
        Mon, 09 Dec 2019 11:46:27 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:26 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 15/22] btrfs: limit max discard size for async discard
Date:   Mon,  9 Dec 2019 11:46:00 -0800
Message-Id: <27178539383762cd11b08454a1a29386a8c71251.1575919746.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Throttle the maximum size of a discard so that we can provide an upper
bound for the rate of async discard. While the block layer is able to
split discards into the appropriate sized discards, we want to be able
to account more accurately the rate at which we are consuming ncq slots
as well as limit the upper bound of work for a discard.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/discard.h          |  5 ++++
 fs/btrfs/free-space-cache.c | 48 +++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 3ed6855e24da..cb6ef0ab879d 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -3,10 +3,15 @@
 #ifndef BTRFS_DISCARD_H
 #define BTRFS_DISCARD_H
 
+#include <linux/sizes.h>
+
 struct btrfs_fs_info;
 struct btrfs_discard_ctl;
 struct btrfs_block_group;
 
+/* Discard size limits. */
+#define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+
 /* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 57df34480b93..0dbcea6c59f9 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3466,19 +3466,40 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		if (entry->offset >= end)
 			goto out_unlock;
 
-		extent_start = entry->offset;
-		extent_bytes = entry->bytes;
-		extent_trim_state = entry->trim_state;
-		start = max(start, extent_start);
-		bytes = min(extent_start + extent_bytes, end) - start;
-		if (bytes < minlen) {
-			spin_unlock(&ctl->tree_lock);
-			mutex_unlock(&ctl->cache_writeout_mutex);
-			goto next;
-		}
+		if (async) {
+			start = extent_start = entry->offset;
+			bytes = extent_bytes = entry->bytes;
+			extent_trim_state = entry->trim_state;
+			if (bytes < minlen) {
+				spin_unlock(&ctl->tree_lock);
+				mutex_unlock(&ctl->cache_writeout_mutex);
+				goto next;
+			}
+			unlink_free_space(ctl, entry);
+			if (bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE) {
+				bytes = extent_bytes =
+					BTRFS_ASYNC_DISCARD_MAX_SIZE;
+				entry->offset += BTRFS_ASYNC_DISCARD_MAX_SIZE;
+				entry->bytes -= BTRFS_ASYNC_DISCARD_MAX_SIZE;
+				link_free_space(ctl, entry);
+			} else {
+				kmem_cache_free(btrfs_free_space_cachep, entry);
+			}
+		} else {
+			extent_start = entry->offset;
+			extent_bytes = entry->bytes;
+			extent_trim_state = entry->trim_state;
+			start = max(start, extent_start);
+			bytes = min(extent_start + extent_bytes, end) - start;
+			if (bytes < minlen) {
+				spin_unlock(&ctl->tree_lock);
+				mutex_unlock(&ctl->cache_writeout_mutex);
+				goto next;
+			}
 
-		unlink_free_space(ctl, entry);
-		kmem_cache_free(btrfs_free_space_cachep, entry);
+			unlink_free_space(ctl, entry);
+			kmem_cache_free(btrfs_free_space_cachep, entry);
+		}
 
 		spin_unlock(&ctl->tree_lock);
 		trim_entry.start = extent_start;
@@ -3643,6 +3664,9 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			goto next;
 		}
 
+		if (async && bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE)
+			bytes = BTRFS_ASYNC_DISCARD_MAX_SIZE;
+
 		bitmap_clear_bits(ctl, entry, start, bytes);
 		if (entry->bytes == 0)
 			free_bitmap(ctl, entry);
-- 
2.17.1


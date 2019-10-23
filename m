Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E775AE26AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436943AbfJWWxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33596 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436935AbfJWWxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id 71so17639801qkl.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PYOKZ/1QajvnP3fueqt/XcahZsRMffUtiJV5/Gx2ziM=;
        b=mZ05iX3zYsc4XggjNeA9pvriaZt7fZe7UXV1fwyBKGce7qmhAOsrKI2TcpsmRnH5LV
         1wQZt7O1r3KRjQgBup6GBpw3XAFZlTjXxFiGuve9s5hD5oQXP3TrYvMUTzD0CtuCElZ6
         8hR8aCbA2t5fs7Dn1IhZPcFE8eG07hz9ebVVNaBaVngMUseaPG79cRsS7bX1J1zEd2yi
         4W1Om1yxUN5VhwrS+uDuA/Ya0ulSSwwsbV+RrA8chTjvJ0SeKTi9/lAceEsEG1Khhzai
         SQVM604NNmILp+IxJuYf6WDhatIpW852bhYdsV6F9OJeWlFR1pHe1Z3FzYL0mEifuJsB
         F6pg==
X-Gm-Message-State: APjAAAUoGc1419glSH5Ff21YLCPV1N8vAuW6a0agZZmIrFB8f+AuXArO
        M+Zq8dKrdNtgMjQF9urpVN8=
X-Google-Smtp-Source: APXvYqzsGVi6PBnL4Y8oZsVIiibB8fXUZlp1Aim99CGXp95OBRXBNtRWwENkQcfrZlU3uniFOhlInw==
X-Received: by 2002:a37:4793:: with SMTP id u141mr7480720qka.402.1571871216692;
        Wed, 23 Oct 2019 15:53:36 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:35 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 15/22] btrfs: limit max discard size for async discard
Date:   Wed, 23 Oct 2019 18:53:09 -0400
Message-Id: <633cde192d549559b675e1182bcf61c4f2dc58ca.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
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
index 2d933b44abd9..c1e745196b6c 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -5,10 +5,15 @@
 #ifndef BTRFS_DISCARD_H
 #define BTRFS_DISCARD_H
 
+#include <linux/sizes.h>
+
 struct btrfs_fs_info;
 struct btrfs_discard_ctl;
 struct btrfs_block_group_cache;
 
+/* Discard size limits. */
+#define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+
 /* List operations. */
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8d4ffd50aee6..186a4243fb7f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3440,19 +3440,40 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
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
@@ -3617,6 +3638,9 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
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


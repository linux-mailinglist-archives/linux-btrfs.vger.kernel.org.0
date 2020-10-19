Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C7292F11
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 22:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgJSUCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 16:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJSUCg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 16:02:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D5C0613CE
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 13:02:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so763254qkk.12
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fXYCCYXHBX5l0Sbyb1496rfUsO/YuyNVFV/BnqqaHLY=;
        b=y5UybrOdijCvA7blWpk/fm8osXM9rKSXiFAi6eE/mGCN+zHRWZXb8GZKQnRRnwbv8r
         BnQEmFPkRyvZWYXZL3zt0tt2YvUpJPJWlwhfz44nr+TwlTtdtq0HCpxTT1IGZLKI04JN
         x1ORTkCZx+9WV6lZs8v5tDpFm0SmjRVRpq+AIH2zuSZ2aPU/rl0ssgnhFo0ig6ReqKsS
         B9JYbRtx0tnJliG6hQsNHdmHJPRdajpEABen6BKZUGs6Qfvn8x5ZzUrKfNhNHlQHceZs
         Yqzd+29dePsA8DOPYA2sADKAbeJQhaPtdhw/W0HNPABOipxq7RrZoLX40BlbEfgFsezr
         LSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXYCCYXHBX5l0Sbyb1496rfUsO/YuyNVFV/BnqqaHLY=;
        b=KajFj7DzrLQb7GNPGQQNu0eAziyXnGTQcEJpQrGeTyuHh6td6rJ5gf8aZb8NbYKr8h
         cN6AkwOi2QBPS6Y8nm7fzU66b0Itn5/Bak83AdujCq/Kdc0QCLQa1tZ4IA2EvuSaG1uP
         rbem1rw84ZOj0fXT+VaRbRF9Br9NiaUwDyiKne2dChoZwVca/PMXnZh64jaocU55zidG
         KfC4s2lj3qY7wWZPH/frfE9qCYEpZ+2hRCO26+b64WqXySAFQz+WTM9ukRgRWk8ZCkkj
         A/XOuZGGSN80TxlWzGGK5SEn4A9Kbnxluw/1EljHgYZdJr1oqgHWGwQ73OF5gPhw0Tgy
         +SHg==
X-Gm-Message-State: AOAM532h00ito4cO+dnrIC2SM3FlONEq2rVsMGYa6+JCM3Byw9Ag2Fzb
        lISujnLfxCacQMY3YKXh+S4DYfOEsap98RDJ
X-Google-Smtp-Source: ABdhPJz5+w/0q7AEYdYIsOGC13BkUd1CESqZTptvRwl9fzU703DpKRN7pfdTmkEHtFK+9gdvKDHKVA==
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr1275290qke.271.1603137755151;
        Mon, 19 Oct 2020 13:02:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u90sm394194qtd.29.2020.10.19.13.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:02:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: drop the path before adding qgroup items when enabling qgroups
Date:   Mon, 19 Oct 2020 16:02:29 -0400
Message-Id: <f0fc7512506f008dd356cffe49a17990199ff6f4.1603137558.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603137558.git.josef@toxicpanda.com>
References: <cover.1603137558.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When enabling qgroups we walk the tree_root and then add a qgroup item
for every root that we have.  This creates a lock dependency on the
tree_root and qgroup_root, which results in the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.9.0-default+ #1299 Not tainted
------------------------------------------------------
btrfs/24552 is trying to acquire lock:
ffff9142dfc5f630 (btrfs-quota-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]

but task is already holding lock:
ffff9142dfc5d0b0 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (btrfs-root-00){++++}-{3:3}:
       __lock_acquire+0x3fb/0x730
       lock_acquire.part.0+0x6a/0x130
       down_read_nested+0x46/0x130
       __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
       __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
       btrfs_search_slot_get_root+0x11d/0x290 [btrfs]
       btrfs_search_slot+0xc3/0x9f0 [btrfs]
       btrfs_insert_item+0x6e/0x140 [btrfs]
       btrfs_create_tree+0x1cb/0x240 [btrfs]
       btrfs_quota_enable+0xcd/0x790 [btrfs]
       btrfs_ioctl_quota_ctl+0xc9/0xe0 [btrfs]
       __x64_sys_ioctl+0x83/0xa0
       do_syscall_64+0x2d/0x70
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (btrfs-quota-00){++++}-{3:3}:
       check_prev_add+0x91/0xc30
       validate_chain+0x491/0x750
       __lock_acquire+0x3fb/0x730
       lock_acquire.part.0+0x6a/0x130
       down_read_nested+0x46/0x130
       __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
       __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
       btrfs_search_slot_get_root+0x11d/0x290 [btrfs]
       btrfs_search_slot+0xc3/0x9f0 [btrfs]
       btrfs_insert_empty_items+0x58/0xa0 [btrfs]
       add_qgroup_item.part.0+0x72/0x210 [btrfs]
       btrfs_quota_enable+0x3bb/0x790 [btrfs]
       btrfs_ioctl_quota_ctl+0xc9/0xe0 [btrfs]
       __x64_sys_ioctl+0x83/0xa0
       do_syscall_64+0x2d/0x70
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(btrfs-quota-00);
                               lock(btrfs-root-00);
  lock(btrfs-quota-00);

 *** DEADLOCK ***

5 locks held by btrfs/24552:
 #0: ffff9142df431478 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write_file+0x22/0xa0
 #1: ffff9142f9b10cc0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl_quota_ctl+0x7b/0xe0 [btrfs]
 #2: ffff9142f9b11a08 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_quota_enable+0x3b/0x790 [btrfs]
 #3: ffff9142df431698 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x406/0x510 [btrfs]
 #4: ffff9142dfc5d0b0 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]

stack backtrace:
CPU: 1 PID: 24552 Comm: btrfs Not tainted 5.9.0-default+ #1299
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
Call Trace:
 dump_stack+0x77/0x97
 check_noncircular+0xf3/0x110
 check_prev_add+0x91/0xc30
 validate_chain+0x491/0x750
 __lock_acquire+0x3fb/0x730
 lock_acquire.part.0+0x6a/0x130
 ? __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
 ? lock_acquire+0xc4/0x140
 ? __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
 down_read_nested+0x46/0x130
 ? __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
 __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
 ? btrfs_root_node+0xd9/0x200 [btrfs]
 __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
 btrfs_search_slot_get_root+0x11d/0x290 [btrfs]
 btrfs_search_slot+0xc3/0x9f0 [btrfs]
 btrfs_insert_empty_items+0x58/0xa0 [btrfs]
 add_qgroup_item.part.0+0x72/0x210 [btrfs]
 btrfs_quota_enable+0x3bb/0x790 [btrfs]
 btrfs_ioctl_quota_ctl+0xc9/0xe0 [btrfs]
 __x64_sys_ioctl+0x83/0xa0
 do_syscall_64+0x2d/0x70
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by dropping the path whenever we find a root item, add the
qgroup item, and then re-lookup the root item we found and continue
processing roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 580899bdb991..573a555b51d8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1026,6 +1026,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
 		if (found_key.type == BTRFS_ROOT_REF_KEY) {
+			btrfs_release_path(path);
+
 			ret = add_qgroup_item(trans, quota_root,
 					      found_key.offset);
 			if (ret) {
@@ -1044,6 +1046,20 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				btrfs_abort_transaction(trans, ret);
 				goto out_free_path;
 			}
+			ret = btrfs_search_slot_for_read(tree_root, &found_key,
+							 path, 1, 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto out_free_path;
+			}
+			if (ret > 0) {
+				/*
+				 * Shouldn't happen, but in case it does we
+				 * don't need to do the btrfs_next_item, just
+				 * continue.
+				 */
+				continue;
+			}
 		}
 		ret = btrfs_next_item(tree_root, path);
 		if (ret < 0) {
-- 
2.26.2


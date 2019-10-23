Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7DE26B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436947AbfJWWxn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41524 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436941AbfJWWxl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id c17so31728196qtn.8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eJZqH8JTIxnzaPVoCiD3/WZteI0vc7zvcPUHOAgd1tM=;
        b=A9uxdSgYVxaDu7xSVvv+2/1ukCY/8dpdwD+N3v6EwEnO041relk/ssXU9YysM3VOTt
         5YOs+wLKacBl897dYj99jucoEUxFqiNesaqbiskrt83SoBzgicMyoxwIk5nj8xyiq8IN
         A1owNk9CTnfqQBVBNylT/vQRawAS79lXmGSRRCzpkcbgCQuhRxoPE13ZrzcEVgDXMhnr
         JVxsrtKwo+3XLvTop3j4ZNUo3OU+HjTcra0ul1DTVnYZcrsNUHZsrWkXej+NUExD+A8k
         5vg3HkLV+wCBaVvs5qnS8J/aLREub2Wm0Mh5cpritsvbxj1EVH3UiKlqTN7SCCXe+w9F
         1aJA==
X-Gm-Message-State: APjAAAUvIwfBXiJtKnYsA6MNEbIWecsQBewkxRL4nO+6fuYKYXTl6haf
        nY4gnCxMSac/jnCgpebHIiw=
X-Google-Smtp-Source: APXvYqyMQy+UjgDRN+mU7UN133ZhZgj9nB1TWp9xI2ZvorjAF1ZTqHfaU8mYDNB6R1AngfgWamHMxQ==
X-Received: by 2002:ac8:b42:: with SMTP id m2mr1115373qti.174.1571871220235;
        Wed, 23 Oct 2019 15:53:40 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:39 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 18/22] btrfs: only keep track of data extents for async discard
Date:   Wed, 23 Oct 2019 18:53:12 -0400
Message-Id: <28b5064229e24388600f6f776621c6443c3e92b7.1571865775.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As mentioned earlier, discarding data can be done either by issuing an
explicit discard or implicitly by reusing the LBA. Metadata chunks see
much more frequent reuse due to well it being metadata. So instead of
explicitly discarding metadata blocks, just leave them be and let the
latter implicit discarding be done for them.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  6 ++++++
 fs/btrfs/discard.c     | 11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 88266cc16c07..6a586b2968ac 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -181,6 +181,12 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group_cache *cache)
 	return (cache->key.objectid + cache->key.offset);
 }
 
+static inline bool btrfs_is_block_group_data(
+					struct btrfs_block_group_cache *cache)
+{
+	return (cache->flags & BTRFS_BLOCK_GROUP_DATA);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline int btrfs_should_fragment_free_space(
 		struct btrfs_block_group_cache *block_group)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 592a5c7b9dc1..be5a4439ceb0 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -51,6 +51,9 @@ static void __btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache)
 {
+	if (!btrfs_is_block_group_data(cache))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 
 	__btrfs_add_to_discard_list(discard_ctl, cache);
@@ -161,7 +164,10 @@ static struct btrfs_block_group_cache *peek_discard_list(
 	if (cache && now > cache->discard_eligible_time) {
 		if (cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
 		    btrfs_block_group_used(&cache->item) != 0) {
-			__btrfs_add_to_discard_list(discard_ctl, cache);
+			if (btrfs_is_block_group_data(cache))
+				__btrfs_add_to_discard_list(discard_ctl, cache);
+			else
+				list_del_init(&cache->discard_list);
 			goto again;
 		}
 		if (cache->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
@@ -492,7 +498,8 @@ void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
 	s32 extents_delta;
 	s64 bytes_delta;
 
-	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
+	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC) ||
+	    !btrfs_is_block_group_data(cache))
 		return;
 
 	discard_ctl = &cache->fs_info->discard_ctl;
-- 
2.17.1


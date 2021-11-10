Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CD44CA54
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhKJURp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhKJURo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B126C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:56 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z9so3268821qtj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iJXWVIvO1tuVtnIozW4eE+rzIC8d+GMpsaxozXvZXMY=;
        b=ETYkR1BeHW+K2BKJQtQIZz+rPGpwSMw6d+TSVr/jGLyIz8ao9gLG8+PUmfIKyoVUR1
         sur7Ev3S/gtpVu+h0FLwXM1Kr1FpLheFNhNOm4MSF/PMRbzWotM+93/h12rXQwsNlg4t
         Xr8yhzLIknZRAE4KUwPdhYRYly/jA8sHjV3yfVJxeR6gcmKEqlsQNPqZJyJXCxnVf/9e
         1VfeqErtBkb87lJepUOG02uEJIjDafG8vIkTgdkxZj4lTvyz6J1wQ9rc9bG2PmxIivot
         1VZfrxkWJ73ohOjt/Zwp6am06n3RSHI3nAL8H0HGeKG7zqjIhGd06rKm1Esfznz5D9Bl
         yzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJXWVIvO1tuVtnIozW4eE+rzIC8d+GMpsaxozXvZXMY=;
        b=5t6VrExtOV5EJNHl3rVditbGDEtjXs3D8drJXDXiGbvTOjr5ZZvlhZGmpj3GHPh/eV
         /Zc7jh6wSKC/XElAJdyTNvtHOQ0I4wcY0PBdSjhcHEtqvekhVSqzsjbSy1o0mmPQuvpJ
         UFZiCjCK8U7ub9aYRuL7XAbs6283VHPwqfv79pKgHsz0YECjA96mEMjMi2mb0Jq1upFK
         j2kKIgrL9YGQoetj1qSUAhQ0NFKw6jUs2Syb8gEIiSZb475C3718uGY9HckAz/PLr3n0
         oOa+yLGE31jEl/gEnne7LhRN/uGz3j9hdQAl6sl/ZMdtc8MVNp9JYdqWOmai0eSW8t+H
         1umw==
X-Gm-Message-State: AOAM532HpDchLm9q/yuelBngx9A1NRjXKg0WyJ700odE7umc9kDyG+i1
        E4pzTOic0vv7Zi699ob41kfmpVmUgekPAg==
X-Google-Smtp-Source: ABdhPJz+EzcWiS2XaKEeBot9yDztK8/VF+14y/hMoxWJgDCzYObCHbbsoirlg+rFqc6v9qehc8a9Cw==
X-Received: by 2002:ac8:5b8c:: with SMTP id a12mr1906545qta.342.1636575295198;
        Wed, 10 Nov 2021 12:14:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w5sm456281qko.54.2021.11.10.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/30] btrfs-progs: check: check all of the csum roots
Date:   Wed, 10 Nov 2021 15:14:18 -0500
Message-Id: <3a581652e5573d8be4ab72578fc909e8094468f3.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the global roots tree to find all of the csum roots in the system
and check all of them as appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 6795e675..175fe616 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5977,7 +5977,7 @@ out:
 	return ret;
 }
 
-static int check_csums(struct btrfs_root *root)
+static int check_csum_root(struct btrfs_root *root)
 {
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
@@ -5991,7 +5991,6 @@ static int check_csums(struct btrfs_root *root)
 	unsigned long leaf_offset;
 	bool verify_csum = !!check_data_csum;
 
-	root = btrfs_csum_root(gfs_info, 0);
 	if (!extent_buffer_uptodate(root->node)) {
 		fprintf(stderr, "No valid csum tree found\n");
 		return -ENOENT;
@@ -6087,6 +6086,27 @@ skip_csum_check:
 	return errors;
 }
 
+static int check_csums(void)
+{
+	struct rb_node *n;
+	struct btrfs_root *root;
+	int ret;
+
+	root = btrfs_csum_root(gfs_info, 0);
+	while (1) {
+		ret = check_csum_root(root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_CSUM_TREE_OBJECTID)
+			break;
+	}
+	return ret;
+}
+
 static int is_dropped_key(struct btrfs_key *key,
 			  struct btrfs_key *drop_key)
 {
@@ -10899,7 +10919,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		task_start(ctx.info, &ctx.start_time, &ctx.item_count);
 	}
 
-	ret = check_csums(root);
+	ret = check_csums();
 	task_stop(ctx.info);
 	/*
 	 * Data csum error is not fatal, and it may indicate more serious
-- 
2.26.3


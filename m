Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4334762EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhLOUPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhLOUPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:04 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39AFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:04 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 8so23100545qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BsZn3H0i4WkHCPRCAwwmm8pRtDp6BOcBYg0jRNbV30M=;
        b=pEKHXFuVm41q46ChnkK8sFARxqhKArfltZr/Ph2wdHBP99vxzx1T8l8TC/RnmjE7ho
         vTNXMwr+Yr2J4sGOsOsdeKDjXick1UQzoZYM2bruEjJMzre2Hw2w1h+ufIFb/bWVgFa+
         crCMhs0XVhB3vgQaMMsCBA+Popa/0AjNgQd96bksWCSqUw+0urIv+7IBPoNv1IuxbXl3
         ZNTfA0I0fCaMITW/QypVBJU5YXp0KbKzyypus2DkWBejmgCdjbH8D4KaVwmhwdeqskqZ
         kJL2qGB9oAr8XQuf5x5c7iJPhlEXQE3k8GzhHiDuh8EV4Uo8xa/ibY5rV/siXx5tioUH
         VAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsZn3H0i4WkHCPRCAwwmm8pRtDp6BOcBYg0jRNbV30M=;
        b=FivIC5oEPZ2brjJIZB7z7qpvFTdGXG8Byl7Qrq89JZjxhwMOFvXwd/PwTYzrN5I3fk
         3IS0t9th0qeXdf9eunsZFuPr8epXLFTqXcAXdwqQAjnULgQlEkopBLubICNpENDtfnnX
         5JEMoEaaADTGiyCRcG9QUl/dJooQhTZ7fUF/s2GgnPhpmiBuf/qngz8m5d6KBMepT8Zh
         Fy1h81tYjOJpn/RbOhMRXkz0JNYQCaFUkapvUrBtbFIb9xZB1imRddrbDYmOJk1mnpU5
         xAkjoAGJF2MylPg7+hpXkbdlZNNuDlUiz87HP8TEpFosvJw62bHKsm2vkFeO+8W2R/0J
         Y/vQ==
X-Gm-Message-State: AOAM533Alo7MRyGLmAFrrHjcYdtBFvnmw09WBXr1BlTi8HXvklmgX+g0
        qUrO72pJPWgrAvnM+/v9QXZ2in0WoOadNg==
X-Google-Smtp-Source: ABdhPJxOiaj9p540a2G4FIDnTyijXvvbZTUM0w72aJEywudxBVoSF2D/wF3ATwuzA2I9wVVl0yOxKw==
X-Received: by 2002:a05:622a:2cc:: with SMTP id a12mr13889729qtx.101.1639599303569;
        Wed, 15 Dec 2021 12:15:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o10sm2266657qtx.33.2021.12.15.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/15] btrfs-progs: check: update block group used properly for extent tree v2
Date:   Wed, 15 Dec 2021 15:14:44 -0500
Message-Id: <e16b2e033a5d1ec11eed8622c60efb9550312da1.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For extent tree v2 we do not have metadata tracked in the extent root,
so every block we find we must account for as used in the appropriate
block group.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/check/main.c b/check/main.c
index da5aab89..cee7e7a0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6412,6 +6412,14 @@ static int run_next_block(struct btrfs_root *root,
 	if (ret)
 		goto out;
 
+	/*
+	 * Extent tree v2 doesn't track metadata in the extent tree, mark any
+	 * blocks we find as used for the block group.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		update_block_group_used(block_group_cache, buf->start,
+					gfs_info->nodesize);
+
 	if (btrfs_is_leaf(buf)) {
 		btree_space_waste += btrfs_leaf_free_space(buf);
 		for (i = 0; i < nritems; i++) {
-- 
2.26.3


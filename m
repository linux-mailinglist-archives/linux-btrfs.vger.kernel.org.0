Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06633983D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhCLU0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhCLUZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:52 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC2C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:52 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l13so4848520qtu.9
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/aDohO5zMMuWf0AmUIAS+Kqci7E8TwpqYGGIn/pZEs=;
        b=mpJo+7CxNY2yRLIKAUxAaka3qw5VBfI6kkACl3Nd/M31eOb/dU3364LevJlGyc06D1
         2qWBv4mQDzV/VajtIpgz/9EmeYYUZVPkKe80MPNoSBCzP77J4PYc+iafkruSs/CdTeD7
         xNeqSGTQfkmjKqPgq/5+dGFUrcjbCqEQsOgnifxEs2vAlsLwByjU/4NthPZYxJ/1MzPG
         WmSWGUYRv+y26v9CBxNWB6yDP5po9blOxRpfi1X7ts67IYONSpni+YM656L3hNfiTdDp
         fzUCIMGHB7FFVGn51POGnHp0UKiLbXRmKorQuqlcryVqkKab0jggpKMLpy5vS51ZqhUc
         CzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/aDohO5zMMuWf0AmUIAS+Kqci7E8TwpqYGGIn/pZEs=;
        b=j2rZ9vMflPoVmHTzal8VGaK+VzD3CzJMcJOpkBxZKFUAi5kjJsqxqpXAZoEdAAt8sb
         PK8CJUxspkhT2L+50iUlhMo+QcKlP41qV8uaJgSE5mOtc056k5H54NJu+QpecdvQra4U
         wHIWJ7nREXl0Mjv1aFlc/Ynj5gg+XGw/UwN825rm6TlLXtEFAVnqFgqn6zf+nGAqT8Oi
         xmjC4bqVEWbSNoo5ZL5z1l4kiZgnMaxHWcrnN9CwrgjEr0DHDrvZS3CNTJAcVeancgxM
         wy9rRMo0s8fPjK0JvF6oi0PPrq3qVUgbb/Tcs+QStXGq8H8faCfyRnOt3vorhd/PlxUS
         PEIw==
X-Gm-Message-State: AOAM532gyGIyI3sIUSZSI0v3u0AWnvUqBwONaEeCzpjif0Cm7ByfaKlj
        auyJJwYbuzda4paVEKTrFHWjO9bV4fQQStHf
X-Google-Smtp-Source: ABdhPJy6BddcAAOTNMhVDTosnyAm3o25p04ucrKXby/kqlfcuiBOcwuJdwrf0xmRleLYT/0l0fUwqA==
X-Received: by 2002:ac8:5c82:: with SMTP id r2mr9990608qta.201.1615580751610;
        Fri, 12 Mar 2021 12:25:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l4sm4632001qte.64.2021.03.12.12.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 10/39] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Fri, 12 Mar 2021 15:25:05 -0500
Message-Id: <f2d84dcb5b07246d69fd1701eb5f063b6b306f52.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_recover_log_trees.

This appears tricky, however we have a reference count on the
destination root, so if this fails we need to continue on in the loop to
make sure the properly cleanup is done.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2f1acc9aea9e..941b4dd96dd0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6278,8 +6278,12 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = log;
-		btrfs_record_root_in_trans(trans, wc.replay_dest);
-		ret = walk_log_tree(trans, log, &wc);
+		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
+		if (ret)
+			btrfs_handle_fs_error(fs_info, ret,
+				"Couldn't record the root in the transaction.");
+		else
+			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-- 
2.26.2


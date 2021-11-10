Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFB44CA1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhKJUK5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJUK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:10:56 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BA2C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:08 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id bu11so2680078qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xe70vkcYZGXPQyJtnSdOR5urDChFKNqPR5Na2BIJw2Y=;
        b=k3N8wdkHbwbCPoguMiJ8NkSe/jVsBN+GoFG4fr/6geNWHfeiYoxh2vkktYdSbyOOQp
         05c8Jg+avgIjIh8InpLa3WBaSjs/uPz34PzWhOIfkxfg/cfowIxEbew0pDPtVHZTOXDo
         uyGyA4xLQrLXOZfOhE8y4YRBxbIIxd6QD2qa8Rv2SXFzQHcXdRAThpNqjqbxZSsgofz8
         NY9pjY8o6fhhsw44N7xTs0NNG8kazsIQZCAI+ESNk+FObnmEk/m/oCDJ6jhbWGLLQD6t
         OKAhotBsYnpfTPc0Bu0ZS/zJjYEESndqrP7iRZfywkEeNg+RLPQ5ityjV9gCGASRcDaD
         ey4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xe70vkcYZGXPQyJtnSdOR5urDChFKNqPR5Na2BIJw2Y=;
        b=b5xv24u9NRNBSEBtAHYqIZf5XRd9dYSHV4J41pBWiIa1siXDirp9P3eu9gFXdCk5JP
         fRQSsYNgbjl748zPnJFnNsT6YHCRZvsAwVE/tu6vDA0NbhW2aZYlON3VBk/RT7r7jZXk
         DL+jcZXSW6Pv5sLg+o/yWdx+egiFor63PA33yNTY1LlDMBf/mlFtGTou5SugbUH8675R
         apjLXEtZInwtauWdHQyYSTUxrTkhjFXJCOloQtOVcjm7zkc16Xqe2iFagHGR7kKOWC0n
         O1wjZaXeyzqLGp7oW5REhwGd9UtXxkii6JTmR/fBkzq5ltd8leAjbcPNUfJ2wM9hVZi0
         fqlQ==
X-Gm-Message-State: AOAM531W3Kq8H0ot6LqBST/lDBEXJsh4sdk8Q4rlJSIcXWs4IjczDA+W
        9w4ZYl8/quEnXCPub4v2EK7HcymEnHpgzw==
X-Google-Smtp-Source: ABdhPJyDQ3VOgmjLiYbA99HC0uDADasII1LfZk6P3RBNcZYtr3uaXUJlomcqcgdRiPyWcnrlXRkLYQ==
X-Received: by 2002:ad4:4d05:: with SMTP id l5mr1328663qvl.54.1636574887447;
        Wed, 10 Nov 2021 12:08:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f9sm508127qtk.36.2021.11.10.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/13] btrfs-progs: check: fix set_extent_dirty range
Date:   Wed, 10 Nov 2021 15:07:52 -0500
Message-Id: <b5b74e0a49f0400c4d05e7a2dec8838aed5f612d.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I screwed up a fix where we're setting the bytenr range as dirty when
marking all tree blocks used, I was looking at btrfs_pin_extent and put
->nodesize for end instead of the actual end, which is bytenr +
->nodesize - 1.  Fix this up so it's correct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 0059672c..02807101 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -664,7 +664,10 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 			if (ret)
 				return ret;
 		} else {
+			u64 end;
+
 			bytenr = btrfs_node_blockptr(eb, i);
+			end = bytenr + gfs_info->nodesize - 1;
 
 			/* If we aren't the tree root don't read the block */
 			if (level == 1 && !tree_root) {
@@ -672,8 +675,7 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 					btrfs_pin_extent(gfs_info, bytenr,
 							 gfs_info->nodesize);
 				else
-					set_extent_dirty(tree, bytenr,
-							 gfs_info->nodesize);
+					set_extent_dirty(tree, bytenr, end);
 				continue;
 			}
 
-- 
2.26.3


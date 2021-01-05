Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2AF2EB4F1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 22:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbhAEVlC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 16:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAEVlB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 16:41:01 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9033AC061574
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jan 2021 13:40:21 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id u21so833598qtw.11
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jan 2021 13:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aBac+HTbVD6bZQG9F6AJ55OuH6B842ZCpbG7gn/Mbv4=;
        b=xkjjqrJzef+rez8XlPBxUjRHrmhV/HCb+rNaDVq7H7YjpXdk+4H652BNnwdFdHsa9U
         v0voY1/kiaFakhaKKc5J6MfwIR9pBop2AxDvK5zfnuz+9IH55xE5RyM1LAJeIaZoNeqj
         1S7Y4kOVsfcb00Q1MCkF7btYPkjJnieVGiCLlL+WfbavgcglL3oLTTbPtuqSWxMNV7Ta
         1xUDpVRLn5UiLDjowB6wkcef44talUcP73QcHDzc+r8Kgp4piVX4rXvyyQNLlYEQBYoF
         OCdwKrFCuxcfujk21EMywsi1Y2xBnvTY1SeJLE/nU5UCyDQv6DJ9QFlf94GlFo1AYeof
         K7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aBac+HTbVD6bZQG9F6AJ55OuH6B842ZCpbG7gn/Mbv4=;
        b=bQyH069AET8aVX3/gDlChymZ2/5wDtRKgWEiBRX5H0NECCRkQDP6DyvdXF0SKlrl+D
         u5gy947J9XcJuDclQ4P3TPW4YoA/VETCn9mt4KN25cjxhm9I9Xrn0p5E7yZjn5zNRqhY
         ymvlbLbzkD+020snGqLsXsitl2W+u5qbskeNszbZbayAlBd/W6YzYBKLJ1AnLbbVlc++
         2stNUHQN4YwoACnaKeZBGDBZpj6FEwKaKTjtau2Os531cSFZht45l/Pb0Ci/Vudx53SS
         3XbEjUHAV/j+vGBo8KO27v37UxemMaFpmHdRwYVTgnRKZYPlAfZt6Gz0TxJpPOsOgurN
         aeOg==
X-Gm-Message-State: AOAM531gvQ+rBy5C90R7KS63VoKX+IYTHflXqFmpDfkGswicyIE7wUu+
        ieSJ37zOI7td2fTfbX1/yb5gEfxzN5amMco3
X-Google-Smtp-Source: ABdhPJz+4eMCuGHu3/5JAX3Kw4uC2QYkUVLgK1eIOi6BJRW+OjXqT8Ny5HVsYc6hVcnjkmGINaiXFg==
X-Received: by 2002:ac8:5286:: with SMTP id s6mr1488693qtn.22.1609882820441;
        Tue, 05 Jan 2021 13:40:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d2sm212447qtp.71.2021.01.05.13.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 13:40:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: properly exclude leaves for lowmem
Date:   Tue,  5 Jan 2021 16:40:18 -0500
Message-Id: <845796bfab85f02919d64908b63f3f7201a2abb3.1609882807.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The lowmem mode excludes all referenced blocks from the allocator in
order to avoid accidentally overwriting blocks while fixing the file
system.  However for leaves it wouldn't exclude anything, it would just
pin them down, which gets cleaned up on transaction commit.  We're safe
for the first modification, but subsequent modifications could blow up
in our face.  Fix this by properly excluding leaves as well as all of
the nodes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index a6489191..ef77b060 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -667,8 +667,12 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 
 			/* If we aren't the tree root don't read the block */
 			if (level == 1 && !tree_root) {
-				btrfs_pin_extent(gfs_info, bytenr,
-						 gfs_info->nodesize);
+				if (pin)
+					btrfs_pin_extent(gfs_info, bytenr,
+							 gfs_info->nodesize);
+				else
+					set_extent_dirty(tree, bytenr,
+							 gfs_info->nodesize);
 				continue;
 			}
 
-- 
2.26.2


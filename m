Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20E02B204B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKMQYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKMQYe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:34 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5DAC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:34 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id v20so1563566qvx.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DyWHy71kiIUszuIZsb5ZbAB/n2AsUIppw3ITFU/EOs8=;
        b=qxgtFz510ZdruSmGe3ABIyz60NfzECBNHav9pyD0erqiVMcjalkkiMYkuQnOuvEhlk
         ljhh7cI45NA01H6dAkSWssVjrsTqZmJAGmt1Hy93yH9YypQ+3p92Lgv+SGRsS/n2i3Eh
         YUqk9IltmKmLcDHo7yDQk+EnF1A1jPvRB3ypl+P8qZ5kRhX4W9wtphr+h0nKkeBqo/l1
         lId+6+hDL3xZaqOjmyNJ+HXm1s+PkrtvaqAYBI+LBtmm+/S3EainoFCNWuRqlnkgtqAi
         Bw2+3RwRdaVm1icV6fGWYy3m1kjg9B5gofX9/sJs2SVH2KjyUmL61nJ2YgA9rA3E5Y4+
         CnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyWHy71kiIUszuIZsb5ZbAB/n2AsUIppw3ITFU/EOs8=;
        b=E/YUw1+Gu7k6yAnDnpj7jJfvJ2kI8jtz+v8fKBJLf3aMB54dX6MNoXQDfdhBeSvMje
         65NLEWkF6gp6O37buMRkT3XIqIrogB8kNbROmxjKcQZA0Qcp3xfGiUcHTwsWY6Pdy7JO
         RadluKU104PXsOJrUDBHBDiSUJZLwCPyj+5aYThu6CC/d6kvEzSVkIBP71q2O8OkSPFO
         I6DYeg2ddGfyRzGQNdhQEZdxjcZ+yOK1oau0WXaSTLbYhVfvBiupVi2R/o8T+LxXccuh
         L72ZrcSc+RmVpILhwf0lK6C+z3ajqQylj7PokNlxCWrOWXuv912QpVGUMdIFx5RryFuH
         6e8Q==
X-Gm-Message-State: AOAM532tSTVYeHq7kFBhFsyvKvIgq8peF1KiI4N89j0jUeLjyUZT6HT1
        eTO8dUM7IA2um6SfXAvijBvgxjn5EPTSDg==
X-Google-Smtp-Source: ABdhPJyZxM1fq1MpdeEX/funS1SOMvT8ApRVocjwCW3ixWglQFTmqr2pP/c4NaIZOkRSI/1/oNG7GA==
X-Received: by 2002:ad4:5691:: with SMTP id bc17mr3165843qvb.30.1605284668666;
        Fri, 13 Nov 2020 08:24:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm7047270qkm.62.2020.11.13.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 29/42] btrfs: handle initial btrfs_cow_block error in replace_path
Date:   Fri, 13 Nov 2020 11:23:19 -0500
Message-Id: <5f17b4728ca4dc358a7c4dad214cbac638b8ac9d.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we error out cow'ing the root node when doing a replace_path then we
simply unlock and free the buffer and return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bb393fa29087..32e183b1d958 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1222,7 +1222,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	if (cow) {
 		ret = btrfs_cow_block(trans, dest, eb, NULL, 0, &eb,
 				      BTRFS_NESTING_COW);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_tree_unlock(eb);
+			free_extent_buffer(eb);
+			return ret;
+		}
 	}
 
 	if (next_key) {
-- 
2.26.2


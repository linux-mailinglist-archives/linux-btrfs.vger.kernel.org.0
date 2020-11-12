Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143022B100F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgKLVUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgKLVUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:19 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2999C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:19 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so5191751qtb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FGxucnwFmP/EkXhNdJ0uoSDBCPbbjyaxb4gEXpYNOWM=;
        b=i/cQScy3er1pxeKmwNYh/U4ZP342YgsqhU+KguAuDFgicI65D0Na3gKu3lRuC7Ptp7
         amiiVM7N1x2LEjP7LQM2gje4m+jiOlpEjOt9OEGFzAZ+mO1oZzAKppSwrQudeABGQl1B
         dDK6ZMX0ZYHMndAthg3QXYqY7cn13sctaLjMO5saKYDkIwbvM1Pjd+YPM76M8QlcGdk6
         7XWKRQLDz9J1gTmvcJb1P1KGsac1nXTayweD7v4gjg71PD34SiSSLJAf28H5Ie2skXdQ
         WPIckAdbOQAij1deuiJ4CZe+AL4m4x5qpQsDIRckBuRX5RjbvOOOiVCEZMe19DyZ5wd0
         cshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGxucnwFmP/EkXhNdJ0uoSDBCPbbjyaxb4gEXpYNOWM=;
        b=tMUiziUDM9E643rM5/xBu9TEESCB75oYwXtySrkCtJeMeGYZUwg84KU45cKvMtK7mS
         cv83av8xrk7EfxGBIMOO3sFmTVn91SnVSd1UArCemN2+W76PldJSfkDAdqocfe84G57Y
         v0+LPKJ4zJwc9XwaE6E8JaUo3nwik+k3Ch07rF12QeCbtFo8wgWvXTvjdsr8wfhNXC2N
         J9sInFBJu8rG+ARwV//Fkrg9zFgaRblFg8qbkA9husn6Oon23US+zUAUAVlbzTU1d2j3
         lSVptMQ5f2XkZgz0G03OG3nXr1WxC1iYFaDOVaJqq1rzUY21enmt9EHi52s4byZ47vLh
         fVFA==
X-Gm-Message-State: AOAM532w8xYi2kzSvGSLX2Q1QOTFSPBnGHPh+jYz3qjjAEOwZXMwBiZS
        jkRQoIVnYxX+8b67+6wnojATc88xHjE2dQ==
X-Google-Smtp-Source: ABdhPJzC/Qp3r3c1c56mkUsi3u0he3rthUUS9vqyDTkLsP8VuLvaAYjqvSArYxeouWrdhmaxnGQWJQ==
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr1154578qtp.320.1605216017761;
        Thu, 12 Nov 2020 13:20:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c203sm1449499qkg.60.2020.11.12.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 32/42] btrfs: handle errors in reference count manipulation in replace_path
Date:   Thu, 12 Nov 2020 16:18:59 -0500
Message-Id: <d5e7792bede2d402787777173dc048b5473495f9.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If any of the reference count manipulation stuff fails in replace_path
we need to abort the transaction, as we've modified the blocks already.
We can simply break at this point and everything will be cleaned up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2c7196e4ef8f..df45b4df989b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1363,27 +1363,39 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_unlock_up_safe(path, 0);
 
-- 
2.26.2


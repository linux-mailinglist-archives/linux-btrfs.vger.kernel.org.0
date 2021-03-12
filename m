Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35DB339855
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhCLU0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhCLU0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:22 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35095C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:22 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 94so4837401qtc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSNt10oYjE5osVwWVwIxXuhyrOI5tef1vCJi80oPQw8=;
        b=DOs1CX1VR43RcJLNeGNOxptFDAoY1bzx2CpWohlgiG65CC53OCHK3l9wyJuhk6MoRe
         l5yLGIm1A7SvO1s+DxaCFfbz+8+Gpy61gxhjkFXYYFHfC2d4k1D+RWcqOt9hjFuR0f8T
         spnG5jI1CFIxyyJj11dX8dFhpHF9UY5QH8kmM/QgI3nXGQQLtsy5/mzhPojy9wrB6uW7
         YTkhKc+SFlu9k0Ju+umJ0JGRm0eIXEgkali/al63pdN2uyI3qn3EELE+E1Q4EnakdJBW
         97TjpD/XB8l8ZwJXv1ekHTv/jCAD4FEjRXnAmVVA2iy/qk6mPYSRCFyzTEbNDMq4vPXo
         4F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSNt10oYjE5osVwWVwIxXuhyrOI5tef1vCJi80oPQw8=;
        b=Kn7RLcGSQDX9yIZC3aDHdRay3sAEyCmUbHGzIUBo89aDgcIiJJg7AM3u2BB5OPElWp
         83VSxO/vHfZpmgVlXPp7vThjnDZNsq3sIzzlArlpAG8TdaIWCeX5+HN500/O7+q4OVFM
         gJDL7UlbWhAmjF+fHJxGHbPVnvoHDxWopBowlsoOaM3tOG9Fh2Snz2VW5zxBXSmypzr+
         E2PXn6e4L+f3kcTeb7V/ib2OqLlcvYWWo497b83DvvYTPoaTalyOkc0D1J96+5u1OQ+/
         uaGt1xT5lgIxJrNT+TKr/B8LsDgKYMAb0Mfsh1a90LAbLl5uekany0xTGSpj9/o3hHe8
         VB0Q==
X-Gm-Message-State: AOAM532etIhlagFhWB4/VQn8/nIsJ6Ss5xO9dgB+IS9qpnvUtIanFw4h
        cCBUl+l5KOk9QrvDUxtzq3dieomG9V05tfGL
X-Google-Smtp-Source: ABdhPJyOXyw/5oQmtvxllDy7QjLwds9SUQDoXF04bVKxeeOzjUmcJPkoIG8qGTTJ61lEPaDRQW9yAA==
X-Received: by 2002:ac8:738f:: with SMTP id t15mr11392129qtp.26.1615580781171;
        Fri, 12 Mar 2021 12:26:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c13sm5080391qkc.99.2021.03.12.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 29/39] btrfs: handle errors in reference count manipulation in replace_path
Date:   Fri, 12 Mar 2021 15:25:24 -0500
Message-Id: <7fc6a13fc3b70bb55e6dc1a818e73f539ca4e601.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If any of the reference count manipulation stuff fails in replace_path
we need to abort the transaction, as we've modified the blocks already.
We can simply break at this point and everything will be cleaned up.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6e8d89e4733a..1a0e07507796 100644
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


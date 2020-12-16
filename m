Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F502DC434
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgLPQ2i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgLPQ2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:37 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38495C0619D9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:48 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id u16so11597320qvl.7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+NX7Y69cTQL1QdVUPKQbwVhZ9YixdVO71sPyw/CMSM=;
        b=d6TFA0OkHo6gAuvCSo/M1bchQBkeL4BNHVkurNpDf1x19j6awcEA/Se5lgOMUYQQo7
         87baKROmK+4hSYj7DV5K2E0yD/jlhOQf2JK4GbIHaoTSqtVbI1QgkTqINDfMeqLIqkaW
         EE6/5IStYJMQoe3dIiY5tWCQ/VrPsxFci/WFDbLplH0ZDEr+tcXlsmhJRKYD3xR3XB03
         MwbDYn9Kj9h0kZL2mrDXcNFAg4gACe4idn0dNEX5i/YcKYPWL8KJ+TB+MjUMynxWNC0H
         zjNVwFWg5ylhZBFtO/ZnH9QpshTLa4e7lrprFFWaNXZUsrj7Sgzky5oMwP2ngx+wpbJs
         LLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+NX7Y69cTQL1QdVUPKQbwVhZ9YixdVO71sPyw/CMSM=;
        b=jhknALdp3bITUeuYk4ndW3QgEhKKLmyTZa605y8zEhYZVyURyEjhhJSbQHHk3g7dYV
         ITv12oGf1XZBvzsl7kXYylBHSxMOqmQnJ2rmFUVPVdahd2L+xgTNwUH36Uc8L6B4XMxB
         ZPwW9ciQYpU3zZxdedkBc7t90agCkYd4d+MYcqdjWbLVLKBptHIzz5UUXPNfr2jOUgSF
         Z1wPHhIuS8HI4+426t/vRLr0ri3NnWApVMoNURNwOKYJmvjTtAiY7du/N0I6c/j0EAHb
         3S8neAdQ7aNxO96C0DedSSBvfJsMUHiPY6H0ixR3xi11HmRXvHT13dR9AWLyeAiG2B12
         A3WQ==
X-Gm-Message-State: AOAM533BcHEIx9QbzwYbmfHBW9PDUNPMXQDZqH8q+DIX0eDjDsjD2lnz
        7zodi8XvcWS+Mizs8bH2qYVeoAHxdK+i8Qoh
X-Google-Smtp-Source: ABdhPJxHK3xcebM95VOzAb98Mki1ICLLXibp/1yV90MBHCKRw2xeWfAZkdwyolpwP37fkcRN+WM0ZA==
X-Received: by 2002:a05:6214:a14:: with SMTP id dw20mr43485349qvb.43.1608136067138;
        Wed, 16 Dec 2020 08:27:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m51sm369979qtm.34.2020.12.16.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 29/38] btrfs: handle errors in reference count manipulation in replace_path
Date:   Wed, 16 Dec 2020 11:26:45 -0500
Message-Id: <72fbcf1a72c88b49a43ae552df09d9965cb9518b.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index 8101cae374cf..e60353980942 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1365,27 +1365,39 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
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


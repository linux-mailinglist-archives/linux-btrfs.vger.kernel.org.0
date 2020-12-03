Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA42CDD7B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502023AbgLCSZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgLCSZK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:10 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3BC094258
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:12 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so3003268qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBEbE2A955QTpSYe7t3gEC9f7kk4UL/5SdXRttPLrCs=;
        b=DWQeIK6U0kmgeIJxpQcQaBFWQqannyHKqRfVksxLyTLUfJRlZbbSZgk4g4VC2Nup5+
         sla4TYtDpwgt7Z66Kml5uJ+IFun+P5nGU2ra+5tuNIa/qDfqdI29NGJu5ml/oTNVSpV+
         hQ7/GX2K9cYPWxceC3BII3CiudX7NOymPwVkwmUcmP+yZrDfaS6/CGAe8sflwg5MfCkg
         RydizqCW4ZRho/OfTP/y3v+jCCt07q9vRZTDVAp9tQ94deQDYXjomMrEqPtk0QrKX2Pi
         7m8YEoqJjUNNuAlFpIz80YTtFwgQX8+FRfs5qbGD9M24W+ipSOgMstH3IfuPKQcN+iQI
         KkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBEbE2A955QTpSYe7t3gEC9f7kk4UL/5SdXRttPLrCs=;
        b=AbZf/ngvhSLGLQHg0ni8I4cedheUgh1WkfXrlMv4MuTpOJWnDn5ABj7uSRyo6agAtB
         AzF6cAJp1z6bkxIcLiR+QNLtf6KPYn9mFgBJo0lzaDWECqP7jQPvZkhaBMNM16cxjt7i
         AWjiYuqhjd1nfE/Z//yDE9bFN+cLtgXobRYKXRV0hl/62nCIVXUX7z5pAO8P5HKipSWx
         thoI8JEAsNsIqremMHU7mTFcNp8aP6SFeJBUuwo6KU6QDffW3IXSbQE6ThhrRahYRDUO
         Wvb2PKig87ABvV5Saa2QG+w8MGoGzyFXbgMebh/j0M5poTgHgX/tw3cT1yob3RqItMrW
         XObQ==
X-Gm-Message-State: AOAM533MA3rKzJZmzKAKYva3TGIvEI3BDUnKK/+0qL//dWo/BrydWkvH
        SjoUmxJvtX+3rS0gPKCINZMEFeALEuEdRsjT
X-Google-Smtp-Source: ABdhPJwnIE/aXD2wPnzZkr87z+vspvOPj1XDhDOwmlh28pjb9vgxZfbBAqd3k/dk0w/Ys6fDexaoXA==
X-Received: by 2002:a37:30c:: with SMTP id 12mr4243071qkd.110.1607019851168;
        Thu, 03 Dec 2020 10:24:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h26sm1557275qtq.18.2020.12.03.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 40/53] btrfs: handle errors in reference count manipulation in replace_path
Date:   Thu,  3 Dec 2020 13:22:46 -0500
Message-Id: <8ea6059d619b11a0d4bd6bda7f8efeeb14fc2292.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
index 6ce46977ec05..e025cb052d77 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1355,27 +1355,39 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
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


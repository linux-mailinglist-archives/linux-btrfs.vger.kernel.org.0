Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722DA2B101B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKLVUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbgKLVUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:44 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D19CC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:44 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b16so4983828qtb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cIHxpoUEzw0mzfxfo95kgHP+9XLiAxOjlXmVK1pCa34=;
        b=J9tVNGdOl6x7irH/cT5W+jbVh397IJvqd8aZ0hde2I8fHcdC6vybMUcm31Rdb2kOw5
         ESwuR+nNONLJMoH210sQdjEtmrUivn+1rgJOA0F5VSN83jtLOecxBEwWMfaat/wb8xE9
         IiGjEJOHB/Ig00Ooy2cnz//JquqZpgYf+mL4OmlMLGxNLNOXx4KLjNl9hqUVlp6eqpOz
         PEIJJ77K2uNmdVBvQhvnTrHbcR/qFgNFZw8ilzbOsjlnLbFv+1qq49S2AyF64GkFMtks
         HwWOcyqjJ6zHusolMVPprkO6tCyCFeBzgZaOPEwRYSHMx4ulV4t/OtBWLfahFKpy8c+n
         DUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIHxpoUEzw0mzfxfo95kgHP+9XLiAxOjlXmVK1pCa34=;
        b=IiybtFjLjYTwwcEn6EIbRh+vaWCyA9Mqz8VYs1IEn3Qav6BLRgZUNuhJ0UfmPK0mjP
         m2n7kYXAmFwBGuUtjyMwXfvJSjbwyE/+H0olm+DxDdZGvEH+CPgO94Mrci1D12PgO/eZ
         A/WKTWPWJ+h97Y2TTZk80L4az8M53/cMUM+hRNB366llYv5R/UWzt+s9ZAkuqwZsoywa
         1JD2r+E758Mjsew8wK2tZU9Zfk3yxBjG7mMvumyKzXfqvpHWTscSgl6kwCRsiq+ch+XG
         KL2YRlwrbm8w8kVTt2iO1w9u6glHHVLq9qFE/kJ3R4pwEPYgelLjVApUOclUBkTGC58v
         rKuQ==
X-Gm-Message-State: AOAM533zrPWh+vlJwfGdhKoksVSPBZOrwRFAsoOGWlD1InEp+yD7esCJ
        nUfXNgSSKNYZSgc3a6wJ7TNhTogjN6wM4A==
X-Google-Smtp-Source: ABdhPJzzxG5hp7NyRyA+hu7bffEhk54CO8oeOumRXE+MLS0ML/KWyf32B8VqDN2JKGnCjp1cPK7JRg==
X-Received: by 2002:ac8:2ab4:: with SMTP id b49mr1236703qta.20.1605216043036;
        Thu, 12 Nov 2020 13:20:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r62sm5728166qkd.80.2020.11.12.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 42/42] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Thu, 12 Nov 2020 16:19:09 -0500
Message-Id: <68e2af9f35585b9a55ac993c777a9cc0fa11b60b.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ef7430eaa119..e9e6f518fe26 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1936,7 +1936,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3431,8 +3431,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3590,7 +3589,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.26.2


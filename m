Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8B92CDD77
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgLCSZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbgLCSZG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:06 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBC6C094240
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:32 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ek7so1433932qvb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CYBNnUQukD2ZtIFsYDYk/jkUwQ6GKfqMwWqwi5Rsq7o=;
        b=EObopIPz9NBddvnrGt7tiDnjoVHBxPv6C/CkS1DFxBgWlMcO3BSvJ+293cJRuxizwK
         XcIFWp1OMy2RWhdlOE94iX7YJpWkFlUxwhygezm5RejeuQLlIsg1q1ZxEb4qfKHetra1
         oBGK4LiAVpfki3xiC/lcbacaHfmCPjdTtVauwBplBkWqZC+TsjRvp+Imsde+pB2Zx3nJ
         ZfQo8Ap3iCWwd+cOAkyY2lm2WMZMnkvl9SZElOjf/i8u0KWesLmW4W20W25FtBv3L47I
         /cbzwRVlOL0lgqY1RRC4qurtTiRhYe39BwR8CMSJSIUozRFrNm1KqSPPL+9EWLHk9jWE
         Y3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYBNnUQukD2ZtIFsYDYk/jkUwQ6GKfqMwWqwi5Rsq7o=;
        b=qHaCVp+YiA2AZ9QRkoFRgOVx2izFGLlPm8+pNaLYu1vwgBwv8pGqoCsaw+3gVfWcqd
         HJKG15MU3v834K8Zgi8sYmG1Fyy7qZfUV2nNFPwNxVN+yA4MSjq8yYt4QBYrJpQsR9PM
         TUJTzSPBeUvmerEVD7ZnuqCeWkq1e4DmrTjrs9H1T5+0fHaGmsgYAYjmGv6vBcjbiTyq
         90OBrWMGbIe8SVoC8KAu8UOCncjd/ffSrHWrAoOfggv4ciqbOMNdpeekuR50FtjNxzGI
         q08wkxT2kugXfoHEi78v0A5F1Vzfs8U+tCqDLMHsdW2/xAOftf28PgB8ULfj33fJZKI0
         Rx/w==
X-Gm-Message-State: AOAM530MJIZkZrue+IQCnz6T9zX8reOCDdYX4FM3YtwjFK/4VY4G43dI
        mHs5dvpknxEtFlfUtxai/vKheINf6YCmxzSE
X-Google-Smtp-Source: ABdhPJznqk6nUq7CuWaJgMdTAZ+FKOma18DXDna0dN6EGM0tAZN1TuYZ4wESjJWEbFX5tf7OV8WmTA==
X-Received: by 2002:a0c:e0c9:: with SMTP id x9mr182494qvk.56.1607019811460;
        Thu, 03 Dec 2020 10:23:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z73sm2199380qkb.112.2020.12.03.10.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 17/53] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Thu,  3 Dec 2020 13:22:23 -0500
Message-Id: <02ccc686cbc2210d1ce995e2066085bfdee68fde.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally speaking this shouldn't ever fail, the corresponding fs root
for the reloc root will already be in memory, so we won't get -ENOMEM
here.

However if there is no corresponding root for the reloc root then we
could get -ENOMEM when we try to allocate it or we could get -ENOENT
when we look it up and see that it doesn't exist.

Convert these BUG_ON()'s into ASSERT()'s + proper error handling for the
case of corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a3ad44605695..90a0a8500a83 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1973,8 +1973,27 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
-	BUG_ON(IS_ERR(root));
-	BUG_ON(root->reloc_root != reloc_root);
+
+	/*
+	 * This should succeed, since we can't have a reloc root without having
+	 * already looked up the actual root and created the reloc root for this
+	 * root.
+	 *
+	 * However if there's some sort of corruption where we have a ref to a
+	 * reloc root without a corresponding root this could return -ENOENT.
+	 */
+	if (IS_ERR(root)) {
+		ASSERT(0);
+		return PTR_ERR(root);
+	}
+	if (root->reloc_root != reloc_root) {
+		ASSERT(0);
+		btrfs_err(fs_info,
+			  "root %llu has two reloc roots associated with it",
+			  reloc_root->root_key.offset);
+		btrfs_put_root(root);
+		return -EUCLEAN;
+	}
 	ret = btrfs_record_root_in_trans(trans, root);
 	btrfs_put_root(root);
 
-- 
2.26.2


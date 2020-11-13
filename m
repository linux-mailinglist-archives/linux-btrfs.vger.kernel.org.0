Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915A12B2031
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKMQX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQX5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:57 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E2EC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:57 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id v143so9311465qkb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e+cOrmULyJu7/nltjuezokqp7yeVBG3mi4VLs2dmux0=;
        b=0MlPIQx8fcs5pMyuHuSb2YPqMDPYRcV0dmnXcEND7nToJm/DLbiY+tXahyl9ughbfj
         zDVPftVvezVkdIqveKvXSAqH7SiPmM39NfmCyUvBlezs+aly2sNfCsxXC/yWcUXEMmEF
         vyFFXjyVlRqLc8c5p7yvNrGf9NLTOMxUpom2TUVyGCTp9C+7JaqgAb2KhpkT4P+4mgt6
         0rUt0pTJGekEe//RCa9UIOQjDyXJIqZEMZbUXwUAdKlc7X2j1mOzUAfxdMNOkq6zIVD/
         srm0rmyqbMkDFqwXL/tfRYfX6fNp/46AxmMhHTQKqOLRYF2b6EVSZr/Jfhd+XPKV3IrH
         NxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+cOrmULyJu7/nltjuezokqp7yeVBG3mi4VLs2dmux0=;
        b=JHorV2RrsWQFB9AoflTCZrZu4A4SlvLdwjzO0acNTMIUfD456tBwBwPuSnbpcygSZQ
         OqVMCBGqTc8F/d406fUqSV2vEXzCLsX/zr2BG56z1LbfpLv/iWvfBnKdZA6109La4ld6
         TwyUeB2I3OOH9qPyfEP1VarQvh1t9w4JhZKg/YwFpHZYJWVFfSoft+fe9wDidJ333PpE
         myzfNlHqthQTNBroS+6ALhNqwaE3/RLEH08T4vQhHXn3Q16/J4qi/XNu89Bzs6532OlB
         /Ir7HVwiXguY59U3C+qLip1cWDeHMRVFb48R3sM67989qcutaIsHKRDDNzOBzE4gkBpy
         kW6g==
X-Gm-Message-State: AOAM5329IkotcreJGU756o7SNVGqGTUQmlQpy/gU/mtVEjYxLD1+zAGI
        oQF5GZmRAarn/sY0ucJaWoTDL4BqlSoHtw==
X-Google-Smtp-Source: ABdhPJxF0ox29mWVXySa750SdcYTsc7xDKsu6mdgJFEdg2myawCS4g8ThxC4qs+yKw5r69wlVu3scg==
X-Received: by 2002:a37:7447:: with SMTP id p68mr2752501qkc.339.1605284631086;
        Fri, 13 Nov 2020 08:23:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v16sm7215144qka.72.2020.11.13.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/42] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Fri, 13 Nov 2020 11:22:59 -0500
Message-Id: <7c168e877c3a07e76c114b9cbf3ba065f51af567.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5a470d3d91a4..4397a8a448f4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1983,8 +1983,30 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
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
+	 *
+	 * The ASSERT()'s are to catch this case in testing, because it could
+	 * indicate a bug, but for non-developers it indicates corruption and we
+	 * should error out.
+	 */
+	ASSERT(!IS_ERR(root));
+	ASSERT(root->reloc_root == reloc_root);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+	if (root->reloc_root != reloc_root) {
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


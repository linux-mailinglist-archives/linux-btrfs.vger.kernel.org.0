Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9829A4D3EC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiCJBcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiCJBcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:32:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FFE1B50
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:31:55 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id bc27so3436797pgb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BB14nT63gRYIk3ucnamKmWjvDKlG4ENASA5fJvDbCA=;
        b=KNex6g8Hhaaa7lm1wojaIV9MaNKP88VfzkZRmMSZvSCA9CeSqCgMjZe6qwzLPe5e0D
         /+HOO7yZplDRQDA2R18oikQB/M9cGX2EqR8+aQexu42S5OAWPhnlegNaF3JhIJc2Goqh
         QORYcbHVa9CjoPYGtMa1DY/yDasXnljmxhC6vPOZnj58KHTGJpOuQuzXFQN6D7tNWnPH
         Rrzzip/FXnYv9pUPWYTlrY4o9YzN2vtPIzM3e0wiDlV3rXmNwo9GZcQ+Lf2MIKkvm97v
         wHyv/vo98n9iz7r0FUlz64SkiTX9tyO3lY3i40DE0L+U+YOI+LW4HiqxI0zzqQLdDLSD
         SVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BB14nT63gRYIk3ucnamKmWjvDKlG4ENASA5fJvDbCA=;
        b=bmtRfF4dWr9xEuLtIwwZQEuq60pGA0VARElf/moIQgK28nhRmg2I4283KZnMkqe9Sm
         e/y45ELq+TS4NSR5ZkqF81k+iIXTJgAU97rwCeBwSVZ1SJ1Vt0baof8zJ6fXE4e5awv/
         73SGQBYbExmsuxq2pIpbF3Tin1M0E/hXfxuUBMBC8cXNnCnUQSvIEEXj0j+HpMBkthew
         llb/Ids+cDfXwunyRO55pwopGwCt7yHhALrX2S7/POdKpHTN06mK4YgXyET2+fRifbxB
         oQHDZb7mpm9/158TKRfZDI7CRwZguMyUMz+bfx66/AQghd3yXOrB+84z2ELXjaC6y8/F
         8oCQ==
X-Gm-Message-State: AOAM532Ff77QRc85gf8OMxfo/uXclY832gqr9b7b9P0UKgtLtlCKPlO/
        qYY6Az15F0yMgbxu5MsHquE6FtuUONDmTw==
X-Google-Smtp-Source: ABdhPJwgsTWB9O6U6MCiYrM1J6Da78DtbkkfVF6I12uj0U6vLCNnqj01TenpoIqHukPSBe4nxAY9jw==
X-Received: by 2002:a05:6a00:170c:b0:4f7:260b:297a with SMTP id h12-20020a056a00170c00b004f7260b297amr2249239pfc.12.1646875914737;
        Wed, 09 Mar 2022 17:31:54 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:31:54 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 01/16] btrfs: reserve correct number of items for unlink and rmdir
Date:   Wed,  9 Mar 2022 17:31:31 -0800
Message-Id: <9d8fc489f381e41421eb4ce8a18be06ed0636009.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

__btrfs_unlink_inode() calls btrfs_update_inode() on the parent
directory in order to update its size and sequence number. Make sure we
account for it.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e7143ff5523..2fb8aa36a9ac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4212,8 +4212,9 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
 	 * 1 for the dir index
 	 * 1 for the inode ref
 	 * 1 for the inode
+	 * 1 for the parent inode
 	 */
-	return btrfs_start_transaction_fallback_global_rsv(root, 5);
+	return btrfs_start_transaction_fallback_global_rsv(root, 6);
 }
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
-- 
2.35.1


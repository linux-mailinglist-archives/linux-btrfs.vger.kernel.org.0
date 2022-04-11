Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351C24FB24A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 05:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbiDKDZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Apr 2022 23:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiDKDZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Apr 2022 23:25:11 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35581A05E;
        Sun, 10 Apr 2022 20:22:58 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id hu11so12270393qvb.7;
        Sun, 10 Apr 2022 20:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gljv/4/7vROqfmzYygZy8dl2lPYRGvUXzmii0Kd9zg=;
        b=Rkg3T1u3wWauWXKxCVGqmY0uEc+A/TRU/MJ4aLfc2+otjFG38A1RmaOFFGvIKu+J6P
         ahTECQeb7p6r+Pwo5MWbVrx5lucJAapZxGzXBiHGHGFJVonTfsPTii3VS/wtp5gf2ul/
         gOEmiio7vT7R29frAr126zVuNSjYVCeTA4NN6UsfQ5teSEsSpq5BA4LhKjtIQabBdpvD
         zmbOUEh92lD640OZWw7iNaSP+gbElE0qyjIhahh6GvMeW6XREe/hUurS1g0wGfWSl4I/
         dJvomvR8qGGXZLtVczle90dxSWgqZ8QPabJVpPCiiqF1T/bxpCD9KnUIuUP/JAa67vhT
         SKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gljv/4/7vROqfmzYygZy8dl2lPYRGvUXzmii0Kd9zg=;
        b=A+LmvgQOA+wmdJevTgk/jFszv3YPj+gC1ETocUVE79L/rmyn6Z4lAg9ODc7yPnAjai
         eqcpSRnjgb7xd4GV+mmFoidt4TfXck21UGcKVp2IHfdlsFVj0XhVl1ZjhW/F3H3GxT5B
         zqTSmniBp/xgA6hyevRRD5BT+h9CMbHNZ8XZLPbat70OpRDEdhH9+TBwLm7Q6stR7N/C
         bMAuobkAvhuLdrifkz7YSq6/pUMwTvcgs8IcjcMA3ZZYibuxyskb6DCLGxM0+xByZyfk
         534PvJjZog94conp4VTEyV1ie+03TsDYNN7p0cGJVJjiiD8dMUvu4rQ4sTXcOmnA7s2P
         Mi+Q==
X-Gm-Message-State: AOAM5324WhQYIPVOhRiSdFfpkaKwIDTj/csb/9aEnIRukqGh0jjgSJFl
        2hjqFAhT43ML4bL6hn6O2Uc=
X-Google-Smtp-Source: ABdhPJzvKAUDtGhX1nuADHq4ZcnNUzwB0Ihku8lhanqUKLdMKV6mjFRhbDmzudTpXWFP1laVJZCz1w==
X-Received: by 2002:a05:6214:2a8d:b0:443:7f75:2aa7 with SMTP id jr13-20020a0562142a8d00b004437f752aa7mr25282238qvb.36.1649647378166;
        Sun, 10 Apr 2022 20:22:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b002e1cd88645dsm24490142qtw.74.2022.04.10.20.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:22:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     dsterba@suse.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] btrfs: remove unnecessary conditional
Date:   Mon, 11 Apr 2022 03:22:52 +0000
Message-Id: <20220411032252.2517399-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

iput() has already handled null and non-null parameter, so it is no
need to use if().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 fs/btrfs/relocation.c | 3 +--
 fs/btrfs/tree-log.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 50bdd82682fa..edddd93d2118 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3846,8 +3846,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
-		if (inode)
-			iput(inode);
+		iput(inode);
 		inode = ERR_PTR(err);
 	}
 	return inode;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 273998153fcc..c46696896f03 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -894,8 +894,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 out:
-	if (inode)
-		iput(inode);
+	iput(inode);
 	return ret;
 }
 
-- 
2.25.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB47042F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 May 2023 03:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEPBeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 21:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEPBem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 21:34:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102B83C33;
        Mon, 15 May 2023 18:34:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3078c092056so7151827f8f.1;
        Mon, 15 May 2023 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684200879; x=1686792879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cx15BLkSeVQvFI/U9q1IQdOHGoKBxbCCuah8hLlwTg=;
        b=bXLE41umtkQgcNv5sxXz8Nvpudine5WY/tl7rALZdG976K4hhcalsowiFj5SbJodZw
         bcvHx6AC8qG8pK9CmKu6MG/HJ/q3FrvMzkA52NMiPk9lpVUw/1JPLv8Yjx3l0rgqM2GO
         D/rYaZGuBiqjac0gGNSssoEr/xMQhMwL8NKYk8Q41frwzAuKbDpKtQRgo+LFYdBheafO
         6+Pn2wvSOEZqe9dMOqfqgQP5Ev+qgBbHPJ7feDSpJG5w4F2fS+r52tpbcbMsn/svXCYg
         fV9qjmh9qVyDJzSpJToueZuitrrEzM0slIT1W8qw3pIDLPayU6hGn6CTMIrgJ5etCOS6
         1DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200879; x=1686792879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Cx15BLkSeVQvFI/U9q1IQdOHGoKBxbCCuah8hLlwTg=;
        b=abB//waji5YIHKm8HL4FqXjU3KIO0TwrHsqa+D+fqSnzgUFgtcDYTU7KlR/qA7znl6
         KjOuzaxVEedPJ34ayC+LYpeHMeDbS68AfqAf91LOCVP1w1Je5Ga1NhueJ/U23DK9klAf
         15wo3Vsi8breOhqW233FFfYvBcM7riUI6GAugfkDf2e9W6lpYnHMGMqSqzIuozMWL4XN
         xIF7oAk8z8UWLvCayJNn77DI92OxuchiWnff/bR4h6dRy7whtRfdYqRfrDUnd0HQd5qB
         dRix4gvDBbiZIFsjz1px+Z3bELNgGdavY/4EgJs1HF89QUt+6AvNOnrtCb/pBNFbrt8o
         0XVg==
X-Gm-Message-State: AC+VfDzpMuT4KCA5vAxhM33/2OFcbsw4XTrFcVD2di1jXZnMpSln/vcX
        pDkgXlfT23xxmSvW2Cy4Bs0=
X-Google-Smtp-Source: ACHHUZ5NKLSmUOYJvEZN1Nih3X1gZA+9PO969hhVhNEcrEjw4hXCTy6Jw+eUbX49BbybXJPl9U7gvQ==
X-Received: by 2002:adf:f58b:0:b0:306:2b85:8dc5 with SMTP id f11-20020adff58b000000b003062b858dc5mr26121280wro.37.1684200879101;
        Mon, 15 May 2023 18:34:39 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id i10-20020adfe48a000000b0030789698eebsm731208wrm.89.2023.05.15.18.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 18:34:38 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
Date:   Tue, 16 May 2023 09:34:30 +0800
Message-Id: <20230516013430.2712449-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Shida Zhang <zhangshida@kylinos.cn>

From: Shida Zhang <zhangshida@kylinos.cn>

This fixes the following warning reported by gcc 10 under x86_64:

../fs/btrfs/tree-log.c: In function ‘btrfs_log_inode’:
../fs/btrfs/tree-log.c:6211:9: error: ‘last_range_start’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 6212 |       first_dir_index, last_dir_index);
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../fs/btrfs/tree-log.c:6161:6: note: ‘last_range_start’ was declared here
 6161 |  u64 last_range_start;
      |      ^~~~~~~~~~~~~~~~

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9b212e8c70cc..d2755d5e338b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6158,7 +6158,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *log = inode->root->log_root;
 	const struct btrfs_delayed_item *curr;
-	u64 last_range_start;
+	u64 last_range_start = 0;
 	u64 last_range_end = 0;
 	struct btrfs_key key;
 
-- 
2.27.0


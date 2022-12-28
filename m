Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5766657273
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Dec 2022 05:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiL1EFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 23:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1EFK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 23:05:10 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D025D13B;
        Tue, 27 Dec 2022 20:05:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id e21so416863pfl.1;
        Tue, 27 Dec 2022 20:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jK0tDIcLfnflzS1LznZP6x/fI+ZY0ZL4k2RInKThgIY=;
        b=RctnmHHOeHRoTlYvNNisGCE2Wz4+3xO7Cp0I8yrPtcJpRXIIXvXKBrdYLm2dJKp8Qf
         uGpm2988jUYQtm00sIinDLQpJsANsha7m5c0Xi/8/HobfS/XP29Zy3BG00R9kBVWv7mZ
         OLximqa884rNy2qlxdbjbWE9CtxSMJBW/08tYB7S/gAeOLzISPQgVaol2+2x7oGA/xCD
         ta/wtXLyoIVfM78JLiraScZkmlbinyBDzUlAypNArEIwCWS9+INxNIL2LjekRXzsF0FI
         FLc8QYJEhskOC74nxf20jf4IZO09uqrBy6vjmqvdxGs/gNJlTMS8OPQKa6PC5Oeg5Sk4
         PLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jK0tDIcLfnflzS1LznZP6x/fI+ZY0ZL4k2RInKThgIY=;
        b=Rd3kK37bSFU3RUL3p3QdVmDqpZUPUspz1YuUJGG4j6jqcrqRemxvCxLpPQGTFVsB0a
         lzHEVKcPQG97Fp/UynKlH/47OuY0CQk+sVZgCWryEvjb6yXgMprBASi+WWmOJwnHE7QM
         AnmsbDw2kRRDrQe6YFztC+SgMexQahdUAB/CkIkCUgkSXj4ol5vtFfueAJafy9wrwMem
         PdovsgpD44Mq8dCOufRwtMqAyvZtpE8g3nRKjWf5Z5xte79WB/UsDmj2EO1+AY2VNfYW
         MQDMIzrVllPNkM3328a0DwAiipXYl606lijrtRpl8w+6OsuPg5SynVS6somKPw9YC1hq
         LWtA==
X-Gm-Message-State: AFqh2krL4X6InherPJuV/ImQgdpaw5Pwyi0PFsvGbPet/lOyrDlT7BCo
        0ilYgwwh5bDthHLg4eo0T0k=
X-Google-Smtp-Source: AMrXdXuuYs30wiC2IfBDU1nWCD8vYDJrC6lTUDmnvBNKqUoGI7wjo5+rB4R4jlB8qODkT2RzSb6mEw==
X-Received: by 2002:a05:6a00:bcb:b0:581:824a:c45d with SMTP id x11-20020a056a000bcb00b00581824ac45dmr2381900pfu.7.1672200309029;
        Tue, 27 Dec 2022 20:05:09 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id g11-20020aa79dcb000000b00575caf8478dsm9284815pfq.41.2022.12.27.20.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 20:05:08 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] brtfs: use PAGE_ALIGNED macro
Date:   Wed, 28 Dec 2022 12:04:47 +0800
Message-Id: <20221228040447.3566246-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

The header file linux/mm.h provides the PAGE_ALIGNED macro to
test whether an address is aligned to PAGE_SIZE. Use it instead
of IS_ALIGNED.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 fs/btrfs/lzo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index d5e78cbc8fbc..71f6d8302d50 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -280,7 +280,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		}
 
 		/* Check if we have reached page boundary */
-		if (IS_ALIGNED(cur_in, PAGE_SIZE)) {
+		if (PAGE_ALIGNED(cur_in)) {
 			put_page(page_in);
 			page_in = NULL;
 		}
-- 
2.27.0


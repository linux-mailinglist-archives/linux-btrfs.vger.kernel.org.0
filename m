Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6159D5A5E53
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiH3IjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiH3IjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 04:39:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D96D2EB6
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 01:39:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q9so10048519pgq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Gl8SS46VBLalAZwuxGWkXfRIJ6dxp0fNqogA50NPGCQ=;
        b=K6srfPpE1gRqtz/SbA2QY2aGiGZ11H/x5t2OWsv/5HspK0ZQpQOkGukwGq/L8gGWlA
         2KL3umgHLGf3cmGei9u9mlkr99jinJ5sawU4EKA8usLgADeE7wEm2H3ijYSsh11i9Okp
         hPgc+uLzNk4NOijz5d/La+Tfq7SvlxWIRS5KXd0qVBR8oA9sI6isNMz8uRmhv+96tA+J
         6337wIyTrI6PsEOZC41iJFyU03Q+hGtZagoHj4QNVt+yy+20hlHCV/w250wLmzbaBk2p
         7XfG9kfBgiDqTKGsTIERnaBgLRvOABCyJUSkYiT+l++p9do3MoBM/Vr5juq779TQ8ji6
         IQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Gl8SS46VBLalAZwuxGWkXfRIJ6dxp0fNqogA50NPGCQ=;
        b=oZkCAOMkqC/XQ80NVgurgaDPOitk1cgA8GP7tgdI0Rbq9Bsncf3FTl0bkinZ4OVuKI
         uFrXh4egBvqTv+LJxJ9aqK6xGdKY51R/E05JmfaVD/81NQA29r5dtedOJvwCw5x8xDUv
         LGILxpwXLVbD4E6cDvFwalIATfTkhOQTr9dZlhU0b9nfDw/leq7sYZ+GaSKjIZ64FX+/
         1nVQunwsVxyWHYPgo+ToWNeQM7horvp2nRgbXtA8RXElBkY/FN9jucH9zCHH5eDHtPg0
         4LTWbu5g+Bvgdg1YPl7k0YOHnfTY0FNpJ2NvVRBopRlE+iUoMzhbzrflvOCo782yChKQ
         VYrw==
X-Gm-Message-State: ACgBeo3iqiolkqxvZidiCbQUdgfOLeu8w+j5GvUvgQr953Xdew4jvxIG
        MDzg00LkSDgCkGVhwSLMHgQ=
X-Google-Smtp-Source: AA6agR7G9wbGu1NBzgJYZktM6EAgP2+Fu/AuJmD2ulIt4r/PvhcdRtcrWnw10TApViutDoyKC8GZ1A==
X-Received: by 2002:a63:5a61:0:b0:41b:b021:f916 with SMTP id k33-20020a635a61000000b0041bb021f916mr16875690pgm.387.1661848762343;
        Tue, 30 Aug 2022 01:39:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b0016eea511f2dsm9223554plg.242.2022.08.30.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:39:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     dsterba@suse.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] btrfs: Remove the unneeded result variable
Date:   Tue, 30 Aug 2022 08:39:14 +0000
Message-Id: <20220830083914.276926-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value iterate_object_props() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/btrfs/props.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index a2ec8ecae8de..055a631276ce 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -270,11 +270,8 @@ int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	u64 ino = btrfs_ino(BTRFS_I(inode));
-	int ret;
-
-	ret = iterate_object_props(root, path, ino, inode_prop_iterator, inode);
 
-	return ret;
+	return iterate_object_props(root, path, ino, inode_prop_iterator, inode);
 }
 
 static int prop_compression_validate(const struct btrfs_inode *inode,
-- 
2.25.1

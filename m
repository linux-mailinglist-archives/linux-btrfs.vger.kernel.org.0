Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8654DE4F9
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Mar 2022 02:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiCSBWK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Mar 2022 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiCSBWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Mar 2022 21:22:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3421E1081A5;
        Fri, 18 Mar 2022 18:20:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p17so8401740plo.9;
        Fri, 18 Mar 2022 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVxiWu7GNyhnLn9AtcfYyZRc2VNjBYlYu44IiOTszec=;
        b=DaXCRIX6d6aCRxjipuNP0d9OC2oBuHC4ht8pR0HOgOLvY+PmSmwJWmTlH0HrlcB12F
         izZnGzljMGcRWp0t4u0IM8LZujbGuMCKGe/QMpgKxCAMEQD5abZwzIR/pCOXzG72UAbZ
         cMyfYumazIXjV8XxYVuDUrJFDcNdRISYoNrosSivABbxo3wtrgMIB8dgnNqPTUlbeHCu
         eFmA459ktUEwVIFF0W4StAFQdUW0Eei99oj6Qds8mncTFmjDS6Bpj/zSLvBHlIjrERMu
         44GO/p85is2vk+4RONmiN+BfQoZu6BQ8hNSu6s7hhXLGd3hbYXu8kIskE/TKZSOIBNil
         hv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVxiWu7GNyhnLn9AtcfYyZRc2VNjBYlYu44IiOTszec=;
        b=nnNcX03Gryx+YKBwDOG0u27YA9yGA41Aov+z++X1VXxxJs0jrQJ/AdXau5557EWKko
         3F60kS+6zeIp/f+CdnyNGbeL36K8Jths7LSar+oQS4XxgOzRytVuJvOh+QCfpNosJHi9
         Om/+RhJY/xi4SAOHb6ECGeVYXy1+wlG/UrhVaaSbLwzsnoz66Hhde3nRQrUuqzz41pms
         ZDnqWeBieT/4MTkzRzXITqCytIafCf8v2J12h/3ZwN9StZODuFfQ5sdgmJwwqeOxCfbU
         rEwyf9RsQ/8zdjt8QSqfasZxOr8AuCQqSm84FW0S1gwuvGSXy6O8cgQbnuqpxpZ5BP4W
         mz/g==
X-Gm-Message-State: AOAM533vT71mBciWoYL0I9TPxMang3kd6WCrZyFluCw4fAHE7/CC7E5J
        pnAG1eY+PuR/4I4KvS1/OqHjkHhJBLyJOQ==
X-Google-Smtp-Source: ABdhPJy/ZCWTYv3oI4AO33xLBRg5mUZPR2AtEhvCUH2xa/H8PUZS0IQnoAFGeLXsWEqaah/i6Dp8uA==
X-Received: by 2002:a17:902:d4c2:b0:151:d590:a13d with SMTP id o2-20020a170902d4c200b00151d590a13dmr2252605plg.85.1647652848448;
        Fri, 18 Mar 2022 18:20:48 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id ep2-20020a17090ae64200b001c6a7c22aedsm2962162pjb.37.2022.03.18.18.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 18:20:48 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com,
        Yusuf Khan <yusisamerican@gmail.com>
Subject: [PATCH] btrfs: raid56: do blk_check_plugged check twice while writing
Date:   Fri, 18 Mar 2022 18:18:40 -0700
Message-Id: <20220319011840.16213-1-yusisamerican@gmail.com>
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

Do the check to see if the drive was connected twice in case that
the first was a fluke.

Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
---
 fs/btrfs/raid56.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0e239a4c3b26..f652900d7569 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1750,18 +1750,23 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
 
 	cb = blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
 	if (cb) {
-		plug = container_of(cb, struct btrfs_plug_cb, cb);
-		if (!plug->info) {
-			plug->info = fs_info;
-			INIT_LIST_HEAD(&plug->rbio_list);
+		cpu_relax();
+		cb = blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
+		if (cb) {
+			plug = container_of(cb, struct btrfs_plug_cb, cb);
+			if (!plug->info) {
+				plug->info = fs_info;
+				INIT_LIST_HEAD(&plug->rbio_list);
+			}
+			list_add_tail(&rbio->plug_list, &plug->rbio_list);
+			return 0;
 		}
-		list_add_tail(&rbio->plug_list, &plug->rbio_list);
-		ret = 0;
-	} else {
-		ret = __raid56_parity_write(rbio);
-		if (ret)
-			btrfs_bio_counter_dec(fs_info);
+		btrfs_warn(fs_info,
+"during a write operation, the first check to see if the drive was plugged in failed, seccond check succeeded, write continued");
 	}
+	ret = __raid56_parity_write(rbio);
+	if (ret)
+		btrfs_bio_counter_dec(fs_info);
 	return ret;
 }
 
-- 
2.25.1


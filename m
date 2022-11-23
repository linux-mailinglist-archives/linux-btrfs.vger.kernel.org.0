Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56126361FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 15:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiKWOkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 09:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiKWOkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 09:40:06 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9E11C02;
        Wed, 23 Nov 2022 06:40:05 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 136so16960069pga.1;
        Wed, 23 Nov 2022 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIsQcU06AK3WRXnlabkbvw+SZ63tPowhBviS6H4nIV8=;
        b=bhWvXZX3GpxZRORmAcForRgQzy5Xw9L2lwowGxv3sS63xcfykrdDt1E2E2gMe8bOPY
         CdmXiLCW2OFAUoM0/HsEAGFHAOcISHZPhBkoGwaJmrQ/Gq9CXkocKo/x4/So2eY4YNIv
         MVDqSwZ77Awmbfq0rPBAKGHCn/LisZ4LzNqWtcsEmYW5PaQs6kVEFasr5qFXQ2Zq9dzw
         JbOXpI2hEpNhxuLGV5d2RMiGLSK37h8NYb03XSjKC8GLDtxNryKWocI0hFUz7YtG6a5H
         LYYPUyNcIajrHFN2HJFV8O7sqvfOxQzAk2h2Iw4EI7I0jYkb+gxcdPF9KFP/9AM1hOH3
         K38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIsQcU06AK3WRXnlabkbvw+SZ63tPowhBviS6H4nIV8=;
        b=3jXnoOeLopExwYsTqP0RtdTTVeXU4dbEqgq4E1Ux3juHj516riBhkKhu4TOmjL4rpS
         jMW1f1NM6jLoRUholKnN/DaAosjWfsSVSKbbxkvjeoZ9TO+71hTF1LnoZwGbUv8CyfPL
         2pSjBEb2WozQBmwSfKkpttK2JHNfduYQ+PRe7ddfEQvyEsCqItYLAnWpD3O1CLK5QJjB
         g33ZxUwyjZ80ZoK2U40Zy+B2Q0kF8SF1CtkvsG1Yv0dsB3LkqI0Vx/rhSMgIjBuW8nBf
         nc75/a2slC9fW7zVZCRi5Rkp1jHmUtNfTAYTLJ04BfxiHdfMd9TX1wa5HUKAfOoK6Q32
         GfZA==
X-Gm-Message-State: ANoB5pnMQzprb+J04jsGlKF2lE8cMSC8otnQUs7U1hyXI2fKUQua7Tka
        5f1qhgznCOToLwF0zQ69/nY=
X-Google-Smtp-Source: AA0mqf6naUoM/rh1taT5Ux7w7gInpiYkEdCFj6do7CRuDeYDIfjYPKDxcvNKSVs4gEulmiB9MH+LGQ==
X-Received: by 2002:aa7:8054:0:b0:56c:4303:a93d with SMTP id y20-20020aa78054000000b0056c4303a93dmr13403671pfm.73.1669214405086;
        Wed, 23 Nov 2022 06:40:05 -0800 (PST)
Received: from DESKTOP-HHR6EMI.localdomain ([58.120.209.5])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902c71100b0017f5c7d3931sm14118037plp.282.2022.11.23.06.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:40:04 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        void0red <void0red@gmail.com>, eriri <1527030098@qq.com>
Subject: [PATCH] btrfs: avoid use-after-free when return the error code
Date:   Wed, 23 Nov 2022 22:39:45 +0800
Message-Id: <20221123143945.2666-1-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

free_extent_map(em) will free em->map_lookup, so it is
wrong to use it when return.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216721
Signed-off-by: void0red <void0red@gmail.com>
Reported-by: eriri <1527030098@qq.com>
---
 fs/btrfs/volumes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 635f45f1a2ef..dba087ad40ea 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7241,8 +7241,9 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			map->stripes[i].dev = handle_missing_device(fs_info,
 								    devid, uuid);
 			if (IS_ERR(map->stripes[i].dev)) {
+				ret = PTR_ERR(map->stripes[i].dev);
 				free_extent_map(em);
-				return PTR_ERR(map->stripes[i].dev);
+				return ret;
 			}
 		}
 
-- 
2.34.1


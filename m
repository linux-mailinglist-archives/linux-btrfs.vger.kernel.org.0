Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E788785A95
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbjHWOd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjHWOdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:25 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF893E77
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bca5d6dcedso4364767a34.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801192; x=1693405992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzhoi3X8eNVANHEyatN34UIapOSXaoRN4o4V10+WQeo=;
        b=cUbHvJxnWpjDrspGtNqaHl6DLbj79RKbLHLfJuo6XaRGrrsz5EMypajylDIczo6yF2
         nBZ7QJXA86HEhDmwQ1++B8L0YW/iZUvSBjtkbhlVkxn2iFv34ieb3qjAzCUA1xF4AW3/
         Un541ZFf3EfrTpKB6W+8tpCsD48NyFf0P3V9qQlZkG9kRhVvGiQuoYPTUcJS4g6MIwEZ
         S+LKMBKWqIyQgD1PFztUiWivOu8YIkQHTg8HGMykQKXY5u1VZYniUZeaIkjb69eIiUem
         mGpb1gwM1+Zrz2NdIR6SeLhCcvrW72zNAFw/P8x6gc9tgdRgCBBxSd8sw0n0g6fgpXmq
         FZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801192; x=1693405992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzhoi3X8eNVANHEyatN34UIapOSXaoRN4o4V10+WQeo=;
        b=jeilgTlvGk2RHKDgv7S88llCkzAJL1G+MYWSmP717m43O7tAslso7pUbocqiiTuePD
         TkUwDFYOAM160xiEBygMwt3N+naJWSNmUK9FF5Bo+uI/pltYkQIypaPQJIQN9SYAt/Zy
         jWoYLmEqgJh7CTtSXWl8NTblU9vOuZW7+l5tsGWSBaQgk5CWSNfh3lZlmSWsPWA/snTY
         GEcXvi7D8G9C4YPu8LGPnc5Q8D/9mYXqw3XaTHPer7bU4AFcAq7DteSIFUUMLTMWEcf0
         30z+SXRSIwD8MVm/aSaqvsimJh7stIy/PAVh4S+AUGSljVCD3rmB7+3sPv2stQLQWbSF
         beVQ==
X-Gm-Message-State: AOJu0YxtocBFhN7Zp6oojOhrCS9+B8phxUYCM6ojU2pZTdM0cNaDAgRF
        hPJ3rLoVWuz23mZX9ydkbuxCuhdRaAKr0QTlhoU=
X-Google-Smtp-Source: AGHT+IFreGwYoFaTvY4ESOpAiWL8bEPyCHeDRqCVjnU6+0t49/Gxb3dZd9EPagcowUr7lzyBt12UGA==
X-Received: by 2002:a05:6358:2791:b0:139:c7cb:77d4 with SMTP id l17-20020a056358279100b00139c7cb77d4mr11859680rwb.24.1692801191991;
        Wed, 23 Aug 2023 07:33:11 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v14-20020a81a54e000000b00579e5c4982fsm3377201ywg.36.2023.08.23.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/38] btrfs-progs: remove add_root_to_dirty_list call when creating free space tree
Date:   Wed, 23 Aug 2023 10:32:29 -0400
Message-ID: <0fb703b5ba71157cf5fb4cb18174538a49b036d9.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we insert the free space tree item into the tree_root when we
create the tree we don't need to call add_root_to_dirty_list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/free-space-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index a2a3663d..34a19464 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1522,7 +1522,6 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	ret = btrfs_global_root_insert(fs_info, free_space_root);
 	if (ret)
 		goto abort;
-	add_root_to_dirty_list(free_space_root);
 
 	do {
 		block_group = btrfs_lookup_first_block_group(fs_info, start);
-- 
2.41.0


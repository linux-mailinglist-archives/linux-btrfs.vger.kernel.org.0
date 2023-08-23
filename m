Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEA785A76
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjHWO17 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:27:59 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09DFE54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58dfe2d5b9aso76920977b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692800876; x=1693405676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Nn75m+fh1uPSGEiOj/Qn99LtEXbrG94dEXOTxOP+tg=;
        b=nLFTI31zRqWxkcXTmuaSyeun7cjDw87zuXaZc63HCkDbEh8IrgVYoOvh7wce4AINY/
         VN+x8XxHNCdcdVPUemb59ewkcU8e9ckULXL4kTaRbpPTww36JERiEs3wXKJbOOGmwp/0
         dSWrHklH1L5UmjGRF/1JJoqFIuhZJ79a1eDf9ERdDnVPdo1cP3dRIngPrSBlVTXzssWQ
         TYr2QZAcRj2qP8Jye97JEPu1a3qJXxR0kwe+uPz/8sV0/rDQqhg9YY5L122BPH2vo35q
         NM/Slmzy5GQvoqXFI+nd0JCgvHbLJH8qV7CffbigKTU7q+ce96SzUpVimQroXK9VoASA
         rPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800876; x=1693405676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nn75m+fh1uPSGEiOj/Qn99LtEXbrG94dEXOTxOP+tg=;
        b=WJsDoVaPF5aNlCDAWslTw4RCSauNFljREy796dqT5UHqNfx86F/mnwwyHXlumwCMnu
         MI2yEUFsQFgeSFBcP8EMnd1etvAbRlRsAnLTRMjrS5wicg1XwikFqNH2AhekAYjo7tPO
         hYw9GkUe/gho+8mg7ST1jpIoknQix7HrRctiE1Qcfez2yInEa6J6GEXLPKK7PoVugKAz
         C+o4YkBKwkc0fBMePnfWCGPKlXSFvIZm0byg6ffJ938OddHMTI3DDhWlbFNJ/o36EUZ4
         3pkwYYV1fb05ki151uBWjph44bvfUtDzu2FDKWH5GRT6GZ+KqizTmH1aZA5y1K+h4qO1
         9MYg==
X-Gm-Message-State: AOJu0YzYfOhN1+8I3qvtX8aLeM3wYq/QP0PcnGoJ91IUvjeWTQZBgpgN
        js301IZFDB/vQfy+y/6mcA1Qf8jg/pM2uP0Z9yQ=
X-Google-Smtp-Source: AGHT+IF9UxbpHOiMlyLqJZhTKzyVtBJkGbwYSqJvpF+sTvkSV3Hf+iI9ms5hHKNccwAOWvVpN+bMpg==
X-Received: by 2002:a81:9154:0:b0:586:9384:ffd7 with SMTP id i81-20020a819154000000b005869384ffd7mr11914445ywg.9.1692800876604;
        Wed, 23 Aug 2023 07:27:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z3-20020a81c203000000b005899c8e8242sm3336182ywc.138.2023.08.23.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:27:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs-progs: clear root dirty when we update the root
Date:   Wed, 23 Aug 2023 10:27:49 -0400
Message-ID: <5867c49c060d81c16fff55e20f62c0702ceae91f.1692800798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800798.git.josef@toxicpanda.com>
References: <cover.1692800798.git.josef@toxicpanda.com>
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

We don't currently use the bit to track whether or not the root is
dirty, but when we sync ctree.c it uses this bit to determine if we
should add the root to the dirty list.  Clear this bit when we update
the root so that the dirty tracking works properly when we sync ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/transaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index d30be5b5..49b435f6 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -14,6 +14,7 @@
  * Boston, MA 021110-1307, USA.
  */
 
+#include "kernel-lib/bitops.h"
 #include "kerncompat.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
@@ -119,6 +120,7 @@ int commit_tree_roots(struct btrfs_trans_handle *trans,
 		next = fs_info->dirty_cowonly_roots.next;
 		list_del_init(next);
 		root = list_entry(next, struct btrfs_root, dirty_list);
+		clear_bit(BTRFS_ROOT_DIRTY, &root->state);
 		ret = update_cowonly_root(trans, root);
 		free_extent_buffer(root->commit_root);
 		root->commit_root = NULL;
-- 
2.41.0


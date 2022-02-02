Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137684A7A99
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 22:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbiBBVpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 16:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiBBVpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 16:45:12 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21490C061714;
        Wed,  2 Feb 2022 13:45:12 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k13so1749152lfg.9;
        Wed, 02 Feb 2022 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsZCuSDsUy/P9AjbDsDGnz1EDK8jhukP3jFdHxX+3Is=;
        b=cR1CTcfVhHaKXOr9wEEIqlQtWxBGArI0hq6ww4zkWxV7ubwux4VgBLeYZBBsM1llWj
         UpUbOHcgBOiXwaDAhHXCuiI9wWSF3J69izYk9Oi1errJRRqCt2Mg64xxcuhIIFVMd0I9
         wTQD/2qBMa40GlYR+o4HmjaHXt8ukK6SxH0m9Ho5B+hyckOx7E2tn0neolZEJuEpk1q/
         IIIwFB78AZ3nzwb9d4iWdyO2+CfZaPc3807H/XnCtE7IK+X1ZMg82bkUtwcNCbO4UMq2
         qubaSytclcHZ2uQmuMcK6a79FToEMGkgFIAyUtgF6Y4/W+409FOCC1E7qDFYgpAIZLiU
         3cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsZCuSDsUy/P9AjbDsDGnz1EDK8jhukP3jFdHxX+3Is=;
        b=U1nh/GmC7Q9ckGD6WtockVjA7Crt2PQV9swtbKOv3TOJgYQ2b9okRSgp2PMTUwxAK/
         78ryqaXDjEE9oCSSn6msv6nB5ISyEWcAiPOZ/Qm4Pq53wcPrjoxf2VpQsC9caWRIdZpc
         Si6H8SRFSzXyA2gb5wjlhv/ANQJk/qmGFW7vW13l1/oi2ffDir2YRLkf2e9MgEjgbEfu
         CezoysRM6u4eh42ZgRNWSoYZBbXqGhtJkoq6uCofjHVXnlaQzmL5JMu0QMsy7UifPMIq
         8CVxXstkL3uVMekWiCDgfvd0oLI1mAUeVgqKEfzvcSiY66liH2RbP9/j+REQNR7t9PZv
         ci9A==
X-Gm-Message-State: AOAM533Oub71xVKPUQkjlKR6zUMJujMmAAPrBAo8/JtN1LGbZSVF4Hv3
        9tqV07wW273EZBrJ+krWzheOraO5gROZXJxHZtA=
X-Google-Smtp-Source: ABdhPJyniYMv/i84IlAxliz5k4dHMzgc9Dq6LJ0H4VPEWda5T6t/Lcep3V+w5zJeMzj6/fyfZz0xyA==
X-Received: by 2002:a19:f014:: with SMTP id p20mr24450386lfc.68.1643838310069;
        Wed, 02 Feb 2022 13:45:10 -0800 (PST)
Received: from ArchRescue.. ([81.198.232.185])
        by smtp.gmail.com with ESMTPSA id p21sm3357970ljm.60.2022.02.02.13.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:45:09 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH 1/2] btrfs: add lzo workspace buffer length constants
Date:   Wed,  2 Feb 2022 23:44:54 +0200
Message-Id: <20220202214455.15753-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It makes it more readable for length checking

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 fs/btrfs/lzo.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 0fb90cbe7669..31319dfcc9fb 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -55,6 +55,9 @@
  * 0x1000   | SegHdr N+1| Data payload N+1 ...                |
  */
 
+#define WORKSPACE_BUF_LENGTH lzo1x_worst_compress(PAGE_SIZE)
+#define WORKSPACE_CBUF_LENGTH lzo1x_worst_compress(PAGE_SIZE)
+
 struct workspace {
 	void *mem;
 	void *buf;	/* where decompressed data goes */
@@ -83,8 +86,8 @@ struct list_head *lzo_alloc_workspace(unsigned int level)
 		return ERR_PTR(-ENOMEM);
 
 	workspace->mem = kvmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
-	workspace->buf = kvmalloc(lzo1x_worst_compress(PAGE_SIZE), GFP_KERNEL);
-	workspace->cbuf = kvmalloc(lzo1x_worst_compress(PAGE_SIZE), GFP_KERNEL);
+	workspace->buf = kvmalloc(WORKSPACE_BUF_LENGTH, GFP_KERNEL);
+	workspace->cbuf = kvmalloc(WORKSPACE_CBUF_LENGTH, GFP_KERNEL);
 	if (!workspace->mem || !workspace->buf || !workspace->cbuf)
 		goto fail;
 
@@ -422,7 +425,7 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	size_t in_len;
 	size_t out_len;
-	size_t max_segment_len = lzo1x_worst_compress(PAGE_SIZE);
+	size_t max_segment_len = WORKSPACE_BUF_LENGTH;
 	int ret = 0;
 	char *kaddr;
 	unsigned long bytes;
-- 
2.35.1


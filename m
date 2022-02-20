Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F2B4BCF11
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Feb 2022 15:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbiBTOqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Feb 2022 09:46:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBTOqg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Feb 2022 09:46:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F853702;
        Sun, 20 Feb 2022 06:46:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m1-20020a17090a668100b001bc023c6f34so2737692pjj.3;
        Sun, 20 Feb 2022 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgS6kerTVTZEPFtaozzEk5NaV1/XOee+v1wXFW66chg=;
        b=MkLnXQKr78XNHNQr64gTtkQWR05yMzArP/ZN4yRNkp/aCkE6XAIaQ0et4cpTSRNlQm
         G3meRKU7vxGidfyORZ0zXyGeR+yPAaUhmpiCj3StrD6EWFsweXF05woJTogMJjJx2AoM
         A5VkNbKigWVQbCv2+yCMgEhJB+bW4n8vocbmbf9hOuM+/tageUMWyRnpRAMrYH+aGegH
         ax3f/OLftPdoaD1YsFdM/5SqbgZHU/g2264Hy9PaYGf20kZdi6NY97lXhOkC3ypNoXyt
         7Ji3F3sOXK1Xv6ZKXUlVQreDVG5fqImLkvtWWoc08X0o0so2aILqOHgFhsiyXl7A4MnG
         VuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgS6kerTVTZEPFtaozzEk5NaV1/XOee+v1wXFW66chg=;
        b=RN7oQkyTfHX1Osl/e5vDt6KPFKqx+ifw/CaC0OWluXaoLELfJPXiFTllR1D2j879+3
         wDgfDYCNwdQu13Hiz5rlUmuOJMv20N7+29ugK3VwzzXwLt1nCJ373s1fQEzdO8LrRZK4
         TL41fccOJN5R8NcJMP3OtlQtj4VyssIEgVzr7e+5ebyhCHOLS6RRE860C0Pu/7yd75UT
         QBQc0Ajvf7yrtjWTNOXpOhdt+fPJgGjJFwSo6/uFSjaYXPyXlLoSmZasBq3Dhec/x680
         vIfNXVFZRGxRdHAbFOFxKEUXwNhifHJHx4kv5VJdx5jlMnOgaLeyIyrrSzt7HM1yDEBR
         /28w==
X-Gm-Message-State: AOAM5334/Qzyx/OdR2B5LsCXMF2gjdSwIyx0rf0xoEVSYWO1lLnO3NVK
        5ZLuuKJh30sAggne95etvzA=
X-Google-Smtp-Source: ABdhPJzVc7ivye/E72EOMqhrW2buJQ81swrxWqxFysdx9zCsNin/OGuT/XqyKOiY6AbOgVYofqHtFA==
X-Received: by 2002:a17:903:11cf:b0:14d:654b:b559 with SMTP id q15-20020a17090311cf00b0014d654bb559mr15382653plh.164.1645368375559;
        Sun, 20 Feb 2022 06:46:15 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9005:88cd:8c59:45e5:31c:c418])
        by smtp.gmail.com with ESMTPSA id i17sm15079540pgn.82.2022.02.20.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 06:46:15 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
Date:   Sun, 20 Feb 2022 20:16:06 +0530
Message-Id: <20220220144606.5695-1-jrdr.linux@gmail.com>
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

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot reported below warning ->
fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
returned to caller [clang-analyzer-core.uninitialized.UndefReturn]

Initialize ret to 0.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4baa8e43d585..5ca7e5ffbc96 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	const u32 max_length = SZ_64K;
 	struct btrfs_path path = {};
 	u64 cur_logical = logical_start;
-	int ret;
+	int ret = 0;
 
 	/* The range must be inside the bg */
 	ASSERT(logical_start >= bg->start &&
-- 
2.25.1


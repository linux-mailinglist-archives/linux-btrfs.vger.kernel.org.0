Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9574A19A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGFPyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 11:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjGFPyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 11:54:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A00FCE
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 08:54:08 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-579dfae6855so11140447b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1688658847; x=1691250847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiCA/eFrrHNy9ZKT7/iQY6SuclXZs/rZHo/QclQ7Wmo=;
        b=BgR+hSbuv8E4J1P86Hz0BdCmFE2BHvubWpQ20M6xNB8ZMbd+e/0GtvNkHV7Wgws6Rm
         VdUssyT/V8yyBF4UbrsEbmK3DkVKF8y/u3jep4wr4VOVHQDzsux/5WCTkCubBCp6F4oF
         j5z8hdXI/wss7ajscIdoNV4iKRRLlLfGCE2QsHWrVZ9OkleSxD5fJqF/xaSiMpM58oXW
         qSUldg5KcOnYbwXFacNzNHFfgAD+UK6/095TevHWZ13fsWqtLokB5jfWrS5lETmIxReo
         eVMaFVHhioG3ursYdLhUlr5L7O6dDnAfZbv3Jg1uPEGRypjoYqjrGSOY44aiAZ58bQAQ
         AdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688658847; x=1691250847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiCA/eFrrHNy9ZKT7/iQY6SuclXZs/rZHo/QclQ7Wmo=;
        b=kuBWPL65tNSVwmOTe0MlNv94/CvZ9IbkUevkUW4MRupUkD8/Ntt9INjO+XTi38Q7OX
         RWFMVzKXfrn0UPwTHIRQBUTBxUi7KW5R7hEgyeBnYMtCcC7qmrxtPt/kec8lRNf3qSrZ
         KkLpKsAzdPAJAZVwSzqb3BZrKHBld9VRh3hHImaMykY2OnzwHjq1pQiBVGtbR6CPQ3vh
         MXs06EvV8qp5Ik3vIZeG2isbMdq5zwfefhxSzrzs6HVF8EnCMjLLlpaXwhR4rdBX7FFz
         9dThT/nqLxX22/3aLZJr602ZvSyQ5eEDuyv3hR+PAEN/lZzfHw29aRuVybz7rUwHKKzW
         2PZg==
X-Gm-Message-State: ABy/qLZYkoRrOguOMbe9uUHBCV7EdLmoDmLR3Dapp3hlXZZVStOMGC0R
        dScTmco8wQySZu0WD35qyWOje8cqBV5gAl+DtKI+7A==
X-Google-Smtp-Source: APBJJlENQlQL0/HDtY4wxqpYvmdCZZB/v99Qil73QZu13SeasF2d2W0n4ybHusf5Tmi9vPRvo/KIig==
X-Received: by 2002:a81:7757:0:b0:573:b42b:4e27 with SMTP id s84-20020a817757000000b00573b42b4e27mr2226216ywc.16.1688658846716;
        Thu, 06 Jul 2023 08:54:06 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r130-20020a815d88000000b00545a081849esm429544ywb.46.2023.07.06.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 08:54:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a zoned file system
Date:   Thu,  6 Jul 2023 11:54:00 -0400
Message-ID: <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688658745.git.josef@toxicpanda.com>
References: <cover.1688658745.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently limit the size of the file system to 5 * the zone size,
however we actually want to limit it to 7 * the zone size.  Fix up the
comment and the math to match our actual minimum zoned file system size.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 8d94dac8..c7d7399f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -84,10 +84,12 @@ struct prepare_device_progress {
  * 1 zone for the system block group
  * 1 zone for a metadata block group
  * 1 zone for a data block group
+ * 1 zone for a relocation block group
+ * 1 zone for the tree log
  */
 static u64 min_zoned_fs_size(const char *filename)
 {
-	return 5 * zone_size(file);
+	return 7 * zone_size(file);
 }
 
 static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
-- 
2.41.0


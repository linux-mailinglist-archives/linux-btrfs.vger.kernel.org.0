Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E406263A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiKKVaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiKKVaX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:23 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F0FDEA2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:22 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id x13so4120888qvn.6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ap0U0t2a02rBzC/AI3ISx1NCYFTi/tCv/+++Vvg9PaY=;
        b=6KZ/H5466WAzVvEHOmG71bYhsZEweMCDoBcnm9SC2eFkL5VZutJ0/aU9hh1O5VaiLf
         QuZeUheNCGxXlQOm3vSkEm8cZlBStPBVzm+0qoQvelhCSmDVr+oXKglvzpiDgvpzDSrX
         IBpDhiapyyhfPVEICCJpG+ZBPbqYGIQ0sFeOBsbjbawstzaf0u8qpoeUgL14NgcrVEc2
         e4fmXDhCeKdzx0bI2q5eNjsymwLu32aoAzUQ41ELtQYA1NH6r+RjUCN7JDHbK8LXHnEE
         xGLNZ4cA2bJWy6LmdiCvypKwQqnROwXRe7iY2UIxdQK2e1vwfST0jHgxqZs+8c3/lXzQ
         Q8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap0U0t2a02rBzC/AI3ISx1NCYFTi/tCv/+++Vvg9PaY=;
        b=T4PgHFNj7wIp9UdZ3JZMxH3Cl0r+NXSYvZHi4c/1xzEjgArCoaD8mclVCOVkJkM+Li
         p5IY6K3wKEoJDcKIEi79CybzRrWwB6rqyaqLj3M/RZrA0gdP/pEL99fkHDn/d8/wVzn9
         g+VEqkW2nMwjcpLYzV8nBqHAKLVX4QgykdKqqJuHue08HjlHzOCS5kPuX7/UjzFCSVi+
         eKTXjyCy8I/XNRjLAssNWkx5ILCLBmdiTMC+Bcpf6bF2KBVY+TP6PgG1oyWFdW9A1qlk
         vi/YlcRAn0atworBV91MYLHEOKAzGCJy9vufPeG/TKK4bzmgBECGpChgXc0sWt0FlhNF
         ALqQ==
X-Gm-Message-State: ANoB5pkf66f9FhQP3OPtNgEXUYs1he9D0lJivVH5U/NMstWijBqI6tCW
        zwuZhUEgjk+QRyYKie2zlQN1j6ZMCQt4cA==
X-Google-Smtp-Source: AA0mqf5tMXt7wsMolDoq/0Uyw5Bbx/taxNZSAzAkOiTwjDoIT95gfg7D2wxzb4KkX353uEnDeLKIUA==
X-Received: by 2002:ad4:5a42:0:b0:4b8:5bce:14c3 with SMTP id ej2-20020ad45a42000000b004b85bce14c3mr3726875qvb.123.1668202221694;
        Fri, 11 Nov 2022 13:30:21 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a400b00b006eeb3165565sm2100661qko.80.2022.11.11.13.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/14] btrfs-progs: use -std=gnu11
Date:   Fri, 11 Nov 2022 16:30:04 -0500
Message-Id: <b53b7358ad72a3640461a9ff110d85940ff2eb6b.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel switched to this recently, switch btrfs-progs to this as well
to avoid issues with syncing the kernel code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1777a22e..f25042f3 100644
--- a/Makefile
+++ b/Makefile
@@ -401,7 +401,7 @@ ifdef C
 			grep -v __SIZE_TYPE__ > $(check_defs))
 	check = $(CHECKER)
 	check_echo = echo
-	CSTD = -std=gnu89
+	CSTD = -std=gnu11
 else
 	check = true
 	check_echo = true
-- 
2.26.3


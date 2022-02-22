Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422E14C048C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiBVW0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiBVW0x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:26:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27230B10B5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:27 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 8so3553844qvf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=suj/fvEAvRHPOZjBsYdOkYJ0wjw6CySP2/ziMVa4AGE=;
        b=nXRnAJ0BC93tRUns9i+4NiCeRuD3GoYsVANYbNYqmN3vMhFI26Sw1YpSjU7+AwaTLJ
         Q/6LPkhDOwjQFqgo+PL31XNOtDTkbrk3UkTIt5hmmtW5FzcbyW77udG5lL5azoDYwRJz
         pyeynNsGYvoSwjKocK0g5fdoLLty/yurnnBrkIuFtBIg+eLZsJ2WdsyHeb6sucBrL5VO
         vuzDMsmRbcG9Vgogiv7hVnW1IUvH+Y+TazPUlMUm7iQS/lnQei/pWG4r25gLqSF6WUYx
         t8YizPy/TEuQODR7hHPPj6RslBktJWRrKHIZxdojIwoGhRBexPyzE/qadSIiJBYLWFTV
         TyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suj/fvEAvRHPOZjBsYdOkYJ0wjw6CySP2/ziMVa4AGE=;
        b=fRTPI+iPS++9lCyBK3FrwDtmPhm68Ut7hQ0Sqy3icirDCD1FuVikFOi48HbMzHMmTz
         pg1OEOUPsNekVv3FdlDCKoobkWdxbikM85hpKl/aF+nml6MEpII5e5y/UkE756AIA+nA
         CbEDIZ9/bBXHl3f8beUn69hJhH9eacfhI67OMgshFi3v7pGkz3I9sGB6sMnq4VHrWgXo
         TA3bu1c3Ib1hVSArfEbW+WoJ+K8Q15oQ9wm3EQCig697B4+/htyNXT7wFulqO4TNayXE
         5ocfCmjuoW9KWI5u73wBBLSsfUqvRID5nnyoD7ctZtGrtdmWdp/0EAMB/8w1B5AhNQwC
         Kwew==
X-Gm-Message-State: AOAM5316u4y7Oo9p86VzUUTSSD9hARxyfZ3Gg9YyN2z7MBo9qrLAF3iF
        JI5cku7xkXmRaio//lnr7iolgHPmvpfoXkfr
X-Google-Smtp-Source: ABdhPJyHuyQCGiOwO4CJgz5iNTTnrUQ5MNAJknlkJC+/CfqQIYQ2GuS9vUw/6KAfXWty0xxNJid7XQ==
X-Received: by 2002:a05:6214:5003:b0:42f:bc42:6ce4 with SMTP id jo3-20020a056214500300b0042fbc426ce4mr20979907qvb.63.1645568785961;
        Tue, 22 Feb 2022 14:26:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18sm746440qta.90.2022.02.22.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/13] btrfs-progs: turn on more compiler warnings and use -Wall
Date:   Tue, 22 Feb 2022 17:26:11 -0500
Message-Id: <2e052f1f853c09952ff44d250e78f64a3ba1471c.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
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

In converting some of our helpers to take new args I would miss some
locations because we don't stop on any warning, and I would miss the
warning in the scrollback.  Fix this by stopping compiling on any error
and turn on the fancy compiler checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index af4908f9..e0921ca3 100644
--- a/Makefile
+++ b/Makefile
@@ -93,6 +93,9 @@ CFLAGS = $(SUBST_CFLAGS) \
 	 -D_XOPEN_SOURCE=700  \
 	 -fno-strict-aliasing \
 	 -fPIC \
+	 -Wall \
+	 -Wunused-but-set-parameter \
+	 -Werror \
 	 -I$(TOPDIR) \
 	 -I$(TOPDIR)/libbtrfsutil \
 	 $(CRYPTO_CFLAGS) \
-- 
2.26.3


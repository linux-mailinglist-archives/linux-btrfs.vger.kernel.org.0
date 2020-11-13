Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A52B202E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKMQXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:52 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA7C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:51 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so9307771qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tEEiwoGlV5uR3GfmKiKBu50FtMmYLYn2bjes02xqDBc=;
        b=nALXknGAP8Hh1o3bYVQVDHKcsNdXUvwJD5HVtsh0Ri0AvYuzlT1a+3WWZreDNOD00D
         ruIpUl3ZssRti8Q7ymuyUicsgKKsqPqA6byWmAggyTaIP2PXLS4MB+1kvpgIm26stH6J
         KmMt/h/XID3lCgwhRM1dIZLtvjoRBEXc+banNlqrPU4xXMnQ8cemd7UF/GxsIrcaYO1P
         vWck+oasNJ4hgqlAHVa1uHo4Cj6bFkikNAn4UYccLexzldjZchO5K1rQMtNS7nXJuJKV
         sSkvI8a6K6K4cBHyhU1QCgXSFXVSHmAWIXsnLMeGc4MUejHDZ4IZzffU3H2K3IJMJQhD
         5twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tEEiwoGlV5uR3GfmKiKBu50FtMmYLYn2bjes02xqDBc=;
        b=T1toYmug/UvSwAcyMnoY0mufKwDIwpAzo8gqMCIf/6cWD88mZ2O6KkIFluIGiaNOfo
         IH/p+8K27z5qRAhqpU3ewjaXv+HgcVvCv/T4I0SOfqTSyKCJtcl5q7vjWOB/UYH58Hqb
         VeBLRgcDn7vy4EbPO3EQkE+M0eX9OU0ESVW0mXe0gqyxkwlJTSkB8AyQQANOexcgZ9T8
         H3eH559O8OMXd0Xi8yxrTEFukoEOknapYnphwithR0Sup2+kSvFplYclMi2rwlpIrLgA
         aCTjVE26O9e+1FPWVCqat19ixgg/TnfUysOwYpbWipGN9LXz4jjRqd3iLvht0CKggcgL
         P87Q==
X-Gm-Message-State: AOAM531dbqTstQ3OMf/UynVvlsXVKKJ+INk5XuPsSjaa8rNifVlEfFmZ
        oiI4B7aQ2pL+cwDWooZP46ehxOwY//StuA==
X-Google-Smtp-Source: ABdhPJwcp5jLfFrmtgZdugjbg0p44hAayzIER7ChdQQwEEmK/KOHIywDMsG+UOvoSmrtnmXk4N7XlQ==
X-Received: by 2002:a37:b642:: with SMTP id g63mr2643795qkf.460.1605284625610;
        Fri, 13 Nov 2020 08:23:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o8sm7100939qtm.9.2020.11.13.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/42] btrfs: handle errors from select_reloc_root()
Date:   Fri, 13 Nov 2020 11:22:56 -0500
Message-Id: <ed0dad12b6d29e485f19aa6aaf66b8d78a48e6d4.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently select_reloc_root() doesn't return an error, but followup
patches will make it possible for it to return an error.  We do have
proper error recovery in do_relocation however, so handle the
possibility of select_reloc_root() having an error properly instead of
BUG_ON(!root).  I've also adjusted select_reloc_root() to return
ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
error case easier to deal with.  I've replaced the BUG_ON(!root) with an
ASSERT(ret != -ENOENT), as this indicates we messed up the backref
walking code, but could indicate corruption so we do not want to have a
BUG_ON() here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3a5e89c82fa5..89e9253846cc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2037,7 +2037,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			break;
 	}
 	if (!root)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
@@ -2209,7 +2209,18 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
-		BUG_ON(!root);
+		if (IS_ERR(root)) {
+			err = PTR_ERR(root);
+
+			/*
+			 * This can happen if there's fs corruption, but if we
+			 * have ASSERT()'s on then we're developers and we
+			 * likely made a logic mistake in the backref code, so
+			 * check for this error condition.
+			 */
+			ASSERT(err != -ENOENT);
+			goto next;
+		}
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-- 
2.26.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F462DC421
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLPQ1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgLPQ1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:27:42 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B7C0617A7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:02 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z11so23040901qkj.7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vzKO5a5BS15XQXu7afxbO40tSG9l7H7GGI1WZ9vnPW0=;
        b=p0Rida9KjPH6gubhHbfl/OkfxwdgQrXKHgfycDK1BxlCOcQqE55Wdw4+Za42GX9as/
         2dCf1CDWNi/lPqeoYvZCWhNmdFPS+rkIL84NfV9RAOl726UZ3uVtMCZlaUd70h91XVZP
         SaiJToci/RYOtGuqrDmfpo9QcUE/7yB2NX9KwHeIbil2Hcb7E/uy1WaHnAYtqutjPItY
         kTJyCD/ADrjbpoHEkrY2Gn2kh+3J+n/P717kwBY/x9iKFi/UrpH2f3FIm4Fm3jhqB9RU
         DGp3fhGpPmbRJV6JmLDh3ZEoFTQUDpGXNo68LLbL9ckiWFC0rO8zKH2oasB+H4X+re1q
         /85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzKO5a5BS15XQXu7afxbO40tSG9l7H7GGI1WZ9vnPW0=;
        b=eCU2ZZOYt0LdwmUoyeFNbSWDCqxnviUT+fkudLKdMngOOh8DfMipc32/6oEiIBtSp9
         TmYrsFgzLV6Kzb+yi8UfDjccKM36T8UmdELbg9dIiKyNlw5ib+rzVcFBIkxON2JPfZ6r
         +7YlstkjiQ8dzSzUxnOPAdJct2rvP1bn5pAfi378Q3O3GDa9GoY+X5eZbefUfE+Q5hmY
         nTGniZW25h0xYBTQ49WUKM2y8wUtrgnzM3Ya9EkP2MeBWKg5zns2WOUsXGt9Jncuvv5x
         EMNre9w44c9/C0kQmTqVB99iM5jzS6/bjAF8JnOLPFxeujPaevZRfYeijQMTILmBLM2d
         4gKg==
X-Gm-Message-State: AOAM533lqYNmvku6tpmx5vN/JdhsBdJFU478EiRGFOVUqJEtURYUQiQI
        59VvVEp3j4nRCgKz1KcDOpRCyGdqw5cFco1s
X-Google-Smtp-Source: ABdhPJzfhvy0FcVFUH5uAtXblLC/j487NHDDq1H3WwMW57I1bWIHIwo2Aa+qwYmazEPQ823G3K4Xgg==
X-Received: by 2002:a37:668e:: with SMTP id a136mr36730793qkc.221.1608136021044;
        Wed, 16 Dec 2020 08:27:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f185sm1342494qkb.119.2020.12.16.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 03/38] btrfs: handle errors from select_reloc_root()
Date:   Wed, 16 Dec 2020 11:26:19 -0500
Message-Id: <aa44497f5c2b8c96ca1229daa4dfdb6503971f31.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
ASSERT(0) for this case as it indicates we messed up the backref walking
code, but it could also indicate corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 08ffaa93b78f..741068580455 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2024,8 +2024,14 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		if (!next || next->level <= node->level)
 			break;
 	}
-	if (!root)
-		return NULL;
+	if (!root) {
+		/*
+		 * This can happen if there's fs corruption or if there's a bug
+		 * in the backref lookup code.
+		 */
+		ASSERT(0);
+		return ERR_PTR(-ENOENT);
+	}
 
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
@@ -2196,7 +2202,10 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
-		BUG_ON(!root);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			goto next;
+		}
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-- 
2.26.2


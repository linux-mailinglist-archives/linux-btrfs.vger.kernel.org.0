Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C22D2F7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgLHQZl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgLHQZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:40 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C3C0611CD
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:36 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 1so16482375qka.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNC/AlSaqkc4ae1+oHV65u8CN7lipZOahlMhp2uAjF4=;
        b=iPnsvjVMl6KCLApSn6mMTczOJB4Xb8or+R6hHyAkIuVJ9/IdfPDoBSHxKnwh6ZmFn2
         o2dKnQTregLyRZ/ljwbQVOMEsgfzHL3A5C8y6DZ5luHqUGt884LSYfCvwY44E/3Xx7g4
         M9fPZa7efbLyT0iP/W154f4MSWx/85+WRjFHZAkroZTN854CwZsus8HCewoIb5YTzNYj
         TjjYFh6z8aya8JS9itdb43dkIYzGnBN3O3+w6rQZUBa+4oXkChmEXTjeg6F8xsm6vRIc
         YKHFeTK5RtohGafTIvFuyx3Lbj3qXXpT99MmuMgXtF94nmn/Fl0rErt18E+xAiPnaxGH
         q8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNC/AlSaqkc4ae1+oHV65u8CN7lipZOahlMhp2uAjF4=;
        b=nUCCHnHa04MliNlZfh74MXYK1hPkLBLCxW6nW3tlBmuG8FoL1dT7MXf5XkmPR9rkNX
         9bsdrZZk1DGdNYf+7Zmg1RWG5F9Ut5RZZBpuygyS23s5Ph5amU6ntMgOEDnlAV5HALPF
         HuxzZcVjZLiKbiDXJMwt/jfakWkdzj4Mvu1/lEPNA3tgKSpaLL55/BrdhdgVjZVazakX
         HP3xRTFkkUPPlpeI41AL7DdFaZTFhikh9oUScUt8CG1CuhDPem4GQCTsE5kLorkE0ZBD
         Ajtw1F42enlGQmvK+OJxbAY/9CTrxDrE5PV0XGndYqUj9WN1PLw+i+vDfufQ4TdBvXLI
         HkwA==
X-Gm-Message-State: AOAM530Fr6fnMBciwXH7dfT8dFUmOO5b9bmhg/F2owIPmI+1hc/FhMuC
        kucROM0OpVnUWV77K2D3MVKBUtagRIN8zHYU
X-Google-Smtp-Source: ABdhPJzt1CGlTXXiTsxP5jOzlP7ueuyBPykVDPZ2i+gX1q8kX2xAdc6KXDRf00kNOJg6m0hDwwUkwA==
X-Received: by 2002:a37:490a:: with SMTP id w10mr23239511qka.487.1607444674925;
        Tue, 08 Dec 2020 08:24:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f59sm14125114qtd.84.2020.12.08.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 15/52] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Tue,  8 Dec 2020 11:23:22 -0500
Message-Id: <ae3d7e4f539bf062b2e11dd62d0c4e12b59a104e.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will record the fs root or the reloc root in the trans in
select_reloc_root.  These will actually return errors in the following
patches, so check their return value here and return it up the stack.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0d4c4e250a89..fd00517fb0f6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1990,6 +1990,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2025,11 +2026,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
-			record_reloc_root_in_trans(trans, root);
+			ret = record_reloc_root_in_trans(trans, root);
+			if (ret)
+				return ERR_PTR(ret);
 			break;
 		}
 
-		btrfs_record_root_in_trans(trans, root);
+		ret = btrfs_record_root_in_trans(trans, root);
+		if (ret)
+			return ERR_PTR(ret);
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-- 
2.26.2


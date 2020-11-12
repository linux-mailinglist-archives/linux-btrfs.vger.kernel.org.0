Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769D32B0FF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKLVT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbgKLVT2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:28 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D462C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:28 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so5234351qtp.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uHNDW/TGiKlAKJbiLuFwmc9wP8nCMg2KwAPiDpukers=;
        b=gbxMHo/rBGmt6CfevwisiHBbXzhJXorfsEYn2kI7EZcCMTK61KDYLrHPvXTGkIMFgN
         qWizK6sw/t/tRcdePVknCAOhG7MCEycuY4kWBMKtdVcRadTBSoIuFU5zzLn9uAVKz9g7
         c5yaRpqKjR4mlW2SXaWjEVaQTuOc/kyRC6CnSmwxT610FovPRAc88JRSsM32Kuoc/Skg
         yuG/zOweyK92T2XaIbAUeMFplFFwV+3+A+pJegBUziZVlHlO4naReevY/BJVS96Q1YPc
         1x/kew3tMt7fNqvOmt4PNkXUOEbjsO4jv5u6WgYYZtgbG7tMR58ulbriDSbP4RJ1g+Pc
         aLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHNDW/TGiKlAKJbiLuFwmc9wP8nCMg2KwAPiDpukers=;
        b=A9E7qhjcp1PTbHs2REcqZc/DJ3VKV65hKQ7/QEms4dFdqBFX8wBSAld2KN6yFDiK9o
         XcFtmE7Fap5BP6z3pZleUp12E7t2j3Nge4l83xnrO7cqcqt/3chSkoVxT3lS5pR9wxhC
         R/5ci7S/eFN/I5qO60OldlZmDzQrW98C1XAEihFoy+ByBA6Vw8tZMvIt874t9CQPNOvG
         1tT8Ok+u8oSrzDQUsnRKZgHZjIIXuKBRUk3EU1rZoFXvTzwpb0UXLaq6frDvVqp6qmrX
         wQaM28pHdf5UMbTYPYwl/tttZ91Cg12zohs8DcAV2/w58ajYr9UPNsxM4J8X6iln459F
         1u3g==
X-Gm-Message-State: AOAM530dn6BJoNXAubPaVldIYMXIpu0odZ6HshIaTSlWLXaGWCV2eine
        rfjZRRy2d8LQVOpUNh/9hk1ZVtC20AhZsQ==
X-Google-Smtp-Source: ABdhPJxw9eSLqU2uDZBPpr1tZ2xI+p8SmOjXSPgxqWiDue+vkdQ/RTlDqu8bzFGEWlR4BMJ1TLgHvw==
X-Received: by 2002:ac8:6f1c:: with SMTP id g28mr1191475qtv.65.1605215967343;
        Thu, 12 Nov 2020 13:19:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm5148395qty.30.2020.11.12.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/42] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Thu, 12 Nov 2020 16:18:35 -0500
Message-Id: <2e660b614f95aa2c585191a7ce89c96f231c2c17.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will record the fs root or the reloc root in the trans in
select_reloc_root.  These will actually return errors in the following
patches, so check their return value here and return it up the stack.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f5c562955690..5deaf56ceb8d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2019,6 +2019,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2056,11 +2057,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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


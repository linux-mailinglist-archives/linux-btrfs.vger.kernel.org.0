Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1202DC442
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgLPQ26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgLPQ26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:58 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D177C0619D2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:28 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v5so8358636qtv.7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V4IlVz0nB0vCl1dD9Ex9gLIurv5gPoDmMqxx9hpzPIY=;
        b=Qn38nhBG010LW3d9m2VcGR6M6c92WpMmch1ggH9vyieJRfuXV4bPJYBY43nEnkAWfq
         TRgpGeVfoduyOHjvRV3KFcpmWz3C8KPwQL0GgjA9e9vL4yOYUGm5JerNkzyxSKQazzRv
         iOkgsqt0BF0mEurFuPRG9TuePoIN7cbGKY28LyoXAvQQ6DQzzxY7WDpkI9KUo0/cXlsw
         4AiiS2w/o9AOthOJJQfsW14wO1+VvQdUoqrzkid4KyNGXzZ02mRBmbLbVEiX5cw8Z2tt
         u8xQDy6OWREKPS0I9bPcIbv6CeNEjadNKtFbbcoTPavf/FGPVrvhGWKLF4e3TNaFxHII
         Db9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4IlVz0nB0vCl1dD9Ex9gLIurv5gPoDmMqxx9hpzPIY=;
        b=K/qsFdGjcDxR5QXrJHMpBoWOhpcGrAhHohgSJ5c2SNkTYqk3y84nOlmQRekGPkwkBk
         l2B+pn+XttQSR3KssTaH2nHNN74NHENjp4LuCXGwHbTIlDLVAbv4BIJuhQOr0cQ6idgC
         sfh04nKmfUgq7w1/p00MyiA99he/vxLjawDFvIrjRvzmTx8fcF2GA9CL1xa+KetPCDwZ
         JPac6UD14pNVDMakatBN0B/LGX1VBe5NthTqxKSIIZw34VplUF+ERl45lPo7dOvx58gn
         osNGJwAZw34oiyHYTZoAuTmmNJ6aPeDbVwNbKAuT5Sc/FtHl59H/Q4XJSV1zDkxX4w63
         axAA==
X-Gm-Message-State: AOAM530T2kE8alIDTq6cd1aip3imtOVQ9FUjW5hxlzrEX0ybgUwiB9Ll
        qFrjdKHU5uuTF6Er94VcIBM0NlgICvFEGXbJ
X-Google-Smtp-Source: ABdhPJytauHFVnfDxqmHF3BtDZy5w8Si1b6dqBg4RrAjsfVuAyF0AAsizsxm7aKrQmSxS5dP5CDWLw==
X-Received: by 2002:ac8:6f77:: with SMTP id u23mr44188442qtv.118.1608136047606;
        Wed, 16 Dec 2020 08:27:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y22sm1366660qkj.129.2020.12.16.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 18/38] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Wed, 16 Dec 2020 11:26:34 -0500
Message-Id: <e3b568d40eae74858fe05b63fb6f281d1cf84673.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

create_reloc_root will return errors in the future, and __add_reloc_root
can return -ENOMEM or -EEXIST, so handle these errors properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 410e779af1ed..126655b199df 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -858,9 +858,14 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
 	if (clear_rsv)
 		trans->block_rsv = rsv;
+	if (IS_ERR(reloc_root))
+		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
-- 
2.26.2


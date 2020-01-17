Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133271412E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAQV0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41339 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so22887521qtk.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b2Rhd/xiW6guBCO0svVDPB2riGJU48lMSVrOtNfEDqU=;
        b=jvUbo7iYBOclFWkn0MC2XGKIQUaHmerAVYkqTOsI0QVaL8Sqfw0iK+69vUDqVubjL3
         xetHlxiSL+JDFazW963XGeB3qWTmBTp1Q3hK6xC+GQoArvm23stwdoJfafJ3aPGADQEC
         bvvM+Azf8frL6hmnEqABWI0f+KX6P+zC4qcM+FjCOcI6YdAohKtDqPqkp5HtZs/6yXrn
         m5G/b8yX+Fw8/caED0MrPZqfVTk7Zux9XyAGejZhk188fKpdz+W/+er6tGZkCQ79MaW8
         yTEbQMTx5ayku3i0HN/89vd9A/gUrmmk/OTGD55XRbslDhrLmM2ywZhw+VYwAcSRqhA8
         SFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2Rhd/xiW6guBCO0svVDPB2riGJU48lMSVrOtNfEDqU=;
        b=WNOhEol0Pt0rx/J1tEHt768X/ga4XdOVB6UXUEAIV96YgyOVAPmweUONrnrpfEvL3P
         Oo9U8ajhhe6ZHa+M/KBQADgAX3rrmWaobQ9IBmZ+pk/BUDf5Oh7ZFf11L8HpXPGJg/Lu
         pqYp1oJC8WzDUoDJcaZ/52xWny+MNXUwdMGGLD1kp/S1980utaECYPnD1o9WfiZk0jZI
         zkCGOLtasVt7wM0YjX8a4zdtfZc7Rni6ZhUZciK3nkzueepAOipHr39QBQ9y62q8qaBy
         vUXsRGo08iCW43bJoswpkj8ZIXY3KmYmPVsQYMBrARVoic7kUrKuUv+vDGA7rh/h+ljm
         Anyw==
X-Gm-Message-State: APjAAAXf5tdiKu8FybxoIhROSRs0JxM8Zr3qgP1I+P/E2vC83OgKAkpi
        xKT93EVYFseB3UsClf6L4eXk1M6w92FsTw==
X-Google-Smtp-Source: APXvYqzx3+5cb841eEsqavjZT0vfBJklEy4mGH8akEfqCM91gobzBd5OMIZWeKu6XvEAZYwdsMVo/A==
X-Received: by 2002:ac8:3847:: with SMTP id r7mr9747737qtb.381.1579296408293;
        Fri, 17 Jan 2020 13:26:48 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r10sm12151874qkm.23.2020.01.17.13.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/43] btrfs: hold a ref on the root in record_reloc_root_in_trans
Date:   Fri, 17 Jan 2020 16:25:43 -0500
Message-Id: <20200117212602.6737-25-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are recording this root in the transaction, so we need to hold a ref
on it until we do that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 79430a4245b5..9b61fdc89af7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2604,15 +2604,20 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = reloc_root->fs_info;
 	struct btrfs_root *root;
+	int ret;
 
 	if (reloc_root->last_trans == trans->transid)
 		return 0;
 
 	root = read_fs_root(fs_info, reloc_root->root_key.offset);
+	if (!btrfs_grab_fs_root(root))
+		BUG();
 	BUG_ON(IS_ERR(root));
 	BUG_ON(root->reloc_root != reloc_root);
+	ret = btrfs_record_root_in_trans(trans, root);
+	btrfs_put_fs_root(root);
 
-	return btrfs_record_root_in_trans(trans, root);
+	return ret;
 }
 
 static noinline_for_stack
-- 
2.24.1


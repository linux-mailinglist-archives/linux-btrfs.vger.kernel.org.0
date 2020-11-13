Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2231E2B2030
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKMQXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQXz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:55 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DAEC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:55 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so9307943qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CjNldZhFQRqTkPlUoR3jvRFvFT28PpJv9PTtjH7S0Wo=;
        b=Kk/EqRLv4T+XoqWUoFlSA9Ak7Mmgg/cvoquWl68HxoF6vYtrNSO0XK/LIvTFKpW8Dr
         HbAAEN/HoHf29V4lUwKihW/ozpfMDo18ttN5aLbfwm7cLfBKUstSgwI7HRTNJUt5E/Qh
         g8bvrZFeXoxqUQ3dVyQyIj8gX7lriKxgj6WW/evtcIlqXXoL8DO3OywkyFFuHtUhdyth
         9D/Ogz40xIE21OSwTJucq/itc+Sk2EIS35HUIeG/zd/e6K0RUeUsP5yM+Fk1DDRWvK7t
         LhL4yxxQHXuLP/2yjWnxAu9/1ZbBB10fO37azs7rFQ64xyE1/ZTOc+K/4pBFOMyqPW5z
         hGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjNldZhFQRqTkPlUoR3jvRFvFT28PpJv9PTtjH7S0Wo=;
        b=adS2HhJrTSi5dON+v2nJ7D1KU8fQ1PPazEOUrW8zKpz+1T+ZWzfLHA3fIzW+tYkQti
         lbivOxAK3aluIsBGdJuJ9kTfMAgZNCg44A1lsMMCD1rLZ6g063CoOng7NUgF0Cx0OizC
         EBiFe1C6b+B2755R3+S9lWx920w+0Sq72aCeKiXKn9zBiN6ikvtjUG5eoyt0YraTQG3g
         5EwNvHoil/Dw9KJDmz1P6jr58ZSEnTTKgwD3v9FJWao+jjTpA4kWsRO36QWD0Mh1Pqw3
         BNbONK5vsbUgo//uXeb62wiYH25BaF0TaMxef4o9nqaSKLbqaxCl+7XX1p0c0FZdi5A+
         t9HA==
X-Gm-Message-State: AOAM533jeuU/fDeE3tnom8LxzIlFNQm3ub0k2xEH7+P1felb2SPedLy2
        pW78oaQCRa6YCtdKXzm7nUkCxu454NEPQw==
X-Google-Smtp-Source: ABdhPJy7fWuglOz9CylpAWrwDCEOfRIxhewmy1sTzwJO2p6fnYSY6LyzQHEwTHwVVjjfmjvNu+hosQ==
X-Received: by 2002:a37:9b01:: with SMTP id d1mr2601513qke.89.1605284629263;
        Fri, 13 Nov 2020 08:23:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c203sm2861290qkg.60.2020.11.13.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/42] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Fri, 13 Nov 2020 11:22:58 -0500
Message-Id: <283c28668c2fa7362e389a3d3f419f91c4dca645.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
index 78bed3c4d635..5a470d3d91a4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2000,6 +2000,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2037,11 +2038,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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


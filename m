Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9917F2B1001
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKLVTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgKLVTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:55 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFCBC0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:42 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id z17so3547572qvy.11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ftm+3BhnS7yeXAWmtayxN81X3ODxQXtA9MVvsDY+0EY=;
        b=yVX1NMFDEguzT093vv3/Di4TgnYC47vxLffp3LqVCiGtyqvnaip8BLvdAntzSo+ru9
         Z1scOb8AZ5/kAHE1TPKzd3Rk1wtDZq1fpohIVg5iqfH7iDgjtxe43AvsWJ+sJ2O5rCfG
         NDGKRuEplPa14JXu+Kvb0B/nNdFwfGoRBoYq4xy2HRiRFdwwG8QwQd51M+tUPlY4B3OL
         LJg2A40v8DdBfqGB6Z+P82H5CJTprpWvtk7XJLN/VCQtpde8UjsZUaSeCjH/OdykzqUo
         XFbeaQT6E59diNzBTNMKYgo1AfoOuX9hL4yqsC2tkwZoRjdPbzTwoDXNe/OwVjHYDMqv
         8OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ftm+3BhnS7yeXAWmtayxN81X3ODxQXtA9MVvsDY+0EY=;
        b=T+ec28hjl86myjGqUDvVI3hYjfSp5oYNQwPDQixmpfHr6LrRwddMg3IyhZg3csYIFm
         pLWsmpZFJB/YEdTJXZzKfurXzAQ2jwkk7sqKeB50ERB4QWcnIcxSOAN0ZSNpj/8LCIFk
         20rivgkl3NbOxa7LhagmenX58H0Z/Y2SIXR/wlR36zAELnPRsepwvSFbXt3Org+ZnhEx
         o8OGBYP4GGQvelHHxz4CwgCOAKgI4B/5dEqb0SP06yyWVTY0SOd1xh5a6mqdT/42zCkj
         Hl3E+ZqmtkB34zRNNL8oh5ahPaKcRvFh+HQuF8UDEvThu0+/YAQNjsxkHymhz6Sn5PEy
         oEYA==
X-Gm-Message-State: AOAM53352aqTWdoUUu8ZWEa+P6WvhxjT0NmYuwpD703dUOa1xXoys+Vj
        O8UgU8zMng0Hy4IZ1zyWmhu6sVyXHtMePA==
X-Google-Smtp-Source: ABdhPJz4VKqyq0YZECX6ybLPpeBtH0OrJ4PVvDTDEq0V2BOW/uBVSgRzOo1cDa6TmZQGdiIrjE7PPQ==
X-Received: by 2002:a05:6214:32f:: with SMTP id j15mr1453232qvu.35.1605215981385;
        Thu, 12 Nov 2020 13:19:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g19sm4279576qkl.86.2020.11.12.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/42] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Thu, 12 Nov 2020 16:18:42 -0500
Message-Id: <a7f8d99bd34705882238a54fe7097311ae1a7028.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in relocate_tree_block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4d445cbc8d69..4d6f898025e5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2607,7 +2607,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 				ret = -EUCLEAN;
 				goto out;
 			}
-			btrfs_record_root_in_trans(trans, root);
+			ret = btrfs_record_root_in_trans(trans, root);
+			if (ret)
+				goto out;
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2


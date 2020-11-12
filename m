Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE72B1019
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKLVUn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgKLVUm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:42 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CFC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:41 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so5231209qts.5
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N1MUME/i85DBTUsc1CvyxW4w/u32sgExQZdYRoLDdHU=;
        b=LAZGydo5BpG7Wh7XlgFrrCmx3yCLH8phwrZDgW32YnkmSBgW4CEUrcsbLfLdiSJhs3
         h+5E7Op8T3fabh+5Rn+LdtmCnriJ7TkBU5ZoXjhy6tYTSwxP00dMnPeoxHfojj8FQkRl
         00+NyA8Rlm5OnSqdsL/y4u4TJANNKAVO7iQCrYREzHogxwUB1BZ6b4D/YMHwDFAhIGY2
         uvYGjWyMfUOZGD8I28WU1N32U/2ZJWmJzbTrK2tcs7wi2YPscP190YOGbYApvv86WCon
         CYXd6GpsW/pclNsHxRUSX9CPOr7v7jBq/wtEvx8U4B0IZqrlazycz3FuWGT8r9ouZORc
         1hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1MUME/i85DBTUsc1CvyxW4w/u32sgExQZdYRoLDdHU=;
        b=j0+BoGZwDuQxjhxQabGaXzMPi1pqP+H30WFFICi/e7Toe0N5DpnIEclSRVC5avq6XR
         VlypeHA2ihfuoXASor4oIFQ5QfPF7W2GP00lGbSWOo190MTpnT4AzXP5E3joX3w4MfLf
         lOJL9Ij/aKWzrx+Dyl9KrHkS/Ed/5Ft6v5jldKR7rwYdArvcV2A4jTRyvilwKt80EODI
         4yP1KMf8FbbiyIDBJWSt4JcjMx17FXKui+8pfdAnpQ6GGq4Zk06wMK4rTd8Hf5DKRQZo
         uANM7IFCy/7Gp7jj3NfMeb3QFWphuvvrY9wQo6NiwiTTP9ZcCS+K1sFNZbIubVA4M5kS
         evUw==
X-Gm-Message-State: AOAM531bny8Bim79CyYQKJUMS2JXFQ9fR3LB06XrSB6v0qa/K+mMq38S
        R0gj4URHIgz4ALGf7sKVI5G+YhnpsNJWsA==
X-Google-Smtp-Source: ABdhPJxSFysjt0AioJ8rWQ9ksgge4uMn+EyX0eEQP4nfrKBhIYiA8lD/sVGhT1X9ioUHIRdDdeX63w==
X-Received: by 2002:ac8:41d4:: with SMTP id o20mr1138192qtm.313.1605216040548;
        Thu, 12 Nov 2020 13:20:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h4sm5959146qkh.93.2020.11.12.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 41/42] btrfs: do proper error handling in merge_reloc_roots
Date:   Thu, 12 Nov 2020 16:19:08 -0500
Message-Id: <2158ea91a49c1c8c783a739543c754134fc81fb4.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
This honestly should never fail, as at this point we have a solid
coordination of fs root to reloc root, and these roots will all be in
memory.  But in the name of killing BUG_ON()'s remove this one and
handle the error properly.  Change the remaining BUG_ON() to an
ASSERT().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4648675980b9..ef7430eaa119 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1980,9 +1980,18 @@ void merge_reloc_roots(struct reloc_control *rc)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
+		if (IS_ERR(root)) {
+			/*
+			 * This likely won't happen, since we would have failed
+			 * at a higher level.  However for correctness sake
+			 * handle the error anyway.
+			 */
+			ret = PTR_ERR(root);
+			goto out;
+		}
+
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			ASSERT(root->reloc_root == reloc_root);
 			ret = merge_reloc_root(rc, root);
 			btrfs_put_root(root);
 			if (ret) {
-- 
2.26.2


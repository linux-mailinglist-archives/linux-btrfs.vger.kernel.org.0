Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9795E2DC426
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgLPQ2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgLPQ2T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:19 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7312AC061285
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:07 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a13so11593956qvv.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ughAcqu5UTXiwMw2asTgzY7G+SQWjtfjcNc/+0aEZU4=;
        b=moK4LA6V2ybTNgA5rkCvUBtERVPLtB6nu77Y55Re1j+8Fe9vLXI80PBt55NVoJr0xp
         H3ovjC8YiUoFvklS4hodLdgmoTS8nDnG8DjDfqIzDYUW+iTZsVdpeBBRGravLwz8T+sH
         /DmfMbXvlAhP4jBFafKS8rm7xM5PAzSzgrqtIsObLsw0XUx2JBAYdpfSJwjDSwtEi0MT
         jMDWEST650gn3+OkIvYEGUDJbpVdI8JLp+IYTqztJWe2Zn4q20I0SgHCXxgmd0kJhwoy
         VeT3E+uEmkphZJMPFAx/CRXZMDQTNOCZWbclRzRh1jZQPq52t0VpJyhgx13fbud5xqk3
         lkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ughAcqu5UTXiwMw2asTgzY7G+SQWjtfjcNc/+0aEZU4=;
        b=maHOqzQIjzrjPGmKA19kXKefLj+0MxCwgbsNsvzrutvdKiV5cX206kiPtRHrEGsxIT
         zW0+CjTg72ixY4kKVl0QALGWaqxNxPD+sBoGftGYT3RVYMZqroXKMBL3hLvg4zT+uDIV
         8tJ8wh+V2/yCTpZnbuch4ZfeJsHifmSSdHLSQh6AHi5uvxh+wis22ipjNqgxOIBRVEfU
         3/HQcbICQzJMAAcAOob5GnxiNXf+Wt46uPC/qUeBrqZAmBK6gOOnIf9ACY2onigD40lZ
         V7VlYZAcmWwc8gYdnIaacIaNcSvk9P+xVgct0Dp6y0XwWXw5vhudoWUkXmRbvKtfJSyp
         xhqw==
X-Gm-Message-State: AOAM530wPP7OdMOCzVthiIaUITRJcDIObdfh5lJ9bC9JkVEmCaAr0FO4
        5TrUSgRz8V2robr3jRAMGRxKbuOkQQH0kpO8
X-Google-Smtp-Source: ABdhPJzcyW0JOvz+UHpOW5ycWqFJpnuY9lea6LHo3+WJZzuqSIqv0bdGRqXrqnlG7UJm9dRJJM9UUg==
X-Received: by 2002:ad4:42a5:: with SMTP id e5mr23875120qvr.37.1608136026358;
        Wed, 16 Dec 2020 08:27:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q27sm1344626qkj.131.2020.12.16.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 06/38] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Wed, 16 Dec 2020 11:26:22 -0500
Message-Id: <0ce7243af178dae7f029f5a2513a230bf8859328.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally speaking this shouldn't ever fail, the corresponding fs root
for the reloc root will already be in memory, so we won't get -ENOMEM
here.

However if there is no corresponding root for the reloc root then we
could get -ENOMEM when we try to allocate it or we could get -ENOENT
when we look it up and see that it doesn't exist.

Convert these BUG_ON()'s into ASSERT()'s + proper error handling for the
case of corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1c36b10fdd02..0eea27d9e3cf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1971,8 +1971,27 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
-	BUG_ON(IS_ERR(root));
-	BUG_ON(root->reloc_root != reloc_root);
+
+	/*
+	 * This should succeed, since we can't have a reloc root without having
+	 * already looked up the actual root and created the reloc root for this
+	 * root.
+	 *
+	 * However if there's some sort of corruption where we have a ref to a
+	 * reloc root without a corresponding root this could return -ENOENT.
+	 */
+	if (IS_ERR(root)) {
+		ASSERT(0);
+		return PTR_ERR(root);
+	}
+	if (root->reloc_root != reloc_root) {
+		ASSERT(0);
+		btrfs_err(fs_info,
+			  "root %llu has two reloc roots associated with it",
+			  reloc_root->root_key.offset);
+		btrfs_put_root(root);
+		return -EUCLEAN;
+	}
 	ret = btrfs_record_root_in_trans(trans, root);
 	btrfs_put_root(root);
 
-- 
2.26.2


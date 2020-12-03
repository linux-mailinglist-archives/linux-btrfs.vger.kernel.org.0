Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806682CDD86
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502059AbgLCSZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502050AbgLCSZR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:17 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3BC09425D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:22 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id x13so1429557qvk.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGsHCr9+jjzby7vaZe+QNyu0SX+RrI2Eyp5IdEhxAGw=;
        b=ULaMGP0dscMX4j9VBW/y3YksTjNiv6MqD+9N9H2yxjF+Qewx3B88jgyfFWt3zYp3Yt
         gaKMz9DLkSpvHI2tkVG2Dfd+sdafQZI0TwpNAGeXUE+/iQ4Nnb8l549byzUbz40cJy3V
         /HRvooyQMw4tggx+vNFKWcqYtpb7Nnp+T0PuoT7cfFSpKj5OhdHoBdHfn8NqialYnW69
         uHFcjXKEOmD6W1bp9g75zj3Lki8zC5TZ2ashLff4Y42Cz/6AvNbihR69oPMOwyxYx0yi
         yLw6JNMADh/0oSxX83khU64w1sSxNLcqzibggdqYEIwEMY9ls4/T2Z1/2LSpK9hixrVK
         +Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGsHCr9+jjzby7vaZe+QNyu0SX+RrI2Eyp5IdEhxAGw=;
        b=gcASyDAO14AqT4XJAWS/Zr16T6gj1wx/Y6wkAmyKiR3pvUPeIDj+MT5c4zSu2jXUB4
         +Nbo+Z5KMf9rZZIayYi/QpxX+XTMGvujPGk9NbreL5msVs35+IklM3DzZyUwplH4oddM
         aBuh2UIvztjueqZqgC1yR2whKD3UnqgxogW9gi7JLKmpo0IG68TXvuwv3stnjcU0clKr
         QR8LaUtk/IFhsoROkF4Ayj11pcYq+GZpX75Ea3h0KCJplbBlUr5m/ZRjLiljj2vaa6JA
         RKGBIwMI8IezQxvzNnROXQy/82VgmWvKlRgBF2AGOff/PXLVOJVF1WH+TWpTD+L7zr1x
         +p4w==
X-Gm-Message-State: AOAM531i0Mr324Qf34XlmsccNCVlU2mnG3/151IrdjSP0nlxOnY8Azr7
        RfhXHuKTWRKxoLZiGINo7bxnzPUEK203SCAM
X-Google-Smtp-Source: ABdhPJwAsPYHwjgVuKK9VeFdxnUcaV9O74Db1PUaNP+ighekBAO0H8ZBit4JrM7vLK1IDs0oTm//Zw==
X-Received: by 2002:ad4:5424:: with SMTP id g4mr187409qvt.56.1607019861235;
        Thu, 03 Dec 2020 10:24:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u4sm1855687qtv.49.2020.12.03.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 46/53] btrfs: cleanup error handling in prepare_to_merge
Date:   Thu,  3 Dec 2020 13:22:52 -0500
Message-Id: <bc2179ef563e9ea6f2bf61c041c1fe229304887a.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This probably can't happen even with a corrupt file system, because we
would have failed much earlier on than here.  However there's no reason
we can't just check and bail out as appropriate, so do that and convert
the correctness BUG_ON() to an ASSERT().

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a2900dc71c72..02760544cba1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1870,8 +1870,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 				false);
-		BUG_ON(IS_ERR(root));
-		BUG_ON(root->reloc_root != reloc_root);
+		if (IS_ERR(root)) {
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_abort_transaction(trans, (int)PTR_ERR(root));
+			if (!err)
+				err = PTR_ERR(root);
+			break;
+		}
+		ASSERT(root->reloc_root == reloc_root);
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
-- 
2.26.2


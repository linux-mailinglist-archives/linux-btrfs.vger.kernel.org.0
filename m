Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1900B2A8282
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgKEPph (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731411AbgKEPpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:35 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA84C0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:35 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so1354322qtb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3eG4uDHAYcP4W1Tfmh2jE2b9q5s4yky077zK1dTzIyo=;
        b=DUhZcTCRhDU6+V+E9XM0jDwm8MrjVPOUKopuqXqLM7J7MnYqPzekc3LUi4+Orh63Lc
         7a1hCC64JOPYDQcdgXZqGRjboBALxeW43aDbIYd4stTLZyTD0WwpMyKPfLnd2eSkrsS1
         5hnD4n4dRFooclBKSlKY1/AmHb4PVYqUlpaIXh7vbVVPftuMqP8sEWEJts6Zn9blq2qc
         6OIDr5LmyRJgrIxA1nDObcKtbabu3GiAFrzECBvSAPg+YVFjdInTJZDB/6+/CcSdSKdt
         YT7CCFoku9eDk5O7ER9J0C+wwT1sT1VjuLulI/VQSaAMafaj8o4acblJr0dyYtmfVNBI
         ih0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eG4uDHAYcP4W1Tfmh2jE2b9q5s4yky077zK1dTzIyo=;
        b=lX8h2WpJHu3wOwpYaTIlyUbS0OAqCIJios6Sv/x8ItkgmOPDMDgF1rNVnaNJQrr0KB
         72Dkp8sOBxQX1yg3sjv6mj1f8B6IfQB+uyvf5JZqA4z4Wz0SjxWc7sR1z50aI/x8zfQ0
         5tV/4Nt8PVplocJxby0QM8Y7/DJNkUP8/69EpdmnZVuK0jRyNp0c75x/CQdCnK49gFgC
         U9zTPbR4V5qlN5iqhf2hjHXhDKkEfSUTkCa6d4ImRBRslcE9vIFttHv/AaaLFxAqyGJR
         YxBv3XIqrzbOTfvnVgEGyXI7TO5DCUTyPZ3de9M4hRMGyuQj7+qlpzAazp7PkkPzesFV
         Eb2g==
X-Gm-Message-State: AOAM5331I5SF6GxU9p9SNy/wC2V3YF2owqJg3XeIz3NIiilTikvRKWn7
        x+c2G7j0q/ZC5uYEtTjq+bQEi40PBQg2E3fn
X-Google-Smtp-Source: ABdhPJwj2m15O5ItddOJUtpJM6ltqt6gr2OUPvISfryLbowzo8Lb0BTM+banFNGBhoBTfvj/BiZ2Kg==
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr2333007qtx.83.1604591134451;
        Thu, 05 Nov 2020 07:45:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f61sm1075692qtb.75.2020.11.05.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/14] btrfs: use btrfs_read_node_slot in replace_path
Date:   Thu,  5 Nov 2020 10:45:13 -0500
Message-Id: <026ed684d026b3d792f1bab60bd3d63be28acd65.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open-coding btrfs_read_node_slot() here, replace with the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4d5cb593b674..465f5b4d3233 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1218,8 +1218,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 
 	parent = eb;
 	while (1) {
-		struct btrfs_key first_key;
-
 		level = btrfs_header_level(parent);
 		BUG_ON(level < lowest_level);
 
@@ -1235,7 +1233,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		old_bytenr = btrfs_node_blockptr(parent, slot);
 		blocksize = fs_info->nodesize;
 		old_ptr_gen = btrfs_node_ptr_generation(parent, slot);
-		btrfs_node_key_to_cpu(parent, &first_key, slot);
 
 		if (level <= max_level) {
 			eb = path->nodes[level];
@@ -1260,15 +1257,10 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				break;
 			}
 
-			eb = read_tree_block(fs_info, old_bytenr, old_ptr_gen,
-					     level - 1, &first_key);
+			eb = btrfs_read_node_slot(parent, slot);
 			if (IS_ERR(eb)) {
 				ret = PTR_ERR(eb);
 				break;
-			} else if (!extent_buffer_uptodate(eb)) {
-				ret = -EIO;
-				free_extent_buffer(eb);
-				break;
 			}
 			btrfs_tree_lock(eb);
 			if (cow) {
-- 
2.26.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008C92A8284
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgKEPpk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbgKEPpj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:39 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B0C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:39 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so1370555qts.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qCMD/N3lOM1qKhBono94nk4qYYiB2Y7X0M5l0N4E2jc=;
        b=FzkFS6hlVuXh7e6DPj+JBxkHTrTSvW5bOKRpOKyBLfA4+2eQ60T6W07cbtq81jnBLC
         xN+JNaiBNNS5N/Nx+TtNTQzdihnCh1Ph7jANlBX+ruRPFRmWoQg1QoL4tnZfsaXZgAjB
         oLW0P/V+Eh6wxiGTp0b5o6V2Iqvc/92o7C4ke/sX6vhdCnws3cJOxYumvP7ONsPy2h62
         /bTFGF+jLbrdVKiIj43c3aNfvC4L+qni736MVl1kZRunb5kq2l+Njfatj4/wUEQWLGwH
         /6ZOYj+jQ8DisGBwJz0ek3SykIKx9rnhoMf9jO36HlavkD72Gir2AAIE0NhYKUgicP3z
         ekWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCMD/N3lOM1qKhBono94nk4qYYiB2Y7X0M5l0N4E2jc=;
        b=VkXpHYq6fr+kIP9X3v3aUXJhXWUqZlQzOPqYhAcn5RH8uByjZuS/dTceEofHXhAFiE
         l/W/nMymhfsAaeUPpGrSL00wJ25Rn3tnr7jZpHA+gXMl1knXrL4BVUW9X38ldRoYKzp4
         fmefjd4rPS6ttkQLsIj6aNAZG4IVlTnoNiZ6c89m6atjTX5eI7y/y6qYtmKBc+xzOGsa
         +HV998upPNoHRrX8rDR/kD8S1TtzoCt6wbt+RG3/WwB2XYCYdd4Cbnlg6/mPJ67NBMDn
         z3I1zyaIADkhTe0ewEYckdbmCbIvgF9G3hJRBo5DwPIGsXEDWWMI+/PXHGrBC3jDkb9H
         Y4Qw==
X-Gm-Message-State: AOAM532/f9BY4ro/m4GqJO93pAlSqPDg+DVBpIBH8qHsAqX8wZb0Ewin
        yJwSn8cmv6KQuMoaA+I+XNuuD5KYCfmokFM7
X-Google-Smtp-Source: ABdhPJz4GImDH49lrpXYdeRKRF0ls/07frSE2IriAEO2p0P7cB/vM1oRJLK605CtS1PwMM8lXvW6CA==
X-Received: by 2002:ac8:7207:: with SMTP id a7mr2574103qtp.40.1604591138457;
        Thu, 05 Nov 2020 07:45:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x22sm1227722qki.104.2020.11.05.07.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/14] btrfs: use btrfs_read_node_slot in qgroup_trace_extent_swap
Date:   Thu,  5 Nov 2020 10:45:15 -0500
Message-Id: <96eb2106d6b5518d4c5db34aec50d12860d702e7.1604591048.git.josef@toxicpanda.com>
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
 fs/btrfs/qgroup.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 717b1a6e13a6..21e42d8ec78e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1892,27 +1892,16 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 		struct btrfs_key dst_key;
 
 		if (src_path->nodes[cur_level] == NULL) {
-			struct btrfs_key first_key;
 			struct extent_buffer *eb;
 			int parent_slot;
-			u64 child_gen;
-			u64 child_bytenr;
 
 			eb = src_path->nodes[cur_level + 1];
 			parent_slot = src_path->slots[cur_level + 1];
-			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
-			child_gen = btrfs_node_ptr_generation(eb, parent_slot);
-			btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
 
-			eb = read_tree_block(fs_info, child_bytenr, child_gen,
-					     cur_level, &first_key);
+			eb = btrfs_read_node_slot(eb, parent_slot);
 			if (IS_ERR(eb)) {
 				ret = PTR_ERR(eb);
 				goto out;
-			} else if (!extent_buffer_uptodate(eb)) {
-				free_extent_buffer(eb);
-				ret = -EIO;
-				goto out;
 			}
 
 			src_path->nodes[cur_level] = eb;
-- 
2.26.2


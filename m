Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916BF2B203D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgKMQYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgKMQYI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:08 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5AC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:08 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ek7so4841848qvb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KrLKCDbazuiI3OqW3fG1L+jod3a2w4if1xz5rUc/xAk=;
        b=h1ijkLmmZ0zPIKmxbuDAbHACqWqIJPVc4c4hRgUJf5Z2CaNu/tOU8qBbNKRc7nEE+E
         8/Rl7P8ZP+Ev7DvuHMj6o3G+/ZIfCMbDZsPHwg8SVe5/IdHhLYKRsxg5aIDxwi0gP8NK
         9iV4Qwk45o4jH404Ex69IiXea5tS17fsavOkGRXOzNphNQxLJ023asWgPZ2UXiNWPQ0a
         8rdqlqr5OLtnafqdIGpLmEm9MhGf1b86WQXbVGzFM5PoDCvVAB+AEMVYl4McpzFE4hda
         soggAk71lwkMhmbyr1uemDY5kx120eNV5GKy4lNWNnufwgEMrNUO8OYVeBFzyp3VG5Zt
         1R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KrLKCDbazuiI3OqW3fG1L+jod3a2w4if1xz5rUc/xAk=;
        b=odLhIQ2wxxO5bfA89RDlh8RuPwAzYWIHEyAk8FiTNpuYhCtB1wWCLSa8u3R8kPi1Sc
         9oJRd/1tYIhrYruBU8Oc4kxjywubVJ1F8PXgvaDG7D8WUMlyMV+NLgwdviCg5JI2q4eL
         8Zu2t8YGcaLotj/XWWZZdNMyOStDLDV/w5EwkBxq0CZ84wr0x7mRb6vjTH3n0YdbKi1v
         Na8QgfKANFmv8152n1efRGFQ1tbKpoBEQmbPWIWoRy1ysjxLC/ZXmk3TEQ99nEUS0pTi
         8+IEWTRyRTijjE+7iep5sKeBFxhw6FbXtMG9Mc1+wPJc/QY2xyVSymJtQhAf6rT65N0e
         hdDg==
X-Gm-Message-State: AOAM532uA+EFiFANz2u6CfEP5bIPfzm4TQDVMsqvhU6egeY/PJ81+R2j
        qYnFIaODfV9G6B4+7S8Ytmo8Oz3kbtd6Fw==
X-Google-Smtp-Source: ABdhPJxGTxkZPHQ38+hlADTM6rRWQMq0ebBRdyaMMevqfcbdaam68RysY8VPIqqfrFkHSf9NbdADKw==
X-Received: by 2002:a0c:d414:: with SMTP id t20mr3258548qvh.34.1605284642776;
        Fri, 13 Nov 2020 08:24:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p187sm6743221qkf.70.2020.11.13.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 15/42] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Fri, 13 Nov 2020 11:23:05 -0500
Message-Id: <227a3569a6ac063cc84ac13f54723a920b4543f0.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
index 4397a8a448f4..6f7bbbd76102 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2578,7 +2578,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
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


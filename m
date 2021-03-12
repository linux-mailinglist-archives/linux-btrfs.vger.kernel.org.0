Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7D339840
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhCLU0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhCLUZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:56 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2FEC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id f124so25702661qkj.5
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmEVrh7Q4lljkARgjKRDJA0uUhmTBg9BsuVkxoSbppA=;
        b=ExLvkt2Np2wUfBdBOJpmx2y077drSNwLMdOkLPvtOlrp7JRyZSnZMjmygpSrFQ0m9O
         oDy3qkuIYQUo4/XXndYgua2So7zROUc0blJzyrlt1fh+sDgCACxNkO+U5Tqxo90ZYZZf
         YQzbpZJ/UOUNhwuP7bCj/Uj35bExa5RPQVmSCPw9+ILWQdNaF4DUYuh/Du/sVE5YN/eW
         zl9GOZl4TdO0xZ/CuCt8ip/8YxbgLCVullxCwsIDlKqEE26JRMNc4EYmOYT/faNOkhhM
         Yx2OgoZqKrohMPpy6S+Jx8+YF5mUEWAnzRYlp0nCWA5C8O/DbJbMHqmYnnaFPwPSfhtK
         A2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmEVrh7Q4lljkARgjKRDJA0uUhmTBg9BsuVkxoSbppA=;
        b=DLqqr1kkbirh1Rmap3Bk6oUviSJ4R/1P+gUPj13OIhtZMM6+L22AihqE7x97TKpx9S
         aqESq1rZaECeDe8sjqVzrm0ygr/mg+atbHoaGOgW0S33EkL7uqluxsrojERIezdKmSHn
         k9gmtiA0baIVpEx5CX6o4pngol7XDmwEMb0LvSvomh4rUH5Coosaw9XC9TcBUREOeIO7
         VjjJAMyuap915sn14KYCYzOKfdrcS8CwMiXFPvhK/TigWtfg0INDBIzTBqh8l1kTR9x2
         6EXQzQWkyBpGoMTzEKE6emnI2QVfUiCY7Hbqw3CykAyZNggOYbVgl03ynSErbKx7oXAb
         6V3Q==
X-Gm-Message-State: AOAM5308AhiozuTK4WRuW5STPZ/vX6RtddcBiYogefFu8bkZkKPAa0RL
        nSIhbQ1QMS6c7pvfXuYoIHbMsjg11levSbnT
X-Google-Smtp-Source: ABdhPJx/rY3xe2tAxL5ueCKU7Ai7H84pWaJJfotyWWtcCQ8Wad418tOVHcBiVelbR2zhnk274Q32YA==
X-Received: by 2002:a05:620a:21ce:: with SMTP id h14mr14099023qka.22.1615580754758;
        Fri, 12 Mar 2021 12:25:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d84sm5243995qke.53.2021.03.12.12.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 12/39] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Fri, 12 Mar 2021 15:25:07 -0500
Message-Id: <cd556fb1e5062f9981a0c294c2a5abd3ff811dd4.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in relocate_tree_block.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 28d49b14a23a..7ca7ab3d40e2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2548,7 +2548,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
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


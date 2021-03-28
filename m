Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00C34BAB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhC1EWH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhC1EVs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFAAC061762;
        Sat, 27 Mar 2021 21:21:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c3so9358845qkc.5;
        Sat, 27 Mar 2021 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjFxH6W+ZybR4edl89mWPAzbMOMm8KxZjCSoxISwkqA=;
        b=n58o3xJRy5NlEskE0I0AAgAGGJaHEddLIDA5uQED8QBpP66zI4Zy6SIDcGHHjQTkXT
         //PHxHkrZzT4/lGvhyBpFiDV+NewJEcFvJw4Xy0VhDKbp89Bkmot4pWopbLMKeSP9z+r
         RKtKZDx5svfa4IyFQ364pSCaEfquj9qrhFGQ5a8kK8bOOTwRzW5+SnEGczrvvVZTiQV5
         JEbtE308N7B4B4wEopPnuATdKt4YwASXVDz/K8G9iL+/0FXf9NL1CntFzvCFoI3126vV
         AXpRHvB4sUR3RvDbFmm2dwq7kVdE6iXkvoZfcL4kX8CsHKdw3gbt1pgpdzgSGm9p5vYh
         /PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjFxH6W+ZybR4edl89mWPAzbMOMm8KxZjCSoxISwkqA=;
        b=kjEi0PGIkgLfprBY6GvRNazM77noPEm0qYnqTRC5WkTmwuFHtkZdoafgBtkimVO91J
         dqU31BbHGzB1ctpRqYiNQa19NkhhaONDEA1al4sA5sMIxQyvRfQuC3n1fq4u39cCJMM7
         unS3V/xut0MSoTFQS2KJP9qQNAi52JZJ5+5zW1yVXR+zPes4R6+SHom9a3CiIuSxHPNV
         YG6CAwATv9GMbLHAdk5XY04/et1/5FHrfIlrRZ2EXB/JQ3YH5y5Q8soEdL8nq0nptrck
         +U4UQZvZKYD+YWAMVVkD+BxUkxba9uPuUmgySOiKoLU0ehTFUvJkenNIsHrkt6UcXiuK
         1R1A==
X-Gm-Message-State: AOAM532ftk61G10y8jqGom4KICwDFdCaZ8N1LY1pLCMsaoOSPFDGweOy
        q1B+XB9j8owa5Tio1HqbVnI=
X-Google-Smtp-Source: ABdhPJxGCGwtg7as8hUzsWvdPBcJNuaQUPAdDV8ozRxDCqv/WKsmfNv42/2CimIJoq6qb/8mDTcUhA==
X-Received: by 2002:a05:620a:16b6:: with SMTP id s22mr19861116qkj.240.1616905307163;
        Sat, 27 Mar 2021 21:21:47 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] extent-tree.c: Fix a typo
Date:   Sun, 28 Mar 2021 09:48:33 +0530
Message-Id: <4fad841cb82c0daaaba4daf445a1c0b27f1285f5.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/Otheriwse/Otherwise/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 36a3c973fda1..d0532754af15 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1421,7 +1421,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
  *		    bytenr of the parent block. Since new extents are always
  *		    created with indirect references, this will only be the case
  *		    when relocating a shared extent. In that case, root_objectid
- *		    will be BTRFS_TREE_RELOC_OBJECTID. Otheriwse, parent must
+ *		    will be BTRFS_TREE_RELOC_OBJECTID. Otherwise, parent must
  *		    be 0
  *
  * @root_objectid:  The id of the root where this modification has originated,
--
2.26.2


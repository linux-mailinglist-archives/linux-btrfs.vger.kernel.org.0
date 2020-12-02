Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530622CC72C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbgLBTxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389802AbgLBTxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:23 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB23C0617A7
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:06 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id b9so1535312qtr.2
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z0Ugk0rFkbZ/xud4PafB395oaAw53VS/FKnPJZs/Gs8=;
        b=cbG8lm0YFTYd/WKJP0n5tZD7KAGUDsyRJqYcWgMA0EskbJ74ZYA3STrRET8zI/RCRC
         1fOYODzUfa1lHs1AaIVtfrD4EY8sxTt0EO9zhr9zLStn/50lWSm7zn78jW0KCB17iQ6G
         i80OXv/Jkaff2McgszCeUMQ7ZdKUYc8RyRseLuXAeDOAjNPrFhbecxDQH9oRAbfr75UH
         9sV9TUJgX/OwotAbkA67NBxUM8lm5LjO0/LunGsMhT5yDGr0tAEXEzlYBX3l4t/fBuKH
         ghQep8G2ifxe8k60iQYFh2gBVXo2PzzpLzIvNtmhY8F0FT7kJ0qrCqq7OUcAgvc/hOA5
         GiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0Ugk0rFkbZ/xud4PafB395oaAw53VS/FKnPJZs/Gs8=;
        b=B3kmtJw5pBfzPsqjJLqhB7zHDuE4WVwizd6r7W/fu75ems/IHpEPmHLiRedggPMKy5
         ELiqKruq6BQj0WabvefyCe3yjNgn+xuNhPffVSpucT68j4ZkSk/GVsCR/0trZXGgU/TP
         FUa1q0habQd8HSDRk6/SdQfbbem6q4jRJ8jQpdXhmbdp2cipP34Pti5xtDWry0cAwDsQ
         pMpGhRKNTcyh1GYkhsk1XHHtv+A4vcRL4I4btgBuIMEL8TfuINqD+BdvXlMLnRcT3wXO
         dDxDWEapDyAkLiQccZeKVhT6pZYMn6CsjOLe6FBfMecm+y+axi12PlWLHj/9akN1mhtS
         pwbg==
X-Gm-Message-State: AOAM533MuZ/m+uE2eovT5EoXpXMQgX77zhYz8Tc2fOV/ULX+I4dacg9b
        vDhMOT4Nh8RKQuEkkVBdr8Dtq9FWB1pSAQ==
X-Google-Smtp-Source: ABdhPJxcAFtySBiG2wgfXx+tgVag+dLJHCMshIqTAZlRagowWjQN9yMeOycjWNetpCo/R9gVEZs9lg==
X-Received: by 2002:aed:2ae2:: with SMTP id t89mr4295905qtd.82.1606938725002;
        Wed, 02 Dec 2020 11:52:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b3sm2601341qte.85.2020.12.02.11.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 28/54] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Wed,  2 Dec 2020 14:50:46 -0500
Message-Id: <102adf0f328cc4064a76e60e70274a3f7dcec8d3.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

create_reloc_root will return errors in the future, and __add_reloc_root
can return -ENOMEM or -EEXIST, so handle these errors properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7993a34a46ca..6d3a80d54b32 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -860,9 +860,14 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
 	if (clear_rsv)
 		trans->block_rsv = rsv;
+	if (IS_ERR(reloc_root))
+		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
-- 
2.26.2


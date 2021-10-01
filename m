Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42C841E766
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 08:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351833AbhJAGLw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhJAGLw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 02:11:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74396C06176A;
        Thu, 30 Sep 2021 23:10:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h15so12045859wrc.3;
        Thu, 30 Sep 2021 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOrU/OWpurogbsHaQKdurQl7O915KhTCNqdRsbs978c=;
        b=I5aGc2PX9U7U+Pyi40zTTpTJb0sVcgmJNJusK8umeGR33XVEZUlZ89zgps65gXEfIy
         tysAsv+Kp1ZFCE517JCd/AjbpUCb4T4/VeWpw7PW0/St+EW1rLqKPrUCXoU0tVf8SeKb
         c9wx+ovZa2Ht3SUFRojR+vELT+7fap/f5V3Xo1yBWBO1dqYKbUhuAuU2Vv2/+bCkn1YC
         6CfodvbM5qwm+gjPsh+OhzlfA6guHOHbcDpapdAq4lSETarzbs5d4CCWX5SEYpneVZUz
         XX2yeJ0w1p90nIBc2gMN3uDR+50zwWWypaTiNJPr6s6IHpMdq9ui+0O+HRz3ZditljJu
         RhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOrU/OWpurogbsHaQKdurQl7O915KhTCNqdRsbs978c=;
        b=HZcGlhZ203JzGGMisATEAzPb3LZwye8K37bTQ00gDvMxI9uDEsXRgPvSkYs87pmK1X
         NkVS27dJvFBfGKhJt3ctYsMCZMWlF6/WQSc++Rl+GlSH5mYYjf3/V6Oxl9ypKwI6aKFG
         OA3iyzxOP/K6vxCu/5HnAx3jS/UQ62qwJosUzO2gdUxt+Ahz8HJnJ9+CI2teBKun8ieV
         34haBvTckx+zOSjfveir92k+yu7a9Y9+aRhdiur7pmgw8+Q+b5djCMd9OsMbkKsELD6E
         URUCAPKPjoggBqAt/uMPtDjOuCNajFCXYETK2Os0bRiwSH/wXFbqSmdkeLuBngpXiZe5
         3dbw==
X-Gm-Message-State: AOAM533fXt7/ZK3O1aBg90hD1RDvK5d3lT4X+VNYwfMS7VnRUoTd89he
        Kr4v9CbdrQKjIPW5E3HcHaE=
X-Google-Smtp-Source: ABdhPJwMTxoMCzuoYeA8QMUmiRa4oMoBhwnU4Dxsdagc4MdB5ZtK4/5sLlv/nrP2ZNkOJt9CgGw1Bw==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr10068610wrs.26.1633068607066;
        Thu, 30 Sep 2021 23:10:07 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id v20sm4864253wra.73.2021.09.30.23.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:10:06 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: missing space before the open parenthesis '('
Date:   Fri,  1 Oct 2021 08:10:02 +0200
Message-Id: <20211001061002.94807-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/btrfs/ref-verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index d2062d5f71dd..51e88c5c2310 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -242,7 +242,7 @@ static void free_block_entry(struct block_entry *be)
 		kfree(re);
 	}
 
-	while((n = rb_first(&be->refs))) {
+	while ((n = rb_first(&be->refs))) {
 		ref = rb_entry(n, struct ref_entry, node);
 		rb_erase(&ref->node, &be->refs);
 		kfree(ref);
-- 
2.25.1


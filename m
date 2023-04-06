Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156A6D921A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjDFI4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjDFI4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 04:56:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC659526C;
        Thu,  6 Apr 2023 01:56:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so5421937wmb.3;
        Thu, 06 Apr 2023 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680771408; x=1683363408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9E2dyd2MRN0nHYGX7dY1twqBkJ/tIQJ5tURjUZDVpA=;
        b=TDVE/37XVvAOOyyWTbmhdv5xfaCPX4A6cgJ2a1rhA5GCh5uk5QLuD/fksVBxc8+kyY
         2D3Xa/bLB2Qkuv00RCCqzE/ElDq19NN+vhTeZwJqLaxmIkkWccupM9dGvsK+2dm/LnJA
         /eGrpcF88i3M28or22rCyU8P5eAniZmFhIQSHsW8+AjJie+OtiCycmLEiZRbevsWF6AG
         BelUF7rrQdX0UKfYr/FuoE3ro3y6NjyYKt4rVyCvCDBbFMPyAGIs9GVeX3w7bHS4Hxs2
         pme6GYbAeJOGr/aDUu2lB/Hr0o1DxgIXwoMBrFFle4xGBbrHQdgmha+Zl3RuhzxwnlU0
         WNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680771408; x=1683363408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9E2dyd2MRN0nHYGX7dY1twqBkJ/tIQJ5tURjUZDVpA=;
        b=WZnhLo4jWJ2iySIk4R2MsY+vPfeYxlRO5r1dtI5zwk2DvTqCtveJM+XeguMuYnm1ys
         CCv2pB7B+XOK6DzJyJZForFCdTbxoUpVbJDtnHMgYm5bwW8ovzhQgOYPdNESV9BbjNRU
         iKJrGkBX+6NJqAWlLQKHlEUDbg3jBlEC1lwfO0NPrCKnSxF0rext5KjXyKKpKPh1yRlf
         f6FjI5HttSiT8cQPMafQ8fFyWU0a13XaG7iVHoVvBlboaTAk1YygjiUWGXoKOVo5VcXf
         H0qOL5P+Byoegeo48Dyg+sFRTF+KEWeTP/qaBerKHEldGdlo9Xxo4Hmgh6Mke+tMY0NR
         VGNw==
X-Gm-Message-State: AAQBX9fDO1Fb/S5DAv8nVknPp5vUt7dAbwbHMmBqy10nO8o7FaiGYSWD
        WTODaiOnkYIKm47rCYfh3SE=
X-Google-Smtp-Source: AKy350YXTbK0QOqx+VBnKVE7BstxDFU/Ax3Ca5TCEFIMsErC+4QejmZG1STPVTA2HN28nUwiPUwhAg==
X-Received: by 2002:a05:600c:20f:b0:3da:2ba4:b97 with SMTP id 15-20020a05600c020f00b003da2ba40b97mr3742367wmi.19.1680771408281;
        Thu, 06 Apr 2023 01:56:48 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d5285000000b002cea8e3bd54sm1155155wrv.53.2023.04.06.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:56:47 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:56:44 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: scrub: use safer allocation function in
 init_scrub_stripe()
Message-ID: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's just always better to use kcalloc() instead of open coding the
size calculation.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ccb4f58ae307..6afb0abc83ce 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -254,7 +254,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 	if (!stripe->sectors)
 		goto error;
 
-	stripe->csums = kzalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits) *
+	stripe->csums = kcalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits),
 				fs_info->csum_size, GFP_KERNEL);
 	if (!stripe->csums)
 		goto error;
-- 
2.39.1


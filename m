Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6047001F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjELH4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbjELH41 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 03:56:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6CA1163F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 May 2023 00:56:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3078d1c8828so6574796f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 May 2023 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683878162; x=1686470162;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wv2tAL8Ez6kv78rrWWrD1FTRStJsvmj8R55tZCpMx/4=;
        b=AMozSnTC8jjWdCXKzCRKCaQQxOMweMppPhOHbjxUGWB0vu1xTSvD4w52k3RU0PbMAN
         5FOAamYI9hjGCV+rX6iSQFqivZdAE6VMO20MEYD81SgwbXq0yqBvej7eEZOevX/d19BG
         nwTsbgIyvUSWWp4HovtuISSWmQmJKg6LfwWgcz8f47cmIl/x8ISklPnfYljfnKPVxT4C
         tAKp2Y1cgn1QfwkmIs0Cs3GPsnipnCOW9Xn3NSNUd1G++fqPzDHdS8ok0ZM27GcYht/Y
         5xrckKSDgyKdDsQ0SMaSz88ZISVE6MLZqhfq6hofGubTr5FVSGiFju4h1KoJ3uHdSQsY
         3g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878162; x=1686470162;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv2tAL8Ez6kv78rrWWrD1FTRStJsvmj8R55tZCpMx/4=;
        b=goRrT1A98PMAlhHT7NNZwQWHWN7JrByWzxuSSzfXoPrsmDETLEE7u3BKqFoha/VW0y
         Ub1j4kT0nbY2X9rQhxdAQQxsB4UGGGVqZnnU9HjOo9ZES1CMVFOuvpBxLfthc0nqUB/4
         ouj2RUvP6zgTCjHJV4tfNXisVqkF1GmfeckV6Ykafutf+HNRv0QuVH2YqykmI+K19Ncp
         /NoXgPzU3o39B8KXJsFFk8T0q/9aYPXevBLllzej2tb388Kqu6BOtAagr3p0t9r6RGSV
         JuutyE0/LbvIGYSRSC0MPyp5V6nNuXepRRAMyWh9QNq4k7WXJLqfgJtPJZ0k2iJp5hXe
         8PPg==
X-Gm-Message-State: AC+VfDyoAMPNjiYcmgvXm7na1ry4CDJnNpFcTaBlyr7un7rZWMMiJgDs
        fvfhpuRebXyIYx/iWsG1ob8Xcw==
X-Google-Smtp-Source: ACHHUZ44UKPoJfTJF9BH28QANZj1Q952mMt4P6itnYokD050z7ZQD36O8UhW8Ofqdk5H+z8uGvXmvQ==
X-Received: by 2002:a5d:470b:0:b0:306:2ddb:47ab with SMTP id y11-20020a5d470b000000b003062ddb47abmr16814545wrq.39.1683878161845;
        Fri, 12 May 2023 00:56:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y15-20020adfe6cf000000b0030633152664sm22620955wrm.87.2023.05.12.00.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:56:00 -0700 (PDT)
Date:   Fri, 12 May 2023 10:55:56 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: delete a stray tab in can_finish_ordered_extent()
Message-ID: <a145fa32-2095-455f-a9a1-d06d9e785e55@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This line was indented one tab too far.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a54bf49bd5c8..9edb9403ff4a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -323,7 +323,7 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 			   ordered->num_bytes,
 			   len,
 			   ordered->bytes_left);
-			   ordered->bytes_left = 0;
+		ordered->bytes_left = 0;
 	} else {
 		ordered->bytes_left -= len;
 	}
-- 
2.39.2


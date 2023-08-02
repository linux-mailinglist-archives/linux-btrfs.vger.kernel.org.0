Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27776CE5B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjHBNUc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 09:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjHBNUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 09:20:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DCA8F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 06:20:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a412653335so4542044b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690982430; x=1691587230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFc9I5c/0jqTsrPuskuWAfytlY1pJqmAnpKfJ4XhGVg=;
        b=nGoHSUxsWRHWKP9R5GVA2Ia1aJXymuCuDnSQLALohB+6PFlv1Aj6rSL1zBihd8UMin
         oqJW3XXNqT7rDxpd2QBGkxK/b3xbkP3nLAinZ+EWulCotroXfMjqCIRXiwN/jK6rcnFt
         CWcAI5P6b4znjOmMwZaLt223hQNzD9BshBul1vfTXtIkbij51KGWKr14ZIyjF6VpRTHH
         Gkl0ZCMl6AmWCzg644sRTplLzynf3NINdi+EL+VM1CBJSPEEpU72DJpdiig9a7hCzCmb
         UJl8xhAo57264B2TYF8pUcboK/UM27k01S20dzqb0SXR17YmMFQeySPmfh6vETLfAKkW
         ktrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982430; x=1691587230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFc9I5c/0jqTsrPuskuWAfytlY1pJqmAnpKfJ4XhGVg=;
        b=kzHgx0EiBkcUK2SUvlMFNPmB3Hy80XbKm622XnaExAsmHrNdX70siFGde5jHHqUMy2
         G568jBhwJXb+TqxxkTYCOj7ZhnzLzlYoVAovgK4vJqXw8yZeOWAJRgtDmwqTSRFzlWWu
         +wBINcYH4pdMMYHWXSF1Uj7HU+jr/HZI7cNOJ6pmAqC0NAkkFN9BUfLUx4KfGn6/Dl+o
         4lqzWSQIr8ZlZkSHJ8LHXwj6bvGNR+IqUcDaqib0yWXA/arVYMstMDm0QVWc4SMz2+Ud
         6QP3ZO0lShj/T2nq8Q06UjhxWy7TctiYOIePy07JfwbyHXMuSsdQ9x9FLRmMe8XONav1
         GCRA==
X-Gm-Message-State: ABy/qLbvRch2LKXTpXSXeuG3HUqTudko+/mc26A50Ylh7HoJEvz3F7aH
        9YmyBOvNze5GG/5ujK1x8hi77PfQQDgN+yx/jnFb2g==
X-Google-Smtp-Source: APBJJlFuQEWtSj2Im1iBaOsW31hIo91k+8mLZuS3HZ8DAGhwt02ybrLaMLC1wyk/owWnjb5uQg4s5Q==
X-Received: by 2002:a05:6808:189d:b0:3a1:dd1e:a726 with SMTP id bi29-20020a056808189d00b003a1dd1ea726mr18186536oib.44.1690982429876;
        Wed, 02 Aug 2023 06:20:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 78-20020a250d51000000b00d217e46d25csm3852944ybn.4.2023.08.02.06.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:20:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: set cache_block_group_error if we find an error
Date:   Wed,  2 Aug 2023 09:20:24 -0400
Message-ID: <8717f1907f699058ab6a6941c007ad43c903a3ca.1690982408.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We set cache_block_group_error if btrfs_cache_block_group() returns an
error, this is because we could end up not finding space to allocate and
mistakenly return -ENOSPC, and which could then abort the transaction
with the incorrect errno, and in the case of ENOSPC result in a
WARN_ON() that will trip up tests like generic/475.

However there's the case where multiple threads can be racing, one
thread gets the proper error, and the other thread doesn't actually call
btrfs_cache_block_group(), it instead sees ->cached ==
BTRFS_CACHE_ERROR.  Again the result is the same, we fail to allocate
our space and return -ENOSPC.  Instead we need to set
cache_block_group_error to -EIO in this case to make sure that if we do
not make our allocation we get the appropriate error returned back to
the caller.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6a3414545e01..7fce05cc6090 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4277,8 +4277,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			ret = 0;
 		}
 
-		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
+		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
+			if (!cache_block_group_error)
+				cache_block_group_error = -EIO;
 			goto loop;
+		}
 
 		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
 			goto loop;
-- 
2.41.0


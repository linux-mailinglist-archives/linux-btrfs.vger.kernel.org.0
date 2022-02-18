Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A24BBBC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiBRPDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:03:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBRPDy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:54 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395529720E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:36 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id o5so15245218qvm.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqyYr1SNUHXS2VgPKdKLZWUk41qb+3D4P7lPlIcVrHc=;
        b=yUJCaCV+tygye99TJbO18BeIdckXXhEwu+HnPQTuu5vpOHhNgyqQF00LNzrcCMrb3d
         KBxkDvpTp62MvBZnYSGkUrE5Z1CFFQ8jmXF7qb+cm2OSS76myNPtUr1kcAVTd8WLUFgN
         5d6QSozk3V+O39h1HzmDFulsmSHTmG7TOQn20nC60J0IjMS9OMBtJNDQYY9uv9EaxL9O
         6769X0RwHgBI9XdXnnaCxw3FUg3IxtcoScg+PjMNEJKmOMJr86+U3FyVwBHayOktf5CC
         1EXQ+Nyn3+Jsn5aZF9NB0VNlRBVmm0EMqZQjUY/xfvWWx8Gr6B7wyIhDnTrr+06FSZJU
         s8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqyYr1SNUHXS2VgPKdKLZWUk41qb+3D4P7lPlIcVrHc=;
        b=u/xSnOH5gZU2ssI9G7KwBqgKTHmfdmF/RbmA4k5dUy7xYu0l0cnObV2YK+knRiQqsp
         G+XRtXCv6Zk3UOzlFzxeL25XFDWbRnGfJCkxCM64a/EHrHUWUGMohrQ+WwhLIwY4RLjA
         LTF6cXOyM6dLE/pXIiZ5VFjF4TybXWUyBGpnAom/xtQ261ORfQVzaD+OcdGLXds/WKXz
         JXEQ4p4s2rxX//5BzGHu0NkJOXTMVtY0I0lxYMMsv5UgLvAQQkc1NFVpTdPWEyH/tTsm
         9pba0uB5Yv3nOQKaqJhwv2JuhHQP6ZyVLa8uWzMSIKres4GteN+7W5jvbFMvOiF+dBFi
         7EkA==
X-Gm-Message-State: AOAM5319OpdoU71tIF8uiaGQF2tWPovsta5yJFWwSHp4ZzSeM3jaQkiq
        jKj7GNKOsufHD/qTIKnZj9FiNtTTCQGjtnyF
X-Google-Smtp-Source: ABdhPJwnhD0nUwzgMDvEdfsVpZMfeI4L5r4z++OnXtERWJXSNmUuyZ+ksA/NyFD5mAzsvhv/vx2fqg==
X-Received: by 2002:a05:6214:21ac:b0:42c:2844:aa93 with SMTP id t12-20020a05621421ac00b0042c2844aa93mr6006048qvc.130.1645196615127;
        Fri, 18 Feb 2022 07:03:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e3sm2435786qto.25.2022.02.18.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/8] btrfs: check correct bio in finish_compressed_bio_read
Date:   Fri, 18 Feb 2022 10:03:24 -0500
Message-Id: <32b987984840f676ea3e71194f7a7d81f02903e7.1645196493.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
References: <cover.1645196493.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit c09abff87f90 ("btrfs: cloned bios must not be iterated by
bio_for_each_segment_all") added ASSERT()'s to make sure we weren't
calling bio_for_each_segment_all() on a RAID5/6 bio.  However it was
checking the bio that the compression code passed in, not the
cb->orig_bio that we actually iterate over, so adjust this ASSERT() to
check the correct bio.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 71e5b2e9a1ba..a9d458305a08 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -259,7 +259,7 @@ static void finish_compressed_bio_read(struct compressed_bio *cb, struct bio *bi
 		 * We have verified the checksum already, set page checked so
 		 * the end_io handlers know about it
 		 */
-		ASSERT(!bio_flagged(bio, BIO_CLONED));
+		ASSERT(!bio_flagged(cb->orig_bio, BIO_CLONED));
 		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {
 			u64 bvec_start = page_offset(bvec->bv_page) +
 					 bvec->bv_offset;
-- 
2.26.3


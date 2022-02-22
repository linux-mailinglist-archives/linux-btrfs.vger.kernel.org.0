Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30374C0481
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiBVWXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiBVWXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:17 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BEF6A053
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:51 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id x3so3485110qvd.8
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6BZ+XXWGNqSveaOKvZEzymkDdFbbFwhSqrpr7+8yraI=;
        b=WrZVs49vjMNFYpWiJ0Ju7B0HDw46e2WL00qhtbNsiZ8qKXGC7l0EvYuSmbcKdUlAM0
         sSCTmXoeNn+fpH945ojn3Xdkq7aevGoxxsrdeksxcE3H+J3BZJRAPhKF13GdKDvZGVEo
         NC+CdeJQ6Lcf8X9cXvvCuR3ggoAYg8Cwx6qc0mNdMlq3LzEFhus81f42HpWFQ1rNH/j4
         F+/qm/rJiVsVy8+CPebFzaMa0cBNHsRtw0sGQQQd84INylTZVA/d2nYSZPieU7Y8M0q2
         o0qbD57aZK4o1eY8xvyKXJOiDDQYE8UcKDklemqm9No8rLywFyoNfgNvMi/uIysRi5nY
         bHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6BZ+XXWGNqSveaOKvZEzymkDdFbbFwhSqrpr7+8yraI=;
        b=31orPOAakBJAV+Wg+T9m5AIIOY5ErHytSXYxTNB9DLVa8S7e0Co5Ef0W3zGMDZdmV1
         X99RJdKMY8UxSFxMijMiahhX0RyZI3hnQhLgJbrl+eL1FuMihZv7RQMPXwqUG1ZWJ7Ea
         p3zJf8E+um7laDc86swyCbELIW/2tUR9U47JbflX8OgNHiOkYa9eJbp4JxUj7R3yvoGj
         TsB7nofwNY9LEOV9saU5ULMtGBdJR7KhPxEQInyI78gXLzC8fNj0L6P70GCqAUNs9QMp
         SiYa3gY3VcGE2Y2Q/OymxLSt3U9G5RaSSLWm0Slxbq2ZVgGZ6RMYwoGNSkuAjMxoZNuI
         CkJg==
X-Gm-Message-State: AOAM532/xBWycSzeUEFHN8UV0CawWJrnlg/sJ0HJxiocDojXj1/LWYnp
        pVN3VGLrrsaSEqsZ6cLbyPSPWQUa3AOiJIyg
X-Google-Smtp-Source: ABdhPJzQL2j6O7R6/AnnCvDOCPbgwuHJroTtZ5zmAUpBAoTa/kP/yv6EOia6R7YOSu9sGVV05v6e4Q==
X-Received: by 2002:a05:6214:e85:b0:42d:f76c:d229 with SMTP id hf5-20020a0562140e8500b0042df76cd229mr21032319qvb.68.1645568570196;
        Tue, 22 Feb 2022 14:22:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s5sm630946qtn.35.2022.02.22.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/7] btrfs-progs: don't check skip_csum_check if there's no fs_info
Date:   Tue, 22 Feb 2022 17:22:40 -0500
Message-Id: <1a0bbdbc600efc9bf09d89170e15f8047480474b.1645567860.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645567860.git.josef@toxicpanda.com>
References: <cover.1645567860.git.josef@toxicpanda.com>
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

The chunk recover code passes in a buffer it allocates with metadata but
no fs_info, causing fuzz-test 008 to segfault.  Fix this test to only
check the flag if we have buf->fs_info set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 1cd965aa..637e8b00 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -174,7 +174,7 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 			result, len);
 
 	if (verify) {
-		if (buf->fs_info->skip_csum_check) {
+		if (buf->fs_info && buf->fs_info->skip_csum_check) {
 			/* printf("skip csum check for block %llu\n", buf->start); */
 		} else if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
 			if (!silent) {
-- 
2.26.3


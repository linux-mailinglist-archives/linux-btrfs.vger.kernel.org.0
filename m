Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44E4B18BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343987AbiBJWoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbiBJWof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:35 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341AD5F7C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:33 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id fh9so6669447qvb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Cl8wfPpxQ/ysohn0n9bzVL1r2SjPino5fnfjtpI+8jM=;
        b=kh4uOEpfK0uF+fpghWRsihsxorwIpVLNqiOTHBvSDmvA2sWwZZR/ix5RNIMS9ANUq5
         c8j8NGyHhrWAKGhLkCuBGjyZl1bSTZOKS5LLDevCqsBGKkFi2E02Yvbux1ziXgVCoorn
         SvfF9zwVzitRXBfQV9bzN8WW8QfFZDG5JSlPbK4WkrC4WKjt+LPHxm895qO9O6GsPgWN
         ri0BlpmJMTrwFPebbh6WaV+iP+6R4a+mwCqpWIr/Zgad9711RKb7AVF1+ybaDaRVlup3
         EraGkhIjdWUdvXZNZgbL44QPpHp7JTTv34DKL4RPunQwqk27lBYqEtFr74vzPCTBRN4a
         4hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cl8wfPpxQ/ysohn0n9bzVL1r2SjPino5fnfjtpI+8jM=;
        b=fy3bX8+9jIc3OPJlHy7+W2kSS02Z/JB6WgVRF1NymYR8b8chvkKcOBzKPbmA9/80nS
         Vb83gXqbtJRCkjTpH+IqO0ZayjihLYVahXP/qy7oBnfjKBA+KVnKOGz6LkNiNZ/YvJ7j
         2eSLem+pIcY6AhY+XTsrJErfOGfmS1pzv6+sfnhmxsZV0NmWAXnoHhSloSOViTj56Nuw
         aANdP1/fdpGAfpXjBVJc1TwoZ5KI+swAK4gXbk/YEuIusZk3MrmSW8Wb3GnNm6Yr0eig
         l7qKhmWO9gS0TAvQXu/qra4NjuNuINUSBeT1To6ME7q1bftLCoLT/3rVN+L8qGH5Bw7Y
         36iw==
X-Gm-Message-State: AOAM533dFvnMhzDsorS6QAdRSeTrX9F/gWdZPK3tMz+++zxbznZ0WGnZ
        5a7GeHnQ22ayy9ncrCNvZQUrv2hgWnCrKF25
X-Google-Smtp-Source: ABdhPJyE7k/0XbsNZvblRz3M4FVT8PPeCdGypwsnEa5NxMoGLLJnQjktzVgOg896nzm33T+bqMtd+w==
X-Received: by 2002:a05:6214:2a8a:: with SMTP id jr10mr6735197qvb.112.1644533072142;
        Thu, 10 Feb 2022 14:44:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w19sm7809449qkp.6.2022.02.10.14.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: check correct bio in finish_compressed_bio_read
Date:   Thu, 10 Feb 2022 17:44:21 -0500
Message-Id: <04d361b2ca1bdf0470e9fdbba00eecd801d18268.1644532798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644532798.git.josef@toxicpanda.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
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


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A01AD21F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgDPVqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgDPVqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6E6C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e12so36009pgj.6
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/itYSMNpKstDNGP+csfYL+XP5hOJoVD3pIaqUC5WKo4=;
        b=Y6OM9PRdA9dwgKfvgZKouWhzVg0FPu1NJi22pb0yPQF6sXDxxSl/oSVdfzMDyWV3e4
         tIceL6hB1DvPMpSZEamJfSzZtvApelt1oyCQIvZk3/K0eJlQr5cNkiV4TnaHI/JzYLu9
         Yqh6NnZsAiHBF7sTtcZZ6QyrgU0hJ8e/W+kB2tw/FcFcCdZt42L7cCVRV538S4AO7YYA
         KWOAvDvzv0foOqZUPCGDkTvLq2BLHYIFvC6LPiNEI1adt/sWG9btPPEF7jRvIURXkfdx
         EB8UNOau/+VzEIE5aCMeVq8MCezk0o2dgu4HcNZuoQRtE2JYmcuL4rTWEXleqESYtm9r
         rvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/itYSMNpKstDNGP+csfYL+XP5hOJoVD3pIaqUC5WKo4=;
        b=TZtqPYtqjg8xL6jIoT1bJauMYyd37zCGO7JMOyqhcWJwqdEdUxcP+g1Nc0c6LwtdEM
         ACFN0G2p+VtrXyedwzwcLp1AV2CJPiBxOdIj1pr2VYgTRhFnhCVdroEj6Aa3qkJatFTn
         Hnj3GGnUvgfF2CLCjnmxBbmam7GmiZLLoNiLEMtFywDwXV9aC72W3TlkWKrmOBxXdCM4
         ZqUHpzfTOIRu8TBQLuCvz9Jrny+PGP/Z30e+Gq+9z86t0VG4bkS4+eVqE4DejpgNLFKn
         Ut3LX25YUsO0EIKVuTOsiwyh50L6raxuQS7NBz0qs6GaZkDdoxggz7xeLhnHjdzs4rqn
         t7Fw==
X-Gm-Message-State: AGi0PubjoNlLip1ozatp5VyY6fGZVtiKyOX9KXfWktVaSkfjpeguKdmM
        MbfK6eYcI9a6/qZOtCyzZYPlvI6sxw8=
X-Google-Smtp-Source: APiQypKxYZaKQyJEItnB9G6oWCOzAopUvXvfutHe8S57apaWaZVCFvbxTPDqmp8ErI+LfXNOcd/NkQ==
X-Received: by 2002:a63:d46:: with SMTP id 6mr8501589pgn.434.1587073594084;
        Thu, 16 Apr 2020 14:46:34 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:33 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 01/15] block: add bio_for_each_bvec_all()
Date:   Thu, 16 Apr 2020 14:46:11 -0700
Message-Id: <b00f5fb71cfa1655f0e5ccdda8a53dcab81a44fe.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

An upcoming Btrfs fix needs to know the original size of a non-cloned
bios. Rather than accessing the bvec table directly, let's add a
bio_for_each_bvec_all() accessor.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 .clang-format                   | 1 +
 Documentation/block/biovecs.rst | 2 ++
 include/linux/bio.h             | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/.clang-format b/.clang-format
index 6ec5558b516b..1d6e39ad2454 100644
--- a/.clang-format
+++ b/.clang-format
@@ -80,6 +80,7 @@ ForEachMacros:
   - 'ax25_uid_for_each'
   - '__bio_for_each_bvec'
   - 'bio_for_each_bvec'
+  - 'bio_for_each_bvec_all'
   - 'bio_for_each_integrity_vec'
   - '__bio_for_each_segment'
   - 'bio_for_each_segment'
diff --git a/Documentation/block/biovecs.rst b/Documentation/block/biovecs.rst
index ad303a2569d3..36771a131b56 100644
--- a/Documentation/block/biovecs.rst
+++ b/Documentation/block/biovecs.rst
@@ -129,6 +129,7 @@ Usage of helpers:
 ::
 
 	bio_for_each_segment_all()
+	bio_for_each_bvec_all()
 	bio_first_bvec_all()
 	bio_first_page_all()
 	bio_last_bvec_all()
@@ -143,4 +144,5 @@ Usage of helpers:
   bio_vec' will contain a multi-page IO vector during the iteration::
 
 	bio_for_each_bvec()
+	bio_for_each_bvec_all()
 	rq_for_each_bvec()
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c1c0f9ea4e63..c506b26f273f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -169,6 +169,14 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 #define bio_for_each_bvec(bvl, bio, iter)			\
 	__bio_for_each_bvec(bvl, bio, iter, (bio)->bi_iter)
 
+/*
+ * Iterate over all multi-page bvecs. Drivers shouldn't use this version for the
+ * same reasons as bio_for_each_segment_all().
+ */
+#define bio_for_each_bvec_all(bvl, bio, i)		\
+	for (i = 0, bvl = bio_first_bvec_all(bio);	\
+	     i < (bio)->bi_vcnt; i++, bvl++)		\
+
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
 static inline unsigned bio_segments(struct bio *bio)
-- 
2.26.1


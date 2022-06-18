Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6B5503C0
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiFRJTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiFRJTJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 05:19:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76902654B;
        Sat, 18 Jun 2022 02:19:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ej4so5042700edb.7;
        Sat, 18 Jun 2022 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnShuNCC7vJwyx79q/xFZV5Bswk3kI4OzmQoFoQnuVM=;
        b=e/JcgF2akSWVnYgPWU/7toRYSXH0Ei2m6FY539tryc8COawWnTM5q1P5l3T4gWEHfd
         vLRDXtG7XraEeEpTm9MGP8zzfmagqSTbwotmISuzb0DRhGaHQrCmK6n/IbX/QFl96dJL
         TQiOo8Q+stPMK+jpgZv+Q/xp38EFksLxUos3jdudA1x5JVYQnLI0Yx1BT3BLW4wchsSv
         N3dwe8/Lsu3oJvnpRKHsV4l4ixPZwmg9cN0hymnjkqLG7T1HyzVTBuXd2yArLYrN1ZUZ
         UtNLosVgbL45q2t8zZ0cCQrntm9E2Aec6Xi5INR4+HtLOuNqfHUEJ1fryr9BGzzjz5cT
         kG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnShuNCC7vJwyx79q/xFZV5Bswk3kI4OzmQoFoQnuVM=;
        b=rm6E6QcwBk5UDfdCwJsr9NL6XkgZbevZ6lw9hOiEcSaTdXBdCGeeNWYy2Y+EzXhQQI
         hAwiDPZ2/r0KQMEEST97euaMoB1koVeviZmatQW5JgeCPXH7j1+qKEhlYAdnMPrBS3yl
         41pjt0yQEdfrPAtj/UjMEi/5ruf+gKbECc8cn8tLZ4lMNQo+kSgQCZmQEQl6A48uyqSS
         gSOGOFzVU0Cu9nyIDd0+eFTT1RytI+NFYrwKXqyJbGYgOF82lYHTxGbmxl3Qlq+22Y3t
         JShc/dRSscoIk4hP+gK0I7Y+mG1SUpN3Ubdfwn1HPHrI35pyfsJKnonOp4sKi3NnaUE7
         byxg==
X-Gm-Message-State: AJIora8sn322mrOEFlD/9sHt+k01LCsFZjy/6sN2bOc6d6ulpNeBAt9B
        TNSeh9vWmhv2hpByKJuYHvI=
X-Google-Smtp-Source: AGRyM1uMBcKH+3IxoQvCC6JZfyD0aPNjvWdfndC8vZU7LL7keZtOqzsWzqlAIaDaQGT6X0XXrJ7xDw==
X-Received: by 2002:a05:6402:403:b0:434:eb49:218f with SMTP id q3-20020a056402040300b00434eb49218fmr17442869edv.426.1655543947288;
        Sat, 18 Jun 2022 02:19:07 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id lb21-20020a170907785500b007219c20dcd8sm451956ejc.196.2022.06.18.02.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 02:19:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] btrfs: Convert zlib_decompress_bio() to use kmap_local_page()
Date:   Sat, 18 Jun 2022 11:19:01 +0200
Message-Id: <20220618091901.25034-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page(). With
kmap_local_page(), the mapping is per thread, CPU local and not globally
visible.

Therefore, use kmap_local_page() / kunmap_local() in zlib_decompress_bio()
because in this function the mappings are per thread and are not visible
in other contexts.

Tested with xfstests on QEMU + KVM 32-bits VM with 4GB of RAM and
HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zlib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 2cd4f6fb1537..966e17cea981 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -284,7 +284,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	struct page **pages_in = cb->compressed_pages;
 
-	data_in = kmap(pages_in[page_in_index]);
+	data_in = kmap_local_page(pages_in[page_in_index]);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
 	workspace->strm.total_in = 0;
@@ -306,7 +306,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
 		pr_warn("BTRFS: inflateInit failed\n");
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(data_in);
 		return -EIO;
 	}
 	while (workspace->strm.total_in < srclen) {
@@ -333,13 +333,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
-			kunmap(pages_in[page_in_index]);
+			kunmap_local(data_in);
 			page_in_index++;
 			if (page_in_index >= total_pages_in) {
 				data_in = NULL;
 				break;
 			}
-			data_in = kmap(pages_in[page_in_index]);
+			data_in = kmap_local_page(pages_in[page_in_index]);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
 			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
@@ -352,7 +352,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 done:
 	zlib_inflateEnd(&workspace->strm);
 	if (data_in)
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(data_in);
 	if (!ret)
 		zero_fill_bio(cb->orig_bio);
 	return ret;
-- 
2.36.1


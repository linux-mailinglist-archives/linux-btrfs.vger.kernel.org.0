Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7E6E83B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDSV3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDSV27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:28:59 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F95170E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:28:55 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5472ead2f56so110603eaf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939735; x=1684531735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BT7Zbax0bpxmHqvJ/MXdpLOfsE8EUXSfjxvOFFyb5kQ=;
        b=UpkD5sjMFVuNvqqDcdcGcdZhUQCJp6pYfyEhx+nR21tc3xnXi6wVqYCpc2oYVkEHSK
         q58M0l1QK7Rg4w9WmqyBiZQELM0SkKR/RrM2Nm2WAaFnG34jsIqSNB4/F8keNomy7KdQ
         AKMLgLDDg/V3X8gGNRMSDtLqNayVa8JkZLdB5Dt7D6nOBeaPNTLxQU1FPKhphK+BxMIc
         VucOVMOsnaV3uDnxUt8X9z72kF4jtFxObszG9+pvu80xpSO2TqGZv/Uv2QRHu2qz7sHB
         FlW2DV9YiwxCt4LdKK+2ImN2WrN3jrLETew/tZq26PzmK8pbLk0Ati8youRmFkmIUeh3
         dGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939735; x=1684531735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT7Zbax0bpxmHqvJ/MXdpLOfsE8EUXSfjxvOFFyb5kQ=;
        b=TpZnxLauLMpGjRwIMv+vi9aExPaNf6QkiVY5qm2ZHSQ9FSem0DiCkhfp8TQzfWXlVd
         DTZh47hcdE59568iCB/Fwk5dbMIrhu7/8XkeAnUJfxMtPPwPjsPLT61sAy5CepuXukNm
         rivCcWlstu2hHoDqGBtOMgEkGieypq7zF93JHma6eGLEfclVH2v104hw3F0mpwMy6B8r
         /TYfyYN4lFvUbPqhRpr6CqDrLbmMGjDC40LgdCpTIoioxztuPn8D321dAuWwfugwOT7y
         Hj6J3rt5vnFV+HtF2TQdzhmQyaPG9Fy3JK/u4KRBMtOYVCX4Ox0mWaK5JtwzswPFXeiX
         IN3g==
X-Gm-Message-State: AAQBX9fvl47wlt0/vmNw5tW201VZk8hKp219MQzZOTlaAi4Vx3knSTMz
        zzNQ14lwQdtQVNbGTOdH7QWeYs7BCIUwVLqlPcYt/Q==
X-Google-Smtp-Source: AKy350brXqmv5svzm8zXiGzRvzYPlVRQIluiAqTg0esrLJWn70mwldJ46vRfWkIJ17K4fNHWjDTD8g==
X-Received: by 2002:a05:6214:f2c:b0:5f1:6c0a:1df6 with SMTP id iw12-20020a0562140f2c00b005f16c0a1df6mr7041694qvb.37.1681939255189;
        Wed, 19 Apr 2023 14:20:55 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a27c800b0074e1625917bsm552183qkp.32.2023.04.19.14.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:20:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/10] btrfs-progs: const-ify the extent buffer helpers
Date:   Wed, 19 Apr 2023 17:20:41 -0400
Message-Id: <9e136253b6e9ae2cbd929552f4e36a3a641cad1f.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
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

These helpers are all take const struct extent_buffer in the kernel, do
the same in btrfs-progs in order to enable us to more easily sync
ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 15 ++++++++-------
 kernel-shared/extent_io.h | 10 ++++++----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 46c0fb3f..01dc5b1e 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -609,26 +609,27 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 	memcpy((void *)eb->data + start, src, len);
 }
 
-void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+void copy_extent_buffer(const struct extent_buffer *dst,
+			const struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len)
 {
-	memcpy(dst->data + dst_offset, src->data + src_offset, len);
+	memcpy((void *)dst->data + dst_offset, src->data + src_offset, len);
 }
 
-void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+void memmove_extent_buffer(const struct extent_buffer *dst, unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len)
 {
-	memmove(dst->data + dst_offset, dst->data + src_offset, len);
+	memmove((void *)dst->data + dst_offset, dst->data + src_offset, len);
 }
 
-void memset_extent_buffer(struct extent_buffer *eb, char c,
+void memset_extent_buffer(const struct extent_buffer *eb, char c,
 			  unsigned long start, unsigned long len)
 {
-	memset(eb->data + start, c, len);
+	memset((void *)eb->data + start, c, len);
 }
 
-int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr)
 {
 	return le_test_bit(nr, (u8 *)eb->data + start);
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 8ba56eed..69133c3c 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -110,14 +110,16 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start, unsigned long len);
 void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len);
-void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+void copy_extent_buffer(const struct extent_buffer *dst,
+			const struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len);
-void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+void memmove_extent_buffer(const struct extent_buffer *dst,
+			   const unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len);
-void memset_extent_buffer(struct extent_buffer *eb, char c,
+void memset_extent_buffer(const struct extent_buffer *eb, char c,
 			  unsigned long start, unsigned long len);
-int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr);
 int set_extent_buffer_dirty(struct extent_buffer *eb);
 int clear_extent_buffer_dirty(struct extent_buffer *eb);
-- 
2.40.0


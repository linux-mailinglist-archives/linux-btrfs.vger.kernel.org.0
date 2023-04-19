Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0E6E838B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjDSVWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDSVWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:22:39 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD92903C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:06 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ay32so63972qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939261; x=1684531261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm9ffGkLcH0XBb3U/IhrXrKQIhZzlp8ny3RtCxuDam4=;
        b=be5tpLtrbuhYaMeJAdmXJOcOra79Q53QsV+JcDUvRiFnQp2pTE8mjTPABf5ClDuLPX
         HM/thefoacgB90q020hvx+171++0Q8EAFGLYXtlR7oZOsUPSggwqYGkabDcC53MICQpk
         +fwJB2SVFcg1WIeA2FoxGxYp6b7dIfRAqVbGoLeqkuuxUaspCmOQf0dGqWl5+DLX5lRr
         TWoN6rSigdhQDNRqgLzT4srGS8+MWqVfdeNe4JshTR+x87TT2ysET0wxXuk0cvWJEqPx
         gsfGSbSVkPCE4tgg367AO2FxDTi9A8t3zfvc7eGady4gXE6lSa4okIgLs18bXQh8vguf
         YXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939261; x=1684531261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm9ffGkLcH0XBb3U/IhrXrKQIhZzlp8ny3RtCxuDam4=;
        b=MdwJJEwfFvD/84aei+2egUhUUSDJ+oC/NgZExSR+U1wZA6BO5NFVW03JczkyKVmogZ
         a/IPv6EhLUQQ66RMtHCCUJArrjRRH1wenbA9HSndpu+U5qvzpIS1R0DQlFWDKImLm0BR
         nKnKT7yHWOlfiKWXYhMsbJJorjLLTgVArpogR+Cd0yf1rvLclTugc7CuBip7+2LPtoqz
         bYUeQ7qRmCN7V6pS1N7sjX1Wb3JyjuiLEktU2w0vAj9DxbxuDVMMD7OKSvlefQQMlXMv
         43jCdqZYGkgT8TVW7WI8Z6f3h3vEw5SBmHu9xd/o6XLRUrGYkBeOvRlMRZoH3Mb0n8jD
         IsHA==
X-Gm-Message-State: AAQBX9fzrSjqRXKDHQfdbqb6oyJsoZ4a9vqSQySMtE1pM6UlOdaXORQQ
        /jnYaTqkW8n7wmQt+ucsiXwwCgFiAqGXq5ltpMxkkg==
X-Google-Smtp-Source: AKy350ZsMGx4hdgq83/tQhyoXs523JOfCpJQQcI4qJHMmSsQQNH2kSzKPagBHf7jtgaxL/+OvNQdGg==
X-Received: by 2002:a05:622a:1d4:b0:3e3:882d:4b47 with SMTP id t20-20020a05622a01d400b003e3882d4b47mr9072468qtw.26.1681939261590;
        Wed, 19 Apr 2023 14:21:01 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a289400b0074a0051fcd4sm4899227qkp.88.2023.04.19.14.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:21:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/10] btrfs-progs: add some missing extent buffer helpers
Date:   Wed, 19 Apr 2023 17:20:46 -0400
Message-Id: <8c23286a4b3630e17540bcddce98eabebdf9c8a3.1681939107.git.josef@toxicpanda.com>
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

The following are some extent buffer helpers we have in the kernel but
not in btrfs-progs.  Sync these in to make syncing ctree.c easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 11 +++++++++++
 kernel-shared/extent_io.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 01dc5b1e..f740b3a6 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -617,6 +617,12 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	memcpy((void *)dst->data + dst_offset, src->data + src_offset, len);
 }
 
+void copy_extent_buffer_full(const struct extent_buffer *dst,
+			     const struct extent_buffer *src)
+{
+	copy_extent_buffer(dst, src, 0, 0, src->len);
+}
+
 void memmove_extent_buffer(const struct extent_buffer *dst, unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len)
 {
@@ -634,3 +640,8 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 {
 	return le_test_bit(nr, (u8 *)eb->data + start);
 }
+
+void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
+{
+	write_extent_buffer(eb, srcv, btrfs_header_fsid(), BTRFS_FSID_SIZE);
+}
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 69133c3c..103f93cb 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -114,6 +114,8 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			const struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len);
+void copy_extent_buffer_full(const struct extent_buffer *dst,
+			     const struct extent_buffer *src);
 void memmove_extent_buffer(const struct extent_buffer *dst,
 			   const unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len);
@@ -133,5 +135,6 @@ void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
                               unsigned long pos, unsigned long len);
 void extent_buffer_init_cache(struct btrfs_fs_info *fs_info);
 void extent_buffer_free_cache(struct btrfs_fs_info *fs_info);
+void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv);
 
 #endif
-- 
2.40.0


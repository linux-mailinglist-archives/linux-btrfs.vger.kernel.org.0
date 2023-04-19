Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D76E83A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjDSVZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjDSVZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F59EFB
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:39 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id fy11so601396qtb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939479; x=1684531479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpagXFsxJft6J5gLjue1iEq0+I5OWYJ4dq12KNrkuWE=;
        b=gAUNTICt68QXIa4JGfu5jhjKShhEdL6FAJUT42ElqVTO000/ixOwbqmyJrAQkWVUto
         9qTjYYEexB0Y/YxQuwZhYkHA71AsuhtLrNwto29Qv3uuY7PW46jz3eoZJHd2p785Nybs
         IYrxjyC3LW5L3fv0C6R52QGMRBPExkKu39qeVl7ciP10rcuaLSPpklmECgK8bf8uW8FF
         ssO3g3PzQwL7JOWpEQpUOaA7siAPnSvFypc8CD83jqQW6/M5CdCJvnaaFkJaII93mtVr
         zLmY0B0ZqLGTTtlJa8nZmWlq5lmG5elVzJP+flvyaomZgJSFuUK9+CfvvYtjWGujdFOg
         6gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939479; x=1684531479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpagXFsxJft6J5gLjue1iEq0+I5OWYJ4dq12KNrkuWE=;
        b=PQ+ESAy/Y0ZJykK9TAV/w9mt/avEpEJK+1b2MUqXpREperlrPJKr53OpKqfPZPecKl
         pHtq4boOM+UoU5pZqdntcyKhrS/28uqKnXhk19TZrwAJpqiNHY2k+0gWKKVuHlw6aXFo
         zuCn6s3uxfV2UYjGm5P0jLyPZ5lFyHutL5BbJ5Etxw2j/we0HaC3VNk0gHbsz+mXi6/V
         HaOVskxH383b7qXCkoN5rzc8sXtaCICh2Sr6eLpIWAXpDbBRHyzYEkgX85RufwjLKCa0
         Ob/0v3aO4w0hhJYtSlCKP0jL5Yf9DXTHgINOO12GS691xhdyAuXudc2GXsjmgr/dp1+W
         db9A==
X-Gm-Message-State: AAQBX9d2HGOqGRW/Wo3O9gO/umZHNPLcEkb/danU+BJy8RfDmrKRz9yq
        EDT3HkQtX+dgniL4ZOOfpZISekS9TFlXgxHKEipBKA==
X-Google-Smtp-Source: AKy350b62Yn3hu4UuvvAbiG+6u1RHRBZic2VsMCqDjko1iUvzBpv+BahRG3IyQruQzZq2V712pVCew==
X-Received: by 2002:a05:6214:29cc:b0:5b1:a698:43c6 with SMTP id gh12-20020a05621429cc00b005b1a69843c6mr22921128qvb.18.1681939460104;
        Wed, 19 Apr 2023 14:24:20 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g24-20020a05620a219800b0074db94ed42fsm3036832qka.116.2023.04.19.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/18] btrfs-progs: add a free_extent_buffer_stale helper
Date:   Wed, 19 Apr 2023 17:23:56 -0400
Message-Id: <8960058259d45ddda23064faa3e782d28599a262.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This does exactly what free_extent_buffer_nocache does, but we call
btrfs_free_extent_buffer_stale in the kernel code, so add this extra
helper.  Once the kernel code is sync'ed we can get rid of the old
helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 5 +++++
 kernel-shared/extent_io.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 4dff81bd..992b5f35 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -204,6 +204,11 @@ void free_extent_buffer_nocache(struct extent_buffer *eb)
 	free_extent_buffer_internal(eb, 1);
 }
 
+void free_extent_buffer_stale(struct extent_buffer *eb)
+{
+	free_extent_buffer_internal(eb, 1);
+}
+
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 bytenr, u32 blocksize)
 {
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 09f3c82a..e4da3c57 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -104,6 +104,7 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						u64 bytenr, u32 blocksize);
 void free_extent_buffer(struct extent_buffer *eb);
 void free_extent_buffer_nocache(struct extent_buffer *eb);
+void free_extent_buffer_stale(struct extent_buffer *eb);
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
-- 
2.40.0


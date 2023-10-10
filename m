Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889D07C41AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjJJUl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjJJUll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3931FA
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7c7262d5eso11152507b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970497; x=1697575297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMKykqBQS3RwEEufY+WMuQHq/EYaymfByQ3Narp/qxc=;
        b=Pf6sO2Q8PbPLwXjPDfItr2/XiXAiSYTSmX1/ppJ8y9kuMaQBJ65oIRI2u1uRbmeuac
         4Z3vz1HNiQ7BMc997V5OHwpfUUtE/TwrlG3NdhQl5Nvla5bkbfNsZ0HnfeDZ1TANxQ9K
         rm3+RrWSiTWqrblMqgAOgaeweaWUUcYntkffgPhwKXVuF+RBPGHdX5CXozBFHHYqTu/b
         0dv3zmTGg3LGW9+adu6RGf3QTFSH/YGZPWmiRTlmmp94gkjtf1Y9YtzkOoEKyQog3K+y
         3yEarudlPP7kNJrgtqExtv4k8RHspW9UuxUu1pSSBTa20HFbuyBxcIO10yK7N2eXBm9G
         AsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970497; x=1697575297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMKykqBQS3RwEEufY+WMuQHq/EYaymfByQ3Narp/qxc=;
        b=PZqzD8xh9YqmHNAsB23QGWSPU4JjB9TEdT7Y9WmGxeLo1Hm5jMXukwoPd0JuOc6Sl7
         XJ3R02c2OXoz5uahpBHI6riiHjDNABb6vRKkFLa5UYS6dIu2W4183dRO7eqbbpsX3Kl/
         d/Bf3f1PnOsPe+kjKYyDhPF1HPS/V2Zo32YA/HxfNkrKveyslZfykWdgOVTHQhP+iUcH
         5NJ87L8w45mYoPBS5/C7HWwXiScmPkm3hjyjhpENnVBfqZeCWr1iHSnma9wbxTHfDI75
         Bfws+86BWcl+KaguMB559XnRrBINkxyUVe0Vmnc+8ay6vR1Uu37dp4g8zscQWg4ufQgY
         4Psg==
X-Gm-Message-State: AOJu0YwHJNSWxAU4bM3OWyb97cZEPMnQZQ1AtLQGxwNm0AB2yrQ/J1XA
        u6yldXIsu5tQ2UnXNYAUb4u3EQ==
X-Google-Smtp-Source: AGHT+IETd3bX/He5a3vC5KS58JgFRitZ1HZTBIPqZbrgbbwE0f9wBdGtCYbfHzTtf7J3O+rl/SIdtQ==
X-Received: by 2002:a0d:e607:0:b0:5a1:c610:1154 with SMTP id p7-20020a0de607000000b005a1c6101154mr20541272ywe.10.1696970497546;
        Tue, 10 Oct 2023 13:41:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y129-20020a0def87000000b00582fae92aa7sm4650659ywe.93.2023.10.10.13.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 29/36] btrfs: pass the fscrypt_info through the replace extent infrastructure
Date:   Tue, 10 Oct 2023 16:40:44 -0400
Message-ID: <3b71dffa339c14a6c973ed5a29a5ca4b879ce847.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prealloc uses the btrfs_replace_file_extents() infrastructure to insert
its new extents.  We need to set the fscrypt context on these extents,
so pass this through the btrfs_replace_extent_info so it can be used in
a later patch when we hook in this infrastructure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 ++
 fs/btrfs/inode.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e5879bd7f2f7..f5367091c0cd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -374,6 +374,8 @@ struct btrfs_replace_extent_info {
 	char *extent_buf;
 	/* The length of @extent_buf */
 	u32 extent_buf_size;
+	/* The fscrypt_extent_info for a new extent. */
+	struct fscrypt_extent_info *fscrypt_info;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 87b38be47d0b..99fb5a613fb8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9714,6 +9714,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
 	extent_info.insertions = 0;
+	extent_info.fscrypt_info = fscrypt_info;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-- 
2.41.0


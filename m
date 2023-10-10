Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3C7C417E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjJJUlc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjJJUlT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:19 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D778E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7af20c488so21279327b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970475; x=1697575275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=teVsTdd4szHuSRdAaNWifrVhPc0k+riHYOoxOIcXixJ1Pi3Td8JeeeCXNo4q9g5WUn
         v1AKOcL2oFVDu9/8hxxFVtbIRuqpUoQsoNQzTZVcu9ssfciuMfaDx3JEKgLZARSmr6Yt
         JbmPBz8CAp6q7Op9jn2+UXVkiBZGqNb+b4I3DGV774kVSXdU+/dFkAY6uQDwa1QuU5Z6
         8Tx00Zq6u5vUYat5llAyLrRANOrrQqMOn/MKcB8/D+c4uLtoKzunrelxVxiZ4whDSBMz
         yv6/ro5N+jE7wepdeNgiVWcX3wf6KR+JqX3l7v4ohjZ2tZOML2LpT4GFMErikp88/FOd
         FeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970475; x=1697575275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=VebNOGNvGXM9i/JFzue/rSmQTQDd31OeTjkDfHenMcanRzyf+hsekB578yjQUD5NOe
         fnVeURSyZ8QlSxn0UAYkcL3SC00JJKdrsx4JLanApaJz4oGSZEjO1i8QbOoGrJef/koc
         4bMRkznGu7iY9pw9Eg62yFNG5hXQatwLf86ZR7WfqI1Y4avsBZqSfpVgogT0Eg/tclrw
         NGkfvIpk7DZHkMw57sQ3TIC7Nu9+bqooq9p0/71Wrdoo5yUnCKpYUkeuZN3klnA7y8JA
         RIl/iMfcU01GPeDLHGHOYzzu7512J0HwYSS06EEFGzdP1Jj1dW3EMQcaN7bbutmRfOG1
         dZag==
X-Gm-Message-State: AOJu0Yzk24NoFXtKVlEvLqi5A8ZumwNLW3Nh1inaJFOR61BxEwgY5Ofj
        AzrtvTdawF0x/k14f77Y/WPG2Q==
X-Google-Smtp-Source: AGHT+IF2iWI7A9wE0CIU+MsdZuyW9o5G9Md2jSIowPav1/vMVNXMclVs/CcYmtHAA5wT5BpHhVF6Aw==
X-Received: by 2002:a0d:d546:0:b0:58f:a19f:2b79 with SMTP id x67-20020a0dd546000000b0058fa19f2b79mr20759539ywd.9.1696970475587;
        Tue, 10 Oct 2023 13:41:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x132-20020a817c8a000000b005925c896bc3sm4700587ywc.53.2023.10.10.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 10/36] btrfs: disable verity on encrypted inodes
Date:   Tue, 10 Oct 2023 16:40:25 -0400
Message-ID: <f61fb12657e5b29a27c73dc3b5bd175aaf4269ee.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Right now there isn't a way to encrypt things that aren't either
filenames in directories or data on blocks on disk with extent
encryption, so for now, disable verity usage with encryption on btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..92536913df04 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -588,6 +588,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
 
 	ASSERT(inode_is_locked(file_inode(filp)));
 
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return -EINVAL;
+
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
 
-- 
2.41.0


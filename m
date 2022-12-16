Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE064F23A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiLPUQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiLPUQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:05 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FC126A99
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:04 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j16so3614411qtv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GkiNo3NR9t33fSWOy/HJNs3H68iO1PgIyTU5GI5al0=;
        b=Lgx+NQTAJYzKMgV61dcgWlKQgOMRC+9v2Bnbelhh7YlG8H9WHy5gBEILMAopKEBFzu
         tcRJzRfwMwwVMF185ZhvCxDhWFHEVqjrHvDI7Px4QjPYpHog/HpNxc7NjvUcpapwvy2h
         12I+B5cPiGKAYhfMZlj+dLtVoP4W3aYaUGXmYehhm2vProa9NtckIBDbkOBxlZVtuk8f
         g3BJWgusPNooDp83d+kTRF4tGywJCm04e6D7qwEmFJ0vs0fRN22RAt2/rDs5skLCC5H9
         GWZdQz++WpanU7uQIPYzTGIpobp6mDEwEJxJPxTu3UCcXXdf6Ge+UdnGqJPLAMmfcdmJ
         +oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GkiNo3NR9t33fSWOy/HJNs3H68iO1PgIyTU5GI5al0=;
        b=eC7OrYAD3dllGwaOtOiQDCQCKNxZOIatKE+sGTKGYNjH+k0VT+XzoUOjRf6zBdK9n+
         EpePj1dbfKAv5sa1WlA4q1dIaTVACgSakY5WPIp6VjMdtsMZiQkR5wQKnE8bqicStRaY
         u6Pbn4JZiD6hcvXg6Cabz3gWGePAERizNlf3S2UPpBrNve3PVnz7oFaNziFMooyQNuzp
         ll/bAkKEDgBKF3pxbshK1ZSiaKrtfpzqey6FP7x66GQPtO51PGAuGXWPGwzmA1ohrc+8
         nUv1N4VrxvjzcVH8XCsGLmgNxgEE7pBgZJRcnLM7JUOPCpD+z8UNBl9rIuS7rAs3Givm
         3Hzg==
X-Gm-Message-State: AFqh2korrBz9isOhSwF6WYXxXPw1QyuBVCzufgKSVDoY4UPuM4Wu5VR+
        cvO/r9iXG/BrHAms8Y5+K+tWt8pdk5HJnVUhZr4=
X-Google-Smtp-Source: AMrXdXuh9W4z56o1VejOBA7FKJwDRjUgUSJeZ+ZigkrJC3rhs4+A+gT2rqcL5QExqo5lVFdNSjhryQ==
X-Received: by 2002:ac8:45da:0:b0:3a9:7cb5:3669 with SMTP id e26-20020ac845da000000b003a97cb53669mr219284qto.32.1671221763500;
        Fri, 16 Dec 2022 12:16:03 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bq17-20020a05622a1c1100b00397e97baa96sm1888138qtb.0.2022.12.16.12.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: fix uninit warning in btrfs_cleanup_ordered_extents
Date:   Fri, 16 Dec 2022 15:15:52 -0500
Message-Id: <8224d05027554e265bb92bd4a7862950e6c7d224.1671221596.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can conditionally pass in a locked page, and then we'll use that page
range to skip marking errors as that will happen in another layer.
However this causes the compiler to complain because it doesn't
understand we only use these values when we have the page.  Make the
compiler stop complaining by setting these values to 0.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 905ea19df125..dfceaf79d5d4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -228,7 +228,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 {
 	unsigned long index = offset >> PAGE_SHIFT;
 	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
-	u64 page_start, page_end;
+	u64 page_start = 0, page_end = 0;
 	struct page *page;
 
 	if (locked_page) {
-- 
2.26.3


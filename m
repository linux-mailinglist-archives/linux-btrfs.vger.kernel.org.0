Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579458E28E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 04:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfHOCFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Aug 2019 22:05:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40544 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbfHOCFm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Aug 2019 22:05:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so885171wrd.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 19:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1H52962HKOogizm6mLBEXWdEZQsuXzDdtHnWo2nn3k=;
        b=IWWRmMSRz/HXqH9TLO8hDlLbCvUMgXxUROeB6GA6oHeSTVD1Otfu0SmBAZI4VMCKlK
         dI8eQljgeBU8LH/9CnHxR0GSQlV6gjOFgti//mMSxECXazzxvZvWdGDVCF7o0l5Nms/3
         ezJeMRE+xZZj3BVYMW9wsTrXWO59LfrL+q9sbuHz4/FPZC7qKZQ1901w2agxqTHZXma4
         9La7lH7+MH9q0EhXV4MHO5/RzpEG+D+ylKC6INBwdDcPymwn6IX8DtP7L5zBfaBPDcDH
         1jp3cwfOeafI1+K7vM1N5a7B98KRaPCPXxyV+MZUNprd1LYzbvJlRZTr6mJVqABnC5NK
         9apQ==
X-Gm-Message-State: APjAAAWcGOk9kUQ38MxlWDxgS7WQTY8geC11Rz35GYR4PHDN6iEkaZzh
        r2LxpoqLG2fPndV2UKOpIDyTcPqsj1o=
X-Google-Smtp-Source: APXvYqzwSZSLBe3VXD17vLX+31JIIVcmYVqH0EPLQ7zOgRII77C78davmzAr85VgrLZ8diivnK4iPg==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr2364070wrm.83.1565834740394;
        Wed, 14 Aug 2019 19:05:40 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id i93sm2130676wri.57.2019.08.14.19.05.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 19:05:39 -0700 (PDT)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH 1/1] btrfs: Simplify parsing max_inline mount option
Date:   Thu, 15 Aug 2019 02:04:53 +0000
Message-Id: <20190815020453.25150-2-git@thecybershadow.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815020453.25150-1-git@thecybershadow.net>
References: <20190815020453.25150-1-git@thecybershadow.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

- Avoid an allocation;
- Properly handle non-numerical argument and garbage after numerical
  argument.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 fs/btrfs/super.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f56617dfb3cf..6fe8ef6667f3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -426,7 +426,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags)
 {
 	substring_t args[MAX_OPT_ARGS];
-	char *p, *num;
+	char *p, *retptr;
 	u64 cache_gen;
 	int intarg;
 	int ret = 0;
@@ -630,22 +630,16 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			info->thread_pool_size = intarg;
 			break;
 		case Opt_max_inline:
-			num = match_strdup(&args[0]);
-			if (num) {
-				info->max_inline = memparse(num, NULL);
-				kfree(num);
-
-				if (info->max_inline) {
-					info->max_inline = min_t(u64,
-						info->max_inline,
-						info->sectorsize);
-				}
-				btrfs_info(info, "max_inline at %llu",
-					   info->max_inline);
-			} else {
-				ret = -ENOMEM;
+			info->max_inline = memparse(args[0].from, &retptr);
+			if (retptr != args[0].to || info->max_inline == 0) {
+				ret = -EINVAL;
 				goto out;
 			}
+			info->max_inline = min_t(u64,
+				info->max_inline,
+				info->sectorsize);
+			btrfs_info(info, "max_inline at %llu",
+				   info->max_inline);
 			break;
 		case Opt_alloc_start:
 			btrfs_info(info,
-- 
2.22.0


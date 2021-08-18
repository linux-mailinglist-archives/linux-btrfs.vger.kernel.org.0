Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEF83F0D60
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhHRVeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHRVeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56CC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x5so2769115qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J7c48rIBltLILOiR3QOXWEV2x44t5VLRCHie2U/xfuA=;
        b=YuDMngM6O4/4fVXi1KOr3O+fLmjb4VYtAge/UIQRJUYNQVcwKwOqX04vcYO6zRQKCE
         xpx6nP+L1fQS2zWzCtYIsKLPk5v1MhxpsZ3X15q5H4Vzai6ZqUVMiHtHmLiuir2jZlLk
         j5v7ZU8N1TLwEibQFnepinZt+aMIsCB2VNJpLYvOQMchm6tAwI9A2ApkBCk0N48yOkYf
         7N+bIYyCvKcgWVLN0rjH5kdGJK7KoOSvDpkUFh09BApMZK7CdFhZOl4TG4oLBWyPfaBZ
         NAOlTWq2qJH5TqO+yCsqxAHIdrGFVEiVG0qQRaCC/7H/El+FhMG7Ffu83b1Pt5NJ9F2L
         DcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7c48rIBltLILOiR3QOXWEV2x44t5VLRCHie2U/xfuA=;
        b=BoLVJCE8prIthNGB2WXMhTIP+KEi3Th/JcabHlazYRP3QKiRH7WpLQXWCOSwhIUA5j
         S9QQ/CekWSgkLIl/TPjlW1fZGph45Q0HsVXBVT0wF/HH6kH9+ggIRwmXkkiIYMoAdQlG
         xWwHLE/gXULJAe+Kv/CEl8ay8elm5IxbxQaVYshotiPU6VM4JnCQTmejMwqfg9vyRRfq
         XzchGHbkMSWYlebD9ZefnujmekOCmXKHMUPIo3e/4g0632kSkJpV7mtHI2EJmagwIza9
         UzUsJtioiApeh8MwcqUalrrzfZDb1MN5st44yIT0nXBhDOcGzhTiwgIZBjt3OvyeeI2q
         SkFA==
X-Gm-Message-State: AOAM533Ok9MGaDPGCcBNGnSWUG/FTUmvf9BTrS/MLLlLj4k4sD6guDg9
        7JyeGBRP5g9C+MJML9VCdiTznfX943KEZw==
X-Google-Smtp-Source: ABdhPJy/fzPiXer+z99v6inCwYWaSX/klDiJpEhLq9B8x/fhSvlD/yxsrx9OX216IY6DOXgIIe3Nvg==
X-Received: by 2002:a05:622a:586:: with SMTP id c6mr9576325qtb.35.1629322408383;
        Wed, 18 Aug 2021 14:33:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r23sm282109qtp.60.2021.08.18.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/12] btrfs-progs: fix running lowmem check tests
Date:   Wed, 18 Aug 2021 17:33:13 -0400
Message-Id: <45ba3fd15ba81f18136d9f6a7e10e7d6bc2422d5.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When I added the invalid super image I saw that the lowmem tests were
passing, despite not having the detection code yet.  Turns out this is
because we weren't using a run command helper which does the proper
expansion and adds the --mode=lowmem option.  Fix this to use the proper
handler, and now the lowmem test fails properly without my patch to add
this support to the lowmem mode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/common | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/common b/tests/common
index 805a447c..5b255689 100644
--- a/tests/common
+++ b/tests/common
@@ -425,9 +425,8 @@ check_image()
 
 	image=$1
 	echo "testing image $(basename $image)" >> "$RESULTS"
-	"$TOP/btrfs" check "$image" >> "$RESULTS" 2>&1
-	[ $? -eq 0 ] && _fail "btrfs check should have detected corruption"
-
+	run_mustfail "btrfs check should have detected corruption" \
+		"$TOP/btrfs" check "$image"
 	run_check "$TOP/btrfs" check --repair --force "$image"
 	run_check "$TOP/btrfs" check "$image"
 }
-- 
2.26.3


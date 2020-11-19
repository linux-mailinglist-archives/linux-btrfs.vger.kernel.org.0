Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1112B9670
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgKSPmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 10:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgKSPmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 10:42:17 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD989C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Nov 2020 07:42:16 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so4602337qtb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Nov 2020 07:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4Zm7v/3ra4qwkPrwD7tBM0n+FHNWbVbVV+eivjmDaw=;
        b=ZVPCoCGBn4LjHOV9Tic4LgWEUfthlp1Bcsc/jB6eR/LP8q5vRR18NBAer1gOC435U/
         +9in3WD48HJrVNBZ0Ug4Y5dLwzUToMZPsx/CkC2/c3ccv9htCfcyiTCekjpzaAn1VW7M
         3SyWiuc9DNDxzNnHtQWEk79tlOw1AXxUwsvIYEJ0slZXDrW/hYHReZQ56euOs2KkwPvf
         8GxmbO4BjcuHjZeVHjOccgyPqn+1JyCEQaoHg+Y3TGR0sOAA1zK+hRrxATZLMVCJ1WG7
         mThc37VvOGfqx6Yjgj7vWNY/slWBHSeuB1mV9eFeCzMwy7XZBqQUeM4oFxn4A436QY6G
         YZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4Zm7v/3ra4qwkPrwD7tBM0n+FHNWbVbVV+eivjmDaw=;
        b=NhIAuBD19qZfSijqUZOUDkzvXI53MYkOinkTCyAu1JSVEeiHPan4+seVfZwp7ocD2O
         S6++DrWvP3l0aLKhX/KwVX3QGkT1Ou9+6Ffrozl+J2DMLTz+vl1k8VAoXj6ohjkcmdAQ
         B3d3ToRBQh2ighuNsv7JiL48+SOvtqnuIUSlrKwDMQZOW4SAphWVitP+yAIpppCWRJen
         5nGMC4QwMpw4bY3FQ7rgqHno0v5jx2BosbRaHon3WPWh1doxsz/2wCnQgFAaxe61s70H
         5Pj8QA/a/rFdsqvQep7quwWUx4hMIXrPMWVeXARlw6w384+Gpt5xeFkSNYyMEXXO2LlL
         PnkQ==
X-Gm-Message-State: AOAM533av7rW4s+t4e69gtfAXDi3iYe6BWoLDRwMwTy1jj2IySDUuypK
        yUzuzQY4Ad0/fXplup7W6n0mpXNZ18XsiA==
X-Google-Smtp-Source: ABdhPJybgsAl/a3kdGB2sI76TFVTg38GXol+81IVv9MaJb8EpEXIAlSZUV2LgpSLOf+HcGAUm9zheA==
X-Received: by 2002:ac8:6b06:: with SMTP id w6mr11177320qts.6.1605800535133;
        Thu, 19 Nov 2020 07:42:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u15sm52248qkj.122.2020.11.19.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:42:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: only spit out the parent or ref root for ref mismatches
Date:   Thu, 19 Nov 2020 10:42:12 -0500
Message-Id: <26927d5268dc42db5ba131dd80b190d474bd596f.1605800521.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While debugging some corruption, I got confused because it appeared as
if we had an invalid parent set on a extent reference, because of this
message

tree backref 67014213632 parent 5 root 5 not found in extent tree

But it turns out that parent and the root are a union, and we were just
printing it out regardless of the type of backref it was.  Fix the error
message to be consistent with the other mismatch messages, simply print
parent or root, depending on the ref type.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 69a47b31..345f86b1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3936,9 +3936,12 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 			} else {
 				tback = to_tree_backref(back);
 				fprintf(stderr,
-"tree backref %llu parent %llu root %llu not found in extent tree\n",
+"tree backref %llu %s %llu not found in extent tree\n",
 					(unsigned long long)rec->start,
-					(unsigned long long)tback->parent,
+					back->full_backref ?
+					"parent" : "root",
+					back->full_backref ?
+					(unsigned long long)tback->parent :
 					(unsigned long long)tback->root);
 			}
 		}
-- 
2.26.2


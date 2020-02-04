Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255A7151C3E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgBDOcu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 09:32:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37181 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgBDOct (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 09:32:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so14429356qtk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LbIHKUd9yagPoYuBNbWFIwxiAchAVleBzOuiRFZQeEc=;
        b=mmnwvE7Z9gACuzLIELZQwzeqGfT4gSWMv5PrvdgtcH03PVk0bb19fUkRKCuEBCnKVG
         hiquw/XBglvMqMU4erQLtGZKI2Ju3YUIYTQo93ix0ba5aKP4gbmUO/j3pzyeQyN/XnGe
         dLXs3BybuaOS2SrLxUZJVXiVKAjuEk37XMkRYlAk76ptDMIRkItLoWG0rx9pMi+XG1wz
         E2xUHxusHhhrW9niaKiFjRaSiZsZ2OXu8Q/egAfI1zvBp+HV1dxGuMo++4LYBhjHbkKp
         HA/QR2H8Lc4M2VjgjlfFDCTMxeUXXY5TMHAM2u3Xo4YjKLW4C+tvR/uqT+Jq69JK/k79
         NCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbIHKUd9yagPoYuBNbWFIwxiAchAVleBzOuiRFZQeEc=;
        b=UECgpT7782yVViGVfGqVrj0seHsUGSQ8y5dCmmdVwN0ZUty12qnVV6Qj6CrUgDRZNo
         8lXqEqJEhcZNeAnk1BzfhxRWJ5PN72Bai2BydH0x/Gds3M2s/b8//I9MItSIiwn3S2/G
         U38JpKFgj6014rnihgoVujoRYeaj/hyGQ8jeo+Uiro+r2my7CqHu8+ItmRvn7B8bWkA+
         etoiiFB+5iQzaVzLyRgJx/NP95jDMzEGgBojNw4KUTzpKiH51HySOtGrSZyU1GDf7GnK
         ZTOVU7kJn3nIR6UncbPSOfhrsvn4M3+Eghd9eZrIMduUp7+xJY4//QV2N+EkZxsw926t
         Vavg==
X-Gm-Message-State: APjAAAXHIXbRQCKT/Bf1WhZgrr69BHZVhmnQqUpAlGtMc8ATZG1q5Iv1
        QP2oAoM0SUmoe/nDwzNUehnWBZwBcHIrXg==
X-Google-Smtp-Source: APXvYqypKj2CQmwDzOEzoA4ugvIgpiSDFeFOv62t2YuRO1JcOPOQ5juJNMTAZ2GhmTX3rYBOgLPr+w==
X-Received: by 2002:aed:204d:: with SMTP id 71mr29026753qta.116.1580826767481;
        Tue, 04 Feb 2020 06:32:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h12sm11697108qtn.56.2020.02.04.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:32:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: fix check to catch gaps at the start of the file
Date:   Tue,  4 Feb 2020 09:32:40 -0500
Message-Id: <20200204143243.696500-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204143243.696500-1-josef@toxicpanda.com>
References: <20200204143243.696500-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When writing my test for the i_size patches, I noticed that I was not
actually failing without my patches as I should have been.  This is
because we only check if the inode record extent end is < isize, we
don't check if the inode record extent start is > 0.  Add this check to
make sure we're catching holes that start at the beginning of the file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 4115049a..22f4e24c 100644
--- a/check/main.c
+++ b/check/main.c
@@ -827,8 +827,9 @@ static void maybe_free_inode_rec(struct cache_tree *inode_cache,
 		/* Orphan inodes don't have correct nbytes */
 		if (rec->nlink > 0 && rec->found_size != rec->nbytes)
 			rec->errors |= I_ERR_FILE_NBYTES_WRONG;
-		if (rec->nlink > 0 && !no_holes &&
+		if (rec->nlink > 0 && !no_holes && rec->isize &&
 		    (rec->extent_end < rec->isize ||
+		     rec->extent_start != 0 ||
 		     first_extent_gap(&rec->holes) < rec->isize))
 			rec->errors |= I_ERR_FILE_EXTENT_DISCOUNT;
 	}
-- 
2.24.1


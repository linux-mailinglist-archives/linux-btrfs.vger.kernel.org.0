Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7B87AFC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436487AbfHINSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:18:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44350 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436470AbfHINSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 09:18:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so64652333qtg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3Ij5CKQxd1szM47xgEJ1ofxwbi1G5qVXxyDlH0FL7E=;
        b=G3gsMmx+VYHut3M72TTssXnLOUQ6OuTvRLeiAifMVLIPdZh8AtFUqLj2eahf7X/rA3
         02G7P+cUVKftcrJEfMLcPF0mckc/3gfk2Tz9nzJ0gGnWK616z2DKTsINCGNmpuZXVWP3
         n7vq8JzAGkD0hBfHCdmawD0KBETVB9QTaRJgSRo19N6PCpu82RXbJySbDuR0F/iXrGsY
         0pvcf9dCXBebIc7VWMLx34xxZ1ewZJqggWzaOswEBZmugKjQcQpNjGjvVRaiwk7kTzwi
         tJgLqhfHpCR+VDxXebc2Rt81AVF+qoJlJOhzVcZRIrQpOgMRXtGgVjJSSx9Uo2dVzqHo
         zSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3Ij5CKQxd1szM47xgEJ1ofxwbi1G5qVXxyDlH0FL7E=;
        b=IrLwJiOrAT6qMod/iEByrVZZmBThVha/L8twaOLn/oNSb09Wk7dLv8pW4DrknbjFXr
         Qd+VVGpFI8QC0XJ0RrWpqgVehwZbSQGpqzx+7O2wOKiJQPa/48K0Nkox0xiyhqhhWev6
         YOsiVmuRMaxmVEu/vtCUT3jGEOOWOi72s3gbGxIJtGliK00X0yvO1o/NHRUndkvk+FP5
         oWcbsN4QtVf/YZ3rmu0Qvf6gfwjhS801lBqmDmo314ADgCskUMlQONLR8ho4P97ex/R+
         vBxdT9EduqljclsHCfZB9N4wDZtrwlFUYBfik9FH+lvQ2LWV5Ccw/L+Kp3nfi1b1n8CZ
         3u+g==
X-Gm-Message-State: APjAAAWQukHOFdOfwNtI91EwSB+PPaRdG7gQBMrq1Ya9L6s78pzpV5U3
        mg3wvFjJUSFds3KQTWITHe1uKx5vKS9TAQ==
X-Google-Smtp-Source: APXvYqy50irYRtPENug9+rrFHwMuxBhEuyxoUwWU0e9fNAhc7UqU9Si3zBRyKTo7T31O9vO3IDfq+g==
X-Received: by 2002:aed:3b94:: with SMTP id r20mr17539118qte.207.1565356713782;
        Fri, 09 Aug 2019 06:18:33 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j50sm4537393qtj.30.2019.08.09.06.18.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:18:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: don't check nbytes on unlinked files
Date:   Fri,  9 Aug 2019 09:18:31 -0400
Message-Id: <20190809131831.26370-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't update the inode when evicting it, so the nbytes will be wrong
in between transaction commits.  This isn't a problem, stop complaining
about it to make generic/269 stop randomly failing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index ca2ace10..45726e6e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -807,7 +807,7 @@ static void maybe_free_inode_rec(struct cache_tree *inode_cache,
 	} else if (S_ISREG(rec->imode) || S_ISLNK(rec->imode)) {
 		if (rec->found_dir_item)
 			rec->errors |= I_ERR_ODD_DIR_ITEM;
-		if (rec->found_size != rec->nbytes)
+		if (rec->nlink > 0 && rec->found_size != rec->nbytes)
 			rec->errors |= I_ERR_FILE_NBYTES_WRONG;
 		if (rec->nlink > 0 && !no_holes &&
 		    (rec->extent_end < rec->isize ||
-- 
2.21.0


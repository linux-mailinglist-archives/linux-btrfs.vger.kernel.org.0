Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4324F419DCF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhI0SHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbhI0SHJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:07:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EDC061740
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m7so20940946qke.8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KeItr4l2pcJk3E61qcbEVPtp48CLKSQAvi6b14/8UF4=;
        b=s4hSyvyf6XNOL9/p8QcnDITEyUQ0bizBInmgaNJr92pWg3G7j3SCSTv5zZFbuJrBaB
         2gWVoUvET8cmM2goeVuuRFefjK0YqGnnIuI5w6fBW5FTm12SIfQaQGfEIDLdtcFKiWX8
         snS5Eh/xEj2x0jSdKGeUL6Y73VSEjlUd/62lLOLXwKEE8+4wDBpvpkvxgYxO/6xBfz/4
         UTS7sJxMwMGUMPXZ/SHk99vGVc1N/PlZHI1QHZBYAecPuHiFdSgxSmCp9a9RPUx25tBp
         Ii7HXwXQRVFs6S3i2xm+RJF0MdNIYoVZmqeCaoDuxjgNbDmt84Voe4aNnVaZiGzdWByE
         26Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeItr4l2pcJk3E61qcbEVPtp48CLKSQAvi6b14/8UF4=;
        b=zeV1Fo04MFxLZFiYDosO692gYSCIC2QrsL+SxHrFTEGW1xdd4HeKItzwW33Xgn7AHs
         fiCYazWromKo8OgyKKS30bmlWvBMwb/0nwb0bs5JfAgIt7khUdVhSadCR6Ht5eSuLRXB
         HNv0cM1DCy9EU5+PCuvZ6LAvor8afBqjR939sHLcf/QLjK2p2RaLbI2EVUoa5Pn5/PEW
         beKlnF9wOZ2iY0NO5ffNFhMLZxkl5IRttewbPp2c5uesUYey+aF8WCT1vG/OZTbjJNbT
         bdIbR8bwgYCRPOBFt1pVGN6FrH2qf3G1nZ0kptk8K5FleWpE70eTYcJJRgEwopi9hiWP
         C3XA==
X-Gm-Message-State: AOAM531uxEIFkBQ3LlbgNza8HZESxjR4gmJeUf56W0j04VBoC0C5tgR2
        khCwUxDVW39ZMO9wBDqhHIk5u7YtYuiq+g==
X-Google-Smtp-Source: ABdhPJzLAmrhsBUo6vs8CJxPG/8Xsg6+eg4HE7Zt8KeHf9ArPaoQ9FzIDtupELkLKgoME040TuXQpg==
X-Received: by 2002:a37:746:: with SMTP id 67mr1268416qkh.465.1632765929788;
        Mon, 27 Sep 2021 11:05:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l28sm12827279qkl.127.2021.09.27.11.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:05:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/5] btrfs: fix abort logic in btrfs_replace_file_extents
Date:   Mon, 27 Sep 2021 14:05:14 -0400
Message-Id: <6d8adc363ee08747d4e5ee2f521b1e0e155516a1.1632765815.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1632765815.git.josef@toxicpanda.com>
References: <cover.1632765815.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error injection testing uncovered a case where we'd end up with a
corrupt file system with a missing extent in the middle of a file.  This
occurs because the if statement to decide if we should abort is wrong.
The only way we would abort in this case is if we got a ret !=
-EOPNOTSUPP and we called from the file clone code.  However the
prealloc code uses this path too.  Instead we need to abort if there is
an error, and the only error we _don't_ abort on is -EOPNOTSUPP and only
if we came from the clone file code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fdceab28587e..f9a1498cf030 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2710,8 +2710,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 			 * returned by __btrfs_drop_extents() without having
 			 * changed anything in the file.
 			 */
-			if (extent_info && !extent_info->is_new_extent &&
-			    ret && ret != -EOPNOTSUPP)
+			if (ret &&
+			    (ret != -EOPNOTSUPP ||
+			     (extent_info && extent_info->is_new_extent)))
 				btrfs_abort_transaction(trans, ret);
 			break;
 		}
-- 
2.26.3


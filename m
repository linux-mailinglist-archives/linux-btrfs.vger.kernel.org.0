Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BC15C47A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 16:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgBMPrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:47:42 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37437 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387954AbgBMPrk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:47:40 -0500
Received: by mail-qv1-f68.google.com with SMTP id m5so2814938qvv.4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 07:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJuMZhJ5ecpuzOM5SSHGH0NirU904GzOSGEgGaVuNEY=;
        b=jUsYbuZTYCEMy/FUA5A9PTnuo2E4TYgWzW7YckGoya/9ZX8/0+UPzOgXe0TaiUM47W
         VAxBn1LNP0iF4DvlAEVOjAjOijtDem2NAxGnAsOgisFHLJebtHhJjMO5rvhDnOKsH1AN
         cIJn5wLv8QBc+34o7CGuNSft6Lx5x+P8bNrZkCkmkzFgbwTISELPjloO0VDgFz1Mb0hI
         jd5TrNNehSVkhsl8fmqgOPtfW3w+boiv+uRhYjbA/nomaCsQ9hTGrJ6S6BtIqrwSKHzr
         6vtUs5SIWTVnRO5slADEgizHsRHieRvROT/zNiVxCajjCWWlZQy12KDyMzZMY0qH/lCx
         W/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJuMZhJ5ecpuzOM5SSHGH0NirU904GzOSGEgGaVuNEY=;
        b=ke1pVJVIigcDN19D6rMz16FrrD0OqbOJMYAnJ1Mdk0Hd2g30GoYwNWSVTunvAVQAHw
         hIOJCmCCBCvXbsckKXjIiEColMRIA/qFsRtkAlFWosNrz2fZBRbtWabTDQIle0rgDDmm
         21XMZ3CBQ8tGTAwddFR3zZ2aiNobBNdulTuL5QV3TDkhXYn528UD7d40kjIUqTnU1A5G
         sTF+sPTaHecMB1f1eVSF2QB5EgkDGObLrNr3SZUlcyIrcLRFstaLFHyOREhcpr2UT69s
         2MTvuygPlzimsQ6e234yGnXby7+OX3tgJDAJXaMw357a9D99eAz5YnMYQSoU/eHrFZgL
         tYJw==
X-Gm-Message-State: APjAAAXK+1M+fIi0uYkmBqPV6ECcnFSyovM0Pi8B22mpC9CTFV2T5YeI
        hqgDCus6HPLUZBOd8m1oDX0Fz+9MElA=
X-Google-Smtp-Source: APXvYqy641CW1DMGwaG/Tpt/2xNZ090Vin7HLAX+eJcJbyI/TpMv9JVUxe42z32U1fOyzXA7fJN5XQ==
X-Received: by 2002:ad4:4c42:: with SMTP id cs2mr12118586qvb.198.1581608859348;
        Thu, 13 Feb 2020 07:47:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z5sm1773211qta.7.2020.02.13.07.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:47:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 2/4] btrfs: do not check delayed items are empty for single trans cleanup
Date:   Thu, 13 Feb 2020 10:47:29 -0500
Message-Id: <20200213154731.90994-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213154731.90994-1-josef@toxicpanda.com>
References: <20200213154731.90994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_assert_delayed_root_empty() will check if the delayed root is
completely empty, but this is a fs wide check.  On cleanup we may have
allowed other transactions to begin, for whatever reason, and thus the
delayed root is not empty.  So remove this check from
cleanup_one_transation().  This however can stay in
btrfs_cleanup_transaction(), because it checks only after all of the
transactions have been properly cleaned up, and thus is valid.

eviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5b6140482cef..601ed3335cf6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4543,7 +4543,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 	wake_up(&fs_info->transaction_wait);
 
 	btrfs_destroy_delayed_inodes(fs_info);
-	btrfs_assert_delayed_root_empty(fs_info);
 
 	btrfs_destroy_marked_extents(fs_info, &cur_trans->dirty_pages,
 				     EXTENT_DIRTY);
-- 
2.24.1


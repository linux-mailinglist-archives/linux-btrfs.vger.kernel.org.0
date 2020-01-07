Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C111132FA9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 20:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgAGTmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 14:42:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40564 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGTmn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 14:42:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id e6so748503qtq.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ieUAFwhIKx4DpFgDaDO4d7DYtH2i4i+TfaHpqbulT6s=;
        b=SX/lKe+JYN+41P66C7lddUJSYYHRW2Z9Ma2+gGT4GwChhumOjZrz9sdPtLXApehbgP
         T83do7elNN3V05xwFV/Bxf6zsj7UxLlD12KW4c/7QiyVYPSMpWn+knHBIPBECSOuiztT
         YHjzUfRtC2mNCk1PGNa/gUqpXpGDs7EbTJz0wId7fkEr2MKTBWvlKbi3C3Rkw2Z+wLws
         qKIndl/Fwr9X5ZCu02lM736wJkEPrk5THMoTvNt5/QiH3is8uWePLGq5sOQeS4BhfVH0
         UC50HVcasGrBFhHiOUDPWlGDva1Vr6XBIpZyjvcM/SFVul6yBDi5iAM/TJVWGXH3XoxI
         XJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieUAFwhIKx4DpFgDaDO4d7DYtH2i4i+TfaHpqbulT6s=;
        b=NLcgAtLcH/726ermYWhFj8IBwYqUKYHZv/kgttrHLo3ZYo7Q0z6Yt1BDArDT7Vwwgi
         KfCzwn3w4tRgDwUoVRyzNuAuZ1VSXOnHiQWwKi8/JXq0NOZW4kiRpFIeaHAaIhB1ZLSo
         ObN4wP6VgvQ6gRKnQY1DN0eBSxnlCgpuJ3rH9YIxJh9lEF0kR3UCYgFODcCJibxFBaLD
         4LMamLv1wEfbcEMYvXHIzDBoWUEWBY3WdWuQZISc0mN6f6rWKkZGMwpGvfSQqLCTV4sR
         dV82rddN+y+jg2xd5opzgTB1JXFTrivN5kWOITFuLreW9HpJrmawr57lCi9Dasg/KLDA
         m66A==
X-Gm-Message-State: APjAAAWMKRD0HNc8iPlKPlhvkbGr7+U9+xg6ijudmkCk36wDCq51ZKmr
        JpLn6dMYS91cryXsMiRaRYWHE1jdXCUG4A==
X-Google-Smtp-Source: APXvYqyope9CWSk1n4NCZmIJb/c+T+tzXEF+a56kjDzzQ+ycCqOgH3INy9i+IPXLLM/3YfrmIo2NxA==
X-Received: by 2002:aed:218f:: with SMTP id l15mr494440qtc.247.1578426161890;
        Tue, 07 Jan 2020 11:42:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i90sm359706qtd.49.2020.01.07.11.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:42:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: use btrfs_ordered_update_i_size in clone_finish_inode_update
Date:   Tue,  7 Jan 2020 14:42:33 -0500
Message-Id: <20200107194237.145694-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107194237.145694-1-josef@toxicpanda.com>
References: <20200107194237.145694-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were using btrfs_i_size_write(), which unconditionally jacks up
inode->disk_i_size.  However since clone can operate on ranges we could
have pending ordered extents for a range prior to the start of our clone
operation and thus increase disk_i_size too far and have a hole with no
file extent.

Fix this by using the btrfs_ordered_update_i_size helper which will do
the right thing in the face of pending ordered extents outside of our
clone range.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8ec61f3f0291..291dda3b6547 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3332,8 +3332,10 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	 */
 	if (endoff > destoff + olen)
 		endoff = destoff + olen;
-	if (endoff > inode->i_size)
-		btrfs_i_size_write(BTRFS_I(inode), endoff);
+	if (endoff > inode->i_size) {
+		i_size_write(inode, endoff);
+		btrfs_ordered_update_i_size(inode, endoff, NULL);
+	}
 
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret) {
-- 
2.23.0


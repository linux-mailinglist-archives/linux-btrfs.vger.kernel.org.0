Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4012B80F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2019 18:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfL0Rmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Dec 2019 12:42:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfL0Rmu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63D021D7E;
        Fri, 27 Dec 2019 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468569;
        bh=q/n2PPch65R2rI8P0F1GiC6a03jcPROWQkGw6IthEwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhhxKT7RffIuuxGSetpilOkYDLjXF43CpWsIizblRYlTSQ3ZQ6NKpZUfxcqkXdqqP
         T8VF8Y3+CcEoRJQdsOKxgNNiwDXPxkeaN4SrF3LiEvqfBKpz4yP0FxCR3guOc8nMvA
         8qyHJ9yAgjQySCPWBe6+jF0mkk8iXSTV/NB9OfEE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 094/187] btrfs: Fix error messages in qgroup_rescan_init
Date:   Fri, 27 Dec 2019 12:39:22 -0500
Message-Id: <20191227174055.4923-94-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 37d02592f11bb76e4ab1dcaa5b8a2a0715403207 ]

The branch of qgroup_rescan_init which is executed from the mount
path prints wrong errors messages. The textual print out in case
BTRFS_QGROUP_STATUS_FLAG_RESCAN/BTRFS_QGROUP_STATUS_FLAG_ON are not
set are transposed. Fix it by exchanging their place.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3ad151655eb8..5ccbc3b6c8f8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3232,12 +3232,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		if (!(fs_info->qgroup_flags &
 		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
 			btrfs_warn(fs_info,
-			"qgroup rescan init failed, qgroup is not enabled");
+			"qgroup rescan init failed, qgroup rescan is not queued");
 			ret = -EINVAL;
 		} else if (!(fs_info->qgroup_flags &
 			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
 			btrfs_warn(fs_info,
-			"qgroup rescan init failed, qgroup rescan is not queued");
+			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
 		}
 
-- 
2.20.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF082873F9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgJHMYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 08:24:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:59496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbgJHMYe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Oct 2020 08:24:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602159873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sV1sF8ixVQfzmAV78oZC+azm3lFs5wHCEAt3QP6A3N0=;
        b=LNOniD3nfEG/xRj394GkkrMNNzgsexFG34CLxr5wU6lO7ow+aMRcPQeeMI+jU57MvJwIUM
        IquTtK4Q6ix8pxTLNA5OO/zFQxbmSYDZpOZ6psHUvMfB7FfmMpmXuvyqKacb0pwAJxyAMs
        DPqph5IrygGLPGOg3rgRoCU76meNLcQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE321AFBF;
        Thu,  8 Oct 2020 12:24:32 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/4] btrfs: Remove redundant check
Date:   Thu,  8 Oct 2020 15:24:28 +0300
Message-Id: <20201008122430.93433-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008122430.93433-1-nborisov@suse.com>
References: <20201008122430.93433-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The value obtained from ktime_get_seconds() is guaranteed to be
monotonically increasing since it's taken from CLOCK_MONOTONIC. As
transaction_kthread obtains a reference to the currently running
transaction under holding btrfs_fs_info::trans_lock it's guaranteed to:

a) See an initialized 'cur', whose start_tim is guaranteed to be smaller
than 'now'
or
b) Not obtain a 'cur' and simply go to sleep.

Given this remove the unnecessary check, if it sees now <
cur->start_time this would imply there are far greated problems on the
machine.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 77b52b724733..b9fbbf66ccee 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1733,8 +1733,7 @@ static int transaction_kthread(void *arg)
 
 		now = ktime_get_seconds();
 		if (cur->state < TRANS_STATE_COMMIT_START &&
-		    (now < cur->start_time ||
-		     now - cur->start_time < fs_info->commit_interval)) {
+		    (now - cur->start_time < fs_info->commit_interval)) {
 			spin_unlock(&fs_info->trans_lock);
 			delay = msecs_to_jiffies(5000);
 			goto sleep;
-- 
2.17.1


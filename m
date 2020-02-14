Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464D615EBC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 18:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbgBNQJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 11:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391294AbgBNQJc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 389AA2467E;
        Fri, 14 Feb 2020 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696572;
        bh=OJ3QoIR3qxJpH00wRqFPDjc6ftqQZW1lGIxutzeBQR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUEtYfAjjlyVFA+5au781zBe0ojTh5q235EJ0WQIXkUK/ZQK3Rro525z1sArHlxeO
         UOIjLzetVBPk8UWOPTDHQYJsG0PRJLzF95DYB54kv5zMmqzvwrEOoO8mAgwIb1JB0d
         u405GLJyB9MiH3sjHEChqFcTavvdTl+VI9sEQ1bQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, philip@philip-seeger.de,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 361/459] btrfs: device stats, log when stats are zeroed
Date:   Fri, 14 Feb 2020 11:00:11 -0500
Message-Id: <20200214160149.11681-361-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit a69976bc69308aa475d0ba3b8b3efd1d013c0460 ]

We had a report indicating that some read errors aren't reported by the
device stats in the userland. It is important to have the errors
reported in the device stat as user land scripts might depend on it to
take the reasonable corrective actions. But to debug these issue we need
to be really sure that request to reset the device stat did not come
from the userland itself. So log an info message when device error reset
happens.

For example:
 BTRFS info (device sdc): device stats zeroed by btrfs(9223)

Reported-by: philip@philip-seeger.de
Link: https://www.spinics.net/lists/linux-btrfs/msg96528.html
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f7d9fc1a6fc2f..9ab3ae5df3005 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7561,6 +7561,8 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 			else
 				btrfs_dev_stat_set(dev, i, 0);
 		}
+		btrfs_info(fs_info, "device stats zeroed by %s (%d)",
+			   current->comm, task_pid_nr(current));
 	} else {
 		for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
 			if (stats->nr_items > i)
-- 
2.20.1


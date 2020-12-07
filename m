Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBC2D0CC3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 10:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgLGJPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 04:15:00 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:36586 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLGJO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 04:14:59 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 04:14:58 EST
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 6F84144AA4F;
        Mon,  7 Dec 2020 11:08:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1607332086; bh=pHC88avoOUcOGdj9kedtyOsO+yRmAMwTo6L2lPXx5CY=;
        h=From:To:Cc:Subject:Date;
        b=P1Y/zvosqpCUVmnqQT/4PqrVES1EjvhAro2CHppRhwUSKsE0IBdOQGlC1bXziq+1a
         KJP03CPymQVTMA+9RuyeuIE4ePpAvE8W+CD/2r2Rkdr8NBFTxzaQ2XEurKypjc0uFG
         4KlUM43iM/ZqQCMJA3yTPF4Kd23+qUjZIa90x6lM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 5B65E44AA4D;
        Mon,  7 Dec 2020 11:08:06 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id nad1YV0PTpXK; Mon,  7 Dec 2020 11:08:06 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id EBC53441EFD;
        Mon,  7 Dec 2020 11:08:05 +0200 (EET)
Received: from localhost.localdomain (unknown [45.87.95.238])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 968A41BE00F2;
        Mon,  7 Dec 2020 11:08:04 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs-progs: cmd-subvolume: set subvol_path to NULL after free
Date:   Mon,  7 Dec 2020 17:07:55 +0800
Message-Id: <20201207090755.16161-1-l@damenly.su>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 6N1mlpY9aTPe6kLDN3bfAwY2rSJKXenj55TE3V0G3GeDUSOAe1YFVw6+mHJ0TnSk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

User reported that `btrfs subvolume show -u -- /mnt` causes double free.


Pointer subovl_path was freed in iterations but still keeps old value.
In the last iteration, error BTRFS_UTIL_ERROR_STOP_ITERATION returned,
then the double free of subvol_path happens in the out goto label.

Set subvol_path to NULL after each free() in the loop to fix the issue.

Links: https://github.com/kdave/btrfs-progs/issues/317
Signed-off-by: Su Yue <l@damenly.su>
---
 cmds/subvolume.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index f153cfa9..a6771d10 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1117,6 +1117,7 @@ static int cmd_subvol_show(const struct cmd_struct *cmd, int argc, char **argv)
 				break;
 
 			free(subvol_path);
+			subvol_path = NULL;
 		}
 		btrfs_util_destroy_subvolume_iterator(iter);
 	} else {
-- 
2.29.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C03A4444
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFKOpL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 10:45:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhFKOpL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 10:45:11 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A32291FD73;
        Fri, 11 Jun 2021 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623422592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MmZZMWflgQsPqPW+01nU3lSzYCLEA9QQvn7lNKNI8/E=;
        b=V2A5QPV3HYOjyHZglYX21LCeIETDpEasCs6gzd/68a60jVltlqBal/3HaNATau1JxMLq6d
        /dP1SaIIBhYgTdKnZGYP1xk7ycS66La4siivuT4dZPQPu9cgos3fSF8ADQcQxCq+ftU91J
        9KIaP2QbwKqHZ301j0GvMMVj1uRIIK4=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2E051118DD;
        Fri, 11 Jun 2021 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623422592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MmZZMWflgQsPqPW+01nU3lSzYCLEA9QQvn7lNKNI8/E=;
        b=V2A5QPV3HYOjyHZglYX21LCeIETDpEasCs6gzd/68a60jVltlqBal/3HaNATau1JxMLq6d
        /dP1SaIIBhYgTdKnZGYP1xk7ycS66La4siivuT4dZPQPu9cgos3fSF8ADQcQxCq+ftU91J
        9KIaP2QbwKqHZ301j0GvMMVj1uRIIK4=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 27WuOH52w2A2fwAALh3uQQ
        (envelope-from <mpdesouza@suse.com>); Fri, 11 Jun 2021 14:43:10 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: quota: Check for args.progress in cmd_quota_rescan
Date:   Fri, 11 Jun 2021 11:43:01 -0300
Message-Id: <20210611144301.10054-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The progress struct member is only set when there is a rescan being
executed, so it's more readable read it directly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/quota.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmds/quota.c b/cmds/quota.c
index 246dd277..2038707e 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -166,11 +166,11 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
 			error("could not obtain quota rescan status: %m");
 			return 1;
 		}
-		if (!args.flags)
-			printf("no rescan operation in progress\n");
-		else
+		if (args.progress)
 			printf("rescan operation running (current key %lld)\n",
 				args.progress);
+		else
+			printf("no rescan operation in progress\n");
 		return 0;
 	}
 
-- 
2.26.2


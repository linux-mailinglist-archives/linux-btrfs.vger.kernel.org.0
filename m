Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881F541F142
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355040AbhJAPbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 11:31:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355033AbhJAPbE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 11:31:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C915D20066;
        Fri,  1 Oct 2021 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633102154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7sOnm14X3GpxsmnBmSGCf5kxvdB4oXH58bZYz0EnLA=;
        b=SjLeAtHW+Go/t7Dpd/aqMpZ6tdRILDBlPMEUh0srPqzL7jY0p0gzRGKZpU7ncAN8Hn8pMC
        7cgFQ3MzKz2YKrElqMwV4lhxxlywjkR3zSYzr8omw+cZF1js6azQuZ0VVu8A9rOHRooewR
        MPLiOe8WeVLHb64m1Sjw7cpa6LgIFZ8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C2AF4A3B87;
        Fri,  1 Oct 2021 15:29:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54156DA7F3; Fri,  1 Oct 2021 17:28:57 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs-progs: subvol show: print send and receive generation and timestamp
Date:   Fri,  1 Oct 2021 17:28:57 +0200
Message-Id: <57bd6dbec9700ff1c310fc5a9256ae7137a4f3fb.1633101904.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633101904.git.dsterba@suse.com>
References: <cover.1633101904.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are some send/receive related data not printed in subvol show,
while they're exported by the ioctls. Print them for convenience:

  $ btrfs subvol show test
  test
	  Name: 		test
	  UUID: 		dc16dd1b-825f-3245-94a8-557672d6cf85
	  Parent UUID: 		-
	  Received UUID: 	-
	  Creation time: 	2021-05-17 16:17:14 +0200
	  Subvolume ID: 	19112
	  Generation: 		7730702
	  Gen at creation:	7730701
	  Parent ID: 		5
	  Top level ID: 	5
	  Flags: 		-
	  Send transid: 	0
	  Send time: 		2021-05-17 16:17:14 +0200
	  Recv transid: 	0
	  Recv time: 		-
	  Snapshot(s):
				  test-snap

Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/subvolume.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 0b00f9601ebe..3d8db249d376 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1411,6 +1411,27 @@ static int cmd_subvol_show(const struct cmd_struct *cmd, int argc, char **argv)
 	else
 		printf("\tFlags: \t\t\t-\n");
 
+	printf("\tSend transid: \t\t%" PRIu64 "\n", subvol.stransid);
+	printf("\tSend time: \t\t%s\n", tstr);
+	if (subvol.stime.tv_sec) {
+		struct tm tm;
+
+		localtime_r(&subvol.stime.tv_sec, &tm);
+		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
+	} else {
+		strcpy(tstr, "-");
+	}
+	printf("\tRecv transid: \t\t%" PRIu64 "\n", subvol.rtransid);
+	if (subvol.rtime.tv_sec) {
+		struct tm tm;
+
+		localtime_r(&subvol.rtime.tv_sec, &tm);
+		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
+	} else {
+		strcpy(tstr, "-");
+	}
+	printf("\tRecv time: \t\t%s\n", tstr);
+
 	/* print the snapshots of the given subvol if any*/
 	printf("\tSnapshot(s):\n");
 
-- 
2.33.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC94828E7
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 02:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiABBuY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 20:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiABBuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 20:50:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A1C061574
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 17:50:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x6so14829829lfa.5
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jan 2022 17:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQmVDNbbV9a+1iShDMtfaLaHvrSLwU26UCHwRxqks/w=;
        b=VIVoxVAzeN0jkGD5I0U020E3A3YseShQiL7UL2a2OCwowq/2u0pg/2P57AWhv6H2+h
         A7D/S9WcKIs+ibPGGVyZvKzpjnuOUXOkycIoEO4W6+PRIK2twFcakrGleGwsfmvwAWxa
         G2qZ0T13Xl1nVsrB7/b+2PnSZ9ZxGTQqlDYU7r7uKLT6Dpotd8N3Oqwd0wg4e8baaiPq
         cVoWTdZcwUQw9b77AQCH+HTI11z/tV/eIE0Li+MyKnPCwaMq7rnvJroadIsvvALTTxmq
         NXNaovAchUqxnCVPRdBMdJNe53F9e3lZUqRzgoLwR8nyKqX+oOgCYBTA5DrVyYgtkwOJ
         hqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQmVDNbbV9a+1iShDMtfaLaHvrSLwU26UCHwRxqks/w=;
        b=pu2Wv241z+ZX4bCgOqv6bhhwrFn9ONKM7odsJX1m9Dc/4gnzmKc7JhLOZNYOLvayHr
         cMOKVrR6i9fZWaW1EzZw1w+6wGLSrqZQXb24Uwat5TRiT96IDgj7F9iahkc/cy/NROOS
         UvkN1ARcyM5EFgf6LRfj8rqIPa+U3C7M2mGQhSGIk7XyqwKGuyeUWairdsmObtvpOjGc
         aFgraM8AmCqbBFzUSp2gXxZGOz9Zng6Dtto1v+LHbRdu3IQrsu/mJ35JLU4HfpILGJCN
         BZa6KvtpIeiMdL4CFx3WXWN5ff5AFll/EGSrCrByMBsxZJqPQb87A8iKIeIQFqERPMw1
         2jGg==
X-Gm-Message-State: AOAM532Cl2hM/FDFFnI/5MY10UWYFulTrTfF43lz7LYQ0AsOTm3dpcDn
        tca00IQIqDTuFQNLO1bmGWwlXkGXWLATNQ==
X-Google-Smtp-Source: ABdhPJzk8kJzTmreKylb0n7vbQwG2PbprvJgxoowS5EpATh3epjuyfaPnZdRGZqV/xaUeCUfgdEsNg==
X-Received: by 2002:a05:6512:2626:: with SMTP id bt38mr36655899lfb.255.1641088220134;
        Sat, 01 Jan 2022 17:50:20 -0800 (PST)
Received: from ArchRescue.. ([95.68.95.192])
        by smtp.gmail.com with ESMTPSA id bq30sm816233lfb.222.2022.01.01.17.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 17:50:19 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] btrfs-progs: process_snapshot: don't free ERR
Date:   Sun,  2 Jan 2022 03:50:16 +0200
Message-Id: <20220102015016.48470-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When some error happens when trying to search for parent subvolume
then parent_subvol will contain errno so don't try to free that

Crash backtrace would look like:
0  process_snapshot at cmds/receive.c:358
    358		free(parent_subvol->path);
1  0x00005646898aaa67 in read_and_process_cmd at common/send-stream.c:348
2  btrfs_read_and_process_send_stream at common/send-stream.c:525
3  0x00005646898c9b8b in do_receive at cmds/receive.c:1113
4  cmd_receive at cmds/receive.c:1316
5  0x00005646898750b1 in cmd_execute at cmds/commands.h:125
6  main at btrfs.c:405

(gdb) p parent_subvol
$1 = (struct subvol_info *) 0xfffffffffffffffe

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 cmds/receive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 4d123a1f..d106e554 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -354,7 +354,7 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
 	}
 
 out:
-	if (parent_subvol) {
+	if (!IS_ERR_OR_NULL(parent_subvol)) {
 		free(parent_subvol->path);
 		free(parent_subvol);
 	}
-- 
2.34.1


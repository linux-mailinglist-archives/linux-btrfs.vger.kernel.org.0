Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A6489716
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbiAJLOD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:14:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244506AbiAJLMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:12:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D742C1F393;
        Mon, 10 Jan 2022 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641813123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c6QGuJuD6F8ncxnpiB0AKVDl2FdeiGh74Y4HAVX383o=;
        b=i5LMGdAZY1s8vHWupOzS0YDDxXnyTs+RRB0Sa6EOWOEmnk8o5xuto3ykmz+JB38uMX5MV9
        fWmUTa1Bu9nUYS4mWzMEhYYCFAwM/tczmNDBNBOg4m+CHsn2lItspuOt1wwtbZHdETFSr8
        AVBkD+dLqhZTYGVGFarfBQ97s9NSBkU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F02C13D2A;
        Mon, 10 Jan 2022 11:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LVLcH4MU3GGGaAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 11:12:03 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Chris Muprhy <lists@colorremedies.com>
Subject: [PATCH] btrfs-progs: Don't crash when processing a clone request during received
Date:   Mon, 10 Jan 2022 13:12:01 +0200
Message-Id: <20220110111201.1824108-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If subvol_uuid_search can't find the clone root then 'si' would either
be NULL or contain an errno. The behavior of this function was
changed as a result of commit
ac5954ee36a5 ("btrfs-progs: merge subvol_uuid_search helpers"). Before
this commit subvol_uuid_search() was a wrapper around subvol_uuid_search2
and it guaranteed to either return well-fromed 'si' or NULL. This was
sufficient for the check after the out label in process_clone.

Properly handle this new semantic by changing the simple null check to
IS_ERR_OR_NULL which covers all possible return value of
subvol_uuid_search.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reported-by: Chris Muprhy <lists@colorremedies.com>
Link: https://lore.kernel.org/linux-btrfs/CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com/
---
 cmds/receive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index b4099bc482b2..16b9b4a853be 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -794,7 +794,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	}

 out:
-	if (si) {
+	if (!IS_ERR_OR_NULL(si)) {
 		free(si->path);
 		free(si);
 	}
--
2.17.1


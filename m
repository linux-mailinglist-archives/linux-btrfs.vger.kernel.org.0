Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3717E9EA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgCIUXc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:23:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36578 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgCIUXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 16:23:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so8068904qtb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uLTPLOeB90UMR5FAKL/IUJ5HHEgSN+N4ETJQO4JMGnI=;
        b=ZufC7zestyphZVD7j0QowvzbINZ+0/qNVue8qNdnk1xuSbqYtXyi5pyM2lxE02QRi3
         /yqIO3Ait2dWtQ63AUpAXgks3qPGewNmdwTvqyPtMWfcpPKBC+Q3fLngEbZ3LOroD6ng
         I/V9QoCZau7rtZ2KqIy84G0FqkWzNGwBe0CeOJLENPVibXE84tsdwFEybWkU4I1WUuLk
         0gPbW6wr5ZUvVxtg2RqDXZtU6B6A80LdKwyZSRYs5ZaS8HG2cUCyDRb0Q8VGCOm2CJXj
         otXMbB4eXb6x6JueTOG1IdT330A6VJQ88dmlY0axx21Zff6q3X14u4jsneARcDrbkl8o
         VVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLTPLOeB90UMR5FAKL/IUJ5HHEgSN+N4ETJQO4JMGnI=;
        b=jYOVZNEeX1RIqnhNeTWJWkZAapaYRKrgc/EBNLFejrjUKWuViChXba232zmZLefmne
         5wiGLv3occNW3Af6hltW4QVBOErUTtrejkxMqVBVNRAO3fGf43qmEcj48vunWqdC9tod
         O8Z5nTZV9UUyG10Ef3ZnhqaOO8cA0AmyBXH6I2eyZdkw0P+XjIUAoH9DuB0E+lHxL9Cx
         ofFm8PHiQ0pKmRE1l06FjBy5dHctyQxKtldhCDQg6zoVXRS4u9WOKriAZg0PSqAq0+kj
         oAzCIWtT2NA6fayc4rUYdSEQrSmE9eFk9rYEk0cw35+U5wPzwJ8FLdyRu3DR+ZiFnbTZ
         U3tQ==
X-Gm-Message-State: ANhLgQ2+8977OvKF32sWdhSLbaHeVPegZ8MrsUSpgqqPVS+zEaE23MIY
        C6LzXTNQqlX2tKAO8iwVxE+Lq2/5+Ws=
X-Google-Smtp-Source: ADFU+vvQfKssgiyNSOFvkadHUy0UXPfVlPlQv9aIoSCuMCbYucFa8BOlVCPnOlV2kM3dbYKvbZ7WRg==
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr4466616qtv.240.1583785410772;
        Mon, 09 Mar 2020 13:23:30 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a23sm22803011qko.77.2020.03.09.13.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:23:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: only take normal tickets into account in may_commit_transaction
Date:   Mon,  9 Mar 2020 16:23:20 -0400
Message-Id: <20200309202322.12327-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309202322.12327-1-josef@toxicpanda.com>
References: <20200309202322.12327-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In debugging a generic/320 failure on ppc64, Nikolay noticed that
sometimes we'd ENOSPC out with plenty of space to reclaim if we had
committed the transaction.  He further discovered that this was because
there was a priority ticket that was small enough to fit in the free
space currently in the space_info.  While that is a problem by itself,
it exposed another flaw, that we consider priority tickets in
may_commit_transaction.

Priority tickets are not allowed to commit the transaction, thus we
shouldn't even consider them in may_commit_transaction.  Instead we need
to only consider current normal tickets.  With this fix in place, we
will properly commit the transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8d00a9ee9458..d198cfd45cf7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -592,10 +592,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	else
 		cur_free_bytes = 0;
 
-	if (!list_empty(&space_info->priority_tickets))
-		ticket = list_first_entry(&space_info->priority_tickets,
-					  struct reserve_ticket, list);
-	else if (!list_empty(&space_info->tickets))
+	if (!list_empty(&space_info->tickets))
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 	bytes_needed = (ticket) ? ticket->bytes : 0;
-- 
2.24.1


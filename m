Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86692D12E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgLGOAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgLGOAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:05 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6EC09424D
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:53 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q7so6489140qvt.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S3VP7V8lCU9GOZcXdgfVCrRDY0XgENnr4Aval9CKvcA=;
        b=qi3fX0W597hKzg8todj9CPmtWuucMPtbeufUfk9ahn4nBb5/rXm03wSREB8zf+lyZM
         eMxXgiRLCGjZCr1dIPYW80mW/E3YgriAUKlkxS44UZIY9RKVD83a/JhURRy35RO4LXhg
         xRVHw8EJDbGfJdFRQ9O2uEy90uVzqGZZ89TJr837TErMoKhFFyphlLRQZZdWFFUwgvdO
         1GLGIo0pUqPEktxVDBDJmoMQtuagZbTr/q3dVjwXnOdG54+p5Alu2+FahoDwumzCRmLy
         6OnNGMEkNmLCumEKabKrkhLXKaArAA3if+Hw9sMMnIQtXp+Mn40kxWCgXXrLFR4G4cyK
         UXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3VP7V8lCU9GOZcXdgfVCrRDY0XgENnr4Aval9CKvcA=;
        b=eLvCzMLwwKpurpWuie5ndrVqlmmeFBastmR3VK5aoE95NoZqaz/n4rG9qfOJ5bdoMn
         ko6GJ/jYAv4PX2td30d7pwdElO2PvSUQGUcG58CdOeTQuFSDJHFdb061fRPikPdzrS5O
         exKsZvIh068Pn2dCm9/aC0j+SjUrPjUms4t+HeTE8yP3mX+NPBQiaNbH4YJimH8vlKKX
         4j9eyEEB0oCDLQ52ymwHj2NW0aQYO/fbGyXVO3NoMqwrv231Tv+2HgXx9JlCuSI49V0v
         JgjGzwWMAId8HrdPZTVZM96h5sUe4qXmTBnWYzmXMaudLKx/7s0y6k3VfQKIfeXfsw2n
         zj9Q==
X-Gm-Message-State: AOAM531gNs5WOjW0cx18u5bDhfU7KqODQP+IggVJfy11Emb+fREemWWZ
        2VKLQr5wzynEj8RG1yCh0S1/mqZrSeszOhUo
X-Google-Smtp-Source: ABdhPJyTmslUcBwdDq2eeFoTOzDNJY4z39trkCvXij3EvsBHW6OtsI/o7E8MVu9Iiw2zDk7byWKc0A==
X-Received: by 2002:ad4:4c8c:: with SMTP id bs12mr4211799qvb.11.1607349532387;
        Mon, 07 Dec 2020 05:58:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b14sm12405968qti.97.2020.12.07.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 34/52] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Mon,  7 Dec 2020 08:57:26 -0500
Message-Id: <25a3ed576c18a96598fa295a3cc8ac54dbf788b7.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
an error properly in prepare_to_merge.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f329903024b0..b4ced3a0ca6f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1860,10 +1860,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		 */
 		if (!err)
 			btrfs_set_root_refs(&reloc_root->root_item, 1);
-		btrfs_update_reloc_root(trans, root);
+		ret = btrfs_update_reloc_root(trans, root);
 
+		/*
+		 * Even if we have an error we need this reloc root back on our
+		 * list so we can clean up properly.
+		 */
 		list_add(&reloc_root->root_list, &reloc_roots);
 		btrfs_put_root(root);
+
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			if (!err)
+				err = ret;
+			break;
+		}
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.26.2


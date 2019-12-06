Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4A11538D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLFOqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41592 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLFOqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id g15so6645718qka.8
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=melX/55R+mGKnJX2pY9dQE4ZsSx3WxtzyO6gYubI3RQ=;
        b=k2dS2qUtf+I+m5dety/rvhUzCKXjQSz/WmsOE456o53jmfgsCk9gPDnSzTqm9xIqZS
         YBc58rwCKVAyYsfBuplGfIJ1wp+7VIepiSYI8hut3EnDUmx0Onx1FUZ1DAQl2oq8L1yG
         GK7k4iLZsSxJx45b+PO9JIR4YH+X0qFlpdW38EhKWQR50gM0B/3WFUv3gmm9UhNyE6N7
         /uZR7kY+ZBTNTSCX3VBEKq85Pz1dwejnMWAyZnij5y9eX4vTKraNfSNu7tcYmt2a5I34
         tyvrRneo5tkbZsUarBEKSrE8yoAMEK2Ayh6iqjoAybArRZcjWRiBhFL+8vAMwu+3cHPr
         PaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=melX/55R+mGKnJX2pY9dQE4ZsSx3WxtzyO6gYubI3RQ=;
        b=h9II0wZIw6TTcmImnrEPTcyaKSCbkuhvM/kuF+6tpPhBh7s6WW02RCt5JibM3tOMCV
         teN/G2nry9hBFK63hEqxjd1ILNPislzxXi8G3v84vRRBC4OM1ohqbwzLgmg5zQq1pnXB
         IP1DIzpekCKQIU8phQGHrlUwzbCrTSEOIgPTGpD5aL5iJnOKucDBhE/7kqce/umXBaW9
         cAoqv4726IkySfWVNs4JhDXedyQz8tYqsIEH+mDiU+mn8fVfEAs9RqSvv+/J+bpqhpGS
         nvuL53Ju1F8ZZrd7Gh814vDdPSRIrneAhRmgrZS1wtMNuz3p8dc2RIPmFrVFXhG4iMaN
         NEvQ==
X-Gm-Message-State: APjAAAUhHaRKD92Hz+izsmemlzQHVxjpItoNavKEmg/VykaaK8rN1MCf
        XJN54b8tw5xKsRhy+EvInMipInrscceTzw==
X-Google-Smtp-Source: APXvYqwy4DpcoqsOuMQMTSZ98lMBEy18kwX4vAIJXWl5/eQfgT4Fd8wsLaHJ/Rg28Y3X3bJqQIZGDA==
X-Received: by 2002:a05:620a:2f6:: with SMTP id a22mr13698349qko.315.1575643605694;
        Fri, 06 Dec 2019 06:46:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o33sm6602157qta.27.2019.12.06.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 37/44] btrfs: hold a ref on the root in btrfs_check_uuid_tree_entry
Date:   Fri,  6 Dec 2019 09:45:31 -0500
Message-Id: <20191206144538.168112-38-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the uuid of arbitrary subvolumes, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 904c3e03467f..47ac3277ee08 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4379,6 +4379,10 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(subvol_root)) {
+		ret = 1;
+		goto out;
+	}
 
 	switch (type) {
 	case BTRFS_UUID_KEY_SUBVOL:
@@ -4391,7 +4395,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		break;
 	}
-
+	btrfs_put_fs_root(subvol_root);
 out:
 	return ret;
 }
-- 
2.23.0


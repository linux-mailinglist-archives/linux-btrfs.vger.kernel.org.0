Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC342605B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Oct 2021 01:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhJGX3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 19:29:14 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:35486
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232772AbhJGX3O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Oct 2021 19:29:14 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C536740002;
        Thu,  7 Oct 2021 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633649236;
        bh=j4KLy0iTel4RMHz49o+7JlbnyzEJeIh5MAE0ooxd3Ac=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=BYzG2INYOspgbKrkTOmgu3MMdragjvqzBrzokptY9CEZsWOoqojZayhFYxsio3Vea
         LvRZszGiUs9tnvybcT+cc6wr/coUM3QaW9PN10QjBguH16lCoWUIYKVO628kv0F7JM
         b41qQE63BsJmrLC82hMemPtFBQwM/hlYXnFedyvGlptiziJ5HNoGaNK8bIn3TB5sph
         GjKfzO08/tiz4J4Y36iqSj8LAQQ2NEnD7n7SeT4d83ccNVRZLjaGa1f2oiij6Bbx/h
         DozposSMs8QwnU7W63Y+dgB1XI1V/Hba/9QduOdj3SLkZB92Pc5U79iGC0EUwxatdi
         PzN0Oikd1fMOA==
From:   Colin King <colin.king@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Remove redundant assignment of variable ret
Date:   Fri,  8 Oct 2021 00:27:16 +0100
Message-Id: <20211007232716.30456-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being assigned a value that is never read, it is
updated later on with a different value. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/btrfs/free-space-cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8ea04582e34b..2a6d02971357 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -735,8 +735,6 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 		return 0;
 	}
 
-	ret = -1;
-
 	leaf = path->nodes[0];
 	header = btrfs_item_ptr(leaf, path->slots[0],
 				struct btrfs_free_space_header);
-- 
2.32.0


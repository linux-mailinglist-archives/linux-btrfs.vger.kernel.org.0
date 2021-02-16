Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2014B31D1B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 21:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBPUoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 15:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBPUoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 15:44:05 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28059C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 12:43:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so8023968qte.9
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GzxkHvDLllCIBEqavqVwpWOvuHNP6WqzxTMUWmRS/OE=;
        b=HvotN1LmXOc6FdQDnMTUVKE8j54vWKDHJB32xmevTv/E765/VEbIwVCB2YAB8yWYyz
         ULYYy6LpuWCFatBEQnDBvL3pcLVBilziBpOhra9Jn7WXl5HOoln82ZOlbN6DvwqwKoPt
         bxtE5Go/JG2g2N4cO0pRKstqx+TILbX0lbYmn7x8D3Gsh9SXY1OKzFHWNtWuJds+cOo3
         Uo1dz6I3dQ3jELIDA4UTW4jEJ896LOvPDTxVD85Lu0QRWVZ0SmPEGF9K0OXvQPtFZq8y
         FXCd6wH4L3NR/V37sDKmz+cR/iACpLwqPhHVj4SGk03R4EL5qMNY9ZIWVVpLqqAYbY/K
         qWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GzxkHvDLllCIBEqavqVwpWOvuHNP6WqzxTMUWmRS/OE=;
        b=CXT3hdEIjox8dzf+HdyEylnQhAvKKIJ2k847KnHFL/yXyzMCrYs81SgS+g0pTOOqNS
         0IFOzNZIvktDSziic+raK0v6chLnrcYa6tP8MCJIIIHZ79lDG3Js6JTy8O3SF0dZKdca
         yyM4eDHHxoPbUEAIhHJzk5JtvX7V5hdFU/T/wAAIhjXd0KKTYyPGzVmA2oEGN5tUr14/
         2Co8t3ARl1rmwy/FXlXGn4k2hJ1vi9c4c+0LOBqRHb13tzZo0WjVWYM7j9vqhrS7GSND
         0p9dwJZM85GGKUY19ywS1Lcffqh0MdZlduFi8D7edtjlDvDkH7Ig8us13RN8D7gwPfTX
         eUIg==
X-Gm-Message-State: AOAM531PnTWnOC7FdryQ5X9p/AVdN2vXJpB60QRoYCsck6UuN2D6FSdN
        54/ENfGlsO//AYbu8lflz9K2s9QyNsVmN0Ok
X-Google-Smtp-Source: ABdhPJy64+S6IEXAjYeudk4nLazBiFFGi9ybShMqvH4oVnACgMVDOPszNEGNWif6byKOcKCk2RlZ0A==
X-Received: by 2002:aed:2dc7:: with SMTP id i65mr21001869qtd.76.1613508204007;
        Tue, 16 Feb 2021 12:43:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v187sm54727qkd.50.2021.02.16.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:43:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     =?UTF-8?q?Tuomas=20L=C3=A4hdekorpi?= <tuomas.lahdekorpi@gmail.com>
Subject: [PATCH] btrfs: do not error out if the extent ref hash doesn't match
Date:   Tue, 16 Feb 2021 15:43:22 -0500
Message-Id: <c801971bb6f1318ae71440504d8631333b7dddc7.1613508186.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree checker checks the extent ref hash at read and write time to
make sure we do not corrupt the file system.  Generally extent
references go inline, but if we have enough of them we need to make an
item, which looks like

key.objectid	= <bytenr>
key.type	= <BTRFS_EXTENT_DATA_REF_KEY|BTRFS_TREE_BLOCK_REF_KEY>
key.offset	= hash(tree, owner, offset)

However if key.offset collide with an unrelated extent reference we'll
simply key.offset++ until we get something that doesn't collide.
Obviously this doesn't match at tree checker time, and thus we error
while writing out the transaction.  This is relatively easy to
reproduce, simply do something like the following

xfs_io -f -c "pwrite 0 1M" file
offset=2

for i in {0..10000}
do
	xfs_io -c "reflink file 0 ${offset}M 1M" file
	offset=$(( offset + 2 ))
done

xfs_io -c "reflink file 0 17999258914816 1M" file
xfs_io -c "reflink file 0 35998517829632 1M" file
xfs_io -c "reflink file 0 53752752058368 1M" file

btrfs filesystem sync

And the sync will error out because we'll abort the transaction.  The
magic values above are used because they generate hash collisions with
the first file in the main subvol.

The fix for this is to remove the hash value check from tree checker, as
we have no idea which offset ours should belong to.

Reported-by: Tuomas Lähdekorpi <tuomas.lahdekorpi@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 582061c7b547..2429d668db46 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1453,22 +1453,10 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	for (; ptr < end; ptr += sizeof(*dref)) {
-		u64 root_objectid;
-		u64 owner;
 		u64 offset;
-		u64 hash;
 
 		dref = (struct btrfs_extent_data_ref *)ptr;
-		root_objectid = btrfs_extent_data_ref_root(leaf, dref);
-		owner = btrfs_extent_data_ref_objectid(leaf, dref);
 		offset = btrfs_extent_data_ref_offset(leaf, dref);
-		hash = hash_extent_data_ref(root_objectid, owner, offset);
-		if (unlikely(hash != key->offset)) {
-			extent_err(leaf, slot,
-	"invalid extent data ref hash, item has 0x%016llx key has 0x%016llx",
-				   hash, key->offset);
-			return -EUCLEAN;
-		}
 		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
 			extent_err(leaf, slot,
 	"invalid extent data backref offset, have %llu expect aligned to %u",
-- 
2.26.2


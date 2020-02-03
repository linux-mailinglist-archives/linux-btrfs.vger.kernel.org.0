Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCA515113D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgBCUom (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:44:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41151 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:44:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id u19so7996537qku.8
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iUnvrD6m4nNHjITULfSvpib82qzgHURQ3/B0vvzqnJ4=;
        b=U5jr+YePGu4S/4l34n/LlxT4RLpCLtRYm8223V1hFth/4EIgA+O/hvJ8V0BPJHpmqp
         L4Sy5+ID6fA1CrI5whNAiY2FDwsb4WX9YiyJMnUgQorDBbJxz2FNWc3cQEfgyK9aBb/+
         3J/pXiFvO2RXrSXQE/j86+ZWRW/OTkRfn8z4ExDWd9bMz4Wt3N4GnOOOdkt0wRsyg/Ab
         2rj7YE6hpWvmnmhTepEcg2nxlWiycNOaGKFasWHB0J2Y0KrXenqTHdoWoopHphNTs3hR
         296AoZ2us3CyHUqygcMSCLTHwct65Uj9UVahff9ieSTMWk5/8B8dwZ/93d2QRNBZoUR7
         PmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUnvrD6m4nNHjITULfSvpib82qzgHURQ3/B0vvzqnJ4=;
        b=pDCwlqBHug6vPL85NIVu91m8UwN8GrgpxgdoL3BRCLPtmJX+2IzbDsq/NNn35s6ixg
         1UUxaRjwhtetMd1uvPKYYwPQhIPQmooSMjmzRR0ilXzi6RIc5ev/rccna5FFghkXWnEn
         h/7rv8qxK6bba5gINXl6rLR7XD+X6xZgHlqdktthf8gT7OFZdUryovWkead6uyIAhD6U
         NJdsGIc+4Af8s7QUNE512IF64sYW5amgEY2unItkI9zblQNMBk/b4+Uo2D3CnHu2Vq6J
         +Ngf1V1IEopRaxNo+MJJhpmXyPXYF55w3JdmPBEpYR+5210SX6gU9604RtBzup4J/g1S
         3beQ==
X-Gm-Message-State: APjAAAUIpeOPFrNgvQfdKvqnRe15v4C4RYqsfQ6+MaqCyruiozlRhf98
        lRTK9iY/ekb14PM2CsaJ3gFWBJZPfh5+LA==
X-Google-Smtp-Source: APXvYqydMzvordAPz1aJDsDekGzhknJHTa2d1uj9Z3ExxM0aYgw9Mzg7oBktOHbA/L/q5AlFFF5ziw==
X-Received: by 2002:a05:620a:11a1:: with SMTP id c1mr26203480qkk.390.1580762680547;
        Mon, 03 Feb 2020 12:44:40 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h12sm10470569qtn.56.2020.02.03.12.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:44:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: add a comment describing block-rsvs
Date:   Mon,  3 Feb 2020 15:44:34 -0500
Message-Id: <20200203204436.517473-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204436.517473-1-josef@toxicpanda.com>
References: <20200203204436.517473-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a giant comment at the top of block-rsv.c describing generally
how block rsvs work.  It is purely about the block rsv's themselves, and
nothing to do with how the actual reservation system works.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index d07bd41a7c1e..54380f477f80 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -6,6 +6,87 @@
 #include "space-info.h"
 #include "transaction.h"
 
+/*
+ * HOW DO BLOCK RSVS WORK
+ *
+ *   Think of block_rsv's as bucktes for logically grouped reservations.  Each
+ *   block_rsv has a ->size and a ->reserved.  ->size is how large we want our
+ *   block rsv to be, ->reserved is how much space is currently reserved for
+ *   this block reserve.
+ *
+ *   ->failfast exists for the truncate case, and is described below.
+ *
+ * NORMAL OPERATION
+ *   We determine we need N items of reservation, we use the appropriate
+ *   btrfs_calc*() helper to determine the number of bytes.  We call into
+ *   reserve_metadata_bytes() and get our bytes, we then add this space to our
+ *   ->size and our ->reserved.
+ *
+ *   We go to modify the tree for our operation, we allocate a tree block, which
+ *   calls btrfs_use_block_rsv(), and subtracts nodesize from
+ *   block_rsv->reserved.
+ *
+ *   We finish our operation, we subtract our original reservation from ->size,
+ *   and then we subtract ->size from ->reserved if there is an excess and free
+ *   the excess back to the space info, by reducing space_info->bytes_may_use by
+ *   the excess amount.
+ *
+ *   In some cases we may return this excess to the global block reserve or
+ *   delayed refs reserve if either of their ->size is greater than their
+ *   ->reserved.
+ *
+ * BLOCK_RSV_TRANS, BLOCK_RSV_DELOPS, BLOCK_RSV_CHUNK
+ *   These behave normally, as described above, just within the confines of the
+ *   lifetime of ther particular operation (transaction for the whole trans
+ *   handle lifetime, for example).
+ *
+ * BLOCK_RSV_GLOBAL
+ *   This has existed forever, with diminishing degrees of importance.
+ *   Currently it exists to save us from ourselves.  We definitely over-reserve
+ *   space most of the time, but the nature of COW is that we do not know how
+ *   much space we may need to use for any given operation.  This is
+ *   particularly true about the extent tree.  Modifying one extent could
+ *   balloon into 1000 modifications of the extent tree, which we have no way of
+ *   properly predicting.  To cover this case we have the global reserve act as
+ *   the "root" space to allow us to not abort the transaciton when things are
+ *   very tight.  As such we tend to treat this space as sacred, and only use it
+ *   if we are desparate.  Generally we should no longer be depending on its
+ *   space, and if new use cases arise we need to address them elsewhere.
+ *
+ * BLOCK_RSV_DELALLOC
+ *   The individual item sizes are determined by the per-inode size
+ *   calculations, which are described with the delalloc code.  This is pretty
+ *   straightforward, it's just the calculation of ->size encodes a lot of
+ *   different items, and thus it gets used when updating inodes, inserting file
+ *   extents, and inserting checksums.
+ *
+ * BLOCK_RSV_DELREFS
+ *   We keep a running talley of how many delayed refs we have on the system.
+ *   We assume each one of these delayed refs are going to use a full
+ *   reservation.  We use the transaction items and pre-reserve space for every
+ *   operation, and use this reservation to refill any gap between ->size and
+ *   ->reserved that may exist.
+ *
+ *   From there it's straightforward, removing a delayed ref means we remove its
+ *   count from ->size and free up reservations as necessary.  Since this is the
+ *   most dynamic block rsv in the system, we will try to refill this block rsv
+ *   first with any excess returned by any other block reserve.
+ *
+ * BLOCK_RSV_EMPTY
+ *   This is the fallback block rsv to make us try to reserve space if we don't
+ *   have a specific bucket for this allocation.  It is mostly used for updating
+ *   the device tree and such, since that is a separate pool we're content to
+ *   just reserve space from the space_info on demand.
+ *
+ * BLOCK_RSV_TEMP
+ *   This is used by things like truncate and iput.  We will temporarily
+ *   allocate a block rsv, set it to some size, and then truncate bytes until we
+ *   have no space left.  With ->failfast set we'll simply return ENOSPC from
+ *   btrfs_use_block_rsv() to signal that we need to unwind and try to make a
+ *   new reservation.  This is because these operations are unbounded, so we
+ *   want to do as much work as we can, and then back off and re-reserve.
+ */
+
 static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_rsv *block_rsv,
 				    struct btrfs_block_rsv *dest, u64 num_bytes,
-- 
2.24.1


Return-Path: <linux-btrfs+bounces-4243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB58A4296
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1029C1C2107B
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8F42071;
	Sun, 14 Apr 2024 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aFyCr6v6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A6381B9
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100969; cv=none; b=HBT7wt1dG0RlCvxUwdDteBcoAcIH5UKh7shLoVwhb86PB9CctrFZt3Vh9IWnSmI93zI+dAInt12MKKgKuR7zIn78sfdr+rFM2fT3Ksol2keidbs+7sfjNmNqBmVqDUWvyHhHnlIC7whhqX11J2FDrYbr9i9cv5ToXmTWGCcvYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100969; c=relaxed/simple;
	bh=BIwgc7pkwM3TthOjQVmGULxPsZQaiUcg6m4AzpUvFhQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B9mIoLC2gavsvMiAD6nZKjbtR/DZQS/wjxsRCvWzrmdLsw7GnFRmzmPhNxxu+vD5v5RKNmiIZWebhjeiDcMU4dTpUByMyAWipXRjoMYP0Kuu33rxLkYBvbGVNQRHO/aq0Dco8T7iSSquFxEMRPbXNCCch2+OmPWj8rgBz3TD4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aFyCr6v6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78edc0a81efso64152985a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713100966; x=1713705766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jo5Um5DcTfhDuaVcXcQLTRceVHqoXO3tdHC8DVMommQ=;
        b=aFyCr6v6r6dZO93d+3CxC/5UJJtJRYpJemUeC0tzY0eU8oq3OrFcd6WmN7IhGXg6r/
         Pb1BU7WYK2Nb6X7MtVhs9QFOjVoVwZ+pZZWtvKv07YilcuIG1wQS5oXhjzlxDtuf2pj5
         oJKV7mbZFeVxz5/dD2cmhRr6WCRNqPJY+Fk2aFDjgRsRkYndhCx0meJLn1YpBiGqxbIK
         fAtUzK3XLB30eysrR2te0hdUdwtWK2lfXW95y4K8RsPNcsNgLwPUYk9HvPd3scqpYkIG
         Ano4Q47vVq0JZ3qe+sspi8dUTUf/39H2b8NzR6nR1yk6T/9y4Bgp3SbhwZIfaJADCgDm
         YUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713100966; x=1713705766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jo5Um5DcTfhDuaVcXcQLTRceVHqoXO3tdHC8DVMommQ=;
        b=MqAK5n3EWWvorn6tEOLx0cjWPiMWj9phdI6L7ROdKwxtSRDSA4gjUcFmMOv6JlU5Ut
         UoaPVmkjKa0eMK7kagY3zVlwxZP0yZyc6tUd92Oj41mSbfHDLG0sqcrkNUwh88xBSCfL
         BNSIkZhe20KDURadPPyfiFN0oS4C53uhxrlsJZFsJ9KTgMH5XGHWzhrX3DaiFWHwiVYF
         WBfAIsQCbJisLKdUbdKUnxEvUPC6fnDBSm3E9lvnnTQUOAL/dYbIskOoNaj69ECUsdmK
         fCBXXXaT8YQFKkpdH8a6SDmvNGbN/A7RQAk9JYYg9fEVlsLlJmv0mI8dbMCtiZW07PTW
         98Tg==
X-Gm-Message-State: AOJu0YwglpONSDSw8XOeE/mNunmz/kc9i/107XK8E63ZPxpWjByWC3Ui
	csEf/UpwHKXemubLiOK1twtgRXW9BquH4mNRo5xag72QJwu16nN2ojMrbgullVGs4Z6WDezgsxL
	9
X-Google-Smtp-Source: AGHT+IGDEYl9P86gqqvHVyiXwyuNZZoYDO03gOYF1v6TSs0mJyMz2S8GDjhSupfhKkoMlnKDUMOguA==
X-Received: by 2002:a37:e306:0:b0:78e:c0f7:54fb with SMTP id y6-20020a37e306000000b0078ec0f754fbmr9386831qki.50.1713100966621;
        Sun, 14 Apr 2024 06:22:46 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x10-20020ae9e90a000000b0078d6d22a0c3sm5038774qkf.90.2024.04.14.06.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 06:22:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: set start on clone before calling copy_extent_buffer_full
Date: Sun, 14 Apr 2024 09:22:38 -0400
Message-ID: <cbf5bf79edc537544f383ee3d6c79a1bec45a964.1713100883.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our subpage testing started hanging on generic/560 and I bisected it
down to 1cab1375ba6d ("btrfs: reuse cloned extent buffer during
fiemap to avoid re-allocations").  This is subtle because we use
eb->start to figure out where in the folio we're copying to when we're
subpage, as our ->start may refer to an area inside of the folio.

For example, assume a 16k page size machine with a 4k node size, and
assume that we already have a cloned extent buffer when we cloned the
previous search.

copy_extent_buffer_full() will do the following when copying the extent
buffer path->nodes[0] (src) into cloned (dest):

src->start = 8k; // this is the new leaf we're cloning
cloned->start = 4k; // this is left over from the previous clone

src_addr = folio_address(src->folios[0]);
dest_addr = folio_address(dest->folios[0]);

memcpy(dest_addr + get_eb_offset_in_folio(dst, 0),
       src_addr + get_eb_offset_in_folio(src, 0), src->len);

Now get_eb_offset_in_folio() is where the problems occur, because for
sub-pagesize blocksize we can have multiple eb's per folio, the code for
this is as follows

size_t get_eb_offset_in_folio(eb, offset) {
	return (eb->start + offset & (folio_size(eb->folio[0]) - 1));
}

So in the above example we are copying into offset 4k inside the folio.
However once we update cloned->start to 8k to match the src the math for
get_eb_offset_in_folio() changes, and any subsequent reads (ie
btrfs_item_key_to_cpu()) will start reading from the offset 8k instead
of 4k where we copied to, giving us garbage.

Fix this by setting start before we co copy_extent_buffer_full() to make
sure that we're copying into the same offset inside of the folio that we
will read from later.

All other sites of copy_extent_buffer_full() are correct because we
either set ->start beforehand or we simply don't change it in the case
of the tree-log usage.

With this fix we now pass generic/560 on our subpage tests.

Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 49f7161a6578..a59cd88cf318 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2809,13 +2809,19 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
 		goto out;
 	}
 
-	/* See the comment at fiemap_search_slot() about why we clone. */
-	copy_extent_buffer_full(clone, path->nodes[0]);
 	/*
 	 * Important to preserve the start field, for the optimizations when
 	 * checking if extents are shared (see extent_fiemap()).
+	 *
+	 * We must set ->start before calling copy_extent_buffer_full().  If we
+	 * are on sub-pagesize blocksize, we use ->start to determine the offset
+	 * into the folio where our eb exists, and if we update ->start after
+	 * the fact then any subsequent reads of the eb may read from a
+	 * different offset in the folio than where we originally copied into.
 	 */
 	clone->start = path->nodes[0]->start;
+	/* See the comment at fiemap_search_slot() about why we clone. */
+	copy_extent_buffer_full(clone, path->nodes[0]);
 
 	slot = path->slots[0];
 	btrfs_release_path(path);
-- 
2.43.0



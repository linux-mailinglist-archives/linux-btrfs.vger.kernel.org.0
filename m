Return-Path: <linux-btrfs+bounces-19594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12ACAED16
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 04:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FCE93001BE9
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D530101A;
	Tue,  9 Dec 2025 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvv13/ib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705F30147F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251487; cv=none; b=J+H//Bcust6t8rNohTWIEIOHD8nKg36z8o5hwBKkMy78mnlXOTQOmqKUPCIuvQn2mof8IwLgw9g4XzfLJf6leiGvJt1DFJm0eaphVAFHfbkW2YqnD800+OwbMSp4czo6KYLxfqaoC8lnV4RkgCpQ0AaGat8y8QIbTN2Do6mtKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251487; c=relaxed/simple;
	bh=iLxBhAxVOlsBK/CYpuauw2ONLqu11z3gcVq9FxJ2GmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMjnD78q9XRqPvmvodBzGey/GHbvw8WJT1nLsPg5nSxizRDhy16/dAbuTsXRxMKuZqwgMmrP8FDHsMOWW9BOnwPfZLRxmxyjapCDsZ6uQLBaGcHgT0cQL88DpyMFAH88O2xgRwaL4JOJhLWntZHxy61skW30b+XRh9hjkY0sLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nvv13/ib; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7bac5b906bcso710879b3a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765251486; x=1765856286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT5iLCG4O8qZM4FPoscL1cvH90ndvsfft78qTEWKl8w=;
        b=Nvv13/ibyELBnFKlpkbqA/l9KHl28Y4t52d/34Q4oMR0GtnAb8iMq5DWa6tu7fIKwL
         hI5YpVd8qzVfSUSgxEOl7SNrjs6dc3qC6g0Ro3K9zmW5Ux4rJBuOusP4M5d3v7GpHC8r
         MSEDwSMbb/FJzeDQKJTmQQLgNVTU6HL+CKHf5UC67DYUBjGQwQ5TZe4rOu8suiw6vXHW
         EySd1f34pQKD96vqG3f4eEKUbr8ZwiwH7iYsz+TIAc1oUpFsLrr50yaCNiuqRVGbsp7E
         IJdRfETTBq2/qJfjonmdofd4u3pZOqn5N/gBzbSlO3gA09mlT9YzMZSdsDKDonEjtf5g
         Y9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251486; x=1765856286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qT5iLCG4O8qZM4FPoscL1cvH90ndvsfft78qTEWKl8w=;
        b=DGYW18qTAyrFDFTX0yOC9iFkwT0cZRJ/HQXDMVz+3yFJLM0kwuyOHRpQmivGfDOuuQ
         9OplW+T0d/ka3kBP0iIARXKChZYMI9Yux5NsyGMg2OhWcOX0IKdYYqowhtYlpXzbs7B0
         1D/rO934Jg8ycsi99YK/RP8v2kp/uTmQSA29fWtntu1QGnyz7SrbuF439gRdRNLjl/PK
         8Lh/E+OIRLCBscZRS9X7rOnrjTXKVEM6+xAD9I/mKwqxQ8TK1hcp2sapav5e6mqOC4ZW
         D0PyffiILJKCc0oJaX9jV0NHFdT367NEz9AwHMEaD6cWgQ0CXCulkB7KVaubon4Xzsww
         WYYg==
X-Gm-Message-State: AOJu0YyukxcM1AIs0AOicZ9w+qRen6ivW9KFoEerFZELlnX8lj8ca+Cd
	UQTYPTckZw69iDFObp2lx/PVzChzOWLAMNY3aydjncgzZSe2TtZElvvUUw/FngCA4peOmg==
X-Gm-Gg: ASbGncuIqjIQ45TfHHGI5O8NIEm3hP3wgDl14Qq91YM9slywItKgNx+Jqr2rn/JNSLb
	RJLUtueuib7/VH65f5DqkAPry28G1GTRek6V1wNWLzcu3//FMvqHIGfCW9MMZ0uIIMxxNQ2cS4V
	LvGDoGW6f9VtKEC1SEqaUpPQjiNoyiZQiaI56We8WS5o16H9yuLsSLuOS9LANCnlgmaJfVY6P+8
	eo2E3z2JgDQhJ/kYPQ1/MwTuY78wJqEUG5JMjs+jCrgUrYIzFi3/p/l2+9HZmQ+uCZ/B4lNr7EN
	Rzu+fQaIwfmm1V9byXH7ImVJh0zItJ6J9BPmHdYfSz49QGOvLsG/q1okWY3MT9WBc4qO+/SudEe
	ut2qs2/uCIFI7Etao41ndW7uUxGibq1f9+pBa3F2t9UX2lwh7htlcgI+vA7V2aomjVxaHkH1qOB
	CJqUQ9a6Jdno+NAe5Cmrzj
X-Google-Smtp-Source: AGHT+IFbHiBkYdtNgF62fvNettxOwlxV/9Oz3LCoPR+Qwv5u6b3CwJNNe6rwcsXhklEQkFtQ2JOpvg==
X-Received: by 2002:a05:6a00:a16:b0:7ab:9850:25fb with SMTP id d2e1a72fcca58-7e8c04ef208mr6486573b3a.2.1765251485807;
        Mon, 08 Dec 2025 19:38:05 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7edac47617dsm3923900b3a.42.2025.12.08.19.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:38:05 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/4] btrfs: don't set return_any @return_any for btrfs_search_slot_for_read in get_last_extent()
Date: Tue,  9 Dec 2025 11:27:19 +0800
Message-ID: <20251209033747.31010-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251209033747.31010-1-sunk67188@gmail.com>
References: <20251209033747.31010-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There must be a previous item at least the inode_item. So setting
@return_any is not necessary.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/send.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2522faa97478..eae596b80ec0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6320,16 +6320,14 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 	key.objectid = sctx->cur_ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = offset;
-	ret = btrfs_search_slot_for_read(root, &key, path, 0, 1);
+	ret = btrfs_search_slot_for_read(root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	ret = 0;
+	ASSERT(ret == 0);
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	if (key.objectid != sctx->cur_ino || key.type != BTRFS_EXTENT_DATA_KEY)
-		return ret;
-
-	sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
-	return ret;
+	if (key.objectid == sctx->cur_ino && key.type == BTRFS_EXTENT_DATA_KEY)
+		sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
+	return 0;
 }
 
 static int range_is_hole_in_parent(struct send_ctx *sctx,
-- 
2.51.2



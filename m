Return-Path: <linux-btrfs+bounces-13491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F35DAA0463
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90A8482B83
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8455D277033;
	Tue, 29 Apr 2025 07:24:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65BA21B1A3;
	Tue, 29 Apr 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911447; cv=none; b=Zsw49rinSIhCqvG85TX3vhobuxRvVmfF334i72kAy8LCQcS6KrvI9CH0hbLwBHi9Jq+dCxtiQAGvncrSv71MlIPgmeWfDZqxqt7vDyaiowl8DOTbxhe6YUJOnALDqImr9XH8NUZlPcfoZqvEvpecm5+uTCjnUZ69Pugz9NEpWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911447; c=relaxed/simple;
	bh=5SLQJUzlUoUcDCh5g1aEuxv+XpKP2Kwgo3y4seB7O3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AsMU9w9TmBTqMYGOt95iT37ft8uU/3aEFnUvXUA+D6irIPGmU/SZWN7G9QdLzDB1MKUTL7GAi/0equyd9BMbZIs2BSL+2w5W0Wfg1CA7dLqvr1fUb9kioS1DrlqHgYSbeSIJ62NSebM59SwIeEdpl5fd8+G2zwFcGg+6f6ZDROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504291522453646;
        Tue, 29 Apr 2025 15:22:45 +0800
Received: from localhost.localdomain (10.94.7.67) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.39; Tue, 29 Apr 2025 15:22:46 +0800
From: Bo Liu <liubo03@inspur.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC: <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] btrfs: Use refcount_t instead of atomic_t for mmap_count
Date: Tue, 29 Apr 2025 03:20:33 -0400
Message-ID: <20250429072033.3382-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2025429152245afd561e9c116c9f26a73e47086225e38
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Use an API that resembles more the actual use of mmap_count.
Found by cocci:
fs/btrfs/bio.c:153:5-24: WARNING: atomic_dec_and_test variation before object free at line 155

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/btrfs/bio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a3ee9a976f6f..353c61936cd6 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -23,7 +23,7 @@ static mempool_t btrfs_failed_bio_pool;
 struct btrfs_failed_bio {
 	struct btrfs_bio *bbio;
 	int num_copies;
-	atomic_t repair_count;
+	refcount_t repair_count;
 };
 
 /* Is this a data path I/O that needs storage layer checksum and repair? */
@@ -150,7 +150,7 @@ static int prev_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
 
 static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
 {
-	if (atomic_dec_and_test(&fbio->repair_count)) {
+	if (refcount_dec_and_test(&fbio->repair_count)) {
 		btrfs_bio_end_io(fbio->bbio, fbio->bbio->bio.bi_status);
 		mempool_free(fbio, &btrfs_failed_bio_pool);
 	}
@@ -235,10 +235,10 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 		fbio = mempool_alloc(&btrfs_failed_bio_pool, GFP_NOFS);
 		fbio->bbio = failed_bbio;
 		fbio->num_copies = num_copies;
-		atomic_set(&fbio->repair_count, 1);
+		refcount_set(&fbio->repair_count, 1);
 	}
 
-	atomic_inc(&fbio->repair_count);
+	refcount_inc(&fbio->repair_count);
 
 	repair_bio = bio_alloc_bioset(NULL, 1, REQ_OP_READ, GFP_NOFS,
 				      &btrfs_repair_bioset);
-- 
2.31.1



Return-Path: <linux-btrfs+bounces-11730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608EA416B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 08:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469307A1657
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666E23FC66;
	Mon, 24 Feb 2025 07:52:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1D13C3F6;
	Mon, 24 Feb 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383530; cv=none; b=AYgTB+d+YuDzHCVE7EX6MXq826hobvEdLt1NRgVR0yg2CH5UuVGihcTFrDAV3vZeeWizBs1BQv7pkqB4RZ+C0zBjM1SQwfZC6tZ1iDMCyRQLHSDPh24vmZotss3SKotsTlp6zKG/AJFFo78ERl7IOm/gntQT3IHqJ+UbI5M88/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383530; c=relaxed/simple;
	bh=EQQrFz14F9++ckzMR6HGqVYAbV06QiwCF9ZWSjxIJSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gnLGHonaIwcLyi4RCXNWUgk2j5f+FWIURJF4m5rcj1PuKt72Fo9amzz613quAHZ75LjjX+OZmbw71FsdOIHNSZnTo6yayHuoeqsvc6dieR70y0SX3w+ZROPYztDj0IH0QCRhix5CkEerW3tXZ+IJx+Qeb5MAo3fPbQXJwHvr+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAAXH1sVJbxn1AryDw--.64440S2;
	Mon, 24 Feb 2025 15:51:51 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	jeffm@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: add a sanity check for btrfs root in btrfs_search_old_slot()
Date: Mon, 24 Feb 2025 15:51:42 +0800
Message-Id: <20250224075142.2959155-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXH1sVJbxn1AryDw--.64440S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWxZw1xGw4kJrW8Kw45Wrg_yoW8Jw43pF
	4fCas0gw4kJr4qgrs8Ww40q34Sgw4qga1Uuasxt3yftw45t345WFykAw18Zr90kFWkJrW2
	vF4jvw1UC3Z2kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUvg4fUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

When searching the extent tree to gather the needed extent info,
btrfs_search_old_slot() doesn't check if the target root is NULL or
not, resulting the null-ptr-deref. Add sanity check for btrfs root
before using it in btrfs_search_old_slot().

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 0b246afa62b0 ("btrfs: root->fs_info cleanup, add fs_info convenience variables")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 fs/btrfs/ctree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3dc5a35dd19b..4e2e1c38d33a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2232,7 +2232,7 @@ ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 			  struct btrfs_path *p, u64 time_seq)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info;
 	struct extent_buffer *b;
 	int slot;
 	int ret;
@@ -2241,6 +2241,10 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	int lowest_unlock = 1;
 	u8 lowest_level = 0;
 
+	if (!root)
+		return -EINVAL;
+
+	fs_info = root->fs_info;
 	lowest_level = p->lowest_level;
 	WARN_ON(p->nodes[0] != NULL);
 	ASSERT(!p->nowait);
-- 
2.25.1



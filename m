Return-Path: <linux-btrfs+bounces-2141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0D84ABE2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 03:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36BA286E42
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 02:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03D56B83;
	Tue,  6 Feb 2024 02:03:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560956B6D;
	Tue,  6 Feb 2024 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185012; cv=none; b=NwtvOVg/uSRvXttVIf1iP0L/sa0QWKaf2U7kououobA2udmt84k/C5V5hKnbhbZxmgsXCrDU4dVvSLgNEYeMcxdE0Gal/wVxgEKfX7LtYqV8r5vGuL/09cUOBfayTyhq4i3jWY9Kn3z9y3zHeQzRpRaDHNjG3lkv9JHpgTISr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185012; c=relaxed/simple;
	bh=HCHH0zlG8Okh9pH+9a449X/wcy1iGT612BVT0ULldVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iFiKLaVIIbhCrnm4NhCIPhuw6GrPhjFA5nB7xHUjfLxsfegzdjrPWEDtqg3k0gr2MG3UVsBrL22PS9knF4/6HYRlcZBcFGxQNRC8EOHtVer/66i+k7O5vtaAFCbBMRt+XKiW3uzgpNargmGu7m6rWi40pv7ohMZGoOz+xcyAm88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from lijuan-ubuntu-04.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADX36OzkcFl3IMSAQ--.8824S2;
	Tue, 06 Feb 2024 09:56:03 +0800 (CST)
From: lilijuan@iscas.ac.cn
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	Lijuan Li <lilijuan@iscas.ac.cn>
Subject: [PATCH] btrfs: mark __btrfs_add_free_space static
Date: Tue,  6 Feb 2024 09:56:00 +0800
Message-Id: <20240206015600.115756-1-lilijuan@iscas.ac.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX36OzkcFl3IMSAQ--.8824S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDAFW5JF4fZFW5uFy5twb_yoW8Xw1kpF
	n3AFsxtw1UArsYvFWvgw4qv34Sga4vqa1Uu3s8A3yfXrZxGr1DXFyqv3W8A3W3trWkJr4x
	Xas09ryUArsIyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
	c2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UfnYwUUUUU=
X-CM-SenderInfo: poloxyxxdqqxpvfd2hldfou0/

From: Lijuan Li <lilijuan@iscas.ac.cn>

__btrfs_add_free_space is only used in free-space-cache.c,
so mark it static.

Signed-off-by: Lijuan Li <lilijuan@iscas.ac.cn>
---
 fs/btrfs/free-space-cache.c | 2 +-
 fs/btrfs/free-space-cache.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d372c7ce0e6b..812994f456e4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2621,7 +2621,7 @@ static void steal_from_bitmap(struct btrfs_free_space_ctl *ctl,
 	}
 }
 
-int __btrfs_add_free_space(struct btrfs_block_group *block_group,
+static int __btrfs_add_free_space(struct btrfs_block_group *block_group,
 			   u64 offset, u64 bytes,
 			   enum btrfs_trim_state trim_state)
 {
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 33b4da3271b1..d9b7fbc2008a 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -114,8 +114,6 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 
 void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 			       struct btrfs_free_space_ctl *ctl);
-int __btrfs_add_free_space(struct btrfs_block_group *block_group, u64 bytenr,
-			   u64 size, enum btrfs_trim_state trim_state);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
 int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
-- 
2.40.1



Return-Path: <linux-btrfs+bounces-2904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1386C3C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 09:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCCB1F223BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CA51016;
	Thu, 29 Feb 2024 08:37:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9A50A63;
	Thu, 29 Feb 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195822; cv=none; b=eZ8/D30LHGhpaLNxQHwv8abpet15kuUfujGUGfNPsXI4dhQCHW+sOs3SrKg47lYorpZ+f/zOGlFHNSojK52xmk/0f8Jd70GYaZsWzs36Lynx7LgauvD/whIa0muCLI1j6VYQh9DK7lQfY000pFP6bzgHQpwDmwHDZeVm97rg3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195822; c=relaxed/simple;
	bh=DFpZU+iH4UhuNKIVT9kLtI0sltz21Wxk14OgBTiuG3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ud1Lx44XuQMJZPie3YAGjj2slCdifdyRk9nJufhZYVWSCu6rg4d8Kl8Y9gf2l6qQlWjFNTGTC7Si3YZHb0Z176Rv6DyUUUG5Vz/HQ8zsRrqjuu4neVt1w01cF1xkVeTZQw+F6vm7t+4tMicZJIlcVg52Vsz7g8hsMEhEz44FuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from lijuan-ubuntu-04.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABXeKmRQOBlkqbJAw--.65446S2;
	Thu, 29 Feb 2024 16:30:10 +0800 (CST)
From: lilijuan@iscas.ac.cn
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	Lijuan Li <lilijuan@iscas.ac.cn>
Subject: [PATCH] btrfs: mark btrfs_put_caching_control static
Date: Thu, 29 Feb 2024 16:30:07 +0800
Message-Id: <20240229083007.679804-1-lilijuan@iscas.ac.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXeKmRQOBlkqbJAw--.65446S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4fZFWrGr43KrW7XrW3GFg_yoW8XF13pr
	ykCrnxGF1UCFn0gF4UG3yYqw1Sgas5J3y7A3s5Cw4xZ343Kr17Zryqyw1rAa4UtFs8ArZr
	Z3WY934UCFnIyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
	c2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	fU8UUUUUUUU
X-CM-SenderInfo: poloxyxxdqqxpvfd2hldfou0/

From: Lijuan Li <lilijuan@iscas.ac.cn>

btrfs_put_caching_control is only used in block-group.c,
so mark it static.

Signed-off-by: Lijuan Li <lilijuan@iscas.ac.cn>
---
 fs/btrfs/block-group.c | 2 +-
 fs/btrfs/block-group.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1b4be41495ea..84932d944d51 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -418,7 +418,7 @@ struct btrfs_caching_control *btrfs_get_caching_control(
 	return ctl;
 }
 
-void btrfs_put_caching_control(struct btrfs_caching_control *ctl)
+static void btrfs_put_caching_control(struct btrfs_caching_control *ctl)
 {
 	if (refcount_dec_and_test(&ctl->count))
 		kfree(ctl);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c03971f50521..8656b38f1fa5 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -311,7 +311,6 @@ void btrfs_wait_nocow_writers(struct btrfs_block_group *bg);
 void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 				           u64 num_bytes);
 int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait);
-void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
 struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group *cache);
 int btrfs_add_new_free_space(struct btrfs_block_group *block_group,
-- 
2.40.1



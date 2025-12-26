Return-Path: <linux-btrfs+bounces-20019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C9CDE6CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C60300CB9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF11259C9C;
	Fri, 26 Dec 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Oi1s/sMK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5714265CA2;
	Fri, 26 Dec 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766734206; cv=none; b=NgN4Af4m976nRPLj8+/w/1ha6rh4E/gS6jTa1Uo+2JreLkCptQL/3owEB6by+4sr6E6jorwWCcZJPwpbR238I+bm38cG0qv8aSpFQcAFZDoZQ8rJipVOi/hnvNUuQO2B7BxCf+yExV3y2rN6QrWuI5PxFgSr8F4gPRTjZ7imJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766734206; c=relaxed/simple;
	bh=M0AonSfthSrLZK9b1fWHbEx9jdHheDJVz0bYAIfLWFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0IAlhJRWiYRqCmvX30Edm1sxJR9HZZ7C7ljpxO3Hia5YpEp2bzZR4tlsrvqvWet2hiSNWI1CUqkpkqQgYNX81OsU7M8JzOGK9JYLibVl8vVnBFlJtzUZY3wLZqH8cZU60zrhQCsnpLcCtRBIFmidYlzVbJgIzUkW6sXMjZtiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Oi1s/sMK; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ea53704b;
	Fri, 26 Dec 2025 15:29:58 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: quwenruo.btrfs@gmx.com
Cc: clm@fb.com,
	dan.carpenter@linaro.org,
	dsterba@suse.com,
	jianhao.xu@seu.edu.cn,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunk67188@gmail.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
Date: Fri, 26 Dec 2025 07:29:56 +0000
Message-Id: <20251226072956.1734175-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d0fac5ff-9159-4d13-8813-5de8e9bb6484@gmx.com>
References: <d0fac5ff-9159-4d13-8813-5de8e9bb6484@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b5990741e03a1kunm9c2a48c82f28e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGE1JVk1KQ0xIH08ZTUoZTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Oi1s/sMK9OCtWD2Q2rJ5n5j28yefWr9C7wKCs46R+gYaTVl34HV32Fhw8GplHIkDMgN2ny89INDlLCUnaci8X+CBp10dPJmsxRCtc/2enD7uG5lRWbxZvR60i//jM3JpVZndnY276M9DRFVqCIpcawjRAW54AYY6XZIQEPTOU6w=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=zG5vzJwopKRbMh3YoAQXvHweqkw9EDTPqEk9kwX9TSo=;
	h=date:mime-version:subject:message-id:from;

On Fri, Dec 26, 2025 at 07:24:45AM +1030, Qu Wenruo wrote:
> >> @@ -517,11 +517,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32 
> >> nodesize)
> >>       tmp_root->root_key.objectid = BTRFS_FS_TREE_OBJECTID;
> >>       root->fs_info->fs_root = tmp_root;
> >>       ret = btrfs_insert_fs_root(root->fs_info, tmp_root);
> >> +    btrfs_put_root(tmp_root);
> >>       if (ret) {
> >>           test_err("couldn't insert fs root %d", ret);
> >>           goto out;
> > 
> > This will lead to double free.
> > 
> > If btrfs_insert_fs_root() failed, btrfs_put_root() will do the cleaning 
> > and free the root.
> > 
> > Then btrfs_free_dummy_root() will call btrfs_put_root() again on the 
> > root, cause use-after-free.
> > 
> > So your analyze is completely wrong.

Hi Qu,

Thanks for the review. I apologize for any ambiguity in my previous 
communication.

I believe there might be a misunderstanding regarding which root is 
being freed at the 'out' label.

The 'out' label calls:
    btrfs_free_dummy_root(root);
    btrfs_free_dummy_fs_info(fs_info);

It explicitly frees 'root', but it does not free 'tmp_root'.

If btrfs_insert_fs_root() fails for 'tmp_root', the 'tmp_root' is not 
added to 'fs_info', so btrfs_free_dummy_fs_info() won't free it either.

Therefore, if we jump to 'out' on failure without calling 
btrfs_put_root(tmp_root), the reference count of 'tmp_root' 
remains 1 (from allocation), and it is never freed, causing a leak.

My patch moves btrfs_put_root(tmp_root) before the error check.
- On success: ref is 2 (alloc + insert), put() drops it to 1 
(held by fs_info).
- On failure: ref is 1 (alloc), put() drops it to 0, freeing it 
immediately.

Please let me know if I missed anything or if there are any further 
improvements I can make to the patch.

> And considering you're sending quite some patches and most of them are 
> rejected, next time if you believe you find some 
> memory-leak/use-after-free, please hit them in the real world with 
> kmemleak/kasan enabled with the call trace.
> 
> I believe kmemleak/kasan more than you, and that will save us a lot of time.

Regarding your concern about my previous patches: I admit I may have 
submitted a few incorrect patches early on. In those cases, although
the proposed fixes were either inappropriate or deemed unnecessary by 
the community, the issues identified were real.

We have reviewed our previous submissions and found that most of them 
have been accepted. Despite this, we will enforce stricter verification 
processes in the future. Currently, our team enforces a strict 
verification process: we manually confirm there is a clear path missing 
a free before reporting a leak, and every patch undergoes a double-check 
by at least two members.

I am dedicated to improving the kernel by detecting potential 
vulnerabilities through static analysis. I hope my efforts contribute 
positively to the community.

Thanks,
Zilin Guan

> > 
> > Thanks,
> > Qu
> > 
> >>       }
> >> -    btrfs_put_root(tmp_root);
> >>       tmp_root = btrfs_alloc_dummy_root(fs_info);
> >>       if (IS_ERR(tmp_root)) {
> >> @@ -532,11 +532,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32 
> >> nodesize)
> >>       tmp_root->root_key.objectid = BTRFS_FIRST_FREE_OBJECTID;
> >>       ret = btrfs_insert_fs_root(root->fs_info, tmp_root);
> >> +    btrfs_put_root(tmp_root);
> >>       if (ret) {
> >>           test_err("couldn't insert fs root %d", ret);
> >>           goto out;
> >>       }
> >> -    btrfs_put_root(tmp_root);
> >>       test_msg("running qgroup tests");
> >>       ret = test_no_shared_qgroup(root, sectorsize, nodesize);
> > 
> > 


Return-Path: <linux-btrfs+bounces-7627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB2E962D68
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16691B2232E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB01A3BD2;
	Wed, 28 Aug 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="m0CITQXx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9C34CC4;
	Wed, 28 Aug 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861676; cv=none; b=eblb/djT90H44trnwcFRTLpHYZXV+CAbRPkZKhqCTtPE55vkJTIG9PjVD8xcOxntiLG10XFbIrRA9km8moYK/f3Q1dZd7SuhUnPVEeUHryFwhepvxpWXU4Q0Xhw/PDSjTmL0vuimpkk5e5GUQjPMltitBRJW7ucBajprhzeJ+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861676; c=relaxed/simple;
	bh=yY+wBYAN63Uk7C/9PTcZcyMIkfVVvJC5R1IEgFIaX2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZX17yw0+ba54zphcggeFUklH+Mim/sItniTVavWom6ag4ZfxvApouL4znGBSI+crJEUwC97Z/a6lMYGcpg68W62/zJCfytgCASIZX1ERbl3qmkH2gHRgAxwX/tQHz5Dn2OWrPAsVdnfS/qCMjVbuZ9ucqn3Uo/cg5o/EifBxng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=m0CITQXx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 86637407852B;
	Wed, 28 Aug 2024 16:14:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 86637407852B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1724861663;
	bh=+n1LrTzcJtR/ppPEGTruB6Ui6lq6iVM0t1P2PWoptCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0CITQXxySgx4kd8z06iUKs4xZOgMLksq0HnC70kfRr+qJ9nX+Tz6uZHh7lsCLuWV
	 0UgCeCq6me0sSU8DuypVDcGJhbpBfmHtgaGToUD1dpA8PAcHbvCKNIEF7QjcJkbmA0
	 WRAe9WKlLM1iWKm63CvOo46GSK4SgFrdWZPzuAEo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	David Sterba <dsterba@suse.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] btrfs: qgroup: don't use extent changeset when not needed
Date: Wed, 28 Aug 2024 19:14:11 +0300
Message-Id: <20240828161411.534042-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <8d26b493-6bc4-488c-b0a7-f2d129d94089@gmx.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local extent changeset is passed to clear_record_extent_bits() where
it may have some additional memory dynamically allocated for ulist. When
qgroup is disabled, the memory is leaked because in this case the
changeset is not released upon __btrfs_qgroup_release_data() return.

Since the recorded contents of the changeset are not used thereafter, just
don't pass it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000aa8c0c060ade165e@google.com
Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota disable")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v2: rework the fix as Qu Wenruo suggested - just don't pass unneeded
    changeset. Update the commit title and description accordingly.

 fs/btrfs/qgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5d57a285d59b..f6118c5f3c9f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4344,10 +4344,9 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	int ret;
 
 	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
-		extent_changeset_init(&changeset);
 		return clear_record_extent_bits(&inode->io_tree, start,
 						start + len - 1,
-						EXTENT_QGROUP_RESERVED, &changeset);
+						EXTENT_QGROUP_RESERVED, NULL);
 	}
 
 	/* In release case, we shouldn't have @reserved */
-- 
2.39.2



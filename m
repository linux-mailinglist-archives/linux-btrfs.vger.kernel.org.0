Return-Path: <linux-btrfs+bounces-7566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0506C9611BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F531C2311A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2EA1C57BF;
	Tue, 27 Aug 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="W4KF0RGN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938F1A072D;
	Tue, 27 Aug 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772164; cv=none; b=nEbYftbGPYwacDEmcgqXW4O2dsLXHV6+aai6OCOPxz7asHaVIZwaXXh+SKiIR3MTaVfU311hAiAPMEIrhUMEUWrFgqpt3t8ghAOMD0mV9qQqw19h5E0sSkgUCn4BeVlKqxA1pqh4S7EtJ+YrcXc7XQE53ynlD2K6gYqEUDt3zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772164; c=relaxed/simple;
	bh=uX2VF1ISl15ZvFiOQ8kAznCsbp8tplhrTRlmCK22HiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F4P4tYjT4v7Zc326+mYzm98hVWGZVVArBfz1nQGlShvyLwfomAorGAKav4wZYcnRS/4n6BdzIgdJKSzh4k4ZyHupGTlD9AibjORJJb3AUzwV3repx/83W1DjM3FdUqjlXezjoksGjkgXHazII5MEXG6hiMmwPKVNsCtuPGJ00Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=W4KF0RGN; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1214840B1E79;
	Tue, 27 Aug 2024 15:13:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1214840B1E79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1724771614;
	bh=5W38TwAm/xm3LEpuuE3aTN7FkHlJ4T793ps5j3TMybM=;
	h=From:To:Cc:Subject:Date:From;
	b=W4KF0RGNIRlmPn4U1pYvfTblFtPVcoUVKSQ3nhjgds0Lv6oKbjkoZSeV6oXyq4Udy
	 mzwDaq2CX5sNGUKCpusoPnLnNHQ6AxaHAvqv7se8zo47HnAp5Td+ogOM2v4sgfWQy0
	 mIL4c37zfGXwvXUDrp3u/MMqvwK+i9NFQ4T/BE1c=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: David Sterba <dsterba@suse.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: add missing extent changeset release
Date: Tue, 27 Aug 2024 18:12:43 +0300
Message-Id: <20240827151243.63493-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extent changeset may have some additional memory dynamically allocated
for ulist in result of clear_record_extent_bits() execution.

Release it after the local changeset is no longer needed in
BTRFS_QGROUP_MODE_DISABLED case.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000aa8c0c060ade165e@google.com
Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota disable")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/btrfs/qgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5d57a285d59b..4f1fa5d427e1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4345,9 +4345,10 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 
 	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
 		extent_changeset_init(&changeset);
-		return clear_record_extent_bits(&inode->io_tree, start,
-						start + len - 1,
-						EXTENT_QGROUP_RESERVED, &changeset);
+		ret = clear_record_extent_bits(&inode->io_tree, start,
+					       start + len - 1,
+					       EXTENT_QGROUP_RESERVED, &changeset);
+		goto out;
 	}
 
 	/* In release case, we shouldn't have @reserved */
-- 
2.39.2



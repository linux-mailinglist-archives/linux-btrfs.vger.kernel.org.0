Return-Path: <linux-btrfs+bounces-1201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC48822B6C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5368AB232C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8F18C24;
	Wed,  3 Jan 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jIELgv8R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A2E18C08;
	Wed,  3 Jan 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id DDEE840F1DDD;
	Wed,  3 Jan 2024 10:31:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DDEE840F1DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704277908;
	bh=ATVmhgg0EGQ8+kx8YSDYDd5FGVTMUjphxtGXvmXrX8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=jIELgv8RSLOsnL8WW8pVFFNDcK2dIsSYuafpZ9Yjd90IVFMkiKYNv15sm8XIGKsaV
	 BdPGfreSc7IxQXuXkr1lo7ViCZ/hOMtJym1onr+MiVXBVb0vZT1vBIbOEIwea1QCFh
	 rl+ibCedpRc6EQpwW0ik+lHWQKqFDg2Oz04/rnHU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com,
	syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: ref-verify: free ref cache before clearing mount opt
Date: Wed,  3 Jan 2024 13:31:27 +0300
Message-ID: <20240103103128.30095-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As clearing REF_VERIFY mount option indicates there were some errors in a
ref-verify process, a ref cache is not relevant anymore and should be
freed.

btrfs_free_ref_cache() requires REF_VERIFY option being set so call
it just before clearing the mount option.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
Reported-by: syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000e5a65c05ee832054@google.com/
Reported-by: syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000007fe09705fdc6086c@google.com/
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/btrfs/ref-verify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 6486f0d7e993..8c4fc98ca9ce 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -889,8 +889,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 out_unlock:
 	spin_unlock(&fs_info->ref_verify_lock);
 out:
-	if (ret)
+	if (ret) {
+		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+	}
 	return ret;
 }
 
@@ -1021,8 +1023,8 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		}
 	}
 	if (ret) {
-		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 		btrfs_free_ref_cache(fs_info);
+		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
 	btrfs_free_path(path);
 	return ret;
-- 
2.43.0



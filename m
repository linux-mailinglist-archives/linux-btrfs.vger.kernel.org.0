Return-Path: <linux-btrfs+bounces-17187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC4BA0156
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7449819C2853
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22BA2E0B4B;
	Thu, 25 Sep 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="ULfV1DeA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6312C21D3;
	Thu, 25 Sep 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812039; cv=none; b=CurkSFoj53emQGkwsNqzUPQqaAwlUFYR76Yav4P2XbJZNKDlkAyXIXM81upgazfRdwqWATN766ohVO6ShB1NKm7vrSn8hXhJajR8kvUj17xRmHLio4eCqQXn2zzhVAXe6/Er/Q139vpyU7WJ9/vpoAn7/0l5Ok3/3wK2r+f2PvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812039; c=relaxed/simple;
	bh=AM5WILHBelS/Whs4JFXa3rXYafBN+qDDE98pmu37z0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i5nbXGqM2ish0Nfv4ftDlXTE9iA7a//y5lzKeX5P/h0WH6nhOjBaeEqdP5EeyZBh07VvVz5SiVJJQfiIsenYMYfVH1J6FBDESdf7dQ3UfqrVjeaMz0whRT7VuXivvVI6TVEr5mYn7w1yfYYbfuF4oEeKBgQ4gCsr/X7Rq7N6UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=ULfV1DeA; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cXcDB2yHnzB0lD;
	Thu, 25 Sep 2025 16:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758812026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A6TZdmI0AWwAqbGk1gFFoWIZdnjU5cD0TQRufQSrKvU=;
	b=ULfV1DeAnofIky4SLlT+bM1uh8YLTuxud9RVwMNyIc079VQ0JQfPqF2XWPdBsQya/hJ9lU
	fVEtp6pdyWJ+t0Aigu2dVgS0LjORrGaCSIw4OXfP2k9tIGhacvX6XJEfFCPeb6615P6uDd
	XL/UQn6whQF3zxTY+vRkkGISKtq4ujBI2SyBE3mepShyqzQBP/UHcajVi4gh2BAkg801aS
	fYk9FF8SOyf0lZ4R+JEJ8ht3UYaPP/8lgP8YP1drIFpunpnQay41KTSMxsuHPhPaHfK9LA
	Vt92PzgIERJ5C1agh5DIkL5zpN0LD2ZXwpoj/1GeKS5WaskiCrcwUpbb7Gn8Mg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] btrfs: ioctl: Fix memory leak on duplicated memory
Date: Thu, 25 Sep 2025 16:53:31 +0200
Message-ID: <20250925145331.357022-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cXcDB2yHnzB0lD

On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
provided by the user, which is kfree'd in the end. But this was not the
case when allocating memory for 'prealloc'. In this case, if it somehow
failed, then the previous code would go directly into calling
'mnt_drop_write_file', without freeing the string duplicated from the
user space.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 185bef0df1c2..00381fdbff9d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 		prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
 		if (!prealloc) {
 			ret = -ENOMEM;
-			goto drop_write;
+			goto out_sa_drop_write;
 		}
 	}
 
@@ -3775,6 +3775,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 
 out:
 	kfree(prealloc);
+out_sa_drop_write:
 	kfree(sa);
 drop_write:
 	mnt_drop_write_file(file);
-- 
2.51.0



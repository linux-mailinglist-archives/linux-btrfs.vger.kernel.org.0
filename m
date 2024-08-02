Return-Path: <linux-btrfs+bounces-6959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A6945D95
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 13:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94566B23194
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15EF1E2889;
	Fri,  2 Aug 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UCs3qFfW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300F1D1F4B;
	Fri,  2 Aug 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599981; cv=none; b=CIkgYJsBDV+/G5JAsL5obMw9a0jhmL9K/fdqaaDIy7hdkUj7DgFVjBv/A9ePPoCEeDw0OSt/R+qc6wd/QpzSLFoF8HpPS6wOMaE9rsxT8RvkfRjHwt2tai+L5NazJZjCmMQUmgXDr9kJN9SAaAdC7z3FHvbcZwP0zKL1ZAU2GO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599981; c=relaxed/simple;
	bh=cmfLiP9sSrSBnm7FdZkGb5nve48YSwb5o/62GizcNRM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DywyOA+97dzIf7dDaSmdKVbK4g++QaupXWaDsjAuOXOVr+UxdOczuuH6zVWwxhxvMmdBrAOOFc+Rvuq25t5kDgIxfLfO8a+tsm66YpMvhtfrMgOHB25eR2kHFBBwa2QP8WGpEYwwn5eqy7ASlmq186jOvXSlozDKPmZw4gCSmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UCs3qFfW; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722599669; bh=+v/LrVZSanD+laRZx4IcWHZVT5zpt89cEWuBN6TiN8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCs3qFfWTJfhgKzj1qlPcy28cyHDOlT+pBgdrTZdjuNpNkpLAdPwvdSL9suKai4Jp
	 Op3OA4kfBLJbkDYn7n5BYOKzxwHViEgYq2E5k9lk01UGJEcaXusMhBIzzWLSje6yED
	 CIUnFotXoCaniGDvxkbzDpG425ZEy3FpvHv3zz7E=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id D9A310C4; Fri, 02 Aug 2024 19:54:26 +0800
X-QQ-mid: xmsmtpt1722599666tmpjq2red
Message-ID: <tencent_8F5362E361A97883B8444B1763F777C6DF05@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wiVmMAq+zrkyD3G91jeGqxua/XnuLIqywI+TVZOJsQ5+FFv5rja
	 7MYYl8ovDhNPfje+dKHfJ7O8viw6hNAttloexDFBa+imd+CahZ3mw4PPradfnxYAHGTNQ1nooI7l
	 Cz4Qa1OKGgt0u17dYMYJZzG/kaR3iFWF3pj79tpqqcWklMUPU0XMDd6Wd3VfR0VmMBx8KY0ccYsZ
	 kVw8tL27zSNWtS+PQoNI+Koc5ddgoX5QfZ+GGBuGomOTBxEu8qKWbDlNWJBvvtEGjvDUXIDIJnKl
	 /L6DhXjFb9kyVz1rSk0Ui4P84bTen9qavxQtmmgjYnRGiTB8Oo7kR16ZHOMkV/P1gx/OH7qFmsZn
	 qU1Gk2zlVAKA4vI+2NpAZL8/gLqasWGBlmFOYHNOYXz3hczS/vpMC/4w+ceQJV9pDyLuaGzBfZw7
	 ZHkMCNb7a1EmqbE+aB7itTGpUt1afxV1X7LMXl18BMvqhadINF+LwDaRfNgLLsBCbD7CeioQX/jb
	 myi6I0HyNIendxZ2INjxetsz4EmXsMAxv4ZRWvyOuav7fws22Aa1PPhVc7ICMly/6mYbrTW777DW
	 /UN/LwMSji6UKB6Uiz3SNzxJmQTEkkXIePg+T9whB05DaWFg2maTB1TP03qp37pvBIQImQHBt0ND
	 cGx6dTf/Tel/4bWLE+6YVmXBqb64H4GQzegUMaCIWSb6rIGCJgcGJNMEq2SnVoQCnMLOs88c41AQ
	 UzSw6+aPcMn8OvQLsWqV43usBUdgECIgOEBON5PY1IPfJLHqnke0MIqCtQSpyKkdKjkXN+y/mPSe
	 iNqzR1M95HfSzZUkJJ7RlkXpk3ojANEPQhypLw0mcRc5LKqfPdWb8LNV+YGpkstKK4L63n6ikwku
	 MZlJjrmxFS2Hx1nMxruA6O+dkfOW5MS5s/YTBtMDXIqwwSoLwoW8A18P6N8WGCT4YQ5nFO7au0
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@suse.com,
	hreitz@redhat.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: Add missing skip-lock for locks
Date: Fri,  2 Aug 2024 19:54:27 +0800
X-OQ-MSGID: <20240802115426.1122610-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000dfd631061eaeb4bc@google.com>
References: <000000000000dfd631061eaeb4bc@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 939b656bc8ab missing a skip-lock in btrfs_sync_file,
it cause syzbot report WARNING: bad unlock balance in btrfs_direct_write.

Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
Reported-and-tested-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7dbbb74af6291b5a5a8b
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9f10a9f23fcc..9914419f3b7d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1868,7 +1868,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
-- 
2.43.0



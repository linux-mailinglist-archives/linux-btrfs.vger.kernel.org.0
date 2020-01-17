Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F151140BD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQN5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:57:54 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40227 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQN5y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:57:54 -0500
Received: by mail-qv1-f67.google.com with SMTP id dp13so10715705qvb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymq9Sjhu+0hGN1UeQTEnbI4Azp2dHl3k+R5KCuSvon8=;
        b=VQLhVEYPzbE2ZiovhS7Qk4BRWKXe6X+eKLBXqGZJQpJ5PFsWjxuPuFSC0Y4GrNxWQ8
         qUxDtjYO9BI+SaofWFehqWIMeF+RV7q6kdena2Xap0/ngV4izAQOhxtreDPFhqV0ixqI
         gEZhy6AcXBpv10xuRxOzOgqFsseFtThp7wiLG4EDI+8yT+Q3cD2NVed4J+6+GKghVwJF
         MZlyqFy+4db53RBtbncn/OFL/VORpAjkSBqJsZlM4O+SYaFkp4+UZ2KPht6coA8wgEBg
         w1oLjkZjsX5iyz2La39hVrcIFWN8udDoYR3aYBhYyxcENYWUNKTELhnieVbr7FIdZxjs
         gyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymq9Sjhu+0hGN1UeQTEnbI4Azp2dHl3k+R5KCuSvon8=;
        b=f9SbsPK7pq/Kv/VyeIxZuxjJ8i57plenahkhpkD2mmX60dlqugRYw8dRFq7iDFzEGN
         XifX/fPzDrw3qOpN+GwPziFm7nx5y5oBaIb01VqgV914RS+9RM6hMXS3cXuTK/SdcFhs
         GuugMwe0OE/Whz3enxcg0wGtBCzJcPGSC2ObuQzW3LXCwbbQWaicupJvpeVdLYhMMdHR
         lZ1rQAhnJ0ieiRB2Pfl/FxlUOud6aPYP1w7kXOkc2aLMX4nySARZWFwfDKa/IjJZU6KN
         YdWguaHJDvk+slIYMh/wewANuoAUcYA+2+pNRkZwLX3EtnPti48i0I4LtWmkXm1JB9CE
         lgmQ==
X-Gm-Message-State: APjAAAVQBxBe8ogHeKB/GlzBnE2oq+kDDcycyyvmGwPTnEJfJcrCC0bX
        wqKJNhIc1hWI/VonQE7II/QcAQ==
X-Google-Smtp-Source: APXvYqy5cmFb5lsQLm+hLtee6eNDJV9gEeC8Xhlibd+S9lJaUfIAlHuEtur3veWaqu+XJ7zsiU9RvA==
X-Received: by 2002:ad4:42d1:: with SMTP id f17mr7955497qvr.30.1579269472977;
        Fri, 17 Jan 2020 05:57:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g81sm11812743qkb.70.2020.01.17.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:57:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH][RESEND] btrfs: set trans->drity in btrfs_commit_transaction
Date:   Fri, 17 Jan 2020 08:57:51 -0500
Message-Id: <20200117135751.42036-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we abort a transaction we have the following sequence

if (!trans->dirty && list_empty(&trans->new_bgs))
	return;
WRITE_ONCE(trans->transaction->aborted, err);

The idea being if we didn't modify anything with our trans handle then
we don't really need to abort the whole transaction, maybe the other
trans handles are fine and we can carry on.

However in the case of create_snapshot we add a pending_snapshot object
to our transaction and then commit the transaction.  We don't actually
modify anything.  sync() behaves the same way, attach to an existing
transaction and commit it.  This means that if we have an IO error in
the right places we could abort the committing transaction with our
trans->dirty being not set and thus not set transaction->aborted.

This is a problem because in the create_snapshot() case we depend on
pending->error being set to something, or btrfs_commit_transaction
returning an error.

If we are not the trans handle that gets to commit the transaction, and
we're waiting on the commit to happen we get our return value from
cur_trans->aborted.  If this was not set to anything because sync() hit
an error in the transaction commit before it could modify anything then
cur_trans->aborted would be 0.  Thus we'd return 0 from
btrfs_commit_transaction() in create_snapshot.

This is a problem because we then try to do things with
pending_snapshot->snap, which will be NULL because we didn't create the
snapshot, and then we'll get a NULL pointer dereference like the
following

"BUG: kernel NULL pointer dereference, address: 00000000000001f0"
RIP: 0010:btrfs_orphan_cleanup+0x2d/0x330
Call Trace:
 ? btrfs_mksubvol.isra.31+0x3f2/0x510
 btrfs_mksubvol.isra.31+0x4bc/0x510
 ? __sb_start_write+0xfa/0x200
 ? mnt_want_write_file+0x24/0x50
 btrfs_ioctl_snap_create_transid+0x16c/0x1a0
 btrfs_ioctl_snap_create_v2+0x11e/0x1a0
 btrfs_ioctl+0x1534/0x2c10
 ? free_debug_processing+0x262/0x2a3
 do_vfs_ioctl+0xa6/0x6b0
 ? do_sys_open+0x188/0x220
 ? syscall_trace_enter+0x1f8/0x330
 ksys_ioctl+0x60/0x90
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x4a/0x1b0

In order to fix this we need to make sure anybody who calls
commit_transaction has trans->dirty set so that they properly set the
trans->transaction->aborted value properly so any waiters know bad
things happened.

This was found while I was running generic/475 with my modified
fsstress, it reproduced within a few runs.  I ran with this patch all
night and didn't see the problem again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- Nothing has changed, simply rebased onto misc-next

 fs/btrfs/transaction.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 27a535d4bb4f..a519083461c7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2017,6 +2017,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	ASSERT(refcount_read(&trans->use_count) == 1);
 
+	/*
+	 * Some places just start a transaction to commit it.  We need to make
+	 * sure that if this commit fails that the abort code actually marks the
+	 * transaction as failed, so set trans->dirty to make the abort code do
+	 * the right thing.
+	 */
+	trans->dirty = true;
+
 	/* Stop the commit early if ->aborted is set */
 	if (unlikely(READ_ONCE(cur_trans->aborted))) {
 		ret = cur_trans->aborted;
-- 
2.24.1


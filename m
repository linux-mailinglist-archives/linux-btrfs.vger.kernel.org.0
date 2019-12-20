Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2469E127E44
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 15:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLTOjb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 09:39:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33467 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTOja (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 09:39:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so8383634qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MS1CdzzrtXne4RNYKyZWGARqKAygAvXHkBosl8mdu0I=;
        b=ShOFdBOLytkaymY4gGi/rIhImjnBxdDzJzyc8lNCsMU5D+whAg2pGzoc0HTDdKgGBM
         OjpsBOx7Z8yDmYmM671DyQNKvLwabvO93b34fjI59lRdtguPyZ/qZXu74K8vcIIEpyJe
         aqMJcEzkSahdnWdr/O9qCUAoBNy7zkWAEq6anp2Go+vWCS3ab7Tm56LrLuNMLWsSg98A
         QnQ58JvGRXGBOgKIHNP5LZcnlG9qdp9vRIq7P44p7KYwq7mX8yq/ad3OHgZ1V2TBw94a
         fUmdhomwZ7wx2UpYFWesx3cze2BXpqPVL/YH1OTtjz7/bU9UIzZN3gkSg0DF+jQN98/5
         svFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MS1CdzzrtXne4RNYKyZWGARqKAygAvXHkBosl8mdu0I=;
        b=GjIMULNIpspqNINE2TUGMkBfZpJB67nJLDQE7CUJlVJ8R/eual1kYwlY29ZVbCwN1E
         36/8rdIZVyQQQP41/viHslPuNZoWtzrJ3tBD4OtzzGUw5X0t3s2HSSdDdpxzbhXTuuoS
         VVs/Izw68Jgrog/gw3OV+Avumedrb8JOUYSKnL+yFYA4rcgKSUICinOvCinYFS97HfGf
         zFejiciDy1rWxtx8621jBnFwpsORNBv2L+nXYg7k07I3B5Mc12vchlhK2iAirKRXlhbp
         bm4pNrhwE4NPsLOuWm7wquETg3CjNLzIceDdAIP706Vf+mN8EfiEA0zhS4Z7qjf5G+e3
         GOnA==
X-Gm-Message-State: APjAAAVDlU0VY/tuuJhvP81mQxOInFzd4+8gzwUoqY5CuWqz8bIRx+9i
        wUdCY7QOZc05l9v/8S+Vr34s15mc7ayYnA==
X-Google-Smtp-Source: APXvYqycV4p48QhlXkTQZYq44GgAFP/93ClkQ7dR/8+bHit3pAuIJZRx08+tMNOmS3r8AxwHrkl32w==
X-Received: by 2002:ac8:75d8:: with SMTP id z24mr11671923qtq.193.1576852768735;
        Fri, 20 Dec 2019 06:39:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o10sm2967674qtp.38.2019.12.20.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:39:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: set trans->drity in btrfs_commit_transaction
Date:   Fri, 20 Dec 2019 09:39:26 -0500
Message-Id: <20191220143926.52200-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
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
 fs/btrfs/transaction.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2252dd967ad8..bfdd326a73e2 100644
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
2.23.0


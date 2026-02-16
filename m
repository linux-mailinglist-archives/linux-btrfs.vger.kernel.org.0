Return-Path: <linux-btrfs+bounces-21694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI3uK4uXk2lI6wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21694-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 23:17:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32954147E63
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 23:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5AED301A2AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE172DA755;
	Mon, 16 Feb 2026 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMU9wx6n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255927442
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771280255; cv=none; b=hMbNLHsT7b5eoBhhvpXiPo4a20a6dpG21AYolbh5tWjf4p35/ndRfej+IHMfgIwJ6Qll2FLXjn5hxrDfQN+VMSgshcbTCqe2D+iZuVyBnSZa7bEdbuXDZOlhnFxscFcn6awdZyHdooZND4dXQ4onkq6VpzQgURMYOAw+hNEE+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771280255; c=relaxed/simple;
	bh=NjtsnE0mKUEBs0uRzaeL+DClyCEXBupMB4mNFSaNS6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVNvvBptr1egkcOmeu6RZfOg+enPhiEPfSmvbJj+xFgRHbGqb0+IYJyXYDIfpykA/X3NT+lspbQD6l01dROPQ3Wr35ZCqVB9yw0jaC6LNdZ0iMeSURpYHIPDuc1E2SNuHnEGFlnQGmzc9PV+QWO2JkYa+YPU6OdkPUkuux8sw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMU9wx6n; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a23f5915so19461155ad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771280254; x=1771885054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKAIaxxIN9CmwcPqgGwKxiWPmmI4kX+9G0DKtHNSc/c=;
        b=YMU9wx6nZ1yD6c4VwtnHOnw1ouft0rvMwcPlBw498Izzh6SyQdMXMnZJ4JKG+wyMwn
         Q+Oqfdi6xJ9obGocAyPphgFR2r3Cf1xt4T+KMGVkjCflj3yTZTW2dNe1oUTEMZb8LmX/
         fO9dkh0zJeF80HrMX/U+el2QXZf6A/WcOtbP6REdq3ppAVxm1c8Qto2KvxuVogJdkzAV
         xIqCvlqQZQmS0mFPotu7YfasYlUz4OakFR5W6pkcBvPwVxtU0XKB+VP9U2ugVyTLsReI
         YywTLziEsoUeORKD42TIDpb/mJXsXUB4tLJT5VOj9hPQt3XKXQC2K45vr1KfC6084vC1
         0D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771280254; x=1771885054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKAIaxxIN9CmwcPqgGwKxiWPmmI4kX+9G0DKtHNSc/c=;
        b=JW2elnq8ERSNYidHWNoTRrCXdUNJ93MtIcMDaEHDwILXG+QkLFR5RWPxzG8fxLEFZw
         sKoblD51rGwaRBx4MUNi6K0QOuuoiTr+b1sw3KYM8f4J6qP37snVNBk9CoL4dr7Oal/u
         e0AsWeId1t8S4WtTq8h0On8pHJo7ysq+94lPeSOJGGv2S+sX7aJfr3CbDQxDVskSlx9w
         bgFdpVL3lN/rry90mQne1kABCJSS8nul8V/wU8dHGaXlwAxBsaeV3taUiHlMC+eSS8wY
         tYIa+AuIbd/vGy82iwjxs8qTVd/THZzids5kHpEieKbaL0NFnaI/TAV8xDxhwZu+JIAd
         EFfg==
X-Gm-Message-State: AOJu0YzVN9m3+slSD1fbOOcLVatWcdZohD1B2jATrjvkxgIusU39NThA
	1P9J4GJnGAzuYWcx4R4MmkVS1zW2DoFN4cecBs0+2fNv8JbB73mIbzrN
X-Gm-Gg: AZuq6aIj1kTE8uGTqLSiMudyiIVZ2+spxPHxHCiTyB4Nzi1tAdYEAAXiYaTZgh4TBzJ
	+gOT/dY2sQbahSdW9oP+IvAzfD/TdTopbY64jb6pCmKh2JrDbJOAKVd9id4FLUhYp1WKfOLYihT
	VYVmo0/AG3+4xnZ2FCMJZdN/YpR4CDbjkH5BdnvgR1BssbQFanEMC2hJJsmAK4sv78NfHeAKF/8
	wXPFer2jr9Eto09Y+DVVzLw2JDkfA3OYLA7jP6BIUCBtTl7u3fyAJsDp4r3B0cUENWeifYaERAT
	WtJoiSbnN9zNUthq8USHKKWnbEVMRSne3KEbKpyTQEbq8HOkZ7HvxHeIuwAnuU+5mrPpa7369vW
	B1TnLDbVV/pPRi/YtkZqbMS553H3/ET3QjXjrv9JqxvidzFgNDq+0fUiEG+hauuj6tTkMqLYUmf
	nt/zGx3knw0NuUU4g2duCpqwS2ijOHhd5m9vlY2Sg9qjxATUl8wgXJSet55bR0yUoXJIyc6x8Fd
	MLD
X-Received: by 2002:a17:902:db0f:b0:2a9:3397:2647 with SMTP id d9443c01a7336-2ab5060da04mr113511355ad.50.1771280253914;
        Mon, 16 Feb 2026 14:17:33 -0800 (PST)
Received: from localhost.localdomain (1-173-18-181.dynamic-ip.hinet.net. [1.173.18.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa229sm75952695ad.18.2026.02.16.14.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 14:17:33 -0800 (PST)
From: jkchen <jk.chen1095@gmail.com>
X-Google-Original-From: jkchen <jkchen@ugreen.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkchen <jkchen@ugreen.com>
Subject: [PATCH] btrfs: check snapshot_force_cow earlier in can_nocow_file_extent
Date: Tue, 17 Feb 2026 06:16:32 +0800
Message-ID: <20260216221632.23087-1-jkchen@ugreen.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21694-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jkchen1095@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ugreen.com:mid,ugreen.com:email]
X-Rspamd-Queue-Id: 32954147E63
X-Rspamd-Action: no action

When a snapshot is being created, the atomic counter snapshot_force_cow
is incremented to force incoming writes to fallback to COW. This is a
critical mechanism to protect the consistency of the snapshot being taken.

Currently, can_nocow_file_extent() checks this counter only after
performing several checks, most notably the expensive cross-reference
check via btrfs_cross_ref_exist(). btrfs_cross_ref_exist() releases the
path and performs a search in the extent tree or backref cache, which
involves btree traversals and locking overhead.

This patch moves the snapshot_force_cow check to the very beginning of
can_nocow_file_extent().

This reordering is safe and beneficial because:
1. args->writeback_path is invariant for the duration of the call (set
   by caller run_delalloc_nocow).
2. is_freespace_inode is a static property of the inode.
3. The state of snapshot_force_cow is driven by the btrfs_mksnapshot
   process. Checking it earlier does not change the outcome of the NOCOW
   decision, but effectively prunes the expensive code path when a
   fallback to COW is inevitable.

By failing fast when a snapshot is pending, we avoid the unnecessary
overhead of btrfs_cross_ref_exist() and other extent item checks in the
scenario where NOCOW is already known to be impossible.

Signed-off-by: jkchen <jkchen@ugreen.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 845164485..3549031f3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1921,6 +1921,11 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	int ret = 0;
 	bool nowait = path->nowait;
 
+	/* If there are pending snapshots for this root, we must COW. */
+	if (args->writeback_path && !is_freespace_inode &&
+	    atomic_read(&root->snapshot_force_cow))
+		goto out;
+
 	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	extent_type = btrfs_file_extent_type(leaf, fi);
 
@@ -1982,11 +1987,6 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 		path = NULL;
 	}
 
-	/* If there are pending snapshots for this root, we must COW. */
-	if (args->writeback_path && !is_freespace_inode &&
-	    atomic_read(&root->snapshot_force_cow))
-		goto out;
-
 	args->file_extent.num_bytes = min(args->end + 1, extent_end) - args->start;
 	args->file_extent.offset += args->start - key->offset;
 	io_start = args->file_extent.disk_bytenr + args->file_extent.offset;
-- 
2.43.0



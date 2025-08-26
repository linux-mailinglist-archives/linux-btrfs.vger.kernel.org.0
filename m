Return-Path: <linux-btrfs+bounces-16423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E70DB3738D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 22:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BED6362C9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3A72633;
	Tue, 26 Aug 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="fZo2vgOt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417784C97
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238510; cv=none; b=bPBajM/aFHxyVH5NpYxRy6jAA1Ot4Tip+C3AE89x18FHcF0pUftrQ/1MEBdn1ewWI+nMQFcmVEQLUiL/WgkV7LuyRXLvN1Uq4IJHlG3LjcnVIxqVPFt+ZQuSytJ6O/zGa+xRCBLB19NLTW+sKB4Q5Cq3JtMoY5y/ZU7ECVhHvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238510; c=relaxed/simple;
	bh=9I3NjcktR3Wlvm1F8kHRMSUDmB7mvWaFT+25/Sbj8IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxKnJ9z/Cyv4IRKjHymySXgOqsR9kgwD/TGvn7/L4rheqaiLY0bao27dVYy1gYbcR26YGi17jrW0Zqj3+MHdd3szlbauUg210pxOyjlMGYqovNo51Uq2b9/gFfGbPQ+4wzq0vEGhFF97f3QA/4JkBKs9svQtwzzKL7mCxdqxL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=fZo2vgOt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4717384710so798203a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1756238508; x=1756843308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCiH4CxV43c6JcLFty9ttM3wgWFNS57HcmAs5AKZCkI=;
        b=fZo2vgOt+rZ5c1t4Ci45EiGnfTBXaeurPO0B3xxZQdyx8Oqu7LoKcJUcwNMMsi5IIR
         Cwd6PoYxQrLL79Tf7U8iBp31xkRj3Kybno0SS8t0dr4bS3o6vBVTXELRzjbcLovN0tdH
         0Mh9SIJh6PynIumPfzF0WZ2cnWtYX23uiwmbi2jA4kZo5UWUGNW5WUbdgY+GCNz85otg
         WBOEj2sVhsU/Rx61bLW42qac+oHzpcvJu+U8Lz4Ug3bXmBxBCkonlWFEe+L5rXaLH+5M
         Kf9wfqeSkxaYSnjVT8lde4NbuFz9q3Xqq6zvJnD1OFqGpgHhTCExc5eQc0E1pNsqMdS/
         s63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238508; x=1756843308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCiH4CxV43c6JcLFty9ttM3wgWFNS57HcmAs5AKZCkI=;
        b=kq8vfGPRf+XXHe7uwbouK5ohjeHn8HB7o0Gtpr3APen1+Kd/B7W6sqxTCrVvCZE4hO
         5+rsO/A1O5BpwaJzn3Hl7RHSKR7ej7yXuaIHvjuiCVELZfFBBicmGXYu932JjOnemjEe
         qoOMSAHmTsDCTOD1RHJmPAN8GR+QgRHPtXZmoIk2jq2KeTwl+mDTNcLkGUIsaf2WLWas
         5Y8RskRiDB0uCExN4KGamHHcabcr9ED+wyUknLqJFbZGrHLQ2b9MkiQ0Mvkq6DxVxhhv
         1mHN+2qoFsBp0O97rRhojlpl2XzK7knCfd14U16gU6i8UcrgW1x7uqqBKESJpVoboit8
         0QBQ==
X-Gm-Message-State: AOJu0YxIanOEJFo7JKq2UBm0aDzLzeeqntDTaHGT4ctVYnbDMxxpBL2o
	4kIo9a90LLkzcCqc03Hx66tdMDRNnumTJ7N3oYkSMlgT/f48hg/6bk2Nmf9gELU/Ha5XX2ZtNoh
	60h/EfJo=
X-Gm-Gg: ASbGnctMRFWEOUhxzWIGJ4bP6Wy8SCyxbUudOBvYZb9kvOS1runk0KCNXOW/dUe+wxQ
	e2ChgzW08MePKD5kIsyyXqTSoT+z/PiHqKkcF6P7n3lzVsxieKFkdWlGfVasn34ZxH9sDAjivI9
	92VZqWthZ5geO2Y5EQFZuXHz+Y00zpODRBqq6ZjyhqhR0OiyP5nKTO/tO0EIgdZN4Rq7QRHtA/7
	/yymZLPdyBQLie48jCx3+GxliMxhypGBv0Lne+VCBjS98tDKYF4cRC3Vex20Mknt/DshJFdcC6S
	Mi08SS89XCdKLDCI2e9CARHNRxgU90BXINJX/e+A6wS8nPMcBrBzaJR6gPAICkhtptAIVDIf1ko
	PnDAR0iOjgITLmF/Fsg==
X-Google-Smtp-Source: AGHT+IHNeAJ6mrY59F1/9DYcTveqjGunKP0l+2bh7RVWVXK+evKqeuHQMCpfTUiITdDXJJKtCe3pDg==
X-Received: by 2002:a17:902:d48b:b0:246:5253:6dfc with SMTP id d9443c01a7336-24652537015mr111812565ad.7.1756238508269;
        Tue, 26 Aug 2025 13:01:48 -0700 (PDT)
Received: from telecaster.tfbnw.net ([2620:10d:c090:400::5:f494])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688801bdsm103468825ad.123.2025.08.26.13.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:01:47 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>,
	Leo Martins <loemra.dev@gmail.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs: fix subvolume deletion lockup caused by inodes xarray race
Date: Tue, 26 Aug 2025 13:01:38 -0700
Message-ID: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

There is a race condition between inode eviction and inode caching that
can cause a live struct btrfs_inode to be missing from the root->inodes
xarray. Specifically, there is a window during evict() between the inode
being unhashed and deleted from the xarray. If btrfs_iget() is called
for the same inode in that window, it will be recreated and inserted
into the xarray, but then eviction will delete the new entry, leaving
nothing in the xarray:

Thread 1                          Thread 2
---------------------------------------------------------------
evict()
  remove_inode_hash()
                                  btrfs_iget_path()
                                    btrfs_iget_locked()
                                    btrfs_read_locked_inode()
                                      btrfs_add_inode_to_root()
  destroy_inode()
    btrfs_destroy_inode()
      btrfs_del_inode_from_root()
        __xa_erase

In turn, this can cause issues for subvolume deletion. Specifically, if
an inode is in this lost state, and all other inodes are evicted, then
btrfs_del_inode_from_root() will call btrfs_add_dead_root() prematurely.
If the lost inode has a delayed_node attached to it, then when
btrfs_clean_one_deleted_snapshot() calls btrfs_kill_all_delayed_nodes(),
it will loop forever because the delayed_nodes xarray will never become
empty (unless memory pressure forces the inode out). We saw this
manifest as soft lockups in production.

Fix it by only deleting the xarray entry if it matches the given inode
(using __xa_cmpxchg()).

Fixes: 310b2f5d5a94 ("btrfs: use an xarray to track open inodes in a root")
Cc: stable@vger.kernel.org # 6.11+
Co-authored-by: Leo Martins <loemra.dev@gmail.com>
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Based on for-next. This reproduces the soft lockup on a kernel with
CONFIG_PREEMPT_NONE=y:

	#!/bin/bash

	set -e

	dev=/dev/vdb

	mkfs.btrfs -f "$dev"
	tmp="$(mktemp -d)"
	trap 'umount "$dev"; rm -rf "$tmp"' EXIT
	mnt="$tmp/mnt"
	mkdir "$mnt"
	mount "$dev" "$mnt"
	cleaner_pid="$(pgrep -n btrfs-cleaner)"

	subvol="$mnt/subvol"

	while true; do
		echo -n .

		btrfs -q subvolume create "$subvol"

		# Stat hard links of the same inode repeatedly.
		touch "$subvol/file"
		for ((i = 0; i < 4; i++)); do
			mkdir "$subvol/dir$i"
			ln "$subvol/file" "$subvol/dir$i/file"
			while [ -f "$subvol/dir$i/file" ]; do
				:
			done &
		done

		# Drop dentry and inode caches. Along with the parallel
		# stats, this may trigger the race when the inode is
		# recached.
		echo 2 > /proc/sys/vm/drop_caches

		# Hold a reference on the inode (but not any of its
		# dentries) by creating an inotify watch.
		inotifywatch -e unmount "$subvol/file" > "$tmp/log" 2>&1 &
		inotifypid=$!
		tail -f "$tmp/log" | grep -q "Finished establishing watches"

		# Hold a reference on another file.
		exec 3> "$subvol/dummy"

		btrfs -q subvolume delete "$subvol"

		echo 2 > /proc/sys/vm/drop_caches

		# After deleting the subvolume and dropping caches, only
		# the lost inode and the dummy file should be cached,
		# and only the dummy file is in the inodes xarray.

		# Closing the dummy file will mark the subvolume as dead
		# even though the lost inode is still cached.
		exec 3>&-

		# Remounting kicks the cleaner thread.
		mount -o remount,rw "$mnt"
		# Loop until the cleaner thread stops running. If we
		# reproduced the race, it will never stop. Otherwise, we
		# will clean up and try again.
		while true; do
			if ! grep 'State:\s*R' "/proc/$cleaner_pid/status"; then
				kill "$inotifypid"
				mount -o remount,rw "$mnt"
			fi
			if ! btrfs subvolume list -d "$mnt" | grep -q .; then
				break
			fi
			sleep 1
		done
	done

 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f91c62146982..3cd9b505bd25 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5697,7 +5697,17 @@ static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
 	bool empty = false;
 
 	xa_lock(&root->inodes);
-	entry = __xa_erase(&root->inodes, btrfs_ino(inode));
+	/*
+	 * This btrfs_inode is being freed and has already been unhashed at this
+	 * point. It's possible that another btrfs_inode has already been
+	 * allocated for the same inode and inserted itself into the root, so
+	 * don't delete it in that case.
+	 *
+	 * Note that this shouldn't need to allocate memory, so the gfp flags
+	 * don't really matter.
+	 */
+	entry = __xa_cmpxchg(&root->inodes, btrfs_ino(inode), inode, NULL,
+			     GFP_ATOMIC);
 	if (entry == inode)
 		empty = xa_empty(&root->inodes);
 	xa_unlock(&root->inodes);
-- 
2.51.0



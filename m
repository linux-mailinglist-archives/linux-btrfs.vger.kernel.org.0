Return-Path: <linux-btrfs+bounces-16856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3176B5989A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 16:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D624E3B5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AA34A338;
	Tue, 16 Sep 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLBo2LB5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0C341AB2
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031188; cv=none; b=HrMT0OxehLv7XGLBLScGV3t6vj7++clgc0OorF+cHpRU0Ym6R0jnerZpoNpB50KUeONGQj6e/4idKMDAT1YoXz95Y7twd9sU1bD35C14BpMqnpMhtEp7Q+jYTHFtl8XovN8M/pRSs9h6daTImAFVZbXviZ/JFXugUurlJ1MRMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031188; c=relaxed/simple;
	bh=zBN9BldLXuQYafbepgbsRKYJCNw2ZdSE8TIiThiLfW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVB0NU0bTTvhWKco3PhT+1pGR5/nGhcC8+wx+rSPgK4d5u4Vy3ZR7NF/PP0B9J/hOwWYeO1+DeLMuTSn/xN1FIiZ5shNDmns/BzkuH7XxEZUJbD8sR28Wf0JLAQMJiJ6yrl6/EzV2/29tJ/yWJm5fyYmq9Txz3fBTKD3I+jfRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLBo2LB5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ea115556b2so1647992f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031182; x=1758635982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=BLBo2LB5PHvFexWoLIYT5WrIPilki61efSEs5c0jKV5SbQmSndN00mauMoB88EsbHy
         EbW3RDHt6qEcAhbdRfU/nR0p3s4ponYl6Od3MsYa3toqlYwc4dPCmvXQinYcjsWKkpoY
         1OgiiIhCNypynnEVbf6HaKtZAZIkbWWGkbYJOw9CwmaKGdEyGmqorR3wDJtsmNIg8YRE
         BKy9Gtsw/o9jXEw+WYSZBaiWgv7q56SpVfUBc0goRKHiTm6Drm8X62FsntD6u0YWyDak
         Ksngv81i03MZ/WRkd+u6vWvTeo51lmVGNs53sBwSK6FgmtujqQgh7j1VFNMk147g/McU
         8Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031182; x=1758635982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=ZE4aiBwYxa7Dk8TF4UnVjVO5xKTSeiVfWEVOFEwzBdAYfkaV7AWRHOkdVZftZdiv5m
         cVG2/SGB8vKzomSyxAsXZi238HpAQeTDLVw4Ew1GoFtPxmBo1LFIc5CvTiI6LWJvhfAH
         hBVq+f5tkRtl7jC+SlgO5RMDpmsWawL+SzpeVxBfPABBAiBHkqC7KF21XkTRAw8t8+Hh
         UeKk27xTvCf+Xi9T7DnwmEhRu/78uK68eqWLj/wdkHrgZ+NSiKu7cs3OgzBxjHgKclAM
         GC0NrpGDYJlbfIxkCyOtJMdJYOScEba9xqLybAFsA0eXAIo8HKfRbIH3Z42bBF6i8k2Q
         QhtA==
X-Forwarded-Encrypted: i=1; AJvYcCVyVz+X/Ohnh+OraSMpgGzBHraBpkcvXzBhZ/Hb1Qz+ZD2ARrN4n0LFefeCTYX6QCQmi/ZnwyczOT3KGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPkrC0EXfsEaHHlWo/lOVmfmfjw0f7zOIZcuyF8JQiwAPAgHF
	5f9O2pUUsvtuiFp0Qm9UezrSf4ArgtGM7MzAwHxk+xNVFgGtnEkpojQD
X-Gm-Gg: ASbGncuK82zLnzVN53kCNefUEqR5CU8sTqhklSxlHhKEKLqpFcl3efKcnnpAlOYK417
	VWwtBzjVB9NdigHZ8hgxKsTxDVA130ctdNG3k7n8f/BDyhcltbATSy96nexJAYc27ugIoTEByam
	KM+eqnT7lyE4aSG9IpRuEm0IWlB1QvN07+aueGBZGAiZGs5l1EyV/Q3InxP+tRvbs5lMd4718nS
	8IVm+4RrVIfytneHNrC4Sq9Kog5NHqU1ETD3shoumhd3xa25etX/ISJJAPCXsBc2elRytj1qUBp
	1YMHok0eVBPuC3pH7M4eBpqodNDbYzuTggFf9cFsjW65yBpGt6Co7druC3x/CTPUOHy2xA1p3fW
	ul7Hxok/bNp9ckV6zJGKSpAJElvQ46YN//6OdaNpLPEKqLGHQjEzeKnmBWL47I0KBYxbBPurE
X-Google-Smtp-Source: AGHT+IE5shqQIUKbOw6hlw6cRTrcBtFVXG2OEPPmead9j/NTizmYAzcuhQc64qnxQ9XZRhrVFrM2rw==
X-Received: by 2002:a05:6000:310f:b0:3ec:d7c4:25a5 with SMTP id ffacd0b85a97d-3ecd7c4282emr1856689f8f.42.1758031181954;
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 05/12] netfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:53 +0200
Message-ID: <20250916135900.2170346-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

 fs/netfs/misc.c        | 8 ++++----
 fs/netfs/read_single.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 20748bcfbf59..f0f23887d350 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -147,10 +147,10 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (!fscache_cookie_valid(cookie))
 		return true;
 
-	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (!(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
@@ -192,7 +192,7 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 {
 	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
 
-	if (inode->i_state & I_PINNING_NETFS_WB) {
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB) {
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..f728aae9bde9 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -36,12 +36,12 @@ void netfs_single_mark_inode_dirty(struct inode *inode)
 
 	mark_inode_dirty(inode);
 
-	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (caching && !(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		bool need_use = false;
 
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
-- 
2.43.0



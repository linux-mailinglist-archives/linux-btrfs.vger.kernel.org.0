Return-Path: <linux-btrfs+bounces-13276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C62A97F32
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 08:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246521694F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB352267392;
	Wed, 23 Apr 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QFuhc+Vk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QFuhc+Vk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59F266B70
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389759; cv=none; b=sy15L3g2oKzVQ18ym12xitemzyA+EcoB94WolLtdX0DQWQN8q8T1z5n+6lRlhxjoNxuc+EczAkOx2qbEgq626+DoKb89L0knwFOnIFpuwJzKVlOtlgW9vc6DGzZzIRnaI/bABrwa2HODW0XpYhlicWLnKQVGwa9Yo9S8RyqFQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389759; c=relaxed/simple;
	bh=SvW8BILRp4aL+WArtiNL45aYW43S8VuHGJh+fnKuPCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRAqnree4E3PSJnA9EbjXBMMEp3WVaIeHWUeyGToGMQq8MxlXnSDm2jDDnuksiUnuiBpU+VD6KLoK6Vhva7bsr4zskssmVVKEbGjn+e3ethujry5IdAP1WpSiiR5UX6zPxBQ9ZhG9MvbbFdiJBuqn0Ze0A5J4nA26jf9/HdXYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QFuhc+Vk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QFuhc+Vk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C5EC1F38D;
	Wed, 23 Apr 2025 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745389755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Aehwt5HcWNIVxcqSTuv4bFTdmP3L5rDSqvNP89MspbY=;
	b=QFuhc+VktSYEIBPAiAMjQOW5p1XnbTFHCZykhkpj8QmLjrGyp4a0Liz5BMcdODjSWbVV6H
	l+8Asp7XuiyOSJ29RMkph5OzrVV2rDlE3r+ZrSgLY+/cPpO+74tFFq+x4WfAv/JUM7CZtx
	X0siw3AHiIxJk2Pr1jAxyCFO9Somb1s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QFuhc+Vk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745389755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Aehwt5HcWNIVxcqSTuv4bFTdmP3L5rDSqvNP89MspbY=;
	b=QFuhc+VktSYEIBPAiAMjQOW5p1XnbTFHCZykhkpj8QmLjrGyp4a0Liz5BMcdODjSWbVV6H
	l+8Asp7XuiyOSJ29RMkph5OzrVV2rDlE3r+ZrSgLY+/cPpO+74tFFq+x4WfAv/JUM7CZtx
	X0siw3AHiIxJk2Pr1jAxyCFO9Somb1s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24F6413691;
	Wed, 23 Apr 2025 06:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ycwACbuICGj1UwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 06:29:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: on unknown chunk allocation policy fallback to regular
Date: Wed, 23 Apr 2025 08:29:14 +0200
Message-ID: <20250423062914.650297-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C5EC1F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

We have only two chunk allocation policies right now and the
switch/cases don't handle an unknown one properly. The error is in the
impossible category (the policy is stored only in memory), we don't have
to BUG(), falling back to regular policy should be safe.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 20 ++++++++++++--------
 fs/btrfs/volumes.h |  5 +++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 37083708d93cb1..08b1d2661a3618 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1617,6 +1617,9 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 static u64 dev_extent_search_start(struct btrfs_device *device)
 {
 	switch (device->fs_devices->chunk_alloc_policy) {
+	default:
+		btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_alloc_policy);
+		fallthrough;
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		return BTRFS_DEVICE_RANGE_RESERVED;
 	case BTRFS_CHUNK_ALLOC_ZONED:
@@ -1626,8 +1629,6 @@ static u64 dev_extent_search_start(struct btrfs_device *device)
 		 * for superblock logging.
 		 */
 		return 0;
-	default:
-		BUG();
 	}
 }
 
@@ -1706,6 +1707,9 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 		}
 
 		switch (device->fs_devices->chunk_alloc_policy) {
+		default:
+			btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_alloc_policy);
+			fallthrough;
 		case BTRFS_CHUNK_ALLOC_REGULAR:
 			/* No extra check */
 			break;
@@ -1720,8 +1724,6 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 				continue;
 			}
 			break;
-		default:
-			BUG();
 		}
 
 		break;
@@ -5290,14 +5292,15 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	ctl->ndevs = 0;
 
 	switch (fs_devices->chunk_alloc_policy) {
+	default:
+		btrfs_warn_unknown_chunk_allocation(fs_devices->chunk_alloc_policy);
+		fallthrough;
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
 		break;
 	case BTRFS_CHUNK_ALLOC_ZONED:
 		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
 		break;
-	default:
-		BUG();
 	}
 }
 
@@ -5482,12 +5485,13 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	ctl->ndevs = min(ctl->ndevs, ctl->devs_max);
 
 	switch (fs_devices->chunk_alloc_policy) {
+	default:
+		btrfs_warn_unknown_chunk_allocation(fs_devices->chunk_alloc_policy);
+		fallthrough;
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		return decide_stripe_size_regular(ctl, devices_info);
 	case BTRFS_CHUNK_ALLOC_ZONED:
 		return decide_stripe_size_zoned(ctl, devices_info);
-	default:
-		BUG();
 	}
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0e793b9776d677..ed7aac04cc5432 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -848,6 +848,11 @@ static inline const char *btrfs_dev_name(const struct btrfs_device *device)
 		return rcu_str_deref(device->name);
 }
 
+static inline void btrfs_warn_unknown_chunk_allocation(enum btrfs_chunk_allocation_policy pol)
+{
+	WARN_ONCE(1, "unknown allocation policy %d, fallback to regular", pol);
+}
+
 void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
 struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
-- 
2.49.0



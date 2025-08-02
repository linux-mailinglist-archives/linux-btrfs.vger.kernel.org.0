Return-Path: <linux-btrfs+bounces-15796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44ECB189E4
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 02:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39A4587EF9
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419C18B12;
	Sat,  2 Aug 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h/bDqvdj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h/bDqvdj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F833207
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094411; cv=none; b=lJpbO19U5NXefQpqw7zMxJcbGB88SMXgFptVX72DvMuAR6PAAcKV8Dtm1CzktLyDIo0hDe9prD1A09tJESmf8O7gnUrNnaxnBxkbvxkO3V3yH4TjKCjSQft+ErSXnjevXzKYghaxSujNNQlJKY7SCeQeQu9EAYYYo+a3V5hBu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094411; c=relaxed/simple;
	bh=zEVU/RGFqeBbCqm1m+58kZ2RW5z0/Lz+3dSgQQ6H9uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahw/ahorxH+o1LriPJYpAdU4UULN1DqIv44JMnmpfS0KUZKmhsRhnFSyPXpjzg3bxUoiXAdrco91BWNKacwhxfwZVCgesB0j9x1GPGdhPWOcyg33ULpQOfg0B9IQpdzH8dgun03RwXQcPxhgrC4Xbn9hLaBsTZt/QWGlngaNC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h/bDqvdj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h/bDqvdj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92EAB21A33;
	Sat,  2 Aug 2025 00:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754094401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJIS4BY6w/BhpwKdNq+CpHrAolyvHH0UdrlKsMEPMmk=;
	b=h/bDqvdjofn3dllBK7ISY1QOPjHeFYtzxAOZej5fEggTCxiaDuV+B3WCU1lXViWHuOQ4n0
	mIVgzK6q2iuPZvx6dST69kaZtP2ux8HEAu1fUlbuta/b2fNGM0Ig4tq5nw8mEr/DD07SMA
	xy/yX0w4EvKlVsbioiVDAWCbVXvYU6Y=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754094401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJIS4BY6w/BhpwKdNq+CpHrAolyvHH0UdrlKsMEPMmk=;
	b=h/bDqvdjofn3dllBK7ISY1QOPjHeFYtzxAOZej5fEggTCxiaDuV+B3WCU1lXViWHuOQ4n0
	mIVgzK6q2iuPZvx6dST69kaZtP2ux8HEAu1fUlbuta/b2fNGM0Ig4tq5nw8mEr/DD07SMA
	xy/yX0w4EvKlVsbioiVDAWCbVXvYU6Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93BA8133D1;
	Sat,  2 Aug 2025 00:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UMiQFUBbjWjnPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 02 Aug 2025 00:26:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 2/2] btrfs-progs: check that device byte values in superblock match those in chunk root
Date: Sat,  2 Aug 2025 09:56:20 +0930
Message-ID: <8783bbbe3aa4b8114f14c712f6beea24271582ef.1754090561.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754090561.git.wqu@suse.com>
References: <cover.1754090561.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

From: Mark Harmstone <maharmstone@fb.com>

The superblock of each device contains a copy of the corresponding
struct btrfs_dev_item that lives in the chunk root.

Add a check that the total_bytes and bytes_used values of these two
copies match.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
[ Change the error to warning ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/check/main.c b/check/main.c
index b78eb59d0c50..5449bf016f39 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8593,6 +8593,7 @@ static int check_device_used(struct device_record *dev_rec,
 		if (opt_check_repair) {
 			ret = repair_dev_item_bytes_used(gfs_info,
 					dev_rec->devid, total_byte);
+			dev_rec->byte_used = total_byte;
 		}
 		return ret;
 	} else {
@@ -8650,6 +8651,28 @@ static bool is_super_size_valid(void)
 	return true;
 }
 
+static int check_super_dev_item(struct device_record *dev_rec)
+{
+	struct btrfs_dev_item *super_di = &gfs_info->super_copy->dev_item;
+	int ret = 0;
+
+	if (btrfs_stack_device_total_bytes(super_di) != dev_rec->total_byte) {
+		warning("device %llu's total_bytes was %llu in tree but %llu in superblock",
+			dev_rec->devid, dev_rec->total_byte,
+			btrfs_stack_device_total_bytes(super_di));
+		ret = 1;
+	}
+
+	if (btrfs_stack_device_bytes_used(super_di) != dev_rec->byte_used) {
+		warning("device %llu's bytes_used was %llu in tree but %llu in superblock",
+			dev_rec->devid, dev_rec->byte_used,
+			btrfs_stack_device_bytes_used(super_di));
+		ret = 1;
+	}
+
+	return ret;
+}
+
 /* check btrfs_dev_item -> btrfs_dev_extent */
 static int check_devices(struct rb_root *dev_cache,
 			 struct device_extent_tree *dev_extent_cache)
@@ -8671,6 +8694,18 @@ static int check_devices(struct rb_root *dev_cache,
 					 gfs_info->sectorsize);
 		if (dev_rec->bad_block_dev_size && !ret)
 			ret = 1;
+
+		if (dev_rec->devid == gfs_info->super_copy->dev_item.devid) {
+			/*
+			 * This dev item mismatch between super and chunk tree
+			 * is not a criticl problem, and CI kernels do not receive
+			 * needed backport so they will cause mismatch during RW mounts.
+			 *
+			 * SO here we didn't record the mismatch as an error.
+			 */
+			check_super_dev_item(dev_rec);
+		}
+
 		dev_node = rb_next(dev_node);
 	}
 	list_for_each_entry(dext_rec, &dev_extent_cache->no_device_orphans,
-- 
2.50.1



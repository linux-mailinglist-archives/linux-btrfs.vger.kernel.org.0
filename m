Return-Path: <linux-btrfs+bounces-4358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E238A8604
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7ACB21727
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581B1420A9;
	Wed, 17 Apr 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Q8+dpn5k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A853801
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364570; cv=none; b=pT/LfcsrUglkWZVWpXWkgepEYRTuSDGvrO37AH1x6vCc8mugTaqm5NQwpE3iHPjupJ9G2nSu5uW/UPujRmua2ectepBSYg31pWHf9NjGeKlTilI9bO5LS0M00J1rMyMfg/c+etSdu9sqUk+77M2sJZEATJ3wdSxXc/f2/lH2JDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364570; c=relaxed/simple;
	bh=KuDGSK6cEDUEFM8xPYyaEziu9aBv5wsFA+cFbTRKVmc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXE7nzRjC9ppTy1C37C8fI3t37l6jF3TwidZaHSSu/tC15kC1MKTXVsVSerSxTBxC7kOkNfQHwvFDt2sAu0lhd9qzbxCzea03inuCzpBesqpmOY8Hc3WurIS2iS6laLADMM6ElkgMsJ/00Ec+CEevxfPXc2cr7CFOaWFUtGLQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Q8+dpn5k; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78f05e56cb3so18651185a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364567; x=1713969367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3LNDYaPKTgHmjH2Yl1+sKVlSw3InI9Wgw4nB5RHABI=;
        b=Q8+dpn5kmL7qUIIc7X0rBtfFIsarbI+OLX6nyzjGR6fQTkgMO3olKBdjIb/wzZU8Ws
         XpeOStnzyoOjE4YIIHXf7gMYdgrX6lzidd2Y5VvQESl3Sd6JVyVz2kI1ophRa+gPfpVA
         MZ4cSQOzTFQrPDgyDcw31o3F2geBBTkwB02+J2n6fy4Hg5oaRTHDkKMAB0s+37bAfxD/
         1iu8Fav6isnLB00OHL2svizL54J8dZxifQhmKNdU2w4bxLH7E35TjsByLPq1f4ypMnMd
         EONuDwSE1HYzJBhk7mTrHM47wEYuXvJeaLad4JwT3KyaGvHf22U1/H1zDGGTGsh6WyFa
         WOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364567; x=1713969367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3LNDYaPKTgHmjH2Yl1+sKVlSw3InI9Wgw4nB5RHABI=;
        b=f5dXmaOZBB9ABRsIZ0ilsoEyCc4lXse957qeZ7yXyCroGOmn1V+9NyCpW+3JLUs1Pp
         mJVkazlHYeZZEbAvtnqVHurnz6FKSrKtqGimlKg+2tIqMw9jtlXKCNbMTZk6yuaRtP6r
         FyV6KDGgaZoGcidb1F6hK1O1evIp5i/9gBH3+/Q70sguAh02HtAtD1kq4/6lo91JYKqL
         9Zri0YtSVUB7NjnpfgUqCE+v4RiML0nNGVMfyXlRw2CWd2/B1S7AHdnNNmoCFoX4W7Yh
         RpIasI4i5JgODnKGSdd8UBN/pfxNlYC/dv/0oySsCIMS7KUugHb0Fzx8s1qFOrV66aoV
         OrgA==
X-Gm-Message-State: AOJu0Yzi4pC9cB1YxodXh37HVxI0XM/Ec5hglHwa0VhXpnYimJTw94pc
	J2cLJgFJUQJm9VNh1qMG1OAUwVE5xoSIkwsRGM7p5gS/LJIAjBvQn+ifIZtpBLNN1h5KfnH1Yic
	P
X-Google-Smtp-Source: AGHT+IHPoxXo+qvihcu2A0PpfD7rNxDeZkZJQ2LryaolrX6T+qeb63gkedEw6LC2IOVydmWMR1ncgg==
X-Received: by 2002:a0c:f512:0:b0:699:162a:b8e8 with SMTP id j18-20020a0cf512000000b00699162ab8e8mr18699743qvm.61.1713364567528;
        Wed, 17 Apr 2024 07:36:07 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id pm11-20020ad446cb000000b0069b432df140sm8384183qvb.121.2024.04.17.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 01/17] btrfs: handle errors in btrfs_reloc_clone_csums properly
Date: Wed, 17 Apr 2024 10:35:45 -0400
Message-ID: <e76b91d488261dc5a5dd3f042a55c04cdc94c7f3.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the cow path we will clone the reloc csums for relocated data
extents, and if there's an error we already have an ordered extent and
rely on the ordered extent finishing to clean everything up.

There's a problem however, we don't mark the ordered extent with an
error, we pretend like everything was just fine.  If we were at the end
of our range we won't actually bubble up this error anywhere, and we
could end up inserting an extent that doesn't have csums where it should
have them.

Fix this by adding a helper to mark the ordered extent with an error,
and then use this when we fail to lookup the csums in
btrfs_reloc_clone_csums.  Use this helper in the other place where we
use the same pattern while we're here.

This will prevent us from erroneously inserting the extent that doesn't
have the required checksums.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c        | 5 ++---
 fs/btrfs/ordered-data.c | 6 ++++++
 fs/btrfs/ordered-data.h | 1 +
 fs/btrfs/relocation.c   | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1dde8085271e..94d9a74a912c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3183,9 +3183,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		 * set the mapping error, so we need to set it if we're the ones
 		 * marking this ordered extent as failed.
 		 */
-		if (ret && !test_and_set_bit(BTRFS_ORDERED_IOERR,
-					     &ordered_extent->flags))
-			mapping_set_error(ordered_extent->inode->i_mapping, -EIO);
+		if (ret)
+			btrfs_mark_ordered_extent_error(ordered_extent);
 
 		if (truncated)
 			unwritten_start += logical_len;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 03b2f646b2f9..1fe64625d006 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -294,6 +294,12 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	spin_unlock_irq(&inode->ordered_tree_lock);
 }
 
+void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered)
+{
+	if (!test_and_set_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
+		mapping_set_error(ordered->inode->i_mapping, -EIO);
+}
+
 static void finish_ordered_fn(struct btrfs_work *work)
 {
 	struct btrfs_ordered_extent *ordered_extent;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 34413fc5b4bd..b6f6c6b91732 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -203,6 +203,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state);
 struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 			struct btrfs_ordered_extent *ordered, u64 len);
+void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7e7799b4560b..0ef84dd5762e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4411,8 +4411,10 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 	ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
 				      disk_bytenr + ordered->num_bytes - 1,
 				      &list, false);
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_mark_ordered_extent_error(ordered);
 		return ret;
+	}
 
 	while (!list_empty(&list)) {
 		struct btrfs_ordered_sum *sums =
-- 
2.43.0



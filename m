Return-Path: <linux-btrfs+bounces-8633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C5993BCA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 02:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B785284AEC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 00:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2470111AD;
	Tue,  8 Oct 2024 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNelfpbb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6266C148
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347327; cv=none; b=ueoFPcXrqOuQz5HC1crXROr+mWkX0ZqeXtNq5JPYDgdRBDsEe6urKS4zxSKzgioQQL9WyJzesmsUrwwvgL+/my5njZkgfHhaqWF0gIR9O8eRbNeS41UzN5NrgbHzqIhLFEbAdKzybGEA0cvO252EaTnFH2Z6mnEgS7NbJ45/qt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347327; c=relaxed/simple;
	bh=tMKwIfEqDC2CcRuFj7V/i4ZDx2ncXTo0kTM8V2a3MHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBJYDgaAsCzi94ETl4qac1TpeXqC2HRZ5bPgtCb4fqs6AAo7yrEgRCyJ6bYx2RlBhUnzNror/1AhZuMg/j+nfRvPwMCbgdXYiHx+ApHMHcxJ16sPq2FwTHUVIEX01YyD+kkg3Sad2bYFSFRDiM5IK11veTWJmuINne5FA9/UAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNelfpbb; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7c3e1081804so2274389a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 17:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728347324; x=1728952124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRlDen1x04WLqn4bdS5L9+9UdbeAOT6cyt5e05ZYNdY=;
        b=LNelfpbboz2DkzxBEkh4WwviOPxXecYtQ4v689gPoHgvkglpA2lZCwx/EoLVtnrOyo
         Jjd5KNX7b+2JmlnAZTCP5z1+fKSnFFu6vlFm4OiC8R2uxDUMK2qXzUW5/V4VOrdsXSiu
         +ANXgDXa/aJiQ4AFdN5n9bBJoJJh27lsrdDzL8COpmShy+AEw+WUDZraXr2HJP2ZsGQ8
         OIKrrLRimfG6x19XS1UCcVY0n8RAWQAgf5lCnMWW8eY+MYRMYfc5uACIDVXCckzQh3pW
         5ER2V8QoTHnFKPNJLUp9AI/UtKedBb3UKOmFQAvZioUmsQXP8/UbA91DY+uDljE9nfgH
         VMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728347324; x=1728952124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRlDen1x04WLqn4bdS5L9+9UdbeAOT6cyt5e05ZYNdY=;
        b=LsMEF8Z7HIWfM3trvzGzAFkI1kBZ6st1Zby4JI+Wl1GWs4Oxw0KapJLrAUOVB1lKl8
         OC4ifdnUqj/3EqrLPkoE6OYpyieGHN9mCZHVuhSwmzXV9cEYFu7oSicxFxxb8c7+la7D
         ZWFxQgNEdKhZVPDZENSje8Vc+AH8SlO5MhFMbCdxKvDeSoGPVs31mxUwU+MzcFo0nKqp
         elP4LuNT2ZrwiSiTdhQYBxzkgvrLX0whP807XCxc8l6wfarZk5YwWuUZc9SEX3FK6APK
         A4H8PoQACzRT2RS+e6qDOZU0+nzm+DfLVMiTggnnMFvp7EcLZcdaD80TSu0NwuFMhXES
         kndw==
X-Gm-Message-State: AOJu0YyX+jE+j5Uu3e0nb5qe6sLa6k+sHsftdrB11kxiwZ6D9h6bf0Vv
	BZUWmnuPwmSqS+TTzwARu12esvyZi8fT1CqrdRrR5ng8PHemvhc9AUUouc2/
X-Google-Smtp-Source: AGHT+IGdSVt+p/jQWpe69olpioup7f7VFQDZAtV6D7PCtg8okvRWv7q0g5F0V8PUqW4Qhf9zf2m1tg==
X-Received: by 2002:a05:6a21:3414:b0:1d4:fb0c:613 with SMTP id adf61e73a8af0-1d6dfa27e78mr17016711637.1.1728347324299;
        Mon, 07 Oct 2024 17:28:44 -0700 (PDT)
Received: from localhost (fwdproxy-eag-007.fbsv.net. [2a03:2880:3ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd16a3sm5005355b3a.59.2024.10.07.17.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 17:28:44 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 3/3] btrfs-progs: free-space-info tree-checker
Date: Mon,  7 Oct 2024 17:27:48 -0700
Message-ID: <41fc4441860cc2769fd11c236067ff979547faf7.1728346056.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1728346056.git.loemra.dev@gmail.com>
References: <cover.1728346056.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new check in check_leaf_item for btrfs_free_space_info. This check
performs exactly the same check that is performed in btrfs check. That
is it searches for the block group that the current free-space-info
belogns to and warns if there is none. When I was testing I found that
sometimes this would be called before the block group cache was
initialized leading to incorrect warnings so I added a check to make
sure that the cache was initialized.

I also chose to not return an error since this bug does not really affect
the ability of the system to function properly.

I'm still not convinced that this tree-checker is helpful or necessary
so if anyone has any opinions I would love to hear them! If this is
deemed helpful I will send out another patch to add this check to the
kernel tree-checker.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 kernel-shared/tree-checker.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 0be8f022..cf2e389e 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -1737,6 +1737,32 @@ static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_free_space_info_item(const struct extent_buffer *leaf,
+				      const struct btrfs_key *key, int slot)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_block_group *bg;
+
+	/* block_group_cache is uninitialized at this point */
+	if (!fs_info->block_group_cache_tree.rb_node)
+		return 0;
+
+	bg = btrfs_lookup_first_block_group(fs_info, key->objectid);
+	if (unlikely(!bg || key->objectid != bg->start ||
+		     key->offset != bg->length)) {
+		generic_err(
+			leaf, slot,
+			"We have a space info key [%llu %u %llu] for a block group that "
+			"doesn't exist.\n"
+			"This is likely due to a minor bug in mkfs.btrfs that doesn't properly\n"
+			"cleanup free spaces and can be fixed using btrfs rescue "
+			"clear-space-cache v2\n",
+			key->objectid, key->type, key->offset);
+	}
+
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1798,6 +1824,9 @@ static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_RAID_STRIPE_KEY:
 		ret = check_raid_stripe_extent(leaf, key, slot);
 		break;
+	case BTRFS_FREE_SPACE_INFO_KEY:
+		ret = check_free_space_info_item(leaf, key, slot);
+		break;
 	}
 
 	if (ret)
-- 
2.43.5



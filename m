Return-Path: <linux-btrfs+bounces-10295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2049EE0A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7707018894A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B420C00E;
	Thu, 12 Dec 2024 07:56:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAC20B7FF
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990161; cv=none; b=XOhUsVnfH5UGCpNtcXVr9AjzSTUZ3VIDNVKSgfmOyfQZeYRR08+j3Svc+b5pE5HrLhcMNefCVWa2dpQKusgsj6ithQXf6mAushCB9MifyuzQin+JMEG7cP6IK8+M7AvWDZTmyapYeYGHd8+8gh44dyuzffBubdgxrjH6hcnGAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990161; c=relaxed/simple;
	bh=QWLL0tgkDIWEyir+WW9TAMvbKy1a1CF2hSQstE0tTmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlzZ/f3usIzlYGM/itzwniACF7NHe+9Mei13RUIPfMIfpHq+02XPnmjqnr7RIzcvmBV/LWjoZOu9RDTH6J0DUoPyqQLJ2LpU+LaRVMYqJgZjAnzSTlxS3Hg89rNuv2NNt7tzs4Lc8iEBgd0Py+mKNv2Qs/d1yBhgFdCM2PIH19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa68b513abcso50339466b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990158; x=1734594958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7s4BeQ713kByi2QeKLX91gwAxcwTp8lak+2I8QfqVA=;
        b=Dnz7PrIapXfGQeF61Vm6yJHNGnpE0Xc85fb6Mpm5mDCdessZLApCypNrddeAzEZhjg
         e/dELwat+HXrcZ+k6f7jrEr77amH7bhwI7twC4jhsudVPT5CNTdQYgbDPwldAvfVdGDg
         2jBpLr5Q9hItgW6xrInoFmHRKUgJgeXhR4EJVB0NzG8fYkWdajz3vd6MNC4S+nbGNwvw
         9IzAkeCxi/jwCr9eYtEfbEy88bY1ASJ0nHk7eJArVoeSNp/wu3k6pfcfW5e5mV4/id8I
         tVVkN43ZXaen0/VGc/BKTfmLCN4jgJNUyeO3gUCNokPqc9X7YEA7OW4zV9W2A3zIv+j0
         Ogxg==
X-Gm-Message-State: AOJu0Yw1QjCITjGHt8e/92giWRt5FaBgmA4kkRUoZPo7f9bVp3129BDV
	pvJjBj8vtYnpCoO64eXFzUqRv4RC+yx7FuTbSpSjfREW8bExZ6nVykBhPI1O
X-Gm-Gg: ASbGncvOiT6Gj+IGYlR+0BLoWQA+dvpLjHl3LYiMlaYLNjcRoXvGjjSoq1upj8EB8iG
	tE0LfEZiHYXPBl/aA/XHAZmKHhjUDMUruXVjVx+43+YlU+oqE2emxorz+Leo2TcLR6lPWAcAt2t
	DvXFsVS81+FsHA/qr5JHut5ynpY2GroLi5zChKtZ91+hmFP2j5HKcXsdZFNa5PWXZRCVBcEM3/+
	8sE+DY8Nv+Z1Wjr+6zsJGYIud503BoEXxyVK/Y1t+LONb0pgyjTCJN6h5JMEz00SpRnwTLfQ7PD
	iU2HrULJkC0jxsxF4bJnVF8K1Kt2u2UuM7UnVpU=
X-Google-Smtp-Source: AGHT+IG8bVlyXCmSszUWIqWNqz8lPveWNwulqzFUTY80i4ea6reIH28Au0pJvtRj+pcEeZBkqFErCw==
X-Received: by 2002:a17:906:7307:b0:aa6:32f9:d1a7 with SMTP id a640c23a62f3a-aa6c1cf1b1fmr399136466b.38.1733990157806;
        Wed, 11 Dec 2024 23:55:57 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:55:57 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/14] btrfs: fix search when deleting a RAID stripe-extent
Date: Thu, 12 Dec 2024 08:55:22 +0100
Message-ID: <29bc20b873dca2bf2e44af4b13ffb85c28d7b3de.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When searching for a RAID stripe-extent for deletion, use an offset of -1
to always get the "left" slot in the btree and correctly handle the slot
selection.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index d341fc2a8a4f..d6f7d7d60e76 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -81,14 +81,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	while (1) {
 		key.objectid = start;
 		key.type = BTRFS_RAID_STRIPE_KEY;
-		key.offset = 0;
+		key.offset = (u64)-1;
 
 		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
 		if (ret < 0)
 			break;
 
-		if (path->slots[0] == btrfs_header_nritems(path->nodes[0]))
-			path->slots[0]--;
+		if (ret == 1) {
+			ret = 0;
+			if (path->slots[0] ==
+			    btrfs_header_nritems(path->nodes[0]))
+				path->slots[0]--;
+		}
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
-- 
2.43.0



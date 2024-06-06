Return-Path: <linux-btrfs+bounces-5494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249378FE10C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0167287857
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067313D52A;
	Thu,  6 Jun 2024 08:35:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164513C814;
	Thu,  6 Jun 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662917; cv=none; b=ONUzc5Yil+QXiAWrG0kv6glKhcnsFsYX1laLjpVi/c5oFXvfhELb8EXTwP1aon2Ojdy/CSKheZ3XDsDEypXi0oTp4jiH4XQ/qZbmb55lulmkBOfVDTwgCheH2t7IKnZlHXjmLYquRX5/wElPcoqGqYXk15TicMwtMprZrlRCiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662917; c=relaxed/simple;
	bh=BSOOhO9uOGNNGpi3Gg+mYHQY2B8J/1iID6JLkJE46A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPT19OHpmEsTTuah9GrifY+f2vPVS5oHSXOwZO6IfbPofoPD2mvfczgwy6Dzrgnf7ErZRESA3YWtZbd0/kPZMFFccfv6naaRV9eYX9ZLXg80tjtgXIWO++5FngPA9nyAVvHe1/qQysAanDMKMBJ07De3pSShV6g8mfQui3p4tBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso777596a12.2;
        Thu, 06 Jun 2024 01:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662913; x=1718267713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeG2H+23xO9tpjf9WGGXRka0BNONAaWNuKPYJcmDEqc=;
        b=Bhxfjr05H73AJ4CJvix98L6GmxogNnJvoWJmx8LxaVgSMZlwlSXgQvAOI12C0cvi87
         ytKhzFdTn3HjOyxqQNvfwznLURIPanMyemU0TmM1FIhuywLSYofjH6o2EMP5tJ986YgK
         L9QfgvP9s4aE5xMif4KTI9wG9ieOkPe0yWHx3diEt7e2/2bNUznVC1E9ixo2XFG2HCW6
         53I80UyQSahspa4Ca2dByl0H3QzMUPVoEAvGRnRpgA/olExHKHFS0KCoQMTXi+MbWFG8
         hjSOz7IBRhfvWSygaP9FoqgQ06WZ90yveb44HgyJuHx9AR2jbsLUSVfLfFXe7p3epPPw
         QoxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7xP6k2kQUGd01DftvUP4Y5ek5Zyt51t6UI8HmQkVtvd8VTef7NTfrd2nP9faYJYetfF8CYHmvNOI0j7IyhQsdv6WNOewWj+JQX7hb
X-Gm-Message-State: AOJu0YwePQNLEYdXEY2hodfDYNPLE0lLnomc+elIYJy18g8WbGNUZCWG
	4+hRhuVq4HATYQpeezb6y0dygulKxQZ2Nu9uwyyG/rW4PUikZKRh
X-Google-Smtp-Source: AGHT+IHCWso67t/to7iMIinu7ADUyy+aHhwgohwPXJMxb0Gfe6fOharlZLaAfrq6H57XFJY/BvCGgg==
X-Received: by 2002:a50:9509:0:b0:57a:19f5:76cd with SMTP id 4fb4d7f45d1cf-57a8b6b6e70mr3404801a12.19.1717662913312;
        Thu, 06 Jun 2024 01:35:13 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e99asm701338a12.17.2024.06.06.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:35:12 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 06 Jun 2024 10:35:00 +0200
Subject: [PATCH v2 2/6] btrfs: pass a reloc_control to
 relocate_file_extent_cluster
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-reloc-cleanups-v2-2-5172a6926f62@kernel.org>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
In-Reply-To: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=jth@kernel.org;
 h=from:subject:message-id; bh=OfB3wMCsTTsiPlpJ1BKnSCGb2nR83tLTHiinUb2gTlc=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlluyVnrxK/1jfWReBI6/P3QjJ2/dcSrnTc7rT8v2s2
 gI+vVuLOkpZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAi+18xMsx7oLstae0s0Wyh
 sG/2S5dnWS+0Djn55pe87LPJlfEeInwM/yyeHf9n7XRs6//UHyxqDiFc7zi/zfZ8uewxh0zN/t3
 3t7IAAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Instead of passing in a reloc_control's data_inode and
file_extent_cluster members, pass in the whole reloc_control structure.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 442d3c074477..e23220bb2d53 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3084,9 +3084,10 @@ static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
 	return ret;
 }
 
-static int relocate_file_extent_cluster(struct inode *inode,
-					const struct file_extent_cluster *cluster)
+static int relocate_file_extent_cluster(struct reloc_control *rc)
 {
+	struct inode *inode = rc->data_inode;
+	const struct file_extent_cluster *cluster = &rc->cluster;
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	unsigned long index;
 	unsigned long last_index;
@@ -3132,7 +3133,7 @@ static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
 	if (cluster->nr > 0 && extent_key->objectid != cluster->end + 1) {
-		ret = relocate_file_extent_cluster(inode, cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret)
 			return ret;
 		cluster->nr = 0;
@@ -3158,7 +3159,7 @@ static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
 		 * the cluster we need to relocate.
 		 */
 		root->relocation_src_root = cluster->owning_root;
-		ret = relocate_file_extent_cluster(inode, cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret)
 			return ret;
 		cluster->nr = 0;
@@ -3177,7 +3178,7 @@ static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
 	cluster->nr++;
 
 	if (cluster->nr >= MAX_EXTENTS) {
-		ret = relocate_file_extent_cluster(inode, cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret)
 			return ret;
 		cluster->nr = 0;
@@ -3775,8 +3776,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	}
 
 	if (!err) {
-		ret = relocate_file_extent_cluster(rc->data_inode,
-						   &rc->cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret < 0)
 			err = ret;
 	}

-- 
2.43.0



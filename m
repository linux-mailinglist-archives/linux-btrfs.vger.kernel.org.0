Return-Path: <linux-btrfs+bounces-5469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9678FCF9E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0A1F2458C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852C199242;
	Wed,  5 Jun 2024 13:17:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B4196445;
	Wed,  5 Jun 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593478; cv=none; b=bUhqSs98hr1M0qqClB/VG1+pXxeANDJ80afeG0YA2qbA9n7fmrUk/QVvzBGhxP6R8A30oLWjlRtFP4E6kibU4OVf+LQYp2pgxOIn0eqyAGci3IoVnrJkNXZQBXLJLHd3pj/kkDUQWLqUK1nD4camJ466NNgwFOP6VY3cf6rWc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593478; c=relaxed/simple;
	bh=wER0C23IRM3B+E0P+tpoGLwjN+qlq9Cy5JPJ+jUloxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcCZRIc5M6xfG4oypASA2t2aaeN2Rh9vUS68QG+MSd01Yd7Xk+wrLp0mZJh2kAtYrlz88oYvs+Lnu/CHFBZ0W2M+UkHBcsdCJ7A/QCy7SulIUa2W9J1Kb58setvsp+6izVMpq8bhiVl+HPpv7Qnyg0Q9ZVKbMP39QZ44vABmcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so6533257a12.1;
        Wed, 05 Jun 2024 06:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593475; x=1718198275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpJSm0J1jEQQpUDbW+K2aiD8E8N7vnXDBGJYZC8h09g=;
        b=UdAA/dAFrI+YzRfm6Xjj9Cak8EuZfQ2BrKgBIDNfcZiKYdktt+lZs7iRJI+NhfkgRQ
         NZBa/YS64QOVz21gRbm+F1GHs/JdLnpAKUXMNCsZg6oolv66oqK/43dBqSZM/Yo5CVzF
         zXA5idaq8THnzt7Y+Kx+iK119bX9DCn+dB4wqyAWz3Qtv9h9KXIfY0lJodObpxmRAtRN
         yAX7/rcj34MwQ+G3tV3fPdl4rRuVeuGOYgUrzyHdSeCr86oH6NcOWk6+jZiS2lgNDzRK
         yxrt5C+xvCu3knGCi514ycrM50BSjMknEpVEJlnnvjQdUS5oTuiPE0E6wzfxE97I1DDh
         CYUA==
X-Forwarded-Encrypted: i=1; AJvYcCXeN6QsEVokIxbgq5azOqpdrXGe97QGF865o2nQLkg1V1wmp8+rVw1XlaUX6Bu/0ngxa5Ii57F3KKHi05OktMXQM7GaoLRc9u7f0vxm
X-Gm-Message-State: AOJu0YwRQzppsDrSmLp0NCkTQaqMWnU9FDqPnQC51T+FM8o8jDHbtU9E
	9FH1k5IcxmvFWnurPZEhPpipHXOLgUYHqVzwvJK8ckpEU8TWFr5npvM6NA==
X-Google-Smtp-Source: AGHT+IGAur4Ev+ZM31k28Uig0lFNnOas4f30gruofQ1oTGENNLGMxP9PJpe6VOR/7wpGCPdU/ADFXA==
X-Received: by 2002:a50:d497:0:b0:578:6198:d6ff with SMTP id 4fb4d7f45d1cf-57a8bca263cmr1707847a12.33.1717593474403;
        Wed, 05 Jun 2024 06:17:54 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99a3fsm9266913a12.9.2024.06.05.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:17:54 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 05 Jun 2024 15:17:49 +0200
Subject: [PATCH 1/4] btrfs: pass reloc_control to relocate_data_extent
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-reloc-cleanups-v1-1-9e4a4c47e067@kernel.org>
References: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
In-Reply-To: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=jth@kernel.org;
 h=from:subject:message-id; bh=YSsr1EzQHpx+x5w2OEIUfA+J6YfsAt/3JAEdrkSu0zg=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlpNbbTX+if43R9qXCzn3eoSZ7iiKlynyvPDw11WH2W
 zn/DZemdpSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEJkox/K/Ju1Wx6tzvCwW5
 c07IlwZu+aCScchXqnhl/rsj1XeZd55j+O/4aeveIqFkz1OntbVcp52xzosOmnl3eW3YzTTDWW5
 G51gB
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Pass a 'struct reloc_control' to relocate_data_extent() instead of
it's data_inode and file_extent_cluster separately.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 81836a38325a..442d3c074477 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3123,10 +3123,11 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	return ret;
 }
 
-static noinline_for_stack int relocate_data_extent(struct inode *inode,
-				const struct btrfs_key *extent_key,
-				struct file_extent_cluster *cluster)
+static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
+					   const struct btrfs_key *extent_key)
 {
+	struct inode *inode = rc->data_inode;
+	struct file_extent_cluster *cluster = &rc->cluster;
 	int ret;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
@@ -3745,8 +3746,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		if (rc->stage == MOVE_DATA_EXTENTS &&
 		    (flags & BTRFS_EXTENT_FLAG_DATA)) {
 			rc->found_file_extent = true;
-			ret = relocate_data_extent(rc->data_inode,
-						   &key, &rc->cluster);
+			ret = relocate_data_extent(rc, &key);
 			if (ret < 0) {
 				err = ret;
 				break;

-- 
2.43.0



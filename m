Return-Path: <linux-btrfs+bounces-5498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5286A8FE115
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FE21C24787
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32C13F440;
	Thu,  6 Jun 2024 08:35:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018013DDBF;
	Thu,  6 Jun 2024 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662920; cv=none; b=U1pKZjvLdtXVv/mWq+JFXeY+myTjxKiHc5r+Ug1Oskiw5Sm48jJWmeoCq3HehQf/eHfndB5tKMXI/2bdKXPSSN4Jab+wewKnfpZU3OVhnf802FBZ2j8q+upb49a2QWTSkcN5ljLMl/HfvjGOkdKzw+wfVHMBxQySt+ClrzzTLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662920; c=relaxed/simple;
	bh=3pmduSBiMNsWuEWUGOxI1Upi2a10FpWxiV8qu2tjxLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ld8gY/iUR2Kz+JP4tgJYkZMPapQvQoXUBkp+QrbFuPUM8sig5tsNawh+Ib9y1CV6coZqylpzr49nntgNqSAbOatJYBj5R2BpoLeVQeRWOI+V019uQEKcr9UhsaTjJFr5D1kiUDf4JjPS6C7b0gdIVtA4kHQp1v1/Hi2ymT7zLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so645346a12.1;
        Thu, 06 Jun 2024 01:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662917; x=1718267717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgqPMyWKMKZbOFk3FEtGJsccK6vNPBLPV72bI7O2nGk=;
        b=KsCC+ScjdQAwnv2kbXmYfvY2IYdew4q3hASBSDZOb4maqU5JQf5lkeFpaEya0hKKWP
         0aOttNKmA52El4CscxHwK7xGuOw+3vXKECml7KcDKeRK7p5/nI4vb8bIkEQ4lD0Jl0ya
         iSLxBEANZC+fMBbc3X8elzNVBSAvFRvVXl26FDyLf1I9o9YFLJsm7e/90O5Pa8tI8pzn
         T/pRKf3/7aVLFUIAlhrrBMzg1S/3cmVHFHwq5+DBFt3bAa3wjAasmcDqb0n39f3461tY
         U9YY2WMf0PB2mRyg0OvbeMnHJbuN4pEZ56N3slhWLcT3hBRSDTUADXFvg+bmnaIyw/W1
         FvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKglt3cyesfFlR+w8Mp77mVFS6v20ID4ZJdQeAIN6lSBHwyl/24eGXuuTPmXmk5VEI7T0WtZI57Z3pbbCbF+73oWfRdH9Vm9kBNBd1
X-Gm-Message-State: AOJu0YzuJUgh+aVRze9E0KMxaJbnzLMI3nY+Qe3PSjymY3CHcTHLsgMU
	rDrfJDd3P1+5t6Q709SR5D2HAMztV2TKrmxoahHba/o7OHg/MTwZ
X-Google-Smtp-Source: AGHT+IEgzPbpXSg6oj4xJJlxYy7SNnAuHVzjVssF7tG8XBiDGWFJK763FFPFkGPEYc5slvM9yCS3DQ==
X-Received: by 2002:a50:a41b:0:b0:57a:1501:38c with SMTP id 4fb4d7f45d1cf-57a8b7c7cb3mr3072840a12.26.1717662916934;
        Thu, 06 Jun 2024 01:35:16 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e99asm701338a12.17.2024.06.06.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:35:16 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 06 Jun 2024 10:35:04 +0200
Subject: [PATCH v2 6/6] btrfs: pass reloc_control to
 setup_relocation_extent_mapping
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-reloc-cleanups-v2-6-5172a6926f62@kernel.org>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
In-Reply-To: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252; i=jth@kernel.org;
 h=from:subject:message-id; bh=Uk/h9ZXJECyqPaI91QMuPfBVGZxkVB5F+nx7U12iegY=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlluwT1PZZseVIrS3v0xPqwku7rVws8mQX5Zay+3UJx
 2y3u/Kqo4SFQYyLQVZMkeV4qO1+CdMj7FMOvTaDmcPKBDKEgYtTACYidYbhm93a17u5VYxVfVoq
 7b7EVy7qnNqaW3us1cNTedKenjkJDP/USnakM5+celL0/I4rvhFztxaJzTio8+J1u9mmAiO96Hh
 WAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

All parameters passed into setup_relocation_extent_mapping() can be
derived from 'struct reloc_control', so only pass in a 'struct
reloc_control'.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c138d08cce76..320e4362d9cf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2899,11 +2899,14 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 	return ret;
 }
 
-static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inode,
-				u64 start, u64 end, u64 block_start)
+static noinline_for_stack int setup_relocation_extent_mapping(struct reloc_control *rc)
 {
+	struct btrfs_inode *inode = BTRFS_I(rc->data_inode);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
+	u64 offset = inode->reloc_block_group_start;
+	u64 start = rc->cluster.start - offset;
+	u64 end = rc->cluster.end - offset;
 	int ret = 0;
 
 	em = alloc_extent_map();
@@ -2912,14 +2915,14 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 
 	em->start = start;
 	em->len = end + 1 - start;
-	em->disk_bytenr = block_start;
+	em->disk_bytenr = rc->cluster.start;
 	em->disk_num_bytes = em->len;
 	em->ram_bytes = em->len;
 	em->flags |= EXTENT_FLAG_PINNED;
 
-	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
-	ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, false);
-	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
+	lock_extent(&inode->io_tree, start, end, &cached_state);
+	ret = btrfs_replace_extent_map_range(inode, em, false);
+	unlock_extent(&inode->io_tree, start, end, &cached_state);
 	free_extent_map(em);
 
 	return ret;
@@ -3110,8 +3113,7 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 
 	file_ra_state_init(ra, inode->i_mapping);
 
-	ret = setup_relocation_extent_mapping(inode, cluster->start - offset,
-				   cluster->end - offset, cluster->start);
+	ret = setup_relocation_extent_mapping(rc);
 	if (ret)
 		goto out;
 

-- 
2.43.0



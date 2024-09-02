Return-Path: <linux-btrfs+bounces-7734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301429685D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 13:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2AE1F22190
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5314A092;
	Mon,  2 Sep 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCHgFFZ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C40481C0;
	Mon,  2 Sep 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275480; cv=none; b=PUA+Uvsz/q13LL5nA3FpiJzEDEGW64NqS0se1IFS+kC9BCNsPOiO8NuIDl5EDysWq9QOHgk3KABa5KBcJhrLG1p9QK0RuVXDDBASmIOoi7X4b5qd3aybpxtZXTzB2JtkRKI27xGbVi4D0g70DObfhektEk60a4/MzAWtsRjhMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275480; c=relaxed/simple;
	bh=Hhr3pQDUYoojQ4vzn9p07s43yWBYOZlpBTXyp3PFkiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iwMmxb3z2wix0/IuL7mrj56Xv76oo5O9z8NawHFNVoX8Bs+wFmT/APEX85AcA2YDHFgQDmAHrxNDLWUFVZOZg9/0zIIQ2Oj52aPnyQejf5tOrKnzYJJdSQ30MDgqhYhaZDKDco0PTuxMTw/IGi5h0Cz8NEw0pp4gDfdGn61e/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCHgFFZ3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bb885f97eso19611085e9.0;
        Mon, 02 Sep 2024 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725275477; x=1725880277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGWfFMdlot0x64gU+B8z1IkYEK31iikM7C/94TI8AAw=;
        b=NCHgFFZ3kkYrym2EsP16VokD0Ja/eNWnZM5L9MSo9okEYRUszCt15ff9qAcwyTAqVy
         k48edlN03ZxYXY54+pTISzfHxYsEiGHAkmeOUei8Ezr4Bh8otq640OQxk5jb1wIkINkm
         Q5+cxE4ke3YXyQhiRWEnAQ3HXKFvfuCGQcABS/ervqeUm+XrPIFhMSDYvvXoTwPGPvT4
         hUx/E6WEkc8+mok3O1pAcLGLemerFOL86C4AdUZKIBPWuoYygzzVyEp71HMIbNpBib/Z
         UP839QBRHqHx0Qw4jBSN+Pf8ZsLMiX3sVcuGA0R61nogoUr4ouMYc9HXmzFF3t23GWUc
         PmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275477; x=1725880277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGWfFMdlot0x64gU+B8z1IkYEK31iikM7C/94TI8AAw=;
        b=b1bDmDnqh6P3Nwjfcjc8PcrWPZDjMu53w36tOa3EYo9JoWZT+v8skGTIC+kJ3EIjW9
         CHUBBU4u5/9ZeO9HFynq9sD4N5jbOUvqXMgG2PBVRhOV2sH+vIq97ynqI/ElhYLXOyy5
         36OyYFexEjmQEH/GjmPfSrzG4nPuedpMEtdhIkkhP8cXrqejK376vdvCGvKW+ox0Q/W3
         O1BqAteBF/SXbOL6wpMmOCfAW1ScljoqnzZG23N56TrEKQqzDiIMCIDFcky4kNoAgfox
         U2Ai4ZL9FjVa+Yj/G86Uu2PQbCFmY8cmHXYYltNQnpDXec/sB0LV3cmHgkYvIHRzuMnW
         Va9w==
X-Forwarded-Encrypted: i=1; AJvYcCV8BruIZWgo1nW6FAWPV1CStE31Jgn3NIOLXWT+4KfzsgwjKMBsAr7aEoGKqZLj5kPKdEDY9A0hVxElzA==@vger.kernel.org, AJvYcCVdLPK21EXLqeyy34I8mSFqbPJWl6/NHe/guIp+m7b9TDL/P2InWg35m09+HdUriXpGhTiWMA03AzOTjiEd@vger.kernel.org
X-Gm-Message-State: AOJu0YywtR8qcksHAlvFI7Qgz9wm2nq6zMzwolVW+fTSQ4hsMw9c1EbJ
	KtXBlkeJOrI5riQfO0eoYENCGSucyqT9C6u56zU8DTkwgV0p0rCH
X-Google-Smtp-Source: AGHT+IE71e/E3L+WncEL35e57wjv9yuis32DtrXa2af/MnZHkErrYl4H4oBU9oG8et5Y7yvM+vmUcg==
X-Received: by 2002:a05:600c:3ca9:b0:424:71f7:77f2 with SMTP id 5b1f17b1804b1-42bb4e9f1a9mr84020865e9.16.1725275476896;
        Mon, 02 Sep 2024 04:11:16 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d83sm134283225e9.44.2024.09.02.04.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:11:16 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Always update fstrim_range on failure
Date: Mon,  2 Sep 2024 13:10:53 +0200
Message-ID: <20240902111110.746509-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even in case of failure we could've discarded
some data and userspace should be made aware of it,
so copy fstrim_range to userspace regardless.

Also make sure to update the trimmed bytes amount
even if btrfs_trim_free_extents fails.

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 4 ++--
 fs/btrfs/ioctl.c       | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..a5966324607d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6551,13 +6551,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			continue;
 
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
+
+		trimmed += group_trimmed;
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
 			break;
 		}
-
-		trimmed += group_trimmed;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e0a664b8a46a..94d8f29b04c5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -543,13 +543,11 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 
 	range.minlen = max(range.minlen, minlen);
 	ret = btrfs_trim_fs(fs_info, &range);
-	if (ret < 0)
-		return ret;
 
 	if (copy_to_user(arg, &range, sizeof(range)))
 		return -EFAULT;
 
-	return 0;
+	return ret;
 }
 
 int __pure btrfs_is_empty_uuid(const u8 *uuid)
-- 
2.46.0



Return-Path: <linux-btrfs+bounces-8048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D863979F18
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03701C2339F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD2015350B;
	Mon, 16 Sep 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhMdrmsr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC82146D7F;
	Mon, 16 Sep 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481789; cv=none; b=RSwAmeXg3TQOXUn4CrQfXk91GWfbkPa6vYxKVejGTv6yFnRzUd7HyeQjgUzFomib2fTSiB1KnAVfa208rft/6jr+PmFyQdoAkZy/DOODIeAAboo4mpdEXyhDZMRj+69FOHDdz4OzPFo1aDEea3MCPzkqK1jk2HVenBPqKR41Nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481789; c=relaxed/simple;
	bh=+OQdfPxxcjTD3+sUfVA/9T2w8bAdEbP+yqDYsBHnQzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRBq0OiUNGC93irLZbBwsURhMcn2ewwxmQVFHG0TGh15GkUj/Bz98277QGeZ9rt9qhSOGUbHmsCu5pq/uVlOgZVvCNbmtNBmUbcUf70icgiqafB1Eq62GEUywC03ebz/7Fy4i0djJle89GnaqhsWfbSaR4yq5U1qknKvEH24V5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhMdrmsr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-375e5c12042so2299236f8f.3;
        Mon, 16 Sep 2024 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726481786; x=1727086586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjiEQutbL4t9l0my21gE0YieX3qenAsUUpmVjhWTT/Q=;
        b=MhMdrmsrfnHpHfSqFIQzYywCCX+dDRE51WclsaBI3T55A2TThKuTD+WKlmbK2MbV1x
         YCx+5uIZYQEErvESNEI/Kuxh09JdIBaemMcU3EFhNnZP2vgvqh1YYY8vnUgr6XEqfdxa
         tunp/oCmQmaY0Ynjmq3Ank2r52NdOf98abVrb4AyVqhA6bN5NzttwGnbu7guDPgmy80j
         AYw5oxD5H98kAhOMSZNeSywQDGW4ka15kJhSeLzhmTshFklTkn8AylEeaczY1CJzBYNb
         1kfmXVfJtV7nTCk68Jauy5SUdC4rSRM3Ro4e5xeTo5TEU6Gll/7QrIsqRSY9fU0yzZvp
         4ntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726481786; x=1727086586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjiEQutbL4t9l0my21gE0YieX3qenAsUUpmVjhWTT/Q=;
        b=SJDTKtfbPHJqBFlHdQrFExCA0jJ9fLKqKiBYj+4UQ+AbYc6ad6/ho8HJKFE9E+iOUl
         JjowKgygAB5iKr+DZmYr6sco3KRdthGpuEebMXs8MNVCuOeREYhyYrTKaziFNRRlVdAr
         dGZnyc/aTGHIlXRSMJH3Abam/Do0vWXueNW19k24IQq5UNHDgtCO6wPPYYanNzPH1U1l
         h99xWSvE01iH1YJev+WaO72kstzhN77FL0iPFafxW5fQaL4EtRHqIK2xb/Z+IjifmhHT
         4lQrdQPiQ2Phc15Ijjopx2DHp3/shIfTBefGxDDGQ+SJFWIDhzTWW7YUm7bMQOQKppm+
         fwxg==
X-Forwarded-Encrypted: i=1; AJvYcCWJJ6K3HXGXMGX1RwQMBsiVBZo1cr/ioKkYhl0le0Of0MG/sm3/tiIdv0ITrnBXPJcewCLdb+J1tt4quA==@vger.kernel.org, AJvYcCWybFcQkmeLqEUXoUVb4NGYZG8+f/GGrcAHUUMZzF5qkc1yLPTkPuFIg8IjAX2WuQeXXhdCMyVgiiRVoreH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ux1AEWmPp1uP4C7btP9dERreD2m2c+PBNaiq47x668+Ic1DC
	Wpg0g8euq7Vdg9tdDnfZhaybuM2wXH89NOFk4bzlSefA1enyDslx
X-Google-Smtp-Source: AGHT+IGgFcyea0E2B0p7cwubLhqDr3i7lH/J8TsgQqGcCIhGCf+OChT6svaZ0M5/uCYtOr8VOhPaIw==
X-Received: by 2002:a05:6000:400d:b0:377:683f:617c with SMTP id ffacd0b85a97d-378c2d07364mr11691299f8f.23.1726481785737;
        Mon, 16 Sep 2024 03:16:25 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e780015dsm6814201f8f.69.2024.09.16.03.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 03:16:25 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] btrfs: Always update fstrim_range on failure
Date: Mon, 16 Sep 2024 12:16:07 +0200
Message-ID: <20240916101615.116164-2-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
References: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
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



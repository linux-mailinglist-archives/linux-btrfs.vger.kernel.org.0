Return-Path: <linux-btrfs+bounces-8585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33331992AD6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE11B23602
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9001C6F6D;
	Mon,  7 Oct 2024 11:53:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A41D14EC
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301987; cv=none; b=Fv/JSktNHBgOkz6TIZtPt8OYyLiGDHBcDEc607uBGdDsbobiObts/hCpKasmNC4aNNzLjT2acU01eoWT0vsGtHSGDiyOlDoVXG82ODIB6wAO4DkrS1CsfQZbd06ff9W5OKmlQhUYjx+gulF+UsVgQ/EU4tz6YJFOeRLZQEtD0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301987; c=relaxed/simple;
	bh=ciI+LWCUlTIS96ABiIuJgms7yBoCOdDOj616x3zsuPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFnm9AIhn/ZasDhH9VJks/rgpUBV7KSRya419Ypxaj4/ZZ4VjQzykZPNTAzwy7w3HqRpMRpy3Ej5QUXXv41qbxDDF7uj2Z2Y5ncZPWT+z6IF+LI0rtFIVRivoZCQjBif987CBIZHzqidERz/C7COhqx7SkqT30zvIlV/H3aR2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso57839235e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 04:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301984; x=1728906784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5zl/oUKeQlueLBeiiFxcIUlyTQ7b9PLM0joLf/wpD4=;
        b=ZtjcrP5DTanC5KM+KAcjEU98HOHGx3qpbpGDIV0oaz49yNbBYu4gIoq1jKKuUzCMqi
         ZzYuIzO8cAbauJn+zPTm9szebXK99B9yLDQbrKX0ljxDT+gmoluuvmXYtgcJA3b78SLF
         N+ZzK8+BRy1F2rmIwKbqeixmjcvKWIRYlnbx130ohMVYI/Mg/9zadBXgK4KQKu+JMwPU
         qmEzgR1sYtYdTR21TvjmCHjcpBQKAMf1jF7JCCtESK69CxrxA+gYinDQa1OJ4QWnEYDq
         A5toV8gZXk163BgQu2UJ2BCaue/UP1/1VyAGzUlUSqsbJ8U9urPCF3VSHeAJxbY76okx
         6UPg==
X-Gm-Message-State: AOJu0YxioGSYkuhdWMN9Y9va3jfX5oIliWqLJGjx3TTXRf/PUlshrrZN
	A5dnwoS8T+WG92EVVpt5Xayn/POhF7QkFFUKRZAPYApHSPo8XOuCxJCjHp3c
X-Google-Smtp-Source: AGHT+IEykPbagy6EOLFH2MIfi+7pXTsdSYs0o+yrRXS6XsW2cJl/lFxZAgWyXdmIEcpZAJ1/JFBDcQ==
X-Received: by 2002:a05:600c:1e22:b0:42c:b555:43dd with SMTP id 5b1f17b1804b1-42f85a6e1admr122131745e9.3.1728301984438;
        Mon, 07 Oct 2024 04:53:04 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e36dsm5570238f8f.85.2024.10.07.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:53:04 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] btrfs: return ENODATA in case RST lookup fails
Date: Mon,  7 Oct 2024 13:52:47 +0200
Message-ID: <20241007115248.16434-2-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007115248.16434-1-jth@kernel.org>
References: <20241007115248.16434-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In case a lookup in the RAID stripe-tree fails, return ENODATA instead of
ENOENT to better distinguish stripe-tree lookups from other code paths
where we return ENOENT.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index b7787a8e4af2..41970bbdb05f 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -234,7 +234,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 		found_end = found_logical + found_length;
 
 		if (found_logical > end) {
-			ret = -ENOENT;
+			ret = -ENODATA;
 			goto out;
 		}
 
@@ -280,10 +280,10 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	}
 
 	/* If we're here, we haven't found the requested devid in the stripe. */
-	ret = -ENOENT;
+	ret = -ENODATA;
 out:
 	if (ret > 0)
-		ret = -ENOENT;
+		ret = -ENODATA;
 	if (ret && ret != -EIO && !stripe->rst_search_commit_root) {
 		btrfs_debug(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
-- 
2.43.0



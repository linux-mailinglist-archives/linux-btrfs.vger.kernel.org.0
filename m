Return-Path: <linux-btrfs+bounces-3727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A263A8900E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 14:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC19295640
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FC84A5E;
	Thu, 28 Mar 2024 13:56:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D027E118;
	Thu, 28 Mar 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634199; cv=none; b=pwekpAczO5H+E/MRfsWS6MfJV5PjCcflVklM/tuBMCzLUZalv9IKe4qjvNE+5w1JaZEyzl4FFuOghSYz3WBxN/e9WrWpHqEedtP+j0u3B2HO4dWWRq0t80734pPI9KUCyM5PIeX3J3vYwao9DC/rGEHxjRM01I7k0GwW0ZUfeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634199; c=relaxed/simple;
	bh=P0f42Sn7SI7DOEZLjCSWkOOSn29G4boIkz35tOQKdYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFrWT1F6agF5SlbJxr0U90J5FmtYvJ3nxq9LxQ4Z+/5bfQltxBucuI2SuDZKjyNNErxV1p/Qdy1oF9e6jShRhNmrjCUQ0JuPNQPcxX1Mduu7hajeYB+871Ep3ltsV2GA4gTphd8ILUOZkHtKNAA3UkTF1KHFxLxZph4uYkB0pt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-415447b16aaso4794515e9.1;
        Thu, 28 Mar 2024 06:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634196; x=1712238996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGbNHcQQIa4fEr+2BYTczM4lGtJMpzlUMjpU5OLKXRg=;
        b=vy2gh7IX2CQa3pswsnezLvtZ82dmjpLHfo0CHkrghfLEiu7Zsj9+KVpzGd/dzfh8TV
         5RyHzLPEIMebPLeUCBQunGE4S7YRzdZtK2o3wTXbckX9R1tSBCmKW429XJXItTAk3EvI
         f+XPzVHkGCjUfAKsweVH7SIj7QSNUHzPOLxTivgUaVdwi0PI618OFxgRZUd4u9JocHIf
         YOg7b9NTkDyACCjKkMNvepU6jifvDSbFIRGD1Rjw3MKjcOmu+b2gbTmAoG7Ci4IQ3kRw
         xUtiygAGDZWvh/nfvFX8cNH9hNdI9G+dvs+ykr8Ci1+bAAPzxPcwyh0EDteacqXfojsz
         3CbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVM6CjVhougBRGno0PHsxpWTYuWTTghXU22g+DCxxPs823/OzlRBfjNcI4JPFOVqtp7gKMwxWiI3uyNQSXjSRUt1lnWDmX8l02DVCF
X-Gm-Message-State: AOJu0Yw6Xdsn06BD4LLcNUYXLOi5FQSGnEkIWmmyoLAoVEiNFoKN8W/v
	scmsqglBc9GSIHZ+QXA2Gftuu6TMpC1UzjEYNsmf8w7UuLybnhDN
X-Google-Smtp-Source: AGHT+IExk6I7CazJfNI1VszLAF4yoh33/Gci+xPydpUTofQ9azqL3acrdLu62dS4kJE9CDH6NDRk2g==
X-Received: by 2002:a05:600c:4ba8:b0:412:efc8:299b with SMTP id e40-20020a05600c4ba800b00412efc8299bmr2322471wmp.39.1711634195714;
        Thu, 28 Mar 2024 06:56:35 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm5519570wms.25.2024.03.28.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:56:35 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 28 Mar 2024 14:56:31 +0100
Subject: [PATCH RFC PATCH 1/3] btrfs: zoned: traverse device list in should
 reclaim under rcu_read_lock
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-hans-v1-1-4cd558959407@kernel.org>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
In-Reply-To: <20240328-hans-v1-0-4cd558959407@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 hch@lst.de, Damien LeMoal <dlemoal@kernel.org>, Boris Burkov <boris@bur.io>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

As btrfs_zoned_should_reclaim() traverses the device list with the
device_list_mutex held. But we're never changing the device list. All we
do is gathering the used and total bytes.

So change the list traversal from the holding the device_list_mutex to
rcu_read_lock(). This also opens up the possibilities to call
btrfs_zoned_should_reclaim() with the chunk_mutex held.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4cba80b34387..d51faf7f4162 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2446,7 +2446,7 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 	if (fs_info->bg_reclaim_threshold == 0)
 		return false;
 
-	mutex_lock(&fs_devices->device_list_mutex);
+	rcu_read_lock();
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (!device->bdev)
 			continue;
@@ -2454,7 +2454,7 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 		total += device->disk_total_bytes;
 		used += device->bytes_used;
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
+	rcu_read_unlock();
 
 	factor = div64_u64(used * 100, total);
 	return factor >= fs_info->bg_reclaim_threshold;

-- 
2.35.3



Return-Path: <linux-btrfs+bounces-6868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A88940F96
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CB7285D97
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4391A0B11;
	Tue, 30 Jul 2024 10:33:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A619FA62;
	Tue, 30 Jul 2024 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335607; cv=none; b=o/qpmFBXS9eOmZZeHZfyl08vY0IaQN42k7HN0HmY5VYUblggd2kym3s4QxsU+IjEYX4iK+I9a4nDlS64XjyI95tu+nyO8AH80mHI/a69BXQQkPGes9xvp6fCdY8jc9ldDCuUfvD8E6+v+qwNbnWzWGVc4+Wr1ImhtZ8FgNol7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335607; c=relaxed/simple;
	bh=7z9b6DSEEd3AS7TAf2EEFdpb8JBFUBPJjjKwMcTk1bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4pYLIjNDZ4KaPHBO/Tm4va9MatW/YMzjURcozT+iseOA9h4vjOjAep/ibFPMHfte5E+nZdRItErkOnNE68v2zi/5PSM3pfiahtTlxo2ssRMABzkxcMgwGIE6Ylgmaz9Kr90QmCsy/TC2ehpOSpSGG+gLpWKa5lc3/xa5WWjmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so464229266b.2;
        Tue, 30 Jul 2024 03:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335604; x=1722940404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGN/kk6WdhdWkkFKRFXP8WuazD2BEVj2C7KF2uk7+UY=;
        b=Rmp6JLA3lgoi3mQ4DTGOEqygYkcZC6Ctjx88n4ZsB1iiju/MTQj0xin0+VWazdpnj+
         eRSbzPwp+mIYZQ9pDmv/3e2sSoS4dUSkZIA9ldlXtDh6CHoFyaRMwxUoxHDgtKLRsIql
         me98y9DAQMwyQ58hJjz/pjcF9bB8iPalMALNcV5u0M68g+i5IU7Owyq2XKpn7GWuhzF+
         yLSphF1/L5Ll8C7ouqJhT+d7P3WS2NJmE/RmDYvL5tyylpsK3H4JYtNKOXHRzSEMjRGO
         EQinUHeyhf9+pLDXpf+q7xXVNa/KHFCZYZ2UGVuX3r2rRV4lDki85DJvzCHN5ZHGO5fK
         ns2A==
X-Forwarded-Encrypted: i=1; AJvYcCXWZMOcckICKwNPMqNEmsXtFFv12une/c0BI+sr3G7tNp1Cu3m4HrBsiGYWqki3b0vSdVDTs6n4t7jQ+RMKdkj0hRDNJhFIEHlDwUYR
X-Gm-Message-State: AOJu0YzToy18KQxNYglZQgxDGM/BbNoAL9FZiPS1Vw646W/8RzDlagQm
	IHRObpRNt+jDIpPVeywAq8T5Nhqs3KmJiTDGG3Bpm8nnoJ910g7k
X-Google-Smtp-Source: AGHT+IESzVqZNqfmZoIANQuHqgZPH/KQSQXGGHUJ/ihImO6iwUaVNrC+1PzEjwZRBusdqCd4R7u2Ow==
X-Received: by 2002:a17:907:3f1e:b0:a7a:be06:d8dc with SMTP id a640c23a62f3a-a7d40165fcemr862127366b.48.1722335603460;
        Tue, 30 Jul 2024 03:33:23 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm622455266b.223.2024.07.30.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:33:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 30 Jul 2024 12:33:14 +0200
Subject: [PATCH v2 1/5] btrfs: don't dump stripe-tree on lookup error
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-debug-v2-1-38e6607ecba6@kernel.org>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=jth@kernel.org;
 h=from:subject:message-id; bh=hwc/5qBk/m03Fn+onMcecnGBzxZqVF2km5Mrm9HY6u4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStOFiQ9vxP6v6UtIv79+TODL7AOfGJlkzIjCeVXV4mW
 elPL6661VHKwiDGxSArpshyPNR2v4TpEfYph16bwcxhZQIZwsDFKQATiedhZGhnua8cevpzq4n7
 e+WF/85J2p8w81P85X5Q+t2DfcJhz/4yMky/e/zvvL3Npkui+fWKY1YY6bvrFjyYl7dF6/mzH9e
 niPMAAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This just creates unnecessary noise and doesn't provide any insights into
debugging RAID stripe-tree related issues.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 684d4744f02d..97430918e923 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -284,8 +284,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (ret > 0)
 		ret = -ENOENT;
 	if (ret && ret != -EIO && !stripe->is_scrub) {
-		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
-			btrfs_print_tree(leaf, 1);
 		btrfs_err(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,

-- 
2.43.0



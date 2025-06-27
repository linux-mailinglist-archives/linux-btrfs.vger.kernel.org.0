Return-Path: <linux-btrfs+bounces-15029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DCAEB2C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47061894E77
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5498299AB5;
	Fri, 27 Jun 2025 09:19:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D82299959
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015976; cv=none; b=s84z1i7KztbkQmudKDGgWJso/O+PXPTkMGCkXf6XbZd6qvmiKumtDIzEDhNBhxz4eApRQUt+E61Uz2Ta0Y8xBYWVdXHe1OHgqASdbiG5DFAsKewcEXQ1Y1pbB7R15x8KdvL/asaxFE1VpRqtdKzF44ajZMbXCYn2xZ3TIsoBoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015976; c=relaxed/simple;
	bh=5V+JKUhO+YjPcN4gt8EoVTveK8ASE8KBAXYWO1l9OJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lovr2XJPrIvp4Ia7b1e8nepsTFAFLFKLE1xsTytAtDkrThJSEyvt2JoCV3nEFdQJLVO4yaIm0xI/DQYiaMZrS+AryRKZ2kSlmVBPYETc4ni+pzNCvR07CBFLp+8nROW63/Oor3KtTx5NTaLly/FbTF0+bVUvPmXbB1aAzaDhi5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4536b8c183cso11892845e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015973; x=1751620773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA7CEyTgY6AJg34N6K17cQDBQxBBn5Okdsbi96uNXOg=;
        b=KgrEY/QbhjCrdEdcz550enQNSf1cdWQmuPrKIsKYc4e6zH9BWRTh8I8lX18nEXrl2w
         TEFyqyii5A4mlYjJ5GsBm70W3i07C4P7Y46dHAR9N62Y9AIEk1Rw8S1CWWsO4ZfFS0hv
         gQ1/UPRaUSGfeIabBRoo312xIuwVcbC1jd3qmvIthqehEEcXoBqw5AGjBQlREGo96WHK
         fDludaaa1ET36le3QT4DaWrLsQdX675+AMSheW7OX4noTg9clrYdJXPe7VamaJ/PbtAz
         S0YJD0RirzGyQIXvyPCq4B4ccpvlORsqmqJ5y6RBe3O6byYT1GxpB03mUIJNvDm9dFqY
         8twA==
X-Gm-Message-State: AOJu0YyD7AR08u8YW+F7gpaTdjsHqcSr3IilpGGy2A2814dSD2vo8Adw
	rWEEFnekVcPOBGUDmwNh4e6zPt32vLJipfLDjV8paxQOqznXGbp8hEheZPcpcA==
X-Gm-Gg: ASbGncv24NocoSEUUlMlfgV5+vHH7hcOieRbbUEl6fjgZac1z7gQc7tOk/fkqL1wO7u
	8KcupeSBYzPITyKxHzwG7NmXv/dtyR7eZ4ye3/1uk0xg9DXTscTq05BUAWT6wl4oX/JoNIq4Fr4
	xznlbqehwCBGopJKUjeiuWjsTifQ1FiB17dqwUPmhkm9sis9C9EOLXSpL8OzKMgsdZTK60Q1JGo
	RduGL9Droo52C1h68mtLlYXYmcDu6fEpU36oeOjZuoiHO+kktlHKM9UbZ8yG3IEZJiCtRyLvR38
	X4Ib31F5IO2e2XA+skAS8R2x4ueRJ2CzQC8boR8p6gN32G/X+bkxmf11oxt5tMYaItu90ioUdzO
	NkRKvjQZ5v5eM//ZZFymRumkIUwHfxYurdvK6tCNC49qhGlkM
X-Google-Smtp-Source: AGHT+IEA3SodoHObPHozDpkR3nTf23TcB79jlwTxR89S9fzFZ+G8VoRWTt2WVXQkxq6KS4OMUPV3Qw==
X-Received: by 2002:a05:600c:8112:b0:442:d9fb:d9a5 with SMTP id 5b1f17b1804b1-4538f2f8b8bmr20759145e9.9.1751015972693;
        Fri, 27 Jun 2025 02:19:32 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:32 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 8/9] btrfs: lower log level of relocation messages
Date: Fri, 27 Jun 2025 11:19:13 +0200
Message-ID: <20250627091914.100715-9-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627091914.100715-1-jth@kernel.org>
References: <20250627091914.100715-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When running a system with automatic reclaim/balancing enabled, there are
lots of info level messages like the following in the kernel log:

 BTRFS info (device nvme2n1): relocating block group 629212708864 flags data
 BTRFS info (device nvme2n1): found 510 extents, stage: move data extents

Lower the log level to debug for these messages.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d7ec1d72821c..46b9236708ed 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3892,7 +3892,7 @@ static void describe_relocation(struct btrfs_block_group *block_group)
 
 	btrfs_describe_block_groups(block_group->flags, buf, sizeof(buf));
 
-	btrfs_info(block_group->fs_info, "relocating block group %llu flags %s",
+	btrfs_debug(block_group->fs_info, "relocating block group %llu flags %s",
 		   block_group->start, buf);
 }
 
@@ -4044,7 +4044,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		if (rc->extents_found == 0)
 			break;
 
-		btrfs_info(fs_info, "found %llu extents, stage: %s",
+		btrfs_debug(fs_info, "found %llu extents, stage: %s",
 			   rc->extents_found, stage_to_string(finishes_stage));
 	}
 
-- 
2.49.0



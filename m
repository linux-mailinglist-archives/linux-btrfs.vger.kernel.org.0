Return-Path: <linux-btrfs+bounces-15028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E72AEB2B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC39A565A12
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976229993F;
	Fri, 27 Jun 2025 09:19:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D719299937
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015974; cv=none; b=FaGr6kVYrEYpt5KpahKzoXF3spUH3sRaN7VPNnL5RuQ0Sw7Ko/8S2G8BjdyD/N+6efhgHtpGex87cId8QQvSnDQSK9RQFL3wgT5PnmRvEwN6wL+WZ2UxkPLCtAeJm7vpnqDr/hT6YfHobXaZTIyWMdt64asZRah9hMEiI/R2hjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015974; c=relaxed/simple;
	bh=s8OGFWD6+SfQWWnJx38adhZPGTDxub9vaiXq1sL/G9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgAMVS7tReT6Cn58utqUg7ECPV0TDdXF8WfVYw6+GJU8rBgLJIfTqsr1PCC8zVT5b0ChdtPkeElE3CoVD0Kz/hwmVen9Re3ZQFKi7HiR8x8x5wqz1tl7mg3fzG3dCNHkaSOi7rP1DI1y+F/K7cz6qSAxT5yGRTj9R1ygJnOzPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1185434f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015971; x=1751620771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXonwfdlDopMmX/oQKnmVBiduxTwDaEp452rNjYrJVc=;
        b=A5s+kGN3aFy6sQwtqP/UQoeS2dGC5tk5wXDt4KQkIxkyZo7+b+ulZdun+EapP/qJZs
         /zO3EVUWzblhUsIyYvwJqXulbQkWMZwu/3NMCXQXNsvymUq02neBXgLNF3Z5Nwb+7PfS
         UAAtUP4eTEbP6BoXiToQk717tb6ozr8v3dTJsPCBLpCTluvmLaxjbk7/GKEPIwiLizBa
         uotCmsIooLLd6KhitAkNLdXiQ5rX+Z1T1jPOyRy+1nkWMpANqiDl/pmleX8rVlekE8G3
         owUM2aTA7WwebUdcOX0xJse4tgmZdtUlf+kY876RWen9PzkMoErZ7H8J7ceNBuPQQgAX
         gFrg==
X-Gm-Message-State: AOJu0Yz9OVAym9kjhps/9ROa8E7rdlhQuZjjUqPe+hReRUFrcnXeIQeh
	b0IbZ6BRxQG9lhtGHxEzWvgvOesjaONXOF0T+Az63RzCpuXE+iZVWatHl1ZHkg==
X-Gm-Gg: ASbGncuz1B0me7Vtx565GAm4n7zpavZuzuOQtQtQUZasTdeSgY1XWBPmxMRD13sFY+g
	2Kj+2LBNcCKHRepqlQcsvDcp54MypiWze78TtgDBP+j6xXx6x4WAJUR4PtESm6DnLI8x0s473Vs
	zws+NYQydR75LqqPatN2c3WbyE4EQUfuHgiJtcB8JLwCeXiONYPKyE6iHT6Xad3tXSHi+f4DJNO
	r4DPVxPsKUyWUzHBlgw+wpO9dfIiZm6cvaM/QYWH2ec3gQ+qQX+R/n5B4YSF5tOMJ/MzDaYlZQF
	rv1YiYEu2tduMjO9gZIufnq/dMXrbgNlBtO640fkclFuAFp5Hb5oBca7tA58vpec/I1CjIW26dy
	FjMnuWi37qQhnu2nQMPHpuMxLEFGTDBb+KE3gO+4LaNzR/F7K
X-Google-Smtp-Source: AGHT+IEtyXPgY99HPOpWfLCBm6E7tWYtdQxUFpIo/0xICw+9NjKYUVmy5iYtsKW6zE9cMvapiBk+YQ==
X-Received: by 2002:a05:6000:270f:b0:3a4:d994:be7d with SMTP id ffacd0b85a97d-3a8fdc1f5a9mr1629670f8f.23.1751015971397;
        Fri, 27 Jun 2025 02:19:31 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:30 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 7/9] btrfs: lower auto-reclaim message log level
Date: Fri, 27 Jun 2025 11:19:12 +0200
Message-ID: <20250627091914.100715-8-jth@kernel.org>
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

 BTRFS info (device nvme2n1): reclaiming chunk 1138166333440 with 10% used 0% reserved 89% unusable

Lower the log level to debug for these messages.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 00e567a4cd16..5e6aead653c4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1963,7 +1963,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		reserved = bg->reserved;
 		spin_unlock(&bg->lock);
 
-		btrfs_info(fs_info,
+		btrfs_debug(fs_info,
 	"reclaiming chunk %llu with %llu%% used %llu%% reserved %llu%% unusable",
 				bg->start,
 				div64_u64(used * 100, bg->length),
-- 
2.49.0



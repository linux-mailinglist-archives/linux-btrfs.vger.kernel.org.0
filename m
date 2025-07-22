Return-Path: <linux-btrfs+bounces-15633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED1B0D863
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54605AA58E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F52E4244;
	Tue, 22 Jul 2025 11:39:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFC2E3AFC
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184364; cv=none; b=uLHtHmxtrVyLPaSxy6NNA9oCyEBa8XT4gbMJtIENKu8nsO3VwY9+FlsI1WZ4r/JQJuZiGr2SNGAt3WziHHhyRLtFhb+r8YfRiC3jr8VJPY9s2VKom3DyM+XxaFxKSGFYlgnOhUDlAteT1WHnW9wbW84XBek/En2joXoO6BrOGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184364; c=relaxed/simple;
	bh=gTMSecp/Zw0fn+KHbTb4jZKYBOOhJY4qXbwX8+Dlv4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRHiklhuy3bHfOm8S/LwDWLiz2NNtSN5VZBKUOTAWE3AvvABPIxVPsfjNMK3lLR1b4Saxsdj0BR8WGdnZ35hRf1s4Ua+qoHSZH0UIlqElv2lVcz3hwxAcSDxmsn47QMCtXcGmkEUrXUx3u7Pa0jKUDdU2UZqKltOyNg2Y3kIoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so30561415e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 04:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184360; x=1753789160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bai1r+mMJ9E6skg9iN55aLlrB99lbWDbl3zxaExfWsc=;
        b=k6YDwhdD/q8OXKUmPVn2A61cIj2zBotzN1/ezTiuiEF3o1QUKJbzM2G7NHJTRoLXHk
         C7+t6W4sonoJDUy0r5tEve0+GeLvGhWGPMr1Xzk1lqKYc3IK/qhnjXYchIeZkF1nib4Z
         JP367JMPXp0DOcpmr5M3zAL6rPBLughroTsup0+bUd6x94/TAx5sRVJ9Fj8kDmMc+6bk
         7igJPEovlVbhKbomrbzu0vqJDZW6OlFC4sI8awuV+81Zei0mhRZ4T1w6u2tm5hHEDDZ/
         P5Ozz22R8IORGfdbqUsFDn+RY9CJ4u1X7dDeOOQ+QoqO8iiBqfyXwpYa4vTy0W+lRY+b
         KHaQ==
X-Gm-Message-State: AOJu0YxLbb5SJlYxbVk8yKBmQ4YmZ3G0Xuvkrj19+u9T62J2kng4jsJE
	AA36s1fM/snVb+JUZWK27o0ricrgmG7dJquZy5p/7luAVu+Iezuha6dTVYZGUuYE
X-Gm-Gg: ASbGncsELknQTM+XK40CqkvlFQp5bUaXNCmNQ+7aITKQtlzCPWSj8QjdrWAxdasPctK
	dBVxPt9dZxsS/yrJ5wrXwhgPQm/bPI+pkR/tC6H3SVRsaa3PWQh4zvh0fR68h12bxX1ZtfpxzDL
	xxsmgDFs1SyYSP93LWGKuku7Y7ESRddHwtP1PCC8n86qYqfW9T7Kk4JL94GaFQ8V5m+qSs1Ydiu
	HYhPUJtTUcIusKPTTrftHM2EOEgQoT3VPwqlqIVnDjGPlnNhTDTx8My6fiJNEBNdA+pZCHp5Z1N
	X7tCCMqkEo5bmdsw1QKE03EJTYmJ/ohfByWmYHItSFYSFXbw1514zy+2/j3I8DS14sNfM3DQmoI
	tkfxv/CUCij5g/bBwFPYi0cwx+ERgHBlcb9dGJGnaTr3fXHx2UhKrp53SpOAqStgqzUYk7g7paQ
	Q5m7/9d8M7Cw==
X-Google-Smtp-Source: AGHT+IGcRxI5Ao0Y04xeur/rtv6r2w27FWtqJKTmMUBFebbUAxBBiK/pEeSBiR4OOY7pqhAKojee/g==
X-Received: by 2002:a05:600c:c16d:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-456352d0b70mr185190695e9.5.1753184359506;
        Tue, 22 Jul 2025 04:39:19 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca24224sm13278255f8f.8.2025.07.22.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:39:19 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/2] btrfs: zoned: directly call do_zone_finish() from btrfs_zone_finish_endio_workfn()
Date: Tue, 22 Jul 2025 13:39:10 +0200
Message-ID: <20250722113912.16484-2-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722113912.16484-1-jth@kernel.org>
References: <20250722113912.16484-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When btrfs_zone_finish_endio_workfn() is calling btrfs_zone_finish_endio()
it already has a pointer to the block group. Furthermore
btrfs_zone_finish_endio() does additional checks if the block group can be
finished or not.

But in the context of btrfs_zone_finish_endio_workfn() only the actual
call to do_zone_finish() is of interest, as the skipping condition when
there is still room to allocate from the block group cannot be checked.

Directly call do_zone_finish() on the block group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 245e813ecd78..e997b236d00a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2461,12 +2461,16 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 
 static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
 {
+	int ret;
 	struct btrfs_block_group *bg =
 		container_of(work, struct btrfs_block_group, zone_finish_work);
 
 	wait_on_extent_buffer_writeback(bg->last_eb);
 	free_extent_buffer(bg->last_eb);
-	btrfs_zone_finish_endio(bg->fs_info, bg->start, bg->length);
+	ret = do_zone_finish(bg, true);
+	if (ret)
+		btrfs_handle_fs_error(bg->fs_info, ret,
+				      "Failed to finish block-group's zone");
 	btrfs_put_block_group(bg);
 }
 
-- 
2.50.1



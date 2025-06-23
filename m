Return-Path: <linux-btrfs+bounces-14879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6476CAE4B80
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7F01886C7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7929CB47;
	Mon, 23 Jun 2025 16:56:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0F29B8D2
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697806; cv=none; b=m+uZ5C0/Zl2Xqu0oq2WwCVddIsaVKAJt8HIIGEIv1gdcjscoQOilXrhdu3TSagEyXiAdIcEnWWSJMXZT5l/s0nk7H8P9OU08GDVcfj5vo+s+duDZET044DRjjSgelEJm/ZDZmbEht4wka0haf/8oTJ78ECSTBdKu1H2G+EwZ21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697806; c=relaxed/simple;
	bh=1iRZw+MJ0js01DRWM2JZ9TgcPOGc+3d1+51VFJ7YVl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpNQ80HbLyZlDLeKHFf4Y/5DYpQXkMUjxmwo7i1tMUwaD4RleSFmNrZDS5PcL6BI2WSEzS2XMVjKKPE7XX0+m8nMbLB9c5IrZVvi2aiAN3D5KGLqigHaVtSXjx76tSmniNWaXcC4z7pNL8aY6LPpfNv7GNoE5Pq1I16bV6i6BZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso34926925e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 09:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750697803; x=1751302603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsjjeYmqpGvrK2avxpZC7BOeo7Fl1L8JSbawAeF7ryk=;
        b=IFKc5w8yrKYN3uBSbs0sh9FmFIonEpITOlXdcLw2HxehTL8HVXPAG0BV/E2aIDlwqF
         GMTzxZN/BNn6yX4RlFKz71UTsfpWd+sNJr8YC2H2W23VJWKpzlRjeFHkGvXJlfRTI5Vf
         euR+pKg/TpYJjvi2kSHGKOkBSvwZEzQK9KRmY12LaJXXFM7tlbXMZQ518lwCkx1WZvqO
         UEFQgVDwT/GUZmpfp4TBCUmAKfw3BbuVdRh46XSFxrT+aIIFCanvragh7f6w+6hB2qOI
         MIBTsAhmt81zwQ/wlCeXOo12xRbJGORF4QuM5b36jiOs0EvYRupaYg4NhvIOyNEwgDls
         A3mw==
X-Gm-Message-State: AOJu0YwqafSOIlBGARF+Y5DijwX6+E9RCRWFukCbGSUrh50j4VwwfckU
	2i5MPMoi+AIxWvleFEszBukwfahrDl7bFJlMMTMZ0cnClTyOX+pqqge8gs8uaTv0
X-Gm-Gg: ASbGncvQgElmb9eF/UnhRaKHcHvN2zbuXwsXr4/MVqzwaJxwL/TT21U6EgLj+fI51g1
	suoKQzzPySdX6fpdPBfP0qbr9R1xFJKOKLaGS91IkcR2m2uCGVY1DUOb/+ErC9Y90Cefen78FGw
	r3O3BOSockShQ1cbnfmF0O/6JMh12uYJTAjCHqKRb/3XwWSEmlVf2kY1nzXrKazvSuURni89mWS
	fQAiKm7raArc4ALkiXr+N1LwN7+POkKQyjYzOYrVftbQxyUlxHDujky4kWAbPGbLvHXaxvHodkI
	bmc+NO4BHocyt9kNcS8TAx4yKcN29dmj423/yfT6nDamgi4hPHH6DNh4nlBZKD9kfyfzDmQN9Uh
	/614RvuMYhKS0B+x0eK7RSndrwp8RoJZm38F8Gn7sLDKkrBx+mg==
X-Google-Smtp-Source: AGHT+IEEa77kpuYp+Wwhnl3nlDUze4nzlB0JKo6N8oAyt7VCS7a9ycS/z2l8K0L0dBhWSkkDpDubPQ==
X-Received: by 2002:a05:6000:220e:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3a6d128a495mr10406027f8f.1.1750697802707;
        Mon, 23 Jun 2025 09:56:42 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d118a1f2sm9713888f8f.83.2025.06.23.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:56:42 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] btrfs: zoned: don't hold space_info lock on zoned allocation
Date: Mon, 23 Jun 2025 18:56:29 +0200
Message-ID: <20250623165629.316213-4-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623165629.316213-1-jth@kernel.org>
References: <20250623165629.316213-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The zoned extent allocator holds 'struct btrfs_space_info::lock' nearly
over the entirety of the allocation process, but nothing in
do_allocation_zoned() is actually accessing fields of 'struct
btrfs_space_info'.

Furthermore taking lock_stat snapshots in performance testing, always shows
the space_info::lock as the most contented lock in the entire system.

Remove locking the space_info lock during do_allocation_zoned() to reduce
lock contention.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 46358a555f78..da731f6d4dad 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3819,7 +3819,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct btrfs_block_group **bg_ret)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
@@ -3871,7 +3870,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 */
 	}
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 
 	if (ret)
@@ -3969,7 +3967,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ret && ffe_ctl->for_data_reloc)
 		WRITE_ONCE(fs_info->data_reloc_bg, 0);
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.49.0



Return-Path: <linux-btrfs+bounces-15624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE9B0D619
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1823E3BB824
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E112DECB1;
	Tue, 22 Jul 2025 09:39:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6B1922ED
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177167; cv=none; b=X/gQD4NQZPB5H9DWZ4HlecXZoWbL24DtBnV/ncmOp2UhyFJQGanQwYLzGbeiAwDCuNldA5pe9mPVbMmMGnXYYxV8ewqLqXSOrzgUbMRSe4zg+OHiuGwIfuMp/bwbK2dkxzC8Zwau9OBCiQWdr+DQxBkmOnVs2Xmu7o1AdJ+U4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177167; c=relaxed/simple;
	bh=JeU22yrN8VXmp39ZrX61Mmd787106Tqo3gWYNko2iDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8YzbwUCGs7fjlroRcELWXfstl6Grl6xwYH/cxBYg49wzao/bwveHdbfqos7f0Jb5p/h5F3RR6rtBacTbqYjkOf/f4b7JYmRaOO82+eLvghtxQmEitN0g79s9RCcV3brUX0Bvypc1BWQiWNNw3y3Y8f0+PpPW6XLVn9X7bjlirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso42648885e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 02:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177164; x=1753781964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O/GNDX4QXY/FUo1FhW7nqW8tmkmFguYp6D59QpNTqE=;
        b=ZC891o05HD3cMWSbo2+FOxJ+25uxtpD4WRmTTdXhLSK82B7QksZNCBb6U46tVoHSiV
         VplG5vxlTPSOkcYe+C02B7H6Smsk9voy7pdYDywrn5QJecIBry5rkzhO9RRjWRMwBy5L
         HCAgzLtQwhQYsVAUv+6i1Ce23FJgRQYv8ezP2L0fKtV3NR0QAhGtR54sPN3mE420NDsB
         WhXhGGRET51Ho1eVpyOJ8z53FDjqzQbUrI7A/hzL33NaLR9yBYLZ4tB7IAQqWV3Qb4mW
         cR+tKQVxAlh6LaOjA8kyaoFdGqs7hlHBPcgI0tjoZ7C29JhAyJ+wOCXHhqOxbxgZqRP0
         SywA==
X-Gm-Message-State: AOJu0YzRPl/RbWwtALcAygPZUeNfwDKzegyxEx2GHbiwgGTcpRzjLDdG
	DYjgktfPwvTXlZbzaY6YLVi5kDOK0SteR1QSk5wIBOelGy+DT4dSyYIt2e+/8lKG
X-Gm-Gg: ASbGncuNTDhynFX434cuEtvxTkSImvQwBcTf16Q9fTmT0WFuUYUE9sbJT68mbcWTsPA
	10SxinnJXClSXueWnxzyA9FhTNe3cJUOSG2G+YXpbX2ghESkkkLEiq8dzk3IWhYq+4lR4NOOvka
	PvaNa8jt+eKkrXqqPaHvyLt4zVm3aFxUR3QH14h5ERSivJGwQlF1Kvc6DDMsL1M/GqaH15LN20L
	+uYtZK82dY6AWaF5NrC2GYr4QaIPgVaP2mwi+7oERMR0SlyecXCmm1wGlfQkhvyBY3hfDAn2fp7
	OhuwYQj9flKIxos2ULQy0uyeLxhfcSMblMwlRVkQA1+29+FC0I3HXxGCr9gFG5uADaVa/lNZjiE
	sdcxz641U3RCVLAmMVev/yWESSfKNaDz/WnCH56pUEaMM2DSF9TB2Xn3qx7t2MLxI8ofw8u8En6
	zuKHDcPRK1vXGmyxg1kiXk
X-Google-Smtp-Source: AGHT+IGBCgSDQhIZo/zD4JoUPsIwdJsRnO/KbgqZSe4lgr0EqAdBoYaepmhX2/32BGhF5Pa+LNznCg==
X-Received: by 2002:a05:600c:310b:b0:453:9b7:c214 with SMTP id 5b1f17b1804b1-4562e29c33emr200771625e9.29.1753177164049;
        Tue, 22 Jul 2025 02:39:24 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5c7e8bsm123225895e9.14.2025.07.22.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:39:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] btrfs: directly call do_zone_finish() from btrfs_zone_finish_endio_workfn()
Date: Tue, 22 Jul 2025 11:39:14 +0200
Message-ID: <20250722093915.13214-2-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722093915.13214-1-jth@kernel.org>
References: <20250722093915.13214-1-jth@kernel.org>
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
 fs/btrfs/zoned.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 245e813ecd78..5a234f31c8da 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2461,12 +2461,14 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 
 static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
 {
+	int ret;
 	struct btrfs_block_group *bg =
 		container_of(work, struct btrfs_block_group, zone_finish_work);
 
 	wait_on_extent_buffer_writeback(bg->last_eb);
 	free_extent_buffer(bg->last_eb);
-	btrfs_zone_finish_endio(bg->fs_info, bg->start, bg->length);
+	ret = do_zone_finish(bg, true);
+	ASSERT(!ret);
 	btrfs_put_block_group(bg);
 }
 
-- 
2.50.1



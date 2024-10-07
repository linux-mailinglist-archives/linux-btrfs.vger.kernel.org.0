Return-Path: <linux-btrfs+bounces-8586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CA992AD7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1991C22A0A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561981D1E71;
	Mon,  7 Oct 2024 11:53:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7D1D1F56
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301988; cv=none; b=czwVqUp2JD4ZNdOIrlVhndQNExA1aPFp1GGQP/mfvBaIWrd/ZciVj2UPETeIKEs9l63LmHA6XAOdL8ShlvKuAVNmeA/uJG7aeLYu6tw7qJtEf5iUoui0Nut+j/nxvXW93BXvzCK8vlySrx50sIOdf+Kh18RdouMaCIrn/b7/eas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301988; c=relaxed/simple;
	bh=G8MZuBaiyQ+1y5sK4SONK4j+7xUSGTknzcHmTUZ+eyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qR7YiVYQzCdezASILr+9xtByJYeRkDFUgCNp6ymRjE3TeCJiwhFQS+v90D16gw982T3vgl5UBqjo8/UvIhp15RHXnBBWgFEi8rYcjehTO1I6BMK/6/IIhwBT9KBumTDvKC10icklqwX+K19N+JBnEkkqyNTALkl7C0EYXnMHGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cdb42b29dso2737819f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 04:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301985; x=1728906785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc5Whcht6JjcDwjELihCRf6ceDPK2grnVpeOSGIktNQ=;
        b=cHzBLblIKlGZ48j/+jEerAaRadQITLd69hQa3Q13zcEhGkqSKIrPaJ8MBkLLaj2DqR
         zpbemxC7kaH3XkIqO5x7dLc3DnenDODC1P5uKIsCassS9zFv8lpzQaboolvcbwam9UAK
         lgQI8FemiSQ19FFJUwxhPLWkrLqydXZUQYtlJ2uwlvKLGkGV7jCH4tTxd9BRzFKgj6Mw
         z+x1ZThnrOjz3/i1jvyEOcM5xrBiRBJAEkILus9VXJbIdGwqsY/GLBEqE6ZsMLoo+IjX
         kXF8rv/4sZibiTX0/XhLm//5zvoK0MZjlkrqTOXjdgRofZYrn9Tg2t+ozUHPOKDawCXq
         lLUw==
X-Gm-Message-State: AOJu0YxyIBjjzbxaSwPY1ewGsI0uMlWXMPC5/Rmpup8J31dQVZ8cxb0U
	21Z5uK6k3fPjEF1EVCm+1blYGRMaE+zugTVxKVltf3y9x2ooVVN0
X-Google-Smtp-Source: AGHT+IEMxWB5hst1cR8JdaZZyJ092DsI8ZUBqylmISjjob62OW/yKF2vLsuad4Kifiqzns05aVl9ZA==
X-Received: by 2002:a5d:5f53:0:b0:37c:f933:48a9 with SMTP id ffacd0b85a97d-37d0e6d317fmr8141935f8f.1.1728301985370;
        Mon, 07 Oct 2024 04:53:05 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e36dsm5570238f8f.85.2024.10.07.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:53:05 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] btrfs: scrub: skip initial RAID stripe-tree lookup errors
Date: Mon,  7 Oct 2024 13:52:48 +0200
Message-ID: <20241007115248.16434-3-jth@kernel.org>
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

Performing the initial extent sector read on a RAID stripe-tree backed
filesystem with pre-allocated extents will cause the RAID stripe-tree
lookup code to return ENODATA, as pre-allocated extents do not have any
on-disk bytes and thus no RAID stripe-tree entries.

But the current scrub read code marks these extens as errors, because the
lookup fails.

If btrfs_map_block() returns -ENODATA, it means that the call to
btrfs_get_raid_extent_offset() returned -ENODATA, because there is no
entry for the corresponding range in the RAID stripe-tree. But as this
range is in the extent-tree it means we've hit a pre-allocated extent. In
this case, don't mark the sector in the stripe's error bitmaps as faulty
and carry on to the next.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e141132b5c8d..96ac6f9e5eee 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1704,8 +1704,10 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					      &stripe_len, &bioc, &io_stripe, &mirror);
 			btrfs_put_bioc(bioc);
 			if (err < 0) {
-				set_bit(i, &stripe->io_error_bitmap);
-				set_bit(i, &stripe->error_bitmap);
+				if (err != -ENODATA) {
+					set_bit(i, &stripe->io_error_bitmap);
+					set_bit(i, &stripe->error_bitmap);
+				}
 				continue;
 			}
 
-- 
2.43.0



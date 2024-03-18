Return-Path: <linux-btrfs+bounces-3355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1487EA78
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 14:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CA82832CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3D4E1D0;
	Mon, 18 Mar 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j62AnLKj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE71FB5;
	Mon, 18 Mar 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770308; cv=none; b=j44jQo67WeGzfjAEy9Ns/zB/ntnlhY1/e40/Lfs6IZYiIv+EPQh88xGwG2Ry/5DtppQJyPjzj5f7UDBIGwMx5ZZ5Eaq4Tfv8OJGvnclBB0GgZdAi/liLLF/Isrf1AzO25IuwJOet/5MkeHf2/Abwj7xtTEgF7VHp/aGNFtwcLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770308; c=relaxed/simple;
	bh=dMzvUM/Zbk0FRaGMA8aUc9LdTr/8ok38DpH/D1CcH7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/pp3IAz51l8lVMwCtQrzCwpdYYmCRskgLOKJ2Wjx5Hd8V+vWahJU1fw+69ZruEdScjo7hq2jWDwWLavL8G5J1wF4OrAVNv0sLGcBMe745h1bKSUH2hjDK93ctsve6hBDhpPGaIqzpzPmruronsHHJhlb+7fs1mJCPE8LYajCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j62AnLKj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430b74c17aaso20039691cf.3;
        Mon, 18 Mar 2024 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710770305; x=1711375105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSQCQqKJBFx+iU5VU2VdeBmE+xqs6g28IL9eUgwBny0=;
        b=j62AnLKjHYuGGTsKsuqX843rh1fE8PyBjRZuvROItJbj1zfcQLVtp7NdUC0VufPiBz
         F6Xm8i5FWbtg+KiPTzGaMh80kKwLB4OZc7sgt6qjDk7K/qzdtkozvJIxjhjjcRDoXaha
         XIpgZ4JBuXiN3jbBERQcgyPtGqXGI6Tc637BGKXKEeeJgCXorss1AIDx/Ow5JDy4QS/W
         Ah2A2jBBmNnz8lOXbWwMImX/QCSl+tSauaGcjd41dL0AUP6vn63igf6ldYcV1tpSYFwm
         BvpApH8KEZd0Sio9zwfd1q0F6Czn3HxwevSP8N5lBXHJsCBofAMMboqNGZHtfOIeK3y+
         w+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710770305; x=1711375105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSQCQqKJBFx+iU5VU2VdeBmE+xqs6g28IL9eUgwBny0=;
        b=QDyhHey2W6Qb4zTwx/BA1U6I6mandOj73783gnn3UMYLxB27ctq2ax7+ulhJb6Kj9C
         OYo/d7zv3LlQ9YkwRKWWnuOg7SadALWoxJXslxZqhw1bWkoSzHBUVBh5ugX6RkpWxHbL
         2YZ9smvYhmsIEumX1L9ERbamfiUi7jGQ0a9zkAA+INM3YZ3Ja2zlyy46N0pPOSoMiEcT
         gEpRYNCr/PNTKIHRwH7/VMLMXlbtHCRiJ7xD+9aw9FH9pUbbnBEFUtF2l/3BoRi77iku
         4j8KxjmOIK2K30vy9sTE7DLufrENZBNZsyKGqyq2RjAegLXrWutNKLjj5McGAvi2g0WA
         l57Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE776rH/mK6dqIsID4XmJ4yUAL9w/vHuJODX1D6g4xUxDGsOcvfxAVAsHhAK3s81rNDJlPjm1kMyLJ/FUZhWH/Iqq3aoLInoeO824v
X-Gm-Message-State: AOJu0YxwceSp0wed0KBpneg4Ck8momfRBiMKDL4L83Ai1NWMRCZKFt+c
	C2E0lqnXyMQE7bDfSoKVeXtsbFRWOjIHkzCy6W1GrqiJfezDTXd59/eemZCCNPk=
X-Google-Smtp-Source: AGHT+IFhF8g12nvXu9MYrIAAp0yqglL1lD+sx/8oN0Aj6o2yi5MBFlI3Rv/pmFmqrwTkXgYoVpcUZw==
X-Received: by 2002:ac8:5d07:0:b0:42d:ff64:edf with SMTP id f7-20020ac85d07000000b0042dff640edfmr14931760qtx.7.1710770305122;
        Mon, 18 Mar 2024 06:58:25 -0700 (PDT)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id fb19-20020a05622a481300b004309cf16815sm1284968qtb.39.2024.03.18.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 06:58:24 -0700 (PDT)
Sender: Tavian Barnes <tavianator@gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
To: linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Tavian Barnes <tavianator@tavianator.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] btrfs: New helper to clear EXTENT_BUFFER_READING
Date: Mon, 18 Mar 2024 09:56:53 -0400
Message-ID: <477327c2e21e253b56261f504a91603419bb167a.1710769876.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710769876.git.tavianator@tavianator.com>
References: <cover.1710769876.git.tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are clearing the bit and waking up any waiters in two different
places.  Factor that code out into a static helper function.

Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
---
 fs/btrfs/extent_io.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 61594eaf1f89..46173dcfde4f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4270,6 +4270,13 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static void clear_extent_buffer_reading(struct extent_buffer *eb)
+{
+	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
+	smp_mb__after_atomic();
+	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
+}
+
 static void end_bbio_meta_read(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
@@ -4304,9 +4311,7 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 		bio_offset += len;
 	}
 
-	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
-	smp_mb__after_atomic();
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
+	clear_extent_buffer_reading(eb);
 	free_extent_buffer(eb);
 
 	bio_put(&bbio->bio);
@@ -4340,9 +4345,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	 * will now be set, and we shouldn't read it in again.
 	 */
 	if (unlikely(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))) {
-		clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
-		smp_mb__after_atomic();
-		wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
+		clear_extent_buffer_reading(eb);
 		return 0;
 	}
 
-- 
2.44.0



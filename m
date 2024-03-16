Return-Path: <linux-btrfs+bounces-3333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83BE87D7C8
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 02:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78201C2125C
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7F4C97;
	Sat, 16 Mar 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlU+2MKb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885864C6D;
	Sat, 16 Mar 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710551731; cv=none; b=tHNXzi67U0ETb17HXRxjpsPFTQDZvfoTcgW/8tcMzwETjCE10Y/sCjjWmFbHCltjz70OcWcKYdkGKNsLqwiYs8Yw6p4G175FuUsYUuC5G28/v3nULKMd/Iok6emtJp2xH69oAd6BcHQwoqzZkTd1pFNAFgjNIX8EPlX6nUugz18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710551731; c=relaxed/simple;
	bh=zT8bamq8EMZLHFCd6L2KaOnl1iKWXf0oNF8trJVvLTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8kbZFsigxTDjOOYpa96Xy7w1/kkE0VNBGVxBvRo7lt8icIRrhrO1NqPAZcAO2BFjMB+R/q/LLI2Ivo4s0crpMN7GhV0oUCzEdEZ9MBGkCT3LwHGUjTKsoxu4Q+XyaqiLFbJbUmP10yfjrogTZ7y+81tA/ZwF4kl8YlnPWR/wzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlU+2MKb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-789e2bf854dso91727485a.3;
        Fri, 15 Mar 2024 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710551728; x=1711156528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U6bXORTuHKGPABlHcn3jWNTWuOAIIqRuk1nSBeLB/bE=;
        b=jlU+2MKbZpVugh+7CXvWjXqnnGVVlOzTt4bcGrkDG1Dg0BkcQZnkeoUxQiXNj2Wudz
         MarviRlYFHRt4KPhq1oP3uRkLTNfXkaWyxlobIy6MmAONc2BxOnZjImiXBMmV2Mg2UGI
         vsQuLEtAbc2Oy+0OA5fMo3ztIVZ3eUThy7cOkGS5kmRni/M5V0jv2iMI0no1RhgofHYq
         CO28WLXpsxys8XYyDP4p4ppUCibJg2pSukH76FNxXmLC5nIXnFuDHf1oDLSa26s846VH
         JnjQi+tqkLoBMJlY1vbTFed69sNhYYbRU93x1dR/lSCM2h65qyQ/xK7Zf4OOJc79HeWl
         sJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710551728; x=1711156528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6bXORTuHKGPABlHcn3jWNTWuOAIIqRuk1nSBeLB/bE=;
        b=jDdbb7XJC9pNqjeQk2Pq2r7CxvLCAFUKj9rhk4Gr0dkH2WdlYD4UnPmJ/F0BF8I5KK
         WhEbMt0hlwaFFHkpQZ2FaALQx27bVRUJl79beHuYMQAa7E+v2L/OHYyMbfL74SnuVKkR
         Lg/6BSDIBFI1VIZsrsGZIVRmFhLO0xOFqA1oKJpBKbz9eYL92BXyXnAmXI5i+lGrEAGL
         kMpnTAS6AO7/4eHzJnmHAMaT1HOJGFn87QXvkR3IzW6qdDK9pETvJjSzm3oBq3KTCySY
         j+kSmP18P3zvB/bTA+RVYJE5FgmRPf3fRqdLFjci9CxPozimm6v8/p6jHhw4NUE229tb
         t33w==
X-Forwarded-Encrypted: i=1; AJvYcCWqKLb82joKXhZ66GQoCABlQiVyvjebmUPTPPTrmN5NX3eg/etOEsCD8NMeGaKzDvKLmetrVBnZbDaDZRfWrjwUlkt/g0GXVIJk6t6S
X-Gm-Message-State: AOJu0YwwWKbJ7KxZfhorvyFNgtrbidN9wOXEkG3Gm77z5+gUlQRrcxZm
	5+7UjbSRq7kEIn3oFftI+KwdHV1yIFLdLVLNDUoRPPK1Ld5Jb3e3pkA11qJ05J4=
X-Google-Smtp-Source: AGHT+IGvVchB/qgx8QuvMz2wSp3M91MVk7u8P03ZZ3bXLXqCItPeMqcmJ6YhQkDsAVnsFEKd+9rFbQ==
X-Received: by 2002:a05:620a:381:b0:789:ed7f:94c1 with SMTP id q1-20020a05620a038100b00789ed7f94c1mr549149qkm.73.1710551728087;
        Fri, 15 Mar 2024 18:15:28 -0700 (PDT)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a13e400b00789e94cf424sm622950qkl.108.2024.03.15.18.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 18:15:27 -0700 (PDT)
Sender: Tavian Barnes <tavianator@gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>,
	Tavian Barnes <tavianator@tavianator.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Fix race in read_extent_buffer_pages()
Date: Fri, 15 Mar 2024 21:14:29 -0400
Message-ID: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent concurrent reads for the same extent buffer,
read_extent_buffer_pages() performs these checks:

    /* (1) */
    if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
        return 0;

    /* (2) */
    if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
        goto done;

At this point, it seems safe to start the actual read operation. Once
that completes, end_bbio_meta_read() does

    /* (3) */
    set_extent_buffer_uptodate(eb);

    /* (4) */
    clear_bit(EXTENT_BUFFER_READING, &eb->bflags);

Normally, this is enough to ensure only one read happens, and all other
callers wait for it to finish before returning.  Unfortunately, there is
a racey interleaving:

    Thread A | Thread B | Thread C
    ---------+----------+---------
       (1)   |          |
             |    (1)   |
       (2)   |          |
       (3)   |          |
       (4)   |          |
             |    (2)   |
             |          |    (1)

When this happens, thread B kicks of an unnecessary read. Worse, thread
C will see UPTODATE set and return immediately, while the read from
thread B is still in progress.  This race could result in tree-checker
errors like this as the extent buffer is concurrently modified:

    BTRFS critical (device dm-0): corrupted node, root=256
    block=8550954455682405139 owner mismatch, have 11858205567642294356
    expect [256, 18446744073709551360]

Fix it by testing UPTODATE again after setting the READING bit, and if
it's been set, skip the unnecessary read.

Fixes: d7172f52e993 ("btrfs: use per-buffer locking for extent_buffer reading")
Link: https://lore.kernel.org/linux-btrfs/CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com/
Link: https://lore.kernel.org/linux-btrfs/f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com/
Link: https://lore.kernel.org/linux-btrfs/c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com/
Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
---
 fs/btrfs/extent_io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7441245b1ceb..61594eaf1f89 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4333,6 +4333,19 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
 		goto done;
 
+	/*
+	 * Between the initial test_bit(EXTENT_BUFFER_UPTODATE) and the above
+	 * test_and_set_bit(EXTENT_BUFFER_READING), someone else could have
+	 * started and finished reading the same eb.  In this case, UPTODATE
+	 * will now be set, and we shouldn't read it in again.
+	 */
+	if (unlikely(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))) {
+		clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
+		smp_mb__after_atomic();
+		wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
+		return 0;
+	}
+
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
 	check_buffer_tree_ref(eb);
-- 
2.44.0



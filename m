Return-Path: <linux-btrfs+bounces-9656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CCA9C8E7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29219B360BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB91B21BA;
	Thu, 14 Nov 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WoVpXnI4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82571B0F12
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598105; cv=none; b=ukjdvBTAYZazJPRtpRmZi+4emYyn41KR6D+MDHs2CY5EbSBmMSaUxsLmLQm9rl6YfZYO05yvPHCn591+DKjsKLqfZt4w+lAQ8XmUzG4zmVtT6Nn6SVFfsxBKeCkQtl6QF850Ude2UErOgYhHdGGmNVtNnWr3n3v35JCh9sN3Zmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598105; c=relaxed/simple;
	bh=JN6ziuaz3h3w93syhui0sSuROUWYBUO3x3xlg3f4CsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftY+cN5Vg4WThhkYL/J5N8favv03ZG31cXx72DWmctfzwD6kYoU2gKT3yIB8HzldP3RdvXeOXcgsSQy7HTaMJws5yN4QHK2cpFNTXvOmposX5bgL3ZCc9Bku0PZDd3sMedA66TkG5DwfThBUUwTDlN/2O9fo+kQODJh3xxfgWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WoVpXnI4; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5eb9ee4f14cso355466eaf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598103; x=1732202903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=WoVpXnI4R1Ju0TIEnacr+++McpiDpZpH9Q7rsPYH9SpUn9vMZESA2hvlpzAFb9slK5
         kHIWPHr2fDItNhMzgknehqNQK8tLhPA9JEvW6hM73LhaRRy6P1wbF/oxMPPvvikdQ/Zo
         3sMPrcD5h4Ji5j8LgRvmBHgma4Qs8y09MMpZ9DnC2FgWelnCb80ECIqLDA7SbF6FwbPl
         5mw+If/NSXb+vofSMxXaNJ078D5LfKDV2JciLksbXBrH3M8HL0sYiVrD35w7uu0bImjQ
         QiWj0Z+1VD54U37NAz28/FTSm3TmZ4IaXCvolffB+k3C6WtLklSP3aDYWTWP1lxSYnA9
         eOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598103; x=1732202903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=DOvsQ99IG0yEDxQQ/6Vl/Qo3riIrR+hwN2jEJlp3h/vwGSbwn2z1Eeu8UyBQxBo/g9
         sbWLJi34isE7YH2p9SLRljwoOIFMXSfYc5wQ8znZmEFTTl5omive5GXDfhOU1MIUzy1s
         7pSgs3ObBE6b/vHGBI56UUOFn+UMg14usbSyEpdv4fYhOlUTLxCkvzwsa1zjL6V1hl8r
         ZHvFSlOuFNWTUpHiN++t6qeeT5qGKqYAEnOaGgKTlOfC/Au+zJ5EOBlkxeqtgRPJ2d20
         NxwQmcWpB8Hxom+fY4LMFyM0qh5TAhFJ+51VPsHWruWhnZbdnpRe91tuDVSRbVyRlDdB
         nQwg==
X-Forwarded-Encrypted: i=1; AJvYcCUi9HjOpZAYnvarbeOBYAVT2yWXrMKDnxkfJvltbtf7Jp3ahlbg6XEFUjF6EdcolV+CHxgfQq4LcXzG9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uQvCdk6za9WxOYop7XTBRPZVmx/cmpBP9XFfWqrP1aa4wPLd
	t0knZ5kpU9dA/PHq7ghu3JiyHFfGwx55nHCSK4pLh2io4YDOJMbAoxlwS5qduqA=
X-Google-Smtp-Source: AGHT+IGxBOidvnNn2woru7d3dY6RKyVHYMtr7QGUJGpSzdzZfL3L6KYNggyKAJszR8sQZicyWvWugQ==
X-Received: by 2002:a4a:e90e:0:b0:5eb:88a5:20e8 with SMTP id 006d021491bc7-5ee9ecc2c38mr2597677eaf.1.1731598103136;
        Thu, 14 Nov 2024 07:28:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/17] xfs: punt uncached write completions to the completion wq
Date: Thu, 14 Nov 2024 08:25:19 -0700
Message-ID: <20241114152743.2381672-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They need non-irq context guaranteed, to be able to prune ranges from
the page cache. Treat them like unwritten extents and punt them to the
completion workqueue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..c86fc2b8f344 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -416,9 +416,12 @@ xfs_prepare_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
-	/* send ioends that might require a transaction to the completion wq */
+	/*
+	 * Send ioends that might require a transaction or need blocking
+	 * context to the completion wq
+	 */
 	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
-	    (ioend->io_flags & IOMAP_F_SHARED))
+	    (ioend->io_flags & (IOMAP_F_SHARED|IOMAP_F_UNCACHED)))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 	return status;
 }
-- 
2.45.2



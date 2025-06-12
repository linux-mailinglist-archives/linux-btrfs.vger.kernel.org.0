Return-Path: <linux-btrfs+bounces-14616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065DAD66CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 06:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A363ABE32
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 04:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45191C860E;
	Thu, 12 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvNaxz82"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63210E5
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702841; cv=none; b=d+p4MUw/2nGbePdT8TnkW+ZiD//sTuNtt8qejrvmRhBblwA/8AaLbm+anWHNRfmjqDez8ojx+47OE+MyS9nh1VNgz6l6ItEKXGTrYkgPLmBQOqGUgjy4eel+mAbpx5plgGM5afQorAvV0pHlzDRpbZ6d1imjAFGmLA4XPSqcAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702841; c=relaxed/simple;
	bh=Vy+SY0RJa17nyeHzH26PqfiNQ4teZk7xUMe9upg9yZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HquK48jkrmc6a5E6bBCtpoHVe7GVKbAEg/Nobee6lAfMgCJsMUzxuvlbsd77UA2ENU+lKgE2RQ4zoa3U52yPUTZOib91M5Na4nN+5RzP527USR32IcUPk9uHjAlShOXYN0Ak5EbdunECh0WBMaPszjlt6iLEjGma+M51vWbdoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvNaxz82; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7d0a61e6c0fso11025685a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749702838; x=1750307638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxeZIWk9OvOP/g2tQArBNtTRS6k4f/ejWX/1rC9kAQw=;
        b=PvNaxz82M7AgD0Ui9SC7vKTJppZPju/KGM4QDIpPJOJI7Oz36gCHEGyJi9ratfoDs1
         V+El/3Q4kd4RBOjdWSGOQnvBoqEfsMG0RXFcHLHvQi9PCi4m+e2OHZcKYT3iWfuZh9iX
         iDH1KZCpUZBF/wbAueoOomRAvAeZwBl+/NgnC7aoNIf/0AvIHH4WS52Boq6EjEMyP2Lr
         pLAbk3dl4dtKx1KCVLbSAnrqRHb+R+S6kDdezPZo1ZHeQw3mSDa7Okf0FwtgoWEYC6FL
         s+f5t0+GUHiHX1xikPFldFli+ELQL/AoapCzb7SmLRi5GTKxcO9MZ5DskzrAwid8wx5S
         mxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749702838; x=1750307638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxeZIWk9OvOP/g2tQArBNtTRS6k4f/ejWX/1rC9kAQw=;
        b=c+Bi/lUCD/6n+C6vu98AxxtoYQyLvf9EKh3EN3i2g/kC04Fh3TRoftcVGaff4Qyj/m
         0IEXbRj+bZ/e9dxBG7CJSDE8UyVXq3Wlql7nuWXbc7XuxzDHiAGtHuPDBgOsubm2rRZy
         4+DzZwCSp8OF2k3yV/2v/RD0GNZs5QD/lm8EiIMzifPTsB3e2aHCIYwmui5gNlSaLZkt
         hKMNPvknfsTbkmaAO+D7xdwIdRQJ8dLL+NZRgJ9bl3SXTXegUAVoXxYiv0wO8Xue3Giu
         WwIQAhiMzGN5Jr4X1Kiug+pJd6pA/WDScxaEIBxPmCMFQzcf5YEfUeOajF3UOWX+7Jmo
         KrWg==
X-Gm-Message-State: AOJu0YzGe1rGq+TNATHARpU6RLtmim1kgTpiZ0s9r+lMG/+8dVnL8cFD
	L3opuf+bsFTF3KWAzcx4cTBTEX1RBgaRXLZblk96a1M9yUj/boSwUxOZbwhHHJuVBjXq0Q==
X-Gm-Gg: ASbGnctmJnYYr3Kl2pyE5G3UKvmvcVutbIwm5KpXZZnBlwDz2+o7Ql4UlLH8+EMMWo2
	hYYToFQr4aP+VfVnQF1N41IKaoCOxk0Dl3uNf8q5fApYKItGgdf8ROlPb4B5GYhaO5glifw0DKp
	Y1h1GB/gJZ5ZWU3uq9784K9KwJCpmgnC3TNGA5603GaniKeMuyBhvkBIz3Z1hHS5Wn02JT6rV+b
	R2iu6KlVECJznFVOwNpNfkF276eyhIBhXzlaqg3/n2Nn4rLTfl2uuIGDDebsf9f5eKBGmUSrbj8
	PpHf2IPx5VJ8nZByekOeyDYaj3qmBKn3mhkOZTfKlFB+nr74h+u+AjI2I1mgHg==
X-Google-Smtp-Source: AGHT+IFa9KC70ptby3Nd3UWLyjwAGbopWcZGcJOdv/+9FhbM0nZ+Pfacxn1m8h0toSK/1tDW9JaccQ==
X-Received: by 2002:a05:6214:519d:b0:6f8:af9c:b825 with SMTP id 6a1803df08f44-6fb2c32a96dmr37463436d6.3.1749702838564;
        Wed, 11 Jun 2025 21:33:58 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c42a28sm5524836d6.83.2025.06.11.21.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 21:33:58 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/3] btrfs: narrow loop variable scope in copy_to_sk()
Date: Thu, 12 Jun 2025 12:31:11 +0800
Message-ID: <20250612043311.22955-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612043311.22955-1-sunk67188@gmail.com>
References: <20250612043311.22955-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop variable 'i' is only used in the for loop, so move its
declaration into the loop header to reduce its scope and improve
readability.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 913acef3f0a9..10c243d32b34 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1485,7 +1485,6 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	unsigned long item_off;
 	unsigned long item_len;
 	int nritems;
-	int i;
 	int slot;
 	int ret = 0;
 
@@ -1493,13 +1492,12 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	slot = path->slots[0];
 	nritems = btrfs_header_nritems(leaf);
 
-	if (btrfs_header_generation(leaf) > sk->max_transid) {
-		i = nritems;
+	if (btrfs_header_generation(leaf) > sk->max_transid)
 		goto advance_key;
-	}
+
 	found_transid = btrfs_header_generation(leaf);
 
-	for (i = slot; i < nritems; i++) {
+	for (int i = slot; i < nritems; i++) {
 		item_off = btrfs_item_ptr_offset(leaf, i);
 		item_len = btrfs_item_size(leaf, i);
 
-- 
2.49.0



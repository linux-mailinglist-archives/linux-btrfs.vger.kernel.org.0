Return-Path: <linux-btrfs+bounces-7187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAC951644
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 10:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FC4B220E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBEE13D524;
	Wed, 14 Aug 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="xp5F+2lZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7886126
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623256; cv=none; b=OFnm1A85SGwd1qRXAy+FTMzlw6DVNZrsIBDNbm5kmcPly83thAtSvAC/PaQk3Pm+1sSXHTh2HT5xfG9NTkFqUfkXYjYmCXK2y/xjxj5Dx/JlfDTM/NwSK7VOOXjDxBcTt80PcmKJfGA+L7LDmZydC4zBQ2haI2+kVjd/gmee+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623256; c=relaxed/simple;
	bh=lUpCW99eNg5vkK25e0gKoFBbywiIER/+T1SiprkyiTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kda8w5uxXnWqETkQKrrotrjRGcP9uUmCSjHJofCZ5qDdpiqKdM3sOgfvt+GIlj4jPdueyvse/f/5SQSMTpUokE5tQBVHk9CtvW04HLjJzBN1LbVEtM+kAqrCMwiZihqA7Au+mk+Vk8+/nZSBeQteVK6ipC8B3yY/tG0yBaik5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=xp5F+2lZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367963ea053so4950610f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723623253; x=1724228053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2MhE9T02qlicCXJIOlaKbeQ4BlaVRpkGM8J9n1s408=;
        b=xp5F+2lZbO7fKF4bhzt5XD6ZfwDUA3B5kNq8mF2K25L8jhEatGqw9oz/+BTY4eNrTg
         1er4goG/n8CUG0kT5GAV1qhFqKKcm2XJ674bHvzjjkuH8r3tvN4N6ESQSpdF2Pa1lYsd
         8Sgf9AqTIQ2TScL2fu0xreF8mla7SFj/8QFHLiLCSXRjmbNq+5OQXwOPZzSWS9U0//3d
         V2WA13QJEWr+dnekZCx7GWD+Pg+cEXStlG+OK0VYND3O6gneOzDpJro/Lo6A3e//LhkN
         pVuGDhY3BWEkzTToC19aEwA48OuzdSds5jCc6Je1POxkG47H2SpEHKlin5R/wknpq+BK
         J5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623253; x=1724228053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2MhE9T02qlicCXJIOlaKbeQ4BlaVRpkGM8J9n1s408=;
        b=Vw2VRStpTWJfHaXzVFMYtcaQ194VjgVhXBgv9YduaOjGq8mQM2iPI5y3ARYqs2K39j
         /iyX4bBwtV4nO0zgYuiu26RMpwQ+bCb8n+xg2kCClKE9DgDUcH9qPsBUomT6Hk+m9NNq
         X5k9yHldmFOpNwjS1USbkDTinT1h1lgRc8LNUfd0b59MlMIpnfl4/g1imTD5D8E3O6gD
         764/qrKNQmHlpbKqkqdR0K1j9SVI2WE2F99X66FS6fCyz5VRre88KOUaWEwyMg/7sza7
         qtSamFGQ29M+zhUE6Gz0AWf//q32mnpuXXckO+0lZ8+9jLDd6nFUwIxS1l2ErjWeQOsq
         amsQ==
X-Gm-Message-State: AOJu0Yzb6zLI0UJF0wF2hfrNZ5OUK32OBh5lbsv0hzF0OE5TawxFx873
	DNXZu7cI8N+Djo5TdU5J3UBfD6R+sAUmekHCIij7TL8dZ4hhl1Co98V0CqGifec=
X-Google-Smtp-Source: AGHT+IHpolfM6NNB/HEnomjj8UK5buQ67rajgbPrjTUUH7umLau21LMSc1FmvzG4ylSy6BwkNA6bow==
X-Received: by 2002:a5d:64ec:0:b0:369:b842:5065 with SMTP id ffacd0b85a97d-371777de9b8mr1845068f8f.41.1723623252726;
        Wed, 14 Aug 2024 01:14:12 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd374bsm12132027f8f.109.2024.08.14.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:14:12 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] btrfs: send: Fix grammar in comments
Date: Wed, 14 Aug 2024 10:13:29 +0200
Message-ID: <20240814081328.156202-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/a/an and s/then/than

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ca711a773ef..02686e82eb9b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -62,7 +62,7 @@ struct fs_path {
 		/*
 		 * Average path length does not exceed 200 bytes, we'll have
 		 * better packing in the slab and higher chance to satisfy
-		 * a allocation later during send.
+		 * an allocation later during send.
 		 */
 		char pad[256];
 	};
@@ -1136,7 +1136,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 	/*
 	 * Start with a small buffer (1 page). If later we end up needing more
 	 * space, which can happen for xattrs on a fs with a leaf size greater
-	 * then the page size, attempt to increase the buffer. Typically xattr
+	 * than the page size, attempt to increase the buffer. Typically xattr
 	 * values are small.
 	 */
 	buf_len = PATH_MAX;
-- 
2.46.0



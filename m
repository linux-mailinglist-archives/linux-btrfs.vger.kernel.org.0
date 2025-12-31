Return-Path: <linux-btrfs+bounces-20054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B62CEBD89
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AB643011920
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7D25B662;
	Wed, 31 Dec 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDmHrAdm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F4279346
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179813; cv=none; b=oMFRBQiDpsjw8CwRIX3iaSzszSYkmkMYNch3+G5/4xZS7OzqVYQDvw7ExFN9I5M9rr6TK5Ww1xHEIxpFmc8YAuTKgrDInoZ1ucAECJIyjAiNowX6YE0589jlMWZvkpYhXt3MXs7jBrj2+OKm9cjQH5yl36WilpW6ELn0JRM14eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179813; c=relaxed/simple;
	bh=LlNREtuP9ynkf26YaALmuptkl1hQ1v0J/g1lXQAQ7mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApXbj5yaLUFCQAxt/YMqn2RIxKLA7mMIlMmxL/e8bmco/l69C6WYgBaNMXYpsXyCabt7AnyrpmIdb94onfC4TCas4IqTXbMHjG47yFn8BvFRrDXOlZakAvMO93Nwj4DXhs4Lc+/GurMlulloWlhbQrT7hpXjdMmCvbzA4gp7eZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDmHrAdm; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f08b909aeso23833825ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179811; x=1767784611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7qw/HNE6J5Ta1CU3in+uOPOpM4GZ1JNqs5/ohGizr8=;
        b=jDmHrAdmuGulBWz7xUtpi1iGULCCbVarWeKJ80LxCZCRKmPbfwRXTAjIVW0H7UjMhL
         cSnlMsD/7mZum2dSu6RSswXBkrPsIIOpV1Hz1QW7GIqSdhRnWDQiikpt+oPNQEBltOS3
         fYxt5cU99bXo04Qt9qIp4VZbZpOgCH2aF+ncxC8sKOl0ztP35lf/7ea39xwPIoUca+El
         hM0OZGdmBcyR8/Yik/op484g+n+FXAR6XNH+5Vf6hwqn0UWCpdL/5PGIY48bVztpKOBy
         6a5yJzHX/0GeYpLaqBa6xH5QFvLgp6vMkSZZzFOPN5Syw+PpJxBz/Oo7VcALF2o4ESIy
         A6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179811; x=1767784611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7qw/HNE6J5Ta1CU3in+uOPOpM4GZ1JNqs5/ohGizr8=;
        b=OvmtNv7WegVklciL1qvhvkjBZHrP+BFFKT4kwCA+GDTk1xCGAxHxha1tBII1leWHbw
         VAmICxBbBfBeCwvHprFu+fiW9GNX5P+60AZgECk6OiES64cGC+Kxs8iKWNgqUEJJat14
         KM+zhU4C0jEg3qUuqBW2dv53sUSRHxtQljKdC9n1utTjlOQqlao7wNJbFQpM/g4Q4Eni
         Xr7o38Xxsyl/JMBQw/FGzICKBUYw0h0rVnfyVw82H7w841B289i3ZgXJP9lWyFLXAINd
         dsi+qMLoY+bRlWbVzBqrTdVAAFhZWTH0GHAotQcnOBgi7z8/sqBDkY49T7YxP+eMe56f
         lwJw==
X-Gm-Message-State: AOJu0YxeGHnNNB1EV5a0aMVRjsy4Cn89+ZvBhNjRCprM4OLx8oD5QOo2
	I+2qQWNlu4UdToctQ5GmHlEd4NyaAtgYfOAHQomux7vsmolFKXD5uaWBy1nfGCARoaDd0AQm
X-Gm-Gg: AY/fxX6oOMsEhOoZz+u0ttWsjtD8gsYmqw7GaN5cB/4dC5FsbgtWpiFiZ4e1yuSgYeX
	OdSkgptCpyHLi4ldm8bESP+s6AIchkEOE3FLU+mtefB7qpVeDwyKSwC0PufnyFBHc28A6EPuB6H
	uVeajl/ceSGv40Ci04ket687D+fHtFQgUEF6Clk4m4QBDGRaC44Tj5oi9oG5OdQmzsf4Y4OVzLN
	Xffr3lXRnxuqar+32A7Nn9yNwNgQealt088ky7QGp8GXEolaWvsWMuqeBznhDg2PesNTV4xoCqO
	2Y8mXeLWp3pMcrUmPt9HUhQWDe78H+cwXKnyV4vSwUtQqYVa++fW2CKiYbPEa7c9ZeGypMdY7Op
	94nTpirvRZ6Q1bLjtPr09cSSfMCZ6rQtUDkHH6cD293GL+fjQfeZeqJpx8aTFuiRYbWNiTXX1s2
	woMTuxVzMuqXos350+HV3SjEw=
X-Google-Smtp-Source: AGHT+IHxrEYGg816JdZBEeZ7lGlpypFU4CWvXhUZrqz3hQT4D+9aIf12JZcEN4nxuEdZXZ81H9829A==
X-Received: by 2002:a17:902:ef01:b0:2a0:992c:1ddd with SMTP id d9443c01a7336-2a2f2d56b69mr277144665ad.8.1767179811582;
        Wed, 31 Dec 2025 03:16:51 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:51 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 6/7] btrfs: clarify reclaim sweep control flow
Date: Wed, 31 Dec 2025 18:39:39 +0800
Message-ID: <20251231111623.30136-7-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231111623.30136-1-sunk67188@gmail.com>
References: <20251231111623.30136-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the try_again flag with will_reclaim and adjust the
to better reflect the intent of the logic. This makes the reclaim
decision easier to follow without changing behavior.

Also prepare for the next patch.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/space-info.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index cf2c4b7105cf..b6ec09aea64f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2083,7 +2083,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
 	int thresh_pct;
-	bool try_again = true;
+	bool will_reclaim = false;
 	bool urgent;
 
 	spin_lock(&space_info->lock);
@@ -2101,7 +2101,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 		spin_lock(&bg->lock);
 		thresh = mult_perc(bg->length, thresh_pct);
 		if (bg->used < thresh && bg->reclaim_mark) {
-			try_again = false;
+			will_reclaim = true;
 			reclaim = true;
 		}
 		bg->reclaim_mark = true;
@@ -2118,8 +2118,8 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 	 * If we have any staler groups, we don't touch the fresher ones, but if we
 	 * really need a block group, do take a fresh one.
 	 */
-	if (try_again && urgent) {
-		try_again = false;
+	if (!will_reclaim && urgent) {
+		urgent = false;
 		goto again;
 	}
 
-- 
2.51.2



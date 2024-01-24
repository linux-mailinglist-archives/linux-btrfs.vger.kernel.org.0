Return-Path: <linux-btrfs+bounces-1724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE183AFAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6883B1F2AD90
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2001129A64;
	Wed, 24 Jan 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KZepQo5q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7721292E0
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116805; cv=none; b=Qx0/x42OhKIwG2r4jJeRp5QSgqnwgIVE2r7HvqtzgVXeepvkWJZv6GqZIZlaj4lggyQsqc1LRj2TCKhHw9lEXdpfTNedgoycVR/oy0OgQCcaCszb7fAUejkSbhGIwWUFCJNsGelDmYgkovLGPEzJim0GM+XOIEiKn9/wbAF/g8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116805; c=relaxed/simple;
	bh=H+o9F8jzIhnsi4JQHLAg23y5GrbRgWs5MeiKkmOUwZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7h+Gt3o/RLVxtmu/EgMfQv5nBln0rKYHqKsGDJiZ/eHwwbPRX8fScuBo7qHq40K6HPqxnsFQryEERbFY4/yXnh43oi/olI8wpiO5bs+YE99ECOCdJNkuXqLqwBojH1jG4CyGUprJ+FTopDKel22OpaDB9mrW+X3nNWH3OA2ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KZepQo5q; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ffb528dc8dso33524067b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116801; x=1706721601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCdBR2G5HfGtYuIo2ocQUjM3CkUrXp0t8Vms/+tMMV4=;
        b=KZepQo5qOZrtW9KBASxseViwiCADbieSp8C4rGFF4gyJCB+PnN+rUe/NYb9Td+7nPG
         p8XFbmW91vFPqZ3lE78pgsm6ntmT6FBsPQ2NNC7/2MRaU3aYnRKiw3lNdLt4JdRnQ3Jf
         Mggn3cv8Uy7rCYJFBbBn+bljMA08AH61Tv2L27Yj2ZBpIS7lLyIEihoeXPT20qYYSlEk
         ZxaRF8QejfaM7N797xKcJr2FXpQljiCDWhZJivq58CGhidlfaz+IVkk2WOcLgCBacEHT
         L5WKIIH6rjGL04nZ+ZqvYC1dgkohwqumDhnVcP1w12YdIlAMyd7UmD3cEAxCJxl16Nf0
         c4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116801; x=1706721601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCdBR2G5HfGtYuIo2ocQUjM3CkUrXp0t8Vms/+tMMV4=;
        b=XGaF8p8ZQtbNe+C/RxDZPQJN7L8JquXMljoBGw+pPNbyaxxfPzTA/HcqwNLqZwob9Q
         /YRuA3QGUoEFv0uWhCOfccCYUT8XXFdZKofo9+L/lprktsZnZT1HGhixoG27rN7syh0P
         5tpjd80Q9ZTJ7RWMkfO3JvYXUMYLJzmMIzZcAhJ9A5ctgGllQtXbQxf91TuLRPxKaqBH
         CjLpmE4Eedzqvc8QZ8NF7MgK04WC1SwUbJ92G2rzH+LQMk0zNqK67hIsJn6ZuGHfciUq
         EAZaLFDw5tnJFINaYEMTTJ23eCeQTTX5i5jCuVgUrxqBgq0g2VC+QqAuaiNFwDwZNPzg
         ZKOA==
X-Gm-Message-State: AOJu0YywQDPYHMGNpcnkvF4rK3IICSkBYSVxSk+IhA+oiL+VyyrNzqsw
	o17F48St6w2eXp4iEdM3T1jZ7T43HIxmdgp03I70RQkZFHmEvQj2oR8NMXIrse1fme6tD6V5Iok
	r
X-Google-Smtp-Source: AGHT+IGubQv+cMkA5HQQvWBZ0mlo8Zqd16o2zyd481MfZ6dW/JoypLoMxFCC66l091HKND6A1PbGmA==
X-Received: by 2002:a0d:dd06:0:b0:5ff:8ab2:89a7 with SMTP id g6-20020a0ddd06000000b005ff8ab289a7mr916259ywe.4.1706116801603;
        Wed, 24 Jan 2024 09:20:01 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05690c030100b005ffa352a84fsm65934ywb.21.2024.01.24.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:01 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 41/52] btrfs: don't rewrite ret from inode_permission
Date: Wed, 24 Jan 2024 12:19:03 -0500
Message-ID: <aca16cb830a4d998e42c7c2d9442eaa12dbbd72d.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our user safe ino resolve ioctl we'll just turn any ret into -EACCES
from inode_permission.  This is redundant, and could potentially be
wrong if we had an ENOMEM in the security layer or some such other
error, so simply return the actual return value.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 95e2615bba51..2740f0359446 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1989,10 +1989,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			ret = inode_permission(idmap, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-			if (ret) {
-				ret = -EACCES;
+			if (ret)
 				goto out_put;
-			}
 
 			if (key.offset == upper_limit.objectid)
 				break;
-- 
2.43.0



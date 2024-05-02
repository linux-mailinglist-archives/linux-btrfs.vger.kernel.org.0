Return-Path: <linux-btrfs+bounces-4681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0328BA248
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24591F23961
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E01C65E1;
	Thu,  2 May 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="o9OoYScd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EC18132E
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685219; cv=none; b=T4q5ZyyIja+1mxk7wKjEITyIEb8CZdbFpMDJhX8n/FPiEAwqjnO2vxfHMlVti9Gd2f4CgeKmBztberOVsHcIDrIGFnHXn20aDpA+0LQFVTZ59p1qzQA9VEFMtHanKc186RgMRORnWXpC646vMemCk8a5rroomA6yJ0GIZ/coCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685219; c=relaxed/simple;
	bh=tVWXNCzdMWLdqo6Ilri79iJRAhyTbQmQeAhLhhvAFyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1uAVDfXzOe90feFum3LYMLVuQUd3sm6U3KGMNvpA2Hytu+moZO05XOC7BhxV9uC4eNMGvTxzEYuqZpoxX/HenjZW5TlREFakrxoIPguSWpqALPNaIYhk7ErS6UGhs6c+szJhr++UKSwrcyC+yspbvx+3eaQLslP66cKcGZjfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=o9OoYScd; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5171a529224so10519021e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685215; x=1715290015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=o9OoYScdHYuuenDc9CZlLY0tcO3eE4/qY+YyFolo9ynupcjYg5OyyaT2EOyyjV9jwD
         7kM9zFW19qAphPxyyl1kIJ6IVg2n4XBuR72MnhzhHGy5OCp6wP4ytOxPMGLXotIZY6+4
         BK7m/oHubHYiuEvwsXz25i31yabAPIMoI1bhOKihuJruGQ/FH83chFz/OSfKOXxlbUHj
         w35MF6vQFHzgdGyqILv6WxhgkS5tkIUr8wO1ZMXB+aeeJtqYKHjFvxhLo8V4dCKskzLD
         v8y57s+lrQgcUGBUcNMDf4lJEVaZIK0v6xUuF2DR12X6816mKotial+odtuoACnrDGgX
         p+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685215; x=1715290015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=KQ/Us/XOGbVxegnB7NsSSid6uX3gLwP9AhQTr3TbH23valPQAPMfeFIrANmWzZGDeb
         MHevrWkFc9P0VLuDiZXJ5zPPEMgOmeXPPAJCGXxk+jh+9K6DFJnG8IE04bU11wqK6XnS
         /O5pTrThMBOXQpYy0AYV6IFMrrlc685YKb3Bg/BxDaGQkfizEcSc17K2sR4IoGiNSkJv
         cmESMRCAuPzETcTF248ddKMwHictVN0Ld13rZC8WSHkW+V+Fvmc/croKMhb7SLgQwU6P
         rDmIEp9BxmlnZX7QS4RzpbG2h27sZpRwuTc0r/GB13/w2LisIiNdAq4Ma9PVmpguXbuH
         Aseg==
X-Gm-Message-State: AOJu0YyqCdFXwkPnGUBBNA2LfpZ8CrB5V3reSymwjmCotRd1IFR4Btpu
	8Oy1ZBrccDKrPAIz5k/Ydi2cdwxH/RbdHjfTi/FOFCMRKO4+02CgyHhiQ0c4r+k=
X-Google-Smtp-Source: AGHT+IFdU+CNhHsbaoct4Qy+KcY+OUDNYVYuy7Zm5gtsIUrtGa9LNDfgRLHazZskYH9L85fevDVJpg==
X-Received: by 2002:a05:6512:3144:b0:51b:e42c:2ec4 with SMTP id s4-20020a056512314400b0051be42c2ec4mr584685lfi.24.1714685214745;
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 1/4] btrfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:28 +0200
Message-ID: <20240502212631.110175-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/blkdev.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 93f5c57ea4e3..5f7ad90fd682 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -9,7 +9,6 @@
 #include <linux/compiler.h>
 #include <linux/math.h>
 #include <linux/atomic.h>
-#include <linux/blkdev.h>
 #include <linux/percpu_counter.h>
 #include <linux/completion.h>
 #include <linux/lockdep.h>
-- 
2.44.0



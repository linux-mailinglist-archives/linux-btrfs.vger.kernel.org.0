Return-Path: <linux-btrfs+bounces-10453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D747F9F44C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC942188BCC4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC261D4618;
	Tue, 17 Dec 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XIdXL33V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDA14E2DA
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419150; cv=none; b=tOR6U99jXS3neRVbpV2+yhaWB3gVRHJBr0r0cBusNoJddpP2z3AkyUzphmgg/BrpsIk/xyJ8KXR5LfYoaMCywlY7PE5HFNpamTmjPwlN8J+gAMcLUtpFpzBKTkihxDN1wurEY5S40ysZRVb9a858UV4Aqwj1EWfh1zy2hKj/CIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419150; c=relaxed/simple;
	bh=Cv6HizXL6holU2DDgXF3pMN0qfJC1IrVHrLfI7qBpqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMC+zc0EouLl3jQ/XVIBjEnG4y7pqa5rKlSIbD601cy0Kg0KO5zxQ4I9fLwhNPb9F4/QjFO/roENxP0IrLpO4ULPdupheW5Gwy9OFjCOCq6dUB5Td+mHUyGKCq33RKLJ4KBsWG2ofq3/ZK7OiaStS9GufQFfZMtwuyPglaRED8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XIdXL33V; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=5IZfh6M5oI/KfZ
	sFUAifgUU4kmJM71wt50i07+tWSL8=; b=XIdXL33V9Z4f4Bet8+miSYCZGwD9RT
	J2tIcCosCojNCxLCWdaN8HK8H7cNKDpEpx+jfb//oNSWnkwX0IwWJ8haGv4FsBpW
	wzW1M8t7dWJQDMExj/DSbOGxHI563BbTfjLkASsCxF9cHREjzM17KalJXYU1QdQE
	5UA2a9bjsM5garGO7lNmgqTr4eRQS8YgW6krVlza5oq1g0qMJ18stEpi4hJbJ6uJ
	X5gYHbGfAO7XpYCGugKyYxfiF5ucyMRoC/T5MxtcKqEZ5wlbSthKi5gixZ+gb/Gh
	NiXWSXo0pEv1vXjD5sR3A8bRXxddhXy4NWFhPUESh2LXGQFSp4R5NiEw==
Received: (qmail 3977827 invoked from network); 17 Dec 2024 08:05:44 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Dec 2024 08:05:44 +0100
X-UD-Smtp-Session: l3s3148p1@AXn87HEpjL5ehhtS
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't include '<linux/rwlock_types.h>' directly
Date: Tue, 17 Dec 2024 08:05:43 +0100
Message-ID: <20241217070542.2483-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via '<linux/spinlock_types.h>'. Replace the include accordingly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 fs/btrfs/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79a1a3d6f04d..78e558652908 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -14,7 +14,7 @@
 #include <linux/lockdep.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-#include <linux/rwlock_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/rwsem.h>
 #include <linux/semaphore.h>
 #include <linux/list.h>
-- 
2.45.2



Return-Path: <linux-btrfs+bounces-15667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB98B11983
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5623B1CC6BE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658B2BE7CB;
	Fri, 25 Jul 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xt00mY22"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41CF9D6;
	Fri, 25 Jul 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430839; cv=none; b=HH2n/GvD31Y5Tys94aTYs7u8QELnEeT5rJSWLYhHGywW7aoawPULyFqvOgj8m23yDd/2NSwihguXhtcxWT1GN3FDZqH4FFQ6JvcOHJshjtdTLE2MBeXFgzI1vr/yjGj5S0/ob+SkQiOxPeGBSeuMx+D6Qsy5Bxup5S/hPHXbBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430839; c=relaxed/simple;
	bh=FvkokQV6JjlIq6E+4Yn0mTQc+PvFQAVfuLeb6K0vmkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvHOafCE5FCFfTjmYU2ds0jtVOK2IRBZOLwSOeWrKLGnmZsYWQ7hkHAaR21LCew16o+pqszLnZKsdPX0WitWphhs20xf/UOPmRNTR/+4NP5Tp2TfrCdb5R44Mv7tIP2JwGorYA8MghxDRayIeNi/tntJZoO9FiUnSac5f5PqNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xt00mY22; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753430833; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8MrZ5zZrVqsHs1G8TMvb4ik2/Jqa3oQto4UpD6AoyGo=;
	b=xt00mY22loDzWaYqUr55pGlFYevDD1q22GPDle+mrcTPAEuL1A8TrSIje6gJYjuP93MEERvg5JcYDyjaqjhHX6ppxyLr0igrcjAdxtkG4NyqZjKcqRJySw/Io0XNG3RQy2NfNUD2IgStj7UEtU73rmD3lKygnjfveyZaTjEkik4=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WjwrbpP_1753430827 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 16:07:12 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: clm@fb.com
Cc: josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] btrfs: Remove duplicate linux/types.h header
Date: Fri, 25 Jul 2025 16:07:05 +0800
Message-ID: <20250725080705.1984011-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./fs/btrfs/messages.h: linux/types.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22939
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/messages.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 022ebc89af85..4416c165644f 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -3,7 +3,6 @@
 #ifndef BTRFS_MESSAGES_H
 #define BTRFS_MESSAGES_H
 
-#include <linux/types.h>
 #include <linux/types.h>
 #include <linux/printk.h>
 #include <linux/bug.h>
-- 
2.43.5



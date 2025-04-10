Return-Path: <linux-btrfs+bounces-12945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9AA83EF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221203B4330
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB825E445;
	Thu, 10 Apr 2025 09:30:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22125D1F0;
	Thu, 10 Apr 2025 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277451; cv=none; b=tVQtKLA1fcwTC9uXP2gfBkXUaT1qJG1hnBGhNWXKuM+XdV2EzGVsECFFaZSgSsSh0IsUKYWNoPpuZ76LOyO9ttnx5gn1+Tzm9SPljeztVE9MIN4b9gBM+6yC86ODpM7PyXMCx5Sw1HGB4W3rpvg3QyS6NPY0tJMvkkORLddaVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277451; c=relaxed/simple;
	bh=IePYY2sz4kk4EDDR/P1VylthiN46P8IuDPIg8wpVLkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iBpFX4mYNnK+3c4FzzpIVZFibsjxV54gr6GQiujwHuEeakk3u3u9jod4hW8nrduVosNYgv6P6o1d0VmG3PbSQH/LxWqSBiX+nqjobDnGaAiTB1efW2e60OM9VWRXZyNRKwwgLztxiaPFMFFCczQCRy8weTtwo8XCSIt32XXJGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201601.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504101708565208;
        Thu, 10 Apr 2025 17:08:56 +0800
Received: from locahost.localdomain.com (10.94.12.92) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 10 Apr 2025 17:07:27 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC: <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] btrfs: Fix the incorrect description in comments.
Date: Thu, 10 Apr 2025 17:07:22 +0800
Message-ID: <20250410090723.10166-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025410170941bc322a839e30b41a560ff517e6e5f210
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Replace PTR_ERR(-ENOMEM) to ERR_PTR(-ENOMEM) in comments.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 fs/btrfs/delayed-inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 3f1551d8a5c6..e35626270f2b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -119,7 +119,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	return NULL;
 }
 
-/* Will return either the node or PTR_ERR(-ENOMEM) */
+/* Will return either the node or ERR_PTR(-ENOMEM) */
 static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		struct btrfs_inode *btrfs_inode)
 {
-- 
2.43.0



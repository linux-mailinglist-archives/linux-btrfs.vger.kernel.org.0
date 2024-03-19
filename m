Return-Path: <linux-btrfs+bounces-3430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4A8802E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E7E1F22F01
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC33225DA;
	Tue, 19 Mar 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pVbJYvWn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AD22325;
	Tue, 19 Mar 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867686; cv=none; b=euiTqLnlrheBm8LG33T0t7RM6JuT2m4pF+FtJW260eJyV5v7V/MKOfcFqvH+pbT6l2NqGP7XUqSYdtTdHLejKekXveKgehZV0VXSPEn1/STsE2g6dsq+aRO33jAY/vuOzL1dUt/YnCWQYPLShqAf/Is5To5/YcEkZfB0qXubFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867686; c=relaxed/simple;
	bh=wxIxc2IBeR488Pp5V7iK1mrm87z+nRMhkQtib6Wz2fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XF4cCM80RR4+r01UEuYahHK8pvKsBzKH3fKk45ifBQBE2WEmutY4ZE5u5vnspXKHBklUzbR9UJ4sklYAMipQg8UJ4qRwEofcIzYgdxsBaRlyTbHli55fRJvKJwFEH9Cn6q8QDViFAc1228+eOnY4fHYAw6y/nEsB8ZjKnBjdggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=pVbJYvWn; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1710867685; x=1742403685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=57GW99A4GkQXZIGOotFJOmgnSAy9xxXesYfr5PIZPOk=;
  b=pVbJYvWnjX4L78jT25MhGstivW36dee8y7yVgnfgQW43lgvyFQMOioj8
   /Xk6BsWRx7W07RdvwvbinOrEH8Sq4gjUXWkkJcHlQTm2vTLoMpGedxdzq
   g0Sqq9aS8Ja4fobqOVAeUSvrMSMsqgEKIDI3F2XZvuyMSh8Uxfv6E2BrA
   c=;
X-IronPort-AV: E=Sophos;i="6.07,137,1708387200"; 
   d="scan'208";a="388874588"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:01:10 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:2537]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.112:2525] with esmtp (Farcaster)
 id 89419cbc-1a1c-4076-8a80-a430305b7285; Tue, 19 Mar 2024 17:01:09 +0000 (UTC)
X-Farcaster-Flow-ID: 89419cbc-1a1c-4076-8a80-a430305b7285
Received: from EX19D008EUA004.ant.amazon.com (10.252.50.158) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 17:01:09 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008EUA004.ant.amazon.com (10.252.50.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 17:01:08 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 19 Mar 2024 17:01:08 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id 3288929D4; Tue, 19 Mar 2024 17:01:08 +0000 (UTC)
From: Maximilian Heyne <mheyne@amazon.de>
To: 
CC: Maximilian Heyne <mheyne@amazon.de>, <stable@vger.kernel.org>, Chris Mason
	<clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, Qu Wenruo
	<wqu@suse.com>, <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4.19 5.4 5.15] btrfs: defrag: fix memory leak in btrfs_ioctl_defrag
Date: Tue, 19 Mar 2024 17:00:55 +0000
Message-ID: <20240319170055.17942-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Prior to commit c853a5783ebe ("btrfs: allocate
btrfs_ioctl_defrag_range_args on stack") range is allocated on the heap
and must be freed. However, commit 173431b274a9 ("btrfs: defrag: reject
unknown flags of btrfs_ioctl_defrag_range_args") didn't take care of
this when it was backported to kernel < 5.15.

Add a kfree on the error path for stable kernels that lack
commit c853a5783ebe ("btrfs: allocate btrfs_ioctl_defrag_range_args on
stack").

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: 173431b274a9 ("btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args")
CC: stable@vger.kernel.org
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 fs/btrfs/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 049b837934e5..adc6c4f2b53c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3195,6 +3195,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			}
 			if (range->flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
 				ret = -EOPNOTSUPP;
+				kfree(range);
 				goto out;
 			}
 			/* compression requires us to start the IO */
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879





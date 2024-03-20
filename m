Return-Path: <linux-btrfs+bounces-3465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE2881106
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 12:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A418F1F211B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DAA3FB82;
	Wed, 20 Mar 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="lLCDBYZu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F633EA62;
	Wed, 20 Mar 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934355; cv=none; b=H2RFjkYPzNIS3vJQj4KH157hYBylLTLDjl6eMUKySNNTiFkYRHlv8rphhgsAry9rLrBF/FVcYhrlSkBA5PZWnH9Ko7Wo65kUXO7GKxTLLb23huP97xuxaQOSc8iuEGQMZO/+1htMoWho6lUN9mm16rPhVtoyVQqIcrF+HIrFoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934355; c=relaxed/simple;
	bh=nvuYKgMQZ2dOzH1kP01A+m3+SU8aRkQ0BxBOYVMusPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MsYZnjMaUoraGE/a3a7lQyfcuUr7bjTR5jctYU9pOZzQVggsaAFQCRJHoxONF8OKdUlpoh/+v/djGVhxshMBd6Xzn8zjHE7f+QDSErU1okCCLVbuNJchcMBT6ehTo5sydhLcmSRsLHrGUmMrIjvkLa8LHtp7ufaenrChqzZK91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=lLCDBYZu; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1710934354; x=1742470354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SagNweem8Fra24984SKbM6xuTks7v+vVjcZ5YAq9KuE=;
  b=lLCDBYZuMBcREtL3Nt8Q7AfgvJ7wfFgk1RAiCVTW7ehB26Lmz8tGjVNF
   DpHCwVAahV4ZLMgVMhKB7iLz+pGPlGBftpHJESKMicjvFiM/eEDekesmd
   htsfHqTUoTaCR5TyKo31c4IBGnhH//wb77cvTdyvmGHwdNnbF2m7LqAbt
   E=;
X-IronPort-AV: E=Sophos;i="6.07,140,1708387200"; 
   d="scan'208";a="192899703"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 11:32:30 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:38524]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.10:2525] with esmtp (Farcaster)
 id ff41ffb3-822d-4040-8907-e5fea2025741; Wed, 20 Mar 2024 11:32:28 +0000 (UTC)
X-Farcaster-Flow-ID: ff41ffb3-822d-4040-8907-e5fea2025741
Received: from EX19D008EUA004.ant.amazon.com (10.252.50.158) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 11:32:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008EUA004.ant.amazon.com (10.252.50.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 11:32:27 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 20 Mar 2024 11:32:26 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id 65438A9F; Wed, 20 Mar 2024 11:32:26 +0000 (UTC)
From: Maximilian Heyne <mheyne@amazon.de>
To: 
CC: Goldwyn Rodrigues <rgoldwyn@suse.com>, Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>, <stable@vger.kernel.org>, Maximilian Heyne
	<mheyne@amazon.de>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] btrfs: allocate btrfs_ioctl_defrag_range_args on stack
Date: Wed, 20 Mar 2024 11:31:56 +0000
Message-ID: <20240320113156.22283-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

commit c853a5783ebe123847886d432354931874367292 upstream.

Instead of using kmalloc() to allocate btrfs_ioctl_defrag_range_args,
allocate btrfs_ioctl_defrag_range_args on stack, the size is reasonably
small and ioctls are called in process context.

sizeof(btrfs_ioctl_defrag_range_args) = 48

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
CC: stable@vger.kernel.org # 4.14+
[ This patch is needed to fix a memory leak of "range" that was
introduced when commit 173431b274a9 ("btrfs: defrag: reject unknown
flags of btrfs_ioctl_defrag_range_args") was backported to kernels
lacking this patch. Now with these two patches applied in reverse order,
range->flags needed to change back to range.flags.
This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.]
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 fs/btrfs/ioctl.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 049b837934e5..ab8ed187746e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3148,7 +3148,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_ioctl_defrag_range_args *range;
+	struct btrfs_ioctl_defrag_range_args range = {0};
 	int ret;
 
 	ret = mnt_want_write_file(file);
@@ -3180,37 +3180,28 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
-		range = kzalloc(sizeof(*range), GFP_KERNEL);
-		if (!range) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
 		if (argp) {
-			if (copy_from_user(range, argp,
-					   sizeof(*range))) {
+			if (copy_from_user(&range, argp, sizeof(range))) {
 				ret = -EFAULT;
-				kfree(range);
 				goto out;
 			}
-			if (range->flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
+			if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
 				ret = -EOPNOTSUPP;
 				goto out;
 			}
 			/* compression requires us to start the IO */
-			if ((range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
-				range->flags |= BTRFS_DEFRAG_RANGE_START_IO;
-				range->extent_thresh = (u32)-1;
+			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
+				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
+				range.extent_thresh = (u32)-1;
 			}
 		} else {
 			/* the rest are all set to zero by kzalloc */
-			range->len = (u64)-1;
+			range.len = (u64)-1;
 		}
 		ret = btrfs_defrag_file(file_inode(file), file,
-					range, BTRFS_OLDEST_GENERATION, 0);
+					&range, BTRFS_OLDEST_GENERATION, 0);
 		if (ret > 0)
 			ret = 0;
-		kfree(range);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879





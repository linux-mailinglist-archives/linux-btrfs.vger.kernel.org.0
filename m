Return-Path: <linux-btrfs+bounces-4693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA568BA5AE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885E9284D69
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB32C6AE;
	Fri,  3 May 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Byzktsii"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5E1F5E4;
	Fri,  3 May 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706621; cv=none; b=ewXWo31cA0C7vGSTxFbZCv2gf3TZTgnu+dT166n9wKq6/SGMjycc0ZkrNULf2m/0/QfVnK/eYA6WNi4STAJvkTa4jyyD/p7IWrCdmAGbqfnbZ34xJCs6LN+STDVndAi65HR2XZMFBpTfUWbXG7Uc/0Gr+lVF1IuPEh/8BrBORHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706621; c=relaxed/simple;
	bh=NpjlpBasDw/z7FV1LoIobqFo0v4WkLpRVIntjnupysE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jv1RnvV2qERFP96vt0guCc5GmSyBGrakq+mIf309MTiOQT0dedpJpAdA0dDlwZGS/xGojXZbcG+NGDuCvhEJF+KpYDm0wAhLobFP9bAQo56pqqvvd97MK7u0I7AG7o4/6eaheUcgGf8p7LE+2Q20gnVAv0OF4eklbEciN1QtdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Byzktsii; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sfJK1PqnCoZ9wUJOzrwSCQ9cwiM2bYAFjnNUULTe6yA=; b=ByzktsiiTZXbZzu/M7+dWWFZ5E
	eGyT/4sn5gzO+Qjyf87RjvTdtn8viMAZIIyMwdESpXbAvuC16FHsDcvRotqhG+obgVdNJgBqIZJPS
	y93BfYYIn0xjQGEtHpf0a8ovifGuxUBjYsTcR4BFrvXIy7Ve+nBYpxHSIPNMivUCEO17T3RVgOGDU
	7BmFNi0Is3ego90WyAX50edOMBZx9LvnVMHRR6pREmjxW2PimAkcYRYDsXaj5+yP8LaC8HZQVxSwC
	4Qq8dQnRbUH5d+/lLkI7aUrB8Sa13CRLFCF9/q3EDO99kWg48OAb14658SY5Fwcfy/ByGPZ/kfre5
	/gAbeK9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWD-00A2Vr-3A;
	Fri, 03 May 2024 03:23:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/9] pktcdvd: sort set_blocksize() calls out
Date: Fri,  3 May 2024 04:23:22 +0100
Message-Id: <20240503032329.2392931-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

1) it doesn't make any sense to have ->open() call set_blocksize() on the
device being opened - the caller will override that anyway.

2) setting block size on underlying device, OTOH, ought to be done when
we are opening it exclusive - i.e. as part of pkt_open_dev().  Having
it done at setup time doesn't guarantee us anything about the state
at the time we start talking to it.  Worse, if you happen to have
the underlying device containing e.g. ext2 with 4Kb blocks that
is currently mounted r/o, that set_blocksize() will confuse the hell
out of filesystem.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/pktcdvd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 21728e9ea5c3..05933f25b397 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2215,6 +2215,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 		}
 		dev_info(ddev, "%lukB available on disc\n", lba << 1);
 	}
+	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
 
 	return 0;
 
@@ -2278,11 +2279,6 @@ static int pkt_open(struct gendisk *disk, blk_mode_t mode)
 		ret = pkt_open_dev(pd, mode & BLK_OPEN_WRITE);
 		if (ret)
 			goto out_dec;
-		/*
-		 * needed here as well, since ext2 (among others) may change
-		 * the blocksize at mount time
-		 */
-		set_blocksize(disk->part0, CD_FRAMESIZE);
 	}
 	mutex_unlock(&ctl_mutex);
 	mutex_unlock(&pktcdvd_mutex);
@@ -2526,7 +2522,6 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	__module_get(THIS_MODULE);
 
 	pd->bdev_file = bdev_file;
-	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
 
 	atomic_set(&pd->cdrw.pending_bios, 0);
 	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->disk->disk_name);
-- 
2.39.2



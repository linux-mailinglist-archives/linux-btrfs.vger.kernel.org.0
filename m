Return-Path: <linux-btrfs+bounces-16825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4844EB5823E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AE51B20573
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A927A123;
	Mon, 15 Sep 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6lVrxUb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA725CC42
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954238; cv=none; b=FtACtNE634NqzAt2KKW2eZH4rzZLffHYpWbEorAFQY0rUJlSTY7fgG4pgal7VJzBEoqKmSccYvCVbhPf50Xhi4OwHHdY+yaULenRYgf8lKc5U2c80Jf3bphfL+k5k1Lb+Iwls4tyDJyqiJPUH13OZkZBVyDV4o1dQnQ44fMBTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954238; c=relaxed/simple;
	bh=uSWILHHPOjf8bNxTQpodZBmzTZfozAwKt6TB21OmDvk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TGXBZtowSFGAQSXgooO3EoU/m/LPx8sboUdH3lQIjXZc/ct5PpWK2RaWsoupTBWfBhPC6KVbZbZb9e8+4JNHhLHpTTzuPF8O/sLR6u9Dm4xZM9s1jZL7o4PN+7+vJ2LY6PJWe5f34/YJkvH6TpV9LtDUjXYJVg2clN6ODeFX67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6lVrxUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2653C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954237;
	bh=uSWILHHPOjf8bNxTQpodZBmzTZfozAwKt6TB21OmDvk=;
	h=From:To:Subject:Date:From;
	b=M6lVrxUb6lDQk8ZFdLD/7vMoiQVd+AuAdWYTRs5gPn8tY5ZJZhhA2lOZG5IiDkTja
	 C8ZomynSBWwGJpw2UaYZFFKWcvbTKuKsetpuGpc1AGTmYAnadACJCENi9mAR5017zO
	 B9ZNnGdSg2W46/DjG6iTSaE+uVucWLtE3u59LS0q5k2vV0F2NcLaHejuIQEaAJY9uD
	 KAVp+QnEELSvXux6+4ZSyG2bqq9wXDP22aoIZy1XHrtl1mrlDUELQ+EWrdWxxvU6lc
	 T2af/+wHYVxHtiYK9TuWv4Vv342IhXr+D0OCIRkjATEaFZu34dPQxqWf/iXZW6MgFy
	 YqCndpK703HPA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs: print-tree enhancements
Date: Mon, 15 Sep 2025 17:37:02 +0100
Message-ID: <cover.1757952682.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The following are several enhancements to the kernel print-tree
implementation. These are motivated by debugging log tree leaves and
apply to the type of items we can find in log trees, and having this
makes the debugging much simpler. Details in the change logs.

Filipe Manana (11):
  btrfs: print-tree: print missing fields for inode items
  btrfs: print-tree: print more information about dir items
  btrfs: print-tree: print dir items for dir index and xattr keys too
  btrfs: print-tree: print information about inode ref items
  btrfs: print-tree: print information about inode extref items
  btrfs: print-tree: print information about dir log items
  btrfs: print-tree: print range information for extent csum items
  btrfs: print-tree: print correct inline extent data size
  btrfs: print-tree: print compression type for file extent items
  btrfs: print-tree: move code for processing file extent item into helper
  btrfs: print-tree: print key types as human readable strings

 fs/btrfs/print-tree.c | 256 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 222 insertions(+), 34 deletions(-)

-- 
2.47.2



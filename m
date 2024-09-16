Return-Path: <linux-btrfs+bounces-8061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2B97A11A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 14:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14F3285938
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAF156F36;
	Mon, 16 Sep 2024 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRMF8VQ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91A15534E;
	Mon, 16 Sep 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488199; cv=none; b=mC6Hx9sre9zimab3UIMw8mKpPg4hNzDxjJVbeXeZQmsnSISmrRVNZZNU9VlNOyyX/KeH14qX9fXfEJwBMlPwzUL0800I3CbS74OPSaNarmFhTbac5WWy5fmn7W/2696vLtNAP9JGbxA2h2txgqRu6jqkzS7czZpFQvo58jOboWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488199; c=relaxed/simple;
	bh=lbtU0/wv7ulkVjSLGH+HvnFEQu4bO+9oGH33F51dffU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJXMpph5vU3e8hQTpbkPedjV/d8Y8nA39Dh/XuuqwSAdv+FLOfmW0I9rXGNRYccgFmxO8NRZ2aZYzKUy6WQ9P6ryrn1+OZwyngg8pQ6n3sZkcFnfa941ynjgcDUtftI37Bo476oI2xJwn8SIxlFo/S76iJhyWpQc3tYWO5QYpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRMF8VQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B647C4CEC4;
	Mon, 16 Sep 2024 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726488199;
	bh=lbtU0/wv7ulkVjSLGH+HvnFEQu4bO+9oGH33F51dffU=;
	h=From:To:Cc:Subject:Date:From;
	b=KRMF8VQ2zbsERi2SeuXELSR/edXsrb4jKbm24EUoNqifA4t1NY1QhhanGpT2n7skw
	 D9BXJxN3epHfCT11R9DLNLKvCHmuTpHd1fPCaVmIFBu+KdCE0zxDoMTApbSovFuH6O
	 ulRAazs3PDd2Z7rc1VAFfkfLyRByNW6omo81w0TEMD1ObMmzsgdb2TL2fJEk7/GhZk
	 x/AQ1YMrL8BoDRPrvnfsLxajAOMJkYr+5JVFTFRVVMZNr8wKzXeiaNjrD1Z1qQSOUH
	 RKK3RABZKf+3bQjhujpU4UPlfCk0gDaYDavuWnb4Y2be4eph3FpYhJZYiv9fbyyCTy
	 wY2h7DA3MryBw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: fix min_dio_alignment logic for getting device block size
Date: Mon, 16 Sep 2024 13:03:12 +0100
Message-ID: <0d6ec0b588b578b9f9aabef91b8ecdf9950b682a.1726488132.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we failed to get the dio alignment from statx we try to get the
device's block size using the BLKSSZGET ioctl, however we failed to
return it because we don't check if the ioctl succeeded (returned 0).
Furthermore in case the ioctl returned an error, we end up returning an
undefined value since the 'logical_block_size' variable ends up not
being initialized.

This was causing some tests to be skipped on btrfs after commit
ee799a0cf1d4 ("replace _min_dio_alignment with calls to
src/min_dio_alignment"), like generic/240 for example:

  $ ./check generic/240
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc7-btrfs-next-174+ #1 SMP PREEMPT_DYNAMIC Tue Sep 10 17:11:38 WEST 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  generic/240 1s ... [not run] fs block size must be larger than the device block size.  fs block size: 4096, device block size: 4096
  Ran: generic/240
  Not run: generic/240
  Passed all 1 tests

Where before that commit the test ran.

Fix this by checking that the ioctl succeeded.

Fixes: 0e5f196d0a6a ("add a new min_dio_alignment helper")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 src/min_dio_alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
index 131f6023..5a7c7d9f 100644
--- a/src/min_dio_alignment.c
+++ b/src/min_dio_alignment.c
@@ -42,7 +42,7 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 		if (dev_fd > 0 &&
 		    fstat(dev_fd, &st) == 0 &&
 		    S_ISBLK(st.st_mode) &&
-		    ioctl(dev_fd, BLKSSZGET, &logical_block_size)) {
+		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0) {
 			return logical_block_size;
 		}
 	}
-- 
2.43.0



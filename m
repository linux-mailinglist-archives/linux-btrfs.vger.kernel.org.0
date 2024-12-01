Return-Path: <linux-btrfs+bounces-9987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D59DF51D
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F04C28128C
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470F139D04;
	Sun,  1 Dec 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvH3dTFN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00974BED
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Dec 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733045772; cv=none; b=frLHrwJdA/ZtBO15t0qYLqw/v7r3rpUxjrX3/M0WKILoC/BpNsMblaWyFxgDrgrORfdqO6q/thyVfisZmUrN2BgngwQlsCx8xi9nCkAOmhLx5pihuUQRxbgu2+MyvjnnLPxzTPxW9vmZPvMUMDRuAdeEJve3JyFH4V1eRuv1/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733045772; c=relaxed/simple;
	bh=IE4LAlT4CHnSy+VJG/nkGoQkCvxrzBq1C5OtbyvYSR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwEocXlwJXyw1W8+nW/WIwd3A13WpXiu7V4NVEPB1q9QmZ7dkNdpM20gxcNK1fy5bdvbo3TQwr4WOHa18F64jMLYFw916Prx9sRXCKFxDm7xcuDyL6vNFgi3YuE4DoPBuphMbM7hN1BafCRFX79H8gv8BHcgyZQndQkIamkO/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvH3dTFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA46C4CED2;
	Sun,  1 Dec 2024 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733045771;
	bh=IE4LAlT4CHnSy+VJG/nkGoQkCvxrzBq1C5OtbyvYSR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvH3dTFNIul33BtAeIOy/ThatctQznqEhgqDCwzANcySa2Km66nN3B1uc0YB13i9F
	 KJDAzR8vb3JTTjph7l5nHgXsqzsxlxM056XbQrlhjn8XwL3KsySKYNui2w95XSSPJU
	 GWjOpL4JC6f/p00TFYf56kH+PtynZf2hQRMAUZ59QcFWWiW70ZZQZV6yzn6/6O4vQC
	 ioiCn7ch5lzdHJIwXamM/SFNfd4J08CMtKUH3AZN9zteMaq8ux/+Bt4u+g7358+FVp
	 13VlsOu1oiu3ETMC69YevbcabMRVtRxw0MGZ6E476yIly58S9HlQHEGPYxqeOuXkIK
	 PWt6zOL56yyTQ==
From: Zorro Lang <zlang@kernel.org>
To: ltp@lists.linux.it
Cc: linux-btrfs@vger.kernel.org,
	zlang@redhat.com
Subject: [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Date: Sun,  1 Dec 2024 17:36:04 +0800
Message-ID: <20241201093606.68993-2-zlang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201093606.68993-1-zlang@kernel.org>
References: <20241201093606.68993-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test need to skip test known filesystems, but according to below
code logic (in lib/tst_test.c):

  if (!tst_test->all_filesystems && tst_test->skip_filesystems) {
        long fs_type = tst_fs_type(".");
        const char *fs_name = tst_fs_type_name(fs_type);

        if (tst_fs_in_skiplist(fs_name, tst_test->skip_filesystems)) {
            tst_brk(TCONF, "%s is not supported by the test",
            fs_name);
        }

        tst_res(TINFO, "%s is supported by the test", fs_name);
  }

if all_filesystems is 1, the skip_filesystems doesn't work. So set
all_filesystems to 0.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
index fab0daaee..b7f676ec7 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -57,7 +57,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-	.all_filesystems = 1,
+	.all_filesystems = 0,
 	.skip_filesystems = (const char *[]) {
 		"bcachefs",
 		"btrfs",
-- 
2.45.2



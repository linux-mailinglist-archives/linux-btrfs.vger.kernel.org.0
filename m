Return-Path: <linux-btrfs+bounces-11597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C5A3C73B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767AC18940DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275E1214A80;
	Wed, 19 Feb 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtJOXbH4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5AC8468;
	Wed, 19 Feb 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989172; cv=none; b=BfP0hO89/kIGvXSuI5PKlUtwms/UckjFU0+tvJm1AD7gjKd4VXpbd3z7TRFQhfZVe4KSaz/KPxaTBbp7WLdZpKtA/vHzVI5SH4pbyDI36AJtJbQ2N6G/9gvgyuNbHZVNcAKXhLPhbJQV2GNnExRO1QCzS/v9UNUkWaViYbn4oHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989172; c=relaxed/simple;
	bh=nLx32WVgspgyqkguAoJe240rymvvIEipMeDDKkWhRrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPevawxjg29k3wYtQzLFKcFNP2QAcAV/0gJSgukDJJV145Z5f+YfOOfG6bt4mHis3a0gr/pYl5h2iPCF0uXioc8D1RgwtHeDL1u52Y1Fh8ZvH0PJLFPF1iVMtGFX45kh7vHoMN7JgaKF/Mzt9cjw66+yu3Hwq2ZBflrFYDOoWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtJOXbH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15E2C4CEDD;
	Wed, 19 Feb 2025 18:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989171;
	bh=nLx32WVgspgyqkguAoJe240rymvvIEipMeDDKkWhRrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtJOXbH47oCbeqlgezg18fej939lk2qo6S14auyRV8Fya9VZ9UTvs9io/+AvRrFFr
	 RaFB+LDZmmWE8sXZ9O3f8FWjyYCnkwTxsTu8IIVMxBg/VIC3cCbUvaYGxwdXO73bwd
	 3wekWN4/vKWCnYtosyDFLBcoPIA5k4Ece/z6sYf2j3AjrdIY2Tu2THqvLgKp7bDkm6
	 0oLUPTF9woI9sbVbM66l7MpNbMbwKfQhv1GwUcQWxYF5wbj32lD6eZd3ed/4k69W1S
	 rqLW2Yf2Gn9fmNmkPoxBNFWDj/X3m1LqDk4uySSyRwVki6o0qEgxrZHnBnrXnTZmOB
	 MsURB0zuUD+DA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of failure/interruption
Date: Wed, 19 Feb 2025 18:19:14 +0000
Message-ID: <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739989076.git.fdmanana@suse.com>
References: <cover.1739989076.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If the test fails or is interrupted after mounting $scratch_dev3 inside
the test filesystem and before unmounting at test_add_device(), we leave
without being unable to unmount the test filesystem since it has a mount
inside it. This results in the need to manually unmount $scratch_dev3,
otherwise a subsequent run of fstests fails since the unmount of the
test device fails with -EBUSY.

Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
function.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/254 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/254 b/tests/btrfs/254
index d9c9eea9..6523389b 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -21,6 +21,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	$UMOUNT_PROG $seq_mnt > /dev/null 2>&1
 	rm -rf $seq_mnt > /dev/null 2>&1
 	cleanup_dmdev
 }
-- 
2.45.2



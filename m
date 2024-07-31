Return-Path: <linux-btrfs+bounces-6916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE19433C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519241C243DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98D1BBBF4;
	Wed, 31 Jul 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhLVZAHh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA261773A;
	Wed, 31 Jul 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441575; cv=none; b=gtg2egESBV3/e5rVR9rVscO19HP5BHQX4+y2P9j4HQjJNTTVaejPECsZZ4IrSColAN7AMJ/j1wUhTvWV1g2DAGX72KxhHiOgs/GmqV+NCkgWXBrCyw9RaPhJOb2eAde6inIKxsfCyETTPHBDyKH7YGRCyMOtuydzeMv8geHpqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441575; c=relaxed/simple;
	bh=HVsuadtcVd++tZmLBUmBackdAcnMY8tEZb79PH4eetY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiVAbgOQHGn7or3i0W4dDkihdPT3bedeqBjsDKGU9xnbkPWFDUBX/D4kLgujKr6zi5vSmOSLnA4E+3zU55LRs+x+HcAc5uFudFChs7tlwbt4S4Vkw4tbDVweY3rtZnnjsv1SDUX1y8iw3vc41DuBG3DAp8nIPwztTi/UVv+k1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhLVZAHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88DBC116B1;
	Wed, 31 Jul 2024 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722441574;
	bh=HVsuadtcVd++tZmLBUmBackdAcnMY8tEZb79PH4eetY=;
	h=From:To:Cc:Subject:Date:From;
	b=dhLVZAHhj0ZsqSvpi1IHLkZlhN7Q+RIv7egFLAWw6CQcFFpb6r78hcuCzowqi3xSE
	 lUYxT8djSbDYu2H9yTem0iZOcuy4+mrcDLOVzA3kjvY0aTsIYF4Eh9TrybV64HMQOC
	 RCDyUNuh25DWVEsLX1HLdZXE9h8ev5r6hxO/urnEHn4jagTZEoEyG28mNTlBDyv0NL
	 xA2sdLdmilVs1NaWWszMx9xLzt0Jz9ykK/ljba/6BlcM9MnF7nkgEHDGucF7Jje0Vf
	 JVjDCt6S9uJyxq53XqCkNu8U9xZkeeqirCxJMkod7obGSMACn4EBZsO00ca1rW1ogn
	 B2e995cSTWk4A==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/019: redirect fsstress output to log file instead
Date: Wed, 31 Jul 2024 16:59:24 +0100
Message-ID: <0fdc35fdbc53f739fce1cb46ede8af97829aea11.1722441479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we are redirecting stdout and stderr of fsstress to /dev/null.
In case we have a test failure, it's useful to know the seed that
fsstress was using because it might be helpful to run it again with that
same seed in the hope of being able to reproduce the failure.

So redirect stdout/stderr to the log file $seqres.full instead, so
that we'll see a line like this after running the test:

    seed = 1722389488

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/019 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/019 b/tests/generic/019
index 26108be4..fe117ac8 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -90,7 +90,7 @@ _workout()
 	echo "Start fsstress.."
 	echo ""
 	echo "fsstress $args" >> $seqres.full
-	$FSSTRESS_PROG $args > /dev/null 2>&1 &
+	$FSSTRESS_PROG $args >> $seqres.full 2>&1 &
 	fs_pid=$!
 	echo "Start fio.."
 	cat $fio_config >>  $seqres.full
-- 
2.43.0



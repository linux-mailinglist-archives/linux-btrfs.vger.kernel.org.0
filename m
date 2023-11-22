Return-Path: <linux-btrfs+bounces-290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A57F4E03
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EDA1C20AF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030F57891;
	Wed, 22 Nov 2023 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HrDD4uJg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E31E191
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:16:04 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso6932998276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673363; x=1701278163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw7gP53YK9FpL5jKVynCaq+VNbFKDbPRWOvIWdMw/Nw=;
        b=HrDD4uJgLOr0+tzfqJIB8SbRmESbNQbx6pNuK97dXHLlZPyovhSruEJDctIJj2kPCY
         4rl9bdnpZkuGgleucqjjHMbFWIAx3QrG6a5jZ1AEK4x9rAG/yR634Uv7jJ1enfqOWSzL
         W9Dx2JP6X1mCKajfWdPQo0RT6K4Rqav0wqv6cs7BkLA44vHeIef351O5XPehieNvYuD8
         kT3MLYZGPBe3g2QnsdjGKoJo7YjDMycpdenPaNIoOU9On63pF91oOR5EBAXlooKx5Jld
         PPX79ZYAjav4ZKnXS7GrSZs83GFVBI93B+NZ1rR6vt+d1LSKqTfQWfuKzxvTwGcLf1YT
         SQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673363; x=1701278163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw7gP53YK9FpL5jKVynCaq+VNbFKDbPRWOvIWdMw/Nw=;
        b=CAG1YDxV5+YklnmCwiNehds7dZfjO6ZgHEgnE4Q1KMcYMWv8KGL3CsI4TozdC0effq
         YskimWrSAfwnhPID4POk5HA24aGvt8UQn1JSVqc7gFZqUJftskCyOBI28FuLb4vHSQUl
         sBUto81O4T0vCB2vZ/9/mBchrrdalfzYmWeJdPGAUVQR38w8Asi71sF/XTlSiCFeBpIz
         iqVMfc0IYZrbABZdu2XiMoVuWWa8kR0iLpI/lyHNOEYVbvLx76XwkfKyPHW2HEcgFM0f
         dSkinfBDNf2ytIq4/Gqhu+Ymp/yBmwdfviQJ9+PvKIqLwX4TvaG3AKJJYIxJPVnpr/6i
         FDnQ==
X-Gm-Message-State: AOJu0YwUQyfOzED3Tc/+rWkIZc62Xpk+dXEtaJO+J2p8msq7qX7pgSjG
	aNXizdzP4CSTK4r69D1qRfj5UGZ82Gx+kba6eom0gn1c
X-Google-Smtp-Source: AGHT+IGpFHTSAvjdtWKH7zJNkAbmTTemfNjjfpYwXSt74edbunWcpoyzkL1fLQdqBj2fNgZg/vLdYw==
X-Received: by 2002:a25:5f01:0:b0:da0:38c8:2e66 with SMTP id t1-20020a255f01000000b00da038c82e66mr2362781ybb.3.1700673363021;
        Wed, 22 Nov 2023 09:16:03 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h11-20020a056902008b00b00d8679407796sm1440222ybs.48.2023.11.22.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:16:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: don't test -o norecovery in btrfs/220
Date: Wed, 22 Nov 2023 12:15:58 -0500
Message-ID: <9cfb7fb05fb474cf5c39ff71340db9c1f6a652aa.1700673354.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a deprecated option and it's going away with the new mount api
patches, so remove this from the test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/220 | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index b092f40b..60b42b6a 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -212,20 +212,14 @@ test_non_revertible_options()
 	# nologreplay should be used only with readonly
 	test_should_fail "nologreplay"
 
-	# norecovery should be used only with readonly.
-	# This options is an alias to nologreplay
-	test_should_fail "norecovery"
-
 	if [ "$enable_rescue_nologreplay" = true ]; then
 		#rescue=nologreplay should be used only with readonly
 		test_should_fail "rescue=nologreplay"
 
 		test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
-		test_mount_opt "norecovery,ro" "ro,rescue=nologreplay"
 		test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
 	else
 		test_mount_opt "nologreplay,ro" "ro,nologreplay"
-		test_mount_opt "norecovery,ro" "ro,nologreplay"
 	fi
 
 	test_mount_opt "rescan_uuid_tree" "rescan_uuid_tree"
-- 
2.41.0



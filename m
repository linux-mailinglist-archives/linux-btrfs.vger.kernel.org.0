Return-Path: <linux-btrfs+bounces-11429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B21A33372
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5541619B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A025C6F0;
	Wed, 12 Feb 2025 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5P/9x07"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C8209F47;
	Wed, 12 Feb 2025 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403317; cv=none; b=kjp+sfHA/eBAgSDgtL2rrgBFoXprXdXX14Q0ZWhxYfCpQEXMciz1GrMYw9fGwCy6MAG8WdXecG/6T3orEW6GHbnH7XQGEcX6wKXnDkstbf9yEWI4OBwdJlNmUTEUVVHOhfPL50R+Rl5PUfuVRzWxHS8xIgdp9rdOo3HBu+4XMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403317; c=relaxed/simple;
	bh=IwF9p8RpzpaOLJFPhdpibT8vTNIOotaahsRIavjp5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2NuAyNfe8xlDztgE0KgOCd8rUFtRx2/Q+XWTbJb/hcE/UT6dkUuxFQn57gIjI6KqHwzRe6v9jvCqjmBJId12mMMrvY7pxWydtXfzPCNJfQiVzEQ0ZaGYnrkzug9l8+Qat2sM4wASx0/KInFc8EghRSicKBxrzHzBl5r8oNE8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5P/9x07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FE7C4CEDF;
	Wed, 12 Feb 2025 23:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403316;
	bh=IwF9p8RpzpaOLJFPhdpibT8vTNIOotaahsRIavjp5e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5P/9x07r5fMuLMCD4ZSXzpOuyEovBMpcAo6hrLZwVVg9nfOHYx+mJMkS58TRly/r
	 QO9S8ptr6l0uT76Cie5W0VIgAAP3ht+uvXOrthv58pXuQWBxZ6rsPasCWSRgOGhtBV
	 8FeScT98beCbKSi1fpLnOG/yajKHIE/gHbcBcO1N/eUgqUrp9NaZXxGqMrVCGDND/e
	 FNORpn5qwHEQNj3VCRqie28ExtTJydEMsAMfIERbeVxTsjQLwJwtlmbAfO7rV5AZf5
	 VDWF7Z32oEdyVHU4uuoBACDu4veu1cLmMERRdDb+ilvIQuNKj0n2H75+SBRTB8zvnG
	 NUgwwWuCQ26xw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/8] btrfs/290: skip test if we are running with nodatacow mount option
Date: Wed, 12 Feb 2025 23:35:00 +0000
Message-ID: <c237eac9f459e96ea4737fbf18bc96b733a0ab9f.1739403114.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739403114.git.fdmanana@suse.com>
References: <cover.1739403114.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We exercise corrupting an inline extent and inline extents can't be created
with nodatacow, we get instead a regular file extent item and if we attempt
to corrupt its disk_bytenr field with btrfs-corrupt-block we fail tree-checker
validation at mount time resulting in failure to mount and the following in
dmesg:

[514127.759739] BTRFS critical (device sdc): corrupt leaf: root=5 \
        block=30408704 slot=8 ino=257 file_offset=0, invalid disk_bytenr for \
        file extent, have 7416089308958521981, should be aligned to 4096
[514127.762715] BTRFS error (device sdc): read time tree block corruption \
        detected on logical 30408704 mirror 1

So add a _require_btrfs_no_nodatacow call to the test.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/290 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 1a5e267b..04563dfe 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -30,6 +30,18 @@ _require_xfs_io_command "pread"
 _require_xfs_io_command "pwrite"
 _require_btrfs_corrupt_block "value"
 _require_btrfs_corrupt_block "offset"
+# We exercise corrupting an inline extent and inline extents can't be created
+# with nodatacow, we get instead a regular file extent item and if we attempt
+# to corrupt its disk_bytenr field with btrfs-corrupt-block we fail tree-checker
+# validation at mount time resulting in failure to mount and the following in
+# dmesg:
+#
+# [514127.759739] BTRFS critical (device sdc): corrupt leaf: root=5 \
+#         block=30408704 slot=8 ino=257 file_offset=0, invalid disk_bytenr for \
+#         file extent, have 7416089308958521981, should be aligned to 4096
+# [514127.762715] BTRFS error (device sdc): read time tree block corruption \
+#         detected on logical 30408704 mirror 1
+_require_btrfs_no_nodatacow
 _disable_fsverity_signatures
 
 get_ino() {
-- 
2.45.2



Return-Path: <linux-btrfs+bounces-2307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F3D8508DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Feb 2024 12:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C941C221FD
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Feb 2024 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BD75A781;
	Sun, 11 Feb 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVNmiy9g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859359178;
	Sun, 11 Feb 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650915; cv=none; b=LM2iap3c/auWLE3ZY1vqD8fInElCxZvZThVV6nf2vWufmRo1nJwJNvfsB9jRM4a4n3Dy4uz5RSfehZeZhGID+xGjujDPrktIHAebWJohETDq1BIv6to0FwekSZwikrzNM57hv3VShb6U3feD6gBTBeLPUjuCfu1Tcdy6UQytNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650915; c=relaxed/simple;
	bh=HjFd7lp/Wz0hf76j/PPhbXj5G+2sKMlVNXJoiKDg4bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rL7pk+u0U2z5UIjgrEysbxA63kz0BEb+aQRWaUXsfg89XYkgV6UCOw9J6yxGOY3Xzz0wtJY/l1dxbWi5o81f3/OzUoK2Wk4r09obUaxo97ymKjywuxXt3Y9wN41vTK6jZMRX441yDMZsrcYP8GDvSth8XN6S6rui4NB4oirvVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVNmiy9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A543BC433C7;
	Sun, 11 Feb 2024 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707650914;
	bh=HjFd7lp/Wz0hf76j/PPhbXj5G+2sKMlVNXJoiKDg4bk=;
	h=From:To:Cc:Subject:Date:From;
	b=VVNmiy9grWrh3Zghjq5VGseh9AZAxFhShNAxddA6Ljq7aQ76yle1iMM1/tgdIgH4c
	 IKVR8g2pcge19Jal2LNd+WQa0oS3P71yvkhNnXuoPl30DjHRRO+R5BUA6TchnyUFCq
	 ickFciymG4iBb4XDNt9nAS7zu0OIYQfVp/wFhGmUOg7e60l1Y+syUgUXmWQVdjQkkG
	 uuZHt4WYLyV6YzP3T53xqQ0xR4zoSRNDD9/7RxjIk/9rAGxiIHo4+kQHR90PjXFsou
	 g6s+Lc11/M6Uptcxd+AKa4hWK0GPE7DbP/5qEnDrlVeHt28Rx03ZfJZh0cETewE7kt
	 w/VWrw8a5r7yw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/736: fix a buffer overflow in readdir-while-renames.c
Date: Sun, 11 Feb 2024 11:28:26 +0000
Message-Id: <eff8549698ca7a61089e17727b3e1d45a4839e6f.1707650891.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test is using a 32 characters buffer to print the full path for each
file name, which in some setups it's not enough because $TEST_DIR can
point to a path name longer than that, or even smaller but then the buffer
is still not large enough after appending a file name. When that's the
case it results in a core dump like this:

  generic/736       QA output created by 736
  *** buffer overflow detected ***: terminated
  /opt/xfstests/tests/generic/736: line 32:  9217 Aborted                 (core dumped) $here/src/readdir-while-renames $target_dir
  Silence is golden
  - output mismatch (see /opt/xfstests/results//generic/736.out.bad)
      --- tests/generic/736.out	2024-01-14 12:01:35.000000000 -0500
      +++ /opt/xfstests/results//generic/736.out.bad	2024-01-23 18:58:37.990000000 -0500
      @@ -1,2 +1,4 @@
       QA output created by 736
      +*** buffer overflow detected ***: terminated
      +/opt/xfstests/tests/generic/736: line 32:  9217 Aborted                 (core dumped) $here/src/readdir-while-renames $target_dir
       Silence is golden
      ...
      (Run diff -u /opt/xfstests/tests/generic/736.out /opt/xfstests/results//generic/736.out.bad  to see the entire diff)
  Ran: generic/736
  Failures: generic/736
  Failed 1 of 1 tests

We don't actually need to print the full path into the buffer, because we
have previously set the current directory (chdir) to the path pointed by
"dir_path". So fix this by printing only the relative path name which
uses at most 5 characters (NUM_FILES is 5000 plus the nul terminator).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 src/readdir-while-renames.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/readdir-while-renames.c b/src/readdir-while-renames.c
index afeefb04..b99c0490 100644
--- a/src/readdir-while-renames.c
+++ b/src/readdir-while-renames.c
@@ -55,10 +55,16 @@ int main(int argc, char *argv[])
 
 	/* Now create all files inside the directory. */
 	for (i = 1; i <= NUM_FILES; i++) {
-		char file_name[32];
+		/* 8 characters is enough for NUM_FILES name plus '\0'. */
+		char file_name[8];
 		FILE *f;
 
-		sprintf(file_name, "%s/%d", dir_path, i);
+		ret = snprintf(file_name, sizeof(file_name), "%d", i);
+		if (ret < 0 || ret >= sizeof(file_name)) {
+			fprintf(stderr, "Buffer to small for filename %i\n", i);
+			ret = EOVERFLOW;
+			goto out;
+		}
 		f = fopen(file_name, "w");
 		if (f == NULL) {
 			fprintf(stderr, "Failed to create file number %d: %d\n",
-- 
2.40.1



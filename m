Return-Path: <linux-btrfs+bounces-9676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ABB9CD549
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 03:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772DF28356A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFC13D26B;
	Fri, 15 Nov 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="N+CAoUHs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3D10F2
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731636980; cv=none; b=aem9Gi1sC4Wla02SnqSuful6UgDmfxvFTkqou/f/zfi6BV+LjIJlUl03RT9kC0qaJrm/enhB2k5QeJ7aF1UUlPvuw8/6EV4PFO4MtRFr4rkR4C3wdV/YLLrs9aWFa9V9fjccDc738UDH9fe+Lb19QdH+HGpTsXK56dg+MZBlegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731636980; c=relaxed/simple;
	bh=u6qYQChjnQo8QPwBmjbbOxpjivOVwnUffDcmhPLa1x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgDulMIbJqL/jBBSUw4eI3oMv44DUQY/Yiy3vpBjVwzQ7suaxXvGoa+ECt3aMx8m7hOhNd34tuI0ts8KykUMP92G2zG8n9h9e/SbMOUipVbznCCpM/BbFK/SOpTQn+pKAE3kHYIkBvSTNQOPEx5lq50tbaxiEUjYUR07Rzu0Lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=N+CAoUHs; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 29BB614C1E1;
	Fri, 15 Nov 2024 03:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731636969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sx48EYv9NA9H8dCcyhct5zxdcy6M75AqOCNrDpv3RKA=;
	b=N+CAoUHsDFlD0Nomah5s76r5cofgd1/r17JbfDElP6Jcm3yxiGF0xbrASiJPKabwpMhzFZ
	nC8dfeajIERdBq9qM/kDMOqo4+hFGGDbOzfNwjITWbaxLQ8Ci0VQqVUvusphlmIkT5DeQd
	d+5R8gYINjjTGSM8RKtgefaILx8r92sL5VeIIibPIz0HSIuIBQl9JcYrjTgD9n9f7C3mrU
	pe9JfspNolSwEUpXzwP/e+Z8OtbprKUpFpn8WxtzjlbmXxcyOqiaqtln64dHh+iDe/SiAK
	QP9CYxfkhkc3sLZ3FwRRnyeea7EBQN9VPov6j5nhqHXLKaRwGvfzRa2oCI71Ow==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id a9114616;
	Fri, 15 Nov 2024 02:16:06 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Qu Wenruo <wqu@suse.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	linux-btrfs@vger.kernel.org,
	u-boot@lists.denx.de
Subject: [PATCH u-boot v2] fs: btrfs: hide duplicate 'Cannot lookup file' error on 'load'
Date: Fri, 15 Nov 2024 11:15:47 +0900
Message-ID: <20241115021549.671932-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

Running commands such as 'load mmc 2:1 $addr $path' when path does not
exists will print an error twice if the file does not exist, e.g.:
```
Cannot lookup file boot/boot.scr
Failed to load 'boot/boot.scr'
```
(where the first line is printed by btrfs and the second by common fs
code)

Historically other filesystems such as ext4 or fat have not been
printing a message here, so do the same here to avoid duplicate.

The other error messages in this function are also somewhat redundant,
but bring useful diagnostics if they happen somewhere, so have been left
as printf.

Note that if a user wants no message to be printed for optional file
loads, they have to check for file existence first with other commands
such as 'size'.

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
v1: https://lkml.kernel.org/r/20241106012918.1395878-1-dominique.martinet@atmark-techno.com
v1->v2: reword commit message to account for the "new" fs/fs error
messages existing

 fs/btrfs/btrfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 350cff0cbca0..f3087f690fa4 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -193,7 +193,7 @@ int btrfs_size(const char *file, loff_t *size)
 	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
 				file, &root, &ino, &type, 40);
 	if (ret < 0) {
-		printf("Cannot lookup file %s\n", file);
+		debug("Cannot lookup file %s\n", file);
 		return ret;
 	}
 	if (type != BTRFS_FT_REG_FILE) {
-- 
2.39.5



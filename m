Return-Path: <linux-btrfs+bounces-5798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903690DE9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 23:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E022857A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DF179650;
	Tue, 18 Jun 2024 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpgWvRmd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283A17836E
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746908; cv=none; b=DfXzxfZXIQ+rEp0dgjw9wImi7ZUwRmx90idVg/xMhyepmaAunmXO6sOQU9cH6B99thgDD6rN9sfZ4vBgS0tNOdAksBZbzUdVyTbHxO9d9HBuGV0yrVgKJo57w7933/NJQR3wAoeFAyRxD3dmgTv2T19TOhw5MaXqm2t0026s+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746908; c=relaxed/simple;
	bh=5ayJI+dSS2WAbeQWuQrZEdWx/gtWtqyQfiPaTxS14G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LulDTHq4RDi6R+VSOA1G4UJy4IFgrtBNqPxlsyYgg9UGB6CD2g6OvpGTlmnhMCPcD/idYZg1gqnImH4gR1N9GcqOGU7LRbb3eQM14QGOoUAxJHpMvuyAEw+PuEssImlbwapvSMIlFQ3YYzSq+xFcuW1940WgUalnXHwuM6EeMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpgWvRmd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso5337344e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718746903; x=1719351703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7k9BtTdjjzYpnnwqSx7jrcx8gt24jwN3T2Nm2RyPXk=;
        b=DpgWvRmdrkwP4sSXciBnJsUTreCdBtKlN2AtYxFwTyDW6vWbmQfzEV13QgGq1A7xba
         QAhyBu4Xk1HEF+RlmgiJBBJUhugnhCmtvxv9geLVEW8ihZM9+jAnGmcTqxthq7rS4AL2
         es+D/40w7gOG3WuIaEC3SzQICERHVsU/EE7KGoanbenelNE8dbfqIIyJNH3iqYsFW/zf
         HNX5hyLMP3lSJ28TrnLVLNYjQY/nBXgutnRIuiGSnClmGOhQ79lqrgdUkcIF/7US0zCc
         NTBUPkD5XcmKLLugj/XFj5sQsTiXQbnfJhbgL7hWVOkHKuJvAkSjQZzliuPruCt7Dbw0
         d0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718746903; x=1719351703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7k9BtTdjjzYpnnwqSx7jrcx8gt24jwN3T2Nm2RyPXk=;
        b=vrJargip3eMvuz8DRpCDs8UPh3awQVNIOseO2EmK0yigl3HVkgNqOb4AboSqO8PnY6
         T4363R5EWfzRyuYsdFWaFRh8nNc8X7DyViZp+/jgAXysHpd6v6F+HActWgaalh2dotjS
         isNV0U1TUZF0rgBZnINF3b0uGaEtIgeVuHjazB9Loy6FQ+KwyeLMrYjhSeTSoeK9EVNx
         7xa1t7gIoUyAoo5lFV0PpNb6mOoIbrZAulO2vpcK0D3K/kEKuoTPFi+49c3CY0KE2nVl
         5U7oGm3trLYX+EYR4vhtl9m1WKXKXbO+Yq9V2tYa7UL5vyVkYdWcR5p7Nfxhwl3bBLhQ
         LY2A==
X-Forwarded-Encrypted: i=1; AJvYcCUfAxtroJ5Z+2vrGQSUHZ0FJWs8dCyexzf2FKpcKsojGdU5McMts734gzFEGhlWJZIuv6pDx9loaGP8Jpj6bCQNLa8U6ZFIZTzhTs8=
X-Gm-Message-State: AOJu0Yz/e4BhHiiAirKfeOKZMHTRHtV2by8+tKP52OqASpfD4j8lfftQ
	sGtFGqBASDCq0GImh5ANAZjOFMl1yt6U5kWtgRPxa626224mwi+DdY+kRe4jSAM=
X-Google-Smtp-Source: AGHT+IHZIL1z+wb+CAL98GpzdKi7cSRa4vsKIH9HNf7wWoP+CFLLlitthxQAj+Z2W2WWXfiIVWb82w==
X-Received: by 2002:a19:5e19:0:b0:52c:814b:3ac2 with SMTP id 2adb3069b0e04-52ccaaa8dcbmr356921e87.68.1718746902954;
        Tue, 18 Jun 2024 14:41:42 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287263bsm1603006e87.165.2024.06.18.14.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:41:41 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Tom Rini <trini@konsulko.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fs: btrfs: fix out of bounds write
Date: Wed, 19 Jun 2024 00:41:38 +0300
Message-Id: <20240618214138.3212175-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix btrfs_read/read_and_truncate_page write out of bounds of destination
buffer. Old behavior break bootstd malloc'd buffers of exact file size.
Previously this OOB write have not been noticed because distroboot usually
read files into huge static memory areas.

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
Fixes: e342718 ("fs: btrfs: Implement btrfs_file_read()")
---

Changes in v2:
- fix error path handling
- add Fixes tag
- use min3

 fs/btrfs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4691612eda..3998ffc2c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -640,7 +640,11 @@ static int read_and_truncate_page(struct btrfs_path *path,
 	extent_type = btrfs_file_extent_type(leaf, fi);
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		ret = btrfs_read_extent_inline(path, fi, buf);
-		memcpy(dest, buf + page_off, min(page_len, ret));
+		if (ret < 0) {
+			free(buf);
+			return ret;
+		}
+		memcpy(dest, buf + page_off, min3(page_len, ret, len));
 		free(buf);
 		return len;
 	}
@@ -652,7 +656,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
 		free(buf);
 		return ret;
 	}
-	memcpy(dest, buf + page_off, page_len);
+	memcpy(dest, buf + page_off, min(page_len, len));
 	free(buf);
 	return len;
 }
-- 
2.34.1



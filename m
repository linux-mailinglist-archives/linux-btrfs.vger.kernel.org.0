Return-Path: <linux-btrfs+bounces-5766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE090BB62
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 21:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1692856B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51818757F;
	Mon, 17 Jun 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ/ig/SH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF12D53E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653795; cv=none; b=b7sfJylYbBhc54FGOIprs7s702nMj3GIR//i8DfkcYbhs+X+4D6JJy2XP/aUBjLY0xFOZISEAq/E8ryi3lBNq/XDUysKJphBlO4WWxhcxJj4qkIPPjviR3+CTfIXoqLWn1oXrU1xWhFvAQZIxUkvTAuwmDbF3PiXUYr1Hc7GTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653795; c=relaxed/simple;
	bh=sTVo0N0gU7vuXY9PPVNGpvHRsI6aLBdFJYjex4CYkao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOK00BiPEhkqM2vblY0bNHIAYGN2tm9Pu+aRr+JKqTGi2xT+sG7iqmBrACRMlQDo8wnwUVrD8aBiu9WxESHqpTCGYrPqmZ/UHZJW0HoyTP21rjbsYT1VHkY4H2TlhN7bmnveJb6Y933K9sUuyYEcb7LM+KGKkOxsrhTOv8FpZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ/ig/SH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso5018231e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718653792; x=1719258592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXXi/Cgj7O5qRRCu4B0r1vEcE07p4zz2tufdZsci5l0=;
        b=JJ/ig/SHqg6429DiGQWnHW3tpgcjmQLl94LxBYmPHIhdIoes58DQnn5rBTlIHJa3q3
         D3eyNOPqfSjNDXWiXrgfSMbgliz4c191Bjdwwn6kHgNnRnwo8bAI31vEB8mTVOcTHPmw
         zGhLNPLedvycN8o3+mp9DzeXOqo0pgKI6HPPlYmB/RE7HsnFTmhi8SkLiPMhpXHkO0IR
         ocN+230LyEDfD4OMZSMVoNr34LNJ34ugnRLQDiJi5T1lXRJBt6hrh0+CxVelny36M9Ih
         jSWP2QK5mLyoPrYQ3BsKJ1p+LWIZWenq+1+KyZc23u9LBTmJxCppkDiypfyJ202rMSVj
         p+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653792; x=1719258592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXXi/Cgj7O5qRRCu4B0r1vEcE07p4zz2tufdZsci5l0=;
        b=KRll5L04f4YvuzhNvOJ5GM/7NNQ1+aqq04CHW+9Zsbn7j2WswnM2Lbufv+RytgEejG
         IQZQuAfmaZFaRlWmf2tHkKxFOLnT+5PcW+iRzSRsHmO8SmbzU1J7XX5udDWkVqnZy9ra
         vEre53fYz5P4Dzupkvv2NCyQCML29V2FUdjzqosTrkGGQnPD7zWnLKiMTaZrhMwSb4VO
         Rs4z3jAIe5tfxXlOpAhnEHSZ5e+wZoikNgiex86zOyxf4AFfEMI5EMjJfejceFcW9Ly1
         JUWPpGX6zRZYIfmOdZ0fSzu5l/ivURUqISsMcFUADBdJPlDpvrfA/SrGddWntXsmRqUA
         nTog==
X-Forwarded-Encrypted: i=1; AJvYcCX+OFXvHhyiMZvrXhH0t5qd5J112X4ijl0nFVQAi+VN3nxH7lOlsgh9PmDyXCV3hpSnq55+6ueJ+JO5oIdKOITY7Yn+wco6YrbRfZM=
X-Gm-Message-State: AOJu0YyGbbNHSilaNfRIzBzJZ0onJh4fbWjZbxw7G4LMzr6cb9VIjC/o
	vD9DvfFHgDIT/2DL+yP4QySK2iTotNx+BvMYEYpw79WmHbuWFqbG
X-Google-Smtp-Source: AGHT+IH0ikRVJ88LUs9iCWD0vp5IzrdVUxxUJd4NkNtMCCqaEBI6w65n/LAuQNqUdUtjFUaUGX9nyg==
X-Received: by 2002:ac2:4cb1:0:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-52ca6e55ab1mr5761206e87.11.1718653791930;
        Mon, 17 Jun 2024 12:49:51 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825670sm1334557e87.43.2024.06.17.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:49:51 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Tom Rini <trini@konsulko.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH] fs: btrfs: fix out of bounds write
Date: Mon, 17 Jun 2024 22:49:47 +0300
Message-Id: <20240617194947.1928008-1-alexthreed@gmail.com>
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
---

 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4691612eda..b51f578b49 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -640,7 +640,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
 	extent_type = btrfs_file_extent_type(leaf, fi);
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		ret = btrfs_read_extent_inline(path, fi, buf);
-		memcpy(dest, buf + page_off, min(page_len, ret));
+		memcpy(dest, buf + page_off, min(min(page_len, ret), len));
 		free(buf);
 		return len;
 	}
@@ -652,7 +652,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
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



Return-Path: <linux-btrfs+bounces-17413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F3BB7048
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5EA34EA674
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF91A256E;
	Fri,  3 Oct 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKbMNVBc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892A34BA39
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498267; cv=none; b=IxBL/PW0T4mhBkUpfqkiTRf0deKk3v7MeLDS0Gc3niwmSGkpHutq5pNyyHG8UbsFmnS+gy2oPjbrNx9I+3WyUFahrBcwW0ZbuxI3FdUoB73w9usnVMeaRym2LLge+JEi3aad0Ou8JuQrsIEoCGGNdUHB9kM4L9sX6DcFcGOpU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498267; c=relaxed/simple;
	bh=M/PYD8FqgY/wvD6rOzHZxSYgVw00CojRui7/mt/ISlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASHq7HFLUAwns0u/qHY/vfixL+Pm5GK2X5cNrWw+FvhlYsTcH6MBkwki9cZX9+8zESXwyhfXDem0s/GX2z3SscsIuEU/weL0Yqp92FisVzkHtuV3fTsx5TnOVBzliNGg0YKzHFvuM+jQbo0JDDYwoAEKhL3OvUYI66U8jM6ZVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKbMNVBc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-789fb76b466so2142286b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759498264; x=1760103064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGZud21unrH50dFl0sIlMV///6phEw6y8UIVkHJrd1M=;
        b=LKbMNVBc6GR5/eTcNRHNJ9Byv/TAJn8R5kVaofc7GN4DU0C3VE0aVbbCEjXIuL/y4V
         stww0Ee0oaT7J4UK9JMA4k02By8rfA5gD1K0hcZHRtYqsufgMLQ/x3l/CLTWQ7VcVZeG
         3zp0EI6IJ1TQGKiwRx31zc6pak/ZyvYKk3bVExB6Yjz/ngtExwpsETZSX+g/Pthv936w
         qtBD7SVFgqZKoZJ+cydW0cBv+3g7oT0236/oIIXyrCbBGHGUvcXCGF4ziIG5lJG5INd/
         LrbEVOV0c+GKUP2av07zy63GyuOifdeZeIRaxEP0R5ThHWdmbuYZQxlHxBVGJiptPVB+
         SG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498264; x=1760103064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGZud21unrH50dFl0sIlMV///6phEw6y8UIVkHJrd1M=;
        b=DBT/Rq2PeS6OYKHiEl/wc7sAVE8tmFUci+nH15juz6rJ5+F5X7yN3OYRxnTuP0YkGM
         /beRvjijjbqAosuKvRa6cG+4+oZjuGjWiXfNpPj7C6jhJyto5iydlIOHJFZtjupUmKcD
         /g1XNQ9f9cr+sjv2BG2Pviy6WAAcMQzcAy+ErVZiLnLutgUTTndmyZChWM759elIQKW7
         9nQ2aRQagJV1FCZ94CUUEC1Osvuo04DdskQQDzH6nxTnEP9LF1bIAtAwsM27A4sZxcmK
         yCXFyEgwrMw3/8yonI7HezAzqGXJlcwvkn1OonTsu+V1BL0zplugeeTPyK1xJeV5JhXt
         97+Q==
X-Gm-Message-State: AOJu0YzNQ2+APr9zT/hza/h0J5tpcsqGpuNjp8AY6TjidxpTxEu12kkm
	b8Qi67sIYECokkpKM4BAEnei8iKaI3h3R/cYDudIcNL8K/uvFMfkK7EW
X-Gm-Gg: ASbGncvsjSscOhcoaOZhwFnhScXejjBusoSZG3wgsyCVmYvaZUWIuiqidsinkUGbvzr
	7vNcDS7VyAz517cAWadG3LiGu9Umpb0lUPT1M5bpIlEIT+CmqHhGGoWEruKT0FgM+AU1I2Nb7Vv
	tLcm7SVXEErpuy20t1rN8/P2SKPpHArhVPZ794qIDInU8waW5exJ9npcjQWzGbdPgbFWVZPZO1T
	xxCClZYJ+h3w2QuvBCePjKdz/TFHibCU393ztp5XJfM1wv8rbN/uSxOvxPkvgfZ3NmJlh5V/Fyn
	EThPigGk7Ur//sSt/64vXZZa7zllgeJ4FhuvFwTveEo8wJt0cgRYbJhNDt4rcL2aPGPa8uFoLdG
	e77HoPn9GP7yLmDRNjDr/KQGszPUlM2ga2zqCvHlkFniUy3fi0cpd21j63LXSn2uAnuaUNV5UYO
	8=
X-Google-Smtp-Source: AGHT+IHUNFg2+6wlpsRB1KLXor895ZHBGEuyK2qlm9lTRa0xoty9J21fzUwTVsMeDCocct+adtHtjw==
X-Received: by 2002:a05:6a20:a11b:b0:2ea:12b9:2dfa with SMTP id adf61e73a8af0-32b620d927amr4632018637.40.1759498264283;
        Fri, 03 Oct 2025 06:31:04 -0700 (PDT)
Received: from fedora ([45.116.149.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f72c54sm4627884a12.45.2025.10.03.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:31:03 -0700 (PDT)
From: rtapadia730@gmail.com
To: dsterba@suse.com,
	clm@fb.com,
	fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	Rajeev Tapadia <rtapadia730@gmail.com>
Subject: [PATCH v2] btrfs: fix comment in alloc_bitmap() and drop stale TODO
Date: Fri,  3 Oct 2025 19:00:02 +0530
Message-ID: <20251003133001.45052-2-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeev Tapadia <rtapadia730@gmail.com>

All callers of alloc_bitmap() hold a transaction handle, so GFP_NOFS is
needed to avoid deadlocks on recursion. Update the comment and drop the
stale TODO.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---
Change log:
As per previous review the change is not required. So just removing the
stale TODO.

 fs/btrfs/free-space-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index dad0b492a663..bb8ca7b679be 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -165,11 +165,9 @@ static unsigned long *alloc_bitmap(u32 bitmap_size)
 
 	/*
 	 * GFP_NOFS doesn't work with kvmalloc(), but we really can't recurse
-	 * into the filesystem as the free space bitmap can be modified in the
-	 * critical section of a transaction commit.
-	 *
-	 * TODO: push the memalloc_nofs_{save,restore}() to the caller where we
-	 * know that recursion is unsafe.
+	 * into the filesystem here. All callers hold a transaction handle
+	 * open, so if a GFP_KERNEL allocation recurses into the filesystem
+	 * and triggers a transaction commit, we would deadlock.
 	 */
 	nofs_flag = memalloc_nofs_save();
 	ret = kvzalloc(bitmap_rounded_size, GFP_KERNEL);
-- 
2.51.0



Return-Path: <linux-btrfs+bounces-8635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9A7993FD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 09:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAEA286E21
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD561E1A19;
	Tue,  8 Oct 2024 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBkDpF66"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5D61FD8;
	Tue,  8 Oct 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370142; cv=none; b=VaY4nuutIscqpJQPh2fF5QWYNjYGnUTUgm7rB1+qMd1TavHuwIzaTVOfsN9zoZbpsFjK/tSepOPbIDU4aW8WmmnFQ75cMNx/PHKbNZLmS4v1ySZLzEjHigGSROCh9UEE/4+iwxq2t0SsvsjNvszLtFzNxgnuBlmrx7f1/OhAUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370142; c=relaxed/simple;
	bh=KX1KemK6vAcVYH5Eaw2EjT3hX3hBhAeZ+/YotAsZvjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfR5jSVv4MwzxoBWUqFtqdIA+FagyB9bb+mtAGBKN3mX2+7hjw6erSooQCq2KFCDH5AXLEcZ2FrwawVCLypVWCHqgWZrebwdl/t6sOyV3sqXIpjWIeKlh0qgR2Xuhb2oihMQTnlBsvIDp6J1GzB/Cyoa0rm7baSjYL7Z62DOEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBkDpF66; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e06acff261so3605592a91.2;
        Mon, 07 Oct 2024 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728370140; x=1728974940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfl4qQhX9QMVV3uwb2SRS/81iBbiwsb1hHtN57rwHmc=;
        b=iBkDpF66E9JncXaBGHYCEvGgqpnQpFeSBG73Ks9EQg+W79eJVXWCM5ZfGmy2PJOxwr
         FuzSyNIQsXqCJ5qDDqpLeCWbvAnNgMLLr2Ai4mtAV5Wp7XgFUUY3DLHJiNwW7ht+N7QM
         rjOj0ZTGTrk3vB3Zvp9HvWpmqhdv89RW9zTpvqpzSKBRUqc86NJ2EHwV/NMoSD6QAiC5
         uwXsVyLvfc3Uf5CPfWZ6GCFUxkA5oni1FyN1VEz5ODOQPaPcsVaaeBN3YKIbCrhrYtvo
         Hace3W4NN5OxNcFUL6evk5Mn2L/r70sxIl1cl/mx4qjiQxoTt6K6Cu3Y0LBuUm1NC1of
         N1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370140; x=1728974940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfl4qQhX9QMVV3uwb2SRS/81iBbiwsb1hHtN57rwHmc=;
        b=Oq8I+IRofxweisG5hyCIaTHpcRTi9eCJyQewQH/p8wGlhsYlo+5vo9o1P0/JZa45Sf
         KjUxkFjSF8aa5JUuxTK0XafDMjhYgxSzJf/x3E65PvrytXvaNC+QwSLG+Yb+nF+m8M9h
         GNNEJR9UOuTAfIShqZ7ISmd48bTn2XFAfjEaQShrwPXqZIQ+Lq60AsliK0bKHCOPo9iZ
         pfnppPf+k5EqqLW8vBtRy6SsM/jYvdioDVHfTReV64yfk+e55L4TWur+woOq5Mesf2mb
         aYIwHw0Fgsza4j+xMgInL2/DP3rM0FXBlMCo8BHYR2hNk/j/eiuRHWwd0cLrex/3O9Ck
         mnHA==
X-Forwarded-Encrypted: i=1; AJvYcCUULmEcILzjITtXTHjNL4WDeDsSS0vm5GR8eb7Fj4gTyJFfWPHiw4ciuJKYiGud8ohu2L1xZkxAMAN2xPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ab+EP87BpZnRqbyvR+8hrdTvlr9cId7WTOEA2+6MsrZIQ6c+
	W3D9T4/zAwthrTpijDocew0MDHSp9DonaiW9gwxdjKPdiUVBAl9i8PBTLYT+SW0ciQ==
X-Google-Smtp-Source: AGHT+IFht93QqQHn/HTgDwxhRTKsY8u7HCeAAWbib2WR5bL5pmMsCYPG9kXr1Jf2CfYAcHsftLqpEw==
X-Received: by 2002:a17:90b:4b87:b0:2c9:6a38:54e4 with SMTP id 98e67ed59e1d1-2e1e63edf3bmr14558507a91.41.1728370139804;
        Mon, 07 Oct 2024 23:48:59 -0700 (PDT)
Received: from VM-213-92-pri.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c905esm8480588a91.17.2024.10.07.23.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:48:59 -0700 (PDT)
From: iamhswang@gmail.com
X-Google-Original-From: haisuwang@tencent.com
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	boris@bur.io,
	linux-kernel@vger.kernel.org,
	iamhswang@gmail.com,
	Haisu Wang <haisuwang@tencent.com>
Subject: [PATCH] btrfs: fix the length of reserved qgroup to free
Date: Tue,  8 Oct 2024 14:48:46 +0800
Message-ID: <20241008064849.1814829-1-haisuwang@tencent.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haisu Wang <haisuwang@tencent.com>

The dealloc flag may be cleared and the extent won't reach the disk
in cow_file_range when errors path. The reserved qgroup space is
freed in commit 30479f31d44d ("btrfs: fix qgroup reserve leaks in
cow_file_range"). However, the length of untouched region to free
need to be adjusted with the region size.

Fixes: 30479f31d44d ("btrfs: fix qgroup reserve leaks in cow_file_range")
Signed-off-by: Haisu Wang <haisuwang@tencent.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b0ad46b734c3..5eefa2318fa8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1592,7 +1592,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_folio,
 					     &cached, clear_bits, page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
+		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
 	}
 	return ret;
 }
-- 
2.39.3



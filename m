Return-Path: <linux-btrfs+bounces-8940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BE99F80B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 22:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66DB1C21792
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8831F818A;
	Tue, 15 Oct 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLsakzf9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4431EC006
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023768; cv=none; b=PtEg34a8gyL0nVNZn2cPp51DYDOzA2Qx7G9qBPAVHcOCRIdtN6pSRpKgFeiVkWQ2EmXQKJrRn0Fq/1LUlQyPKrZAF8KkcQ1gmdESBDR5dhwYj7jydYRMkPUWSEm69hmmPoal6LEzlR61VJQGfLUchZd8WoL5Ztr9AnlVsjjtByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023768; c=relaxed/simple;
	bh=21YGFtYrTpnZNmqO+X8RFoSALfAMcvTfi4fLoLGKewg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYMYYR/ClzxeMVvdy5vt6VLW+gihvUhwjV9hgMOigZru7fQn2tlusDjEZdP2HhXrkkELQ1GDsuGe1Y31BhDJ/utrN+t1IgG2X1gLtsFIIXtIxiG21Vi7Y35Xuc6pW7XhRcZ4ClScoo2Q1ZGqzrwCNozE2Tnz63+xjWEmZKwsyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLsakzf9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4c482844so3367896f8f.0;
        Tue, 15 Oct 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729023765; x=1729628565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sBuh9qedRngbKbx/KtPG/i2ytx6KF8a3n9MhiI1P/s=;
        b=VLsakzf9NNfKD6Ggkb2MO09lM6KnBX1QMRwkjXCQx3oJk9OEhLtOmErXbID9MXech9
         flte3nIkt33/kQlhWrkAefn/HZOwkRWlI1Kpcoudp4QQxrOxhWQphWckva7E3aTWzGh/
         eMx/bGSDAiDBTyotpSn/WVu4R1B/eg8yDw1IwiG0A/+RkcOJaUp6oICbVmAeGf90p9nY
         O+Otth0g2z4TskJ/QM8oKCrwX3lVReKpEbCxRAUsCLLXOYKR2a0mMLvENfMF8izOpKJK
         W5K+R+DgaQXCgOX4DNF4niqn3e1RXrHZPTCjuosEh5dSTFj9DtfluEkyz2LbBUFEEixt
         rTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729023765; x=1729628565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sBuh9qedRngbKbx/KtPG/i2ytx6KF8a3n9MhiI1P/s=;
        b=NktjVlI1pLkzfGLZPKayYmWgBYxatyxg+5fAcHtCCJK9b8HxAorliwz8rOSapfH7lS
         8PpZbjNd5k0XTinqgUf4sOH5l4BkAkhxzBOLymrrU9GLBiktzYh+vzkDplT1Q8Wed5+2
         Q/n4VjtzkAKaboTCmkPkCVGrMd42aW2xeFtHxFflLZOtUNAnYTCw7cbZTpBeEMZQ43H5
         JLv1g5Z3ssWCDlqiE7Jj6FlobkIJ20L41g/4NlX35+fPmEoqBQuYjOmWyjiCgE12MueC
         VUV/RArI1k7WfOHlf2A+2gB2TmvwaxQQP4IcRNhH/kutEaWsfj4JUmz1zNuyaZAkHyWt
         HhNw==
X-Forwarded-Encrypted: i=1; AJvYcCWoAolyM0O5i4WhWCRc5i28Z95yztFKCtFVYanyIXMRRUNOMsdtWyPwtu1eURxhQuD+4l8sbePFE7elZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkusB4jrie/U6C6bmtdUW8PU1Tonul8m0RDrZdv24nGyBn7e2c
	5NyUSRsPa3GC6edPOQpU/bwUK4ogxVOw1225RHFCAvy/CwxVLB/I
X-Google-Smtp-Source: AGHT+IGdO6MCGB3aw0gRJGB00Cq4maRvH9Cl/2rak7OX+j1O9C6BxXhE8dKlRA4SuoaGucF/uQoCRQ==
X-Received: by 2002:a05:6000:11c3:b0:37c:d2ac:dd7d with SMTP id ffacd0b85a97d-37d86c03103mr1114910f8f.30.1729023765228;
        Tue, 15 Oct 2024 13:22:45 -0700 (PDT)
Received: from 192.168.1.5 ([79.113.196.154])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4313f6b1e77sm28088695e9.31.2024.10.15.13.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:22:44 -0700 (PDT)
From: Racz Zoltan <racz.zoli@gmail.com>
To: clm@fb.com
Cc: linux-btrfs@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH] fs/btrfs/inode.c: Fixed an identation error
Date: Tue, 15 Oct 2024 23:22:15 +0300
Message-ID: <20241015202215.10086-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed identation error

Signed-off-by: Racz Zoltan <racz.zoli@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5618ca02934a..9c737e63c339 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4226,7 +4226,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
- 	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
+	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode(trans, dir);
 out:
 	return ret;
-- 
2.47.0



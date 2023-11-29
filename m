Return-Path: <linux-btrfs+bounces-432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBC77FD625
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 13:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16DB1C2120F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A81D552;
	Wed, 29 Nov 2023 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR8pczz+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693D12B72
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 12:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8D1C433C8;
	Wed, 29 Nov 2023 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701259241;
	bh=n2nAGxbaM4bdUExVSTPbG6T9Ltt30lIhFwcPWN7vNO8=;
	h=From:To:Cc:Subject:Date:From;
	b=lR8pczz+YIOlEBwSdhbDA/LVQ12dQ2u9nO+Hghy/NF/HjnaDVkOfmyvbPCtzx7TKg
	 tQWbDZW02R9WyulystAPJr+vQwm9E98sAFJv5kRXaIkXd+ZnPNAWfTEfzxWLqheHuM
	 4XpHvHWTUBF6lNDHTpJYZlWvu2RQ8g81HvWYN5OM5uHsSub98AtYfGNS+Xi/NMqrw8
	 uQL/2hZv4HFjz2qVRw77alR1CqHdnpi5FHjmogBrOj/ZkN8s1SdDRdkiqmdkbp9lAQ
	 RCXD4F6J6Oa9zxjbVD6MCca/jPDdpkpwg1QIRtnAe+2uIjEcjJXTAe1YETnOo72cB4
	 ySy5sSvZnSVWA==
From: Arnd Bergmann <arnd@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix btrfs_parse_param() build failure
Date: Wed, 29 Nov 2023 13:00:29 +0100
Message-Id: <20231129120036.3908495-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With CONFIG_BTRFS_FS_POSIX_ACL disabled, the newly added function fails
to build because of an apparent broken rebase:

fs/btrfs/super.c: In function 'btrfs_parse_param':
fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this function); did you mean 'net'?
  416 |                         ret = -EINVAL;
      |                         ^~~

Just return the error directly here instead of the incorrect unwinding.

Fixes: a7293bf27082 ("btrfs: add parse_param callback for the new mount api")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 59fe4ffce6e7..022179a05d76 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -413,8 +413,7 @@ static int btrfs_parse_param(struct fs_context *fc,
 			fc->sb_flags |= SB_POSIXACL;
 #else
 			btrfs_err(NULL, "support for ACL not compiled in!");
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 #endif
 		}
 		/*
-- 
2.39.2



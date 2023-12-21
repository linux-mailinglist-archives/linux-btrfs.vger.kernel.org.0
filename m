Return-Path: <linux-btrfs+bounces-1084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C129C81B0AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7701A1F23A3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69292033E;
	Thu, 21 Dec 2023 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="c+CEjC1k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EC1A701
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:47a7:0:640:b27a:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTP id 2D9BE60A8E;
	Thu, 21 Dec 2023 11:49:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id knJNPn7Oc0U0-Nztkbxd2;
	Thu, 21 Dec 2023 11:49:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1703148586; bh=2pjNm+W9HnO5Aw3VHazNUCu4K8W+VOu14wvftoZDFO8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=c+CEjC1kdALKaEj+95Zw6tgKTDgRf2iB+b+YGonxtHaowuw5+0SO5rnnaBCTUitin
	 l/7U+hTH2OQUcFp5hUnRLordVIPyJnOvYlBuLay0YCT0IM1ZR4SZYelQNRN31YpLsP
	 MvjiTyysluULRNKTlYESxCVRzdJTmIESmzPywbyg=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: David Sterba <dsterba@suse.com>
Cc: Denis Efremov <efremov@linux.com>,
	linux-btrfs@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] btrfs: fix kvcalloc() arguments order
Date: Thu, 21 Dec 2023 11:47:45 +0300
Message-ID: <20231221084748.10094-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.0 20231220 (experimental)
and W=1, I've noticed the following warning:

fs/btrfs/send.c: In function 'btrfs_ioctl_send':
fs/btrfs/send.c:8208:44: warning: 'kvcalloc' sizes specified with 'sizeof'
in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
 8208 |         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
      |                                            ^

Since 'n' and 'size' arguments of 'kvcalloc()' are multiplied to
calculate the final size, their actual order doesn't affect the
result and so this is not a bug. But it's still worth to fix it.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/btrfs/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4e36550618e5..2d7519a6ce72 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8205,8 +8205,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 		goto out;
 	}
 
-	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
-				     arg->clone_sources_count + 1,
+	sctx->clone_roots = kvcalloc(arg->clone_sources_count + 1,
+				     sizeof(*sctx->clone_roots),
 				     GFP_KERNEL);
 	if (!sctx->clone_roots) {
 		ret = -ENOMEM;
-- 
2.43.0



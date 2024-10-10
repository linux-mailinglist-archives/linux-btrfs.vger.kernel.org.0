Return-Path: <linux-btrfs+bounces-8787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E25998795
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6231C233FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F77D1C9DEB;
	Thu, 10 Oct 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="uZWzoPcT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3141C2457;
	Thu, 10 Oct 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566776; cv=none; b=kf2HmOKE9N/0oDSFQV8OmS8c5d+BLaTjcB+D2sIah90KAbwjUv60Aj9KbM9K+k2KOtLQi5Pgt9h2NidHob1WcXTp2TUuR2apYhItq6s4Wx58+qkcUtdQnnBtbBvJA6Mfk+cuNJsZ8pYiGFlcGO+OB7O0GjBj5pfyZhNOIBm7mJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566776; c=relaxed/simple;
	bh=lbwvQcbDJsKhSQNGTExP3AgqlRBNb9vOza2lfHEioag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OkFO2zFWkQYYBtqA2OMkU9nZc4qwD9ixNdxv6jEvRRL6WFHBU1vbdmurcFvGyfDEbeK24xZhythZvNOVlraii+zGjbqIfR2oTkShI+R+vJtUuCg2lleJPPoa3OgcNwGbZSFeMz4ipgwZBLYAyTxPjeptmII9vpxl2zqTJyC1Q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=uZWzoPcT; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1728566756; x=1729171556; i=christian@heusel.eu;
	bh=ZxURnu2H08+OwhwYM8XDXAevNHVNRfjBtJfTgxY1KTE=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uZWzoPcTBHAfk9YSOiUcDlX6xi0XjA8l4OeW55GJ9kLRSrKjK8KczW6GKqssGDGe
	 tVFhBt/eSKIbht8g9tbUwsmVs+v4VE2Wxs43ooYQCt7PpQef1cr2zWS2OzUEiDoQG
	 B+Hoy509WbrB80SJNlTA7NNFAnDP2ReXOcNIpsD7/HUoo6dE864Yvasqxz084AmbS
	 QVnPwjIhCIR1ILfFdk+o2gKaaR8WilRqRB+4DuwUZcJpqU32gbE66JKCyp7RQHRb7
	 Q+I6dq8OEGeZIczRx1JTEaCdcUOPTsq/5XD5IF8zGtpTFCCeUpmwg7U4hPLmH7FsQ
	 1L+VVMH4HYFhTOilcg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.localdomain ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McHQA-1tZ3LE1H1I-00hv8U; Thu, 10 Oct 2024 15:25:56 +0200
From: Christian Heusel <christian@heusel.eu>
Date: Thu, 10 Oct 2024 15:25:25 +0200
Subject: [PATCH] btrfs: send: cleanup unneeded variable in changed_verity
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241010-btrfs-return-cleanup-v1-1-3d7a7649530a@heusel.eu>
X-B4-Tracking: v=1; b=H4sIAMTVB2cC/x3MywqDMBBG4VeRWXcg8YLgq5QunPhHBySViZaC+
 O4Gl9/inJMyTJFpqE4y/DTrNxX4V0VhGdMM1qmYale33nnHslvMbNgPSxxWjOnYuOshIrFrgoB
 Kuhmi/p/t+3NdN9jTLiRmAAAA
X-Change-ID: 20241010-btrfs-return-cleanup-57ebbbf53cbe
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Christian Heusel <christian@heusel.eu>
X-Mailer: b4 0.14.2
X-Provags-ID: V03:K1:R8mcuuc5g1POkw3nnpQce73yHBzZvE9EWy3hyp94uMZ3roLAFoY
 QkgcBft29CvN8qYcioCfNjG3Ln7f3Jrxc+4y153V34WpTRBS/leG064qC5hxi00pb64i9k2
 sNpjxIva+GrgMKuFoPpHtqVGYRjJS48/3MHLZxPzEg7V5P7fCq/qsKO3UycINR7yYI6uVqj
 A2Og/M15tKU43Z37TUJJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZctUuu1v6GU=;w9OCmNNfC0Meonbhc8waVyhUy/X
 K9Hxcxl4hzt3VHjmp85SsbMac8Jq/5V81GlIKC5eIGWoVJKWrHQfNgfmi6Xod3pRkk45RmnVC
 Lg2vyvsv24WXS14ArfpP+IgHqGra0+8pnpbEgAlD8pttNUOk/CWszk/NaVlcCDLSg/HPhF6ff
 ZWWL5Pf2Z5LJ5vANrqxH/aXuoC+5l8+pF+P1exkxGrkFiAqyStx1X0uttft2Rbd5S7smXDa3g
 2D/thhdVdAnfEGi+Bgx97Klmj5VZZztORrMojcxGfPqyTzPsM8GGHwhOTZ0y/yR94zqNispg7
 rWED8VR5ajBB7dsJCV5x6+DN4cIr7hj/tyOzSMWAjj0uqf+ytAsF3RbbDJ8mluGotJIeiZ2rK
 RwZI5G4zx2p9vQzTwR6jVjDWRLayGucFreDl4PN+8FxVBztcZNxD7IdPWsjlMjBq7GkiPNL+D
 JxQlKfYmZEz+gddyyg6ZMr1l3kQ6733vxK2dDtigOeb+AAWkFWCa3/K4tvFPKLbHQ+PXVmoRV
 ZKdnep0+1BOsvqLAINQmlwCyZqmXhBZba10HJSeGEOh7BGh19AQ0yWKiXTEGTY9VpMyX+v4YT
 GhmMd9aF5DnGeWadVGsIJu9qaMD1jLvIVdeVae+DKI30cd2UZVZep5PYE1JqvxBD1EgaLqe16
 XUfSAnLp3kPTuwait+mT4+6xISw99821mlz+i339u04kGQZjPNTQBJ6i6mCAbDQB1nZZkjiMo
 JwZrBfzehThD/8VF9sTgSzPVe5wpR71qA==

As all changed_ functions need to return something, just return 0
directly here, as the verity status is passed via the context.

Suggested-by: David Sterba <dsterba@suse.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410092305.WbyqspH8-lkp@in=
tel.com/
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
 fs/btrfs/send.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7f48ba6c1c77a0862932bdeffdf7b350267ca544..3f7e100a63cd5e444f8cd76c24=
114a5855a86e61 100644
=2D-- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7167,13 +7167,11 @@ static int changed_extent(struct send_ctx *sctx,

 static int changed_verity(struct send_ctx *sctx, enum btrfs_compare_tree_=
result result)
 {
-	int ret =3D 0;
-
 	if (!sctx->cur_inode_new_gen && !sctx->cur_inode_deleted) {
 		if (result =3D=3D BTRFS_COMPARE_TREE_NEW)
 			sctx->cur_inode_needs_verity =3D true;
 	}
-	return ret;
+	return 0;
 }

 static int dir_changed(struct send_ctx *sctx, u64 dir)

=2D--
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241010-btrfs-return-cleanup-57ebbbf53cbe

Best regards,
=2D-
Christian Heusel <christian@heusel.eu>



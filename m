Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5663305736
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 10:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhA0Jo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 04:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235432AbhA0JnV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 04:43:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90F3E20758;
        Wed, 27 Jan 2021 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611740557;
        bh=jGmqiZceCyQBNsgG4WSaurr6OUKEtvu04Lzu24CAX1g=;
        h=From:To:Cc:Subject:Date:From;
        b=ViVtmPDtmGNz+tgB5Tw3VOHZXQAhNKybtDKHuAXLOYL9IJxwA5OFXp8c35Rjs6Ljq
         hUfaxo8d24hw3MHLCxZq7fmFxvpt/ZXQAU9YslbpjCKYPhAD9FONiXOQBmzbt9fTe1
         YOJaqZdcUTS0D439J4h3N16NsJO0UfxoIqO3zon7shUeqPGNR0geD6AVvu8dJDlq6t
         HJxcm9SmwS2usSbX75KU+HXpj/ukgA8zIauAL4ailr1YLw9KyzSRZJtLkfFO8Pr8jP
         OBXf+FbmPaoT/MPAomgtNpqy7eG/MlgH69fIrY3hsoQCSs0+0wrI+AGRlT14ErwcB0
         hyQYXt0QCYNBA==
From:   matthias.bgg@kernel.org
To:     Qu Wenruo <wqu@suse.com>, Marek Behun <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] fs: btrfs: Select SHA256 in Kconfig
Date:   Wed, 27 Jan 2021 10:42:30 +0100
Message-Id: <20210127094231.11740-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Since commit 565a4147d17a ("fs: btrfs: Add more checksum algorithms")
btrfs uses the sha256 checksum algorithm. But Kconfig lacks to select
it. This leads to compilation errors:
fs/built-in.o: In function `hash_sha256':
fs/btrfs/crypto/hash.c:25: undefined reference to `sha256_starts'
fs/btrfs/crypto/hash.c:26: undefined reference to `sha256_update'
fs/btrfs/crypto/hash.c:27: undefined reference to `sha256_finish'

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 fs/btrfs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index f302b1fbef..2a32f42ad1 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -4,6 +4,7 @@ config FS_BTRFS
 	select LZO
 	select ZSTD
 	select RBTREE
+	select SHA256
 	help
 	  This provides a single-device read-only BTRFS support. BTRFS is a
 	  next-generation Linux file system based on the copy-on-write
-- 
2.30.0


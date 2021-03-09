Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADD3330F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhCIVcl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 16:32:41 -0500
Received: from j341190.servers.jiffybox.net ([46.252.26.156]:51495 "EHLO
        heiko-becker.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhCIVcO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 16:32:14 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 16:32:14 EST
Received: from gantenbein.fritz.box (p3e9e515a.dip0.t-ipconnect.de [62.158.81.90])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by heiko-becker.de (Postfix) with ESMTPSA id 14D0F1D57B5;
        Tue,  9 Mar 2021 22:24:46 +0100 (CET)
From:   Heiko Becker <heirecka@exherbo.org>
To:     linux-btrfs@vger.kernel.org
Cc:     Heiko Becker <heirecka@exherbo.org>
Subject: [PATCH] btrfs-progs: build: Use PKG_CONFIG instead of pkg-config
Date:   Tue,  9 Mar 2021 22:24:40 +0100
Message-Id: <20210309212440.2136364-1-heirecka@exherbo.org>
X-Mailer: git-send-email 2.31.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: heiko-becker.de;
        auth=pass smtp.auth=postmaster@shruuf.de smtp.mailfrom=heirecka@exherbo.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hard-coding the pkg-config executable might result in build errors
on system and cross environments that have prefixed toolchains. The
PKG_CONFIG variable already holds the proper one and is already used
in a few other places.

Signed-off-by: Heiko Becker <heirecka@exherbo.org>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1b0e92f9..612a3f87 100644
--- a/configure.ac
+++ b/configure.ac
@@ -223,17 +223,17 @@ elif test "$with_crypto" = "libgcrypt"; then
 	cryptoprovider="libgcrypt"
 	PKG_CHECK_MODULES(GCRYPT, [libgcrypt >= 1.8.0])
 	AC_DEFINE([CRYPTOPROVIDER_LIBGCRYPT],[1],[Use libcrypt])
-	cryptoproviderversion=`pkg-config libgcrypt --version`
+	cryptoproviderversion=`${PKG_CONFIG} libgcrypt --version`
 elif test "$with_crypto" = "libsodium"; then
 	cryptoprovider="libsodium"
 	PKG_CHECK_MODULES(SODIUM, [libsodium >= 1.0.4])
 	AC_DEFINE([CRYPTOPROVIDER_LIBSODIUM],[1],[Use libsodium])
-	cryptoproviderversion=`pkg-config libsodium --version`
+	cryptoproviderversion=`${PKG_CONFIG} libsodium --version`
 elif test "$with_crypto" = "libkcapi"; then
 	cryptoprovider="libkcapi"
 	PKG_CHECK_MODULES(KCAPI, [libkcapi >= 1.0.0])
 	AC_DEFINE([CRYPTOPROVIDER_LIBKCAPI],[1],[Use libkcapi])
-	cryptoproviderversion=`pkg-config libkcapi --version`
+	cryptoproviderversion=`${PKG_CONFIG} libkcapi --version`
 else
 	AC_MSG_ERROR([unrecognized crypto provider: $with_crypto])
 fi
-- 
2.31.0.rc2


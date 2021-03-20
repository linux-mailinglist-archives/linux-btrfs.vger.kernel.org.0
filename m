Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9779A342CAD
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 13:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCTMCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 08:02:32 -0400
Received: from smtp26.services.sfr.fr ([93.17.128.192]:3877 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCTMCP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 08:02:15 -0400
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by msfrf2606.sfr.fr (SMTP Server) with ESMTPS id 90ED81C003141
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 10:27:28 +0100 (CET)
X-mail-filterd: 1.0.0
X-sfr-mailing: LEGIT
X-sfr-spamrating: 40
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=neuf.fr; s=202006;
 t=1616232448; h=From:To:Subject:Date:In-Reply-To:References; bh=Pe0uuzTO8HLH
  wwyDm3wSDd8j/unr9DzefX/dQBcqtYg=; b=Q/XkLOTHVc8tDrg9DUQuFMPSTIvAhGvQ3DdPZZPv
  IehzZfJ1pdhoSVFEii83jv9ImIQZBYmTpESfFB/5YLonInP0pCgj3FFyRDWmtTYufKSnln3cxnyY
  CaXKlUngOJgzjPuQ1a6WdTnHUszHV9i7b55HsjOJX4sJwVVbBzWiVN6UdhE1n+hnHEE6PFJUbsjJ
  A47qjruFMjFazntnwG+jgB7NgMmWwEDkv5+TqUWh4nqx2PvQ8kqHTuFLwVZa8Pn1CmUd7z0QLlgf
  fTUKJ/DOcwYj8GNojaAQmu9GjMuciVHueZkPeMyKMWj51epoJxRKnoMlUYsb0SHTGghHPVvqpw==
  ;
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        by msfrf2606.sfr.fr (SMTP Server) with ESMTP id 775131C00203B
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 10:27:28 +0100 (CET)
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pierre.labastie@neuf.fr)
        by msfrf2606.sfr.fr (SMTP Server) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 10:27:28 +0100 (CET)
Authentication-Results: sfr.fr; auth=pass (PLAIN) smtp.auth=pierre.labastie@neuf.fr
Received: from pierre by neuf.fr with local (Exim 4.94)
        (envelope-from <pierre@neuf.fr>)
        id 1lNXtI-0006Qk-41
        for linux-btrfs@vger.kernel.org; Sat, 20 Mar 2021 10:27:28 +0100
From:   pierre.labastie@neuf.fr
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs-progs: build system - do not use AC_DEFINE twice
Date:   Sat, 20 Mar 2021 10:27:28 +0100
Message-Id: <20210320092728.24673-2-pierre.labastie@neuf.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320092728.24673-1-pierre.labastie@neuf.fr>
References: <20210320092728.24673-1-pierre.labastie@neuf.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Pierre Labastie <pierre.labastie@neuf.fr>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Pierre Labastie <pierre.labastie@neuf.fr>

Autoheader uses the AC_DEFINE macros (and a few others) to populate
the config.h.in file. The autotools documentation does not tell
what happens if AC_DEFINE is used twice for the same identifier.

This patch prevents using AC_DEFINE twice for
HAVE_OWN_FIEMAP_EXTENT_DEFINE, preserving the logic (using the
fact that an undefined identifier in a preprocessor directive is
taken as zero).

Signed-off-by: Pierre Labastie <pierre.labastie@neuf.fr>
---
 configure.ac | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index aa3f7824..6ea29e0a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -240,17 +240,11 @@ fi
 AC_SUBST([CRYPTOPROVIDER_BUILTIN])
 AC_DEFINE_UNQUOTED([CRYPTOPROVIDER],["$cryptoprovider"],[Crypto implementation source name])
 
-HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE=0
 AX_CHECK_DEFINE([linux/fiemap.h], [FIEMAP_EXTENT_SHARED], [],
-		[HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE=1
+		[AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [1],
+                           [Define to 1 if kernel headers do not define FIEMAP_EXTENT_SHARED])
 		 AC_MSG_WARN([no definition of FIEMAP_EXTENT_SHARED found, probably old kernel, will use own definition, 'btrfs fi du' might report wrong numbers])])
 
-if test "x$HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE" == "x1"; then
-AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [1], [We defined FIEMAP_EXTENT_SHARED])
-else
-AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [0], [We did not define FIEMAP_EXTENT_SHARED])
-fi
-
 AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
 		[AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
 			   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
-- 
2.30.2


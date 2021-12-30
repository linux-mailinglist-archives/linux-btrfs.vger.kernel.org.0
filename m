Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92911481C8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Dec 2021 14:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhL3NdH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Dec 2021 08:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhL3NdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Dec 2021 08:33:07 -0500
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Dec 2021 05:33:06 PST
Received: from mail.tintel.eu (mail.tintel.eu [IPv6:2001:41d0:a:6e77:0:ff:fe5c:6a54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8739C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 05:33:06 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id A713F443B976;
        Thu, 30 Dec 2021 14:24:02 +0100 (CET)
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 6nMdjYdLynNy; Thu, 30 Dec 2021 14:24:02 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id 332C4443B970;
        Thu, 30 Dec 2021 14:24:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu 332C4443B970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
        s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1640870642;
        bh=v5dqyNWSd8Xo8GEC+gRQIy/0xdFQlyatutUBaToe+EI=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=PV7twKExm0xDRsP5aFq1PushWHcksBn/fF9BaWtw12nNHB6z1r9Q5s3zeuXR0n6ku
         fTpF08FgQx+jgaSm6nfSDjVlLs2PZOLAPzfGYiceF0/+QkNM2PACORR+29k9f3W4Sg
         Fh0die5Ud0cw9wGo5GD8ihbxf80M29hg4Uzln090=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id jpJqdlJ3kwTy; Thu, 30 Dec 2021 14:24:02 +0100 (CET)
Received: from taz.sof.bg.adlevio.net (unknown [IPv6:2001:67c:21bc:20::10])
        by mail.tintel.eu (Postfix) with ESMTPS id 70C21441C33A;
        Thu, 30 Dec 2021 14:24:01 +0100 (CET)
From:   Stijn Tintel <stijn@linux-ipv6.be>
To:     linux-btrfs@vger.kernel.org
Cc:     Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: [PATCH] btrfs-progs: include linux/const.h to fix build with 5.12+ headers
Date:   Thu, 30 Dec 2021 15:23:59 +0200
Message-Id: <20211230132359.2554027-1-stijn@linux-ipv6.be>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Rspamd-Queue-Id: 70C21441C33A
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Spamd-Result: default: False [0.00 / 15.00];
        TAGGED_RCPT(0.00)[];
        IP_WHITELIST(0.00)[2001:67c:21bc:20::10];
        ASN(0.00)[asn:200533, ipnet:2001:67c:21bc::/48, country:BG]
X-Rspamd-Server: skulls
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Bruce Ashfield <bruce.ashfield@gmail.com>

btrfs-tools compile fails with mips, musl and 5.12+ headers.

The definition of __ALIGN_KERNEL has moved in 5.12+ kernels, so we
add an explicit include of const.h to pickup the macro:

  | make: *** [Makefile:595: mkfs.btrfs] Error 1
  | make: *** Waiting for unfinished jobs....
  | libbtrfs.a(volumes.o): in function `dev_extent_search_start':
  | /usr/src/debug/btrfs-tools/5.12.1-r0/git/kernel-shared/volumes.c:464:=
 undefined reference to `__ALIGN_KERNEL'
  | collect2: error: ld returned 1 exit status

This is safe for older kernel's as well, since the header still
exists, and is valid to include.

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
[remove invalid OE Upstream-status]
Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
---
 kerncompat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kerncompat.h b/kerncompat.h
index df167fe6..254235bd 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <stdint.h>
+#include <linux/const.h>
=20
 #include <features.h>
=20
--=20
2.33.1


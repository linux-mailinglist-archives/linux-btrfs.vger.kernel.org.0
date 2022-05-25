Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C55341F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbiEYRFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 13:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbiEYRFX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 13:05:23 -0400
Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752FA8880
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:05:21 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.14.90])
        by smtp-33.iol.local with ESMTPA
        id tuRjnT8NmKYsNtuRjnAVcJ; Wed, 25 May 2022 19:05:20 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1653498320; bh=vB/HUfWQzIXlI/Wvd3g9Ff/B5IETWpzb2T3ZEv0QZ2I=;
        h=From;
        b=DmSWw7GXQ8HBiBO3tDwzD73sb9fuL/OIVTgERcQS5Nj/r/KDnMne04o8MiJtv0lIg
         dhoZhSFKMzOQbJyT0CzE1hvbkDSNzKd4x79/XU2MLRUs+zLkIYWZsTEtgAmLnPYlHc
         5ycwIS5tY8OW/VLK7Tghg63oU3GvfAxPDupeMPpb6YMWqc1hVyu/eSFQ/NS+EzNyqA
         V/EKMllyZhw1U9yLOkbVnReGmF0bsco59yE7VZuSOZOjPGef7nsLqlrcjYKcH1j8nu
         z9DQMnaf1AP7/cpTWsKEd9fOd7ASIi45kcOoXU0r4caQ4yWpsVnfF5RDxbOg8ciHTI
         hzbpRaSWMtTMg==
X-CNFS-Analysis: v=2.4 cv=KtOIZUaN c=1 sm=1 tr=0 ts=628e61d0 cx=a_exe
 a=tzWkov1jpxwUGlXVT4HyzQ==:117 a=tzWkov1jpxwUGlXVT4HyzQ==:17
 a=IkcTkHD0fZMA:10 a=zxxO8GdMmFOkapouXo0A:9 a=QEXdDO2ut3YA:10
Message-ID: <d1ccc0de-90b0-30ab-6798-42913933dbb2@libero.it>
Date:   Wed, 25 May 2022 19:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Content-Language: en-US
To:     linux-btrfs <linux-btrfs@vger.kernel.org>, coreutils@gnu.org
Cc:     Forza <forza@tnonline.net>,
        Matthew Warren <matthewwarren101010@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: [RFC][PATCH][cp] btrfs, nocow and cp --reflink
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP1YrUibSZmxOFnPrx/uFTgCj6bW3lHmeashpLCSFlRWqb3Q5Xhh6bYhlpajOsX3yTcTUgh2w4MryQRaNQyb37RDSBod9w0hPzUlpOVnKJQxVtQyoIn0
 oltXfWN8MRtEkaO5RjMjnM7YiT6LOcrcEW9pL7KP0YRoZF4+BRwvWVdNFkQjMXsJCDRk4qGBYfKHQj1qxutA8Uu+4NbfnjQBaCChRJNZA3WQy+V4EW7i6qZ4
 JB0+IlMzrYjcxyo/wh2x9HZzUYOrYHpTe+7mrnTy3X/ybp5ylYX9Nj4bNMpdsbPYAwgDC3wuZjZRJjHC5K1fEV4eBk0rcIJKdAOkU24QA1Y=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

recently I discovered that BTRFS allow to reflink a file only if the flag FS_NOCOW_FL is the same on both source and destination.
In the end of this email I added a patch to "cp" to set the FS_NOCOW_FL flag according to the source.

Even tough this works, I am wondering if this is the expected/the least surprise behavior by/for any user. This is the reason why this email is tagged as RFC.

Without reflink, the default behavior is that the new file has the FS_NOCOW_FL flag set according to the parent directory; with this patch the flag would be the same as the source.

I am not sure that this is the correct behviour without warning the user of this change.

Another possibility, is to flip the NOCOW flag only if --reflink=always is passed.

Thoughts ?

BR
G.Baroncelli


-----

diff --git a/src/copy.c b/src/copy.c
index b15d91990..41df45cd5 100644
--- a/src/copy.c
+++ b/src/copy.c
@@ -22,6 +22,8 @@
  #include <sys/ioctl.h>
  #include <sys/types.h>
  #include <selinux/selinux.h>
+#include <sys/vfs.h>
+#include <linux/magic.h>
  
  #if HAVE_HURD_H
  # include <hurd.h>
@@ -399,6 +401,32 @@ static inline int
  clone_file (int dest_fd, int src_fd)
  {
  #ifdef FICLONE
+# ifdef __linux__
+  /* BTRFS requires that both source and dest have the same setting
+     about FS_NOCOW_FL */
+  int src_flags, dst_flags, r;
+  struct statfs sbuf;
+
+  r = fstatfs(dest_fd, &sbuf);
+  if (r < 0)
+    return r;
+  if (sbuf.f_type == BTRFS_SUPER_MAGIC || sbuf.f_type == BTRFS_TEST_MAGIC)
+    {
+      r = ioctl(src_fd, FS_IOC_GETFLAGS, &src_flags);
+      if (r < 0)
+        return r;
+      r = ioctl(dest_fd, FS_IOC_GETFLAGS, &dst_flags);
+      if (r < 0)
+        return r;
+      if ((src_flags ^ dst_flags) & FS_NOCOW_FL)
+        {
+          dst_flags ^= FS_NOCOW_FL;
+          r = ioctl(dest_fd, FS_IOC_SETFLAGS, &dst_flags);
+          if (r < 0)
+            return r;
+        }
+    }
+# endif
    return ioctl (dest_fd, FICLONE, src_fd);
  #else
    (void) dest_fd;



-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

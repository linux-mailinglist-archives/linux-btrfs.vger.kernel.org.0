Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE54784C55
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 23:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHVVyj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjHVVyi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 17:54:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E3CE;
        Tue, 22 Aug 2023 14:54:35 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40fed08b990so32463101cf.2;
        Tue, 22 Aug 2023 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692741275; x=1693346075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTePWJg1P3FSq1aZNsQ7RlEp2lrVrpcoBt9+8ShosH0=;
        b=OiVT+Rl9i3+i6XT+LMPHZ1pqot5eYnqGr9tQzckS1SqZ5kdHPKeCEMDxaJHFCYfetx
         tEuP401eThZYhjGJBk1YZsBFxxvbRKecO2cS9Attwk8wM4RGKiKoYCOJUr4lxJ3nz/iB
         FUauvX9AGtcLRpRlnf32lDKMqm7B3yyohygGLOIRzY5O2yp3+rWUxSpaL7zo/lt3H4QR
         DLX5A7qmk2j4jLgmnjsrT97ztC4m7IgTsXMjH/J0lLwYOWLcBej9oA81hxH26IGClhdk
         A0MbhIs4ATOPe8rd9a8UdSdYBiur88Dvg5phlunvHN0oGn7YdlTLVAd4bxrl+8Ja0EHV
         rSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692741275; x=1693346075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTePWJg1P3FSq1aZNsQ7RlEp2lrVrpcoBt9+8ShosH0=;
        b=kKmB4WX40r3K4IGwu+YjaV7Zcj7WWyJJ4ljAk9+Zeie49mGcrKVBKNlnBq8DJ1/Noj
         r5JdOvONPgT/yPFYcRvG4I6gnNIkiei/rk27DmckLXX1U/aQwqU0A49StVDMqGmlMrb4
         xs34qjAPjAjOcwaV205kP6/2UXPi6jOGT3fMoeU5p/xTZ02B4/J6KM3LzRI8bw/q2LWT
         FP+wLIu0lVohMov0xXJ9c+EGBq8LTX5sVEwDe6wPjwkHjXT9bDnx47c9tWP4MXoaQqkY
         39Gu7VqrEKdmhiqeUfDjQ9EJ/VP1fFB9KCJydGDajBufTUTIxUHM9YUrkxoAL4h4UzMF
         +I/w==
X-Gm-Message-State: AOJu0Yw1igKnPInnjlaUDV7J1dVkoPbVUUx8pXFux8gBVtHwr5Q+HHSo
        Dk+ivZg0D05A27Qr/uvCJzE=
X-Google-Smtp-Source: AGHT+IG/T3r0RmfuYBdy19qEAchsQWbNnxNn0HhobNEcESIQAg+0oSfEeErjPqJyv/rk2yxMSXqI2w==
X-Received: by 2002:a0c:aa82:0:b0:63f:8159:5fc4 with SMTP id f2-20020a0caa82000000b0063f81595fc4mr8750187qvb.26.1692741274829;
        Tue, 22 Aug 2023 14:54:34 -0700 (PDT)
Received: from localhost.localdomain ([191.96.150.158])
        by smtp.gmail.com with ESMTPSA id j5-20020a0cab85000000b0064c107c9679sm3603270qvb.125.2023.08.22.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:54:34 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Btrfs: Replace obsolete wiki url with maintained doc url
Date:   Wed, 23 Aug 2023 03:17:47 +0530
Message-ID: <20230822215158.10542-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replaced and removed obsolete url with maintained url.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/filesystems/btrfs.rst | 1 -
 MAINTAINERS                         | 1 -
 fs/btrfs/Kconfig                    | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/filesystems/btrfs.rst b/Documentation/filesystems/btrfs.rst
index 992eddb0e11b..a81db8f54d68 100644
--- a/Documentation/filesystems/btrfs.rst
+++ b/Documentation/filesystems/btrfs.rst
@@ -37,7 +37,6 @@ For more information please refer to the documentation site or wiki

   https://btrfs.readthedocs.io

-  https://btrfs.wiki.kernel.org

 that maintains information about administration tasks, frequently asked
 questions, use cases, mount options, comprehensible changelogs, features,
diff --git a/MAINTAINERS b/MAINTAINERS
index d590ce31aa72..dea8c26efbca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4360,7 +4360,6 @@ M:	David Sterba <dsterba@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Maintained
 W:	https://btrfs.readthedocs.io
-W:	https://btrfs.wiki.kernel.org/
 Q:	https://patchwork.kernel.org/project/linux-btrfs/list/
 C:	irc://irc.libera.chat/btrfs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 66fa9ab2c046..868d80464858 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -31,7 +31,7 @@ config BTRFS_FS
 	  continue to be mountable and usable by newer kernels.

 	  For more information, please see the web pages at
-	  http://btrfs.wiki.kernel.org.
+	  https://btrfs.readthedocs.io

 	  To compile this file system support as a module, choose M here. The
 	  module will be called btrfs.
--
2.41.0


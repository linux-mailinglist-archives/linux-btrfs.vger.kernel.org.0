Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF95934BAA7
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC1EVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhC1EVW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:22 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9C1C061762;
        Sat, 27 Mar 2021 21:21:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q3so9325752qkq.12;
        Sat, 27 Mar 2021 21:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHG3t+ffr0Era+XL9VE2IB2W+Dy89F8q3bfK5kxmeKs=;
        b=U8+9RytyqACY1+SKqmPPZMBoOdvlzfCiXs10PgwRI3RaYbj0Co58D/dtxOp2vPE2HR
         qZmmdbl8TIoBWn3GI75j+WdMH7Gbg/UZvd+wFW7NgqNXCuycYbd3RHDKOeVLJfIzBJal
         bTIEtmvBDpHayhYGBIxbWdF0b358rqZ96pGIEFdSgzZxb8XjkrXXVkvadiv6rgNHY8wP
         XrTkzpXbuopOIjhliXoeewYIdV6zn1wWpToJiOqJ8jUS7G921OpOZI/hkjKnvcoWi0yM
         XKl0yRiOMaWBWqkviEMtnYyUVswm9XXxwfId8ltCZOPZ9rmZpw0Lu8Y8n6wSHTnUd3Li
         DGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHG3t+ffr0Era+XL9VE2IB2W+Dy89F8q3bfK5kxmeKs=;
        b=nw3lz6kil+u8NU9jrfj1ZnKS5x1afP3HbpXGK9U7Fz1s8N0K0PvdAqLAdMXft4wNYw
         UQJxzz4Gte67XOQzXTNj9eSmxHQ3jpvKHLGJs2eMcb9ySMBtHYQlNyBMeEDLbHQfd3WO
         /LUWfEDxtYPcq8CdeyY5V8BQWlXMTgCgdFPn4YK0d+JZD/QR2yL7hK/uNOaftgk0JVk8
         7+RnB0IuhW7ZKCxAUElr/T0vd9wmCV1tF+3nhYKb/eJD5Pi7Y2d0d0JUIQeGq8TYG8IE
         jfGXPBhdLfIfFo3O0dH7afPCKrP5EkbwbjWAps4WG5uxI3C5BZuwvR7LOVDiJ5gyOx+A
         9EEA==
X-Gm-Message-State: AOAM533qfKVcVMSb4bOrvddlfWP8o/6UUiigeCgwKP1IDD7XZ9lLe1CA
        ZfY2SG3p9mgSXpmpMvWMdvs=
X-Google-Smtp-Source: ABdhPJxGkXbdNeHRdY+8sFlMvQJFbUKAoQoIJPOLpALCs01rLr8GVYcQ7iQEpBlIPz1cG6ckUpHkLw==
X-Received: by 2002:a37:9b07:: with SMTP id d7mr19586090qke.130.1616905281657;
        Sat, 27 Mar 2021 21:21:21 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] ioctl.c: A typo fix
Date:   Sun, 28 Mar 2021 09:48:27 +0530
Message-Id: <25dcc33aa2f97b1f073acd478b77cd9b4a0bbaba.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/termined/terminated/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e8d53fea4c61..98ed14a0682e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3022,7 +3022,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 				err = PTR_ERR(subvol_name_ptr);
 				goto free_parent;
 			}
-			/* subvol_name_ptr is already NULL termined */
+			/* subvol_name_ptr is already NULL terminated */
 			subvol_name = (char *)kbasename(subvol_name_ptr);
 		}
 	} else {
--
2.26.2


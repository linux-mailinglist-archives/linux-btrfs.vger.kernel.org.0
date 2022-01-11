Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1D48A55F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 02:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbiAKB5Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 20:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbiAKB5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 20:57:25 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E6CC06173F;
        Mon, 10 Jan 2022 17:57:24 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id m2so17559848qkd.8;
        Mon, 10 Jan 2022 17:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnk3aKUU8TTDQJEelWsA5ELdK1ZLlLJyjUDJuNNEPts=;
        b=CJ2RPnsKcrYl4nadUXD5HbYLYgSIR+tiBN+v4dWx7xzsISppty1LGsgwGhB2QwZ9Wm
         22OqLkTLgq80wCrbuxFnfBuqVuuAEOZE/ZlKuL3dUxHk6xfIu8ChOJAJiSAwUzCgnCK5
         rWsOXDLcdu5bLEz2pcogGaixpHluGd2xEjT651zwm53KJCNH5LZwiHV27pfeLtiCFetw
         x6QRkGlMTsoqirVUmRowwn0Rk5MqAZWSAC5INhc+SEH6/xrlI424XPyF1/npUv1wyTFx
         xpFZSmIrp5uyi/Wk5+leI0SqLyijJmda8+/axavfl8lli/l65EnW5p/U1cvG7bZrZ3K6
         GZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnk3aKUU8TTDQJEelWsA5ELdK1ZLlLJyjUDJuNNEPts=;
        b=x5FIm1VSoUa6lE3JewRgzjgBKBORfMNtJ6LJ3zGbBYOiVk5jKS+pY/ph9M930NwqcP
         b/Ou0rluvckpvOGn+xNQJGiPQDxbgYeCnHbBUSABPa/spCl7cL5oqUdegDyu0obhTcIL
         Hqi41wkK2j32udgpTrAhRn66Ls+3lKEalJGGmfc2aeojG1RVsx6beq+fOyRyDfhBfjzY
         mLU2Io/CE3X4wxCBCi+n3GbNrlsJC1H1Qs5luvf+rvfigLzr4nVSeuz2Xn92c0BhE+Hq
         w9KPN1xyw38Kzsagu+tH5hCvqaXlIlqd/BzPVUYZijxHGLC0e4ZgrHbOb9rVQDLBSaNs
         ZrDQ==
X-Gm-Message-State: AOAM530ztfGs6Rx5ejgo/mXoRgjQ6+GELMHOEQtEFXYUNn4OQk/rfW71
        tYYtgW2B56OJnVe0ER8m76ZAHAkPNb0=
X-Google-Smtp-Source: ABdhPJwvlVq/9hQvVVvzPFp41+ow+FcRFj2/Fg4wA2+lE7BaMzIhpwKS1P5C8QXUIQA/+k3PJF+tpQ==
X-Received: by 2002:a05:620a:254f:: with SMTP id s15mr1830374qko.241.1641866244026;
        Mon, 10 Jan 2022 17:57:24 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f33sm5926885qtb.56.2022.01.10.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 17:57:23 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] fs/btrfs: remove redundant ret variable
Date:   Tue, 11 Jan 2022 01:57:16 +0000
Message-Id: <20220111015716.649468-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from fs_path_add_path() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 fs/btrfs/send.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3fc144b8c0d8..4ed13461cb07 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -528,14 +528,10 @@ static int fs_path_add_from_extent_buffer(struct fs_path *p,
 
 static int fs_path_copy(struct fs_path *p, struct fs_path *from)
 {
-	int ret;
-
 	p->reversed = from->reversed;
 	fs_path_reset(p);
 
-	ret = fs_path_add_path(p, from);
-
-	return ret;
+	return fs_path_add_path(p, from);
 }
 
 
-- 
2.25.1


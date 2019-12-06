Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42ADA115383
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLFOqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43265 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfLFOq3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so1650847qke.10
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=98+1b8oFGLaRfzg8C5aM6Su3ReXVCYbXLcjBOBU6crI=;
        b=a5JEcHj8FjYbZ9ti3x+K3ElkqPR2wpwvGYTvd7ZiycSm2tnNA0S0WjoYVVY6WxDSL7
         SdHi9pjvuYG6gQwSGoEEJn/xPnZrF5Mqdrmu6nWEw0ZBIdCAz1ovbd/BjRKBrO4puuor
         Q4o1CYNXknWsXNu+pstJDbM2Wq8mqAvHQXguhL5L5UB8RcvTgaoBmT7OJ6ePwLzgm4Wq
         upIONBK91XcSnuP2nOsl5wp+04oDj2QJ6CcKq3KsKReZMjnc7RkjBHW640c1jJnnvria
         6fnGRsXVD2ftDOrviLDWwj9hu3uEIODICnDFTSlI/pRMhgZeieD4lDPIraFl8QkDoQFV
         EaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98+1b8oFGLaRfzg8C5aM6Su3ReXVCYbXLcjBOBU6crI=;
        b=MxBUQhA8eTdpmRJMxVHKhhJvETW0grwo3RaTMim/C2U8eFQrkBiX7RQA0W1iymWQxo
         VaZRZwystrezUUdBYnYLCl1nmBHysSSO7C/usnZfOxl1P527VK8+YyqQqgFRYk/RNCd3
         +RrnGnVfXBlBdzzFwcCsXCQD6K8UgezVS+X9r75/6WCt7ckfT+uSAxLCP4p1awH+14bz
         h6qfvt2DUPJ2BV/gAGmB8nbQLLMgGzDvcaiAuCDJLPYdVdZi7mJjcRtcKEOoxABvU/NP
         lNbcPGTR8u8m3baMe1zsdgmZhY3PQpsFvxOi9szkB+sgUtxR8/wUVuNIx5RLZWv75mHZ
         z4og==
X-Gm-Message-State: APjAAAWC/yeA1dIEOYvkkD33bMyv6FN2DvC2b3zxC6Syx1nt//hfxUa4
        fXeWBisylVIy0uJYr9gmzty1SChTt1g3/A==
X-Google-Smtp-Source: APXvYqy7nscKXZ6AApwYEjJ4F34e2+1PrpYlMZuZcip+i/iNE0Xj2Go65p5t4hiPcQhjya4gWSa4xw==
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr13860115qkl.115.1575643588431;
        Fri, 06 Dec 2019 06:46:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g62sm6006095qkd.25.2019.12.06.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 27/44] btrfs: hold a ref on the root in find_data_references
Date:   Fri,  6 Dec 2019 09:45:21 -0500
Message-Id: <20191206144538.168112-28-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up the data references for the bytenr in a root, we need
to hold a ref on that root while we're doing that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c3cf582f943f..3b419a4e4829 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3669,7 +3669,11 @@ static int find_data_references(struct reloc_control *rc,
 	root = read_fs_root(fs_info, ref_root);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-		goto out;
+		goto out_free;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		err = -ENOENT;
+		goto out_free;
 	}
 
 	key.objectid = ref_objectid;
@@ -3782,6 +3786,8 @@ static int find_data_references(struct reloc_control *rc,
 
 	}
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	btrfs_free_path(path);
 	return err;
 }
-- 
2.23.0


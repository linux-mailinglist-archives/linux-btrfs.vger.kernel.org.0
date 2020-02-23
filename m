Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D513E169AE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 00:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgBWXR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 18:17:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42759 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgBWXR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 18:17:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id p18so4599902wre.9;
        Sun, 23 Feb 2020 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOWxBzMu1Tr1kESKNK3MjAE/ivG0oS+MP+wwV4gJaxc=;
        b=LYlWMx6tQnhBnK+RPyBuYSnK7VJCHTCJsBHxoBOJPGHciR2FtHRWkllVAllTKe+TPt
         rH7GUEkBVCVxgBirrDS/pOwYPiXcNNriCE0YJUWqeiZT1yBKbTgM6AF2ftsgv+pJ3fNL
         Q84mWTwNNY/O0Dve4U/8lgd6pvOVlOQc78G93y4zjDUBr/uLlTD9uRdN+rI44wbX6CuV
         Yr+iLtooO6U4OgILxuMjPPstHVG+83FVfPUyrjUte/wnGWt+Ey1Zf6B/CiyrhKa2eYAe
         u7J4G4Zc8yQGD9xvbXPsurj8Pujjum+Z5Njaz5/Odz2tjdKzGaPw5QmwdCLguQUoTWtz
         c5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOWxBzMu1Tr1kESKNK3MjAE/ivG0oS+MP+wwV4gJaxc=;
        b=nZlKVGejli2ObnD3JjIthmNtMeWcWtxSngRnSVHqyr5lF96+7MWypG1GV+Z5ZW82x9
         DY/+/gwF5jb+lUEsg0BlotuXkvROGM5Ag4ioadtooaYbdGJA4wAusq1cFqEJX5xeckpi
         Pr8H3l56FBvS06eFIEe19m/NuloHA03/jhj1bcwdAJ09e73YF3YnRZcWbMnv+IPbaSfD
         INIfOtSmx+OmPy2KWjBq5eM6wRB7AxspWETbjufm4HP3A9sjjkhTOtVau8Gxl/CPILTc
         9aIemTSl28WF06P5aAOMY4765I7Q/vuwF/RZiJIO3dxo216n4YlJ8gZSiKwPXqzilNnn
         QKvg==
X-Gm-Message-State: APjAAAWTfGj4q2/h/TCQTj58HANm3eWGDfuDzmc6rYTPpFIpIx6gZViv
        QDTDlFawCucgNTFMf0W7c+vyhf245A==
X-Google-Smtp-Source: APXvYqybPH8c6FwwdT6e/hCdRCrsRHzwMpD1UH8pFx2wVbI2R83W06aNfH89fPPDVGd/0uDAoI3Ptw==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr186452wrm.305.1582499874397;
        Sun, 23 Feb 2020 15:17:54 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:17:54 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH 01/30] btrfs: Add missing annotation for release_extent_buffer()
Date:   Sun, 23 Feb 2020 23:16:42 +0000
Message-Id: <20200223231711.157699-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sparse reports a warning at release_extent_buffer()
warning: context imbalance in release_extent_buffer() - unexpected unlock

The root cause is the missing annotation at release_extent_buffer()
Add the missing __releases(&eb->refs_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c0f202741e09..8b6d6893e7a7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5230,6 +5230,7 @@ static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
 }
 
 static int release_extent_buffer(struct extent_buffer *eb)
+	__releases(&eb->refs_lock)
 {
 	lockdep_assert_held(&eb->refs_lock);
 
-- 
2.24.1


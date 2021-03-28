Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF634BAAE
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhC1EWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhC1EVj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36967C061762;
        Sat, 27 Mar 2021 21:21:39 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o5so9402957qkb.0;
        Sat, 27 Mar 2021 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDfitwPdxYx+qIzQbCzCLcoHH8gP8izKHpQ9g3YygP8=;
        b=JaCxghRwGh5HZJor/vTKk+BTwfgwgM2Imbm4x9s+ckJWl5as4luSompmng6zpAmHE6
         g2eNIaqPJSMTzbHN/rjrQ3ZtN8QTNWzHNtbREUh9dGBiGVNM1k6hBKCuq3NIaYKtoZyX
         reOwCUzjBoppvsKq+iSTncMrOay/HencOdBIXpKtABvTl8XtZzvnz+L802cCi61YDvCF
         tzt1BUYSE3vndZzO+i6T+ztpK3J7MAywiuZunixkrnj1clfbgngnrL4PAvI0dMWTZYxX
         b111w1q/XIeOZyZNGZIKt1meoj+Ibrzcv44YAjarwJGeFuST+dbk2+OCtk3NHf5KZoZR
         Qzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDfitwPdxYx+qIzQbCzCLcoHH8gP8izKHpQ9g3YygP8=;
        b=J2p95OkW0q3oxrgi9dr23XKwRa+RMOqZksEJQIJYXz8pWPSadPiGFY8FcdyQc1SjF9
         xiEYe18RjUzemN05r/lB3D102zj1c+TV6SgM87B4gHO2zk4CcAQLmk/AB2tuBZfQqN9h
         Ri99c3Rx9v4vsaRNvqW/IwXv7mgPA4fLx5u7cy+Foprvv2xnzPzdx2A1mVCv7uHBi9Yr
         AUmWvAncXyIW+41hcsUcNnJggjsaIbv4kzDVmMh+dOBw3FkwEvT/AS/H2LvjWl5FCiCS
         f80c708S914sugfBmoxyRDTXZLAWnyWdBDOwnDCMmxf2+aKN3X+HUjrk5i0FiI0Y3+Ba
         OLPQ==
X-Gm-Message-State: AOAM5330hsreIjrh6qPrWqxz5uCI/F5VRkMKBXwyUEi4rxNBod0UqWmG
        weEZvNJG3gLkiSuQ/QHWJ64=
X-Google-Smtp-Source: ABdhPJyJ0CQjWnR7HXJhxHH/eE1ReOl5E0XnX4TaARYZlMw/bfY3y8EUGaMq+dDdZLpY1nfVaYgQrA==
X-Received: by 2002:a37:6c1:: with SMTP id 184mr19580934qkg.462.1616905298508;
        Sat, 27 Mar 2021 21:21:38 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:37 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] locking.c: Fix same typo in couple of places
Date:   Sun, 28 Mar 2021 09:48:31 +0530
Message-Id: <175684259886b4c2f7c3ca8df93b589b91c888a8.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/Retrun/Return/ ..... two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/locking.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 5fafc5e89bb7..313d9d685adb 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -57,7 +57,7 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 /*
  * Try-lock for read.
  *
- * Retrun 1 if the rwlock has been taken, 0 otherwise
+ * Return 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
@@ -72,7 +72,7 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 /*
  * Try-lock for write.
  *
- * Retrun 1 if the rwlock has been taken, 0 otherwise
+ * Return 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
--
2.26.2


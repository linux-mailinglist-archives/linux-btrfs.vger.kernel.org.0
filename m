Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE89E44C8E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhKJTXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 14:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhKJTW7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 14:22:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9FC061766;
        Wed, 10 Nov 2021 11:20:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so5528423wme.0;
        Wed, 10 Nov 2021 11:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2gR6okmLSMlMIhfCQTlyRrP9i8TvjzjbMxZ8UL3G+U=;
        b=ZlL6MzG25MmTPSIhCaqmFE0o5ZJkk4P7wI+ZLWAO7W2YXoHzfKEDDkqljk6vNfXl03
         aap+e71LCTcBSvUkcYJGpUr8i5Bq5C9xhl0k3FbeiPc2tf/aiLp5pT/HQ+CebYpUbHVK
         KXTu4FCuvWWukJXO8/JvYhiwe5CpL5GIe9oQpjoH87LgPTt7W1nBLDm9vth3+dAHnvMY
         lH9SvJDeGDOxZdcyWi4U8H6dq5dW8TIHKCEl9WRGj+6+AGjTfHZfXKGJg9uI0qB/DJTu
         IiuHdMxjNKCOpdix7OyBMrgCarV7KW2XF5nPkQkj6bfEHiX0xAPbSylRkduhORU7PlEM
         K27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2gR6okmLSMlMIhfCQTlyRrP9i8TvjzjbMxZ8UL3G+U=;
        b=LMx13GQtK4GMeGjFBkZ8DtvxeO+grstIFjK1TFCI0AjyKJc26naA+tSDpBDcFuUhQO
         J2cqkF49wYXYzJsaJuiUTYhXFenHSN45JWYcIoZRzV2+RjupGhaRhsUbx6GEcq+JaZrB
         P4wvm9zYHyZPX3P19Y3yf8xNRJImma3jq7Zn7UuNkskCyjJdSK+ZhixJdEojywKF5ghG
         B0ZY3m5vkBFI60415HunHuR7h+kiXHPqEn0h22Lpld8dH0QVTWCxFLOOU/H6gjFERC9c
         n8FPattOhmru4+oFE/TKEL3B5imvWgchXk+Mmb+GJRtDbZwfpuwEGs1MsVJvLnMCx3gR
         OjSA==
X-Gm-Message-State: AOAM530Yk7Sr1OsMtK87BeexpQdDMOxYcONwxirSwosnjXfAjP22OnAA
        N9XMDdcC0l2yYA==
X-Google-Smtp-Source: ABdhPJxkjsyfnVhoNjji26QSNCrhZkbSE262C9r9Z1O3juc2nhpF2kfC5Ou0624AkR7HAjaHO6LhfA==
X-Received: by 2002:a05:600c:a42:: with SMTP id c2mr19334580wmq.154.1636572010145;
        Wed, 10 Nov 2021 11:20:10 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b197sm598885wmb.24.2021.11.10.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:20:09 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: make 1-bit bit-fields unsigned int
Date:   Wed, 10 Nov 2021 19:20:08 +0000
Message-Id: <20211110192008.311901-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The bitfields have_csum and io_error are currently signed which is
not recommended as the representation is an implementation defined
behaviour. Fix this by making the bit-fields unsigned ints.

Fixes: 2c36395430b0 ("btrfs: scrub: remove the anonymous structure from scrub_page")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf82ea6f54fb..8f6ceea33969 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -73,8 +73,8 @@ struct scrub_page {
 	u64			physical_for_dev_replace;
 	atomic_t		refs;
 	u8			mirror_num;
-	int			have_csum:1;
-	int			io_error:1;
+	unsigned int		have_csum:1;
+	unsigned int		io_error:1;
 	u8			csum[BTRFS_CSUM_SIZE];
 
 	struct scrub_recover	*recover;
-- 
2.32.0


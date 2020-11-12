Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369B12B1016
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKLVUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgKLVUf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:35 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99808C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:32 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so5192059qte.11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sHF7Tm+o2J0OkqwMhP7RAPJ0V/inuUAg+Wxu2zIkZkk=;
        b=e/DTDvQ1cTsrko3vvIP8dXp3n0x2UMEtBjGx4cwuzUEyqAAXgDzF89UUHZu4zEAjag
         St7ciVo/Y8rg9BBsdZVDWkTuSdD9wzL1Lw6lc/mabsjrWW3l4nuMl+3+wJ0DUFdxYZPX
         ygy/9hGPl32Z9GDV9i1LwmGn5YGMefnR3i8P7aTvMPECGueoySjZA/Y9dhvXeU5yotSx
         sVXUU4H0ksyFE+Ms/07AsJMNomRHWRVbNyNtZlA4L41XJuRAyzjemlQiEpHHmuTRi/En
         Ir/ZOgcg+F3IW6ygzHdtYBqxFYxeeMSqKOTS1ItDRcyvXC0SIJujnVgrjlXpEgazFIse
         EOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHF7Tm+o2J0OkqwMhP7RAPJ0V/inuUAg+Wxu2zIkZkk=;
        b=rdYM94ca+7/ZYqqKBbP5islH50nEF18emPD5iofKeOUYFFgKXGLkrGffhpA9PjMP9J
         W7W7y82foTbGdlxbtpglL5DNU5viOOvBMp+skUThUp4MZtY7PgeW9+KZpXZeE8+q+dXN
         bhH9XkKXasEg9/O+it/m1gyuA8iNHB40/CQQUuQV3sP/DOb5+KoitwOWgjCrOjm7nx65
         Zrnik1LyuzAXnz/tNf4KqOm848xd3GpAMZ5tf3gMnBgFvfuMSX3KaKu6b7Vr/YTXmguY
         tpBqjUmIgwMipgAXuuwcfi+mmOnLZxnoLUdiyZblz8edGJtuv7swXOHujvMI84WkK8em
         UDqQ==
X-Gm-Message-State: AOAM5304VsnjVVu4iSfRxv//cZaA3WFSYfuvRCFJGU4TqMpoO0LJXJqP
        q0lwk17aObxuKnCibTxoNubc3jBX9wluCA==
X-Google-Smtp-Source: ABdhPJwWbdV3HYA4WoILKglRgOmbMqtKFLxobW7YYnyTJp85OIL4RWD0j1hRd6k4YR9UPMYDfd0MDA==
X-Received: by 2002:a05:622a:14c:: with SMTP id v12mr1204561qtw.11.1605216031416;
        Thu, 12 Nov 2020 13:20:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 137sm5607856qkj.109.2020.11.12.13.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 37/42] btrfs: handle __add_reloc_root failure in btrfs_recover_relocation
Date:   Thu, 12 Nov 2020 16:19:04 -0500
Message-Id: <fcd0d76c384c5f5d938ef51da1a21ff5e8a7cf1a.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already handle errors appropriately from this function, deal with
an error coming from __add_reloc_root appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c6619e54f424..832bf7c19dac 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3978,7 +3978,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		}
 
 		err = __add_reloc_root(reloc_root);
-		BUG_ON(err < 0); /* -ENOMEM or logic error */
+		if (err) {
+			list_add_tail(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(fs_root);
+			btrfs_end_transaction(trans);
+			goto out_unset;
+		}
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
-- 
2.26.2


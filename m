Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08360495FEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 14:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380740AbiAUNps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 08:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380720AbiAUNpm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 08:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642772741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=17q/M65gYgBO/SPoZzHGwbDSkKeNitT4nImp6fFN+Jg=;
        b=E3Axi5nRJlonnp0FEb+Jev8SeW2nu0sbAuRxFa80YM50ef2oA2NAHgu591MJ/PzokdE/z5
        MrEeM3iY4H4j77HlL1bKphUNsxMTxFzrARx8XmP/07VAHen2tNRcnyhfK+b5rvLu0K6jEQ
        GiEG8znvlkSOVlRPx1yT3cH/UeQDBAE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-G9X-f9TiOTaU0upzVxenlg-1; Fri, 21 Jan 2022 08:45:40 -0500
X-MC-Unique: G9X-f9TiOTaU0upzVxenlg-1
Received: by mail-ot1-f71.google.com with SMTP id 30-20020a9d0a21000000b00594d9ed4bf1so5472624otg.23
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 05:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17q/M65gYgBO/SPoZzHGwbDSkKeNitT4nImp6fFN+Jg=;
        b=VB+ykkrheh6YvQjXGXeYjhVnfYL8yhd/Vw1YVSZLOeXkMJyLzOPIizrinBUBo/xqgy
         j2sXLkOrKeNLis+9Bkkgk1eWPq+FxUCu2G+A3bCDpqOe8hsa7tZvnUukpxKMtvM518W1
         pDjG1uSdsYqs0ValO1P2en4wAXUmA9cxMj7bAhoaiwXZKSocCjPy5X2FI1oK2SuJbGAG
         m/VPbzPdP+Z4g1OkyND7fyMTTFsMcysnOwRX72XNUHaapfJZhLVC2prv0TmhcMd/NufV
         0y/sZ1wPqQExzbgxtx59Z3CFs2Et07d7gU7xkjv1utRvt6ewCfRh0bbMBXBNbndqTuvi
         uIog==
X-Gm-Message-State: AOAM531X27b7k6c5vDAWMm1BtgQMwE4QVBn05F5L3pukpxQ9eqPASUlO
        ZYnj5FLXEmVsU1BtGUZVOk9fKc6XelwwsmLye+NOYfHZ/7dnHyQxrKnbNC8mDxYl52fP6Jn5TeZ
        9LxvEiPmDZe2eCM5LJcDKIk0=
X-Received: by 2002:aca:741:: with SMTP id 62mr570975oih.87.1642772739435;
        Fri, 21 Jan 2022 05:45:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9SguOPBXUy11/Do9O3kCGX1ZokLcCXVsUAdxGjD9Ol9xJN2frusYOCbndlnUNmcESN2jJZw==
X-Received: by 2002:aca:741:: with SMTP id 62mr570954oih.87.1642772739225;
        Fri, 21 Jan 2022 05:45:39 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m5sm1349202oiw.30.2022.01.21.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 05:45:38 -0800 (PST)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com, anand.jain@oracle.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: initialize variable cancel
Date:   Fri, 21 Jan 2022 05:45:22 -0800
Message-Id: <20220121134522.832207-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
ioctl.c:3333:8: warning: 3rd function call argument is an
  uninitialized value
    ret = exclop_start_or_cancel_reloc(fs_info,

cancel is only set in one branch of an if-check and is
always used.  So initialize to false.

Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 190ad8af4f45a..26e82379747f8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3308,7 +3308,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct block_device *bdev = NULL;
 	fmode_t mode;
 	int ret;
-	bool cancel;
+	bool cancel = false;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-- 
2.26.3


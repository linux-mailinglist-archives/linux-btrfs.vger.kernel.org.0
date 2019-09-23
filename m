Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38ABBE86
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 00:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503339AbfIWWeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 18:34:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43933 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbfIWWeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 18:34:50 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so37507208iob.10;
        Mon, 23 Sep 2019 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ESXrds+UkbTh1Hy7rleyJrIt8yDroZEYMnOKz1oS1U=;
        b=HUBbFfCSh3vMKfJOM8EaCOEnkHZDGxdVvmoOY3dAzyrsy4bmK8BZ7QGPOMIU4v7nNA
         rKwmr3kzUtLSwlPT1BuPo4/Rh3b7F79zhv6ae6MkXRa09REgi4WPQQ+mKQAepk2pn/Hg
         QDxfNWHLZInpMGMhHRYVMm1IHcjZLLubt4ECohLul24/9Mb3b3idj7fb2kcgdLhB4uPQ
         undfL9R2nOSOr41BxGN+1/afcmiFwdhahA9aLxSRVoH29TEEu9XnwGGWbfy0VPHSo2Xg
         boTqbcE+7yVyvjQmoCOJqeKecn2lBpDwYzdvmGm2EkNOJsTCS/szPmB+X3FkyVtD2G1V
         0CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ESXrds+UkbTh1Hy7rleyJrIt8yDroZEYMnOKz1oS1U=;
        b=BwTU26zN0rq/3yq73DZ8tSpEbNUWeDjpMYh0ONGz+7tCOqKqDdSk4jqB2biPO9y+Km
         ZpMVsdOgkQmQVVNLcGw176Ml1AnKThMTBvSTFczFOnBjVZYwnw/BcgdATrxIXDxpBOJj
         7nu7PlW7j6vR/zhra1wAs48IxmfchmGIzN+V/C9cBzdcL1bz2nE9OmUtPblfhPHvjYGx
         hC0gRO6ggyuBMJMAbHmoP56ELDUJOKe/bQhz8RrW0ER2n1aApV5LzbdRKZRxfN/isRin
         xjle5JO7DIjdQSGbuj9Lxx0d+/vz3p+7yHwcDBcDfrdBAw8+NS4x3cO/8Y9jR57L1GOv
         k8hg==
X-Gm-Message-State: APjAAAVKWHINEQ9FFOUiA36zM4D0xJ5seB854QW9lYWi1tH7JFqcuGM8
        DZZ2K6h17P14bpq+o4Ti8LA=
X-Google-Smtp-Source: APXvYqyGvXsuCTYv2evhg0d0GRcR+CafHX246r1/RS/Iuf+TGdu/sqYNTm7XV+cXHM0OxEVesAe58Q==
X-Received: by 2002:a5d:8908:: with SMTP id b8mr2026998ion.237.1569278089305;
        Mon, 23 Sep 2019 15:34:49 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id f5sm11689832ioh.87.2019.09.23.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 15:34:48 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: prevent memory leak
Date:   Mon, 23 Sep 2019 17:34:36 -0500
Message-Id: <20190923223437.11086-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfsic_mount if btrfsic_dev_state_alloc fails the allocated state
will be leaked. It needs to be released on error handling path.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/btrfs/check-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 0b52ab4cb964..8a77b0cb2db3 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2941,6 +2941,7 @@ int btrfsic_mount(struct btrfs_fs_info *fs_info,
 		if (NULL == ds) {
 			pr_info("btrfs check-integrity: kmalloc() failed!\n");
 			mutex_unlock(&btrfsic_mutex);
+			kvfree(state);
 			return -ENOMEM;
 		}
 		ds->bdev = device->bdev;
-- 
2.17.1


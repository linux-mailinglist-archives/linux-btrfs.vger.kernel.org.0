Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955EB229CC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGVQHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgGVQH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 12:07:29 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB06C0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 09:07:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so2175291qtm.10
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6diZpmoYJxFJo2bayk6PN2hMSNmGQAMLPG5IUsglcDk=;
        b=wsTmCyvJulnjhNLAuBt2mJqnq3xNfbdYC/eWNnOetDsJ8dZJRR3DpD/JTqLEyfXABC
         wJz9ZGnG0hAMrBLfqKmsl62N7E8uZCiy7g8uLKxnt0tA+cMXyXkF9HIbystR16Ym9XNe
         lyA8QvQy9R5Nd4JRgq6Sh8REspsP5XwDyy7EEa3LCcyifx7d5eChkEc3BAcCotkyHKjP
         YnmuzaFbterQV0uEjy6mnJjlnurrPlua7djXjSO70DJYNNUfu7dkMq/nH4bilfKoABl9
         5FeOioB42qRSVYY4y1If0tfN4JGxoq97lbr17Y/KYOCz13Vtj4ABIg+aMWTXoEv+QRD/
         Dxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6diZpmoYJxFJo2bayk6PN2hMSNmGQAMLPG5IUsglcDk=;
        b=NUd/DCRiafdDvtkVOgOSYQ1wiVuiAsGhne3aUIRrycM56LO0FZYRD86qiJZojV3jJd
         NY3SZ6GtqkUQwcnThok7OkQuIRXilzZyyROeQVhgRPvGTk715gtw7JRa8h2pp3rhTHyS
         x00ElXbYAaklFe2qfFlIcsojX2p2l0ShX1oE+YcZ3QTB/SEKEIygERLXIMxYJSflOVzQ
         Kpj49ry5Z7hB4f3ZREHyF74TzA5E9SBTzk1RscAR+FDr/a7DepcLoH6swIqEydnsurbm
         A6UYBmZXKz1btxGeVsDY9GyC2J4wpr31RVOMpWJuOXXNXP0fnH0ehSuMw5GqvEdaTulA
         M8Bg==
X-Gm-Message-State: AOAM5305L5qp8tDR19JHbMWueZUhLYV0717XgfCJzbd5wPxcZ4LoOONS
        ZSgEG+TOPtr/66Y4wSD5IMa2E/ArRPzz/Q==
X-Google-Smtp-Source: ABdhPJwbAJnVUhZk1NxRASVzzjFxukqvEtBrI6mZOK9z7mgnRCVMg8HdTXxI3J/S8VqVdtPaGMXWag==
X-Received: by 2002:ac8:66d1:: with SMTP id m17mr70961qtp.88.1595434046513;
        Wed, 22 Jul 2020 09:07:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a3sm194586qkf.131.2020.07.22.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 09:07:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: fix root leak printk to use %lld instead of %llu
Date:   Wed, 22 Jul 2020 12:07:22 -0400
Message-Id: <20200722160722.8641-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722160722.8641-1-josef@toxicpanda.com>
References: <20200722160722.8641-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm a actual human being so am incapable of converting u64 to s64 in my
head, use %lld so we can see the negative number in order to identify
which of our special roots we leaked.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f1fdbdd44c02..cc4081a1c7f9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1508,7 +1508,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&fs_info->allocated_roots)) {
 		root = list_first_entry(&fs_info->allocated_roots,
 					struct btrfs_root, leak_list);
-		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
+		btrfs_err(fs_info, "leaked root %lld-%llu refcount %d",
 			  root->root_key.objectid, root->root_key.offset,
 			  refcount_read(&root->refs));
 		while (refcount_read(&root->refs) > 1)
-- 
2.24.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE45A4EE3B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 00:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbiCaWBQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbiCaWBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 18:01:10 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756F83879A
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 14:59:22 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so735665pjf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 14:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Znm+xY6mGatmaemFgCNs/1Q7aa+ft4q2oHBusKXx5+I=;
        b=IjioVn6ra0hRxLu60d0xShjdb+fNOyeMYrtYoU2rbDc5lZslClRv7wzRK+zYdSGQjC
         FS2rsv32WLf2gVrICcPs3/dlx7w+c6w4pIvdC5U53lJwuRF7C7jf40v8x/E6aG87Y+H9
         ukaqzvfgowXontfHy4vSAzcL1B67nUvIVesvJLEwQKo9IIqCEvRxVZ/uKCo8c7gymrCk
         2qfqZk+HhAzUR6oL2gm5V6W6axT/hD5fn+8TDEnNvfK9tqhf2AkqPr9vEFTE1JKAB89y
         AxWfc/FeFbfwW647HwKSHAvKAGS3Su1QMlcmnfY0xGw8E6vmr6gtx5p6ivPaO5yEIYco
         GaTA==
X-Gm-Message-State: AOAM533cMBJ7xYNLZwWxjoXpGo9Hw39kYOXZHtHBNd/2d3GOV9yEbyZo
        ika88fUUD3SA30UJg9GGgv4=
X-Google-Smtp-Source: ABdhPJw8ucYA1RFB/sydkgsC2Pf8LiBTxwRKEzZ6zXlwnVyDM1twmcFGVRjoMpI51ROg0qtb3qIEIw==
X-Received: by 2002:a17:902:e40a:b0:155:d894:79a3 with SMTP id m10-20020a170902e40a00b00155d89479a3mr7436177ple.73.1648763961718;
        Thu, 31 Mar 2022 14:59:21 -0700 (PDT)
Received: from localhost.localdomain (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id s10-20020a63a30a000000b003987eaef296sm300914pge.44.2022.03.31.14.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:59:21 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 1/1] btrfs: fix btrfs_submit_compressed_write cgroup attribution
Date:   Thu, 31 Mar 2022 14:58:28 -0700
Message-Id: <20220331215828.179991-2-dennis@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331215828.179991-1-dennis@kernel.org>
References: <20220331215828.179991-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This restores the logic from commit 46bcff2bfc5e
("btrfs: fix compressed write bio blkcg attribution") which added cgroup
attribution to btrfs writeback. It also adds back the REQ_CGROUP_PUNT
flag for these ios.

Fixes: 91507240482e ("btrfs: determine stripe boundary at bio allocation time in btrfs_submit_compressed_write")
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/compression.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index be476f094300..19bf36d8ffea 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -537,6 +537,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
+	if (blkcg_css)
+		kthread_associate_blkcg(blkcg_css);
+
 	while (cur_disk_bytenr < disk_start + compressed_len) {
 		u64 offset = cur_disk_bytenr - disk_start;
 		unsigned int index = offset >> PAGE_SHIFT;
@@ -555,6 +558,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				bio = NULL;
 				goto finish_cb;
 			}
+			if (blkcg_css)
+				bio->bi_opf |= REQ_CGROUP_PUNT;
 		}
 		/*
 		 * We should never reach next_stripe_start start as we will
@@ -612,6 +617,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	return 0;
 
 finish_cb:
+	if (blkcg_css)
+		kthread_associate_blkcg(NULL);
+
 	if (bio) {
 		bio->bi_status = ret;
 		bio_endio(bio);
-- 
2.34.1


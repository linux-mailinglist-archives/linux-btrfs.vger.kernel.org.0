Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4737F60BA82
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiJXUhw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiJXUhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:37:15 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3363A1D52FE
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:36 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a18so6681716qko.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPtgyZnR4VV/PfIz80V6wteXkyP32HnV4LWPjljQ3KA=;
        b=uwevkm7ziYW3hY6Evk6pjvItkf7DNmL8bDHmdm5lqwcy57W1f9nEzhyoKW8IKOYChW
         nUHDPF/6Z6Hy5xSKOW9WIQ+05m3Rp8VBfjaTbzoyktz33XRx54YlT0jOhcN3U6fGe9rN
         HJknJUVkl/WuH1WUi2eo9jAjeJGiD2rqSJWr182ORiyfqs6HhrTw9RxehtKFgGYzZKgZ
         YCdXiu2bgnmpGhwT7nSaINy50VVQACJhwqV9Vw+dBJK0e8zo4SdYA7VMgH/Mm2gz1GWt
         sRGNLe9RAO2EDfmVEQNb0jqTh9NTn7hmqCgiRZITFjx4EGPDbHtB4158okQ6E2Jk53wE
         q3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPtgyZnR4VV/PfIz80V6wteXkyP32HnV4LWPjljQ3KA=;
        b=sgcGsXTUBRRZEM2ibXn3unnv6anL+tmNkrpel0/nxca4/4SDdTFTKTuTP+YTCo509c
         xhWbeHmAMHyUgBj97xRrwRtpFalfwdP7bM6HQxoz7uwcW/vzm4p+EPbQY9J/d73d5SPU
         kpvCYagi8TMew9L/d92IZmkfffTWmn0CsXQW7oD8T26VmnegWeoY6bj1ZIUGpRZ/DeMy
         6vjnvONZ3lbt133/dKPBDZKNRaf9sshUbCNJ6O6VLPVZAZ7SrHccBpOIKn1LmwUawbUP
         r7n/qjbVT8pawuseQHpp0W8xGIfMJfRQcwT7Oi9sQERS9vX2P+pHZf303U5f7CWL0DVY
         L+Tg==
X-Gm-Message-State: ACrzQf1kuUGzb2AiWQDRgllbtT0BxXqXCuOv+udLqJkopxP9KGNegF7P
        fWGC5g/aDwizK2yY/uircHixSCJuNjffWA==
X-Google-Smtp-Source: AMsMyM7kAkYx02FYKxs32sMEunBiyXm78KgzgYGVczVmnhSyUulB2WqNF80A39Qleb3HvcQx7uYCnw==
X-Received: by 2002:a37:557:0:b0:6ee:790e:d1d1 with SMTP id 84-20020a370557000000b006ee790ed1d1mr24178589qkf.118.1666637229103;
        Mon, 24 Oct 2022 11:47:09 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a414700b006be8713f742sm484525qko.38.2022.10.24.11.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: remove extra space info prototypes in ctree.h
Date:   Mon, 24 Oct 2022 14:46:55 -0400
Message-Id: <16235747b1fd12c8839253cad6ae6e31cd126170.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are defined already in space-info.h, remove them from ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 805c36f1bc2d..32c3bd724bc9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -558,8 +558,6 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
-void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
-
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
@@ -576,7 +574,6 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 
-int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 int btrfs_delayed_refs_qgroup_accounting(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info);
 int btrfs_start_write_no_snapshotting(struct btrfs_root *root);
-- 
2.26.3


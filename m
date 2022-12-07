Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA063646415
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiLGW2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLGW2Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:24 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629B42F64
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:23 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id fu10so8902649qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iqMaeL2/3iIa7APep2tYpwUpwF7cWyXv1iyiMsdJsQ=;
        b=iVzwwZ5LzPqYgYZWpdWK/ropKSLqFrtYKvi19Zb3wGqtcqM58lFZdeVwhlOTjVZ8Qg
         cKvyUlDOUUysFjX5XFk3BmYWOSaNrib+cdgR+UqAa8FX8MwCv4VRNxqpZuCnKSqJhs/D
         DeDbkQcxngVDMw4WChr8nNb/PDbFC8ubcsyYtvBUBQe1gp4IIsIi1eTGVgHJ9ucqph/E
         8B57wX35UfsuYIDEQi8k0w3kWBuHLTFti1G2pVlaybc4XX8DStJgvWN72wP2LRQDYTRs
         ZhewHXu+1O0iqrQqCw5idDOA33XEEgmJr4c58JtCwtfW5evoTTDJHVA72zOn33YST2gj
         6CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iqMaeL2/3iIa7APep2tYpwUpwF7cWyXv1iyiMsdJsQ=;
        b=4ejJ6TAqmHyLVLS99ywvA2hkgZiLxqbrhoRPH+gEyOx+80oocjQf2MBQ+T7zwzk73l
         JM1UkC9rKqZGAy/DiL6zE7mtHr8EhaTd920KS+pXIT3t3AuehmPD/wXMNvCX/K0UJhk3
         AR5PFJ/h5K8ikO6cP1QmD39xYwH2Rp6c4cOJSlVqoeo4FerMJdckzaPg/s8sHhIL6Hg/
         o0bHBVfRrkpEv4PY33/89B1W83s6n8bV5qIPNacGVvMNuIeOBr7QLbJjdtMtr2Mj1CGy
         cfET8ixtW68RTOlMhcOrja8YU4tC9/ESHljK58jdYO5UgOlgCE0TbPyjVhQ8Et3iS3MQ
         P3PA==
X-Gm-Message-State: ANoB5pmUkXG7GTczP0Iaq/KBnLf34v4AaNz28P1EwSutQVC48ebyUcIL
        znNi+FBTIXZiyHi7sF5pyl2sjToSt+XZ4MdA
X-Google-Smtp-Source: AA0mqf53TIE0iOrRxVoiZUYmL7IczxYBv1i/xf8JNhANaUIg23pmjML3pHG9729c+UP6+hrwMvkRrw==
X-Received: by 2002:ac8:5392:0:b0:3a6:a8fb:245c with SMTP id x18-20020ac85392000000b003a6a8fb245cmr1540930qtp.41.1670452101706;
        Wed, 07 Dec 2022 14:28:21 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g9-20020ac80709000000b003a7e8ab2972sm4821200qth.23.2022.12.07.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
Date:   Wed,  7 Dec 2022 17:28:08 -0500
Message-Id: <3e7e31ab27e22d2fbc76c9cd44924b8de88f43b5.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
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

We only add if we set the extent buffer dirty, and we subtract when we
clear the extent buffer dirty.  If we end up in set_btree_ioerr we have
already cleared the buffer dirty, and we aren't resetting dirty on the
extent buffer, so this is simply wrong.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c87be46e0663..7cd4065acc82 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2467,13 +2467,6 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	 */
 	mapping_set_error(page->mapping, -EIO);
 
-	/*
-	 * If we error out, we should add back the dirty_metadata_bytes
-	 * to make it consistent.
-	 */
-	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-				 eb->len, fs_info->dirty_metadata_batch);
-
 	/*
 	 * If writeback for a btree extent that doesn't belong to a log tree
 	 * failed, increment the counter transaction->eb_write_errors.
-- 
2.26.3


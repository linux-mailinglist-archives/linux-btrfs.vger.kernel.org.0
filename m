Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2599C67D71D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjAZVBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjAZVBS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:18 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B41C4A1E8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:09 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4b718cab0e4so40448237b3.9
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iqMaeL2/3iIa7APep2tYpwUpwF7cWyXv1iyiMsdJsQ=;
        b=6Vw7XA+WFa+m8oBLm3NrUwpez50KrHB2n8kvvEXcko5eILHN5vCTGrZ6Ez73Cxm4B9
         W1Jjr+eN22uPLfVYHv2kR61tNwX7E8wqhWDksJLoQU/zrXnJ5lKoa+5d7rczOyUCdh6v
         d7X+qY2YMaWGCxaq1xAsGzvbxypnKrnmTWXp/i6BFkMSMDFHEyWZE3Stlybqyt5jgAFC
         83iPf+V6NSKKdjunKOO5y/soIjGuxzl0cmDBMaW5aO8ykcLg5qy/mY//B39ms5+gyucr
         hU67NW94lAnJaaHdqgi/d/NJSG7NajfIsp4KhO2CM9/5GpRARm3yzqTfVvCrDB3ka6EY
         3AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iqMaeL2/3iIa7APep2tYpwUpwF7cWyXv1iyiMsdJsQ=;
        b=hFgUGHuzWDGwBm1+B8zet8OINr0n+PlSF1CLMGBaHN8emH4iEN0wD1+ZlE/nVTFRjE
         5yc1pTPh5LTS5qk0cCaJHgbeCVau10CV6Ra9oSyOlpyvivad7+OHjMYOj0rnOjyHxttF
         yc8iQfu4RQ04J5EvkigXH8SJWJVteHkF6/m9NKCTadZz+W8lobisbbSe2+zqBBJRbaYP
         Kvm+dh4JSiCNKsM3jVT020ZjdxXsZ1I0f1srmFUWpLQzRBixQ9yWyB41DzKDi5C1CNvL
         ww3R/Utr/W+tlAndbarTodV83tKh5Vr3wkdVioE44e43SP16zLv8D8DylSAb2dluyPLr
         xUVw==
X-Gm-Message-State: AFqh2kpmfghgnEQxd/1hIfwC5MxKJyBu++9DcVGf2TaYG6gKTIvRR0hW
        8XYJL6Hc4oinKFlKqTUD+uwcHi0bhN0w31URmSw=
X-Google-Smtp-Source: AMrXdXuFb7E7mtGj1nRQt8QipIQvqBl4BaWvzd43TPvAZlgNaJ///62pVf6ocae/itOb4YZpvBRmdA==
X-Received: by 2002:a0d:fd86:0:b0:4c5:2b26:8cee with SMTP id n128-20020a0dfd86000000b004c52b268ceemr27390501ywf.13.1674766868082;
        Thu, 26 Jan 2023 13:01:08 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c139-20020ae9ed91000000b00704a9942708sm1592097qkg.73.2023.01.26.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/7] btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
Date:   Thu, 26 Jan 2023 16:00:57 -0500
Message-Id: <f31715dc14fd4816b0e05f88bcf297024c31c90a.1674766637.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
References: <cover.1674766637.git.josef@toxicpanda.com>
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


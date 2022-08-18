Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56C597F9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbiHRHzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiHRHzl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 03:55:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6DA5A89B;
        Thu, 18 Aug 2022 00:55:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso2193139wmc.0;
        Thu, 18 Aug 2022 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=N8163GDxT/V70KLJ/27Rndv21wKXDLINtjwcMLb2kOA=;
        b=Jdd9X9K+VkVBPE+9TBX1m+lOy5EdIcVIIYm/gJLhd22iEKZTqgyH6JgCSDZumjVMM4
         orEaVkVr5L/FhKSueIwVQIeghAVaNROoFnjZELWJujqKYJym+eMkT2B0nW2YeX07QHFm
         yuyy9fY4r8LdDeco3SRyGIwNFdzEd6Q1C8rxa9xVTHaIO/0caJvWOi3ONzkh0v9V63pN
         /aam/EqPMvUkJEjeu0dYHDkGrwEjifDSDQts5ywuf33kQODKK6ji1xvIcjozoMUzhOQz
         j4LOAMMsy2elIO0M5lycE+3b7uCLSjmmbKuCKRUm73hdp8SpTVPcJbXe8eI/DRie2RbT
         rwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=N8163GDxT/V70KLJ/27Rndv21wKXDLINtjwcMLb2kOA=;
        b=gtEl+ZvYhiw6iwMhpJkB0z9l/Ey8zvULVD8X9ME8nptXZt8/V+FNVaUxIx0B1VIA//
         wxOqn6jl5QaIOvpIrbwJP/1yZuQgPU2NYTLmvOHC2kiWixxkDKWDawN1WknnJz6QOXd5
         CNv29GAwy+JSk/9VKJY5HhpIDp+F3xWuizN+niRhKhwokUM2+H9+k6Q+VRjntgL+4k6M
         07Ee7xIgRfDOTokxSSXHTMpyWiuy9RmXVfDheKkgSsYUvCRpRTSOpOn/KeFhsdPyNxF5
         xgWbE40NDJHQYjNlizthPkhlbz2VSwMGtidY2p5Znypa7zOyK380h2f/ivYlU85hlOGx
         HuZA==
X-Gm-Message-State: ACgBeo0WxlOMWQHLXWZSo363nWKp/K/6xddxm6BTLp6oEprFJ05w9AWN
        +wWVHTwhycD/Y3EXDxcMiIk=
X-Google-Smtp-Source: AA6agR7TsG+ox8UNe7WR1JIRWeyTOZdcW8xXglKJt+5UNt/Tj3yrnuAzIK0GhjF4XKQaRDLerIZthw==
X-Received: by 2002:a05:600c:2cc5:b0:3a5:4fae:1288 with SMTP id l5-20020a05600c2cc500b003a54fae1288mr4316159wmc.79.1660809338692;
        Thu, 18 Aug 2022 00:55:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p22-20020a7bcc96000000b003a52969e89csm4448559wma.4.2022.08.18.00.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:55:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: Fix spelling mistake "deivce" -> "device"
Date:   Thu, 18 Aug 2022 08:55:37 +0100
Message-Id: <20220818075537.117851-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a spelling mistake in a btrfs_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/dev-replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7202b76ce59f..773f1caab126 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -167,7 +167,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info,
 			"replace devid present without an active replace item");
 			btrfs_info(fs_info,
-	"mount after the command 'btrfs deivce scan --forget <devpath-of-id-0>'");
+	"mount after the command 'btrfs device scan --forget <devpath-of-id-0>'");
 			ret = -EUCLEAN;
 		} else {
 			dev_replace->srcdev = NULL;
-- 
2.37.1


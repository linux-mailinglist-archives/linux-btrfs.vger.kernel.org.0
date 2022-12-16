Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7014E64F239
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiLPUQG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiLPUQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:04 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935D36C51
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a16so3577292qtw.10
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxrdrp2AQBozx+ibU551s3/U4/ft7JusEwx9n/BiA4U=;
        b=bXMfWyDkRf2AHX/gWGBwFZfir3IuAoOR0Nrv4pYMIWs8OrCWM8PRQHqFd/ADaJIoah
         0mRvj6+dGi+2Gdjhj1LzLoyJaIx9NeXeuFawtAOsC5hKVzF2DnjQD0GoulqoQj79BL4P
         cfRmdoDER22R2jJ97Ey9E9a5C+a7MhuCWfAdbHF+ZcPl1CRDih151doz5uKsqEt4ovl9
         3V0PfVyieaQAA76Ku6xHye52KG+PkkE1hV0gIWtIJrPx8qOMhCZhE1Buf6x5/6tGdSu6
         Zl2Aluf4DDpRI8azmmT3lXqda6RuZZ0/2zHMyzbOqUkim5mBx3F8DKBgFzS/oS4qT3n2
         Z8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxrdrp2AQBozx+ibU551s3/U4/ft7JusEwx9n/BiA4U=;
        b=KbUs6OptzhtvuZGyi6umQNQIG4u45Fy6p8/qvW1wSWz3r8yIMaSnAqAv2TnrxRIhsC
         1auoYa/3QPqfmYuj9HJ5vovCb7G/vAfzS4naDlb9DvQaPcPFMWjEgKwM1LotE1BFSpBF
         cb9pjPE0hax/YOPml65W/4000NG1rZhRmuJnox6cIp9knq8oUYRU1NPCeJbjt5kKE6tj
         flOXnxj6okOsJar9HVAxWEpxV2j4rD0IancSyoxqQ3m+OFk2hQlZgcS1rSLFgvmE0gQi
         hr1Dk1CqwklRPU4zhBrlT6P6bHl7ZvWyb3UOqvT2UHV+y4bPS3ZjN2DMKDY5bGEzsOfs
         yGcQ==
X-Gm-Message-State: ANoB5pnB4Xr+0JI456k8abrxiCeNopuQS9Uns6ActpGWUKc66IN6pUxZ
        oDI7Pym82JQ3/oWhGwr+zzVG8sh7M+Ix4lz9nSQ=
X-Google-Smtp-Source: AA0mqf4F2vJQ0VlVEvcxLq2SWtSRhjM28Vy6SngULgARQTsjIErWKyOh1f9d7bJdz8RHBYGddUmvCg==
X-Received: by 2002:a05:622a:489b:b0:3a6:4e2f:eae7 with SMTP id fc27-20020a05622a489b00b003a64e2feae7mr47904233qtb.10.1671221762147;
        Fri, 16 Dec 2022 12:16:02 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85151000000b0039cba52974fsm1771066qtn.94.2022.12.16.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: fix uninit warning in run_one_async_start
Date:   Fri, 16 Dec 2022 15:15:51 -0500
Message-Id: <5501d33f6ac5af3f371c8734793baeddcde75b4d.1671221596.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
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

With -Wmaybe-uninitialized complains about ret being possibly
uninitialized, which isn't possible, however we can init the value to
get rid of the warning.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0888d484df80..c25b444027d6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -693,7 +693,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 static void run_one_async_start(struct btrfs_work *work)
 {
 	struct async_submit_bio *async;
-	blk_status_t ret;
+	blk_status_t ret = BLK_STS_OK;
 
 	async = container_of(work, struct  async_submit_bio, work);
 	switch (async->submit_cmd) {
-- 
2.26.3


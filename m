Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84B16C7631
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 04:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCXDR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 23:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXDRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 23:17:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660BB476;
        Thu, 23 Mar 2023 20:17:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a16so396931pjs.4;
        Thu, 23 Mar 2023 20:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679627843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oE8IT0eGLP+ltAmGkmnTbIjUwhB1iQPb5PUuFNWEi9s=;
        b=Pp3xF9Mhs/4s45yE2SBIVEuLySI+7hw5n3scAveYYwy3B21GGwAKMSU6qwEmOKh3WA
         WKYNY5pftKtyDqtRQnkBBSbPUatg3CMLkXWufkLSDCWF8odKTX4ZzHlTSmzJT2aDtuCE
         Y7b19A1uPpy3HZ+uBZUqpxFX4hJlEUwdEcp6Y6dx8/jH0oi7RC5ycbjgX3DtDGOofjxk
         22l8IAmUkmCBPvbdr/i0Okevx8cL9SKiuo6sMhS9Fxm51uw4qWmVKoFkGbs+A7B0obRY
         hq43UkLNgYGlkUIVjA+aO3Hpdy1EiG+jtuVKTJuvlwhA5eW8HUWW5+12N8E5IWnxWOH+
         T8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679627843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oE8IT0eGLP+ltAmGkmnTbIjUwhB1iQPb5PUuFNWEi9s=;
        b=mAsP8eoykR+O5Afvay5QN2WJCEAcEZGvVswQpQyMqLEfVoyKARRVxaTDmo5TGwHxw+
         6igwcf6aAsj3zFZXBTqenjE3G8EadoxIuSl/v+ch4DGChO1sDb8Sstf6r8DNHYWU0Mbr
         9J9BHTz/p06Lj28e+KqPRGUrOjH58A9gKStblLSCyuFJN/XCX5c19aK7cH9wnFBzUdb7
         MGlSZAr7dDPy3lyX6/WRie5gVQ0iE7wSOsdDiswu0YHBVGv1SsysvpDEjeFUmTT3611q
         u51esAQylR3nDSQPqAc2hSkXdJMWUYXsz0EU1m73Mpx8o4m4YQ0VUIlD0jdxe97x/JAl
         8igg==
X-Gm-Message-State: AAQBX9cLadgGxkijay9gIKNUr7KF2CpWn6T0QAnsoV/aZeGPNEV7UFb9
        hGLhrNPwWv+3tnIH5yjnaco=
X-Google-Smtp-Source: AKy350YJdGQw0BVjrs2To1PdWcsP2zUH4n7egCn+AwfaKoeoRP+uhcW2oB4ECvCQtq3GlK4zy3w2qw==
X-Received: by 2002:a17:903:120b:b0:1a0:42d4:e38a with SMTP id l11-20020a170903120b00b001a042d4e38amr1624786plh.11.1679627843131;
        Thu, 23 Mar 2023 20:17:23 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902ab9500b001a076568da9sm12960984plr.216.2023.03.23.20.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 20:17:22 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@gmail.com>,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: [PATCH] btrfs: ioctl: fix inaccurate determination of exclusive_operation
Date:   Thu, 23 Mar 2023 23:16:11 -0400
Message-Id: <20230324031611.98986-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

with fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD enter
btrfs_ioctl_add_dev function , exclusive_operation will be classified
as in paused balance operation. After return from btrfs_ioctl_add_dev,
exclusive_operation will be restore to BTRFS_EXCLOP_BALANCE_PAUSED which
is not its original state.

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 fs/btrfs/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a0ef1a1784c7..aab5fdb9445c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2629,7 +2629,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 	}
 
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
-		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
+		if (fs_info->exclusive_operation != BTRFS_EXCLOP_BALANCE_PAUSED)
 			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 
 		/*
@@ -2637,8 +2637,9 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 		 * change the exclusive op type and remember we should bring
 		 * back the paused balance
 		 */
+		spin_lock(&fs_info->super_lock);
 		fs_info->exclusive_operation = BTRFS_EXCLOP_DEV_ADD;
-		btrfs_exclop_start_unlock(fs_info);
+		spin_unlock(&fs_info->super_lock);
 		restore_op = true;
 	}
 
-- 
2.20.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE08636D46
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKWWiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiKWWht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:49 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6318B09
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:44 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id df6so10894932qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=Lr1qptCGSIGEkSSgjJBv79AiYMNLXg6HMU1faBH3c40me0MnpXvzRXuFmUC0/qs9BT
         8fpksKg/arEZUF4S8UQYfDD+/7lEVlBD4aEY/qP/hSESAOV3ZVN7ftL9eHqFpoYNijns
         6cZwPLX6U4Z/d4SXaPw1PY6YKwZZ3jpc2SLcrUzD8lei1l421qqbBRlVee3EQjZDFuOm
         QqhgQNsdLrb0mMxljPU33dsSWgALsH81Ow4xRQ+NFAC6lD8/vAZ3J4s1W7wV34WSc+cT
         R9/73eZjPmtqOTqL/9QHY6LSxO+Gh5UWCbWlbUFwdddJToLmqJc+GQ32bIeQLhCAh0wA
         qEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=fFav+GfnB5MoTAXrHVnuj+PYkH4ToVR0O8VW8HVzCXuOzWo0ig7kz5IPw2wLetTTOE
         PS2v8Qg0YWEzvNVpC5aSPmo9kSrL0dK16Ncdq924jyginkW7ZSuG9YQPjbwyJaiUlmhU
         ckJJGT3r/T8QDvTJ0jghQfGaytsF3infUcAcybrtjYM/gkCe7kVM2aFecfE+bHGqnetZ
         bPI2+fcKHXUvSdT4nblW5uxEk5KvL0fhPrglduZo/uqG/eOvrbTgj+9ZCH6IbuKmAAWp
         K6B/79vqPIFdK1+O/cQCyfFpvhRDSgSt65CKQpPSVOA+nB4uXnUNK39TqWwW/WJt5K0w
         MdoA==
X-Gm-Message-State: ANoB5plomFhqdzDGWfJkQ/rVSVTowbFKwT7NNyGkOZmScFCotFFT+czV
        6b+0+hs83kXQHcXFNugD6vQuEAlUflcbKQ==
X-Google-Smtp-Source: AA0mqf7h7CqRvgzv7wmfc2yabimJGvH80vznIRK0PWeDqCrE2pQxVTCGgmhlfh1tgdzlY93kYUlAlg==
X-Received: by 2002:a05:6214:3981:b0:4c6:a9fa:47f7 with SMTP id ny1-20020a056214398100b004c6a9fa47f7mr15751088qvb.34.1669243063456;
        Wed, 23 Nov 2022 14:37:43 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y10-20020a05622a120a00b0039cc64bcb53sm10460712qtx.27.2022.11.23.14.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 03/29] btrfs-progs: properly test for send_stream_version
Date:   Wed, 23 Nov 2022 17:37:11 -0500
Message-Id: <e7ca4d3f79485396cc1e2d7e8d635983a1c2e2a9.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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

We want to notrun if this test fails, not if it succeeds.  Additionally
we want -s, as -q will still print an error if it gets ENOENT from the
file we're trying to grep.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/misc-tests/053-receive-write-encoded/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/misc-tests/053-receive-write-encoded/test.sh b/tests/misc-tests/053-receive-write-encoded/test.sh
index a3e97a73..74b745ca 100755
--- a/tests/misc-tests/053-receive-write-encoded/test.sh
+++ b/tests/misc-tests/053-receive-write-encoded/test.sh
@@ -11,7 +11,7 @@ check_prereq btrfs
 setup_root_helper
 prepare_test_dev
 
-if grep -q '1$'  "/sys/fs/btrfs/features/send_stream_version"; then
+if ! grep -s '1$'  "/sys/fs/btrfs/features/send_stream_version"; then
 	_not_run "kernel does not support send stream >1"
 	exit
 fi
-- 
2.26.3


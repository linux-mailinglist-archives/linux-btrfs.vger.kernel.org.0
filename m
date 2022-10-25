Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0404560D4F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 21:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiJYTuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiJYTuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 15:50:06 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363E1CFDC
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 12:49:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id t16so9518448qvm.9
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=jEhbQpD12JkuOSUkInOKTMOsvWmiuROCy5PZO1W0lBfPe+RtBISqN/WFvLIwUwgQDI
         /Z3LSH1/7sPFPnPjhLMmKDYCzJDuSMign7StMPSKp1XWnm1uSFHuUeAqnkmKQpoCJWZ0
         OdUEJ/3UMGAHdk+77cD9EerkJgHCnFp6Tdl6d8JZTlvpOIbGTeTUNh1nYJgyg1BvTZ3r
         wd6wO8Lym9sOheMBXKJRsDFK7s/YEoxCVPflEtVqOlIEQMgnfL66wDFJ1/EmBmmz38qR
         Buojse8hNT11j+InmXp4OvgzZBVUTygDo3kynh+oyng+MkhFszkIFsBws9c418mlbd0e
         TNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=ABuOFuSWW2CNJP+82mabgVStqXH0NrwuN+1phTLt4Es23ALeZHrKIFhez3u7Q5Gx30
         f0QU3t9OgxtBiA0pOmTV74AyYSzCiCm5hKj+xc2b1kx5j73h4nFlgjeN/3sSHW+Hoybb
         VgeWTv0Y88IycHnSlHWnQsZ59VKoR7DEGbtCnj5jTRrCzZbxAwRDpy6md+5pGttVrjla
         9E5nESfDQNqFVppx5RXJd1wgdx5HCd2WyYoIHcXnytRP4wBN0LRWwsUOk51ez9HkIs0N
         hhXWqBXrogCfnfDzV9CA0+j0Okamf3kljmlK8wX12c0mZFnuwNuFqaTLkIAoLB5GqFYH
         X20w==
X-Gm-Message-State: ACrzQf235+q0CjPZehYDnQFDKQhgQmI9du8zVb8ycBZyT7z6Gibt8TaN
        YX4ND3O9BSgK1aC1zrx4MK4gy4WxhQQEuQ==
X-Google-Smtp-Source: AMsMyM5T7+iv+0l+gtVZz8eakMO4ruKV0YEyVtPgOig7iZpPdQMsvxP2XRjylxlL2kUL65XNyqtdbA==
X-Received: by 2002:a05:6214:27ea:b0:4b9:e0f5:22b0 with SMTP id jt10-20020a05621427ea00b004b9e0f522b0mr22920594qvb.26.1666727398356;
        Tue, 25 Oct 2022 12:49:58 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id cf9-20020a05622a400900b00399fe4aac3esm1845643qtb.50.2022.10.25.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:49:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: properly test for send_stream_version
Date:   Tue, 25 Oct 2022 15:49:56 -0400
Message-Id: <e2742a8d9f88ccd7d46086dfff5d861579abfa0a.1666727387.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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


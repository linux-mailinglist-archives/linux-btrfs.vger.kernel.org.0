Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4535907C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiHKVGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiHKVGP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 17:06:15 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A94792F6
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 14:06:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b2so1716787qkh.12
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=APj8MMArpCNZSn8U99XLcYIOtF6HIPreubb2saJ1CKw=;
        b=A4D1XeO0rFML+SrBygFJs5p+jwYJEmcXSQPsuf5TQlblPtjg9M51rliiuhK11Hmcz4
         0pJoYzK73TP5MpJ7YMS/fiZNv6MKpbfgoK+9N2TnzrFAOH4jwbpvmEmvrzcw/A0UKkY7
         NVww2PqhQxWmaUKTY5XcDmUtLfV574m4GtoP8ioQ9dkSOy4wcjMyTnKYzvYO3AybR/Uy
         GSaIA0VvK4XuT9dgoMOyx8yn1+ymSM3n3rkIREgLApKPc45EECxod/BLEp1JUfes8Pex
         bAGNApAYwJ6Pp4voXm09qvKQssIjaitfR28RTnk9ld4NmId0LXohk8En7kruTUISItJh
         bsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=APj8MMArpCNZSn8U99XLcYIOtF6HIPreubb2saJ1CKw=;
        b=K3TaaIA2evgS+XhqA0vqLXnN7Pmg34H3SRVL9hRjNoJn7pYJ+YSiKhpWE0Ux2PEDNE
         zSp+vDt6wEZc2Ksn0pKdMyWX0Oc5cl7YjjloVxX3BBe3vI2574t+iPB60fucRWMoesRI
         8FZUHmD0WFkE7Q+vBSZOn2yRViAmGTKQNlgrgvPkEhaNGVikceIA6oCaez3Utu1QYoLA
         EyYAxQtGxUmFmoRSY6YbTLrNMVu4BggpdGpWapL7EUhoS47XADNh5D28A/YYS5cY6T+r
         42xYuh5RgRPVv9b8z9jh0wLp9JHikcdy1Wh0m+m/oOaQmb1p5+OHR6bmzUSYB191eqO7
         L+YQ==
X-Gm-Message-State: ACgBeo3D2GsyqgS2s8tRtfLoE1H7aUJKj6taJ5Bf2HxsIanbOuBFBYIh
        IVmUMrRkeGy4Ylojs4BC0UGTFqx3UTCUeg==
X-Google-Smtp-Source: AA6agR7WY9QZ+ugm9tROfbDE6eQxqkazaOKaqKCre0hMk01pJ27H/XuS9Q4B9Nf/gXynQYXSnE08vA==
X-Received: by 2002:a05:620a:294f:b0:6b4:6915:f52d with SMTP id n15-20020a05620a294f00b006b46915f52dmr679630qkp.159.1660251973486;
        Thu, 11 Aug 2022 14:06:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b0031ef67386a5sm281207qtb.68.2022.08.11.14.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:06:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Dylan Yudaken <dylany@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] btrfs: handle DIO read faults properly
Date:   Thu, 11 Aug 2022 17:06:11 -0400
Message-Id: <552156d49d65ab7d635554b697252fdbfb8f93b0.1660251962.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dylan reported a problem where he had an io_uring test that was returning
short DIO reads with ee5b46a353af ("btrfs: increase direct io read size
limit to 256 sectors") applied.  This turned out to be a red herring,
this simply increases the size of the reads we'll attempt to do in one
go.  The root of the problem is that because we're now trying to read in
more into our buffer, we're more likely to hit a page fault while trying
to read into the buffer.

Because we pass IOMAP_DIO_PARTIAL into iomap if we get an -EFAULT we'll
simply return 0, expecting that we'll do the fault and then try again.
However since we're only checking for a ret > 0 || ret == -EFAULT we
return a short read.  Fix this by checking for a 0 read from iomap as
well.  I've left the EFAULT case because it appears like we can still
get this in the case of a page fault from a direct read from an inline
extent.

Jens tested this patch with their testcase and it fixed the problem.

Reported-by: Dylan Yudaken <dylany@fb.com>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c9649b7b2f18..a61085ac59d6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3776,7 +3776,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (ret > 0)
 		read = ret;
 
-	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret > 0)) {
+	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret >= 0)) {
 		const size_t left = iov_iter_count(to);
 
 		if (left == prev_left) {
-- 
2.26.3


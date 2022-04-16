Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0950351D
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiDPISW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Apr 2022 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPISU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Apr 2022 04:18:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2A5F83;
        Sat, 16 Apr 2022 01:15:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso8692431pjv.0;
        Sat, 16 Apr 2022 01:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVfFJCMkrWLbyYUJOBj2PVHo9GdUj3rw5BmoGxMpBoo=;
        b=iYCJ6Wum2Xv3OfVJqUjKKcIs4chqAe85/Ts0gdvaAhPlZcypz00oeX4nApt4uQ/IQM
         Z/kGU5mHBZSb9cwIXqhlKJgLGbDSgyzXjte2f83Epit+PxLjJ4EZ5nvq6K/cvze/KLpV
         WP3hiWF5BvZLNM0yjBJ/gYWOXc/A3aPeK9627J6poVefhVN+uUJNUq7nPJwXA0/05YWl
         6XVvVYcQfJX6r08lZlHmq288j5fEPiyaUFTsEW6T8NT8d4Tgc14I/GLjt7eOXxgoSJ4L
         tTv4KdfEoFhcmfbHm0XMaGw71L4uoZs/A6XJWQxKMgIKzxkvnRWiZwFoKy3LIzcvIXLR
         ITDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVfFJCMkrWLbyYUJOBj2PVHo9GdUj3rw5BmoGxMpBoo=;
        b=xbT9YwH5mWims7iMY3SYveY/qhJFslcBt88dCfSZVaaeendUpEemHgBvFUjQodJ4p8
         tVPZxK+vPgxl86tZLqbewuPluW3H4u/eqrE+IxOJ1zkwm5J63zV/Bdr/wuPtlopy8IEa
         6GbzuqDu+a2fl2l1bAv91Ygrgv7AydazcvqBRFwIdYxENBDp6nwErHWikqM3Wlmt0BW2
         VTROZrcaeMoESZCwr+jvHEC9qB2zbufZz+suZMeB7L5fSYtAqULnnMa0cxQ0FN/7G/oH
         1tPIW9iZ5dmmGsqItpg4KZTbZLntlRwt6xOIjktup6TH1JYOT6loySTjGnyYZdxteoOd
         wZhw==
X-Gm-Message-State: AOAM532vcfNYmk0MbkBVCe6xAWN1qyl9Q7TMuSx+8wqcFQPSeeauoB9k
        PSx/Tbnd2G1n2n0R100Avkophv1Tv7tcKocu
X-Google-Smtp-Source: ABdhPJyMPbjlWbRSvxRImteK8nhcFkaxavzpAmXI8Nda6nL/B2Mb6fHzJYwRgmR8/Qxj1XUqk4txSw==
X-Received: by 2002:a17:90b:3889:b0:1c6:408b:6b0f with SMTP id mu9-20020a17090b388900b001c6408b6b0fmr2814842pjb.43.1650096947494;
        Sat, 16 Apr 2022 01:15:47 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm5513328pfh.177.2022.04.16.01.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:15:46 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, Schspa Shi <schspa@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: zstd: add missing function name in zstd_reclaim_timer_fn() comment
Date:   Sat, 16 Apr 2022 15:15:34 +0700
Message-Id: <20220416081534.28729-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel test robot reports kernel-doc warning:

>> fs/btrfs/zstd.c:98: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

The warning is caused by missing function name (in this case
zstd_reclaim_timer_fn) in the comment.

Add the function name.

Link: https://lore.kernel.org/linux-doc/202204151934.CkKcnvuJ-lkp@intel.com/
Fixes: b672526e2ee935 (btrfs: use non-bh spin_lock in zstd timer callback)
Reported-by: kernel test robot <lkp@intel.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Schspa Shi <schspa@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is applied on top of btrfs-devel/misc-next [1] tree.

 [1]: https://github.com/kdave/btrfs-devel.git

 fs/btrfs/zstd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68f0..b2740358e94819 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -95,7 +95,7 @@ void zstd_free_workspace(struct list_head *ws);
 struct list_head *zstd_alloc_workspace(unsigned int level);
 
 /**
- * Timer callback to free unused workspaces.
+ * zstd_reclaim_timer_fn() - Timer callback to free unused workspaces.
  *
  * @t: timer
  *

base-commit: 550a34e972578538fd0826916ae4fc407b62bb68
-- 
An old man doll... just what I always wanted! - Clara


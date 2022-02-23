Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB284C1B67
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiBWTHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 14:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbiBWTHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 14:07:20 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53433121C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:49 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id c7so5234645qka.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ee1C+K4NQAEUxI2Y6YsFAXFNc/Ka8gvsPzm13o8yE7Q=;
        b=n/UZYqfR+zTv9pWyU5KMwy56FSuyt2WwMJiP423/f9u2E2GoIL3r7T+d+6lwqReBuk
         vkQUof8ljQKbgjkhLnVwhIXy6f4M/m2hILzcVSNSzS0HW6sqZAiRjoQGybUxRrM5gtOb
         djsqG2MYs73gfeQlSqp0+3MYtiVcPHo1wMRjif2TgPlWQiUifbfilriP5TvqonNjOC4x
         Dx5hOaqnzZwDgOXIzVO1Ou8cpcICg93xTMgp3wPVywuuEfrA8/ueFkGGk7vRfxOcOg5V
         PZbm9g2NplfTYlRwJq6liY974YqjM6c1ZZXuUmh90chAToYiQjRg+8h2MetXd/nq2aN5
         bDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ee1C+K4NQAEUxI2Y6YsFAXFNc/Ka8gvsPzm13o8yE7Q=;
        b=SeckOW6zDjVilatKAJ1hiAA1Pz76h+WPkul0VTj0BnaL3CXY5hu1Vrvz0LRHK5SQ48
         LUvgtx0YyAJcRaDco2N9DeNDRiZFG1kSfT+PSWQEqqdBcvfAxyvUqIS/RnUgDYBhzDJn
         OQDYq/AMnpXezP+9cuGNbu3ziWPlCQyz+GFQ3IthTI55OWU9zXRIaYlc0J7Z3y1M7Pi/
         kC0EkmwPTBTaF4Q8SAlctxqb0LV7ZpZOi2E59OYeWrU4v0HlCEwn5PvBP5ipNElSdnCm
         olS2YCUaD+PDkgODh8f0fUfrjJ71YVzcNzUmNFnJPzIn+NknHBbtW11lXBXzZGFsXmCM
         JPYg==
X-Gm-Message-State: AOAM533E/MV/hX+L330kF3BczESvnGoBljmhGwTpp5wZ0Hb+Mh17oJYL
        1/Nk4eoUqKaAOcfEdxE3Fi89G0NJA+ptDhzD
X-Google-Smtp-Source: ABdhPJyjml+bVMIj9ZUkS/RuOoP3pMeBPNx1/UL4OwvO4LuVqgiWzoE4GCj0rtAu7UwluI326PKBNw==
X-Received: by 2002:a37:b842:0:b0:479:2ecc:e51e with SMTP id i63-20020a37b842000000b004792ecce51emr810026qkf.206.1645643208551;
        Wed, 23 Feb 2022 11:06:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l202sm196094qke.53.2022.02.23.11.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:06:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] btrfs: some extent tree modification cleanups
Date:   Wed, 23 Feb 2022 14:06:42 -0500
Message-Id: <cover.1645643109.git.josef@toxicpanda.com>
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

Hello,

These four patches are some prep/cleanup patches that I have for the next batch
of extent tree v2 changes I have queued up.  They are cosmetic, simply moving
some code around and cleaning up some old cruft that was left over.  Thanks,

Josef

Josef Bacik (4):
  btrfs: remove BUG_ON(ret) in alloc_reserved_tree_block
  btrfs: add a alloc_reserved_extent helper
  btrfs: remove `last_ref` from the extent freeing code
  btrfs: add a do_free_extent_accounting helper

 fs/btrfs/extent-tree.c | 141 +++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 75 deletions(-)

-- 
2.26.3


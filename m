Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457095B90CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiINXFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiINXFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:06 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4012F64F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id ay9so1655960qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=hZBQPQVAYJOitHUk4v87PNBF/5fF24yOlf/HPSTLkPw=;
        b=0lF2ick5HUvgcFC13yNSzo0Y+bM6bNJ1Gdgw7gOuGF9Iz7g3l+TAEKk3mwQ7EoXpFF
         /8LSFvS9ccPLXunFh4vojMeJvlfB9bJ0k0TBD1ubTbtD01FOmIjtxzkpj2nSZ6XmcN3D
         yJW/flmGa9YHzSYPEtDTaTdOrwL4dwJ3cG14NGb/xz7UP4s4nk6nuLSGElFCxPChAke3
         An4cBiZflRB3OCc4fYir/1BcBc9DO9dHwWkrVLA/M3c0OfbUxxQCKhAn60blQXLbTFlZ
         3WMCsHd4Ypn8YkrbYqxKpqNPFbnVhWOaQB9JF78/AA7DxahZB7CbacafS8cVAoB20gXK
         tL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hZBQPQVAYJOitHUk4v87PNBF/5fF24yOlf/HPSTLkPw=;
        b=ap383N87bomiW6m1NK396SF+mnookwy0cD/qj2KGOAj7AyE6sXtklKjhAmGyFqdSwO
         3F+2IPtnRLrETrtAFiFkGjAIJRQ/5Sehyy81E3NlM+sFNOAMAiORlW3c2mleOW0kNr02
         /mBwRy/mq67GtG5MKUxFTLUjB1bON9S4x7hFjiNXwnb7MF3cm52XoC89Q30TGTi0XHDM
         3wczG3XMaAeL/joOaJbLF09K0un29KHwXYzMTNg0aqqDeBJRg0miDC3L4DSaDc9LXiQi
         yMkdPXOoNG4rjoj8Xf15Eir9KvjV5SOat1Ixc+vVT05Veqx8fjDVhw7ojQLQRE2O+i3X
         dXgw==
X-Gm-Message-State: ACgBeo1pZOUZ5RVX2SBhNcu7ECB3WaSdZ/ucMzGRmA1+d+DktLfF3ZwL
        +b6Gsg4Rn/mTXJ/CNRo1DG9sPun58y9amA==
X-Google-Smtp-Source: AA6agR6N5Yth1CAM50J0TL0lWpcdZn1FKupgcPiG9XXYki7nysnD/XWnw849N3P+kKYXR9oZrxKMlg==
X-Received: by 2002:a05:622a:58f:b0:35b:6813:75e9 with SMTP id c15-20020a05622a058f00b0035b681375e9mr25195084qtb.650.1663196704186;
        Wed, 14 Sep 2022 16:05:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a12a400b006ce40fbb8f6sm2686309qki.21.2022.09.14.16.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/15] btrfs: move fs_info struct declarations to the top of ctree.h
Date:   Wed, 14 Sep 2022 19:04:44 -0400
Message-Id: <9506fef3a36ca9a740283dbf1df1f2d884cb732a.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

In order to make it more straightforward to move the fs_info struct and
it's related structures, move the struct declarations to the top of
ctree.h.  This will make it easier to clean up after the fact.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b9e848a22290..05eb0e994e68 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -46,6 +46,13 @@ struct btrfs_ref;
 struct btrfs_bio;
 struct btrfs_ioctl_encoded_io_args;
 
+/* fs_info */
+struct reloc_control;
+struct btrfs_device;
+struct btrfs_fs_devices;
+struct btrfs_balance_control;
+struct btrfs_delayed_root;
+
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 #define BTRFS_EMPTY_DIR_SIZE 0
@@ -208,13 +215,6 @@ struct btrfs_discard_ctl {
 	atomic64_t discard_bytes_saved;
 };
 
-/* fs_info */
-struct reloc_control;
-struct btrfs_device;
-struct btrfs_fs_devices;
-struct btrfs_balance_control;
-struct btrfs_delayed_root;
-
 /*
  * Exclusive operations (device replace, resize, device add/remove, balance)
  */
-- 
2.26.3


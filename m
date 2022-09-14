Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8021C5B90CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiINXFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiINXFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A533A1B
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id ay9so1655881qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=PldtfrkpRWo3KxAk3gI6jAkacJ64+J8f9MtlJI3vk6k=;
        b=nTGiFrdksDb3ClwPn66k6/YMJdocQvakp4IdnXfOVJe5G3IvlGhbPmz760LurSdDmJ
         pcLajH3X3uNHlwKepTSf/rcW1o+WRHJEwhF4E7qjBU1iGfjpC7oFexlRKlnF/JE1IYmJ
         6W4NbfcihZejSB38GTBg87x8s0n6DU/ZMTzctXl59iesEzLRUQW8m4ppGuOa+w76oBMs
         FKgM92SrGHxEbpgHvJquGD416yDNyOGU+bevgTHoI1JkE4hQtQ/0IpX+HV8ZybWE3UxE
         yBgV45FGH+cPLjGkRvVyX8mVU9YBydKyGS9umLzavHBRFXRt03IfY9LEPJXmgnpLggzt
         hh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PldtfrkpRWo3KxAk3gI6jAkacJ64+J8f9MtlJI3vk6k=;
        b=qL7IVt05SMxrMo/dY65PHaeykvt+jCki3Wu50Y6neva/kndVdVjGvLdfL1cffglYDo
         pJ23YAYEcoARQtGCOiO47X/eZf30GVdi81F7OLIbQ3XOut5ZDwM8eInAgtbOuaWfmf3g
         sMgfpolsg8nb74sbdnAMb7ED1H7NimK1KJEJJdvvQD+JY9Y/E6+D+DLyejym06GMkpG6
         GcyMbLwQ5pvwOeI681vzs/2b+0yNNJN7QoqEHHUkZi4CiIcw2GYPrgvw925Rckmf3691
         13b/hEV8ooZiNgcK0kQeyyUdnswIdUz7fIs4nhEdVd+TggQ8kJPcwyzke6m+//ygyCKw
         d5Ig==
X-Gm-Message-State: ACgBeo2jZxryfq+1YoIahTbbj6njLG0R8Ha8+R8C7j856u74o9bxSB4Z
        XMx8Np4tv30mZaavaEdqITKKnQ6U7IaO6A==
X-Google-Smtp-Source: AA6agR4i7RZSaLXWurlomwUvl81uojKHP835YuxCrOHOjgyizOF6I+ME3bJBVfNCU6QQoHGBxoA49g==
X-Received: by 2002:ac8:7c44:0:b0:344:5653:df43 with SMTP id o4-20020ac87c44000000b003445653df43mr35064981qtv.359.1663196700444;
        Wed, 14 Sep 2022 16:05:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a2a1100b006ce9e880c6fsm1173207qkp.111.2022.09.14.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:04:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/15] btrfs: remove temporary btrfs_map_token declaration in ctree.h
Date:   Wed, 14 Sep 2022 19:04:41 -0400
Message-Id: <cada813eb22ef6d856d17c15d4e4e5d883b38bc8.1663196541.git.josef@toxicpanda.com>
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

This was added while I was moving this code to its new home, it can be
removed now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 36a473f05831..a790c58b4c73 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -46,8 +46,6 @@ struct btrfs_ref;
 struct btrfs_bio;
 struct btrfs_ioctl_encoded_io_args;
 
-struct btrfs_map_token;
-
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 #define BTRFS_EMPTY_DIR_SIZE 0
-- 
2.26.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAAE604A32
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJSO6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiJSO5l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E4BC6962
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a24so11780196qto.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKQta0HBGWzfonEHtISYSlTd/0kvcw3vIJGc0uHX9/M=;
        b=ljFzzzbN/vLscVM5jyQgub6XMUhRlVe0bBYEb8OWlBbAFmtBVJmQAQutSbPUMBwSAH
         +CQ66sRtkrswwq99mv+P6YADejIJ8kg6MgNlqQztA9MoKlRb+NjOyozeg5vpngJSqiqf
         vCR7a3FrhBzF/3oZHp5e9V4WTLro4o0Buhxgn/F83EJTPoX3UQyB9WOn5Bf5RYWuue2B
         AvXNtgk0ya15sYJsiHLfaD2odW8wZtH4yNPVvqXVX9M76SkMRIGsKsssgyFblGHTSL6A
         qvd+AbOIPXKMTgjEDMvydooEJC7IIzDTCF+nvLTLN/yYVH7IJHwxWAfyVif3buWeeKV2
         KXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKQta0HBGWzfonEHtISYSlTd/0kvcw3vIJGc0uHX9/M=;
        b=R96+VW/+5iZ1detv5RArVQeLwXjqyRJE9y9r6b5GF5c56iqXd7q6/e2F7Mjbolptw2
         70otvHkY55Syb9aZaIG5oarb9XDv18ZkGzVe+YZ6Pv7GHPDUYNZNESQQvNL5SB7Myzn/
         QlS8vGRDhdpFlSUDHxxhHuUYMfLpdZcA7cRGIYjCqp7qHNLfCZ32e+nayl8MU9crA2Ej
         X9tDF9fznpeB/UyAi+Zp/mVQO89bznNCNk92IqBYKPzMYgX4Umz3XYABEYFH+xsLpBVx
         c6DZQLtln1fWL/eg3Y3m0dIYSuKDmwunGZ/68/JSK6IBuHF6Fk9I8MJC2GYNHGvdUFuT
         UylQ==
X-Gm-Message-State: ACrzQf3zWPxqrHZeF5agK29nE5a8d5AJYthkLR+uwQXUpkne50rcgoGr
        AJC2OVoDiuWLAl6forGmPqf/FGZJmD4JqQ==
X-Google-Smtp-Source: AMsMyM6HSWD4msepOv7ky2p1vihqfzDKsVtZbL4Fd+vMW/r2hW+70J3TBS0FaXFwEEEn+0tjs4yVqA==
X-Received: by 2002:ac8:5b90:0:b0:39c:e9b9:c002 with SMTP id a16-20020ac85b90000000b0039ce9b9c002mr6731448qta.3.1666191084211;
        Wed, 19 Oct 2022 07:51:24 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id he7-20020a05622a600700b003972790deb9sm4096556qtb.84.2022.10.19.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 15/15] btrfs: remove temporary btrfs_map_token declaration in ctree.h
Date:   Wed, 19 Oct 2022 10:51:01 -0400
Message-Id: <5cfd74155b651c5a4305511e59c3aa1f20090293.1666190850.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

This was added while I was moving this code to its new home, it can be
removed now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fcf809ca5842..1da8f1579e4f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -51,8 +51,6 @@ struct btrfs_balance_control;
 struct btrfs_delayed_root;
 struct reloc_control;
 
-struct btrfs_map_token;
-
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 #define BTRFS_EMPTY_DIR_SIZE 0
-- 
2.26.3


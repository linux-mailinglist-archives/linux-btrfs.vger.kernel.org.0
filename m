Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39B739AE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjFVIzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjFVIyU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 04:54:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7981213B
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:54:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b5466bc5f8so9651685ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424051; x=1690016051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFMKKDRv9BEw0wZ8UUzCf9pHUtxe8HkFUWg9bN69VRM=;
        b=AuFJ2ff77l/LXEOtYzZWEupZaAfbwt3boPeShk25fcGMwTsb6VlfqfAhMOVgIPnKgi
         eqcOSF5WVHBBVioigqwmY9UAoTi5JEhiUSGdMReu4dDGNOFEVgxVIc2OKO3nltUsVDLn
         bIiXH0DnqlXam4z90R2tFa6XgNVpJSLaIq6Gbf9RXLnB8BOaf0v/n1c1hG3kRZPk0MVc
         mjQpq7kQFhiCgtBijMi8fR+x4TAH8zuouOKbSAqWM+GHeJnchPRb4XIBJxswbiSbm3XO
         sXBcqfmZ/ARe540iNA/E7F7ZKvP/VvSbnbTILDPrN3l0DanjIGoHjsT1U12ioP3F05dG
         yTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424051; x=1690016051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFMKKDRv9BEw0wZ8UUzCf9pHUtxe8HkFUWg9bN69VRM=;
        b=QvCCuom9i8D/PrnDYzRjCWtiHwD3AjH+MwapFGxcK2OoLSYCcDGJfBP5yo/rHrQJK9
         cNyoNJ86sDKtVASlGpXFstK8nykCA59Glh9I0dyW1B9v2dcBYAaeDjz+r4nZM4yhNMvZ
         t1UNN6bEkTpm17yGygbDoBZ/7BU7nbOy79dz8wZ7fcGHI/5703AC0PBErBUqyLdeCcbu
         xqEI4QRHT+uK8YPhsz/UR6xK3YKf+24G3LkXVGL/CsUwoahThXamactCADlYrVDwQymy
         2WzEA7aXIZj4fMjlUe2s3xhNP/f03dxknEXFJkzkHGc2uhL1l7BA33F4y/zyQR4rIYFa
         wM3w==
X-Gm-Message-State: AC+VfDzKeAH5TxHqmkbqcgEthbOPJTiZIaGRVZmjQxoH8izYZvhnQl33
        p1YI/Zmjcupy6eY36VW37yyZTQ==
X-Google-Smtp-Source: ACHHUZ41Ov0V9PIJeBixnqaY8MSMJrvGTOtmFbuG0vAMaQAXgKytEj5uEpxgQHkUs9eKy8wwGzA30Q==
X-Received: by 2002:a17:902:f691:b0:1b3:d4bb:3515 with SMTP id l17-20020a170902f69100b001b3d4bb3515mr21827814plg.0.1687424051106;
        Thu, 22 Jun 2023 01:54:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:54:10 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 01/29] mm: shrinker: add shrinker::private_data field
Date:   Thu, 22 Jun 2023 16:53:07 +0800
Message-Id: <20230622085335.77010-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To prepare for the dynamic allocation of shrinker instances
embedded in other structures, add a private_data field to
struct shrinker, so that we can use shrinker::private_data
to record and get the original embedded structure.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..43e6fcabbf51 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -70,6 +70,8 @@ struct shrinker {
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
 
+	void *private_data;
+
 	/* These are for internal use */
 	struct list_head list;
 #ifdef CONFIG_MEMCG
-- 
2.30.2


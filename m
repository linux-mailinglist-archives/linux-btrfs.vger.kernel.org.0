Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C8B4C5082
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 22:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiBYVVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 16:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbiBYVVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 16:21:20 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD501F0818;
        Fri, 25 Feb 2022 13:20:47 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q17so9148238edd.4;
        Fri, 25 Feb 2022 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YlNvB7NrEBpJJE6cmb8mulZ18i+X9nsh0taaOhh5Pc=;
        b=MVwDWvjTYS6eO/Y/InyGS/3FRGUUboW79CiOsz/G0Xoq00Ybodmb8j4qXGrUWvfz/W
         fbCfauAn97Zm+VthvYQGx5ClfD7SsXYuMcKaItY1915fA5iha1EaPX3A6qF7k1ac+0Dh
         dZRo6Jf3uH3djYL6DnBE5b4sVInTKWQg1Ogr6qQetmJubnF1QfNUjAxVuXPxWsS2QL9L
         4n0bmDEXh9rAxIxQ5Gr+WGim8sHiiF0zveo9sL5LOotRSEgmpaq6yStzaye4jVaYIsJT
         YM6lrdTzYXYzA13aBF0PexAdbXAw7Fk18yA/9n1B60LbMByzOrYOSlw/FKQYC59C44E0
         pVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YlNvB7NrEBpJJE6cmb8mulZ18i+X9nsh0taaOhh5Pc=;
        b=XpIpPvEH4URrJN/Ms4l2GRVyFzDlDvHKbb/fgIgto/JuxKCgnw76mGQriwHIhRgZWx
         ZDDPYOYEczGPYH1BCtJtFY215dZnvMFUPfQqs2lwFJ9nx/yAtfsOxWJnLMRvXf0G1kXP
         qlO+tGvHb4drImV2x0ibrKLo0BKR/LWoAaMjV8lQg74l1bfKcEMq5J41PW3p2zs0Waht
         xBlOK29SGLwGHlLxt4c/PUO+ZprsSAP5TpjQi6wCcP+a3RwSu9E5gftYVpEBvo+DUwG7
         Kw77u9PXcSdK2V3q7SDTZiUd89wD16kadetU32nIDMpSa+1bxb1iiiNf0Mye1gBn0soB
         XZ4g==
X-Gm-Message-State: AOAM531svbtZkEOaJoX1k40pFyMMsyAhkx46/8QSFPCmlyPkYdRrt5NE
        E7PRHRu6AoTTVgKqKcfT7quDGaJ6Ips=
X-Google-Smtp-Source: ABdhPJxsaUsO21GZYFT9xQF1vXhg7RW+orNSxj6ErLyaBTZZ4eYDUADQzxqB2dWli+Xuz26SXwyHQQ==
X-Received: by 2002:a05:6402:90b:b0:412:a7cc:f5f9 with SMTP id g11-20020a056402090b00b00412a7ccf5f9mr8781718edz.136.1645824046394;
        Fri, 25 Feb 2022 13:20:46 -0800 (PST)
Received: from nlaptop.localdomain (178-117-137-225.access.telenet.be. [178.117.137.225])
        by smtp.gmail.com with ESMTPSA id ey10-20020a1709070b8a00b006cee56b87b9sm1428959ejc.141.2022.02.25.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 13:20:46 -0800 (PST)
From:   Niels Dossche <dossche.niels@gmail.com>
X-Google-Original-From: Niels Dossche <niels.dossche@ugent.be>
To:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Niels Dossche <niels.dossche@ugent.be>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] btrfs: extend locking to all space_info members accesses
Date:   Fri, 25 Feb 2022 22:20:28 +0100
Message-Id: <20220225212028.75021-1-niels.dossche@ugent.be>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bytes_pinned is always accessed under space_info->lock, except in
btrfs_preempt_reclaim_metadata_space, however the other members are
accessed under that lock. The reserved member of the rsv's are also
partially accessed under a lock and partially not. Move all these
accesses into the same lock to ensure consistency.

Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 294242c194d8..62382ae1eb02 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1061,7 +1061,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 			trans_rsv->reserved;
 		if (block_rsv_size < space_info->bytes_may_use)
 			delalloc_size = space_info->bytes_may_use - block_rsv_size;
-		spin_unlock(&space_info->lock);
 
 		/*
 		 * We don't want to include the global_rsv in our calculation,
@@ -1092,6 +1091,8 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 			flush = FLUSH_DELAYED_REFS_NR;
 		}
 
+		spin_unlock(&space_info->lock);
+
 		/*
 		 * We don't want to reclaim everything, just a portion, so scale
 		 * down the to_reclaim by 1/4.  If it takes us down to 0,
-- 
2.35.1


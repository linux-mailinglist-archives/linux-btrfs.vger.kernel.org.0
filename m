Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37194D0AB8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiCGWOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiCGWOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:24 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5C55BC6
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:29 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bc10so14595964qtb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qhhiZ6F/4zhhMbdlYr/SNn9aKFTUY4df/mi+Mp5Og1w=;
        b=G2h4qzGIKLAfqSVS1ZY0GXLLT05zUYJCNgs+EetZYYV2uiV4LVO+m7cA7vLoyUvsmT
         wDU01kmSSWq30Gwbyj67/6im1lKoOdF0Kqk0o5hDEe0NsGlol646tXHe5e9WMloR2Igs
         8jQCrRnV4bfQcL/v9GJB3frYsZegnthZAq77TzXWJmPqCUB7QcT9YagkyiL19FTN1uOQ
         YPkEoFvH6plw4SYN4XHff0dKDni/UbYNGKng5FyYJS617Qz3Hgn9WenDMKtcoXFD3JFB
         elRchm10e6eheGiHkQ1BJEbCWm4aqbWOMsbf80GkrflDntIOTIQiQhPnQ04RI0N7Zl1P
         HO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhhiZ6F/4zhhMbdlYr/SNn9aKFTUY4df/mi+Mp5Og1w=;
        b=l0hu3HjB6IBxG3nVTRyKseh1YpKzo6U3sZCGMyn3xhi5HvrfLofCBnGz28opKJaPvY
         iwN/zaFZJNqwLws16O20GLCvAVtoJvIORfY//OvLqwTRQPhdtKChbgNVfv44S5Tt1KPX
         EISZRNQwWugYyh1j19Jb/dsBEvfguJEVTbRbaJFqLYz2wKXfKlScnRqVRHIIHEPjGW7b
         H1rp6VK+wMKqqIpvPoS2IMwhIubqcmnmkdDCQKAUqDB0NWLhOSRDAWdGHTs8gF0t12P9
         VgF2FlM80G3Qj8A145Wjsego/BkhkQ1RWjF1LEqSvn2chnhGZ18g/xEnkLfXTn7y6qSQ
         C66A==
X-Gm-Message-State: AOAM531zKlD4YODq7ucFuD7lJ1Jb26w61W+6XJElqEX8oC/1DTICWDhd
        TJ8jteb89MrDwdWxXnRa76n3xjcu+oF40bSJ
X-Google-Smtp-Source: ABdhPJxt8pLR+XNXpZC76Vv/D1Fwr8pNk1bTiewWA2WP4iLpvNuAkTFMFHNhcNRvPQ19c8HT+pAtiQ==
X-Received: by 2002:a05:622a:1044:b0:2de:2db0:3c01 with SMTP id f4-20020a05622a104400b002de2db03c01mr11171545qte.365.1646691208099;
        Mon, 07 Mar 2022 14:13:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b00648c706dda1sm6711567qki.6.2022.03.07.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/15] btrfs-progs: check: calculate normal flags for extent tree v2 metadata
Date:   Mon,  7 Mar 2022 17:13:09 -0500
Message-Id: <c3895108d399ada307d0e83a3e6ca45eea5f1326.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

Metadata in extent tree v2 will not have FULL_BACKREF set, so simply
calculate normal flags for any metadata blocks we find.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check/main.c b/check/main.c
index b5d08280..420453e0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6185,6 +6185,9 @@ static int calc_extent_flag(struct cache_tree *extent_cache,
 
 	rec = container_of(cache, struct extent_record, cache);
 
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		goto normal;
+
 	/*
 	 * Except file/reloc tree, we can not have
 	 * FULL BACKREF MODE
-- 
2.26.3


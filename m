Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16547629D8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKOPcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiKOPbx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA0C2DAAD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x18so9691367qki.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGTLGPNKt9rHwMmVBTUJWDbcQrsnFY5gBQrILtbVypo=;
        b=yZvm/muf+6I/B9Ax2ngKCmSaLSx0qZDaH0fgMSF1IA4FBrjFVU0BqIaOt3USLGm5VW
         1StCxJTIY4nBH2dlBATRfP38WFeo3ZwoSHBeIyHxbnmzk79/Xz/7t5U94RHXP/iaUMs7
         sC2WYsmR2bp4iRnGD9/xpfMjk7Q0xOiX/XTYFOdO9vrhEVam9QjfbBgTPV+6JmJxKxrG
         Gc53lzJmJy12Q9cx1zxnja2qPcn+XkJZB7bdzhcTz3MTeL00bqz67kLbs0w3pz2oS1fm
         Ee4ueiTeVUKDIOvDnPr/RicXx5c3pB/e2fMVBsl6BOsy8t2hLN075vrgsF+7QkYW/7cM
         akqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGTLGPNKt9rHwMmVBTUJWDbcQrsnFY5gBQrILtbVypo=;
        b=nA8pKjx8GKlpzAZC/3LhyhrXJQrFJ5dm8++agJAFNb4eX/NUSHeJ5Am4gn+CSCmLd7
         zWxUX6/Uf0o4RbpUEjyxMv3D5wPoPYSJGC35s6U56wwJ1KK7bKqSZnSeovTsA4+BsDVp
         ZCtg0YwVtyvXQxgWs5i1RLnxNabm+OBCiC9fIHVlFb2sJG6fGOFg7sSx3tI+jjyVk3zP
         ahfDQ1BZ52B6k2da/mNHFvjARopuWds2H449jdiEvFlMvm092PH9TDG558nwFfHnKdHF
         tNhjW8PqoDDqF3Dt/C8SoovtJ1IYNCouTNaMAZhibZ2a6hkS7DRyXVnRTONYd/mboqc+
         //qQ==
X-Gm-Message-State: ANoB5pk/g1UNdN9teMPfCngb1L/eS//TNejpA6siDiUrWm2Iq1Ippblh
        /kW/faxuvls+iNjcWju9ekhH9+0knUpE0A==
X-Google-Smtp-Source: AA0mqf7h76CaG1vulFexhihPD3QwqUNH/TkgqL863GOBQkGsaeMwHfvZoGqiSzhtUw15How00/A2nw==
X-Received: by 2002:a37:814:0:b0:6f9:efd4:c6 with SMTP id 20-20020a370814000000b006f9efd400c6mr15859621qki.733.1668526309754;
        Tue, 15 Nov 2022 07:31:49 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u2-20020ac87502000000b0035cd6a4ba3csm7322203qtq.39.2022.11.15.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/18] btrfs: stop using btrfs_root_item_v0
Date:   Tue, 15 Nov 2022 10:31:20 -0500
Message-Id: <2bbbeed123967a554a9c0e4808e78705b4e35262.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
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

This isn't defined in the kernel, we simply check if the root item size
is less than btrfs_root_item, so adjust the user of btrfs_root_item_v0
to make a similar check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/subvolume-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 6997d877..1c734f50 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -870,8 +870,8 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 				ri = (struct btrfs_root_item *)(args.buf + off);
 				gen = btrfs_root_generation(ri);
 				flags = btrfs_root_flags(ri);
-				if(sh.len >
-				   sizeof(struct btrfs_root_item_v0)) {
+				if(sh.len <
+				   sizeof(struct btrfs_root_item)) {
 					otime = btrfs_stack_timespec_sec(&ri->otime);
 					ogen = btrfs_root_otransid(ri);
 					memcpy(uuid, ri->uuid, BTRFS_UUID_SIZE);
-- 
2.26.3


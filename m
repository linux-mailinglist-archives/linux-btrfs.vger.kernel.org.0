Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754A1781775
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Aug 2023 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbjHSFE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Aug 2023 01:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbjHSFEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Aug 2023 01:04:40 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544BC3598;
        Fri, 18 Aug 2023 22:04:39 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-649921ec030so9021916d6.1;
        Fri, 18 Aug 2023 22:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692421478; x=1693026278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65uHw/jFKgtttoGYupIpEn43WBBJ6HYuxZbTGo+wnJY=;
        b=bji/cWKH0GWJRI9/qZaY8Y7zkh7yPqC9PfJMGkr1+p/DpGDqXrK3z3mwZsHAtAVvXh
         PBVJJSmihte+Es2loHrp6rBCfWX+vHHOmgLGiQLhrpE2h27z+NZB1yEpbNJqYYi853Hk
         6DU/PpVxV6lpL9Q2os2berhe4ztnmVA64byYZFiAeJ4N6j5rO1r0MkzCYPBSC4VSSr2L
         OwmgZ9BpKsFGQmB9y0Ld0S7ewzco/cWWF2qbTyz2qkmj/inxmX4PgMmmaRlHDPgm01hK
         CRVwhci4ISB05yuDcAZAitTDTzT2SRJ1dQHECro+GWtbsRW9THftU4vRjrxUznJlDjT3
         wYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692421478; x=1693026278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65uHw/jFKgtttoGYupIpEn43WBBJ6HYuxZbTGo+wnJY=;
        b=Xye0SmjmypOHXnQlHK0n/Qusb38hfdvkKvR/8w+WlU3O5dxqLz6+ZpJaPb/JBFGiRg
         LrrY42F2rYWGh0B7egM1SExiccYySkUK4AWbVyBpb3o/D5/MLlgH1/URF+GyqEVmMrFR
         bnPvKCbMqEvFJS6QqrBlxWwDpX4F3Z/KmdvzdOTanHYT2h99AOHRRSfRJWyvF1D5ajMC
         lGVKzaLV1b3uY7abnBLTJTOTgJUFa0QsdJPgiSA/px91ADKqsIO+2EzJPWCqRsWeEGvz
         xYiTAD4lhsRlaiJkZIq4ODSAnumCfAPwlkXZK3UBZ1c9UydxTZRr58c3/rH8oMgbNN/1
         mSRg==
X-Gm-Message-State: AOJu0YzMjMbHSgNxUSpSeFMgJ6ntbag0xd16bnpkSiUey3yCzQsFP6o8
        pUExCGlwx1btrf7OrNRAjW4=
X-Google-Smtp-Source: AGHT+IGmdsYken7saj1l4ykvVfNk3fFwdCQabhJWkrwzje/23fMb5RTTQHDek5wdrYtpx5A9jcMzzA==
X-Received: by 2002:a0c:aa0f:0:b0:64c:9d23:8f5c with SMTP id d15-20020a0caa0f000000b0064c9d238f5cmr923146qvb.64.1692421478425;
        Fri, 18 Aug 2023 22:04:38 -0700 (PDT)
Received: from Slackware.localdomain ([154.16.192.72])
        by smtp.gmail.com with ESMTPSA id d28-20020a0cb2dc000000b0063d0b792469sm1213356qvf.136.2023.08.18.22.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 22:04:38 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 3/3] Docu: filesystems: btrfs: Remove obsolete wiki link
Date:   Sat, 19 Aug 2023 10:23:05 +0530
Message-ID: <d4ab019b782f1a206e34f3a6e9f48e842d61bbf2.1692420752.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692420752.git.unixbhaskar@gmail.com>
References: <cover.1692420752.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Removed the obsolete wiki link.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/filesystems/btrfs.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/btrfs.rst b/Documentation/filesystems/btrfs.rst
index 992eddb0e11b..a81db8f54d68 100644
--- a/Documentation/filesystems/btrfs.rst
+++ b/Documentation/filesystems/btrfs.rst
@@ -37,7 +37,6 @@ For more information please refer to the documentation site or wiki

   https://btrfs.readthedocs.io

-  https://btrfs.wiki.kernel.org

 that maintains information about administration tasks, frequently asked
 questions, use cases, mount options, comprehensible changelogs, features,
--
2.41.0


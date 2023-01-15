Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3016A66B3DC
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Jan 2023 21:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjAOUeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Jan 2023 15:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAOUeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Jan 2023 15:34:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61712F1E;
        Sun, 15 Jan 2023 12:34:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kt14so4860346ejc.3;
        Sun, 15 Jan 2023 12:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bCfG5cMr9fRbFQ0xiXbNmLirkViibitjy1tc8WBHeA=;
        b=BnO7bwuSV3y/IjVwtwAdnsKpQ/x7G03pVbyeAELWwoqckz7SjWOnC2Nwe1xL8Gto0r
         wUVym3Ct1SSfbXX2W6g3s2yYuY2IIWZ+tqV99L9Tv/Q9FcTr4I/V81Mnq5n873uATPhG
         i0lU4ERA7B0TcTCknSw8uGNeu46lxHDM5Bd4Rncq1WuwANAa3Vc7kL3KHi0MzzJVlwa7
         b3bftZBpv+q/knbl63odCaw7jpN6eAEaVk+tYrPWKhbhhKHHptLNKHO8U8MbRM7P8lzE
         6kN4LPJqKVv8mjNGWj49wepdnIcU7VoVn5FNhMwuf7gQnvByDiKw/C7vFolI1ywPbvMj
         KfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bCfG5cMr9fRbFQ0xiXbNmLirkViibitjy1tc8WBHeA=;
        b=oJ0C9ZF7XtQ6zjOGd4nml2vGitiyN+DQyUwCD5N1GXNB0VO4Xih4MezZU0tgUY7MPV
         vcchLuRCkIGIU74NjOVGj68FTvPRXauxd/dro53Cq21dlZPCEBYmXUXU/gEYy1grV7g3
         Qwwal9gnwQEplign0f7ekAdPc5J+U8pjaxa+WJwpYUfjvB2Q7qhV5KjNCYA9qzJB1qAG
         G4O9EPzQerlRz5trR4TXVLXsT4tMG3Y9bf/wqq89aI+ncy3aNz9a1RlTrEPSctz7TH6n
         E+fUB55H9f5Ty06V4PvQwAnKCL0cXlZY7bo9pjjWsa6rxlsFSuCPmu9hE6pGleGHeTWD
         nhUA==
X-Gm-Message-State: AFqh2kqoKkmitJ/hKTOrghtmVpHkbamUzzaOCcMDjgpudQoMV3lMh7G2
        DlRjIuag1EMIdoHi6+W3GvU=
X-Google-Smtp-Source: AMrXdXt61pqQXUODG2P1NXp0W6RnkXA2i8+lkwbTlo795NsH0tyrrlmh0d7OD4J944rEKNIdHVpDnw==
X-Received: by 2002:a17:906:bc1:b0:7fd:eb9e:6fd5 with SMTP id y1-20020a1709060bc100b007fdeb9e6fd5mr73533461ejg.45.1673814844410;
        Sun, 15 Jan 2023 12:34:04 -0800 (PST)
Received: from Tanmay.. (ip5f5ad407.dynamic.kabel-deutschland.de. [95.90.212.7])
        by smtp.gmail.com with ESMTPSA id kw16-20020a170907771000b0084d43e23436sm9082067ejc.38.2023.01.15.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 12:34:03 -0800 (PST)
From:   Tanmay Bhushan <007047221b@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tanmay Bhushan <007047221b@gmail.com>
Subject: [PATCH] btrfs: raid56: Fix stripes if vertical errors are found
Date:   Sun, 15 Jan 2023 21:32:15 +0100
Message-Id: <20230115203215.8115-1-007047221b@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We take two stripe numbers if vertical errors are found.
In case it is just a pstripe it does not matter but in
case of raid 6 it matters a both stripes need to be fixed.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
---
 fs/btrfs/raid56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6a2cf754912d..f35898a78b16 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1886,7 +1886,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		sector->uptodate = 1;
 	}
 	if (failb >= 0) {
-		ret = verify_one_sector(rbio, faila, sector_nr);
+		ret = verify_one_sector(rbio, failb, sector_nr);
 		if (ret < 0)
 			goto cleanup;
 
-- 
2.34.1


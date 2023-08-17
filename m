Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1577FF64
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355088AbjHQU62 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355084AbjHQU5z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:57:55 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA133583
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d6fcffce486so255360276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692305873; x=1692910673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXzvrSqu2NVVVGOJubdrgNOnpMI1Fh11yOes1nDnPZY=;
        b=KCOwhSyboLWFbkZt8OFP6htCdD0xDc3bu5MfVqNjlUJys4W2AyfBdV1pmaYQGiVBMJ
         7V2prqoOP907wzPp8hmLHJhObKPBTQKgHpwmCqRDYWL9I1df12+/c31iBDIqKD1iwIV3
         F2j4n5MSKoBviZc1Vj3obXaYV+sBTxFKjOFhgOGw+sSZNN7MQZ7gxvNI1O4T4ayG6JjP
         GOAYD3Yd/aXM9OqOWlxmOVPv5aQCKLdecCqSEvTj3EtgsuQhxj6BWESeesEK9M/xiGIk
         8jJfBd/jIlPpKZuDwqovnRBIWUnKhameu3bEjophUoJK5IC791OMWdW62wGdBq6GY1IM
         JAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305873; x=1692910673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXzvrSqu2NVVVGOJubdrgNOnpMI1Fh11yOes1nDnPZY=;
        b=iRzzeGE7hfvvMsUA4XTGDm/+6Qt9o6I+POswlEOtwAbheHDF/n0ZNBdLVvyyrlHcsn
         DjkuUx8f0/v5pYAHFMvriuEqTVnKAY8bgyzgHXyguSljzl0Sp/YqS7VubGz37AX1FcYf
         zhl0yBOP8MQTiWlxGYtIZqJqyfw+aiOZzm206IEVVFcK48J8bJXKWrjtjp/pL8STmND3
         gkBGU/tBjkEOFE/yPWzSCksBLqPPsOAX63u8OixiL7uH+r/avUVNXpL2a4O7k7p9KqaX
         Rq8et0B8my7i+NpLiL6cD6O4xSfOVn1pdxrLgSB07jwkUSe+iPI99vbHKr2I811MY9Ig
         nGuA==
X-Gm-Message-State: AOJu0YzbGX7UpGQltZk2282nMt4O1d2odfrU0f4Cb/IFDvHmHi4dXpzX
        +yvrWHbOIXUlst9Tp0NBpUHQI9lf+UQr7Wg6iMPY9w==
X-Google-Smtp-Source: AGHT+IHo5gEIew1kXCuT4a734xvBz8hQwkp+OYszXDYbOOnaGrFCwGAMcI9HP5HQFhZBqkDW0ZNvPw==
X-Received: by 2002:a0d:df0b:0:b0:589:e802:af0b with SMTP id i11-20020a0ddf0b000000b00589e802af0bmr512366ywe.39.1692305872969;
        Thu, 17 Aug 2023 13:57:52 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i127-20020a819185000000b0058c4e33b2d6sm100064ywg.90.2023.08.17.13.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:57:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: fix incorrect splitting in btrfs_drop_extent_map_range
Date:   Thu, 17 Aug 2023 16:57:30 -0400
Message-Id: <e12c86889b1a64879ce6c6cf6f6d315d577295a7.1692305624.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1692305624.git.josef@toxicpanda.com>
References: <cover.1692305624.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In production we were seeing a variety of WARN_ON()'s in the extent_map
code, specifically in btrfs_drop_extent_map_range() when we have to call
add_extent_mapping() for our second split.

Consider the following extent map layout

PINNED
[0 16K)  [32K, 48K)

and then we call btrfs_drop_extent_map_range for [0, 36K), with
skip_pinned == true.  The initial loop will have

start = 0
end = 36K
len = 36K

we will find the [0, 16k) extent, but since we are pinned we will skip
it, which has this cod

	start = em_end;
	if (end != (u64)-1)
		len = start + len - em_end;

em_end here is 16K, so now the values are

start = 16K
len = 16K + 36K - 16K = 36K

len should instead be 20K.  This is a problem when we find the next
extent at [32K, 48K), we need to split this extent to leave [36K, 48k),
however the code for the split looks like this

	split->start = start + len;
	split->len = em_end - (start + len);

In this case we have

em_end = 48K
split->start = 16K + 36K //this should be 16K + 20K
split->len = 48K - (16K + 36K) // this overflows as 16K + 36K is 52K

and now we have an invalid extent_map in the tree that potentially
overlaps other entries in the extent map.  Even in the non-overlapping
case we will have split->start set improperly, which will cause problems
with any block related calculations.

We don't actually need len in this loop, we can simply use end as our
end point, and only adjust start up when we find a pinned extent we need
to skip.

Adjust the logic to do this, which keeps us from inserting an invalid
extent map.

We only skip_pinned in the relocation case, so this is relatively rare,
except in the case where you are running relocation a lot, which can
happen with auto relocation on.

Fixes: 55ef68990029 ("Btrfs: Fix btrfs_drop_extent_cache for skip pinned case")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_map.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 0cdb3e86f29b..a6d8368ed0ed 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -760,8 +760,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
 			start = em_end;
-			if (end != (u64)-1)
-				len = start + len - em_end;
 			goto next;
 		}
 
@@ -829,8 +827,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				if (!split)
 					goto remove_em;
 			}
-			split->start = start + len;
-			split->len = em_end - (start + len);
+			split->start = end;
+			split->len = em_end - end;
 			split->block_start = em->block_start;
 			split->flags = flags;
 			split->compress_type = em->compress_type;
-- 
2.26.3


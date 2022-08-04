Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9586458A0C3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiHDStp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiHDSto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 14:49:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB96D563
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 11:49:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m22so255447qkm.12
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Aug 2022 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLvxGsI5a3bmtHd7+rKcyC0zVL69mImV3D4GYEr2ilw=;
        b=n96D3dHOoeugpC5iqvxvbyH6qcpwBskKvA2bgUm3YoKCQKa3aQ0y5MDHHbAu4nBe7s
         dTnBnn4QoBGnifF5GrlXIDd3QywG3frcQGf545MavF1JPv4OJMC9k+nJMrBDtCRxd4uC
         6+f0dUGxO++B6R+Vw6vTHLMVXg4Ra/Sgv2/Mio+Aj7E/sgeqpKCjnGDTtoi85DYmdHUt
         kkqHgZr+UViSppXlov8ywJfD2BT4E805S9wnrnCVLLLDo2zXpD9LJ6tlr9nlOwfrKkot
         y6uzFA+TM9lNcSppvCsHircdjQd9rCkA/aJSnv+9+y3MDiZc9x7USACQsuc2o818RHnN
         R4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLvxGsI5a3bmtHd7+rKcyC0zVL69mImV3D4GYEr2ilw=;
        b=dny95A2GiUAf8kgrLsH4+EfzcQ/Y7YxtpE/9BYv4FGHSYtlohIbA6w+hiSi0PE0kvX
         S0XI4qXyn6wpDL6Dn7pOMJE9QX4yRN7dHvNnkUb4ZfAnlgHQcCZOcN3o+aNjkSvvcqwR
         kcY/jDwczRx/o1WMPJo2IHAxeg+NXwlCT7hZZLlxkoDiWqIBm+aCssMW9O2udHlJIwbg
         7i6jR3cy40fpbDeDXUzonXKq+528gPuR6i/iWa4kZ1nYpaWEk0fNNpPPYRKYeBmuyn88
         ILUVYbBB0+MEQM6IkBQQTyCDMv7M6u3D5ZIjJ6RyZBBd/ZGUJMx/b5Lq9kpebQBPcG91
         HJQg==
X-Gm-Message-State: ACgBeo0KdaIecW9tsueMqOxomwKJJjvlu7gRpBOx2qeiJZ/XDZkefzND
        NJYi/MiPwnfTWRSMGUvMZzNyuKnUUyUo6Q==
X-Google-Smtp-Source: AA6agR6ijFDbsRO+nvatRwmhT6VEBOtZGcqHC3QBVWd0JrHk/JeFE3JeziPgmzERpmuxxpVezG4CEA==
X-Received: by 2002:a05:620a:f8d:b0:6b8:e7b3:8a68 with SMTP id b13-20020a05620a0f8d00b006b8e7b38a68mr2479443qkn.48.1659638981752;
        Thu, 04 Aug 2022 11:49:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p4-20020ac87404000000b0031ea2328edcsm1129329qtq.82.2022.08.04.11.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:49:40 -0700 (PDT)
Date:   Thu, 4 Aug 2022 14:49:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        Yu Kuai <yukuai3@huawei.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: fiemap is slow on btrfs on files with multiple extents
Message-ID: <YuwUw2JLKtIa9X+S@localhost.localdomain>
References: <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 04, 2022 at 07:30:52PM +0300, Pavel Tikhomirov wrote:
> I ran the below test on Fedora 36 (the test basically creates "very" sparse
> file, with 4k data followed by 4k hole again and again for the specified
> length and uses fiemap to count extents in this file) and face the problem
> that fiemap hangs for too long (for instance comparing to ext4 version).
> Fiemap with 32768 extents takes ~37264 us and with 65536 extents it takes
> ~34123954 us, which is x1000 times more when file only increased twice the
> size:
>

Ah that was helpful, thank you.  I think I've spotted the problem, please give
this a whirl to make sure we're seeing the same thing.  Thanks,

Josef
 
From 1133d5ebf952ebf334bc7be21a575b1f52eb71d4 Mon Sep 17 00:00:00 2001
Message-Id: <1133d5ebf952ebf334bc7be21a575b1f52eb71d4.1659638886.git.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 4 Aug 2022 14:45:53 -0400
Subject: [PATCH] btrfs: don't search entire range for delalloc with fiemap

For the case where we have

[EXTENT1][HOLE][EXTENT2]

If we fiemap from [HOLE] we will search to len (which could be -1) to
see if there's any delalloc extents in the range, however in the above
case btrfs_get_extent() returns a hole em for just the range of the
hole, as it will find EXTENT2, so all we need to do is search for
delalloc in the hole range, not the entire rest of the requested fiemap
range.

This fixes the extremely bad fiemap performance with very large sparse
files.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8fc1e3b6e00c..b7ad8f7a7b53 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7095,7 +7095,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 		hole_em = em;
 
 	/* check to see if we've wrapped (len == -1 or similar) */
-	end = start + len;
+	end = em->start + em->len;
 	if (end < start)
 		end = (u64)-1;
 	else
-- 
2.36.1

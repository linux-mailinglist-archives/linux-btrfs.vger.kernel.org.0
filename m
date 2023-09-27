Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1377B0B49
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjI0RrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0RrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:47:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAACB4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7742be66bd3so507419785a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695836829; x=1696441629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8i9/QHLfcoxb5XIiB/cn7XVFrCaueq8mVZ+yI+OIZrs=;
        b=ddBO72s0CTmtQofYX5fF9fGIMdxSSTFsrx9+LgNonzAig1Tdxh7dsEeAqKwQas92qd
         07GkymvcDTLdotMFLjlsLkfr2irUid+2RG4/fWIpI+NFhrY24tl6+f4Bzx5/JOdhh3Xl
         DYOf0IS8KwR/jZWx8ypBIP0kooyHqybdPDP/tadXTDvJdOuoZToJwyHfbB2iX6ZLhj/d
         vypGQ7Z2O5L1BKD9WRZ78RwMhdUo2+8OCbX5THHd4eFxfRjUYubkdXkH30BdgaK9cLVf
         iyRmWI80HBZuRi7Zx7h6IijSzbDfNCzaoAj/nKpPJCWm92r2mXJww3+FlhQK/+JELoUb
         99MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695836829; x=1696441629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8i9/QHLfcoxb5XIiB/cn7XVFrCaueq8mVZ+yI+OIZrs=;
        b=R12MK9QaMOW7gKbDmfBayMZj88U0Xfw3Oy9ShQfu1Mzcf3AEVh4c2NPqmRwk+O86qZ
         PiqYRLpOuuTbtvZaK9tRKvDSiSBbW0eloTpX34NHpmrtES47ljhcp4DpgK+Wh47FeDPG
         vJIK8D6Hl7Syz/tIRA6XQQ+F3eTNUm0tJ+g4swUbINfnuKbPGwnRt3ae0BX9p3z6s4fg
         8LUGuIc2uJikThqrwvlv+c7rda9LkicpwoV/XBgFjPvAoIYoJD2KBdo2l+AUGHfWSrHV
         fNN75+F3nInQCNQ8gfn8JMxGNJrbcjbV4cmP+ddUkR1SkTDFDasNrCZWHhX/6T3Qhv4j
         02tg==
X-Gm-Message-State: AOJu0YzV2A3NxtTqPFznjah4B4ccdglEePEVV3lpFUbnAFyEI/GPTWpy
        TkjmZPCZQk8FPolfYIWGit4NJg4a3PHgoZJdSkt40A==
X-Google-Smtp-Source: AGHT+IFJEE+mVjjaybnKnBaeXjsnqglXJMzs00iEDWQJH91R3UdQ591MZZQJ85LenvvfDksemwwSoA==
X-Received: by 2002:a0c:e1d2:0:b0:65a:fcc7:d77 with SMTP id v18-20020a0ce1d2000000b0065afcc70d77mr2758358qvl.55.1695836829492;
        Wed, 27 Sep 2023 10:47:09 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n14-20020a0cdc8e000000b0064f77d37798sm4055386qvk.5.2023.09.27.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:47:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/3] btrfs: adjust overcommit logic and fixes
Date:   Wed, 27 Sep 2023 13:46:58 -0400
Message-ID: <cover.1695836511.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

Hello,

This is an update to my original patch

https://lore.kernel.org/linux-btrfs/b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com/

This was causing failures with btrfs/156 and btrfs/177.  The btrfs/156 problem
was caused by the fact that I was just subtracting 1g from the available space.
I missed a spot where we also limit the chunk size to 10% of the file system, so
I've updated the calculation to be exactly what we choose from the chunk
allocator, and this resovled the btrfs/156 failure.

The btrfs/177 failure was actually due to a underflow in ->free_chunk_space
where we weren't adding the new space we got from btrfs_grow_device.  I also
noticed a slight issue with how we remove space from ->free_chunk_space in
btrfs_srhink_device so I fixed that as well.

With these 3 patches we're no longer seeing the above failures and the original
test case is also fixed.  Thanks,

Josef

Josef Bacik (3):
  btrfs: fix ->free_chunk_space math in btrfs_shrink_device
  btrfs: increase ->free_chunk_space in btrfs_grow_device
  btrfs: adjust overcommit logic when very close to full

 fs/btrfs/space-info.c | 32 ++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c    | 21 ++++++++++++++++++---
 2 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.41.0


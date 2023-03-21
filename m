Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CBB6C38E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCUSGq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUSGp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 14:06:45 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC52F4D2A4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:06:43 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id bz27so7198380qtb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=412pzojuSE2f0w3DYVguk4c8qRm7lPnYodGxkNfunN0=;
        b=EjDbxjjWcoPXG3RYtx2w5zqSFPWYO1saA5dFvFyrgLCAb1aLSayd2CPFR53pXY6e6H
         1MwEBhqlkvS2Y4Lnpq0xQ1FTR4dnf3KiNJ0Ek2S4UoH2Oau5zGAiI6Mxw1Pl+1JMtwJ6
         B5VTv0VCMRHU03qBI7W8Z+xBsWQ6I1FFMmd5jwMTgM4Spq1FYKg9pwzYx6MFJetK6xL1
         3fP/z23j/82/5XBDe9P3ZUjOQeAkFGzn9reixh8V/svFtb4r/4DE5bRZaHXIBJ5ZTy3D
         TdeVE38mIt1ZrBVeUWyyAoIC9dMYOQfc2kXuOBE3CknoiN97l7HpTj9zrBWbK8ToWypN
         vp0w==
X-Gm-Message-State: AO0yUKUoBYthv7Z5puLwYZcBouoZJSPou2xFUWVRcrUm7wSKuQ8OPwQj
        hIIqcBhi4nD0EyeGZEeo9UnoxwqF8WQW3pohWFU=
X-Google-Smtp-Source: AK7set9+2p6eGp3S7sZ795vZUEMHFSO3IYC1ylRSkBax4pZ2Y2akTUJTXlMr3SaBE0KhhgdIPxkjQw==
X-Received: by 2002:ac8:5b95:0:b0:3b8:340b:1aab with SMTP id a21-20020ac85b95000000b003b8340b1aabmr1291066qta.25.1679422002405;
        Tue, 21 Mar 2023 11:06:42 -0700 (PDT)
Received: from Belldandy-Slimbook.infra.opensuse.org (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id 84-20020a370c57000000b0074698d81ffasm2328796qkm.44.2023.03.21.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:06:42 -0700 (PDT)
From:   Neal Gompa <neal@gompa.dev>
To:     Linux BTRFS Development <linux-btrfs@vger.kernel.org>
Cc:     Neal Gompa <neal@gompa.dev>, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: [RFC PATCH v2 0/1] Enforce 4k sectorize by default for mkfs
Date:   Tue, 21 Mar 2023 14:06:09 -0400
Message-Id: <20230321180610.2620012-1-neal@gompa.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The Fedora Asahi SIG[0] is working on bringing up support for
Apple Silicon Macintosh computers through the Asahi Fedora Remix[1].

Apple Silicon Macs are unusual in that they currently require 16k
page sizes, which means that the current default for mkfs.btrfs(8)
makes a filesystem that is unreadable on x86 PCs and most other ARM
PCs.

Soon, this will be even more of a problem within Apple Silicon Macs
as Asahi Lina is working on 4k support to enable x86 emulation[2]
and since Linux does not support dynamically switching page sizes at
runtime, users will likely regularly switch back and forth depending
on their needs.

Thus, I'd like to see us finally make the switchover to 4k sectorsize
for new filesystems by default, regardless of page size.

The initial test run by Hector Martin[3] at request of Qu Wenruo
looks promising[4], and I hope we can get this to land upstream soon.

This is an update on the initial RFC patch[5], which addresses the
documentation feedback from Anand Jain.

[0]: https://fedoraproject.org/wiki/SIGs/Asahi
[1]: https://asahi-fedora-remix.org/
[2]: https://vt.social/@lina/110060963422545117
[3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
[4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895
[5]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#t

Neal Gompa (1):
  btrfs-progs: mkfs: Enforce 4k sectorsize by default

 Documentation/Subpage.rst    | 15 ++++++++-------
 Documentation/mkfs.btrfs.rst | 13 +++++++++----
 mkfs/main.c                  |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.39.2


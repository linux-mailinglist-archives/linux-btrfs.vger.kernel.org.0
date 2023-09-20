Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91C57A862C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjITOHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjITOHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 10:07:08 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773CCE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 07:07:00 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-656262cd5aeso34563896d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 07:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218818; x=1695823618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YC58Rwjn05yfeh/0Sb/+de3YeleF18tUEJjL/AOV6XA=;
        b=XByEtapqWe7iHJkcX8hgISpbdTLmyovYUTKUxSe8Y6MTrjhspqdTIBWqKJQ6VUG3N5
         gdq5ScLZzx1atTp/fE+qi5vDYrb0MMCBknB8xk160OyVLtE9knNEsj1dQK2fjOczkD+2
         fgSMolPjQ47tIhLHYhpLbZObPwbZ3tj1WjO2It/pCSjPnbkPPqg7BoyiNaetQmrAtSzU
         RxOXxUXVNROFvgZ0eAhxyRtOweZjdDm8Ygi2oyiJ0iPvQX7hd5B1HUUs5JSMnPreNal9
         u6S3OMRk23I+xAkmnLeoJwHZkKQvrPP3pZR2LDLvjyhKn8gyoNkNkGgXw57w2TkpDSfn
         w/jA==
X-Gm-Message-State: AOJu0Yyk14LwJoHJYXqrNwxq889mA2H5cQJx4ZWv5dK0oC2xF5Br1rjU
        3F1HBZ5Ju07k3W+b+BIj6PBQ/ZardyA6j56l
X-Google-Smtp-Source: AGHT+IFsy6Uqrt5kzFTeGNeq8yg2PsDBPHH3t6PsFOCklVE7RahfIvrBiFFoLnZ53tvUj6CjOM6ehA==
X-Received: by 2002:a0c:a709:0:b0:658:2eb1:10d9 with SMTP id u9-20020a0ca709000000b006582eb110d9mr2122682qva.14.1695218818569;
        Wed, 20 Sep 2023 07:06:58 -0700 (PDT)
Received: from Belldandy-Slimbook.tail03774.ts.net (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id v1-20020a0cdd81000000b006589375b888sm345447qvk.67.2023.09.20.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:06:57 -0700 (PDT)
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
Subject: [PATCH v2 0/1] Enforce 4k sectorize by default for mkfs
Date:   Wed, 20 Sep 2023 10:06:13 -0400
Message-ID: <20230920140635.2066172-1-neal@gompa.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

=== Changelog ===

v2: Rebased to latest, updated doc references for v6.6

Final v1: Collected Reviewed-by tags for inclusion.

RFC v2: Addressed documentation feedback

RFC v1: Initial submission

[0]: https://fedoraproject.org/wiki/SIGs/Asahi
[1]: https://asahi-fedora-remix.org/
[2]: https://vt.social/@lina/110060963422545117
[3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
[4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895

Neal Gompa (1):
  btrfs-progs: mkfs: Enforce 4k sectorsize by default

 Documentation/Subpage.rst    | 15 ++++++++-------
 Documentation/mkfs.btrfs.rst | 13 +++++++++----
 mkfs/main.c                  |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.39.2


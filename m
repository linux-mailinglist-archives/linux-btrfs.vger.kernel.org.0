Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236746C595B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCVWRp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWRo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 18:17:44 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD5D55BE
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 15:17:42 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id t19so10534147qta.12
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 15:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679523461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8fm59T6GNtFNZMpkSl1+tEkfa0SYgZQT4b9lud/WVc=;
        b=i4rS1a0517r1a/cLYuyK7d9fkq+Om5CoswgsvTx3gaBoUgMUwoCuzAi+Ry+bR31TLE
         lXCzDrHZcc0DvO8oWtRAy1OQY66FORTuWjwES2vrjkBTNiFLoC9UIxEa5fKYp2+1EO2P
         VIktgFvgwf6BB7TQGG8+PDT1GkgMVNQ/zm2qijYbH8fCj60aDnGNz+o6ICui6l10zAh7
         MhmxY8bSlj6tg66ONN60+bWFgZZI2OsRZmapTqqtIEBtrpzDr42Mft1+MUHkfXMc7SM2
         eNdtqs9m63sJdUs0EuMcGzodYubSgJm6p+U9WAWxLPWjL2/dwb5jVgKJFPy9rYPbq43F
         e1YQ==
X-Gm-Message-State: AO0yUKV0/AgbTy2yEbcWfwOVK43S5LkupkHXp2hnyDK+d4klnYamWqV+
        8qT0epIxAnDB8Gb94vIX/p/xgq4+2RejuLsZ0JQ=
X-Google-Smtp-Source: AK7set9yeM+Iuru4SwZlFPYQIFWDKA9bG78A4iKjbutxtB1YOJjhX65eU6Bkl/CCbev7aYajH6rZYw==
X-Received: by 2002:a05:622a:204:b0:3dc:ac3b:ca6c with SMTP id b4-20020a05622a020400b003dcac3bca6cmr7110842qtx.6.1679523460610;
        Wed, 22 Mar 2023 15:17:40 -0700 (PDT)
Received: from Belldandy-Slimbook.infra.opensuse.org (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id j185-20020a37b9c2000000b007465ad44891sm11068443qkf.102.2023.03.22.15.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:17:40 -0700 (PDT)
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
Subject: [PATCH 0/1] Enforce 4k sectorize by default for mkfs
Date:   Wed, 22 Mar 2023 18:17:13 -0400
Message-Id: <20230322221714.2702819-1-neal@gompa.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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


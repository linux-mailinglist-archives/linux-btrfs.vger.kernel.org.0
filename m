Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6B6766F06
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjG1OJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1OJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 10:09:12 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 07:09:10 PDT
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de [89.1.8.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81A35A9
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 07:09:10 -0700 (PDT)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout2.netcologne.de (Postfix) with ESMTP id 676D212348
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=netcologne.de;
        s=nc1116a; t=1690552754;
        bh=7TKEbgD1EcGcpftfS3Sb0V0/UNCViu34U9oifLMibXo=;
        h=From:Date:Message-ID:Subject:To:From;
        b=NbHkqGHUTLtut8TeG+7ZtZM66bCneim/nCmZmxQrjP9s5DqkGvKJl71E4i/j3mpeR
         gU6CNyv8KQq4kJoR322RN50iJ9iUTaieCW0S5wo71dx1nn6fX1TPh+xpUGMZc5zKqg
         U8Mf1cFKCxpCe/IoWmUr28rbVeuIvsg+sSyns9DsGipgPZeyyw+ss1S81le3O5QXk4
         mtRLfROODC9YX8T8oDimL9gr/5DWSpJcwCNOLmAyko5cugfGAQ5iFkOp2NY3I1vtOX
         WF8RN13bZho8MWFXFbVwig8GB0kwCJujx15Cc3WBhr2+Kgqb/cGfjTiRATB55RrzXP
         +A0SpOk3zXb9g==
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA id 4CD32120DB
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:59:14 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bba54f7eefso21630335ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 06:59:14 -0700 (PDT)
X-Gm-Message-State: ABy/qLaS2n0XpdCaemSyukOf2xE6TnYLIEI5on2XbyIuDZcwst8PzLLH
        tvmS0OMZaTuE3kNl3HLa6PF7KWKILquHLQQp1OA=
X-Google-Smtp-Source: APBJJlH5o+YZ9Lz88CDkE+zkReHapf7Dv/ws9MoW0uccucRICtGJy7oAkfr2xQZEdLAk9jGtsWvdI0srHKNf6Dr2tLM=
X-Received: by 2002:a17:90a:940d:b0:263:5376:b952 with SMTP id
 r13-20020a17090a940d00b002635376b952mr2671273pjo.9.1690552752661; Fri, 28 Jul
 2023 06:59:12 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Malte Schumacher <s.schumacher@netcologne.de>
Date:   Fri, 28 Jul 2023 15:59:01 +0200
X-Gmail-Original-Message-ID: <CAA3ktqkR_hk++GpHM1oLUVto139oUOMLH92GPepQMA4M7-wdYQ@mail.gmail.com>
Message-ID: <CAA3ktqkR_hk++GpHM1oLUVto139oUOMLH92GPepQMA4M7-wdYQ@mail.gmail.com>
Subject: Drives failures in irregular RAID1-Pool
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 4CD32120DB
X-Rspamd-Action: no action
X-Spamd-Bar: -
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I recently read something about raidz and truenas, which led to me
realizing that despite using it for years as my main file storage I
couldn't answer the same question regarding btrfs. Here it comes:

I have a pool of harddisks of different sizes using RAID1 for Data and
Metadata. Can the largest drive fail without causing any data loss? I
always assumed that the data would be distributed in a way that would
prevent data loss regardless of the drive size, but now I realize I
have never experienced this before and should prepare for this
scenario.

Total devices 6 FS bytes used 27.72TiB
devid    7 size 9.10TiB used 6.89TiB path /dev/sdb
devid    8 size 16.37TiB used 14.15TiB path /dev/sdf
devid    9 size 9.10TiB used 6.90TiB path /dev/sda
devid   10 size 12.73TiB used 10.53TiB path /dev/sdd
devid   11 size 12.73TiB used 10.54TiB path /dev/sde
devid   12 size 9.10TiB used 6.90TiB path /dev/sdc

Yours sincerely
Stefan Schumacher

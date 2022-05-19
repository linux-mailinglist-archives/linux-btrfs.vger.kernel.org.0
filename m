Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54D52D000
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 11:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiESJ7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 05:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiESJ67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 05:58:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93E9BADC
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 02:58:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u23so8229038lfc.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NHIGK+PbLgilEsHtWFHc9mvBatt0TaZ5XM4UToczjcc=;
        b=eUVDGlxX5lGUifIo++BMKxrVJrfCQxrp9LB9Q3KBlCCllvFAHYgrNinYoEDmpB4lnD
         8ZyfuBDsvP/dZ+JsgSyw42AbMyxZjiyXLulm292/ObwFlJiDtWyMKdtF9HEooMyB8VOp
         R8LOFktr7nIWSOgTU2Ey66t0Kjj9I0rDdlmYMM7sKlORwiW3hTMZ6bE7RDd7yZEr/T4/
         5/NqUYRtUJCWytG5/auPX9bg66Mqk25wCaAy9cnzZ9I+UEfwCQ3DkpHu9fB6SUVAT1+8
         WJp5c5yQ9rQNEPfTvXvq8HnqIdXkcRosDoKtyZSEf3HdyM/m7nbBKx/vaFPzDmi8DJkE
         Gjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NHIGK+PbLgilEsHtWFHc9mvBatt0TaZ5XM4UToczjcc=;
        b=AViPS6VMQ5RnFwv1yVDVhlE5T+ZQh/Z4Uyt9JOED7ZrsvncxKNeXBw5DEDKpSsizXZ
         t1FUzmhxsRQfEnVdCmcTmqgYLiYJdh4s3Ab/7IZYVnRG2jSq1kFGuDxM5P8qVwIK4oD5
         m+m3L4FRq1nnD3AN6KSiFlf2Dvhc8uKwA1SkIgeU20Bvpz/J5p1t71iREr6ZkW0H+5ns
         Vk7hBoXdzE3QYQ/pWw7FNNCLb+F6Z2oMFJCGakQe8iLlEGxoqVvDm9vF4v0S/VdZbTpf
         TcSFrVPswYN9HVg1FGNFofNchemSi2cYXpKHCXAmtoHdUfqIeyO6DMGz1PihCG1ysWKL
         TYTw==
X-Gm-Message-State: AOAM5338JRhwkhZxNodZgUkek0T8NIqW+qvcAEPVzOglPybYJhrOdQPZ
        L3HbAMogPsFP7/Irk0smLYi9rhb2ulmO9iksr+X2rBupAutv2Q==
X-Google-Smtp-Source: ABdhPJzvdHon3+H36xbtlp8p0okYlGmaB8crJjM6FArCGf2Mm/oFZQkCCDmxRdZYXF2F80UQtw4sF3tAPzoA+mUvNL4=
X-Received: by 2002:a05:6512:22cf:b0:473:a41f:155f with SMTP id
 g15-20020a05651222cf00b00473a41f155fmr2741998lfu.227.1652954336844; Thu, 19
 May 2022 02:58:56 -0700 (PDT)
MIME-Version: 1.0
From:   arnaud gaboury <arnaud.gaboury@gmail.com>
Date:   Thu, 19 May 2022 11:58:45 +0200
Message-ID: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
Subject: can't boot into filesystem
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My OS has been freshly installed on a btrfs filesystem. I am quite new
to btrfs, especially when mounting specific partitions. After a change
in my fstab, I couldn't boot into the filesystem. Booting from a
rescue CD, I changed the fstab back to its original. Unfortunately I
still can't boot.
Here is part of the error message I have:
devid 2 uuid XXYYY is missing
failed to read chunk tree: -2

part of my fstab:
LABEL=magnolia   / btrfs  rw,noatime.....,subvol=@
LABEL=magnolia  /btrbk_pool  btrfs  noatime,....,subvolid=5
LABEL=magnolia   /home   btrfs .....,subvol=/@home
......



I am now back to rescue CD. I can mount my filesystem with no error:
# mount -t btrfs /dev/sdb2 /mnt
# ls -al /mnt/
@
btrbk_snapshots
@home
home

I can see my filesystem when I ls the @ directory.
What can I do to boot my filesystem which is perfectly reproduced in
the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
the root of /mnt  when my device sdb2 is mounted?
Sorry for the lack of formatting and info, but I can't use the browser
from the rescue CD so I am writing from another computer.

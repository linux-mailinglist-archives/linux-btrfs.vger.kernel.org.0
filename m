Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3E1CFBD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgELRR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELRRz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 13:17:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2ECC061A0C
        for <linux-btrfs@vger.kernel.org>; Tue, 12 May 2020 10:17:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o24so18908356oic.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 May 2020 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rozsas-eng-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=WbDCSt9ayD2aaxwHRX6Btyd4wthtj6RjunTWKaGrUpw=;
        b=rQcaauzfjHq/NBe2240DDW7BRM8+AfBycvR6BgJ8NIJKUaYIHhaw0h+NEe0AvpAUVZ
         qlNsiVpesU72tJsp1bZ56VzVD4TTYGFJA3aWnYjfLv55oE+DAXjG2QD2uF5axRzwI6HL
         qCICuleR+oLB63LFmNvGR3InteYWb7sCreaRYnnMlp/PQJRNbGwSK5DsgMB5B2tr9lTg
         i/aIz/KNN5k7vMzq+UllRIl3JVJBBrGjbc+MQgCWQMW0+roomew4HXuhHoXZ2/iMC1EO
         7DR80p8nvjHDNXIo0rkUVXJwvrDyX1gfpFPFLVNSSy1NUy99gudvqx1OJZlvg5kTHqQT
         G8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WbDCSt9ayD2aaxwHRX6Btyd4wthtj6RjunTWKaGrUpw=;
        b=t/hIScJQrjMH6BYX50sK0wLHnCh2vUHk3KYObWVd0mY8UFOHjjkxF+X1AudN2fEJmN
         Wsp2B9xzGLnw1p7t0BQLfm2kVta5p2582g31amGknHIS6wVciYEhnDnWBc/8R4Mj7MVu
         wONGHP1BSey8aydja97v4xn33WB4u5ep/oDtewTwbXRJDP4rhlSakQYlU5p0yauzpQHP
         bPFsW18Q5xvBI1syUEjrpvp2eR2aayqWSHFoZO+eR6JFOiciqWYZHclLcceN/oRncIy/
         ZXGUsmwEMUCVlJ8RNY3lsMfYzC0ucqeh2IWAfhsgHPTxCxB1CW0/Q8y/8gjVyCLdsOOo
         tH2g==
X-Gm-Message-State: AGi0Pub1kvNc1JqueyAmazJYS8KGf3O288lTorXykeFjUG6OVVxxUnK2
        uJnNCk/4y5pin+y5AlT52uROA/Y/XFkLyEkPZAzTS10czFA=
X-Google-Smtp-Source: APiQypKgvXGH/T6HbHVAOpbb+WM0C9OHh3mTnOCjksZOoo0txGst7Wuyb80y12sAuJdjLcnXL4wd4aXXVE8tb9G4A94=
X-Received: by 2002:aca:bf09:: with SMTP id p9mr22378774oif.55.1589303874937;
 Tue, 12 May 2020 10:17:54 -0700 (PDT)
MIME-Version: 1.0
From:   "miguel@rozsas.eng.br" <miguel@rozsas.eng.br>
Date:   Tue, 12 May 2020 14:17:19 -0300
Message-ID: <CAP5D+wYLQUh+XqBCU3MVq1vY41fbPgjabm7GkORmio+kFOYaqg@mail.gmail.com>
Subject: How to find the parent folder of a sub-volume ?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there !

root@fenix:/home/miguel# btrfs --version
btrfs-progs v5.2.1
root@fenix:/home/miguel# btrfs subvolume list /home/miguel/tmp/
ID 265 gen 20670 top level 5 path miguel
ID 266 gen 23573 top level 265 path miguel/Documentos
ID 267 gen 23575 top level 265 path miguel/Downloads
ID 269 gen 23537 top level 265 path miguel/Misc
ID 270 gen 23522 top level 265 path miguel/Musica
ID 271 gen 23526 top level 265 path miguel/ProgramasRFB
ID 272 gen 23574 top level 265 path miguel/tmp
ID 273 gen 23509 top level 265 path miguel/Videos
ID 274 gen 23574 top level 265 path miguel/R
ID 275 gen 23557 top level 265 path miguel/Imagens
ID 302 gen 23507 top level 265 path miguel/Tech
ID 595 gen 23517 top level 265 path miguel/src/UPSData
ID 596 gen 23510 top level 265 path miguel/bin/UPSData
root@fenix:/home/miguel#

How to find the parent folder (root tree?) of the above sub-volumes ?
On this parent folder I expect to see the above sub-folders as regular folders.

best regards,

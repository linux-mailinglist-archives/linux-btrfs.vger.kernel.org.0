Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CB516AD1
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357970AbiEBGWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 02:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357223AbiEBGWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 02:22:52 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80EF47388
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 23:19:23 -0700 (PDT)
Date:   Mon, 02 May 2022 06:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail3; t=1651472359;
        bh=sgOyd/890xh98P9egRr3SbOYWgk37k7U71ErD+bsrZw=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=hklPtFxJD0D0W5RCAY1a6FHRUD5L3sJcjPNi8hOTGAPcLQWuMt/OzkjyE8V52/F4+
         Wi4STevFMuEY+QerQFSkDrhrqfugk2vOe+dJd/GZAqVlHN+E+g8dckDhF+YRJVmPk/
         x3sLu9QArkBOvob8cQFQGBsisP6N0M7ivvtZVnBgdznvpn7cfBQaWWJza/jRvJoOh+
         zOL84T/DK7OMwBLwyZ6pUKL9ha+CAklUBEifhJS+Vh4QcylO5i5GypeExKyu2WKWoz
         ShlOLyDeFsU+J8L51mUbaftM2Wjmv1mt9W4h65gXX9jiTe0mAOJZvaJYhaIpe44yxQ
         8pHkmO5YFA2ug==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Neko-san <nekoNexus@proton.me>
Reply-To: Neko-san <nekoNexus@proton.me>
Subject: [Help?] "errors" found in fs roots
Message-ID: <8hH0EBKfKaciK1_cX-iqDutaxznwCYo_pJp5SCgfxC-qGnmQ6-YWHJx69Mi0N2akRh-OZOedEPGeHCUqguEnMXM8Kqz13pHUxZw6hwp05AM=@proton.me>
Feedback-ID: 45481095:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello; I'm having a bit of trouble resizing my BTRFS partition...
It mounts fine, but "btrfs check" reports errors and prevented my GUI disk =
management software from performing the operation.

I would appreciate help in figuring out how to fix this without destroying =
~2 TBs of data... please. >_<

```
neko-san@ARCH ~> btrfs check --readonly --progress /dev/sda3 &> btrfs-check=
.log

neko-san@ARCH ~> uname -a
                       btrfs --version
                       btrfs fi show
                       btrfs fi df /mnt/extraStorage/
                       sudo dmesg > dmesg.log
Linux ARCH 5.17.2-256-tkg-pds-llvm #1 TKG SMP PREEMPT Wed, 13 Apr 2022 20:3=
0:30 +0000 x86_64 GNU/Linux
btrfs-progs v5.17
Label: none  uuid: 5761f276-9f47-4195-a5b2-c21ff4f3fea5
        Total devices 1 FS bytes used 181.35GiB
        devid    1 size 198.11GiB used 198.11GiB path /dev/nvme0n1p2

Label: 'extraStorage'  uuid: 9d14e17d-66d4-41e7-95a4-8125f75b4d2b
        Total devices 1 FS bytes used 2.16TiB
        devid    1 size 2.18TiB used 2.18TiB path /dev/sda3

Data, single: total=3D194.01GiB, used=3D179.33GiB
System, single: total=3D4.00MiB, used=3D48.00KiB
Metadata, single: total=3D4.09GiB, used=3D2.03GiB
GlobalReserve, single: total=3D370.78MiB, used=3D0.00B
doas (neko-san@ARCH) password:
neko-san@ARCH ~>
```
(The logs are too big for this email, so here's a cloud link:
https://mega.nz/file/QrJRUQ5D#NCt5T6dpwS8VGWOrxPGdFK2M9nkURJ2ekH-YugFvVuc )

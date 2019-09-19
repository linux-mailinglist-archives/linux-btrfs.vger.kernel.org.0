Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB45B82F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2019 22:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfISUwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Sep 2019 16:52:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40897 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732722AbfISUwA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Sep 2019 16:52:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so5532626wmj.5
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2019 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HEQdrF859Tpnz39D+yW+ws2om0OvYxzWuUFukBmH494=;
        b=qyvLDN2/Q2/Qot4nOD51s9x3eljJDlAp/nPWe+YIXFiQYD0Y4vL1YKjcDDQWSZ0Kf7
         kcu66AKCH/1uHYIdMkDM6krdQnEbic+QfJfNWE0dMnKcut5CLBIY1hpxCt6ImxL97ynI
         1Y9Gb3JToKOJNeBYh/F9+rA/8nVtJruJc336XmldtCNxb+2bUBC45KdWiQLA1OheM2E2
         waMLvWbMxFuBwuAmnzBUE1mDu91jLYkGWeM97V9Fb+/0pHOjPV7G2i8mjRxkyzIJUC5U
         A01KDltcTOn+pBeiPcISSKRaCHg9mwx2ki0tNVyzxYxZpELIRCB/42GVunPS2qU/GxzT
         8Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HEQdrF859Tpnz39D+yW+ws2om0OvYxzWuUFukBmH494=;
        b=jNtiBGc1PlwGz5+QKVQmspYqF/W2nK49dPFrXIIqGdVwi9TBlyP7uUDxPxsYi5VVri
         Zh9PfJSo69wmiMQGkAeZvv3t+KJ7K/CMKCS8UxSxHCFoBxQe3++OJRHHmASPf+QNZET/
         pHDOS5rwFY3ItMSXO4oe6tTnHPxPzA/7KuX9BAJStiqFfFSUXU4mk8BWiK0SgpZUriqM
         VXAV6iKSjgI9etrUh/mOZ41OgWThb9jdBs8pcD1ov/j0ASLs/ZfSGNfjiR311vzZsiKd
         0XbiMhoQx3yISGR4UH+vuOu/cO/L+UCYr59t2G5fDnmAWpqZuFb6ujmcEbh1xjF9rr5J
         FVNQ==
X-Gm-Message-State: APjAAAW3VAgGhuJCDav7DlGvT8+zndXuEGv9R3vLlF8RjSAwrYxjjwqR
        0a8EvWKJ2L1qlaALEQn0mgKLyvc1mM3Uwa0Ow+EzLg==
X-Google-Smtp-Source: APXvYqw/YlVg/0S5lQaANqARpE6Uh9gx/Iam4/b4Iqla/R7jGVlIxgnvWHELNfZ/4OQHgVVvIJzjetCC8KG+oCOW+No=
X-Received: by 2002:a1c:5942:: with SMTP id n63mr4441139wmb.65.1568926318450;
 Thu, 19 Sep 2019 13:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <4DF2D58151C4C8499907B16D8F72881901CEC458EC@MCDBS2A.mc.ad.lluahsc.org>
In-Reply-To: <4DF2D58151C4C8499907B16D8F72881901CEC458EC@MCDBS2A.mc.ad.lluahsc.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 19 Sep 2019 14:51:47 -0600
Message-ID: <CAJCQCtSo4HN9AUK+cUGjUrOYsnW7f39GVn_r8Yrszw=WvSo1GA@mail.gmail.com>
Subject: Re: Unable to delete directory: input/output error and corrupt leaf
To:     "Barnes, Samuel" <SABarnes@llu.edu>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 19, 2019 at 11:38 AM Barnes, Samuel <SABarnes@llu.edu> wrote:
>
> I have a btrfs drive that started have problems, I first noticed some of =
my old backup directories couldn't be deleted, the automated delete command=
s removed all the files, but got stuck on the directories. Now if I try to =
delete I get input/output error:
>
> rm -rf 20190806-020001-412/
> rm: cannot remove '20190806-020001-412/backup/media/network_mriphysics/HA=
T_data/Phantoms/Penn State Coll Time1': Input/output error
>
> dmesg shows the following errors:
>
>
[11655.022724] BTRFS critical (device sdc1): corrupt leaf: root=3D5
block=3D1399280648192 slot=3D69 ino=3D8904454, name hash mismatch with key,
have 0x00000000d8649173 expect 0x00000000f88d2ac3 [11655.027629] BTRFS
critical (device sdc1): corrupt leaf: root=3D5 block=3D1399280648192
slot=3D69 ino=3D8904454, name hash mismatch with key, have
0x00000000d8649173 expect 0x00000000f88d2ac3 [11655.027990] BTRFS
critical (device sdc1): corrupt leaf: root=3D5 block=3D1399280648192
slot=3D69 ino=3D8904454, name hash mismatch with key, have
0x00000000d8649173 expect 0x00000000f88d2ac3 [11655.028311] BTRFS
critical (device sdc1): corrupt leaf: root=3D5 block=3D1399280648192
slot=3D69 ino=3D8904454, name hash mismatch with key, have
0x00000000d8649173 expect 0x00000000f88d2ac3
>

What do you get for:
# btrfs insp dump-t -b 1399280648192 /dev/sdc1

This likely exposes filenames, it's OK to remove them.

> I have tried a scrub, no errors:
>
> sudo ./btrfs scrub status /dev/sdc1
> UUID:             d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
> Scrub started:    Tue Sep 17 10:43:20 2019
> Status:           finished
> Duration:         1:46:29
> Total to scrub:   1.18TiB
> Rate:             193.46MiB/s
> Error summary:    no errors found
>
> a btrfs check gives a very very long list of errors most include "link co=
unt wrong" such as:
>
> root 5 inode 5202109 errors 2000, link count wrong
>     unresolved ref dir 7424552 index 19 namelen 9 name 12-25.dcm filetype=
 0 errors 3, no dir item, no dir index
>     unresolved ref dir 8454942 index 19 namelen 9 name 12-25.dcm filetype=
 0 errors 3, no dir item, no dir index
>     unresolved ref dir 8616651 index 19 namelen 9 name 12-25.dcm filetype=
 0 errors 3, no dir item, no dir index
>
> another example:
>
> root 5 inode 7422709 errors 2001, no inode item, link count wrong
>     unresolved ref dir 261 index 182 namelen 19 name 20190630-020001-715 =
filetype 2 errors 4, no inode ref
>
> I ran a balance, that didn't help, and interestingly if I run check --rep=
air it aborts:
>
> sudo ./btrfs check --repair /dev/sdc1
> enabling repair mode
> Opening filesystem to check...
> Checking filesystem on /dev/sdc1
> UUID: d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> incorrect offsets 9191 67118055
> incorrect offsets 9191 67118055
> incorrect offsets 9191 67118055
> incorrect offsets 9191 67118055
> items overlap, can't fix
> check/main.c:4265: fix_item_offset: BUG_ON `ret` triggered, value -5 ./bt=
rfs(+0x5e2f0)[0x557b1e3c62f0] ./btrfs(+0x5e396)[0x557b1e3c6396] ./btrfs(+0x=
6951b)[0x557b1e3d151b] ./btrfs(+0x6a45a)[0x557b1e3d245a] ./btrfs(+0x6cf09)[=
0x557b1e3d4f09] ./btrfs(main+0x95)[0x557b1e37c690]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f7aec452b97]
> ./btrfs(_start+0x2a)[0x557b1e37c1ea]
> Aborted

That's a bug.

I think overall the file system is probably fine, but there's an older
kernel bug that caused this leaf to become corrupt at some point, and
increasingly stronger checking is what's exposing it now. So the trick
is really how to delete the offending file, because right now it looks
like that isn't being allowed.

Qu might have an idea.



--=20
Chris Murphy

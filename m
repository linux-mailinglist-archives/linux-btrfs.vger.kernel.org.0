Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5672B41BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 11:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgKPKxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 05:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgKPKxJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 05:53:09 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBF7C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Nov 2020 02:53:09 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id o21so23764497ejb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Nov 2020 02:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhml9+tOuM64N+Kdue9JcVhV+l7dqchXKjApMncn+j4=;
        b=P6byh5xdD7Fcm/zu3ImrK9y91MMrwjiQtXJ+AnPvFX/GyEB8BM5axLR+3SQ5ywmlsZ
         CSCWaCpEhbI+88NTKAdpK10/uX6ub422FXBI5tVPQutPdqihiplzWj++c0LEe5fCMabn
         eNqGrSiqEQQnYGQ3zxwRNKS/u6WcI5CQ/J5KObg5iYAUt6U6G4E/KbmuJcCbMvsge1G8
         Bq4pT9zaLocE/qDe6p2krm26sNYk7lUzHgVH6ecDzDYjf2QlwefyDmtWe2AEdDvyehZA
         0+hP4I+F/aaFXxsFwg1FCWbglbJPftzMGfzurr/OJ1EyHCiFWtDaDqzlBLpKk5MKX7yP
         UzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhml9+tOuM64N+Kdue9JcVhV+l7dqchXKjApMncn+j4=;
        b=nKksO1mo3m7Y6HDT7n+45FXpMbWl0xjdXvmYUzhuiIejdSzinR4eHvns9YnrN0E0gN
         Rw4iqbjCYyl2YGS/G0+jlNCgjKUjhpPtMu8VMMQIwdFYnr1hEquhJwidfNGF3f5P9+oI
         cX1yMibUWN/gsSifMmz13R2do2zpjpTZWgoN2i15c1qRmWAFxhdlK3gWbq0Lp4aRHJot
         qnFatK7qzBd2XDr7UdWK+40zZBNSmJUhv3NEYft2totac1nHukdMpsCRuJsuB9WIaJD+
         PQSJH5+YpSVZ8tPZM7tVWytSiQAxuyumIZ+Gg7Mu62OqgrDyzVpRIkQ0jdWHni9/00Fi
         dozw==
X-Gm-Message-State: AOAM532U7tXjGUM7z7bc5zMtevB7tZwOpXAltYvx76WhNUrM5hKZRr2E
        C47LeH0bqtP+3oIhVyU1HdXUlCGiVOU2/0zepLg=
X-Google-Smtp-Source: ABdhPJxYxC9hHsGYf7be31oO2/JDQK2thvTuqFu0+yn7vkbt8Nt99d0enk4pQTNw7672n7X2RTSTP2WPSd7fUxcnx/A=
X-Received: by 2002:a17:906:7016:: with SMTP id n22mr14605993ejj.402.1605523988181;
 Mon, 16 Nov 2020 02:53:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com> <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com> <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com> <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com> <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com> <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com> <ca811ad9-5ae4-602e-98a4-5d4d6c860a1c@gmail.com>
 <0acac733-233c-0c71-b9bc-c4bee1c724ba@suse.com> <4dd24fde-6d7f-202f-5d2f-b4478d797a93@gmail.com>
 <fcd272a5-a437-e918-8102-3813a608574c@gmx.com> <a26dc3fa-f68a-31fd-dbf8-692892df6019@gmail.com>
 <d57d7430-c0c5-315e-9d74-08d4b38696aa@suse.com> <1afa30fd-518e-f93e-24ae-e0cd87ce6885@gmail.com>
In-Reply-To: <1afa30fd-518e-f93e-24ae-e0cd87ce6885@gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Mon, 16 Nov 2020 13:52:56 +0300
Message-ID: <CAA91j0XLWcHsj4K4QfMOfQ01a43OJxPO-P246Y-wZ9c=uFP=Ow@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 16, 2020 at 1:44 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> - Built btrfs-progs v5.9 from
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git and
> booting Kubuntu 20.10 from USB stick then running btrfs-progs v5.9 fixes
> it with below log.
>

What do you mean "fixes"? "btrfs check" is read-only by default so
your invocation could not fix anything. Was it the only command you
invoked?

> - Thanks Qu for the help!
>
> Ferry
>
> log
>
> ---
>
> kubuntu@kubuntu:~$ sudo ./btrfs check /dev/sda2
> Opening filesystem to check...
> Checking filesystem on /dev/sda2
> UUID: 27155120-9ef8-47fb-b248-eaac2b7c8375
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 294 inode 915975 errors 100000, invalid inode generation or transid
> root 294 inode 915976 errors 100000, invalid inode generation or transid
> root 294 inode 915977 errors 100000, invalid inode generation or transid
> root 294 inode 915978 errors 100000, invalid inode generation or transid
> root 294 inode 915979 errors 100000, invalid inode generation or transid
> root 294 inode 915980 errors 100000, invalid inode generation or transid
> root 294 inode 915982 errors 100000, invalid inode generation or transid
> root 294 inode 915984 errors 100000, invalid inode generation or transid
> root 294 inode 915985 errors 100000, invalid inode generation or transid
> root 294 inode 915987 errors 100000, invalid inode generation or transid
> root 294 inode 1962496 errors 100000, invalid inode generation or transid
> root 294 inode 1962499 errors 100000, invalid inode generation or transid
> root 294 inode 1962500 errors 100000, invalid inode generation or transid
> root 294 inode 1962501 errors 100000, invalid inode generation or transid
> root 294 inode 1962502 errors 100000, invalid inode generation or transid
> root 294 inode 1962503 errors 100000, invalid inode generation or transid
> root 294 inode 1962504 errors 100000, invalid inode generation or transid
> root 294 inode 1962505 errors 100000, invalid inode generation or transid
> root 294 inode 1962506 errors 100000, invalid inode generation or transid
> root 294 inode 1962507 errors 100000, invalid inode generation or transid
> root 294 inode 1962508 errors 100000, invalid inode generation or transid
> root 294 inode 1962509 errors 100000, invalid inode generation or transid
> root 294 inode 1962510 errors 100000, invalid inode generation or transid
> root 294 inode 1962511 errors 100000, invalid inode generation or transid
> root 294 inode 1962512 errors 100000, invalid inode generation or transid
> root 294 inode 1962513 errors 100000, invalid inode generation or transid
> root 294 inode 1962514 errors 100000, invalid inode generation or transid
> root 294 inode 1962515 errors 100000, invalid inode generation or transid
> root 294 inode 1962516 errors 100000, invalid inode generation or transid
> root 294 inode 1962517 errors 100000, invalid inode generation or transid
> root 294 inode 1962518 errors 100000, invalid inode generation or transid
> root 294 inode 1962519 errors 100000, invalid inode generation or transid
> root 294 inode 1962520 errors 100000, invalid inode generation or transid
> root 294 inode 1962521 errors 100000, invalid inode generation or transid
> root 294 inode 1962522 errors 100000, invalid inode generation or transid
> root 294 inode 1962523 errors 100000, invalid inode generation or transid
> root 294 inode 1962524 errors 100000, invalid inode generation or transid
> root 294 inode 1962525 errors 100000, invalid inode generation or transid
> root 294 inode 1962526 errors 100000, invalid inode generation or transid
> root 294 inode 1962527 errors 100000, invalid inode generation or transid
> root 294 inode 1962528 errors 100000, invalid inode generation or transid
> root 294 inode 1962529 errors 100000, invalid inode generation or transid
> root 294 inode 1962530 errors 100000, invalid inode generation or transid
> root 294 inode 1962531 errors 100000, invalid inode generation or transid
> root 294 inode 1962532 errors 100000, invalid inode generation or transid
> root 294 inode 1962533 errors 100000, invalid inode generation or transid
> root 294 inode 1962534 errors 100000, invalid inode generation or transid
> root 294 inode 1962535 errors 100000, invalid inode generation or transid
> root 294 inode 1962536 errors 100000, invalid inode generation or transid
> root 294 inode 1962537 errors 100000, invalid inode generation or transid
> root 294 inode 1962538 errors 100000, invalid inode generation or transid
> root 294 inode 1962539 errors 100000, invalid inode generation or transid
> root 294 inode 1962540 errors 100000, invalid inode generation or transid
> root 294 inode 1962541 errors 100000, invalid inode generation or transid
> root 294 inode 1962542 errors 100000, invalid inode generation or transid
> root 294 inode 1962543 errors 100000, invalid inode generation or transid
> root 294 inode 1962544 errors 100000, invalid inode generation or transid
> root 294 inode 1962545 errors 100000, invalid inode generation or transid
> root 294 inode 1962546 errors 100000, invalid inode generation or transid
> root 294 inode 1962547 errors 100000, invalid inode generation or transid
> root 294 inode 1962548 errors 100000, invalid inode generation or transid
> root 294 inode 1962549 errors 100000, invalid inode generation or transid
> root 294 inode 1962550 errors 100000, invalid inode generation or transid
> root 294 inode 1962551 errors 100000, invalid inode generation or transid
> root 294 inode 1962552 errors 100000, invalid inode generation or transid
> root 294 inode 1962553 errors 100000, invalid inode generation or transid
> root 294 inode 1962554 errors 100000, invalid inode generation or transid
> root 294 inode 1962555 errors 100000, invalid inode generation or transid
> root 294 inode 1962556 errors 100000, invalid inode generation or transid
> root 294 inode 1962557 errors 100000, invalid inode generation or transid
> root 294 inode 1962558 errors 100000, invalid inode generation or transid
> root 294 inode 1962559 errors 100000, invalid inode generation or transid
> root 294 inode 1962560 errors 100000, invalid inode generation or transid
> root 294 inode 1962561 errors 100000, invalid inode generation or transid
> root 294 inode 1962562 errors 100000, invalid inode generation or transid
> root 294 inode 1962563 errors 100000, invalid inode generation or transid
> root 294 inode 1962564 errors 100000, invalid inode generation or transid
> root 294 inode 1962565 errors 100000, invalid inode generation or transid
> root 294 inode 1962566 errors 100000, invalid inode generation or transid
> root 294 inode 1962567 errors 100000, invalid inode generation or transid
> root 294 inode 1962568 errors 100000, invalid inode generation or transid
> root 294 inode 1962569 errors 100000, invalid inode generation or transid
> root 294 inode 1962570 errors 100000, invalid inode generation or transid
> root 294 inode 1962571 errors 100000, invalid inode generation or transid
> root 294 inode 1962572 errors 100000, invalid inode generation or transid
> root 294 inode 1962573 errors 100000, invalid inode generation or transid
> root 294 inode 1962574 errors 100000, invalid inode generation or transid
> root 294 inode 1962575 errors 100000, invalid inode generation or transid
> root 294 inode 1962576 errors 100000, invalid inode generation or transid
> root 294 inode 1962577 errors 100000, invalid inode generation or transid
> root 294 inode 1962578 errors 100000, invalid inode generation or transid
> root 294 inode 1962579 errors 100000, invalid inode generation or transid
> root 294 inode 1962580 errors 100000, invalid inode generation or transid
> root 294 inode 1962581 errors 100000, invalid inode generation or transid
> root 294 inode 1962582 errors 100000, invalid inode generation or transid
> root 294 inode 1962583 errors 100000, invalid inode generation or transid
> root 294 inode 1962584 errors 100000, invalid inode generation or transid
> root 294 inode 1962585 errors 100000, invalid inode generation or transid
> root 294 inode 1962586 errors 100000, invalid inode generation or transid
> ERROR: errors found in fs roots
> found 444725678080 bytes used, error(s) found
> total csum bytes: 272354940
> total tree bytes: 1862316032
> total fs tree bytes: 1250484224
> total extent tree bytes: 277397504
> btree space waste bytes: 401028956
> file data blocks allocated: 16021691621376
>   referenced 394733535232
>
>

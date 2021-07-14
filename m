Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51CA3C7E4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 07:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbhGNGAq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 02:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhGNGAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 02:00:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B4C0613DD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 22:57:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g12so796427wme.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 22:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=StIOCzDn6VMUekWKD+KNnaCKiDKoXiSDeQzilPhfYr0=;
        b=avSc6MX/1GrybbbFMqgWYsMQSCb3nt9j80L2p5f7AoVu4MRrdah4riJvak14RnsWnH
         pXmU2VINRaW6xUwz1utBQfpJpNY61vk03A6o8myPnWLHSxUnrPWIJ+HwrCgsQ96NuD+7
         AKwUd2QSFsBXdctVoGqEo5qHwTPll0BpY73rEp06tpG5KWNRgrmw4M/uahb6Q5RKQZIu
         q36GBJU5aqWMdWaivjhPhA1k5Exov/FDS6Hsn8x3r/J7wD8C/84N1Nx6KX/n641Cdy9j
         pNWdDHI/3J5uJUPbPSezYpER5aEWHmcDiy7nY6TOkWua+epdq463+tKvi4ukn0ffbaGV
         UvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=StIOCzDn6VMUekWKD+KNnaCKiDKoXiSDeQzilPhfYr0=;
        b=dIyLCbf313hlH4ZDs1TZdZFqEtY5PYVwEYViS2fiidchO6WWc4BGXgORyLv9CywIEw
         tzvqEwwDdX5mNNqtsVjAjoxbeX3BZ6CC5bniBk+G8u+dryLfGs+C1EoM707WcdGNx4EV
         3RRDzahuzr/NWmSVsoVDI3dvFYPbqd3J1keOiv/HiT0KzR6pa0UJfgwkw90kxB34/AZ7
         ojy5ZsVRYKmhEulatXoHGL0yr+olxe+r8MoqjPKQEBSQtDvE+1Drged2JITQ8z8GXWJa
         pND8ELmwapCGWNnIwDvCDRAEXCEq/8WRl0su0Up1NFjNho+XjXexvSkU6BaJvrlvzLjn
         W2ow==
X-Gm-Message-State: AOAM53250uEwMwLXdsOyKgDEJlMLRNOE23XLckeUVI1ODjsyRiC/SeQj
        ksrqxIBtlZFZYQ6fixkA3MaDa+ipdQTsvN8rdgb5+YoQwZ6o89bF44M=
X-Google-Smtp-Source: ABdhPJxDeTzu0EVz4Xtmr//AU0b4tS3mlOY99Czz04advqeFIKAaMwRSGYfSv64a///mj7DRJCp25JBfteaCX+UpgvU=
X-Received: by 2002:a7b:c949:: with SMTP id i9mr9220770wml.168.1626241475984;
 Tue, 13 Jul 2021 22:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com> <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
In-Reply-To: <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 13 Jul 2021 23:44:19 -0600
Message-ID: <CAJCQCtTFkYHocpdqtS=1y-At11wz5-Kv4Tx5D-QeRg9JpEGdMA@mail.gmail.com>
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     DanglingPointer <danglingpointerexception@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 13, 2021 at 10:59 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:

> > 2. If we use space_cache=3Dv2, is it indeed still the case that the
> >     "btrfs" command will NOT work with the filesystem?
>
> Why would you think "btrfs" won't work on a btrfs?
>

Maybe this?

man 5 btrfs, space_cache includes:

 The btrfs(8) command currently only has read-only support for v2. A
read-write command may be run on a v2 filesystem by clearing the
cache, running the command, and then remounting with space_cache=3Dv2.



--=20
Chris Murphy

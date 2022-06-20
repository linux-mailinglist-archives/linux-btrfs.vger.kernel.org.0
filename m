Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B295525DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiFTUhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 16:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiFTUhn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 16:37:43 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A520C19286
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 13:37:42 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3178acf2a92so77682187b3.6
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILLLhm57Dx98/Pdx1wBHCH2PjNh9hIHlezuFSJOnSdw=;
        b=UpWHJfB1LxXIN0ByKZXsId8h1z8ypZ69WQ80X1Fohqn+uwib1Qo61J53ziubDfW3tR
         Bd03ws7XQrpilpMEcRYMkiwCc+L2IuSqQcuA4IEsRbiIh0UeZeWT/W1t7ByqujN4t+i/
         R5T2+0VA9RGq7RfTAevuyLa3moK6bS0MqLIpcVraxL1Lcf3MgtFNTXRWFgJIBcnu9Cu1
         qJzUKv99p1glkBe9ZhlT+v3xd3AJ29c63vCNyxizFKQfFGRqCQXJvq/IpRW4IFxhNV5y
         bHXrgJbPSEGBXdEzNt0So1R4MtgjmzTP3R88BEuJkv+tNQMXvMM7VPE36TMilpLpw6Jn
         0UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILLLhm57Dx98/Pdx1wBHCH2PjNh9hIHlezuFSJOnSdw=;
        b=rEoO1Jy0ysoD/PUVcD0Uff3sQUFWvI5WDZAE4b5QU3Dd0YMI3ozUPd/1+VBDOKrpN6
         pI/NX7gAPIrseqppaV9CxAOy7EsAGHBylKQcdVQerxq2D4ojFgH3RU96g+84h/VWIsXT
         sF+YEokT9Upjg76ryYEniRkQk9N8TAzpT9nDygrQw9dEUaj7Qrq0YgujoVWZBd9ex/kG
         HKyNsHtKvO09F9j98LYlFDZ305+5M8UvFOdqTp9wwP8DFPpGQcOkuauIG/B3ul6+0zfg
         ABhHsDJMnuu1osd1j/RlKnkiLL09e6KS5IoGpw79UfmqeLRaGhjaRwO7SfrATGoov9ts
         LerA==
X-Gm-Message-State: AJIora+xleQiUKsgrSfFiIn6VEF0X0K1exo5GbznXIcvzUKr9HqfVETi
        8s0p3fw3ZdR2u58kWvzAXY4zQ2WKZx0DkwGA0CRNa1GuPXU=
X-Google-Smtp-Source: AGRyM1sLDJRREVB+ioGYhriUsBqMUwBvvSQqAqs905Olqz4OdKSC/LaX1m9EBRKideMsqIw4CbVvZfaBDGxGM2oEkD0=
X-Received: by 2002:a0d:c603:0:b0:317:ce48:51db with SMTP id
 i3-20020a0dc603000000b00317ce4851dbmr8635896ywd.363.1655757461717; Mon, 20
 Jun 2022 13:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220611143033.56ffa6af@nvm> <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org>
In-Reply-To: <20220611145259.GF1664812@merlins.org>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Mon, 20 Jun 2022 22:37:25 +0200
Message-ID: <CAK-xaQa0n8q9Fc5-t-pJfu4yrwO28A7dzEOgytzedbhL3N3v-A@mail.gmail.com>
Subject: Re: Suggestions for building new 44TB Raid5 array
To:     Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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

Il giorno sab 11 giu 2022 alle ore 16:53 Marc MERLIN
<marc@merlins.org> ha scritto:
> Mmmh, bcachefs, I was not aware of this new one. Not sure if I want to
> add yet another layer, esepcially if it's new.

I share the link just to say: bcache author works in a great way.
Bcachefs could be the idea to replace a few layers. Not to add new
one.

Just for the record.
I'm using a 120TB array with BTRFS and bcache as caching over raid1 2TB ssd.
I tried same setup with LVM, but - sadly - lvm tool complained about
maximum cache size (16GB max, if I remember exactly, anyway no way to
use the fully 2TB).
Sad, because nowhere they mentioned this.

Played a little bit with kernel source, but eventually didn't want to
risk too much with a server I want to use in production at work.

On my side, in the end, I really like cryptsetup for each HD, with
mergerfs and snapraid (for my home setup).
Very handy with replacing, playing, experimenting and so on.
Each time I tried one big single volume setup, eventually I regret it.

Ciao,
Gelma

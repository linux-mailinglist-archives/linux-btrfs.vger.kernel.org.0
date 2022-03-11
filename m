Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710C34D6B1D
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 00:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiCKX3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 18:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCKX3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 18:29:50 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02E55776
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 15:28:46 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id n7so11075434oif.5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 15:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51W00mNPw6yuewUz6HhyhD5ttFSn1qgx77nRDwchw0Q=;
        b=q687htx/DY9UEutpAOYTGByu9RV/pTPRiBrTkkPnmNxKCl2SrYoCd6pkmKJlBY5xOX
         VHXHHNItLGLp8Xz3H+xjNISZQR8Q2Dq69WNBCcpd8CQJYH93KpGSRFilbrGbqpMjfV0b
         LYnu+4Lp2yPytH/6Se4YMeif84OBe6V9LjjnJG+C0Hdlis/JemMx+3GztqOal/OBW7oV
         qT4zde0h8DvKeT2gG3sQyjk8feNh0ateJ5O4SjEVfQVUokS9lZKVutL9drj2Z6JQTc+Y
         Z94NXn2iDb7o/2bkuZGc72lJMIfY+CoUhfNCJugDQ8yrUGJ2PD80Gd0BloozRPOKq40W
         f6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51W00mNPw6yuewUz6HhyhD5ttFSn1qgx77nRDwchw0Q=;
        b=SghKpd6umhkKUm2PvQ34ESAmWqjBrrdoqCvxDiL/iTgA2LPIzmWNdSUQu4JToaaoKC
         VlpqGtiCaSAUHxXh9eg93J/pLm6xVdqXEuFtjZscRD3S4bCsHPcUSlVNx9Xw1WNTHebE
         82A/nYzmQKT8hrts4h00rFE1cOxCxdbQOZWWaO0r5qgKRcfbXXAULiwXYxCARBBw2Klb
         Ii+BG3E1+aqFMC0lt97U+aBCq2A0A8n1yfKKQTdrhP5suTNuoYIcU+TK/8re/oZhQ1dF
         sOgcI+taeXm71k9jA5q/ujD2W9ijfgym+1j4qG+ytyffUbcMIUNh3NeewbEfzYqNRGNR
         SHCg==
X-Gm-Message-State: AOAM532P6Aktiu6q/FWEEVBDsCw0UfS0BDbTonOXPiu3dN5xBteEzoX4
        XD/On/zRBbv1X4s0X8ZRarxZlRNfLedIxrKRjFh622vc
X-Google-Smtp-Source: ABdhPJzIXqBLArrXuRjZpy5PipViOW/wgGfn4Z5s0yQGvWbnb6f8Obiqby6pVPuclsEeIgYL4mxn1E2la6mDG6U/02A=
X-Received: by 2002:a05:6808:2117:b0:2da:5906:22c3 with SMTP id
 r23-20020a056808211700b002da590622c3mr7848845oiw.80.1647041325866; Fri, 11
 Mar 2022 15:28:45 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com> <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com> <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
 <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com> <e7df8c6e-5185-4bea-2863-211214968153@gmx.com>
In-Reply-To: <e7df8c6e-5185-4bea-2863-211214968153@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sat, 12 Mar 2022 00:28:10 +0100
Message-ID: <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
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

On Sat, Mar 12, 2022 at 12:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> As stated before, autodefrag is not really that useful for database.

Do you realize that you are claiming that btrfs autodefrag should not
- by design - be effective in the case of high-fragmentation files? If
it isn't supposed to be useful for high-fragmentation files then where
is it supposed to be useful? Low-fragmentation files?

-Jan

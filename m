Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964CE53B07F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiFAXEv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 19:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiFAXEo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 19:04:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14932997A9
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 16:04:43 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p74so3255818iod.8
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 16:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KdX+WOz851Zi5IwSkUW5O6Q/nZ3v2ryUMiGkUgNIzs=;
        b=Ib/SwgRIABTahsGQgTsb5+GRk+/nLvvXc43jem3ywHl8+CJbuUbfPXESILcZ3RK5fA
         ymL8CNHRIT2OcfidkKCLE4hgWhNbbDRD1ZEr9sR9BSCwvSedl5QaScNLoRbeXWsAAExE
         QVqBWfYviKKYErO1Od8YwvA+F3AZ1de29JAaocw/dARa5CdgHVYwosb1BuGVtR8CPYnI
         QeuTrK8MecE88bjl2tdBA5A8XbQ46sFIu1OymIkwmPc7Zapfv5JpDDh2qYJpB8KlEKOU
         S6maUxBJlMVL/XVw39NU/lQ9tgK9cck5eFcWU2aahnoPshffkeo95CKghKiJVEPpsMOb
         JUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KdX+WOz851Zi5IwSkUW5O6Q/nZ3v2ryUMiGkUgNIzs=;
        b=1kc2DpS+wMXyekaUDDvvnsIzBdMkgnr5YcvNqpfIdxfajWY/ln7M3mjZt1RqTO4HF4
         gqiN3W3oRMGph+APZWaPcFE4YFbzduVrXFotRvLyOgEn5FjaQRtLDyoABVEeSlHCDkUu
         ucEz8uJJpepgWhC5rAxNSUmlfcxZc2BMdKruDkZQUrnUNAHSBrkRyJhuMd+q7A/CipPc
         wFTuoCPeIfXsvTUmyGOvoMf6h+cXJy78Bgm1CSBHMARIQOUBxiu07DyePHNeRML/relz
         OmvFAzCXGxC3CJ3WXNThlwRdub7EV0bFRkuP8Qm/ka9tm5vPMNMlVxrVXBJ4oNTYvY1/
         NkUA==
X-Gm-Message-State: AOAM532qFlhl5KoscotqtKnp6CAQJB8el7Se+egeMPhqKDKHjsdfkVA5
        Yv/z23OudZV4hHewJNIQsdwpuiTKYiRQQIYYr/ka2mMQH/U=
X-Google-Smtp-Source: ABdhPJwXM4CxJDNG0faGWVnmg1QNic6WqLE3c6mB/aElS8hFXY5iyQ9XC8Qz7os15JjRROvOiF+anuQE5uv4NMZbvR8=
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id
 a4-20020a029984000000b0032daeffc592mr1473533jal.46.1654124682788; Wed, 01 Jun
 2022 16:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org> <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org> <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
 <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com>
 <20220601214054.GH22722@merlins.org> <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
 <20220601223639.GI22722@merlins.org> <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
 <20220601225643.GJ22722@merlins.org>
In-Reply-To: <20220601225643.GJ22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 19:04:32 -0400
Message-ID: <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 1, 2022 at 6:56 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 06:54:31PM -0400, Josef Bacik wrote:
> > Ah right, I have to mock up free space since we can't read our normal
> > stuff.  Fixed, lets go again.  Thanks,
>
> Found missing chunk 15483956887552-15485030629376 type 0
> Found missing chunk 15485030629376-15486104371200 type 0
> Found missing chunk 15486104371200-15487178113024 type 0
> Found missing chunk 15487178113024-15488251854848 type 0
> Found missing chunk 15488251854848-15489325596672 type 0
> Found missing chunk 15671861706752-15672935448576 type 0
> Found missing chunk 15672935448576-15674009190400 type 0
> Found missing chunk 15772793438208-15773867180032 type 0
> Found missing chunk 15773867180032-15774940921856 type 0
> Found missing chunk 15774940921856-15776014663680 type 0
> Found missing chunk 15776014663680-15777088405504 type 0
> Found missing chunk 15777088405504-15778162147328 type 0
>

I swear there's so much tech-debt here.  Try again please.  Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1982E8205
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgLaUtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 15:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaUtq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 15:49:46 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DDC061575
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 12:49:05 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s75so22872286oih.1
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 12:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=al/okKcs0ej1kbHT56rQb6AM5oWIR66nfqIX6r9ebp8=;
        b=CFanRbWP/1FSM9vALyOev2bms6OfwNo5sPwJ4+Ga5xz85RfkdMF27JOy3bl4Bjxn86
         jFc5Ngi8pr0qPSDifAWf0MxgUy7aZCNOkgmoAHAeegbV2grd201vpNSRzUVVlhJTpBFz
         PaT+2TCcw8+aXTP5t4wrqPG3X++DUINZ6bvAhmdJMCgkgYP5ts4AFPKdSHWqQqrzVYbR
         +k9YBKwxgoamprahdsFncHv6VM2lrbIZSvhNqomqK5VlCjoCK0DDpYD+cZBSV63loDtF
         XMBfV+S24/gxPMOS3lst7b+1CdZH6CNKRQt+3FumUoUn06EtBiUZc8HNh9h/tsGKyVe4
         EsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=al/okKcs0ej1kbHT56rQb6AM5oWIR66nfqIX6r9ebp8=;
        b=fj99WDf68ns6J8rc6fHiEeI9NO2J6yr6O3DVDDPy/JObvQT2tR3b5R8M2Pdt4Osm0X
         WPegtL4B9QoAfTofGx7V+iQ2ux6o3yfLuwdTlAR6r48DY1Jwut//ssB+BrTLPuNXBTjs
         2//3JksRCw0V066RvxT+rFV5sA9pk3bUvVeT6OhbvlfKWjtg3IoqWg22daVprYxzVPY5
         zOLrJx7TGBQlMV61A5D+obCTzzwZIdZTPfLSM8Up6rg7gv3fPLigjQ9gJ99tbG7FbAx+
         NwRF86V5/g2geYQBYmTxoxkso9ScqCFf8EmFoWfKPCCDEYS5QOSW3MpMrfVHMeIKm1cp
         f24Q==
X-Gm-Message-State: AOAM531y8PCF9Gepn57zjep8Yd/w+PU5KjXpYZJPW4+U2z1bPKP/KfuK
        zbnVe2t7MX/fvLMzvYl4tN10ZPaeGgLy26WrUokJJDHR7TyAMg==
X-Google-Smtp-Source: ABdhPJyH/J2WpZwzHRsJ/jsWEKKLxUc46b2Pxl4GCZHkMJ61ogoZAjcSQ40phI3hJLRygAyojga9xj/7T/DpI3BOIE4=
X-Received: by 2002:a05:6808:3bc:: with SMTP id n28mr9117900oie.118.1609447745207;
 Thu, 31 Dec 2020 12:49:05 -0800 (PST)
MIME-Version: 1.0
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se> <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com> <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org> <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
 <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com>
In-Reply-To: <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com>
From:   john terragon <jterragon@gmail.com>
Date:   Thu, 31 Dec 2020 21:48:54 +0100
Message-ID: <CANg_oxztFRbw+NqHbnvvK6HS3g67hDkSgk6TpMbd-zgYSv9URw@mail.gmail.com>
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 31, 2020 at 8:42 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>

>
> How exactly you create subvolume with the same content? There are many
> possible interpretations.
>

Zygo wrote that any subvol could be used with -p. So, out of
curiosity, I did the following

1) btrfs sub create X
2) I unpacked some source (linux kernel) in X
3) btrfs sub create W
4) I unpacked the same source in W (so X and W have the same content
but they are independent)
5) btrfs sub snap -r X X_RO
6) btrfs sub snap -r W W_RO
7) btrfs send W_RO | btrfs receive /mnt/btrfs2
8) btrfs send -p W_RO X_RO | btrfs receive /mnt/btrfs2

And this is the exact output of 8)

At subvol X_RO
At snapshot X_RO
ERROR: chown o257-1648413-0 failed: No such file or directory

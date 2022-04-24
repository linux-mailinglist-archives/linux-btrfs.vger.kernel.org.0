Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8450D5FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbiDXXa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiDXXaS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 19:30:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BCC6A045
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 16:27:13 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y85so14189884iof.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 16:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rOgHzJrWeliCnySJ4m6HKwOZAYR61+42192DyFg9FE=;
        b=8JEoXoEFzNuV/xI/6I1Z5t3tv4zw9Z3ysxHi8W+Sn4TPoQIq7BWBt6rmjPRjACnlHM
         XX38p0eS7TeqPBCLv6v4TMrLoAXWfZEwbFApwkhHjB4azwomBJ4mPbClvbMwAnoE9Gfc
         cECrZU9dqRdnvaCTnD86qqzJUYoHdvcXDmvetO9CCgdFQ0/FqcmSFsQQBup95q0OlRlF
         R/Q1bg/qrIihnAkbTXBTRPKilq1O9NiGHYu3iXURHujOEsLZ93mp0wy6XzY6PsgnmKpm
         TjGlTIac7gchMTcUCwtY/My9P2vHvw+uBMwGUUvJE/qgT6VEbh55CwaLEuE9F1A1IM14
         ufTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rOgHzJrWeliCnySJ4m6HKwOZAYR61+42192DyFg9FE=;
        b=whDvG1Ib9KQ4TZbhyKMpvfea9VTeIP4ujAEtAoYQH97KJ8nRWolI5aHEMR0u/FXSgQ
         y0XOD0O7tg0cnCN7Wznr5paUa4iQRai40hwdkXl/NEA7HuR61JC/M+p0Lno/Q5wEYhqM
         XvINDuGlDU8E/WZ9DJviQB+sbW0cgAlJ5bOmUImzdRmZaR1VApS4d2ylyqrX2EyGdyn8
         Mg2CxZN7bw4HtCn7hoHJ/XkbmtN7lFHNFQ7JhATQb/iYw3GD8vlT69TIJipJgblV6tNK
         SVAyKLmQKHHaEzgdLvxUa7ONnpAlemSU0cfTRq8UMXPrybzJPjtQnT4KPKnoWdZ2lYui
         XphA==
X-Gm-Message-State: AOAM531WIy4Te/zrhedclI3DTCto5WZmKiDD821uuh8Obx7HSH5NZKac
        yaSszSpIIP8ZQ5gWLtI8JX/oZZv7YlI/h+6vVRttoZp94nQ=
X-Google-Smtp-Source: ABdhPJxBcsTQvkq9OCr2hy4OOB6Bq0da3xMmfz4ITC/yj/vy++7iuntEIkcnNpFwM/XpATE7JnL4hS/uLJsnWyrCrgY=
X-Received: by 2002:a05:6602:14ce:b0:657:2bbc:ade8 with SMTP id
 b14-20020a05660214ce00b006572bbcade8mr6096424iow.83.1650842833049; Sun, 24
 Apr 2022 16:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220424203133.GA29107@merlins.org> <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
 <20220424205454.GB29107@merlins.org> <CAEzrpqeVQQ+42Lnn9+3gevnRgrU=vsBEwczF41gmTukn=a2ycw@mail.gmail.com>
 <20220424210732.GC29107@merlins.org> <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org> <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org> <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org>
In-Reply-To: <20220424231446.GF29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 19:27:02 -0400
Message-ID: <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 7:14 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 06:56:01PM -0400, Josef Bacik wrote:
> > I feel like this thing is purposefully changing itself between each
> > run so I can't get a grasp on wtf is going on.  I pushed some stuff,
> > lets see how that goes.  Thanks,
>
> After all the tests we did, is it possible that some damaged the FS
> further?
>

That's the thing, we're literally deleting the entire tree and
starting over, it should do the same thing every time.  I pushed
another fix, I think I've been messing up the buffers and that's why
we're getting random values. Lets try this again,

Josef

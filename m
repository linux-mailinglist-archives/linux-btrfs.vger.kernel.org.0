Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6B4C806D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 02:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiCABps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 20:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiCABpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 20:45:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14121B45
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 17:45:06 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f37so24384118lfv.8
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 17:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kodOlkpnY/cQi4rkoNOKxDYhR6tBFMlz0MzRrzzynrA=;
        b=FnnXxGvrAGNLzax4Ndakyj5mTurkJ66hb3fdIGP9ZDsq1ichX59O8J1XJuP/r79zZ3
         adJt2ie87ci1fzt4mrzR0kGIBr/3vSTwbEK9v+jGn1PIKVn6lUXWSEHxUUuGLozRHMAw
         rsSug29MvqU2hJrj+LSjJoFr/mlqNM/lHZ0f3VYeid0canzgYDgRiUfye2d0HJqkSa9x
         2Vkz9hy3Il5TfxPhMl7E7jiiO1ZjkeZfh5Bn0WfL7M/j3nKB8zbQmWu2S5co+Sd4IN08
         k7hi6EyXmcVOwlfy6ELQKSdGE/ba+diVw2Wsu29fyXS+ilvG4jHPyClj8uAysA54Q8R+
         9aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kodOlkpnY/cQi4rkoNOKxDYhR6tBFMlz0MzRrzzynrA=;
        b=dhBLBc8vq6JIOVfe2dW7qac4bJ2Ed49mTpo8VXoSIRnvqrTxYA3kNuQQ2eG8EuLwD6
         LQPGfpp4tEAN2Tv6ia1RavRi+mkaB3gYm8ekMMfJPPSKvI5x1SPhBOhNLnt4sEbQaXi+
         nZB/2qRS9AaHZgl3DL2h9VnxYupeeiLtzrlmW3keGDFD/M3LwFs5fZa0bcJDG/gelXcy
         jj3qX2FBApiLj40hf9L169IzvomrbUHeLy6YWzeNccO9wXxyGVTCbZv0tpZfmtUKu9t9
         ksjQcFbzBfmnXF6wjSsbW4IVUzFpFAHmo2Gs7al9Pzni+np+Xw8gjR4IKATXpPSl021A
         Mb5A==
X-Gm-Message-State: AOAM531t0rAUoiQ0mz9wRiu7FhFYyi6m3VFxu67rCWMAPCg8u9oRsQhU
        an80sMPruc+4D6HSATT5+Eap72ZkzxAeT+xLfrKRCdW0p1jKyNgHoHs=
X-Google-Smtp-Source: ABdhPJzTwoMZNp/pMJucfFC/5I3eVfNca1erHU82Fm2XkYEuq43TJJ2+DiJs9mequdC/2lICViY4zRFvXDhNaDVB4wM=
X-Received: by 2002:a19:f80e:0:b0:443:7eba:1b89 with SMTP id
 a14-20020a19f80e000000b004437eba1b89mr14500000lff.446.1646099104249; Mon, 28
 Feb 2022 17:45:04 -0800 (PST)
MIME-Version: 1.0
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz> <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain> <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com> <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
In-Reply-To: <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 28 Feb 2022 18:44:47 -0700
Message-ID: <CAJCQCtSHCn7Pit7TgLJUTmMg9Tb87DdajDGDvM_bw=bsb8h_jg@mail.gmail.com>
Subject: Re: Seed device is broken, again.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 27, 2022 at 7:35 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> >> With method b, at least we can make dev add ioctl to be completely RW in
> >> the long run.
> >
> >   Could you please add more clarity here? Very confusing.
>
> Isn't it an awful thing that device add ioctl can even be executed on a
> RO mounted fs?

I think it's more idiosyncratic than awful. It is definitely
confusing. But I think the explanation is that the ro mount is a VFS
option, not a Btrfs option. It only indicates we cannot write from
user space to this file system while it's ro. Btrfs still can,
including playing the tree log (and I assume it updates trees on disk,
even if ro but without notreelog.

There's a wide assortment of confusion in the `mount` command's
results. You just have to depend on rote memorization to know what
things are VFS or file system specific. Maybe it'd be nice if the
output were clearer but ...

/dev/nvme0n1p5 on /home type btrfs
(rw,noatime,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=271,subvol=/home)

Is seclabel VFS? Or yet a third domain? Anyway, for example:

/dev/nvme0n1p5 on /home type btrfs
(VFS:rw,noatime,seclabel)(btrfs:compress=zstd:1,ssd,space_cache=v2,subvolid=271,subvol=/home)


-- 
Chris Murphy

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CCD418D1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhIZXnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Sep 2021 19:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhIZXnz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Sep 2021 19:43:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3AEC061570
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Sep 2021 16:42:18 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so15124314otv.4
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Sep 2021 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EsRKKWYhtvR5FEj5Yxt9JYN05curAVZZmt+hCjP0iQ=;
        b=JCk51LfaPAGiy9RKMzzZdJzGEXKiA7EGWhd0exwCsdU90zggs5/mzSXWPOkXQ6AAE0
         YTnnCwW6HkV3Lh/XQACrHKPEEfolA8FWsEsrFENkEVtLQbCFPcmbZXi2/AtyhqFJejvM
         0PbhfL8GhJwv0IjfEQLjOuu7ZUYZNxqRcV/Pb7rFjhuVVzk2hzNOsptg2NP88obAoDRj
         AMdJD/z3R9R0S4OPisn/upGNlD8LOKS63cJPMrv2KQdqwrGSorzn8BqYNGcVdt2GCXkZ
         ddN2polOyl0IvBrDEsgPvomweiPACdlcxAv/pYTp1BC7RhzJiu78nWOkL4qDhTfiXW7G
         hgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EsRKKWYhtvR5FEj5Yxt9JYN05curAVZZmt+hCjP0iQ=;
        b=DIqCdM012iWdnhILPQhsqvtwSCS5T7rEsUNab+GnQviSL+wtoyRp5OYctGhKAhT0GI
         Z6NQmOcjVhp44e5NiRP0Ed/8ejWv3s/iDURCpMRMDJdZoJkJ66uAmFk7OMmo+DNgvXBH
         iAWmGGVuIqYvzUJffwUiAu9qrpaCjrRpTDvA0izBnQ1HYV1uKPCObeagdxIA59C50btM
         pa9wMHkeGbuC+qUP0GiPM1rFw0odtFAXYEuNvV+79EPZost0OUcZkoz8AtxMSeLKVeHv
         Oc7zerid0D6PGo4tnRSxq7lV1v2mJsPk/S0RTSrPi6z9AJG90E/j7XsPOT81bhk2ROEA
         ZgOw==
X-Gm-Message-State: AOAM533YfjFtt8Vz2dnQhO+je0Lvaz6Y21gKZhLQWyTJppdGy364zxKK
        EDuODzuZjCYsrMRzskpn/E8I407egO1cB7vZ3dp5w48BMu8L+w==
X-Google-Smtp-Source: ABdhPJw39qFjoS+mbujvdNRYk+XuPOjxF1108C3JHrcw/+haU3Wy+vBKvA7CmOkFUSzTBFwZIk1S161aFKuv3pqUhgI=
X-Received: by 2002:a9d:5f82:: with SMTP id g2mr14691058oti.318.1632699737616;
 Sun, 26 Sep 2021 16:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com>
 <b57cace4-fc85-2a5f-e88b-d056b12a2a0b@opensource.wdc.com>
In-Reply-To: <b57cace4-fc85-2a5f-e88b-d056b12a2a0b@opensource.wdc.com>
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Mon, 27 Sep 2021 07:42:06 +0800
Message-ID: <CAHQ7scWo2hF1r0k5_NG2kfAuy0yMxjrym866cGpxRf2Oc2cbMA@mail.gmail.com>
Subject: Re: seagate hm-smr issue
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
You are correct, for a WD/HGST HM-SMR disk, it takes about 15 mins to
mount a full disk.

But It takes about 2-3 hours for mounting a Seagate HM-SMR disk.

Have no idea why Seagate takes so loooooong time.

On Mon, Sep 27, 2021 at 7:13 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2021/09/26 22:57, Jingyun He wrote:
> > Hello,
> > Btrfs works very well on WD/HGST disks, we got some Seagate HM-SMR
> > disks recently,  model number is ST14000NM0428,
> > mkfs.btrfs works fine, and I can mount it, and push data into disk.
> > once we used up the capacity, and umount it. then we are unable to
> > re-mount it again.
> > The mount process will never end, the process just hangs there.
> >
> > Anybody can help me with this?
>
> +Naohiro and Johannes
>
> This is not a hang. Mount will just take a looooong time due to an inefficiency
> in how block groups are checked: a single zone report zone command is issued per
> block group, so with a disk almost full, that takes a long time (75000+zones
> checked one by one). Naohiro is working on a fix for this.
>
> >
> > Thanks.
> >
>
>
> --
> Damien Le Moal
> Western Digital Research

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC42719D112
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 09:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbgDCHUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 03:20:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgDCHUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 03:20:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id v7so7068641qkc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Apr 2020 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vM4RH7PBgxxQlmbs2ck4eLnfsUC8xWw95wkpl8biPAw=;
        b=Di00c+DjA2MOq1wrLZrqQ6294WGTHttqC3k3mTVxpfLaYBFP8ltyrOIEnPCUxjx4A2
         +spSLbfOjmIonwDjVJXVqI4Om54zCJroGZGhcnwPLWorqV8PrEreJ5ZsVX2KwOBNCmAP
         FMfqpAjDQVhiKsjDEVECFRys0XM1nSyJNrZK0rHP0wD7DPwt829QwP34i3rKq+eTqnKi
         tGBWIpkNSNDmkMC8kYDYAMrB8iR/vLInCLmTY8DkTv2KZQ0rhMkQsIUcJ86yD6lbm8W9
         cMmdx1tZov3+FHqILub3hBWn4vEnTByVkbYnXa4K1V/aeW+Clx8140obENwbaO/Mek+g
         cjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vM4RH7PBgxxQlmbs2ck4eLnfsUC8xWw95wkpl8biPAw=;
        b=q2yzveexmH1oeBF27zRX2HVPbYqvnbcf7UmCcU1iO2JSQA02I0ubNSR5lO23ymTja5
         UUg3Y2Tb+hqosYxvaAPLvALT3xP2CSzFtFbuxndU3v3a5vSxfnarnURWznZe+RIVFuqE
         kHk5Co5QDMI4Pu3vrjVaZQcgKPYnTyi6Haw/2y7Adjh/rTQxKnfUcDzaMDtcSSUQ3X/D
         3h0f0kaFVfrcMASKLzjJwdsCF9OQvu+5l7ovJJoIlsDegk6JoyhCjhsXqfRlE3T2z75F
         7AwDIouVYT75WymGAHbNYuPMMyIeE2Gjhk+Cc4tlIM0GUhFIe8My3Lr4wAwPdrrz8/CJ
         adPQ==
X-Gm-Message-State: AGi0Pubg2VPoBwWkYWwEfsV/PD6/Zfjo4iyyZRc8vnYjqEaBtfZAuCa/
        lSPRcGF6cK6ZMC1EgsxxIWM1IAi+dAiQQI1rUF8=
X-Google-Smtp-Source: APiQypIyLmTBF2VmvErxlvtxYVsyXdmDyuWsFMyYHaFogt+eikreTPFgv0x35s8E6BKplLpqbklgdvhuWf/1gEc+aPI=
X-Received: by 2002:a37:a84b:: with SMTP id r72mr7540165qke.414.1585898433809;
 Fri, 03 Apr 2020 00:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com> <20200402211415.GH13306@hungrycats.org>
In-Reply-To: <20200402211415.GH13306@hungrycats.org>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Fri, 3 Apr 2020 09:20:22 +0200
Message-ID: <CAK-xaQbbadKhN75FhVeMkfDOBvY0N_=CaUVLs0HxYKyVLFyx4g@mail.gmail.com>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>, neilb@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno gio 2 apr 2020 alle ore 23:23 Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> ha scritto:
> mdadm raid5/6 has no protection against the kinds of silent data
> corruption that btrfs can detect.  If the drive has a write error and
> reports it to the host, mdadm will eject the entire disk from the array,
> and a resync is required to put it back into the array (correcting the
> error in the process).  If the drive silently drops a write or the data

That's not true.
mdadm has a lot of logic of retries/wait and different "reactions" on what is
happening.
You can have spare blocks to use just in case, to avoid to kick the
entire drive just
by one bad block.
It has a write journal log, to avoid RAID5/6 write hole (since years,
but people keep
saying there's no way to avoid it on mdadm...)

Also, the greatest thing to me, Neil Brown did an incredible job
constantly (year by year)
improving the logic of mdadm (tools and kernel) to make it more robust against
users mistakes and protective/proactive on failing setup/operations
emerging from reports on
mailig list.

Until I read the mdadm mailing list, the flow was: user complains for
software/hardware problem,
after a while Neil commit to avoid the same problem in the future.
Very costructive and useful way to manage the project.

A few times I was saved by the tools warning: "you're doing a stupid
thing, that could loose your
date. But if you are sure, you can use --force".
Or the kernel complaining about: "I'm not going to assemble this. Use
--force if you're sure".

On BTRFS, Qu is doing the same great job. Lots of patches to address
users problems.

Kudos to Qu!

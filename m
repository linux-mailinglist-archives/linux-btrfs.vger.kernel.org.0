Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC91404631
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 09:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350553AbhIIHbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 03:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbhIIHbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 03:31:41 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20D5C061575
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Sep 2021 00:30:32 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id g16so464636uam.7
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Sep 2021 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=bRi6g6mG8Vl/pLiRP5v/LMl34JFY0AShwH7fRfy+E7Y=;
        b=osMFkp+bByyfUVkU9PjS5W+qSzCwa6PGaIZfQbL2pD1MdZdcU2aqsX/BIg1eq2gI6e
         IiVE7oogt2ch5c02+SmRfGJSr6sXAoEo8WEoga3Pjp/MohhAJOGueCHbTGJ1u7kvVvWL
         D/6ntT+R8lR36iZqtf05hR40Ro5R90T5XaCn8hHNCbDKegYUjMv3Jmh4IgropN9ySyQg
         L4oDu4un+4Si5r6S8fwtUHWYjwUYs6i1to451CKZxgQAeycbrbL4xu0VpGzu+MRxFUgC
         2c0PeHToBoQAK/VszvO5fqckNeCzcgmJ+b0V4xHDsObcBoSTld0JSF9QVU8ydmdZFWuy
         Q6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=bRi6g6mG8Vl/pLiRP5v/LMl34JFY0AShwH7fRfy+E7Y=;
        b=4Y8sPXrClDRG4kynOVpcLPHNbM7OBuldvfBQ8Qy/GKndUm/Kd3fvOuLUiz8bPfmfDq
         R3l3Mj8zztMKc9lGU0PDX80DEE0qX8dpuQxfsJ7GoIHKTC3umg6Vm6qXDVXbavM3zkLn
         KPV965l6ZbyqvtScur+C0aM85foOhu+txgaAIQ/VTmCUI2Gt2e8guUhinpM+ElJL7BXb
         piRcZuxCDQGnaFQJv2BLa/KHSeZVaf1rsQrbSemUhWp9IfBNpVoAbx/60bnbjLcQGDEF
         UKJEPdSYd6JemsoacH97ydY7UWuNZRmq5vsQzIgKb6Y91hUhH3+VrfY2hagl2JoyhjA9
         Pc4g==
X-Gm-Message-State: AOAM53282AJSi+srK/OyxwxObh7W7wN8Wrn29knzFioBroefQnTzJhJn
        xhoYGYFI/VtF2QQrkbiEioUBKndQd4+3z1xOk9oxIUwDrYs=
X-Google-Smtp-Source: ABdhPJx97uqEqDkxi8j4pc+bLpdfdVXm8jGdhFyE5QQDlr5+RM89wT6Mcvms4IkfXX9H1/hnjwcuiPLn4/ygGr8Mpm8=
X-Received: by 2002:ab0:2b95:: with SMTP id q21mr633922uar.59.1631172631776;
 Thu, 09 Sep 2021 00:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <f40b07a3-9f64-84f0-5c91-1c7fdfe5640a@suse.com>
In-Reply-To: <f40b07a3-9f64-84f0-5c91-1c7fdfe5640a@suse.com>
From:   Sam Edwards <cfsworks@gmail.com>
Date:   Thu, 9 Sep 2021 01:30:20 -0600
Message-ID: <CAH5Ym4jt-b58ySKonbn3QXaDzZf6HQjYfUXPUDOX5ogEVwhNVA@mail.gmail.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

This is a Gentoo system, which installs most package updates from
source. I had just installed/compiled updates before this issue
manifested -- I'm sure that this easily qualifies as a "workload." :)

The listed .dll and .dll.so files belong to Wine. Although I don't
believe Wine was among the updates installed in that batch. I can
double-check if it's of importance.

The only files listed which I don't suspect were from the system
updates are "data" and "backtest" at the top. Those were from the
overnight workload that left the system unresponsive on the 5th.

Kind regards,
Sam


On Thu, Sep 9, 2021, 01:12 Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 9.09.21 =D0=B3. 3:47, Sam Edwards wrote:
> > My primary hypothesis is that there's some write bug in Linux 5.14.1.
> > I installed some package updates right before btrfs detected the
> > problem, and most of the files in the `btrfs check` output look like
> > they were created as part of those updates.
>
> SO what was the last workload that got run on this server. The
> btrfs-progs log suggests the last 2 transactions have been lost
> expecting 66655 vs finding 66653. Also looking at the missing file names
> it suggests you were fiddling with some windows development software? I
> can see a mix of .dll.so files and also a bunch of just .dll files. SO
> what was the last thing you installed on that machine? Are you using
> dual boot by any chance on the same disk?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465CC5174A7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbiEBQoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 12:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiEBQox (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 12:44:53 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4E631E
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 09:41:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r27so11619929iot.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLpPAB4DjIzjFJlNRyh2+pFRU3llzQ/YpPPmbf+Rl8U=;
        b=irY84IoDEgrVH4kqXox88BVuTPKT4yty9OvklGnKjKZJFqWLvZk+1PiPl4ZcrY31C6
         eUPGhCVODPWalXt5UChU1Ajrs2v9FDCZ2FZIGMVZfq713sDToBdgSBzGT044YCWYYvpm
         w+lQ8FI0cg+2Mt43PS/O9H7Few9X3SwRwi4A9sdiXCloOUioKrJAh+5bqvMw/QaRYQ/k
         uXSj0zgDJdqFp7qWtkY+oUHwm6hddG72PoWWEv1b8oZ/Rs1fFEWDYKFc5S0of5n1pTcm
         o73FL2Q2epOvPRN7xmkb1b8JvOdI3yWjloBhTiV0oEhjR9azRx4h8kvF2Xw9lv79FsuM
         u9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLpPAB4DjIzjFJlNRyh2+pFRU3llzQ/YpPPmbf+Rl8U=;
        b=qAV8QW4yZ+gRo+RI29B6JLAdh5MwrGNbNd45dCriru29wTQt7/NGPuzvvH33D9OqY+
         zwQuoAKTZ6sUWxmKrB86+XZ0ZKvD/yT6WVnxZks1q3CfYXAvj+dRNKZcYGD2d/Z2mr3T
         nqs/IAT7oxeTL51QgqCZKgWSMcSvxN2tkRts17oU7uoXF3XXm/xbDVqA0M2KE5eLGxSo
         5MZg12tWQyguULMVHXETBr2pr84/0R5N7IGxvST6xdVm6OCZlPaA5bscH3D3MxNWnPpB
         Gy06bh1XA/ISr9uLRVRihdOzsNR+iuIs7+wlyUKdCnbijZJziw1e7v6PGumfHHBjGR6+
         J0ag==
X-Gm-Message-State: AOAM530jASk027HKkjzXc3kB4zFWWIG8CntD9mvMLHmBiclJ/+VoLRYV
        ln+DbdpucHzkmO6P1TfWsOnZY05WUafhaKH+xFb+s1sHCTc=
X-Google-Smtp-Source: ABdhPJzN0YsrQ616rdh54NGq01W+LnJZTmirtuLE2HS92l2MzzmJ0OlGtvU83HsaXhpYmb7+RaxF4fPEyBvtpuURyfc=
X-Received: by 2002:a05:6602:2c4b:b0:65a:7a65:8037 with SMTP id
 x11-20020a0566022c4b00b0065a7a658037mr1227269iov.134.1651509682845; Mon, 02
 May 2022 09:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220430022406.GH12542@merlins.org> <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
 <20220430130752.GI12542@merlins.org> <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
 <20220430231115.GJ12542@merlins.org> <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
 <20220501045456.GL12542@merlins.org> <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
 <20220501152231.GM12542@merlins.org> <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org>
In-Reply-To: <20220502012528.GA29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 2 May 2022 12:41:11 -0400
Message-ID: <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
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

On Sun, May 1, 2022 at 9:25 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 01, 2022 at 07:09:19PM -0400, Josef Bacik wrote:
> > Sorry was on airplanes, pushed some more debugging.  Thanks,
>
> no worries
>
> Recording extents for root 165294
> processed 16384 of 49479680 possible bytes
> Recording extents for root 165298
> processed 81920 of 109445120 possible bytes
> Recording extents for root 165299
> processed 16384 of 75792384 possible bytes
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes
> doing block accounting
> ERROR: update block group failed 15847955365888 1073217536 ret -1
> FIX BLOCK ACCOUNTING FAILED -1
> ERROR: The commit failed???? -1
>

More debugging, this really shouldn't happen because we wouldn't be
able to map the bytenr.  Thanks,

Josef

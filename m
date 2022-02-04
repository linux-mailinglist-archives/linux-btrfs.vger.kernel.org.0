Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF894A982C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiBDLFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBDLFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 06:05:15 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC3C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 03:05:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g20so4715369pgn.10
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 03:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73HTtXPssTQkrztOByI8TshmMEAzQqpWUKmJDJkJ2Jc=;
        b=EffJ8vU8iVNd2TVeHMNje8061gXiTbpbFx14gt2Y2rB/RVZhhjOAwz3iRC6z2/zGmf
         YHJzpUA/MJCooCsMM7+tYCyvouh/JQ93t8yVOyCKj078/8UAnOOkTnakqt/E8CAgfxnm
         Kbt9nP7rGd2rNZ2F/C/NuiYoUfIZ7P3P7OE+FyZ3OuswJP3Su9l+rE+HfgUNlRqqDnm4
         UFYO26p70vIDPvPr7F3ohDNgv889uARELZ7U4ch8xXRuRiHQ3VtLdI0+IUmusJ9g5b5T
         wTrg8XLYjdafHnin9ff8u5u5e3oeyVzXki7rMkGrRosfpHrvbuw69SWaalLpJuVxP9tX
         27gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73HTtXPssTQkrztOByI8TshmMEAzQqpWUKmJDJkJ2Jc=;
        b=IoonPe+0gzjc/gZjkpPlP4i0a4vlRmx34MA8ol9hGiOH3gbBdEmIvDmN7P2VInuVDz
         cvxbCd5yVl1juwuIfGJUQgxbQ5uaxPhuq43O5G/LxXox/Xt+9wYa6XwuHfDtUc605ppa
         LLK24wlbbY4y9bT8Zztb/SU/RodJtPoCDgGGvW2uHN5pIdOg6vgCBoPWYkmtQAONJSHt
         uTcKLI4vkggASvg0QtH+fj1imolvvceZW3Hw+a8K8se11DgLoGtB5KR9siVXVuq7slMZ
         VPHwjR/9MwaPPVH7R7M7rnB/V0xiOdt3WickGGTqkqlo4IedQlu6hp4V2xgRyzIRtHdR
         zV6A==
X-Gm-Message-State: AOAM532bLwL1c2lz5WqiZ+mfGclMesX37f6Taw2tBrXo9ICL7lJmaNzt
        kD8tJ11/yLZqsGiXA9LkAnV84yW6NwEFDhdeUsQ=
X-Google-Smtp-Source: ABdhPJwqoxExMyBbcCIXSNlSbGkIDoVkAP74UldZUhbv4oZL0ezG6rIWjTzU4IXDA7+KqBbrQpV86cKGVMOJ4hssQBg=
X-Received: by 2002:a05:6a00:1a8b:: with SMTP id e11mr2603211pfv.60.1643972715304;
 Fri, 04 Feb 2022 03:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20220125065057.35863-1-wqu@suse.com> <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com> <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com> <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
 <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
 <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com> <4fdf158c-203e-6def-27e1-8a003775693c@suse.com>
In-Reply-To: <4fdf158c-203e-6def-27e1-8a003775693c@suse.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Fri, 4 Feb 2022 12:05:03 +0100
Message-ID: <CAEwRaO4H_KTRBn8adNr0b_Ob_9-yYZhW=R7B1C+J=uDzL=NdWg@mail.gmail.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> But one thing to mention is, the color scheme is little weird to me.

Good point, here's a custom graph with just the write rate, that
should be easier to read than the default graph with everything:
https://i.imgur.com/vlRPOFr.png

Waiting for your next update then. In the mean time are there other
statistics I should collect that would make this easier to debug?

Thanks,
Fran=C3=A7ois-Xavier

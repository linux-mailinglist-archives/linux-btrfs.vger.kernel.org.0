Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF54A786D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 20:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbiBBTBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 14:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBBTBT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 14:01:19 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630EC061714
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Feb 2022 11:01:19 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i186so141783pfe.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Feb 2022 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X/7iw6JFiHgKL9+038VpL8FJO+miwRVCIclOeeGsfyc=;
        b=TLMn9pgRW+3gKPUR1p8kpdNfwOPLUZvs/kkJWDut3GNduwjO9X+Werxd/r5udbyGZr
         ouMHiaBAW+zkb9YuLX9VJrB0FhI0PLL0mN7MHkqb4idcJZvjCVebH3KVkV2popoGXqUN
         p9OzQJwU79ERuDHC96Q6l7RwYWXr7FHkB+4EnsXBuoCMpnHIChCs7AbXfuEQ+JhirzVN
         URkRJ2ahc2a7LDoEuVbtGhVMd8dveJM8eWGa0kerVShg0Xumzf5jcYRh55GbwJ5eCd+3
         8ZGcHG6detNwXAQNk+yo/cZLp2PU1IDNy86suj0u7nMvW73ci4W4nWmQ/3P1YY7vYSqT
         tFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X/7iw6JFiHgKL9+038VpL8FJO+miwRVCIclOeeGsfyc=;
        b=fDW6gCAlJJhESe0KtXvu/acmYomM1K8wDimsLY4bNAADUnBJp4DoP5/M/C/gz3eedp
         prxPFg1m+aEcghnD0LIu0OTE56mtG2CdmMdu6dQCJIrVY6f0jk03DZGNeGmC5Dd+u6m+
         EzoVJr0mjKdFU46sFwRh2BMFqYW+j+m7UVgUUK/4Cxb50hTi4xtcGg3wN9eYS4W0/gP0
         XuMVA+k1Bw9nNLFAhHb3vuaW1XdF4cvmVOQJjDCC9AKbMZErbPOpZRq1tOR78EbTLn8x
         AFJdLcJRA9dhyygbCgywM3D7J8El3h65t9ZgEBmPfu9eniI3FWc3mTzJSi4BMarLxUkT
         JQSw==
X-Gm-Message-State: AOAM5304PNZIoakId3l59m4XLHgYhjFkpWcWoC39RyEYGqKi4WZBhMIB
        dyJ23eval/OtPh7prOPa/ALbnJfmbkKSestRMFs=
X-Google-Smtp-Source: ABdhPJzqa0oFC2in9O2hHu5byrRXpl85BWLCFNbx7kZj7r0IxO0Zqx3OhPBO6tHjcqvxThm4+TC8b7o3irHaCF+7NJs=
X-Received: by 2002:a05:6a00:1a8b:: with SMTP id e11mr7508280pfv.60.1643828478435;
 Wed, 02 Feb 2022 11:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20220125065057.35863-1-wqu@suse.com> <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com> <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com> <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
In-Reply-To: <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Wed, 2 Feb 2022 20:01:06 +0100
Message-ID: <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> As a final struggle, mind to test the small diff (without any previous
diff) against v5.15?

Sure, will let you know when I get the results!

Fran=C3=A7ois-Xavier

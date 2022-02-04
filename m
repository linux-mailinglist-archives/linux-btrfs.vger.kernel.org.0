Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B44A96D9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 10:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiBDJcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 04:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiBDJcx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 04:32:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27572C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 01:32:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id r59so4960054pjg.4
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yhuqrIHS1oKdQheln6lG4PiSqRsz/u8dIQKIzvJMpJg=;
        b=Olf2/fmiYQF8Cl6xkMU4LHmc41yWumdv3n1FMmwEjkCE1qlatKK0/QkoRY1NIkeMZp
         YEjBcUKV3wHWEcYclbT4UF0fgNZP5YB8g6hf3Zuq0kaipEnU21ksrAaVLd3cN2WDpoht
         0KnLHKzo+TebzUxBKFPhbBAq5iklsyb5cjVmKnzaAwXmjsCnTqVIgmxMdFfklL/f9f9S
         r+qqL63FgZqKtULccto8cUmvwzTOXe24scYBd78k+C7ldhQDKYrJfPf8qGWefW6fxi7Z
         9SksNG0I+FGnBgG/IUeU7wbmHHvUJ2F7MPNRHeatpe2G11CQH3IncTwB6Dyek0HoHY71
         sfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yhuqrIHS1oKdQheln6lG4PiSqRsz/u8dIQKIzvJMpJg=;
        b=JgXLLkIxLcSSS6vYwdcVFVHvR7LET/mkUm1ocO8wpHy4gd/Otpfa2LYDNMf0DyIMKA
         AnCwtENbO4+48rzYUNgF/fukyp1uOOnOMmhzr/aBtn5ujf+HKszFF1PafxoSsXotXyzq
         eFksIm+WLWV9M68FH+ZbxKAERx8zgopgOPVuGq5fCLtCpL9XLv4nqF7UShECpsv+R/py
         rJCuupGgP3gUIyvJCSR30HA50U5oW/mRR4lFES34/P163Y7XssYR/nIvJp1rC1ojFi7A
         sfIQSN5LNuL2gEwy/0LB/rvaY0Vce0QXKXqD90kRhGkaDCdEW0risg/B3DA5lT4FJ/pd
         6j1g==
X-Gm-Message-State: AOAM532ZsaduGtUDASFbM0IaOeheEACtiDr2GNo5Np3p8uV5uj7s8Djg
        cVZ235+4hFv0/xIrutzN0U207Ue4sxPaA0jY249+5xUOn3m6HQ==
X-Google-Smtp-Source: ABdhPJwbBlW3DIWtwyURhpkW2m+KZCWDCE1ZNQ7EfiX/OhLgm9RoxXWgq8TGbldv2R1xqYffXhScSQjy+fakM7mUtjs=
X-Received: by 2002:a17:90b:4f46:: with SMTP id pj6mr2158365pjb.43.1643967172693;
 Fri, 04 Feb 2022 01:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20220125065057.35863-1-wqu@suse.com> <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com> <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com> <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
 <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
In-Reply-To: <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Fri, 4 Feb 2022 10:32:41 +0100
Message-ID: <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The increase in I/O is small but noticeable:
https://i.imgur.com/IJ4lLI2.png

I also checked 5.16.5 just in case, and the difference is still marked.

Fran=C3=A7ois-Xavier

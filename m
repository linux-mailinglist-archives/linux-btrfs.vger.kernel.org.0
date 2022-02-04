Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C184A9865
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358390AbiBDL26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358367AbiBDL25 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 06:28:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E25C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 03:28:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p12-20020a17090a2d8c00b001b833dec394so5914317pjd.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 03:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kbULgBWYts2SxmqcTienQO9HvU3UIzVZasR/tJTj6R0=;
        b=WarZoYK+CZdCok+uMekgutnTX3nkiSQ08U2Ag1VeVqH78UnyOcM6mCNAjw6zQcDzal
         PjrEAfiHx+1dGSQ2kTF4HsoKwMPDzzcVNsy38WhIWf1pa4deKXsofZQOwVWqG0jb2NYo
         GDN0vADqfbAh9UQ3MDMR7Y42jdzr4kN09IRH7ZqaL28KqMWizKIttTQqAcOB/NBAYiJ5
         +2TnnY9wgvwOHaI2udlnBt+dC1uweOM7T24fdgQdInLx1PTy+hvtoRvcPr4I9PXhzt1N
         338YNsxoyGCz13Iy5sMidxmsU5OxGd2MO12zNFxejtMiDe9A2nsPgOd3LAdN44eot+RR
         LJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kbULgBWYts2SxmqcTienQO9HvU3UIzVZasR/tJTj6R0=;
        b=g5iM9oRUlTQmbERWflMJ1dGbG+VB73bCwGAAd4gPYts8i90H4VJaK2CTujUOcjUV23
         yoLu4xf17AbLhU2AO6hfa0Z/T33Hr04dpf69p9PmR9JV7sp72uzXbBCZQ5XU3TsvpjGb
         0NcYJsP5onDf/DoIu4RF19/1Uc8vQbuQ37ywjE+rtl3XxgkHqLWdyjE9+F0GTOoyygos
         N70jrOKJl/r4q7y3aY3XN1mXIFGgwsObw7FIPRIjuZTiunY4htLhXYPHwxdfFRh9dZXV
         k9Jmu/ccNb4f6PQyfcSYrXqkCcjWf/xC251KiRyZzecVC59B/3AorSQtC0EmOAlx2I4K
         Z6Gg==
X-Gm-Message-State: AOAM533wGxGntaHkCBrLuqf2Yu7LnuP8XsAq72dmOIDoNiSP/ICpjFMH
        uEeafbjZCYWfMLWYkm9xnyZ26QMu7o6uGjoP3FA=
X-Google-Smtp-Source: ABdhPJxEc1B5qTCQdvta8XSSMfFz8z1vAA+q4L97xvTcF7B+9bfG3bfbpX4fTHgYBROCaVKuZoqDz+2fSEE6RNOKDQQ=
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr2613043pja.1.1643974137451;
 Fri, 04 Feb 2022 03:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20220125065057.35863-1-wqu@suse.com> <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com> <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com> <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
 <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
 <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com>
 <4fdf158c-203e-6def-27e1-8a003775693c@suse.com> <CAEwRaO4H_KTRBn8adNr0b_Ob_9-yYZhW=R7B1C+J=uDzL=NdWg@mail.gmail.com>
 <c4a8ab03-792c-2d95-4f92-a7ba7b5b0f31@gmx.com> <CAEwRaO6_XKO_bNBLrgAW2v2-H5VPHspMdgVRPHfBw6m8HKpcuQ@mail.gmail.com>
In-Reply-To: <CAEwRaO6_XKO_bNBLrgAW2v2-H5VPHspMdgVRPHfBw6m8HKpcuQ@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Fri, 4 Feb 2022 12:28:46 +0100
Message-ID: <CAEwRaO5DjKdhZLf5Xpszk91QbzR2FLxturRDgLWhcM7Pb2FWbQ@mail.gmail.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Here's a set of separate graphs with read/write ops/bytes (no real
difference in reads):

Ah, that was the wrong link, here's the correct one:
https://imgur.com/a/nB4dDmF

Fran=C3=A7ois-Xavier

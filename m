Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9D4AA556
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 02:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378874AbiBEBf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 20:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiBEBf7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 20:35:59 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439CC061346;
        Fri,  4 Feb 2022 17:35:56 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id b37so13675964uad.12;
        Fri, 04 Feb 2022 17:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tZR3UiQjuZ3E4E4YIGJytgfZZs1q2BPvs+JB9ytaoRw=;
        b=DN0ma292xvwZ0EUXamExIIa9xpKjA0BuY2oJhNZ4840bg2atTKmlHOkoh3Nf1Y70n+
         NjDXPwPQP2D/1DqpGJTdhaREWFtVL/q+cC5IrJq1uHX8Yb0CLSSNmwngsBXFBmyEVgb3
         UbRJ7EV2Cy2zifYK6mTPZPash4IXDEsHCgq5tmHhk9QnVOtVsdM80K8PqH2WKsStsc6J
         wBqSR2Wtp+LXoGXQunCVAcavHYSh0nKtcBowgUSMwaVbxf7B4cQiJRk4gMqpYDS/Lnuz
         PlQF3V/pOKoJuTTsEMeI+3ncTKnun/sbml+XetFCtPfgwPb44cnmC4I3d57lksm6tDUx
         BRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=tZR3UiQjuZ3E4E4YIGJytgfZZs1q2BPvs+JB9ytaoRw=;
        b=VDrN8O86hkaXhzd/b7NIrl8z1TL8E+EnWCokbDXu1lZAt8kiDsuaOCaq639vQpnAO9
         LsCIWtyYF+mCs8lsn4T8qXbIgq6ezuEL24hJv6/ZVqIjdbLLYVNrZaeHaTp3XPZAQgNg
         KUMMvSWE6JV6Bf7jLanWW8ug3m1aZb9oVQL0+UKiblNPpvdR/cRYU0WN5x/2mQ2H+5oP
         iGvlJSdfgJ1Z1PjgkWCTt62rKZzkuMQudtRcN3h8n5GQrjukZppnEI0LY/llZ2mykrOP
         dhxTzYQhYqD39RGjIlEGMvsDHFBv/9OSujGgA39aHK/ezFRG/cAPNylG7d4+a4fs8jbe
         NY5Q==
X-Gm-Message-State: AOAM531aIR1nA6ALPDQeiGv5xo1VOaXtLvbcP4a+2D68RGL6TX5kqcNN
        k4nacJ5ew0k/cMqwjnEKzRdV0Ox5SI1K1e0ye0w=
X-Google-Smtp-Source: ABdhPJyKCb8zMQ7Q7Q/EDZecwGYGAwHbZhz6M0cjEYvNJaP/6PD5vXx5uHfGrZI2rLby3Be5CPI9HcbMatC4WMkeCGM=
X-Received: by 2002:a67:f3d9:: with SMTP id j25mr1919842vsn.84.1644024955422;
 Fri, 04 Feb 2022 17:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20220202201437.7718-1-davispuh@gmail.com> <20220204162821.GD14046@twin.jikos.cz>
In-Reply-To: <20220204162821.GD14046@twin.jikos.cz>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sat, 5 Feb 2022 03:35:44 +0200
Message-ID: <CAOE4rSwu9Ond3qO2ADA=HPo5bRPq2BgBvJF6=J8efhzL73rrqg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: in case of IO error log inode
To:     David Sterba <dsterba@suse.cz>,
        =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        BTRFS <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

piektd., 2022. g. 4. febr., plkst. 18:29 =E2=80=94 lietot=C4=81js David Ste=
rba
(<dsterba@suse.cz>) rakst=C4=ABja:
>
> On Wed, Feb 02, 2022 at 10:14:37PM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > Currently if we get IO error while doing send then we abort without
> > logging information about which file caused issue.
> > So log inode to help with debugging.
>
> The Signed-off-by tag is missing.
>

Yeah I forgot.

> > ---
> >  fs/btrfs/send.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index d8ccb62aa7d2..945d9c01d902 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -5000,6 +5000,7 @@ static int put_file_data(struct send_ctx *sctx, u=
64 offset, u32 len)
> >                       if (!PageUptodate(page)) {
> >                               unlock_page(page);
> >                               put_page(page);
> > +                             btrfs_err(fs_info, "received IO error for=
 inode=3D%llu", sctx->cur_ino);
>
> A message here makes sense. I'd make it more explicit that it's for send
> (the word "received" is kind of confusing), the inode number is not
> unique identifier so the root id should be also printed, it's available
> from the sctx->send_root and maybe also the file offset (taken from the
> associated page by page_offset()).

Thanks! Will submit v2

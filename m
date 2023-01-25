Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD92867BC80
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 21:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjAYUZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 15:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjAYUZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 15:25:52 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347245235
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 12:25:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bk15so50771539ejb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MQqi5uAIXsv23BfkTLDT2QnZDkLaDEc10J0zEjYqkG8=;
        b=jGY+eQ0fmes0//cLBT7AjKFQ2CNKpojloejRG7Jvq3eCuCdVCmbOOKcc+pHo+P+Un/
         H9Q3woaAL8V1RED8ky4Um8xsRZK/B0I5qNShK0MgNDW9UE4FwDl4bwdYMwxfzn9ZHl/A
         ai4CNaDXtht94ILudzfFB01SMznfurM0kWzaDKP3hW3gs8PsW5dDh8ZeadWATWiaVtSC
         zLmfZrw14ooZFk3C1qBZOtj8R9bSTU0sAdgYNZlFd2sWZ69N8uZpy2TtryTvZHx1lq1I
         rFoYXZAbW3PCacUjpyQ/1IcSvx56Ee3yz/zlPF++GzeB/5XIqRyogSi/hZhs2IxVkIGS
         fSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQqi5uAIXsv23BfkTLDT2QnZDkLaDEc10J0zEjYqkG8=;
        b=bYrtZtqPM5I3ln5P5RdrViae7PZODgBwSsbjUGz4xmwrJcD5rC9Lvn1OPB1SGYDKWb
         yFQ7XXEwC35IrpDJ+73LqXvDBidHmMZEnuJUW8CEV8yyLuCQqFX8pU7rDL/XKIQmrYIj
         UkBtqAGxtB/XYewmDAKTQJGdN/oRzUacN/dNQeLQhE6+jbLJdnKtui8np7S5cowhRzZp
         vhrcBmPjidG8OaaIGyDELs7yj9IS0pBZseSEa5e7rg5sHb/m/JQNcnGDJ5mHBlBg41c1
         9ejuGwZsJ/HUedyP4vb3D85imA3yh7eLABBZpFf5r5Um9mSGvX+FBLMKQH/fdQHbTrq0
         dAoA==
X-Gm-Message-State: AFqh2kr90FRjKb6aA/IYHCuQ8lxrSOuQwZ/xwLN+6gKoGgyLcLV7Fq8a
        Zj+p4NnQ57fpfcILymt4ItVJIgWD7w6Txpb4XbbcjkXERkU=
X-Google-Smtp-Source: AMrXdXtPHwzWzcupSoPX+GJb6IbAVyz8VK3mp3sBVOElv+qN7OrUW7Wrh/HqlmmqxYvs3DJdAC/f+vg6DSg7NgwnnAQ=
X-Received: by 2002:a17:906:12c2:b0:877:77fa:4266 with SMTP id
 l2-20020a17090612c200b0087777fa4266mr3685696ejb.395.1674678349281; Wed, 25
 Jan 2023 12:25:49 -0800 (PST)
MIME-Version: 1.0
References: <87a6271kbg.fsf@fsf.org> <CAA7pwKOXSNpS0o9DhFCgPH1JV-wiLptZ77MiS1Wqam5O3-yfFg@mail.gmail.com>
 <87k01afl4o.fsf@fsf.org>
In-Reply-To: <87k01afl4o.fsf@fsf.org>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Wed, 25 Jan 2023 21:25:37 +0100
Message-ID: <CAA7pwKNf7bRo3BQVHfozL69g4wG-32umHzXKPG3cazP_YC9QXA@mail.gmail.com>
Subject: Re: balance stuck in loop on linux 6.1.7
To:     Ian Kelling <iank@fsf.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 25 Jan 2023 at 20:51, Ian Kelling <iank@fsf.org> wrote:
> Patrik Lundquist <patrik.lundquist@gmail.com> writes:
>
> > On Wed, 25 Jan 2023 at 02:48, Ian Kelling <iank@fsf.org> wrote:
> >>
> >> If I restart the balance, it will take about 2.8 days to get back to the
> >> stuck 11% point. The balance is still running, but I'm going to cancel
> >> it morning unless I hear from the list that there is some use to letting
> >> it run since it is wearing out the mechanical drives.
> >
> > You can pause it instead of cancelling it.
>
> I ran btrfs balance pause but the command is taking a very long time. My
> ssh session died about half an hour after the command started for
> unrelated reasons, but I see the command still running 5 hours after it
> started. Is that normal?

I don't think so. Now is probably a good time to add "skip_balance" to
your mount options.

>
> Balance status says:
>
> Balance on '/mnt/i' is running, pause requested

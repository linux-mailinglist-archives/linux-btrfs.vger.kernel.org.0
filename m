Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089725366AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 19:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiE0Rsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiE0Rst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 13:48:49 -0400
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598A6CAB9
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 10:48:48 -0700 (PDT)
Date:   Fri, 27 May 2022 17:48:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail3; t=1653673725; x=1653932925;
        bh=yDZi6FvjAnRj5WFHRue3X0VWw5l6f03mlIS5YM6olDA=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ngxsxpmzaS2cdK80T3Ebrkuxu3aLDWy0x0flLvYDItzLiOi9+FdQtJacy0f8dzpvp
         zF6bOtpuhzSbKXGhCPSbVND5Tih2soyvLbbg7ZuH0lSQbqIhSz/mkC5wcOy/PApqnt
         tI3RD59lQ4Flc5BcAHa1jMklNP33wMjfLTJki3Ms8LGIAn4EpJs4b1BSTrAvDGxacX
         VUJHwnOTsjpgBncFmUvp//D3vN5e1Jh0xMtJBxPjUt8SQ3Wi5y04oSNSelnjk24z9y
         6FVhHhsVEjfflIcc3MllRa6O6ZAYk8eo0M0sOQg5SbQgtr6rtVd75DUn0FsXJAmSx/
         WFD2D3agkV1pg==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Neko-san <nekoNexus@proton.me>
Reply-To: Neko-san <nekoNexus@proton.me>
Subject: Re: [Help Please] Missing FIle Permissions Irrecoverably
Message-ID: <PWnYANQjXkFVkcIa9-_uPmrUNHswzULG4KgDCwToPJjP4OPxHKaIo1C1i1WSOS9YUjadCwVgvkNPh49JRbo4puaXm1R0lMlQaIESMIiHmuE=@proton.me>
In-Reply-To: <wztQTaGfQNKnobWabVzov7npkcVSeXD2Zth69WUFRit2NRq61hMN6a7t6R9mJntS0kyDryBabwpzmP4_q4nsO8y9WnUX35nOJ3ZF0agom9M=@proton.me>
References: <LQBIObJ0wXAJiClnJItZ5QlGJPGLx5G3_cbQYB6Yle5t7wg7-MX233_rkpCs_ybzN9-DWoQBSlPD6EZRa6HDjdo6PWJjFWO0qb4XB7UsK1E=@proton.me> <20220520212751.GE22627@savella.carfax.org.uk> <VHT1Yf4pw4jirz6QjpYj6bPb1zvJ06WStOXc4w1mSC1A7DsH5YQq-mqvzkzZSZriBXwCHuyF11thmlcgSLYFGaBeHGuA5XliXPJVJ3eXItE=@proton.me> <J6n7dr0d6RAArHrDWGrU_uNQsM56Npqpp_tuyXoY7q4rS_2dPzmd4sH14t_w-n_tE80HWdjyUKY2SqwV-iFwBoa55dLfJ3WI7LVsrjTRTVw=@proton.me> <uDip5WTKD2tJ6uP8N0eW91dNpbSShUrHBHPLczGV4l__Z_Wem9uWnG_pCYqcYjren8Gx8Va0iS3AGvCEiFTAC33Lgx_gOMs9KVqb1dh_lnc=@proton.me> <wztQTaGfQNKnobWabVzov7npkcVSeXD2Zth69WUFRit2NRq61hMN6a7t6R9mJntS0kyDryBabwpzmP4_q4nsO8y9WnUX35nOJ3ZF0agom9M=@proton.me>
Feedback-ID: 45481095:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

How am I supposed to recommend BTRFS to anyone if I can't even get support =
for when something goes wrong with it? I can't *not* have a PC :/
I'm honestly baffled by the week-long silence...

------- Original Message -------
On Monday, May 23rd, 2022 at 6:05 AM, Neko-san <nekoNexus@proton.me> wrote:


> I had accidentally forgot to re-add the mailing list to the recipients re=
garding this; I have attached a dmesg log regarding this...
> I had attempted to downgrade the btrfs-progs package to 5.16.2 from 5.17 =
in an attempt to alleviate the problem but... that didn't work. :/
> I'm at my wits-end and I need my PC to work, as most do...
>
> -----
> On Friday, May 20th, 2022 at 9:27 PM, Hugo Mills hugo@carfax.org.uk wrote=
:
>
> > [snip]
> >
> > > [ 1646.159335] systemd-journald[387]: Failed to rotate /var/log/journ=
al/63f413b0af0c43ae9345a082aaf00bd3/user-1000.journal: Read-only file syste=
m
> >
> > That would be a read-only filesystem, then. Most likely caused by
> > some serious error on the FS, which caused it to go read-only to
> > protect itself. You'll have to go back in dmesg to see what happened
> > to cause that. There's most likely a kernel oops in there at around
> > the same time that the systemd journal started spewing those errors.
> >
> > Hugo.
> >
> > --
> > Hugo Mills | You shouldn't anthropomorphise computers. They
> > hugo@... carfax.org.uk | really don't like that.
> > http://carfax.org.uk/ |
> > PGP: E2AB1DE4 |

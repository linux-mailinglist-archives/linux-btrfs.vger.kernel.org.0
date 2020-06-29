Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE120E4A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 00:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391111AbgF2V10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgF2Smo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:44 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EBC031C46
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 10:26:12 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id m38so21970ool.4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IwHR1Sf+LTcrpq8mCmUJ74S3YkT8OmjO5FN6B1Z6CVI=;
        b=RqttxmYwLeSaH+0GvvrVokaNnLrTKSp/DSruaQuR/NCELfNkfLBY1vL4Wb1cbE10n/
         kfXBxFYs5Xe6Tv0b2ao6vX/Ogq027dH7PrxzqrjNGCEGMapK/vDB5F5Qli5kzpig1FL6
         Xmg73BfOo7oSDgtIDnTJnypa9HNJg/IQ7dC0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IwHR1Sf+LTcrpq8mCmUJ74S3YkT8OmjO5FN6B1Z6CVI=;
        b=sNN+mGQn0Q9DKmDMghHaz11QSIdVczQlw8lMWx67RSANBKj7UhLOjLZjCfIWyyFgbV
         Mu5CI0mTWB4TyTVYvXu+CMpW2t2bBRyd/DdUb/nW/rNu95diSkStPU1ukC7ArVsq3KmO
         Zu2lW8nP8PF/kF1oHbPlJ6cbHDLmtc2qAmwyNEdeh5F+pAdEkbjEUQWH7/2fmT1jX4Hq
         IuRS3btsJlOhj65jDDSpphQ7aqYunWlAjCeEOlgNOEoeYwnAHjaiq2dUZk5P2U7hoVff
         5EIyTUsipULT+MKb1+TM1gif35frvDythcbwWh2Ok9GkGAPS4+BQ2g6L9THT3xwFVQkv
         z6Eg==
X-Gm-Message-State: AOAM531ELV7xNe2HATKTmK+c+eHR7DzmVCHoXfW+vta+xAoqI+f8kcja
        3v2TO9cfDEjwPYDQcduGw1cwbSuVdwUJjLtI39+VVw==
X-Google-Smtp-Source: ABdhPJzHy75/mbU/WBsuLKSzmxwRuut0qq+NAbMM1959xUc8/Ut6NpP4FouT81ZUYYPwR8FuXs6Gssp/LIZjoN2zxd0=
X-Received: by 2002:a4a:c4c1:: with SMTP id g1mr14132172ooq.93.1593451571314;
 Mon, 29 Jun 2020 10:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200624160316.5001-1-marek.behun@nic.cz> <CAPnjgZ2Pus57k3JS=cqiwwhm1p_bH4E_K4x4=znnD+2ch9cCRg@mail.gmail.com>
 <20200626133641.GX8432@bill-the-cat>
In-Reply-To: <20200626133641.GX8432@bill-the-cat>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 29 Jun 2020 11:26:00 -0600
Message-ID: <CAPnjgZ3YADT-iGxNXODEvpBj_nTodaJYDQaD-kYK38bCZdJuTg@mail.gmail.com>
Subject: Re: [PATCH U-BOOT v3 00/30] PLEASE TEST fs: btrfs: Re-implement btrfs
 support using code from btrfs-progs
To:     Tom Rini <trini@konsulko.com>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        =?UTF-8?Q?Alberto_S=C3=A1nchez_Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Fri, 26 Jun 2020 at 07:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 25, 2020 at 07:43:20PM -0600, Simon Glass wrote:
> > Hi Marek,
> >
> > On Wed, 24 Jun 2020 at 10:03, Marek Beh=C3=BAn <marek.behun@nic.cz> wro=
te:
> > >
> > > Hello,
> > >
> > > this is a cleaned up version of Qu's patches that reimplements U-Boot=
's
> > > btrfs driver with code from btrfs-progs.
> > >
> > > I have tested this series, found and corrected one bug (failure when
> > > accesing files via symlinks), and it looks it is working now, but I
> > > would like more people to do some testing.
> > >
> > > There are a lot of checkpatch warnings and errors left, I shall fix
> > > this in the future.
> > >
> > > Marek
> >
> > Please can you add a test for this one? See fs-test.sh
>
> Not more fs-test.sh tests, test/py/tests/test_fs/ tests please, thanks!

That's good news, I hadn't noticed the conversion from shell!

Regards,
Simon

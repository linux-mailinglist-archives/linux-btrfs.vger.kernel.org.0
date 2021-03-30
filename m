Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92A34F209
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 22:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhC3USQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhC3USM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 16:18:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38785C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 13:18:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so17463408wrw.10
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pUpIeffphecMmhk8t3+C047xaTjNHW/a+LsGI2NVygM=;
        b=FFoze3Adu86hsuLVVKnV0bqR9B7Sql4uh/u5EFBwZ4tA9wo7Rzrj0UnktIon9Oe0n/
         XbKXLyc4HjVzKlcS/UA4EqXY6HLqZzTfR5f2NQUnh8b0OCjQZlm8z285OeVUQxBUhQCx
         I4EpSHF1o04pu3MnigMS3+yzBJFuQtTtEoq+/0BSHd4Ab+otXEwPPz6TrDicVt5Dj2X4
         GXwXvEEQ3yS2/TgFwHpg6ycNtWcVgNBoZ/a9fe8UnutwV4kMi8D4Tuu17RJ1f+KxCMnf
         zKr/g7S9M35KuP7qRRAkXQHXAYA9fNHkcK+W1GVFafgya3vS+93435bBbNJnubp0iVkg
         MifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUpIeffphecMmhk8t3+C047xaTjNHW/a+LsGI2NVygM=;
        b=AUtnThDv2lFY8yBCCt46F1C7mQV2psmcJVQ4caiGVx2SWxHj/rgBP8/YZFIwa28KAy
         6klPdawcQof68Fw0zStnX9v8AQbvboh4cNx4TrsUTD/TmEiw4mz2kD7ai0irXT4Za6OJ
         aCIhaEoVpMjY9v9feHUjWArKAw0Y2mLpRbBUtVBptRWcoPPaL57YzkVRabhqfMe0GFyH
         UqpCd+aAMTjh0HZ7vdXh2vkdnzoSXaA+p/QBy9yiWDN2JyrLJYXp8V0erTrNpY6U2U96
         fw7sqePmWSSsXpCfbrod94MUnRjcTLKqj8WrozYpEabr5Vdb9677/FeRbcoCIJnbQ9l9
         Q3Vg==
X-Gm-Message-State: AOAM530oNzpD+uyadpCQP/X+XOxH1HJQfraDUm/4zIz9uuMSq6LRMk13
        FimzoR9yhGoe30+tW5r1pwYUlA0Vv9qcjUnsFN9TwlUyT9H+/s2a
X-Google-Smtp-Source: ABdhPJzzft9xaU8Donq1o2D5O2nkHfUEthNjd3jY9fXh1qO9Zhak/Y8a4F90Lepndklfk43mAHUU4qKiSzjRItdBUIQ=
X-Received: by 2002:adf:eec9:: with SMTP id a9mr35706594wrp.252.1617135483015;
 Tue, 30 Mar 2021 13:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQWtnjyN88gif-tmA_cxcs+6HPgVxB5XwNmAVj3qMKmfw@mail.gmail.com> <trinity-6258eac7-550c-402f-9280-6f529e372d32-1617093845116@3c-app-webde-bs38>
In-Reply-To: <trinity-6258eac7-550c-402f-9280-6f529e372d32-1617093845116@3c-app-webde-bs38>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 30 Mar 2021 14:17:46 -0600
Message-ID: <CAJCQCtQ7qtNU4tjWKf8VcmjZiij5nHd0cUAbh4rRO+NWWnQ=BA@mail.gmail.com>
Subject: Re: Re: Help needed with filesystem errors: parent transid verify failed
To:     B A <chris.std@web.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        btrfs kernel mailing list <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 30, 2021 at 2:44 AM B A <chris.std@web.de> wrote:
>
>
> > Gesendet: Dienstag, 30. M=C3=A4rz 2021 um 00:07 Uhr
> > Von: "Chris Murphy" <lists@colorremedies.com>
> > An: "B A" <chris.std@web.de>
> > Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
> > Betreff: Re: Help needed with filesystem errors: parent transid verify =
failed
> >
> > On Sun, Mar 28, 2021 at 9:41 AM B A <chris.std@web.de> wrote:
> > >
> > > * Samsung 840 series SSD (SMART data looks fine)
> >
> > EVO or PRO? And what does its /proc/mounts line look like?
>
> Model is MZ-7TD500, which seems to be an EVO. Firmware is DXT08B0Q.

For me smartctl reports
Device Model:     Samsung SSD 840 EVO 250GB
Firmware Version: EXT0DB6Q

Yours might be a PRO or it could just be a different era EVO. Last I
checked, Samsung had no firmware updates on their website for the 840
EVO. While I'm aware of some minor firmware bugs related to smartctl
testing, so far I've done well over 100 pull the power cord tests
while doing heavy writes (with Btrfs), and have never had a problem.
So I'd say there's probably not a "per se" problem with this model.
Best guess is that since the leaves pass checksum, it's not
corruption, but some SSD equivalent of a misdirected write (?) if
that's possible. It just looks like these two leaves are in the wrong
place.


> > Total_LBAs_Written?
>
> Raw value:
92857573119

OK I'm at 33063832698

Well hopefully --repair will fix it (let us know either way) and if
not, then we'll see what Josef can come up with, or alternatively you
can just mkfs and restore from backups which will surely be faster.


--=20
Chris Murphy

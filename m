Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74821751AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 02:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCBB5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 20:57:55 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46353 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgCBB5y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 20:57:54 -0500
Received: by mail-il1-f194.google.com with SMTP id e8so3257760ilc.13
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 17:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ur/4nuVr6V1fkpSMUO4TLg9+9opaMRHCkjWx6aBQd/E=;
        b=OLLgenp1+GWv8WY+yBkUlzIJ1pMEx9HdiC8d2t0avXbDmw6Y50qAEWA6nX21xOanPo
         7XPcM4lFZHuZhE6Cyrqw7RDvemjPMIIBJ3V6tjkQ8xYjnlYX+yts3fCocgiYQK3TV2Fh
         RKoqjHUtU6OCneBD0KbCG7CnXK7iuny5ySkI0KX5rVIG7rC/xSIRV6w7eOIx8WNdYKXo
         l45Ylm1pfIjfnkvM/2LqRSYgYd6fu96Wl8mNaiaLO8MpNRH3fLeXuezHJO1P03w2EhdJ
         PXSb/aBjOclfuSeO4BqRge4H3G2Hjc41PHccuu1TtC2u2syDtPNyOIBIBzAvvmxrPJW+
         cytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ur/4nuVr6V1fkpSMUO4TLg9+9opaMRHCkjWx6aBQd/E=;
        b=icgsZ4aBFWphrgXAWF9ptjbguqvAFuLyKwlPIPzP6qDc/AljEomNuhXQ8GnrmceiKa
         zPSzzIs+EIfiqlXeUr349j3r7TKaaTuS1GB9CtykQ3cwMVh3Bu4B4BgZpTFzBJ7z44sh
         3Uf557iUEbHymMzDTF5OZjtFAsXxurxzMgGbSRbLB5tR8PjbfWk/AwgJngFG4cpn471L
         yRAWzKYWeazL/JiFOZBZvruFzsJegLPFuXNcM648YVJPyH/9dOmzry1xNNPLOSuW9RNn
         +RvXQNrtLPlkRfMtV+W+7sfQgpjUzjWlM3Znkj2bcRiVTpstSIU6EiLOpOO1hs2JmoGP
         Fcew==
X-Gm-Message-State: APjAAAVJIUp9U9lN9lm7SvJ2DI6eOU1QkWVLjrXJuyJB/EJQ/KHi4ph+
        ZGffQRHNQ+miXDd4OqRJaRc3m+O0CYOAt1+1eL4=
X-Google-Smtp-Source: APXvYqzVhu4CzVFPtqffEhK18Sk4E9AYkqJWLqLcCl6oVMW8xp8egqZXwFjp75GevGPYjpHPu+oKwLZyMy9RFfc3QK0=
X-Received: by 2002:a92:da01:: with SMTP id z1mr15459581ilm.108.1583114274039;
 Sun, 01 Mar 2020 17:57:54 -0800 (PST)
MIME-Version: 1.0
References: <1746386.HyI1YD2b7T@merkaba> <BA3238FF-0884-40AA-9E32-89DA35D8CD0A@bluematt.me>
 <7ab6c91f-6185-06be-0091-f3540858de29@gmx.com>
In-Reply-To: <7ab6c91f-6185-06be-0091-f3540858de29@gmx.com>
From:   Etienne Champetier <champetier.etienne@gmail.com>
Date:   Sun, 1 Mar 2020 20:57:42 -0500
Message-ID: <CAOdf3gpeyRSNEp_efkxG9be1PaFx7xzF5GO9STXYRSm3DsH9Rw@mail.gmail.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Matt Corallo <kernel@bluematt.me>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,

Le jeu. 30 janv. 2020 =C3=A0 20:57, Qu Wenruo <quwenruo.btrfs@gmx.com> a =
=C3=A9crit :
>
>
>
> On 2020/1/31 =E4=B8=8A=E5=8D=889:43, Matt Corallo wrote:
> > This is a pretty critical regression for me. I have a few applications =
that regularly check space available and exit if they find low available sp=
ace, as well as a number of applications that, eg, rsync small files, causi=
ng this bug to appear (even with many TB free). It looks like the suggested=
 patch isn=E2=80=99t moving towards stable, is there some other patch we sh=
ould be testing?
>
> That mentioned patch is no longer maintained, since it was original
> planned for a quick fix for v5.5, but extra concern about whether we
> should report 0 available space when metadata is exhausted is the
> blockage for merge.
>
> The proper fix for next release can be found here:
> https://github.com/adam900710/linux/tree/per_type_avail
>
> I hope this time, the patchset can be merged without extra blockage.

I see that there is a v8 of this patchset but can't find it in 5.6, is
it targetted at 5.7 now ?
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D245113

Thanks
Etienne

> Thanks,
> Qu
> >
> >> On Jan 30, 2020, at 18:12, Martin Steigerwald <martin@lichtvoll.de> wr=
ote:
> >>
> >> =EF=BB=BFRemi Gauvin - 30.01.20, 22:20:47 CET:
> >>>> On 2020-01-30 4:10 p.m., Martin Steigerwald wrote:
> >>>> I am done with re-balancing experiments.
> >>>
> >>> It should be pretty easy to fix.. use the metadata_ratio=3D1 mount
> >>> option, then write enough to force the allocation of more data
> >>> space,,
> >>>
> >>> In your earlier attempt, you wrote 500MB, but from your btrfs
> >>> filesystem usage, you had over 1GB of allocated but unused space.
> >>>
> >>> If you wrote and deleted, say, 20GB of zeroes, that should force the
> >>> allocation of metatada space to get you past the global reserve size
> >>> that is causing this bug,, (Assuming this bug is even impacting you.
> >>> I was unclear from your messages if you are seeing any ill effects
> >>> besides the misreporting in df.)
> >>
> >> I thought more about writing a lot of little files as I expect that to
> >> use more metadata, but=E2=80=A6 I can just work around it by using com=
mand line
> >> tools instead of Dolphin to move data around. This is mostly my music,
> >> photos and so on filesystem, I do not change data on it very often, so
> >> that will most likely work just fine for me until there is a proper fi=
x.
> >>
> >> So do need to do any more things that could potentially age the
> >> filesystem. :)
> >>
> >> --
> >> Martin
> >>
> >>
> >
>

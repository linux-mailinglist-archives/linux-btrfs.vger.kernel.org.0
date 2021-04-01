Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876ED351F46
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhDATEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 15:04:50 -0400
Received: from mout.web.de ([212.227.15.3]:34639 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhDAS5l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 14:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617303460;
        bh=lVg0vBbUQd7acNMgRKbrzaJ+GlS/XxikrXcPbLEA3EU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hVi+a4w9+dIS2fGASGa1cD2wM9oFPhzh7E4rIVDldx9YHtnVQ38xvOJesEgo6HZs7
         wHYnkJl1//OdgO0Zzf5ZXPx70266J9vEnu4aa/nSseiwYBvyZRg65WoXdrlE5XmPlH
         mAC0QP39XRDaXMEhDC5Aj37iesxLAQm3LuoB+UUg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [62.216.205.36] ([62.216.205.36]) by web-mail.web.de
 (3c-app-webde-bs39.server.lan [172.19.170.39]) (via HTTP); Thu, 1 Apr 2021
 14:42:06 +0200
MIME-Version: 1.0
Message-ID: <trinity-ccc8c959-c9de-4327-aa3e-dab2ffd0b7e5-1617280926216@3c-app-webde-bs39>
From:   B A <chris.std@web.de>
To:     btrfs kernel mailing list <linux-btrfs@vger.kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>
Subject: Aw: Re: Re: Help needed with filesystem errors: parent transid
 verify failed
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 1 Apr 2021 14:42:06 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAJCQCtQ7qtNU4tjWKf8VcmjZiij5nHd0cUAbh4rRO+NWWnQ=BA@mail.gmail.com>
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQWtnjyN88gif-tmA_cxcs+6HPgVxB5XwNmAVj3qMKmfw@mail.gmail.com>
 <trinity-6258eac7-550c-402f-9280-6f529e372d32-1617093845116@3c-app-webde-bs38>
 <CAJCQCtQ7qtNU4tjWKf8VcmjZiij5nHd0cUAbh4rRO+NWWnQ=BA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:m+r1d12JW4Fi9DKuaB2AI/R+kNC39Lj4q9TBwIEyiJpXplocsdI1OwO5Z8MU7dZFJaj94
 kvTkVPhYiDLt0wdGMrFEZXTvMcCPMSedZWfkVhcZkJRdafbuy1BjmwnkeXzw/ZEnz3uZNe7AC2Es
 CrIyQQFlKQ2NuZT3QI4LyUKDpPf9Oq/M/w1G3tutLKv3D6T7t3/3EOy2Hm6ODnyMs2epKeRAAGOw
 y8XjkIf8CWjTKaZ7rFBwUIApX58MS+QONkBpki0+S0fjJRDZBnV5CsDuVmrxc+h8JuWwKrl1dLnV
 iw=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tgpp64ZM0+Y=:BEGlVi9qLPLqYZZv7YhrgY
 EKJnaRmVu15fjyeZgoYF5gUdYPD5S89HXjZGh6dkrIjZutMkfUuPxuOjumYxI8IelevJ2hVXi
 9aOkFKOHhbQER55+zWEI4e3hVk2XLHLFPmaCWf+4nEdIaD6ZLeiuxYyub0Y0wVimFYEuXgqz9
 CgyJDILpxFAFwAeIrnKqpAmlQi3BpFJMxkU45hmHHiRT16JvrPqWtaYLAVHT6zVFD9wu3gdfV
 ODn02mXteI7JoffgNk5AltJxbZJE44k0tw0cv8EYAWCKHVkYPojQRfgTPWFv80cc8vhFUTzr9
 Pguu5A+GV9eB4cdC5NjoBsP8QKTUur71mrEB1Ax4iECJbzdwCHvNMy6EpLUAdE3Yup+/1Npjp
 pthKY2126HG/Ds0mtmUQQ/NwrpruxZ139O0Jz8/lXTcUuSFojDbX73j28/OaUtqud00tVfegJ
 5v6c/Scn+3zpEpMLg1Kjf1svwry1Cvtk0p5nItBN6i0ofW0nAM98bejz1wXCyNWYrLU38a0MH
 lwOZx8PdScEf+7OOqNGefAAAHOR7Q39b7y63LGDtw7eQuLSyPaxac44JbmKq5Cl/6TwcQSIRX
 gkJkRHrfJvViitlu1rnBSPE7750Gb0GG7/Jk+dfr+Nr27cFSYxZ7spmMFjO66GgYuJehEWyhY
 qD7AJ1E/0rcfYnFrEOV0XP5MaL+aND1G3mqA+h/aOmOlaycGxLFh9BM8wXFGn1jYdWlUQ1w/C
 6AkXsKZKdifIXQF/E0zIeH5sMf5Nu4ILSiH5/k5cYtHnOuMuSfpjGT8UMm0lYNPDBv990pMDc
 sAldeJ+xBwt2S0G/qV41HU6r7g+UAOu2pxz+6Gmgwxya5adgyFCVQ4kg5eaQ5c4GZGTDyocCD
 csTQNaK2CM1O+6xGBhsN2n64DFHrdD/PBlgML1UDd5it8ztpzUwXr561xUvfuA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

> Gesendet: Dienstag, 30=2E M=C3=A4rz 2021 um 20:17 Uhr
> Von: "Chris Murphy" <lists@colorremedies=2Ecom>
>
> On Tue, Mar 30, 2021 at 2:44 AM B A <chris=2Estd@web=2Ede> wrote:
> >
> > > Gesendet: Dienstag, 30=2E M=C3=A4rz 2021 um 00:07 Uhr
> > > Von: "Chris Murphy" <lists@colorremedies=2Ecom>
> > > [=E2=80=A6]
> > > EVO or PRO? And what does its /proc/mounts line look like?
> >
> > Model is MZ-7TD500, which seems to be an EVO=2E Firmware is DXT08B0Q=
=2E
>=20
> For me smartctl reports
> Device Model:     Samsung SSD 840 EVO 250GB
> Firmware Version: EXT0DB6Q
>=20
> Yours might be a PRO or it could just be a different era EVO=2E Last I
> checked, Samsung had no firmware updates on their website for the 840
> EVO=2E While I'm aware of some minor firmware bugs related to smartctl
> testing, so far I've done well over 100 pull the power cord tests
> while doing heavy writes (with Btrfs), and have never had a problem=2E
> So I'd say there's probably not a "per se" problem with this model=2E
> Best guess is that since the leaves pass checksum, it's not
> corruption, but some SSD equivalent of a misdirected write (?) if
> that's possible=2E It just looks like these two leaves are in the wrong
> place=2E

I'd rather go with the theory you (indirectly) raised a few days ago that =
my RAM may misbehave (when you suggested I run memtest)=2E This is rather p=
ossible because I had difficulties understanding my BIOS and at some point =
I have accidentally enabled some overclocking=2E As I know this may cause t=
he RAM to misbehave (and I don't have ECC RAM), this may as well be the rea=
son=2E

>=20
> > > Total_LBAs_Written?
> >
> > Raw value:
> 92857573119
>=20
> OK I'm at 33063832698
>=20
> Well hopefully --repair will fix it (let us know either way) and if
> not, then we'll see what Josef can come up with, or alternatively you
> can just mkfs and restore from backups which will surely be faster=2E

Sadly it didn't (see other e-mail) but I think I'll go for the latter (mkf=
s and restore from backups) as I *think* my backups are fine and I don't wa=
nt to waste more of your time (unless Josef wants to get his changes tested=
)=2E

Thanks very much so far for the support and thanks for maintaining BTRFS :=
-)

Kind regards,
Chris

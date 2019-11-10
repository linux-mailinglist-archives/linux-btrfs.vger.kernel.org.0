Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7FF69CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 16:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfKJPkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 10:40:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36090 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfKJPkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 10:40:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id v19so8689038pfm.3
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2019 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/hgfKmETBK5TlVyXtIDxSNJ9lvAPFHdmJzH67tZWqnw=;
        b=dquQLwWZS6QARZJp7tYJ5LaagI9ftYt4jIImPHwbXP2Lld9yy9qkSHDziT+9H5Da0r
         QbSSualctyPA+GdQVoyXFEIc0/Y2BSdHVYCZj6bFatdXwOsUzTCnnMzfjneyMcyz4CzH
         xzdi4vp1kSCjtSyzk6PPR7ff+uRjccP5sMGr3BftP1KN0w5FnV1n2XCqmHKoTcJgAdYL
         yO7YkQ9FYAnlVAn9ufgJYugu+6bNQJ/3ODMiabOt2NXLL2Ym/VawTyMysP+e8/3DFPyy
         +QPkZr7wkM8fismX4cuTjNYp5wyjt+87p6sgoVPMYFutUZps8OicP/cHdYP2AU+02mk5
         EeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/hgfKmETBK5TlVyXtIDxSNJ9lvAPFHdmJzH67tZWqnw=;
        b=JqIKie2Yc49lQowTfTQUGL52kjRsR3FLCJH2L259C9UaGaTLuhO2gCIR6ZOE3sRoPA
         ueTqqLi2Lg8sHag9wefTNSaEohtZfuUR6mkjkQDgF2vyHEr1UNGCCs2MJLy6dnDKRBMG
         EAo7zGFL6QBO5afTByhqgAMgLMXLkaOKKBLBYBku1tlINI5XR1ChENU7flouiFj4f9C0
         43UNLOnxumwxU/MoFf5LWY/aZobLXSXfZKFhcCIP116CkqJbL16P8hrzxUp/owx8IatO
         Q+EoDnmTO9VgEkL/zoYDrh8FXMfLhSwkVbGU6XzDXUjZ+BuM+qwQfl2JfudY6HxcaaN2
         DChg==
X-Gm-Message-State: APjAAAVPxBCGMRsRjpDli0k7NVsdZs7Gerv2MP1hV8Uf8QJRd4lx7crD
        qwVi4vCQjWrjgsIpXJcnUcZ9ZjPA+VhEuGN9ADg=
X-Google-Smtp-Source: APXvYqzwrjt1JvsFWF6b4JjStRGO+OR6u4i9i557x53gjkzyuI/zPocG9IL+WEiTq9UZ2jh6XLm9ZfeuUdmPqYj5dVc=
X-Received: by 2002:a62:170b:: with SMTP id 11mr24518064pfx.85.1573400439040;
 Sun, 10 Nov 2019 07:40:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
 <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com> <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
 <1e600b1e-f61b-ab7a-85bc-8bd1710c2ea9@gmx.com> <CAJjG=74LUiRLbJiJ_BwgirqkA=i72t0GfJB0Masgkg0NHY0ozA@mail.gmail.com>
In-Reply-To: <CAJjG=74LUiRLbJiJ_BwgirqkA=i72t0GfJB0Masgkg0NHY0ozA@mail.gmail.com>
From:   Sergiu Cozma <lssjbrolli@gmail.com>
Date:   Sun, 10 Nov 2019 17:40:02 +0200
Message-ID: <CAJjG=74O4oMPpDkj2Ue2b+scnb6AM8Bvh_e3ZGQr2_gTEVSUuQ@mail.gmail.com>
Subject: Re: fix for ERROR: cannot read chunk root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

root   856153161728
chunk_root     856119312384

Aren't those nr too high for a 416GB partition?

On Thu, Nov 7, 2019 at 9:16 AM Sergiu Cozma <lssjbrolli@gmail.com> wrote:
>
> Well nothing to lose now so if you come up with any exotic ideas you
> wanna try please let me know, I will keep the partition for the next
> couple of days.
>
> Thank you for your time.
>
> On Thu, Nov 7, 2019 at 2:44 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2019/11/6 =E4=B8=8B=E5=8D=8811:52, Sergiu Cozma wrote:
> > > Hi, thanks for taking the time to help me out with this.
> > >
> > > The history is kinda bad, I tried to resize the partition but gparted
> > > failed saying that the the fs has errors and after throwing some
> > > commands found on the internet at it now I'm here :(
> >
> > Not sure how gparted handle resize, but I guess it should use
> > btrfs-progs to do the resize?
> >
> > >
> > > Any chance to recover or rebuild the chunk tree?
> >
> > I don't think so. Since it's wiped, there is no guarantee that only
> > chunk tree is wiped.
> >
> > THanks,
> > Qu
> >
> >
> > >
> > >
> > > On Wed, Nov 6, 2019, 13:34 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
> > >>> hi, i need some help to recover a btrfs partition
> > >>> i use btrfs-progs v5.3.1
> > >>>
> > >>> btrfs rescue super-recover https://pastebin.com/mGEp6vjV
> > >>> btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
> > >>> btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
> > >>>
> > >>> can't mount the partition with
> > >>> BTRFS error (device sdb4): bad tree block start, want 856119312384 =
have 0
> > >>
> > >> Something wiped your fs on-disk data.
> > >> And the wiped one belongs to one of the most essential tree, chunk t=
ree.
> > >>
> > >> What's the history of the fs?
> > >> It doesn't look like a bug in btrfs, but some external thing wiped i=
t.
> > >>
> > >> Thanks,
> > >> Qu
> > >>
> > >>> [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
> > >>> [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
> > >>>
> > >>
> >

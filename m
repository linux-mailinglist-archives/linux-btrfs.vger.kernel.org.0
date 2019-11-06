Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D321F1B19
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2019 17:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfKFQWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 11:22:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37279 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfKFQWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Nov 2019 11:22:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so12776350pfn.4
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Nov 2019 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4OETBcrCb/q+d4YqGCP5Fr4BmIUY8D2RjVPzMyo3en4=;
        b=RxPLBmfkrb3lzLnzo6I7rGFb9m6F9wKa8Ol3sXap7kNkkmfUGwpgnoNY2P2kfM7eSA
         GPU87uYr76vwCRD7eaR/HxX/N2ptuQGEY7MMbC5rDlH+jl6YvaAm2oPExRZ+AevZ+Rlr
         tV3spV7pIEEs48YSv/H8w13PwLmgYZK5hdNDxBE/sX2SzDqKE1LGv9V4oCYzWxyEKZPq
         4NO/O/kaEcLZjNUiVv1rCVSVmIHAKboH2/dvh84Rd2h06q3uAGu/Q66m8tBx7o2xZxSK
         WJeg4h/RItryOMxumANntvYb/02AbuPFF3eNN2hJrXUEiXHttAhaO4SQPd1Y/df7pXju
         DbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4OETBcrCb/q+d4YqGCP5Fr4BmIUY8D2RjVPzMyo3en4=;
        b=LaHfSiW0X9UalmQzC2nwNfN/bc7EuO+06zG377eUmOh6Usi14Ei+lU2VKmbOmCqLlY
         sJFdf7bwKLYnK5ECeP4Fvq8jdeU5FxBOODeRMVZQ8B158Q58b0iC/YsNUznuP3x7Nsyz
         ZMTkwF1N2INITXOxpNWBV8+A3Hx6nn7qywCAmWVCFGd4ApWeVgwi6VyUGkbixT6GyP/J
         /PrEiDOgIc8SWkRKMkgzfxtdcZ4jwSxLAUQ5QPS2aiAtQFEEouz6j/5QAdRt9CPQ/ZFd
         Xc5TiYWQkhxFiTHarIfBOS/XNrV3QsOu04X6Q6UsGcSL8UNF1sxAtv905UGin5/dvWLF
         3caQ==
X-Gm-Message-State: APjAAAVWwSXUHCxXRiOM6zxhgZ7KM7rUsNu7MVPLKVcEqRuUSgc/l0Yw
        cws1E4hGIVlwSuKXVKIM3hW9SuA9KGgOfdD+7h7q6jTEcJGEyg==
X-Google-Smtp-Source: APXvYqxrx3F1VHggUZ3W0Cl8nZ9Gdzroggcx5KcyzN0EAtC8R2tVPgdIoJhdZfJ4DT7O0qzUd6pEqqWgjD+1yJHzK2k=
X-Received: by 2002:a17:90a:25ea:: with SMTP id k97mr4757911pje.110.1573057340802;
 Wed, 06 Nov 2019 08:22:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
 <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com> <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
In-Reply-To: <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
From:   Sergiu Cozma <lssjbrolli@gmail.com>
Date:   Wed, 6 Nov 2019 18:21:44 +0200
Message-ID: <CAJjG=76E8X7h3UR2PDF1RsdRLgeMfwK_cF=OXkE8qBWOmUHfZQ@mail.gmail.com>
Subject: Re: fix for ERROR: cannot read chunk root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs inspect-internal dump-super -af /dev/sdb4 | grep chunk_root
chunk_root_generation   687369
chunk_root              856119312384
chunk_root_level        1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
chunk_root_generation   687369
chunk_root              856119312384
chunk_root_level        1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
chunk_root_generation   687369
chunk_root              856119312384
chunk_root_level        1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1
               backup_chunk_root:      856119312384    gen: 687369     leve=
l: 1

if i understand this correctly there is only one copy of the chunk
root in the whole fs and mine is corrupted?

On Wed, Nov 6, 2019 at 5:52 PM Sergiu Cozma <lssjbrolli@gmail.com> wrote:
>
> Hi, thanks for taking the time to help me out with this.
>
> The history is kinda bad, I tried to resize the partition but gparted
> failed saying that the the fs has errors and after throwing some
> commands found on the internet at it now I'm here :(
>
> Any chance to recover or rebuild the chunk tree?
>
>
> On Wed, Nov 6, 2019, 13:34 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
> > > hi, i need some help to recover a btrfs partition
> > > i use btrfs-progs v5.3.1
> > >
> > > btrfs rescue super-recover https://pastebin.com/mGEp6vjV
> > > btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
> > > btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
> > >
> > > can't mount the partition with
> > > BTRFS error (device sdb4): bad tree block start, want 856119312384 ha=
ve 0
> >
> > Something wiped your fs on-disk data.
> > And the wiped one belongs to one of the most essential tree, chunk tree=
.
> >
> > What's the history of the fs?
> > It doesn't look like a bug in btrfs, but some external thing wiped it.
> >
> > Thanks,
> > Qu
> >
> > > [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
> > > [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
> > >
> >

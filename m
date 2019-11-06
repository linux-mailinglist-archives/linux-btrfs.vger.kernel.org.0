Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C473DF2188
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2019 23:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfKFWU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 17:20:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33482 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFWUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Nov 2019 17:20:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so186475pfb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Nov 2019 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G7iZ4MorLdojnUKhke285Sd7F37vfcYmZ4iU5JsbIoQ=;
        b=pBW05nFjzjcrP1xxHKRyqTA3RCg8Y6xJ/S0NvLQg0wKOCRNA5ISxB1oFHe7ixc4Jlo
         HIPahgiCynJ6007L8p7DeYExBt93Nt/wkkIZR4zRsR8O/j9/WVgKQR2INvoDjbAK0d3K
         g9CrGUqj51GGAHdIoQbntq7vx7YUXb85cpZ05wDFBBL6xI2qvjrFu0eiU1PgV7mUKYc8
         bnS/PJmo4Kw5oDP3FUKlX7Y1TygosOKrbuLA7ZrLuNdAg0M4E07fJ3xEJyCnRD89ApSy
         lzMgoR2TBaV22L17rB4i63qhAhmizv5aviSG7SDtYwCVHUml9WmTGYQ+cjQgoFCNRpnG
         8CLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G7iZ4MorLdojnUKhke285Sd7F37vfcYmZ4iU5JsbIoQ=;
        b=r2AlkuAC1b47aJ/0A4g/VjIl9EedAQL6cVlsUPXw9OpCzBBpBdJ4QTcuhWiHdFXLyn
         xuuXpUCj0iAnDMIWOzaHnSxk8w2Oo1AdlycV5u5y4ZawD2/WGSwWyPLz7f18QIpOCPPn
         ncLmKUmVVg110kQ5rU3shS7cnpFjuXn3b8WCGzAh/R3YJlYo8/mVEwR1xXzxsb8oqAVM
         zD9lycaq+Kw/izZdkuc8yGTSyRF4K6T0T1ImQWevsRR8jGRggphuUjfmDKgO9/4Wu97K
         kT+rOg+L0W4AlCqutbh5lLsALKxC+Z4pAj7A6mrwCZwSUekswMHUcYrhWpW210bnD5+c
         klCw==
X-Gm-Message-State: APjAAAWm9MIm18gBLYRZ6zV5TnSF/Jjpo/Ldu7hjOnFwWVT1V1wdz7Bs
        gNZMPBGlpjDSPzgX9bf/Areyu/Qm+4yPgZPzbZQecdOTIQTl5Q==
X-Google-Smtp-Source: APXvYqxUh8oqo3mCSw9q7p3iXEkHcl1O/lMC4wxUBD00DYwGdxnXnVIumXE47tuv95TlZTwQZcwTJjNk7UCyjE+SFhg=
X-Received: by 2002:a63:fe09:: with SMTP id p9mr173823pgh.293.1573078824755;
 Wed, 06 Nov 2019 14:20:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
 <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com> <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
 <CAJjG=76E8X7h3UR2PDF1RsdRLgeMfwK_cF=OXkE8qBWOmUHfZQ@mail.gmail.com>
In-Reply-To: <CAJjG=76E8X7h3UR2PDF1RsdRLgeMfwK_cF=OXkE8qBWOmUHfZQ@mail.gmail.com>
From:   Sergiu Cozma <lssjbrolli@gmail.com>
Date:   Thu, 7 Nov 2019 00:19:48 +0200
Message-ID: <CAJjG=77gtuw0wMJeL62MJoznekz7dyzCBTvmRTL5WrtzfhQhVA@mail.gmail.com>
Subject: Re: fix for ERROR: cannot read chunk root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

additional info: it's a simple partition on a samsung 840evo ssd, no
encryption, no md, no raid
 mount flags rw,relatime,ssd,space_cache,subvolid=3D5,subvol=3D/ mounted as=
 /home
and it's pretty old(couple of years) and i'm like 70% sure it was
converted from ext4

On Wed, Nov 6, 2019 at 6:21 PM Sergiu Cozma <lssjbrolli@gmail.com> wrote:
>
> btrfs inspect-internal dump-super -af /dev/sdb4 | grep chunk_root
> chunk_root_generation   687369
> chunk_root              856119312384
> chunk_root_level        1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
> chunk_root_generation   687369
> chunk_root              856119312384
> chunk_root_level        1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
> chunk_root_generation   687369
> chunk_root              856119312384
> chunk_root_level        1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>                backup_chunk_root:      856119312384    gen: 687369     le=
vel: 1
>
> if i understand this correctly there is only one copy of the chunk
> root in the whole fs and mine is corrupted?
>
> On Wed, Nov 6, 2019 at 5:52 PM Sergiu Cozma <lssjbrolli@gmail.com> wrote:
> >
> > Hi, thanks for taking the time to help me out with this.
> >
> > The history is kinda bad, I tried to resize the partition but gparted
> > failed saying that the the fs has errors and after throwing some
> > commands found on the internet at it now I'm here :(
> >
> > Any chance to recover or rebuild the chunk tree?
> >
> >
> > On Wed, Nov 6, 2019, 13:34 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >
> > >
> > >
> > > On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
> > > > hi, i need some help to recover a btrfs partition
> > > > i use btrfs-progs v5.3.1
> > > >
> > > > btrfs rescue super-recover https://pastebin.com/mGEp6vjV
> > > > btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
> > > > btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
> > > >
> > > > can't mount the partition with
> > > > BTRFS error (device sdb4): bad tree block start, want 856119312384 =
have 0
> > >
> > > Something wiped your fs on-disk data.
> > > And the wiped one belongs to one of the most essential tree, chunk tr=
ee.
> > >
> > > What's the history of the fs?
> > > It doesn't look like a bug in btrfs, but some external thing wiped it=
.
> > >
> > > Thanks,
> > > Qu
> > >
> > > > [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
> > > > [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
> > > >
> > >

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C214D3CD9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 23:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiCIWXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 17:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiCIWXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 17:23:41 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3A2183F
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 14:22:41 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso4572016oop.13
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 14:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BA/wPfk+CPXylDN+radXlpEYSnckYSB2fkULcOr9plk=;
        b=dJbVBTznpIDCuI2bSLq60cG3zM1w78DNhTni4CKApOiZfC6DsR/yEVpeZdSzwWbPms
         TXcfIwRsa8QdWqeoT4e2KzxF7EhMEdM1NNi8jDrOzh3Y+7sx6eByTzMs07UGVsZ8J0HG
         tPpVM9mrghHLvCgptMeG2qMTPZ4XqMpwMVlfuJ+ycaj3ccs8mACP2dzjTtjbAZ2TIq6P
         g6piXwuSH8Ksv8urx2yaFDjasf4u4znvI6LAtBlKvXEi0oYAPhnrDDfobDEyEKU+c3/U
         kzgHM+h1MGYUwBNp7EAc/Q3LgDaO8CfDL44YWR9Z7MoRDdV+K0aPAmcCoIgX1sPOlRUm
         0RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BA/wPfk+CPXylDN+radXlpEYSnckYSB2fkULcOr9plk=;
        b=u2+kYxDR9O14CtRl6wknRgEBVnIvoXdLZoUlrscp7NqZHY6Tj0xAYQ4aAkl6ISmkSz
         08JvSSG5quJUxkg/hEfVokOd7KAdU2H4pfLxalMcbLlebS3nF/o5O82kmak10z6fJJFK
         +H8vP72wS5cLbip2h+/QJCkTJEv/i/Yv/vnHU2OzieY+sb204DigiTJjezzHBqTK8bab
         EANGtI1yhhe44Eb7sDKUa5FM84ZlN21S/Xla/dhQ0W4+0Ub/3ydgCH9IkNPnasVh5MK/
         6ttpX3V7xe1skyvFVZvREtdV0RkX/Q2hgGVKwZqRXWHFwG40vwULmob4ftd4aVqahZYC
         RQTg==
X-Gm-Message-State: AOAM531AUvOBfujg723J1jaYdbPpXOJW1Kn298OiBv855i6dHn8F8tXT
        QxXc3BVpV+BUNBUwZdYpsNa50qdcYC+Qj+IuMZlhtDc+LkA=
X-Google-Smtp-Source: ABdhPJzVSawMkZZRcMVmeuElQNdSU4FBlajuSvJ6yuBxrvn8R4rVsQ8oCjxAcLRSdawTFSJXoLyynBttRBA8vNgc7x8=
X-Received: by 2002:a4a:dcd6:0:b0:321:2728:d4cd with SMTP id
 h22-20020a4adcd6000000b003212728d4cdmr978493oou.33.1646864560979; Wed, 09 Mar
 2022 14:22:40 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
 <3f286144-d4c4-13f6-67d9-5928a94611af@gmx.com>
In-Reply-To: <3f286144-d4c4-13f6-67d9-5928a94611af@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 9 Mar 2022 23:22:05 +0100
Message-ID: <CAODFU0r8QqbuHdH_vG21bPacuMM+dmzMbdSq23TPHxL=R1DbgQ@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 9, 2022 at 12:40 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2022/3/9 05:57, Jan Ziak wrote:
> > On Mon, Mar 7, 2022 at 3:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> On 2022/3/7 10:23, Jan Ziak wrote:
> >>> BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
> >>> (uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
> >>> file-with-million-extents" doesn't finish even after several minutes
> >>> of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
> >>> ioctl syscalls per second - and appears to be slowing down as the
> >>> value of the "fm_start" ioctl argument grows; e2fsprogs version
> >>> 1.46.5). It would be nice if filefrag was faster than just a few
> >>> ioctls per second.
> >>
> >> This is mostly a race with autodefrag.
> >>
> >> Both are using file extent map, thus if autodefrag is still trying to
> >> redirty the file again and again, it would definitely cause problems for
> >> anything also using file extent map.
> >
> > It isn't caused by a race with autodefrag, but by something else.
> > Autodefrag was turned off when I was running "filefrag
> > file-with-million-extents".
> >
> > $ /usr/bin/time filefrag file-with-million-extents.sqlite
> > Ctrl+C Command terminated by signal 2
> > 0.000000 user, 4.327145 system, 0:04.331167 elapsed, 99% CPU
>
> Too many file extents will slow down the full fiemap call.
>
> If you use ranged fiemap, like:
>
>   xfs_io -c "fiemap -v 0 4k" <file>
>
> It should finish very quick.

Unfortunately, that doesn't seem to be the case (Linux 5.16.12).

xfs_io -c "fiemap -v 0 4g" completes and prints

  ....
  16935: [8387168..8388791]: 22237781600..22237783223  1624   0x0

in 0.6 seconds.

But xfs_io -c "fiemap -v 0 40g" is significantly slower, does not
complete in a reasonable time, and makes it to 1000

   ....
  1000: [154576..154903]: 22232564688..22232565015   328   0x0
   ....

in 6.5 seconds.

The NVMe device was mostly idle when running the above commands (reads
and writes per second were close to zero).

In summary: xfs_io -c "fiemap -v 0 4g" is approximately 185 times
faster than xfs_io -c "fiemap -v 0 40g".

-Jan

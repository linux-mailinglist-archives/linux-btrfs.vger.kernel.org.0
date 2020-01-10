Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF3A1371B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgAJPtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 10:49:08 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:40401 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAJPtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 10:49:08 -0500
Date:   Fri, 10 Jan 2020 15:49:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578671344;
        bh=VQe0PUOh2QYkiUbAG1XPOvFt/glgNppECRODm+mxooE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=tlLbU3e3V70A4V/73FL9YvTlNo1A56fTnWBUD5Z4Qmni0YwmFYaNKgFs0Ou9hbAJE
         IesOVtXqNMHiN0c9ZwNf1oP/L7lhsVFzBPrKW5KXL6jqc53he3ZVLqDzkZS/RJWMOC
         HtGkyHI4CJnziF6THOU2rcGl0CjcLDTw3QEl2cUs=
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   Raviu <raviu@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Raviu <raviu@protonmail.com>
Subject: Re: Cannot mount or recover btrfs
Message-ID: <WRo_3945htQfxtDZZNkPAwuneW3b_pFPZwAcuTpF1uxy_SJhqv2NYE5Hz7laeNzoaGXYH_8ZIVaD2mZT-PLqz_pSB7CAR1GsUGtnC4xoxyE=@protonmail.com>
In-Reply-To: <GcVUmbGhdxe1MDb3v9U3AMetZhThLuSy7raXfZeZcmaELxVwlw1ekBr7UU5-4_Mz4dg7H6D09PwzU9WY0ou2Mhfp_FR9cDefy6c-e2Y-Ghw=@protonmail.com>
References: <qxM9wPidCbIA9yMGE4e57cGzc5GkQnFF39Q2h1PLV0XTLpSVZ1nvi9wDfOD3YXIAl3GYyq2wRoG8ncoE692e0MVUah_rmDSRggyZz_trQH0=@protonmail.com>
 <3f51a5fa-90db-7247-ec78-b57b9798b99b@gmx.com>
 <GcVUmbGhdxe1MDb3v9U3AMetZhThLuSy7raXfZeZcmaELxVwlw1ekBr7UU5-4_Mz4dg7H6D09PwzU9WY0ou2Mhfp_FR9cDefy6c-e2Y-Ghw=@protonmail.com>
Feedback-ID: s2UDJFOuCQB5skd1w8rqWlDOlD5NAbNnTyErhCdMqDC7lQ_PsWqTjpdH2pOmUWgBaEipj53UTbJWo1jzNMb12A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Would a duplicate metadata be of any help in my case?
If my filesystem was formatted with duplicate metadata I mean.

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, January 7, 2020 9:35 AM, Raviu <raviu@protonmail.com> wrote:

> I've restored over 90% of the data using restore command, and reformatted=
 disk before I got the email.
> But I can confirm that I'd RAM corruption, I've done memtest per your rec=
ommendation and found that the 1st module of the two modules is bad.
> Corruption was severe and repetitive, I just exclaim how did this server =
corruption went without notice from the linux kernel other than random rare=
 lockups. I'm really amazed how apps and kernel was functioning! Data is re=
ally changed on ram.
> I've upgraded to vanilla kernel 5.4.6 before doing the memtest, so the la=
test kernel was not panic about this bad RAM.
>
> Isn't this something that should be fixed?
>
> Sent with ProtonMail Secure Email.
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Monday, December 30, 2019 7:38 AM, Qu Wenruo quwenruo.btrfs@gmx.com wr=
ote:
>
> > On 2019/12/29 =E4=B8=8B=E5=8D=8811:05, Raviu wrote:
> >
> > > Hi,
> > > My system suddenly crashed, after reboot I cannot mount /home any mor=
e.
> > > `uname -a`
> > > Linux moonIk80 4.12.14-lp151.28.36-default #1 SMP Fri Dec 6 13:50:27 =
UTC 2019 (8f4a495) x86_64 x86_64 x86_64 GNU/Linux
> > > btrfs-progs v5.4
> > > `btrfs fi show`
> > > Label: none uuid: 378faa6e-8af0-415e-93f7-68b31fb08a29
> > > Total devices 1 FS bytes used 194.99GiB
> > > devid 1 size 232.79GiB used 231.79GiB path /dev/mapper/cr_sda4
> > > The device cannot be mounted.
> > > [ 188.649876] BTRFS info (device dm-1): disk space caching is enabled
> > > [ 188.649878] BTRFS info (device dm-1): has skinny extents
> > > [ 188.656364] BTRFS critical (device dm-1): corrupt leaf: root=3D2 bl=
ock=3D294640566272 slot=3D104, unexpected item end, have 42739 expect 9971
> >
> > As Hugo has already pointed out, this looks very like a bit flip.
> > Thus a memtest is highly recommended.
> > Also, your kernel is a little old. I'm not sure if the distro (I guess
> > it's openSUSE or SLE?) had all the backports, but starts from v5.2, we
> > had newer write-time tree-checker to even prevent such bitflip written
> > back to disk, thus we could catch them earlier.
> > This is extent tree, in theory you can always salvage the data using
> > `btrfs-restore`.
> > But that's the last resort method.
> >
> > > [ 188.656374] BTRFS error (device dm-1): failed to read block groups:=
 -5
> > > [ 188.700088] BTRFS error (device dm-1): open_ctree failed
> > > `btrfs check /dev/mapper/cr_sda4`
> > > Opening filesystem to check...
> > > incorrect offsets 9971 42739
> > > incorrect offsets 9971 42739
> > > incorrect offsets 9971 42739
> > > ERROR: failed to read block groups: Operation not permitted
> > > ERROR: cannot open file system
> >
> > If you can re-compile btrfs-progs, you can try this branch:
> > https://github.com/adam900710/btrfs-progs/tree/dirty_fix_for_raviu
> > Then use the compiled btrfs-corrupt-block (I know it's a terrible name)
> > to fix the fs:
> > ./btrfs-corrupt-block -X /dev/dm-1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > It should output what it fixed if it found anything.
> > Thanks,
> > Qu



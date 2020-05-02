Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DCD1C26AD
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgEBPvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 11:51:43 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:16748 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgEBPvn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 11:51:43 -0400
Date:   Sat, 02 May 2020 15:51:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1588434701;
        bh=0ZJRhd/UzqG6L0d2rXmRK3aeqtHBpvyrRZYBN/BTfYE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=fjCUBqovBQdlAsp85VhBuJycYj0aU1Kxi2uOEYU4xY9tLfMlZFtLbWOwcjp5E+AEX
         ZwfinnMHp/IPY/NQKY+J37lnsWSelDitElRVYrk8jmq9OIYohTg2RAa8QxSi4mNc84
         L8qqRTd/RMk1jJNjIgl0ysMsb9j5JtcwetcWdVII=
To:     Chris Murphy <lists@colorremedies.com>
From:   Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Reply-To: Nouts <nouts@protonmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read block groups
Message-ID: <DQCllnVeUApb40W6_xKaNlAxRJlhCTeYnZEP5r3dZvF0AZejwemvJK-CWfNtV56zb5-LZaPuH-4WgD_-SxDeE2b_TYCRDeTo-2aN4atItbY=@protonmail.com>
In-Reply-To: <ZL8K9EyQa7EnOmd3WjfSsNFy8hYbikAq4lO6CTK1vc-HoXoqpY9CKKcYd2xFCwEDvry2aLuZvbwK91-2_J-Zu6tDL6sovvr4jRIATnhmyMQ=@protonmail.com>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
 <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
 <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com>
 <XzvzKWYVgWGlgX7GSa5XGfQcMuM4od6BMpG63kC2X3thsAfl0i__swcKuMF3TcdiInqnifyiphevLoacMdYlEn7YDqj8JDLKFaZRZsoQx1Q=@protonmail.com>
 <CAJCQCtQ=hwE-wwPXEw_r+VOe36zsHYmpx7updj4JOMmQqQeM8w@mail.gmail.com>
 <ZL8K9EyQa7EnOmd3WjfSsNFy8hYbikAq4lO6CTK1vc-HoXoqpY9CKKcYd2xFCwEDvry2aLuZvbwK91-2_J-Zu6tDL6sovvr4jRIATnhmyMQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Well, I changed my mind. I'll wait a few more days, for the beginning of th=
e next week, if you have any magical command left :)
I'm not sure to understand it but can a "restore" command dump all of the d=
ata in a new readable disc ?




=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Saturday, May 2, 2020 4:55 PM, Nouts <nouts@protonmail.com> wrote:

> For the record, I ran check and check --repair with the new btrfs-progs. =
Both returned this error :
>
> Opening filesystem to check...
> ERROR: child eb corrupted: parent bytenr=3D5923702292480 item=3D2 parent =
level=3D2 child level=3D0
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
> I'm gonna wipe the drive and restore a backup as I've lost hope recoverin=
g and can't wait any longer.
> Thanks a lot for your help !
>
> Nouts
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Thursday, April 30, 2020 9:18 PM, Chris Murphy lists@colorremedies.com=
 wrote:
>
> > On Thu, Apr 30, 2020 at 1:05 PM Nouts nouts@protonmail.com wrote:
> >
> > > Here is the dump --follow : https://pastebin.com/yx13mDfB
> > > Sadly, none of "mount" worked.
> >
> > Yep. I can't tell from the check error or the dump output, whether
> > it's worth trying chunk recover again with the latest progs, or check
> > with --repair. But either of those makes changes to the file system,
> > so best to get advice from a developer first and in the meantime
> > refresh backups.
> > I don't know that a newer kernel will help in this case, because even
> > the latest progs complains. And the output from check doesn't give
> > enough information to know what to try next or if it's hopeless.
> >
> > Chris Murphy



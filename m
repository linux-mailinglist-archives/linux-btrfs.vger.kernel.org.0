Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25041C8B7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGMzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 08:55:25 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137]:24424 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgEGMzZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 08:55:25 -0400
Date:   Thu, 07 May 2020 12:55:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1588856123;
        bh=TELeaw3TNIzRRQ8a0sPQ63sZdUt/eCWCE7p0eXzqix4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=IozZJwWwZ4YaGZ4WKur7Jp7BS/VFkec4MT/rrMv6Qi8fXThsxWDBofUP0pNlKQbHY
         nGcn+W2dU2SiuS8YYfNPSJJTyG83gbVl8OVGLG8M7VsVEK23JJ/STjXy8PD/q83jaM
         C/TczsRgaUKFYlEkSS9yoD/24LlR37OPz3Ndo4C8=
To:     Chris Murphy <lists@colorremedies.com>
From:   Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Reply-To: Nouts <nouts@protonmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read block groups
Message-ID: <eGSGSeFih4vXmJDS3fzSSPiTp2_XwNQiDrfBVEEnP_aeLbBSFeOp0lC9xEjXS509a5l4dFhJniZfYBvN0a7SjpBUnCQkx0uF8RvdriS8maI=@protonmail.com>
In-Reply-To: <WWJvfdDerZkhiBg_J3WCgQq_oTtujW6_n-sw5WA-aCBzVuAKGh8NNpwTeLyD1ujMXAsGE1kkEy3ZeMVuZWMjx8mI8iz6P_SQV35A80mSZfo=@protonmail.com>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
 <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com>
 <XzvzKWYVgWGlgX7GSa5XGfQcMuM4od6BMpG63kC2X3thsAfl0i__swcKuMF3TcdiInqnifyiphevLoacMdYlEn7YDqj8JDLKFaZRZsoQx1Q=@protonmail.com>
 <CAJCQCtQ=hwE-wwPXEw_r+VOe36zsHYmpx7updj4JOMmQqQeM8w@mail.gmail.com>
 <ZL8K9EyQa7EnOmd3WjfSsNFy8hYbikAq4lO6CTK1vc-HoXoqpY9CKKcYd2xFCwEDvry2aLuZvbwK91-2_J-Zu6tDL6sovvr4jRIATnhmyMQ=@protonmail.com>
 <DQCllnVeUApb40W6_xKaNlAxRJlhCTeYnZEP5r3dZvF0AZejwemvJK-CWfNtV56zb5-LZaPuH-4WgD_-SxDeE2b_TYCRDeTo-2aN4atItbY=@protonmail.com>
 <CAJCQCtTjWc=Z4mE604Pfc1tKbWcrJNT6qmPB=HVmM4N8MhFW3g@mail.gmail.com>
 <WWJvfdDerZkhiBg_J3WCgQq_oTtujW6_n-sw5WA-aCBzVuAKGh8NNpwTeLyD1ujMXAsGE1kkEy3ZeMVuZWMjx8mI8iz6P_SQV35A80mSZfo=@protonmail.com>
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

Also, I just read about SMR disk and noticed my RAID1 is build only on SMR =
disk, no CMR.
I also use hardlink a lot due to Radarr/Sonarr. The day before it all gone =
wrong, I deleted some data (deleting the original files), leaving only the =
second files (the hardlinked one).

Could the mix of both be responsible of my issue ?


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, May 6, 2020 9:31 PM, Nouts <nouts@protonmail.com> wrote:

> Hello again,
>
> Do you think someone will be able to tell us more about reports I provide=
d ?
> I ordered a new drive that can fit all the data from a "restore", so I'll=
 wait until it's delivered.
>
> Nouts
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Saturday, May 2, 2020 7:53 PM, Chris Murphy lists@colorremedies.com wr=
ote:
>
> > On Sat, May 2, 2020 at 9:51 AM Nouts nouts@protonmail.com wrote:
> >
> > > Well, I changed my mind. I'll wait a few more days, for the beginning=
 of the next week, if you have any magical command left :)
> > > I'm not sure to understand it but can a "restore" command dump all of=
 the data in a new readable disc ?
> >
> > Yes, that's the only way it works. It's an offline scraping tool. It
> > is possible for recovered files to be corrupt, the point of the tool
> > is to improve the chance of recovery. So it doesn't have the same
> > safeguards that Btrfs has, where EIO happens upon corruption being
> > detected.
> > https://btrfs.wiki.kernel.org/index.php/Restore
> >
> > Chris Murphy



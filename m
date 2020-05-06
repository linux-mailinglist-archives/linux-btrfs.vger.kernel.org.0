Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545901C7A4E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 21:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgEFTcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 15:32:04 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:60836 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgEFTcE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 15:32:04 -0400
Date:   Wed, 06 May 2020 19:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1588793522;
        bh=Y0KA4epkPamwtLoOSwq9QDIbbwOsfXP5XukHH8kX4iM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=PvqbiiglpvBOndAKUXegXTQX75DstgK7yIQvPz1Xvfe+Q1uN5gFA0Hx/3OYQB+ow7
         5wDdR9rtmTQJANOMH+HPbGqRZm0jUOLaEAXDw5aVhsHibwt2XpBFjBda517cUXJRQ/
         k9fntPrlU5N8xohzLnZAWICfv7Ppuz0WhpoHLOfI=
To:     Chris Murphy <lists@colorremedies.com>
From:   Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Reply-To: Nouts <nouts@protonmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read block groups
Message-ID: <WWJvfdDerZkhiBg_J3WCgQq_oTtujW6_n-sw5WA-aCBzVuAKGh8NNpwTeLyD1ujMXAsGE1kkEy3ZeMVuZWMjx8mI8iz6P_SQV35A80mSZfo=@protonmail.com>
In-Reply-To: <CAJCQCtTjWc=Z4mE604Pfc1tKbWcrJNT6qmPB=HVmM4N8MhFW3g@mail.gmail.com>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
 <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
 <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com>
 <XzvzKWYVgWGlgX7GSa5XGfQcMuM4od6BMpG63kC2X3thsAfl0i__swcKuMF3TcdiInqnifyiphevLoacMdYlEn7YDqj8JDLKFaZRZsoQx1Q=@protonmail.com>
 <CAJCQCtQ=hwE-wwPXEw_r+VOe36zsHYmpx7updj4JOMmQqQeM8w@mail.gmail.com>
 <ZL8K9EyQa7EnOmd3WjfSsNFy8hYbikAq4lO6CTK1vc-HoXoqpY9CKKcYd2xFCwEDvry2aLuZvbwK91-2_J-Zu6tDL6sovvr4jRIATnhmyMQ=@protonmail.com>
 <DQCllnVeUApb40W6_xKaNlAxRJlhCTeYnZEP5r3dZvF0AZejwemvJK-CWfNtV56zb5-LZaPuH-4WgD_-SxDeE2b_TYCRDeTo-2aN4atItbY=@protonmail.com>
 <CAJCQCtTjWc=Z4mE604Pfc1tKbWcrJNT6qmPB=HVmM4N8MhFW3g@mail.gmail.com>
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

Hello again,


Do you think someone will be able to tell us more about reports I provided =
?
I ordered a new drive that can fit all the data from a "restore", so I'll w=
ait until it's delivered.

Nouts

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Saturday, May 2, 2020 7:53 PM, Chris Murphy <lists@colorremedies.com> wr=
ote:

> On Sat, May 2, 2020 at 9:51 AM Nouts nouts@protonmail.com wrote:
>
> > Well, I changed my mind. I'll wait a few more days, for the beginning o=
f the next week, if you have any magical command left :)
> > I'm not sure to understand it but can a "restore" command dump all of t=
he data in a new readable disc ?
>
> Yes, that's the only way it works. It's an offline scraping tool. It
> is possible for recovered files to be corrupt, the point of the tool
> is to improve the chance of recovery. So it doesn't have the same
> safeguards that Btrfs has, where EIO happens upon corruption being
> detected.
>
> https://btrfs.wiki.kernel.org/index.php/Restore
>
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------
>
> Chris Murphy



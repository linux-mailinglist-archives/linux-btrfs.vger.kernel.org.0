Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D51C0591
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD3TFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 15:05:13 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:61043 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD3TFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 15:05:13 -0400
Date:   Thu, 30 Apr 2020 19:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1588273510;
        bh=V5zqsqX+QdFtR36KFcFr6O6Gzq2jn4RNbIOoQ9nCLXY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=mmhN5Z5xJ5vpfdO5/3eBofjeyUjnMcgAv4Spr9hXhr008UvOYVEOYVbfmesKQLrrK
         SMEEmQKEy+KEqFKlpPjR6AjaslbBYOxsMzzg4vSPd576RgMfC88MMi6OjdW0zjXHC9
         7IAUDb6/lFok9mmlQKz1CKBetqCNfdPYYYHn9R2I=
To:     Chris Murphy <lists@colorremedies.com>
From:   Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Nouts <nouts@protonmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read block groups
Message-ID: <XzvzKWYVgWGlgX7GSa5XGfQcMuM4od6BMpG63kC2X3thsAfl0i__swcKuMF3TcdiInqnifyiphevLoacMdYlEn7YDqj8JDLKFaZRZsoQx1Q=@protonmail.com>
In-Reply-To: <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
 <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
 <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com>
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

Here is the dump --follow : https://pastebin.com/yx13mDfB
Sadly, none of "mount" worked.

I'm on debian 9, already using backported Kernel.
For Kernel 5.4 or 5.6, I would have to use debian testing repo...
I'll see what I can do without breaking the rest of my system :)


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, April 30, 2020 8:46 PM, Chris Murphy <lists@colorremedies.com>=
 wrote:

> On Thu, Apr 30, 2020 at 12:40 PM Nouts nouts@protonmail.com wrote:
>
> > Thanks for your help. I compiled btrfs-progs v5.6 from github.
> > Here is the dump from /dev/sda : https://pastebin.com/e3YZxxsZ
> > And btrfs check returned an error instantly :
> > Opening filesystem to check...
> > ERROR: child eb corrupted: parent bytenr=3D5923702292480 item=3D2 paren=
t level=3D2 child level=3D0
> > ERROR: failed to read block groups: Input/output error
> > ERROR: cannot open file system
>
> Ok try:
> btrfs insp dump-t -b 5923702292480 --follow /dev/sda
>
> Qu might have an idea. But in the meantime, my suggestion is to try to
> mount with a newer kernel. In order try:
>
> normal mount
> mount -o ro
> mount -o ro,degraded
> mount -o ro,degraded,usebackuproot
>
> And if any works, at least you can update backups in case this file
> system can't be fixed.
>
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------------------
>
> Chris Murphy



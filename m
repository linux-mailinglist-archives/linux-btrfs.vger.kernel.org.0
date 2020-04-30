Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C71BFC41
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgD3OEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 10:04:25 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:48047 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgD3OEV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 10:04:21 -0400
Date:   Thu, 30 Apr 2020 14:04:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1588255458;
        bh=xgCw1i7d7jybsvQmlFh5lYfhJcFmcIuEuGS43iRfyuw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=eVGkfpZ+OFN/YMdV+tcQEvSI9lO3TJYpvGQ7SZFPBr/LapPchRbb8X5xTocNN6Aoh
         J0JAXeMF+rwL24BwAqhd0jl7jTKHNHLEeBUrvIMkXtsxXD/pL0vU9cgO/FOkAt1REN
         x8CnfqLH0WQyQoaGyIUjCkunr8FV5ktf2wxkhO4M=
To:     Hugo Mills <hugo@carfax.org.uk>
From:   Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Nouts <nouts@protonmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read block groups
Message-ID: <NVm09ktMbxb2ycTV__dSAr2bxtsJeMDwHm-BNZmTCvqDGNAwwiv4ho9F3VnHJev5xslJs0Hb95GeZalWN5_y5XrpXzDWsJmYle0sb8f7Zb0=@protonmail.com>
In-Reply-To: <20200430134652.GA1623@savella.carfax.org.uk>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <20200430134652.GA1623@savella.carfax.org.uk>
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

Arf ! Thanks for letting me know.
Here is a download link from my previous attachment
https://drop.tigwali.fr/r/PiTaYrbxwL#TXjCkEo4nx1GZkZV4tUlJeajpMi9GHa+hB60IO=
V+BqM=3D

I'll wait a bit more then, if you can tell what happened to my drive :)



=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, April 30, 2020 3:46 PM, Hugo Mills <hugo@carfax.org.uk> wrote:

> On Thu, Apr 30, 2020 at 11:41:11AM +0000, Nouts wrote:
>
> > Hello again,
> > I'm not familiar with mailing list. Should I expect an answer sooner or=
 later ?
>
> Your original mail didn't get through to the list, as far as I can
> see. I'd guess the attachment was too large, and the mail server
> swallowed it.
>
> Hugo.
>
> > As I need to get back on track as soon as possible, I would like to kno=
w if it's too complicated to get an answer quickly from you.
> > I don't want to be rude, I just want to know if I should wait long enou=
gh for an answer that might save my day and my data. Or I'm doomed and I sh=
ould have wipe my drive already ?
> > I'll take any answer :)
> > Thank you
> > Nouts
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Tuesday, April 28, 2020 11:26 AM, Nouts nouts@protonmail.com wrote:
> >
> > > Hello,
> > > I am having issue with a RAID1 btrfs pool "failed to read block group=
s". I was advised to send information to this mailing list, as someone migh=
t be interested in debug logs and might also help solve my issue.
> > > I have a 3 drive RAID1 pool (2x3TB + 1x6TB), mounted as /home.
> > > My system became really slow while doing nothing, and after a reboot =
my /home pool can't mount.This is the error I got :
> > > [ 4645.402880] BTRFS info (device sdb): disk space caching is enabled
> > > [ 4645.405687] BTRFS info (device sdb): has skinny extents
> > > [ 4645.451484] BTRFS error (device sdb): failed to read block groups:=
 -117
> > > [ 4645.472062] BTRFS error (device sdb): open_ctree failed
> > > mount: wrong fs type, bad option, bad superblock on /dev/sdb,missing =
codepage or helper program, or other error
> > > In some cases useful info is found in syslog - trydmesg | tail or so.
> > > I attached you the smartctl result from the day before and the last s=
crub report I got from a month ago. From my understanding, it was ok.
> > > I use hardlink (on the same partition/pool) and I deleted some data j=
ust the day before. I suspect my daily scrub routine triggered something th=
at night and next day /home was gone.
> > > I can't scrub anymore as it's not mounted. Mounting with usebackuproo=
t or degraded or ro produce the same error.
> > > I tried "btrfs check /dev/sda" :
> > > checking extents
> > > leaf parent key incorrect 5909107507200
> > > bad block 5909107507200
> > > Errors found in extent allocation tree or chunk allocation
> > > Checking filesystem on /dev/sda
> > > UUID: 3720251f-ef92-4e21-bad0-eae1c97cff03
> > > Then "btrfs rescue super-recover /dev/sda" :
> > > All supers are valid, no need to recover
> > > Then "btrfs rescue zero-log /dev/sda", which produced a weird stacktr=
ace...
> > > Unable to find block group for 0
> > > extent-tree.c:289: find_search_start: Assertion '1' failed.
> > > btrfs[0x43e418]
> > > btrfs(btrfs_reserve_extent+0x5c9)[0x4425df]
> > > btrfs(btrfs_alloc_free_block+0x63[0x44297c]
> > > btrfs(__btrfs_cow_block+0xfc[0x436636]
> > > btrfs(btrfs_cow_block+0x8b)[0x436bd8]
> > > btrfs[0x43ad82]
> > > btrfs(btrfs_commit_transaction+0xb8)[0x43c5dc]
> > > btrfs[0x42c0d4]btrfs(main+0x12f)[0x40a341]/lib/x86_64-linux-gnu/libc.=
so.6(__libc_start_main+0xf1)[0x7f1462d712e1]
> > > btrfs(_start+0x2a)[0x40a37a]
> > > Clearing log on /dev/sda, previous log_root 0, level 0
> > > Finally I tried "btrfs rescue chunk-recover /dev/sda", which run on a=
ll 3 drives at the same time during 8+ hours...
> > > It asks to rebuild some metadata tree, which I accepted (I did not sa=
ved the full output sorry) and it ended with the same stacktrace as above.
> > > The only command left is "btrfs check --repair" but I afraid it might=
 do more bad than good.
> > > I'm running Debian 9 (still, because of some dependencies). My kernel=
 is already backported : 4.19.0-0.bpo.6-amd64 #1 SMP Debian 4.19.67-2+deb10=
u2~bpo9+1 (2019-11-12) x86_64 GNU/Linux
> > > btrfs version : v4.7.3
> > > I originally posted on reddit : https://www.reddit.com/r/btrfs/commen=
ts/g99v4v/nas_raid1_not_mounting_failed_to_read_block_groups/
> > > Let me know if you need more information.
> > > Nouts
>
> --
>
> Hugo Mills | To an Englishman, 100 miles is a long way; to an
> hugo@... carfax.org.uk | American, 100 years is a long time.
> http://carfax.org.uk/ |
> PGP: E2AB1DE4 | Earle Hitchner



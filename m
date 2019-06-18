Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136C74AB56
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfFRUDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:03:12 -0400
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:60456 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730189AbfFRUDM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:03:12 -0400
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id A3D2E324F;
        Tue, 18 Jun 2019 22:03:09 +0200 (CEST)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1560888189;
        bh=VwfiohaMFEB7fX9PcM2II556LkKDtWBb5VJtQjaKbz0=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=P0Ma0Wfg7PHRwjj4mJUKCzDvsoEaVV8fqhtn8qjg90OqieG1x+z7v1knWc0lNn08F
         OyXw464//DrBc4JmDrL3IHIdvOnYcrV3xnR/Fn2J0boRlSU0i76qAJSIp31q2cEG3S
         7hO42freUTUnCFm6HhgdtvOxwzrQG/gC2Bmc4t9E=
MIME-Version: 1.0
Date:   Tue, 18 Jun 2019 20:03:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs@lesimple.fr>
Message-ID: <0f78095e480ef658815d9e5c37f94ac4@lesimple.fr>
Subject: Re: Rebalancing raid1 after adding a device
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <958d79f1-ed9c-eca3-9d7a-03a846de8f2f@gmail.com>
References: <958d79f1-ed9c-eca3-9d7a-03a846de8f2f@gmail.com>
 <1e1f90ed-80ce-96dc-e3d8-1e406121833d@gmail.com>
 <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <3cf139f51a2bc9324797a13831f99507@lesimple.fr>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

June 18, 2019 9:42 PM, "Austin S. Hemmelgarn" <ahferroin7@gmail.com> wrot=
e:=0A=0A> On 2019-06-18 15:37, St=C3=A9phane Lesimple wrote:=0A> =0A>> Ju=
ne 18, 2019 9:06 PM, "Austin S. Hemmelgarn" <ahferroin7@gmail.com> wrote:=
=0A>> On 2019-06-18 14:26, St=C3=A9phane Lesimple wrote:=0A>>> [...]=0A>>=
 =0A>> I don't need to have a perfectly balanced FS, I just want all the =
space > to be allocatable.=0A>> I tried using the -ddevid option but it o=
nly instructs btrfs to work on > the block groups=0A>> allocated on said =
device, as it happens, it tends to > move data between the 4 preexisting =
devices=0A>> and doesn't fix my problem. > A full balance with -dlimit=3D=
100 did no better.=0A>> Is there a way to ask the block group allocator t=
o prefer writing to a > specific device during a=0A>> balance? Something =
like -ddestdevid=3DN? This > would just be a hint to the allocator and th=
e usual=0A>> constraints would > always apply (and prevail over the hint =
when needed).=0A>> Or is there any obvious solution I'm completely missin=
g?=0A>>> Based on what you've said, you may actually not have enough free=
 space that can be allocated to=0A>>> balance things properly.=0A>>> =0A>=
>> When a chunk gets balanced, you need to have enough space to create a =
new instance of that type of=0A>>> chunk before the old one is removed. A=
s such, if you can't allocate new chunks at all, you can't=0A>>> balance =
those chunks either.=0A>>> =0A>>> So, that brings up the question of how =
to deal with your situation.=0A>>> =0A>>> The first thing I would do is m=
ultiple compaction passes using the `usage` filter. Start with:=0A>>> =0A=
>>> btrfs balance -dusage=3D0 -musage=3D0 /wherever=0A>>> =0A>>> That wil=
l clear out any empty chunks which haven't been removed (there shouldn't =
be any if you're=0A>>> on a recent kernel, but it's good practice anyway)=
. After that, repeat the same command, but with a=0A>>> value of 10 inste=
ad of 0, and then keep repeating in increments of 10 up until 50. Doing t=
his will=0A>>> clean up chunks that are more than half empty (making mult=
iple passes like this is a bit more=0A>>> reliable, and in some cases als=
o more efficient), which should free up enough space for balance to=0A>>>=
 work with (as well as probably moving most of the block groups it touche=
s to use the new disk).=0A>> =0A>> Fair point, I do run some balances wit=
h -dusage=3D20 from time to time, the current state of the FS=0A>> is act=
ually as follows:=0A>> btrfs d u /tank | grep Unallocated:=0A>> Unallocat=
ed: 57.45GiB=0A>> Unallocated: 4.58TiB <=3D new 10T=0A>> Unallocated: 16.=
03GiB=0A>> Unallocated: 63.49GiB=0A>> Unallocated: 69.52GiB=0A>> As you c=
an see I was able to move some data to the new 10T drive in the last few =
days, mainly by=0A>> trial/error with several -ddevid and -dlimit paramet=
ers. As of now I still have 4.38T that are=0A>> unallocatable, out of the=
 4.58T that are unallocated on the new drive. I was looking for a better=
=0A>> solution that just running a full balance (with or without -devid=
=3Dold10T) by asking btrfs to=0A>> balance data to the new drive, but it =
seems there's no way to instruct btrfs to do that.=0A>> I think I'll stil=
l run a -dusage pass before doing the full balance indeed, can't hurt.=0A=
=0A> I would specifically make a point to go all the way up to `-dusage=
=3D50` on that pass though. It=0A> will, of course, take longer than a ru=
n with `-dusage=3D20` would, but it will also do a much better=0A> job.=
=0A=0A> That said, it looks like you should have more than enough space f=
or balance to be doing it's job=0A> correctly here, so I suspect you may =
have a lot of partially full chunks around and the balance is=0A> repacki=
ng into those instead of allocating new chunks.=0A=0A> Regardless though,=
 I suspect that just doing a balance pass with the devid filter and only=
=0A> balancing chunks that are on the old 10TB disk as Hugo suggested is =
probably going to get you the=0A> best results proportionate to the time =
it takes.=0A=0AAbout the chunks, that's entirely possible.=0AI'll run som=
e passes up to -dusage=3D50 before launching the balance then.=0A=0AThank=
s!=0A=0A-- =0ASt=C3=A9phane.

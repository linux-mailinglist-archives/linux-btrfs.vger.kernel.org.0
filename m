Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692864AB11
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfFRThd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 15:37:33 -0400
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:59124 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbfFRThd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 15:37:33 -0400
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id E45BACFA8;
        Tue, 18 Jun 2019 21:37:30 +0200 (CEST)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1560886650;
        bh=WF+rJJrK9Zwx1qYQ/yfuF9rqpE6YP3mJ4PvdxygHM7o=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=AJFyq7ni4AWFQcZIbXtxmA6B2ugoGACum7lornHnrPMnPHPrgUQdZ/sOuw//RRkXe
         Pqn/lwxNhsqXL5kns0P421E2PhIs0EVKpM0SqGYXCUqgVoCWNEczeMlAyniNzp7oA0
         VGu0Rb2/xp7XtAlT/accWlbRZZjIrJ0WrwU5RPfI=
MIME-Version: 1.0
Date:   Tue, 18 Jun 2019 19:37:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs@lesimple.fr>
Message-ID: <3cf139f51a2bc9324797a13831f99507@lesimple.fr>
Subject: Re: Rebalancing raid1 after adding a device
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <1e1f90ed-80ce-96dc-e3d8-1e406121833d@gmail.com>
References: <1e1f90ed-80ce-96dc-e3d8-1e406121833d@gmail.com>
 <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

June 18, 2019 9:06 PM, "Austin S. Hemmelgarn" <ahferroin7@gmail.com> wrot=
e:=0A=0A> On 2019-06-18 14:26, St=C3=A9phane Lesimple wrote:=0A>=0A> [...=
] =0A>=0A>> I don't need to have a perfectly balanced FS, I just want all=
 the space > to be allocatable.=0A>> I tried using the -ddevid option but=
 it only instructs btrfs to work on > the block groups=0A>> allocated on =
said device, as it happens, it tends to > move data between the 4 preexis=
ting devices=0A>> and doesn't fix my problem. > A full balance with -dlim=
it=3D100 did no better.=0A>> Is there a way to ask the block group alloca=
tor to prefer writing to a > specific device during a=0A>> balance? Somet=
hing like -ddestdevid=3DN? This > would just be a hint to the allocator a=
nd the usual=0A>> constraints would > always apply (and prevail over the =
hint when needed).=0A>> Or is there any obvious solution I'm completely m=
issing?=0A> =0A> Based on what you've said, you may actually not have eno=
ugh free space that can be allocated to=0A> balance things properly.=0A> =
=0A> When a chunk gets balanced, you need to have enough space to create =
a new instance of that type of=0A> chunk before the old one is removed. A=
s such, if you can't allocate new chunks at all, you can't=0A> balance th=
ose chunks either.=0A> =0A> So, that brings up the question of how to dea=
l with your situation.=0A> =0A> The first thing I would do is multiple co=
mpaction passes using the `usage` filter. Start with:=0A> =0A> btrfs bala=
nce -dusage=3D0 -musage=3D0 /wherever=0A> =0A> That will clear out any em=
pty chunks which haven't been removed (there shouldn't be any if you're=
=0A> on a recent kernel, but it's good practice anyway). After that, repe=
at the same command, but with a=0A> value of 10 instead of 0, and then ke=
ep repeating in increments of 10 up until 50. Doing this will=0A> clean u=
p chunks that are more than half empty (making multiple passes like this =
is a bit more=0A> reliable, and in some cases also more efficient), which=
 should free up enough space for balance to=0A> work with (as well as pro=
bably moving most of the block groups it touches to use the new disk).=0A=
=0AFair point, I do run some balances with -dusage=3D20 from time to time=
, the current state of the FS=0Ais actually as follows:=0A=0Abtrfs d u /t=
ank | grep Unallocated:=0A   Unallocated:            57.45GiB=0A   Unallo=
cated:             4.58TiB <=3D new 10T=0A   Unallocated:            16.0=
3GiB=0A   Unallocated:            63.49GiB=0A   Unallocated:            6=
9.52GiB=0A=0AAs you can see I was able to move some data to the new 10T d=
rive in the last few days, mainly by=0Atrial/error with several -ddevid a=
nd -dlimit parameters. As of now I still have 4.38T that are=0Aunallocata=
ble, out of the 4.58T that are unallocated on the new drive. I was lookin=
g for a better=0Asolution that just running a full balance (with or witho=
ut -devid=3Dold10T) by asking btrfs to=0Abalance data to the new drive, b=
ut it seems there's no way to instruct btrfs to do that.=0A=0AI think I'l=
l still run a -dusage pass before doing the full balance indeed, can't hu=
rt.=0A=0A-- =0ASt=C3=A9phane.

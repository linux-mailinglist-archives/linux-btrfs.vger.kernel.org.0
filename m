Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6902F68A93
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfGONbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 09:31:05 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:47454 "EHLO
        13.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbfGONbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 09:31:05 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 09:31:01 EDT
Received: from player696.ha.ovh.net (unknown [10.108.57.38])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id D987621E056
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 15:22:29 +0200 (CEST)
Received: from grubelek.pl (31-178-94-81.dynamic.chello.pl [31.178.94.81])
        (Authenticated sender: szarpaj@grubelek.pl)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 8545D805702E
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 13:22:29 +0000 (UTC)
Received: by teh mailsystemz
        id 743A91597D72; Mon, 15 Jul 2019 15:22:28 +0200 (CEST)
Date:   Mon, 15 Jul 2019 15:22:28 +0200
From:   Piotr Szymaniak <szarpaj@grubelek.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find subvolume directories
Message-ID: <20190715132228.GF4212@pontus.sran>
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
 <20190713082759.GB16856@tik.uni-stuttgart.de>
 <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
 <20190713112832.GA30696@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190713112832.GA30696@tik.uni-stuttgart.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Ovh-Tracer-Id: 9085167823910278807
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrheekgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 13, 2019 at 01:28:32PM +0200, Ulli Horlacher wrote:
> On Sat 2019-07-13 (14:10), Andrei Borzenkov wrote:
> 
> > >> It is entirely up to the user who creates it how subvolumes are named and
> > >> structured. You can well have /foo, /bar, /baz mounted as /, /var and
> > >> /home.
> > > 
> > > And how can I find them in my mounted filesystem?
> > > THIS is my problem.
> > 
> > I am not sure what problem you are trying to solve
> 
> I want a list of all subvolumes directories (which I can access with UNIX
> tools like cd and ls or btrfs subvolume ...).

Hi,

what about btrfs sub list [options]? (see man btrfs-subvolume)

You can make ie.:
root@ed:~# btrfs sub list -a / | head -10
ID 259 gen 142795 top level 5 path <FS_TREE>/@rut
ID 267 gen 1599 top level 259 path @rut/BUP/190417-1748_Image_SYSVOL
ID 268 gen 2516 top level 259 path @rut/BUP/190417-1750_Image_C
ID 326 gen 1599 top level 259 path @rut/BUP/190418-1009
ID 359 gen 1599 top level 259 path @rut/BUP/190418-1751
ID 361 gen 1599 top level 259 path @rut/BUP/190419-0812
ID 364 gen 1599 top level 259 path @rut/BUP/190423-1025
ID 369 gen 2086 top level 259 path @rut/BUP/190423-2232

But, I'm a bit like Andrei, and not sure what are you looking for. You
already asked about "mounted" and then about "list of all subvols"...
So you want to find mounted subvolumes or all subvolumes or all mounted
subvolumes or ...?


Best regards,
Piotr Szymaniak.
-- 
Najgoretsze miejsce w piekle szykowane jest nie tym, ktorzy zabijaja,
ale tym, ktorzy sie bezczynnie temu przygladaja.
  -- Dante Alighieri

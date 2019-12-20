Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D308D1281A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 18:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLTRuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 12:50:19 -0500
Received: from mail.nethype.de ([5.9.56.24]:42067 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfLTRuT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 12:50:19 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiMPp-003ema-QT; Fri, 20 Dec 2019 17:50:17 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiMPp-0004yn-Ky; Fri, 20 Dec 2019 17:50:17 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiMPp-0001jW-Kd; Fri, 20 Dec 2019 18:50:17 +0100
Date:   Fri, 20 Dec 2019 18:50:17 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220175017.GA6387@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
 <45b11982-0847-8e2c-b40f-0c22ed21de2b@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b11982-0847-8e2c-b40f-0c22ed21de2b@georgianit.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 12:24:05PM -0500, Remi Gauvin <remi@georgianit.com> wrote:
> You don't need hints, the problem is right here.

Yes, I already guessed that (see my other mail). I fortunately can add two
more devices. However:

> device left with unallocated space, so no new metadata space can be
> allocated until you fix that.

I think it really shouldn't be up to me to second guess btrfs's not very
helpful error messages "and fix things". And if I couldn't add another
device, I would be pretty much fucked - btrfs balance does not allow me
to move any chunks to the other device, I tried balancing 10 data chunks
and 10 metadata chunks - the data chunks balanced successfully but nothing
changed, and the metadata chunks instantly hit the ENOSPC problem.

Pushing "fix things" at users without giving them the ability to do so is
rather poor.

So is there a legit fix for this? The tools don't allow me to rebalance
the filesystem so there is more space on the drives and deleting data and
writing it again doesn't seem to help - btrfs still wants to write to the
nearly full disks. I could probably convert the metadata to single and
back, but as long as btrfs has no way orf moving data form one disk to
another, that's going to be tough. Maybe converting to single and resizing
would do the trick - seriously, though, btrfs shouldn't force users to
jump through such hoops.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

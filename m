Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9C42DAAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 15:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJNNoV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhJNNoV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 09:44:21 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDEAC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 06:42:16 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1mb0yG-0002g5-K5; Thu, 14 Oct 2021 14:40:32 +0100
Date:   Thu, 14 Oct 2021 14:40:32 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Subject: Re: some principal understanding problems (balance and free space)
Message-ID: <20211014134032.GB3478@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
References: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 02:57:58PM +0200, Lentes, Bernd wrote:
> Hi,
> 
> OMG. Why is BTRFS in some cases so complicated? I just expect that a FS does its job, nothing else.
> I read the wiki and Merlin's Blog, but the more i read the more i get confused.
> Please help me, i'd like to use BTRFS, especially because of the snapshot feature which i'm missing in the most others FS.
> And i like to understand what i do.
> 
> Let's take this:
> 
> root@pc65472:~# btrfs fi df /
> Data, single: total=361.00GiB, used=343.29GiB
> System, single: total=32.00MiB, used=80.00KiB
> Metadata, single: total=9.00GiB, used=7.10GiB
> root@pc65472:~#
> root@pc65472:~# btrfs fi show /
> Label: none  uuid: 3a623645-a5e1-438e-b0f3-f02520f1a2eb
>         Total devices 1 FS bytes used 350.39GiB
>         devid    1 size 420.00GiB used 372.03GiB path /dev/mapper/vg1-lv_root
> 
> What does "Data, single: total=361.00GiB, used=343.29GiB" mean ?

   Of the 361GiB currently allocated for use as data storage,
343.29GiB of actual file data is stored in it.

> Having 343GB pure data occupying 361GB ?
> From what i've read before my understanding was that 361GB are reversed for data allocation ("data will be stored there").
> And 343GB are really used for data, so 18Gb pure data can still be saved. Is that correct ?
> What if i save now 18GB, so the total and used value are equal ? Does BTRFS claim new space so that the total value is growing ?

   Yes. If you write another 20 GiB to the FS, the 361GiB in the fi df
output will go up, as will the 372.03 GiB in the fi show output.

> Or are the 18GB lost and unusable ?
> 
> I read that if Metadata is occupying more than 75% of the total value you need to react.

   Not really. If you have a fully allocated filesystem (even if it's
not full of data), then there's nowhere for new metadata chunks to be
allocated from. That's when you need to take action, by reducing the
data allocation. This is done by balancing (some of) the data.

> I did some "btrfs balance start / -dusage=5", increasing the value of dusage in steps of 5.
> I expected that i get more total space or less used space for Metadata. But it didn't.
> What happened is that the total value for Data shrinked a bit, from 363GB to 361GB.

   That's correct. Balance will compact the used data and free up any
allocation that is unused as a result.

> I did then some "btrfs balance start / -musage=5" increasing in steps of 5. I expected that "used" for Metadata decreased, but it didn't.
> Finally the value "total" for Metadata decreased (from 9GB to 8GB), which isn't completely contrary to what i've expected:

   Balance does the exact same thing to metadata -- it compacts it,
and frees up the unused allocation. However, don't balance metadata
(ever), as it exacerbates the usual out-of-space case (where metadata
is low and there's nowhere for it to expand into).

> root@pc65472:~# btrfs fi df /
> Data, single: total=361.00GiB, used=343.46GiB
> System, single: total=32.00MiB, used=80.00KiB
> Metadata, single: total=8.00GiB, used=7.10GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> That would mean that after my "btrfs balance ... musage= " there is now less space for Metadata than before. Why to balance then ?

   Don't balance metadata. :)

> OS is Ubuntu 16.04, kernel is 4.4.0-66-generic.

   This is very old, and I would strongly recommend updating to
something after about 5.5.

> What is with the most recent kernels ? Is there an automatic "btrfs balance" or do i still have to check my BTRFS regulary ?

   No, there's no automatic balance. Recent kernels will drop a chunk
if it's completely empty, but the chances of that happening without a
balance are pretty much zero.

   Hugo.

-- 
Hugo Mills             | The last man on Earth sat in a room. Suddenly, there
hugo@... carfax.org.uk | was a knock at the door.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                        Frederic Brown
